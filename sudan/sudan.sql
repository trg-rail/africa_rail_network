-- Sudan
-- and South Sudan

select railway, count(*) from africa_osm_nodes where country = 'Sudan' group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country = 'Sudan' group by railway order by count desc;

select status, count(*) from africa_osm_edges where country = 'Sudan' group by status order by count desc;

select type, count(*) from africa_osm_edges where country = 'Sudan' group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country = 'Sudan' and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country = 'Sudan' group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country = 'Sudan' group by gauge order by gauge desc;


select railway, count(*) from africa_osm_nodes where country = 'South Sudan' group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country = 'South Sudan' group by railway order by count desc;

select status, count(*) from africa_osm_edges where country = 'South Sudan' group by status order by count desc;

select type, count(*) from africa_osm_edges where country = 'South Sudan' group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country = 'South Sudan' and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country = 'South Sudan' group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country = 'South Sudan' group by gauge order by gauge desc;


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

-- Atbara station
select rn_copy_node(array[555082271], array[555096004]);

update africa_osm_nodes
set railway = 'station',
name = 'Atbara'
where oid = 556082271;
postgres
update africa_osm_nodes
set name_arabic = 'محطة أبو حمد',
name = 'Abu Hamad'
where oid = 555021191;

update africa_osm_nodes
set name = 'Khartoum'
where oid = 555057333;

update africa_osm_nodes
set name = 'Khartoum North'
where oid = 555010559;

update africa_osm_nodes
set name_arabic = 'بورتسودان',
name = 'Port Sudan'
where oid = 555012964;

update africa_osm_nodes
set name = 'Port of Sudan (Southern)',
facility = 'container_port',
railway = 'stop'
where oid = 555078047;

update africa_osm_nodes
set name = 'Port of Sudan (Northern)',
facility = 'port',
railway = 'stop'
where oid = 555123804;

update africa_osm_nodes
set name_arabic = 'الأبيض',
name = 'El Obeid'
where oid = 555023134;

update africa_osm_nodes
set name_arabic = 'بابنوسة',
name = 'Babanusa'
where oid = 555023101;

update africa_osm_nodes
set name_arabic = 'محطة نيالا القطارات',
name = 'Nyala'
where oid = 555028964;

update africa_osm_nodes
set name_arabic = 'الضعين',
name = 'El Daein'
where oid = 555060276;

update africa_osm_nodes
set name = 'Selihea'
where oid = 555019061;

update africa_osm_nodes
set name_arabic = 'كسلا',
name = 'Kassala'
where oid = 555062663;

update africa_osm_nodes
set name_arabic = 'وادي حلفا',
name = 'Wadi Halfa'
where oid = 555062839;

update africa_osm_nodes
set name_arabic = 'ود مدني',
name = 'Wad Madani'
where oid = 555062963;

update africa_osm_nodes
set name = 'Ar Rahad'
where oid = 555009712;

update africa_osm_nodes
set name = 'Haiya',
railway = 'station'
where oid = 555092216;

update africa_osm_nodes
set name = null,
railway = null
where oid in (555062452, 555010842, 555062996, 555019062, 555042360);

-- add Sennar station
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000011,
 'station',
 'Sennar',
 'Sudan',
 null,
 null,
 ST_SetSRID(ST_Point(33.56633,13.57366), 4326)
 )
;

select rn_copy_node(array[558000011], array[555063627]);

-- Khartoum - Atbara

