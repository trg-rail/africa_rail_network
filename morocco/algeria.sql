-- Morocco

select railway, count(*) from africa_osm_nodes where country like '%Algeria%' group by railway order by count desc;
select railway, count(*) from africa_osm_nodes where name is not null and country like '%Algeria%' group by railway order by count desc;

select status, count(*) from africa_osm_edges where country like '%Algeria%' group by status order by count desc;
select type, count(*) from africa_osm_edges where country like '%Algeria%' group by type order by count desc;
select line, status, count(*) from africa_osm_edges where country like '%Algeria%' and line is not null group by line, status order by count desc;
select structure, count(*) from africa_osm_edges where country like '%Algeria%' group by structure order by count desc;
select gauge, count(*) from africa_osm_edges where country like '%Algeria%' group by gauge order by gauge desc;


-- set additional node for stations
update africa_osm_nodes
set name = 'Centrale d''Oran محطة القطار وهران',
railway = 'station'
where oid = 555070202;

update africa_osm_nodes
set name = 'Oran Marine (port) وهران البحرية',
railway = 'station'
where oid = 555028159;

update africa_osm_nodes
set name = 'Arzew أرزيو',
railway = 'station'
where oid = 556037475;

update africa_osm_nodes
set name = 'Oued Tlelat وادي تليلات',
railway = 'station'
where oid = 556028940;


-- set names where missing
update africa_osm_nodes
set name = 'Skhour Rhamna',
railway = 'station'
where oid = ;

-- facilities

-- mines / industrial etc

-- OCP Phosphate mine, Benguerir
update africa_osm_nodes
set railway = 'stop',
name = 'OCP Benguerir (Phosphate Mine)',
facility = 'mine'
where oid = ;


-- create new station (or other) nodes
-- this is required as there can be several edges running through stations but the station node
-- is located on an edge that isn't used for the route.
-- create node on edge 555065285 for branch to Arzew
-- copy 555014903 onto edge 555065285
-- Arzew
-- Oued Tlelat
-- Bechar
-- Tabia

DO $$ DECLARE
-- create new station nodes
-- note: must not be a node coincident with the closest point (reassign that node as a station instead)
--nodes INT8 ARRAY DEFAULT ARRAY [555014903, 555037475, 555028940, 555024272, 555021009];
--edges INT8 ARRAY DEFAULT ARRAY [555065285, 555068139, 555096463, 555059088, 555050232];
nodes INT8 ARRAY DEFAULT ARRAY [555021009];
edges INT8 ARRAY DEFAULT ARRAY [555050232];
node INT8;
edge INT8;
idx INT;
closest_point GEOMETRY;
newline GEOMETRY;
orsource int8;
ortarget int8;
BEGIN
		for node, edge in select unnest(nodes), unnest(edges)
		LOOP

-- want a new station node on the nearest point on the required edge and split the edge for routing
-- find index of nearest segment to the point in the line. We want to insert a new point (vertex) into the line so we can split it at the station
-- use function ST_LineLocateN
SELECT ST_LineLocateN(e.geom, n.geom) from africa_osm_nodes n, africa_osm_edges e where n.oid = node and e.oid = edge
into idx;
-- closest point
select ST_ClosestPoint(e.geom, n.geom) from africa_osm_nodes n, africa_osm_edges e where n.oid = node and e.oid = edge into closest_point;
-- new line geometry with added point
select ST_AddPoint(e.geom, closest_point, idx) from africa_osm_edges e where e.oid = edge into newline;
-- original source and target
select target from africa_osm_edges where oid = edge into ortarget;
select source from africa_osm_edges where oid = edge into orsource;

raise notice 'counter: %', node || ' ' || edge || ' ' || idx || ' ' || orsource || ' ' || ortarget ;	

-- create new node for station
INSERT INTO africa_osm_nodes (name, geom, railway, country, oid)
SELECT name, closest_point, railway, country, oid + 1000000
FROM africa_osm_nodes
WHERE oid = node;
 
