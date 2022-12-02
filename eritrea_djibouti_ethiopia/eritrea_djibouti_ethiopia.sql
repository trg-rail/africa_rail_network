-- eritrea_djibouti_ethiopia

select railway, count(*) from africa_osm_nodes where country in ('Eritrea', 'Djibouti', 'Ethiopia') group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country in ('Eritrea', 'Djibouti', 'Ethiopia') group by railway order by count desc;

select status, count(*) from africa_osm_edges where country in ('Eritrea', 'Djibouti', 'Ethiopia') group by status order by count desc;

select type, count(*) from africa_osm_edges where country in ('Eritrea', 'Djibouti', 'Ethiopia') group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country in ('Eritrea', 'Djibouti', 'Ethiopia') and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country in ('Eritrea', 'Djibouti', 'Ethiopia') group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country in ('Eritrea', 'Djibouti', 'Ethiopia') group by gauge order by gauge desc;


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


-- Massawa Port to Asmara

--split 555105000 at 555114126
select rn_split_edge(array[555105000], array[555114126]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555032419,
		555010387,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Massawa Port - Asmara',
mode = 'mixed',
type = 'conventional',
gauge = '950',
status = 'open',
comment = 'Believed to be some freight and limited passenger services on this line which was reconstructed between 1995-2003. See: https://www.sinfin.net/railways/world/eritrea.html'
where oid in (select edge from tmp);

-- Massawa-Taulud station access
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555031479,
		555114126,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Massawa-Taulud station access',
mode = 'mixed',
type = 'conventional',
gauge = '950',
status = 'open',
comment = 'Station may be disused'
where oid in (select edge from tmp);

-- Ethio-Djibouti Railway

-- Create Djibouti port stops

-- ports
update africa_osm_nodes
set railway = 'stop',
name = 'Djibouti Port (Container)',
facility = 'port'
where oid = 555050096;

update africa_osm_nodes
set railway = 'stop',
name = 'Doraleh Port (Terminals)',
facility = 'port'
where oid = 555046103;

-- Sebeta Freight Terminal
update africa_osm_nodes
set railway = 'stop',
name = 'Sebeta Freight Terminal',
facility = 'Freight Terminal'
where oid = 555127657;

-- passenger/freight
-- Nagad - Sebeta

-- copy Sebeta station
select rn_copy_node(array[555031598], array[555070336]);

update africa_osm_nodes
set railway = 'station',
name = 'Nagad',
name_arabic = 'نقاذ'
where oid = 555127657;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555028277,
		556031598,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ethio-Djibouti Railway',
mode = 'mixed',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Electrified. Completed 2016. '
where oid in (select edge from tmp);

-- Sebeta - Sebeta Freight Terminal
select rn_split_edge(array[5550703361], array[555127656]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             556031598,
		555127657,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ethio-Djibouti Railway (Sebeta Freight Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Electrified. Completed 2016.'
where oid in (select edge from tmp);

-- Nagad - Doraleh Port

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555028277,
		555046103,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ethio-Djibouti Railway (Nagad - Doraleh Port)',
mode = 'freight',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Djibouti Port

-- split 555097421 at 555137091
select rn_split_edge(array[555097421], array[555137091]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555137091,
		555138906,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ethio-Djibouti Railway (Djibouti Port)',
mode = 'freight',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Awash to Kombolcha line
-- under construction. This section thought to haev been largely complete
-- but damage during Tigray War. Assume not open.

-- split 555097426 at 555132294
select rn_split_edge(array[555097426], array[555132294]);

-- copy Awash station
select rn_copy_node(array[555028984], array[555104012]);
-- copy Kombolcha station
select rn_copy_node(array[555063192], array[555115923]);
-- update
update africa_osm_nodes
set name = 'Kombolcha',
railway = 'station'
where oid = 556063192;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555132294,
		556063192,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Awash to Kombolcha',
mode = 'mixed',
type = 'conventional',
gauge = '1435',
status = 'construction',
comment = 'Part of proposed Awash - Weldiya new line. This section was thought to be complete and trials were taking place 2018. Howver, now thought to have been damaged during Tigray War. Expected 120km/h passenger and 80-90km/h freight. Electrified.'
where oid in (select edge from tmp);

-- Addis Ababa Light Rail


-- Common Section

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555096137,
		555096142,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Addis Ababa Light Rail (Common Section)',
mode = 'passenger',
type = 'light rail',
gauge = '1435',
status = 'open',
comment = 'Up to 70km/h. Electrified'
where oid in (select edge from tmp);



-- Green Line Ayat - Tor Hailoch

update africa_osm_nodes
set railway = 'station'
where oid = 555038980;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555038980,
		555096137,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Addis Ababa Light Rail (Green Line)',
mode = 'passenger',
type = 'light rail',
gauge = '1435',
status = 'open',
comment = 'Up to 70km/h. Electrified'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555096142,
		555028307,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Addis Ababa Light Rail (Green Line)',
mode = 'passenger',
type = 'light rail',
gauge = '1435',
status = 'open',
comment = 'Up to 70km/h. Electrified'
where oid in (select edge from tmp);

-- Blue Line (Menelik Square to Kaliti)

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555034951,
		555096142,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Addis Ababa Light Rail (Blue Line)',
mode = 'passenger',
type = 'light rail',
gauge = '1435',
status = 'open',
comment = 'Up to 70km/h. Electrified'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555096137,
		555028316,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Addis Ababa Light Rail (Blue Line)',
mode = 'passenger',
type = 'light rail',
gauge = '1435',
status = 'open',
comment = 'Up to 70km/h. Electrified'
where oid in (select edge from tmp);

-- fix duplicate stations/stop on Addis Ababa Light Rail

update africa_osm_nodes
set railway = NULL
where oid in (
555035519,
555038995,
555028305,
555028301,
555039047,
555023210,
555039045,
555039044,
555028448,
555028451,
555028297,
555038997,
555028292
)


-- fix station issues

-- Arbaroba
select rn_copy_node(array[555014908], array[555034216]);
-- Ghinda
select rn_copy_node(array[555014913], array[555034264]);
-- Addis Ababa-Kality
select rn_copy_node(array[555029296], array[555072127]);
-- Furi-Labu
update africa_osm_nodes
set name = 'Addis Ababa-Furi-Labu'
where oid = 555028983;
-- Mofo station
update africa_osm_nodes
set railway = 'station'
where oid = 555028527;
-- Metehara station
-- add station
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000012,
 'station'
 'Metehara',
 'Ethiopia',
 '1435',
 null,
 ST_SetSRID(ST_Point(39.92062,8.91348), 4326)
 )
;
select rn_copy_node(array[558000012], array[555097431]);
-- Sirba Kunkur
update africa_osm_nodes
set railway = 'station',
name = 'Sirba Kunkur'
where oid = 555046459;
-- Mieso
update africa_osm_nodes
set railway = 'station',
name = 'Mieso'
where oid = 555046460;
-- Adigala Station
-- add station
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000013,
 'station',
 'Adigala',
 'Ethiopia',
 null,
 null,
 ST_SetSRID(ST_Point(42.14951,10.42262), 4326)
 )
;
select rn_copy_node(array[558000013], array[555116093]);
-- Arawa station
-- add station
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000014,
 'station',
 'Arawa',
 'Ethiopia',
 null,
 null,
 ST_SetSRID(ST_Point(41.94252,9.97815), 4326)
 )
;
select rn_copy_node(array[558000014], array[555069878]);
-- Dirē Dawa
select rn_copy_node(array[555062844], array[555097463]);
-- Dewele
select rn_copy_node(array[555028278], array[555116069]);
-- Gare d'Ali-sabieh
select rn_copy_node(array[555062838], array[555116846]);
-- Holl-Holl
select rn_copy_node(array[555063027], array[555083313]);
update africa_osm_nodes
set name = 'Holl-Holl'
where oid = 556063027;

-- stations on Awash - Weldiya




-- Facilities / Freight specific

-- Mojo Dry Port
-- ports
update africa_osm_nodes
set railway = 'stop',
name = 'Mojo Dry Port',
facility = 'dry port'
where oid = 555127594;

-- simply join to main line
select rn_insert_edge(555056594, 555056586, 556000062);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555056586,
		555127594,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mojo Dry Port',
mode = 'freight',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Dire Dawa Dry Port
update africa_osm_nodes
set railway = 'stop',
name = 'Dire Dawa Dry Port',
facility = 'dry port'
where oid = 555050970;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555038623,
		555050970,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Dire Dawa Dry Port',
mode = 'freight',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = ''
where oid in (select edge from tmp);



update africa_osm_nodes
set gauge = '950'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '950'))
and country in ('Eritrea') and railway in ('station', 'halt', 'stop');

update africa_osm_nodes
set gauge = '1435'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435'))
and country in ('Ethiopia', 'Djibouti') and railway in ('station', 'halt', 'stop');

-- extract tables (backup)
create table eritrea_djibouti_ethiopia_osm_edges as select * from africa_osm_edges where country in ('Eritrea', 'Djibouti', 'Ethiopia');
create table eritrea_djibouti_ethiopia_osm_nodes as select * from africa_osm_nodes where country in ('Eritrea', 'Djibouti', 'Ethiopia');

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555046103,
		556063192,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			
			
			





























