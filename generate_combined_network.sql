-- merge east africa with rest of africa.

-- highest oid in africa_osm_edges
select max(oid) from africa_osm_edges;
-- 555116014112
select max(oid) from africa_osm_nodes;
-- 559000104

-- create copies of hvt table
create TABLE hvt_edges as
select * from hvt_rail_network;

create TABLE hvt_nodes as
select * from hvt_rail_nodes;

-- highest oid in hvt
select max(oid) from hvt_edges;
-- 44411212
select max(oid) from hvt_nodes;
-- 4450051

alter table hvt_edges
alter column oid set data type int8,
alter column source set data type int8,
alter column target set data type int8;

alter table hvt_nodes
alter column oid set data type int8;

alter table hvt_nodes
add column comment varchar,
add column name_arabic varchar,
add column status text;

select distinct type from africa_osm_edges where line is not null;

-- re-code oids for edges and nodes for hvt tables so will be unique when combined with afrn tables.
UPDATE hvt_edges set oid = oid + 666600000000;
UPDATE hvt_edges set source = source + 660000000;
UPDATE hvt_edges set target = target + 660000000;
UPDATE hvt_nodes set oid = oid + 660000000;

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.type, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM hvt_edges where line is not null',
               661110579,
		663330214,
		false
		) AS X left join
		hvt_edges as a on a.oid = X.edge left join
		hvt_nodes as b on b.oid = X.node
		ORDER BY seq;

-- HVT generated combined routable rail network for Kenya, Tanzania, Zambia, and Uganda

create table africa_rail_network as
(
select oid, country, source, target, length, line, status, type, gauge, mode, structure, speed_freight, speed_passenger, 99999::float4 as time_freight, comment, geom
from africa_osm_edges where line is not null
UNION
select oid, country, source, target, length, line, status, 'conventional'::text as type, gauge, mode, structure, speed_freight, speed_passenger, time_freight, comment, geom
from hvt_edges
);

ALTER TABLE africa_rail_network ADD PRIMARY KEY (oid);

-- nodes table is just stations/stops/halts coincident with edges in respective networks
create table africa_rail_nodes as
(
select distinct a.oid, a.country, a.railway as type, a.name, a.name_arabic, a.facility, a.gauge, a.status, a.comment, a.geom from africa_osm_nodes a
JOIN africa_osm_edges b ON st_intersects(a.geom, b.geom)
where a.railway in ('station', 'halt', 'stop') and b.line is not null
UNION
select distinct a.oid, a.country, a.type, a.name, a.name_arabic, a.facility, a.gauge, a.status, a.comment, a.geom from hvt_nodes a
order by country, name asc
);

ALTER TABLE africa_rail_nodes ADD PRIMARY KEY (oid);


-- make connections between hvt network and rest of network (essentialy just links to Zambia)

-- DRC <-> Zambia (Sakania)
-- change target of edge 666603330654 to 555077255

update africa_rail_network
set source = 555077255
where oid = 666603330654;

-- Zambia <-> Malawi
-- change source of edge 666603330544 to 555012146
update africa_rail_network
set source = 555012146
where oid = 666603330544;

-- Zambia <-> Zimbabwe
-- remove uneeded edge
delete from africa_rail_network where oid = 666603330028;
-- change target of edge 666603330031 to 555064788
update africa_rail_network
set target = 555064788
where oid = 666603330031;


-- rationalise facility definitions
select distinct facility from africa_rail_nodes order by facility;

update africa_rail_nodes
set facility = 'industrial area'
where facility in ('Business area','Business Area','Industrial area','Industrial Area','Industrial zone');

update africa_rail_nodes
set facility = 'dry port'
where facility in ('Dry Port', 'dry_port');

update africa_rail_nodes
set facility = 'manufacturing'
where facility in ('Cement plant', 'chemical_plant', 'Cement plant', 'Copper Smelter','manufacturer','manfacturing');

update africa_rail_nodes
set facility = 'container terminal'
where facility in ('Container Terminal','container_port');

update africa_rail_nodes
set facility = 'food production'
where facility in ('food','food manufacturing','food manufacture','Food manufacturing');

update africa_rail_nodes
set facility = 'food storage'
where facility in ('Food storage');

update africa_rail_nodes
set facility = 'fuel storage'
where facility in ('fuel depot','Fuel depot','fuel storage','fuel storage depot','fuel storage terminal','fuel terminal','Fuel terminal','Oil storage depot');

update africa_rail_nodes
set facility = 'freight terminal'
where facility in ('Freight Terminal','Rail Freight Terminal');

update africa_rail_nodes
set facility = 'refinery'
where facility in ('fuel refinery','oil refinery', 'Oil refinery');

update africa_rail_nodes
set facility = 'power station'
where facility in ('Power Station');

update africa_rail_nodes
set facility = 'agriculture'
where facility in ('Agriculture');

update africa_rail_nodes
set facility = 'mining'
where facility in ('mine', 'Mine');

update africa_rail_nodes
set facility = 'port'
where facility in ('Port');

update africa_rail_nodes
set facility = 'quarry'
where facility in ('Quarry');

update africa_rail_nodes
set facility = 'port (river)'
where facility in ('River Port');

update africa_rail_nodes
set facility = 'military'
where facility in ('Military');

update africa_rail_nodes
set facility = 'terminal'
where facility in ('cargo_terminal');

update africa_rail_nodes
set facility = 'coal terminal'
where facility in ('Coal Terminal (port)');

update africa_rail_nodes
set facility = 'commodity auctions'
where facility in ('Commodity auctions');

update africa_rail_nodes
set facility = 'port (dry)'
where facility in ('dry port');

update africa_rail_nodes
set facility = 'marshalling yard'
where facility in ('Marshalling Yard');


-- rationalise status
select distinct status from africa_rail_network;

-- fix null status

update africa_rail_network
set status = 'open',
type = 'conventional',
mode = 'mixed'
where oid in (556000000,556000002,556000004);

update africa_rail_network
set status = 'unknown'
where status in ('unclear');

-- re-calculate edge lengths - measure spheroid length as no projection appropriate for entire continent
UPDATE africa_rail_network set length = round(st_lengthspheroid(geom, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2);


-- change country names to standard capitalised format
select distinct country from africa_rail_network;

update africa_rail_network
set country = 'Kenya' where country = 'kenya';

update africa_rail_network
set country = 'Zambia' where country = 'zambia';

update africa_rail_network
set country = 'Uganda' where country = 'uganda';

update africa_rail_network
set country = 'Tanzania' where country = 'tanzania';

select distinct country from africa_rail_nodes;

update africa_rail_nodes
set country = 'Kenya' where country = 'kenya';

update africa_rail_nodes
set country = 'Zambia' where country = 'zambia';

update africa_rail_nodes
set country = 'Uganda' where country = 'uganda';

update africa_rail_nodes
set country = 'Tanzania' where country = 'tanzania';


-- stats
select status, round(sum(length/1000)::numeric, 0) as length from africa_rail_network group by status order by length desc


select country, round(sum(length/1000)::numeric, 0) as length from africa_rail_network group by country order by length desc

select count(*) from africa_rail_nodes where facility is not null;
select facility, count(*) from africa_rail_nodes group by facility order by count desc;
select count(*) from africa_rail_nodes;
-- test routing

		SELECT X.*, a.line, a.status, a.gauge, a.country, b.type, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_rail_network',
               555000263,
		663331109,
		false
		) AS X left join
		africa_rail_network as a on a.oid = X.edge left join
		africa_rail_nodes as b on b.oid = X.node
		ORDER BY seq;
			