insert into africa_osm_edges 
with tmp as ( select a.*, ( st_dump ( st_split ( newline, closest_point ) ) ).geom as geom2 from africa_osm_edges a where oid = edge ),
	tmp2 as ( select geom2 as geom, country, length, ( oid :: text || row_number ( ) over ( ) ) :: int8 as oid, line, gauge, status, type, mode, structure, speed_freight, speed_passenger, comment, st_startpoint ( geom2 ), st_endpoint ( geom2 ) from tmp ) select
	a.geom,
	a.country,
	round(st_lengthspheroid(a.geom, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2 ) as length,
	b.oid as source,
	c.oid as target,
	a.oid,
	a.line,
	a.gauge,
	a.status,
	a.type,
	a.mode,
	a.structure,
	a.speed_freight,
	a.speed_passenger,
	a.comment
	from
		tmp2 a JOIN africa_osm_nodes b ON st_dwithin( b.geom, a.st_startpoint, .000000001 )
		-- need st_dwithin rather than st_intersects 
		JOIN africa_osm_nodes c ON st_dwithin ( c.geom, a.st_endpoint, .00000000001 )
		-- there can be additional nodes than the original target and source nodes at the original line end /start points
		-- so have to limit results 
		where b.oid in (ortarget, orsource) or c.oid in (ortarget,orsource)
	;
	
	-- delete the original edge
	delete 
	from
	africa_osm_edges 
	where
	oid = edge;
	
	-- delete original station node
	-- don't think will do that, will just select the station nodes that intersect the required routes.
	-- delete 
	-- from
	-- africa_osm_nodes 
	-- where
	-- oid = node;
	

END LOOP;
END $$;

-- psql code to fix routing issue. Splits edge at node.

-- route out of Algiers
-- split 555002336 @ 555064349
-- split 555056971 @ 555118638
-- route from Oed Tlelat on to Bechar line
-- split 555091243 @ 555108536
-- routing after Tabia
-- split 555067840 at 555092037

DO $$ DECLARE
-- edges INT8 ARRAY DEFAULT ARRAY [555002336, 555056971, 555091243, 555067840];
 -- nodes INT8 ARRAY DEFAULT ARRAY [555064349, 555118638, 555108536, 555092037];
edges INT8 ARRAY DEFAULT ARRAY [555067840];
nodes INT8 ARRAY DEFAULT ARRAY [555092037];
edge int8;
node int8;
BEGIN
		for edge, node in select unnest(edges), unnest(nodes)
		LOOP
		raise notice'counter: %', edge || ' ' || node;
	insert into africa_osm_edges with tmp as (select a.*, (st_dump(st_split(a.geom, b.geom))).geom as geom2 from africa_osm_edges a, africa_osm_nodes b where a.oid = edge and b.oid = node),
	tmp2 as (select geom2 as geom, country, length, ( oid :: text || row_number ( ) over ( ) ) :: int8 as oid, line, gauge, status, type, mode, structure, speed_freight, speed_passenger, comment, st_startpoint ( geom2 ), st_endpoint ( geom2 ) from tmp ) select 
	a.geom,
	a.country,
	round(st_lengthspheroid(a.geom, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2 ) as length,
	b.oid as source,
	c.oid as target,
	a.oid,
	a.line,
	a.gauge,
	a.status,
	a.type,
	a.mode,
	a.structure,
	a.speed_freight,
	a.speed_passenger,
	a.comment 
	from
		tmp2
		a JOIN africa_osm_nodes b ON st_intersects ( b.geom, a.st_startpoint )
		JOIN africa_osm_nodes c ON st_intersects ( c.geom, a.st_endpoint );
	delete 
	from
		africa_osm_edges 
	where
		oid = edge;
END LOOP;
END $$;


-- update line information

-- Alger/Algiers to Oran
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555003515,
		555070202,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Algiers to Oran',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);

-- add link between 555070203 and 555078101 
-- simplify routing to Oran port
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555070203 and b.oid = 555078101
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555070203,
555078101,
556000007
from tmp as a;

-- Oran to Oran Maritime (port)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555070203,
		555028159,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oran to Oran Maritime (port)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);

-- Oran to Arzew branch

-- Need to edit edge 555071266 and amend the first coordinate (source) to be
-- node 556014903 rather than 555014903 to simplify routing to Oran.

UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, 0, (select geom from africa_osm_nodes where oid = 556014903)),
	source = 556014903
	WHERE oid = 555071266;
	
-- Oran to Arzew
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                556014903,
		556037475,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oran to Arzew',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Oued Tlelat to Béchar
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                556028940,
		556024272,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oued Tlelat to Béchar',
gauge = '1435',
status = 'open',
comment = 'Not electrified.',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Moulay Slissen to Saïda
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555080824,
		555033671,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Moulay Slissen to Saïda',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- add link between 555092074 and 556021009
-- simplify routing from Tabia to Akid Abbess line
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555092074 and b.oid = 556021009
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555092074,
556021009,
556000008
from tmp as a;

-- Tabia to Akid Abbes (Zouj Beghal)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                556021009,
		555025504,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tabia to Akid Abbes (Zouj Beghal)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Akid Abbes (Zouj Beghal) to Ghazaouet
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555025504,
		555021070,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Akid Abbes (Zouj Beghal) to Ghazaouet',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

update africa_osm_nodes
set gauge = '1435'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435'))
and railway in ('station', 'halt', 'stop');

-- extract tables for algeria (backup)
create table algeria_osm_edges as select * from africa_osm_edges where country like '%Algeria%';
create table algeria_osm_nodes as select * from africa_osm_nodes where country like '%Algeria%';
