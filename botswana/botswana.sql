-- Botswana

select railway, count(*) from africa_osm_nodes where country in ('Botswana') group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country in ('Botswana') group by railway order by count desc;

select status, count(*) from africa_osm_edges where country in ('Botswana') group by status order by count desc;

select type, count(*) from africa_osm_edges where country in ('Botswana') group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country in ('Botswana') and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country in ('Botswana') group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country in ('Botswana') group by gauge order by gauge desc;


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

-- add station
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


-- add station for Palapye
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000017,
 'station',
 'Palapye',
 'Botswana',
 null,
 'station',
 ST_SetSRID(ST_Point(27.12725,-22.55827), 4326)
 )
;

select rn_copy_node(array[558000017], array[555062959]);

-- set name for Lobatse station
update africa_osm_nodes
set name = 'Lobatse'
where oid = 555063119;

-- passenger services (currently suspended)
-- between Lobatse and Francistown
-- BR Express

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555063119,
		555009365,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Lobatse -- Francistown',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'All passenger services (BR Express) are currently suspended. Initially due to COVID19'
where oid in (select edge from tmp);

-- Francistown (Botswana) - Zimbabwe border

-- insert node at border

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000018,
 NULL,
 NULL,
 'Botswana',
 null,
 null,
 ST_SetSRID(ST_Point(27.72270,-20.51306), 4326)
 )
;

select rn_copy_node(array[558000018], array[555017932]);

update africa_osm_edges
set country = 'Zimbabwe'
where oid = 5550179322;


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009365,
		559000018,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Francistown (Botswana) - Zimbabwe border',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'All passenger services are currently suspended. Service between Francistown and Bulawayo in Zimbabwe started in 2017. Stopped due to COVID19 and not restarted'
where oid in (select edge from tmp);

-- Lobatse to SA Border
-- Freight only

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555063119,
		555081222,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Lobatse - SA Border',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Freight only. Not thought to be any passenger services across SA border'
where oid in (select edge from tmp);

-- Tshele Hills fuel storage facility
-- Rail spur completed, facility expected to be completed in 2023

update africa_osm_nodes
set name = 'Tshele Hills fuel storage facility',
railway = 'stop',
facility = 'fuel storage depot',
comment = 'Currently under construction, expected to be completed 2023. Railway spur is completed. See: http://bit.ly/3HkWSJY'
where oid = 555046348;

-- split 555050238 at 555133111
-- split 555050237 at 555133106
select rn_split_edge(array[555050238, 555050237], array[555133111, 555133106]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555133106,
		555046348,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tshele Hills fuel storage facility spur',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Spur completed. See: http://bit.ly/3HkWSJY'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555133111,
		555133112,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tshele Hills fuel storage facility spur',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Spur completed. See: http://bit.ly/3HkWSJY'
where oid in (select edge from tmp);

-- Steel fabrication facility (Gear Mining)

update africa_osm_nodes
set name = 'Steel fabrication facility (Gear Mining)',
facility = 'manufacturing',
railway = 'stop',
comment = 'https://www.steelservices.co.za/gearmining.html'
where oid = 555090711;

-- split 555052925 at 555090712
select rn_split_edge(array[555052925], array[555090712]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555090712,
		555090711,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gear Mining',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Gaborone Container Terminal (Dry Port)

update africa_osm_nodes
set name = 'Gaborone Container Terminal',
facility = 'Dry Port',
railway = 'stop',
comment = 'https://www.gabcon.co.bw/about-us/'
where oid = 555010163;

-- simplify routing from Goborone station
select rn_insert_edge(555093396, 555010166, 556000069);

-- split 555092876 at 555093396
select rn_split_edge(array[555092876], array[555093396]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555093396,
		555010163,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gaborone Container Terminal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Morupule Colliery

update africa_osm_nodes
set name = 'Morupule Colliery',
facility = 'Mine',
railway = 'stop',
comment = 'Coal mine'
where oid = 555081317;

-- Morupule B Power Plant
update africa_osm_nodes
set name = 'Morupule B Power Plant',
facility = 'Power Station',
railway = 'stop',
comment = ''
where oid = 555023551;

-- split 555049744 at 555096934
select rn_split_edge(array[555049744], array[555096934]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009347,
		555081317,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Morupule Colliery Branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555041210,
		555015112,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Morupule Colliery Branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555096934,
		555023551,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Morupule B Power Plant',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Selebi-Phikwe branch

-- Selebi mine - nickel copper-cobalt
update africa_osm_nodes
set railway = 'stop',
name = 'Selebi Mine',
facility = 'Mine',
comment = 'nickel copper-cobalt. See: http://bit.ly/3wFWWz1 and https://www.mindat.org/loc-21623.html'
where oid = 555081703;

-- Selebi North Mine
-- Originally copper-nickel mine, believed to be a quarry now 
-- https://www.mindat.org/loc-21624.html

update africa_osm_nodes
set railway = 'stop',
name = 'Selebi North Mine',
facility = 'mine',
comment =  'Copper-nickel mine, believed to also be location of a quarry now, see http://bit.ly/3wFWWz1 and https://www.mindat.org/loc-21624.html and https://www.facebook.com/TlouCrusher'
where oid = 555081701;

update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('Botswana') and railway in ('station', 'halt', 'stop');

-- Phikwe Mine
-- copper-nickel
-- https://www.mindat.org/loc-18379.html
-- opencast
-- believed unused (see: https://en.wikipedia.org/wiki/Selebi-Phikwe)

update africa_osm_nodes
set railway = 'stop',
name = 'Phikwe Mine',
facility = 'mine',
comment =  'Copper-nickel mine (opencast) opencast and believed unused (see: https://en.wikipedia.org/wiki/Selebi-Phikwe)'
where oid = 555081693;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009375,
		555015101,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Serole - Selebi-Phikwe branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Selebi Mine branch
-- split 555035590 at 555081712
select rn_split_edge(array[555035590], array[555081712]) ;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555015101,
		555081703,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Selebi Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Selebi North Mine

-- split 555035602 at 555081702
select rn_split_edge(array[555035602], array[555081702]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555081702,
		555081701,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Selebi North Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Phikwe Mine

-- split 555035610 at 555081692
select rn_split_edge(array[555035610], array[555081692]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555081692,
		555081693,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Phikwe Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Mine is believed to be disused. Status of spar unclear'
where oid in (select edge from tmp);

-- Francistown – Sowa (Soda Ash and salt)
-- https://botash.bw/about-botash/
-- salt mine

update africa_osm_nodes
set name = 'Botswana Ash Salt Mine',
railway = 'stop',
facility = 'mine',
comment = 'salt mine producing soda ash and salt. See: https://botash.bw/about-botash/'
where oid = 555146813;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009380,
		555146813,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Francistown – Sowa branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Mine is believed to be disused. Status of spar unclear'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009584,
		555009583,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Francistown – Sowa branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Mine is believed to be disused. Status of spar unclear'
where oid in (select edge from tmp);

-- update stations
update africa_osm_nodes
set railway = 'station',
name = 'Serule'
where oid = 555073338;

select rn_copy_node(array[555009216], array[5550928762]);

update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('Botswana') and railway in ('station', 'halt', 'stop');


-- extract tables (backup)
create table botswana_osm_edges as select * from africa_osm_edges where country in ('Botswana');
create table botswana_osm_nodes as select * from africa_osm_nodes where country in ('Botswana');

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555146813,
		555046348,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			
			
			





























