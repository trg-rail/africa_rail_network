-- assign country to nodes

create table africa_osm_nodes_new as
select a.*, b.name as country from
africa_osm_nodes a
left join africa_osm_countries b
on st_intersects(a.geom, b.geom);

-- drop old nodes table
drop table africa_osm_nodes cascade;

-- rename new table
alter table africa_osm_nodes_new rename to africa_osm_nodes;

-- create geom index
create index africa_osm_nodes_geom_idx
on africa_osm_nodes
using gist (geom);

select count(*) from africa_osm_nodes; --154953

-- find null country
select * from africa_osm_nodes where country is null; --4/0

-- update null country column
update africa_osm_nodes
set country =
case when id = 'rail_africa_128466' then 'Namibia'
-- proposed tunnel/bridge to spain
when id = 'rail_africa_143576' then 'Spain'
when id = 'rail_africa_148693' then 'Tanzania'
when id = 'rail_africa_74726' then 'Eritrea'
end
where id in ('rail_africa_128466', 'rail_africa_143576', 'rail_africa_148693', 'rail_africa_74726');

-- find duplicates from the intersect query with africa_osm_countries

select id, count(*)
from africa_osm_nodes
group by id
HAVING count(*) > 1;

-- two nodes are exactly on border between two countries, so intersect has created two records for each. Delete one.
delete from africa_osm_nodes where id = 'rail_africa_12622' and country != 'Algeria';
delete from africa_osm_nodes where id = 'rail_africa_81222' and country != 'Botswana';

-- assign country to edges

-- set srid
-- SELECT UpdateGeometrySRID('africa_osm_edges','geom',4326);

-- need a unique id to use with the intersect query so we can remove duplicates later
CREATE SEQUENCE africa_osm_edges_vid_seq CYCLE;
ALTER SEQUENCE africa_osm_edges_vid_seq RESTART WITH 1;

create table africa_osm_edges_new as
select nextval('africa_osm_edges_vid_seq'::regclass) AS vid, a.*, b.name as country from
africa_osm_edges a
left join africa_osm_countries b
on st_intersects(a.geom, b.geom);

select count(*) from africa_osm_edges; -- 135473
select count(*) from africa_osm_edges_new; -- 135512

-- delete old edges table 
drop table africa_osm_edges cascade;
-- rename new table
alter table africa_osm_edges_new rename to africa_osm_edges;
-- keep copy of prepared edges table in case need to repeat steps that follow
create table africa_osm_edges_backup as select * from africa_osm_edges;
-- create table africa_osm_edges as select * from africa_osm_edges_backup

-- create geom index
create index africa_osm_edges_geom_idx
on africa_osm_edges
using gist (geom);

-- find null country column if any
--select * from africa_osm_edges where country is null; --zero

-- number of duplicates as a result of the intersect - this is edges that cross country boundaries
--select id, count(*)
--from africa_osm_edges
--group by id
--HAVING count(*) > 1; --39

-- need to remove any duplicates keeping just the row with the country with greatest length of the edge
-- first CTE calculate length of the intersection within the country
WITH tmp as
(
SELECT a.vid, a.id, a.country, ST_Length(ST_Intersection(a.geom::geography, b.geom::geography)) as length_within_country
FROM africa_osm_edges as a
LEFT JOIN africa_osm_countries as b ON a.country = b.name
where a.id in 
(
select id
from africa_osm_edges
group by id
HAVING count(*) > 1
)
order by a.id
), tmp2 as
(
-- select vids where rank is other than 1 (i.e. not the greatest in-country length)
select vid from (
-- rank by length_within_country desc -rank one is where in-country length is greatest
SELECT vid, rank() OVER (PARTITION BY id order by length_within_country DESC) as rank FROM tmp
) as ranking
where rank != 1
)
delete from africa_osm_edges where vid in (select vid from tmp2);

--select count(*) from africa_osm_edges; -- 135473

-- pgRouting requires the source and target nodes to be integer ids.
-- Need to amend node and edge ids to integer

-- add souce and target columns
ALTER TABLE africa_osm_edges
		ADD COLUMN length float4,
    ADD COLUMN source integer, 
		ADD COLUMN target integer,
		ADD COLUMN oid int8,
		ADD COLUMN line text,
		ADD COLUMN gauge text,
		ADD COLUMN status text, -- open, abandoned, disused, rehabilitation, construction, proposed etc
		ADD COLUMN type text, -- heavy (if rail or narrow_gauge), tram, light_rail, preserved, subway, monorail, miniature, funicular
		ADD COLUMN mode text, -- passenger, freight or mixed.
		ADD COLUMN structure text, -- bridges etc
		ADD COLUMN speed_freight integer,
		ADD COLUMN speed_passenger integer,
		ADD COLUMN comment text;
		
-- calculate edge lengths - measure spheroid length as no projection appropriate for entire continent
UPDATE africa_osm_edges set length = round(st_lengthspheroid(geom, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2);

-- assume mixed mode unless amended
UPDATE africa_osm_edges set mode = 'mixed';
		
-- copy integer ids component
-- africa ids start 555000000
UPDATE africa_osm_edges set source = 555000000 + reverse(split_part(reverse(from_id), '_', 1))::int4;
UPDATE africa_osm_edges set target = 555000000 + reverse(split_part(reverse(to_id), '_', 1))::int4;
UPDATE africa_osm_edges set oid = 555000000 + reverse(split_part(reverse(id), '_', 1))::int4;

-- make primary key
ALTER TABLE africa_osm_edges ADD PRIMARY KEY (oid);

-- add oid column to nodes
ALTER TABLE africa_osm_nodes ADD COLUMN oid int8;
UPDATE africa_osm_nodes set oid = 555000000 + reverse(split_part(reverse(id), '_', 1))::int4;

-- make primary key
ALTER TABLE africa_osm_nodes ADD PRIMARY KEY (oid);

alter table africa_osm_nodes
add COLUMN gauge text,
add COLUMN facility text; -- dry_port, gauge_interchange etc

-- Update status - copy over from railway key as appropriate; otherwise assume open

UPDATE africa_osm_edges
 SET status =
 CASE WHEN railway in ('disused', 'abandoned', 'construction', 'razed', 'proposed', 'dismantled', 'historical_planned', 'path', 'planned') THEN railway
 else 'open'
 end;
 
 -- Update type
 UPDATE africa_osm_edges
 SET type =
 CASE
 WHEN railway = 'rail' THEN 'conventional'
 WHEN railway = 'narrow_gauge' THEN 'conventional'
 WHEN railway in ('tram', 'light_rail', 'preserved', 'subway', 'monorail', 'miniature', 'funicular') THEN railway
 else 'other'
 end;
 
 -- Update structure
 update africa_osm_edges
 set structure = 
 CASE
 WHEN bridge = 'yes' then 'bridge'
 WHEN bridge = 'cantilever' then 'bridge'
 WHEN bridge = 'movable' then 'movable bridge'
 WHEN bridge = 'viaduct' then 'viaduct'
 WHEN bridge = 'aqueduct' then 'viaduct' -- presume incorrect term used
 WHEN railway in ('level_crossing', 'railway_crossing', 'platform', 'station', 'turntable', 'loading_ramp', 'traverser', 'crane_rail') THEN railway
 end;

-- remove unused columns from edges
alter table africa_osm_edges
drop column vid,
drop column id,
drop column fid,
drop column osm_id,
drop column bridge,
drop column railway,
drop column name,
drop column is_current,
drop column from_id,
drop column to_id;

-- remove unused columns from nodes
alter table africa_osm_nodes
drop column id,
drop column fid,
drop column osm_id,
drop column is_current;
