-- Eswatini

select railway, count(*) from africa_osm_nodes where country in ('Eswatini') group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country in ('Eswatini') group by railway order by count desc;

select status, count(*) from africa_osm_edges where country in ('Eswatini') group by status order by count desc;

select type, count(*) from africa_osm_edges where country in ('Eswatini') group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country in ('Eswatini') and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country in ('Eswatini') group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country in ('Eswatini') group by gauge order by gauge desc;


-- trap running entire script
update rubbish set rubish

-- features
-- tunnel
update africa_osm_edges
set structure = 'tunnel'
where oid = ;

-- incorrect nodes
update africa_osm_nodes
set railway = null,
name = null
where oid in ();

-- set additional node for stations or update details
update africa_osm_nodes
set name = '',
railway = 'station'
where oid = ;

-- ports
update africa_osm_nodes
set railway = 'stop',
name = '', 
facility = 'port'
where oid = ;

-- insert node to enable link to be inserted
-- will then be inserted onto correct edge below

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 ,
 '',
 '',
 '',
 null,
 null,
 ST_SetSRID(ST_Point(), 4326)
 )
;

select rn_copy_node(array[], array[]);


-- Goba Line – Matsapha – Mlawula – [Maputo]

-- split 555016856 at 555076347
select rn_split_edge(array[555016856], array[555076347]);

update africa_osm_nodes
set name = 'Matsapha'
where oid = 555011601;

update africa_osm_nodes
set railway = null,
name = null
where oid = 555023803;

update africa_osm_nodes
set railway = 'station',
name = 'Mpaka'
where oid = 555007757;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555011601,
		555007760,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Goba line (Matsapha - Mlawula)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555007760,
		555078710,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Goba line (Mlawula - Mozambique border)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Komatipoort Line – Komatipoort [SA] – Mpaka

-- South Africa Border
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000092,
 null,
 null,
 'Eswatini',
 null,
 null,
 ST_SetSRID(ST_Point(31.79322,-25.95332), 4326)
 )
;

select rn_copy_node(array[558000092], array[555026062]);
-- 559000092

update africa_osm_edges
set country = 'Eswatini'
where oid = 5550260622;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555068248,
		559000092,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Komatipoort line (Mpaka - SA border)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Richards Bay Line – Richards Bay (SA) – Siphofaneni/Phuzumoya

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555070389,
		555081227,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Richards Bay Line (Phuzumoya - SA border)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Freight spurs

-- Eswatini Sugar Association warehouse
update africa_osm_nodes
set name = 'Eswatini Sugar Association (warehouse)',
railway = 'stop',
facility = 'food storage',
comment = 'ESA have a warehouse and siding at Mlawula and export the raw sugar to overseas markets via Maputo port.'
where oid = 555078712;

-- split 555029665 at 555078703
select rn_split_edge(array[555029665], array[555078703]);
-- split 555029655 at 555078711
select rn_split_edge(array[555029655], array[555078711]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555078703,
		555078712,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Eswatini Sugar Association (warehouse)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Maloma Colliery siding
-- note: collliery is about 28km by road from this siding
-- see: https://maloma.co.sz/markets/
update africa_osm_nodes
set name = 'Maloma Colliery siding',
railway = 'stop',
facility = 'road-rail transfer',
comment = 'This siding serves Maloma Colliery which is about 28km west. Transfer of coal from road to rail. See: https://maloma.co.sz/markets/'
where oid = 555150285;

-- split 555020224 at 555150286
select rn_split_edge(array[555020224], array[555150286]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555150286,
		555150285,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Maloma Colliery siding',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Afrisam Eswatini 
-- cement works
-- 555130506

update africa_osm_nodes
set name = 'Cement works (Afrisam Eswatini)',
railway = 'stop',
facility = 'manufacturing'
where oid = 555130506;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555043266,
		555130506,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cement works (Afrisam Eswatini)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Phuzumoya fuel storage facility
-- not completed/started
-- but railway spur appears to be in place.
update africa_osm_nodes
set name = 'Phuzumoya fuel storage facility (proposed)',
facility = 'fuel storage',
railway = 'stop',
comment = 'Project staled in 2017 but road and railway spur appears to be in place. See: http://bit.ly/3J28mno'
where oid = 555116322;

-- split 555019685 at 555116328
select rn_split_edge(array[555019685], array[555116328]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555116328,
		555116322,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Phuzumoya fuel storage facility',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Project staled in 2017 but road and railway spur appears to be in place. See: http://bit.ly/3J28mno'
where oid in (select edge from tmp);

-- spur at Mpaka Langa National Bricks
-- https://www.facebook.com/langabrick/

update africa_osm_nodes
set name = 'Langa Bricks',
railway = 'stop',
facility = 'manufacturing',
comment = 'Brick manufacture. See: https://www.facebook.com/langabrick/'
where oid = 555097462;

-- split 555072014 at 555097461
select rn_split_edge(array[555072014], array[555097461]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555097461,
		555097462,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Langa Bricks',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Ngwane Mills 

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000093,
 null,
 null,
 'Eswatini',
 null,
 null,
 ST_SetSRID(ST_Point(31.29264,-26.51178), 4326)
 )
;

select rn_copy_node(array[558000093], array[555016860]);
-- 559000093

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000094,
 null,
 null,
 'Eswatini',
 null,
 null,
 ST_SetSRID(ST_Point(31.29326,-26.51107), 4326)
 )
;

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000095,
 'stop',
 'Ngwane Mills',
 'Eswatini',
 null,
 'food manufacturing',
 ST_SetSRID(ST_Point(31.29510,-26.50965), 4326)
 )
;

select rn_insert_edge(559000093, 558000094, 556000082);
select rn_insert_edge(558000094, 558000095, 556000083);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            559000093,
		558000095,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ngwane Mills',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Dry port (Container terminal inland) at Matsapha. Matsapha Inland Clearance Depot (ICD). See: https://eswatinirail.co.sz/services/containerised-cargo/

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000096,
 null,
 null,
 'Eswatini',
 null,
 null,
 ST_SetSRID(ST_Point(31.30921,-26.49581), 4326)
 )
;

select rn_copy_node(array[558000096], array[555026109]);
-- 559000096

update africa_osm_nodes
set name = 'Matsapha Inland Clearance Depot (ICD)',
facility = 'dry port',
railway = 'stop',
comment = 'Dry port (Container terminal). See: https://bit.ly/3J348fl'
where oid = 559000096;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555011601,
		559000096,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Matsapha Inland Clearance Depot (ICD)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('Eswatini') and railway in ('station', 'halt', 'stop');

-- extract tables (backup)
create table eswatini_osm_edges as select * from africa_osm_edges where country in ('Eswatini');
create table eswatini_osm_nodes as select * from africa_osm_nodes where country in ('Eswatini');

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555069940,
		555033205,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			
			
			





