-- split 555064449 at 555147097
select rn_split_edge(array[555064449], array[555147097]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555057333,
		556082271,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Khartoum - Atbara',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Atbara - Port Sudan
-- route out of Atbara
-- split 555036216 at 555082063
select rn_split_edge(array[555036216], array[555082063]);
-- split 

select rn_change_target(555036115, 555082086);
select rn_change_target(555036121, 555082086);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              556082271,
		555012964,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Atbara - Port Sudan',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Port of Sudan (Northern)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555012964,
		555123804,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Sudan (Northern)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Port of Sudan (Southern)

-- split 555093017 at 555078046
select rn_split_edge(array[555093017], array[555078046]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555012964,
		555078047,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Sudan (Southern)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Atbara - Abu Hamad

select rn_copy_node(array[555021191], array[555040243]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              556082271,
		556021191,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Atbara - Abu Hamad',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Abu Hamad - Wadi Halfa

select rn_copy_node(array[555062839], array[555027768]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              556021191,
		556062839,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Abu Hamad - Wadi Halfa',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Abu Hamad - Karima

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555091714,
		555021086,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Abu Hamad - Karima',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kassinger - El Ban

-- split 555040269 at 555091775
select rn_split_edge(array[555040269], array[555091775]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555091775,
		555021087,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kassinger - El Ban',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Assumed to be open'
where oid in (select edge from tmp);


-- Khartoum - Sennar

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555057333,
		559000011,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Khartoum - Sennar',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'All lines South of Khartoum are believed to be disused with possibility of future rehabilitation to be completed by 2024. See: https://bloom.bg/3Dat9CN'
where oid in (select edge from tmp);

-- Sennar - El Obeid

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              559000011,
		555023134,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sennar - El Obeid',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'All lines South of Khartoum are believed to be disused with possibility of future rehabilitation to be completed by 2024. See: https://bloom.bg/3Dat9CN'
where oid in (select edge from tmp);

-- Ar Rahad - Nyala

-- split 555044737 at 555088340
select rn_split_edge(array[555044737], array[555088340]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555088340,
		555028964,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ar Rahad - Nyala',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'All lines South of Khartoum are believed to be disused with possibility of future rehabilitation to be completed by 2024. See: https://bloom.bg/3Dat9CN'
where oid in (select edge from tmp);

-- Babanusa - Wau (South Sudan)

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555064569,
		555018692,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Babanusa - Wau (South Sudan)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'All lines South of Khartoum are believed to be disused with possibility of future rehabilitation to be completed by 2024. See: https://bloom.bg/3Dat9CN'
where oid in (select edge from tmp);

-- Haiya - Kassala

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555092216,
		555062663,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Haiya - Kassala',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Kassala - Sennar (not complete)

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555117024,
		555065002,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kassala - Sennar (not complete)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Gaps in this line. Therefore not routable.'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555003192,
		555101144,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kassala - Sennar (not complete)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Gaps in this line. Therefore not routable.'
where oid in (select edge from tmp);

-- freight lines

-- CNPPC Oil Refinery, El Obeid
update africa_osm_nodes
set railway = 'stop',
name = 'CNPPC Oil Refinery',
facility = 'manufacturing'
where oid = 555096033;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555023134,
		555096033,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'CNPPC Oil Refinery',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kenana Sugar Factory
update africa_osm_nodes
set railway = 'stop',
name = 'Kenana Sugar Factory',
facility = 'manufacturing'
where oid = 555088659;

select rn_split_edge(array[555118525], array[555088658]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555088658,
		555088659,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kenana Sugar Factory',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Khartoum North Thermal Power Plant
update africa_osm_nodes
set railway = 'stop',
name = 'Khartoum North Thermal Power Plant',
facility = 'utilities'
where oid = 555093398;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555025582,
		555093398,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Khartoum North Thermal Power Plant',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Assumed to be open'
where oid in (select edge from tmp);

-- fix station issues

-- Keheili Station
select rn_copy_node(array[555021083], array[555118703]);
-- El Kab Station
select rn_copy_node(array[555021082], array[555118704]);
-- Daghfeli Station
select rn_copy_node(array[555020951], array[555118706]);

update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country like '%Sudan%' and railway in ('station', 'halt', 'stop');

-- extract tables for Egypt (backup)
create table sudan_osm_edges as select * from africa_osm_edges where country like '%Sudan%';
create table sudan_osm_nodes as select * from africa_osm_nodes where country like '%Sudan%';

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555028964,
		555012964,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			
			
			





























