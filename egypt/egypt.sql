-- Egypt

select railway, count(*) from africa_osm_nodes where country like '%Egypt%' group by railway order by count desc;
select railway, count(*) from africa_osm_nodes where name is not null and country like '%Egypt%' group by railway order by count desc;

select status, count(*) from africa_osm_edges where country like '%Egypt%' group by status order by count desc;
select type, count(*) from africa_osm_edges where country like '%Egypt%' group by type order by count desc;
select line, status, count(*) from africa_osm_edges where country like '%Egypt%' and line is not null group by line, status order by count desc;
select structure, count(*) from africa_osm_edges where country like '%Egypt%' group by structure order by count desc;
select gauge, count(*) from africa_osm_edges where country like '%Egypt%' group by gauge order by gauge desc;


-- update station nodes with english names (downloaded from OSM)
update africa_osm_nodes
set name_arabic = name
where railway in ('station', 'stop', 'halt')
and country = 'Egypt'

update africa_osm_nodes a
set name = b."name:en"
from osm_railway_stations_egypt b
where
name_arabic = b.name 
and a.railway in ('station', 'stop', 'halt')
and a.country = 'Egypt'


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
-- routing to Tajerouine
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 ,
 null,
 null,
 '',
 '',
 '',
 ST_SetSRID(ST_Point(), 4326)
 )
;

-- update line information

-- Cairo (Ramses) to Aswan
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555002397,
		555003179,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cairo (Ramses) to Aswan',
gauge = '1435',
status = 'open',
comment = 'double-track section',
mode = 'mixed'
where oid in (select edge from tmp);

-- Aswan to High Dam
-- is this freight only?
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555003179,
		555062097,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Aswan to Aswan High Dam',
gauge = '1435',
status = 'open',
comment = 'double-track section',
mode = 'freight'
where oid in (select edge from tmp);

update africa_osm_nodes
set railway = 'station',
name = 'Aswan High Dam'
where oid = 555062097; 

-- Aswan to Shallal branch
-- not clear if this is still used for passenger services

-- split 555003500 at 555064865
select rn_split_edge(array[555003500], array[555064865]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555064865,
		555010370,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Aswan to Shallal',
gauge = '1435',
status = 'open',
comment = 'status unclear',
mode = 'mixed'
where oid in (select edge from tmp);

-- Quena to Kharga, Baris, Abou Tartour
-- appears to be disused. East of Qena to Safaga is abandoned
-- plans for rehabilitation.

update africa_osm_nodes
set railway = 'stop',
name = 'Abou Tartour Phosphate Mine (proposed)'
where oid = 555064417; 

-- split 555004671 at 555065400 (allow routing to Kharga)
select rn_split_edge(array[555004671], array[555065400]);
-- and 555004669 at 555124051
-- and 555004670 at 555124052
select rn_split_edge(array[555004669, 555004670], array[555124051, 555124052]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555064417,
		555065400,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Abou Tartour',
gauge = '1435',
status = 'disused',
comment = 'Rehabilitation planned. Access to proposed phosphate mine/works',
mode = 'freight'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555010933,
		555099186,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kharga to Safaga (part)',
gauge = '1435',
status = 'disused',
comment = 'Probably disused. Rehabilitation planned.',
mode = 'mixed'
where oid in (select edge from tmp);

-- routing from Kharga line onto main Cairo <-> Aswan line
-- split 555135470 at 555097073
-- split 555057437 at 555097074
select rn_split_edge(array[555135470, 555057437], array[555097073, 555097074]);
-- split 555022046 at 555073888
-- split 555095112 at 555073879
select rn_split_edge(array[555022046, 555095112], array[555073888, 555073879]);
-- split 5550951122 at 555073889
select rn_split_edge(array[5550951122], array[555073889]);
-- link 555097073 to 555044792;
select rn_insert_edge(555097073, 555044792, 556000039);

update africa_osm_edges
set type = 'conventional',
status = 'disused'
where oid = 556000039;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555097073,
		555073879,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kharga to Safaga <-> Cairo (Ramses) to Aswan',
gauge = '1435',
status = 'disused',
comment = 'Probably disused. Rehabilitation planned.',
mode = 'mixed'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555097073,
		555073889,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kharga to Safaga <-> Cairo (Ramses) to Aswan',
gauge = '1435',
status = 'disused',
comment = 'Probably disused. Rehabilitation planned.',
mode = 'mixed'
where oid in (select edge from tmp);

-- Al-Wasitah to Al Fayoum
-- routing from Cairo to Aswan line
-- split 555034145 at 555080972
select rn_split_edge(array[555034145], array[555080972]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555080972,
		555009692,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Al-Wasitah to El Fayoum',
gauge = '1435',
status = 'open',
comment = 'Passenger services to Cairo according to ENR timetable',
mode = 'mixed'
where oid in (select edge from tmp);

-- Al Maraziq - El Gedida Iron Mine (El Bahariya)
-- appears to be freight only?

update africa_osm_nodes
set name = 'Al Maraziq (Mazghuna)'
where oid = 555003079;

-- route from Cairo - Aswan line
-- split 555011073 at 555064785
select rn_split_edge(array[555011073], array[555064785]);
-- split 555024161 at 555064784
select rn_split_edge(array[555024161], array[555064784]);

update africa_osm_nodes
set name = 'El Gedida Iron Mine (El Bahariya)',
railway = 'stop',
facility = 'mine'
where oid = 555065407;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555064785,
		555065407,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Al Maraziq - Gedida Iron Mine (El Bahariya)',
gauge = '1435',
status = 'open',
comment = 'Assumed freight only',
mode = 'freight'
where oid in (select edge from tmp);

update africa_osm_nodes
set name = 'El Tebbeen Industrial area',
railway = 'stop',
facility = 'manufacturing'
where oid = 555093762;

-- routing from Cairo - Aswan line
-- split 555011071 at 555095091
select rn_split_edge(array[555011071], array[555095091]);
-- split 555054698 at 555095086
select rn_split_edge(array[555054698], array[555095086]);
-- split 555054837 at 555065008
select rn_split_edge(array[555054837], array[555065008]);

-- Industrial area (El Nasr coke plant, Emeco Steel) El Tebbeen, 
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555095091,
		555093762,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'El Tebbeen Industrial area',
gauge = '1435',
status = 'open',
comment = 'Assumed freight only. Appears to serve El Nasr coke plant and perhaps Emeco Steel. Line provides access to Gedida Iron Mine',
mode = 'freight'
where oid in (select edge from tmp);

-- Military base, Badrshein

update africa_osm_nodes
set name = 'Military barracks (Badrshein)',
railway = 'stop',
facility = 'military'
where oid = 555094809;

-- split  555024172 at 555094810
select rn_split_edge(array[555024172], array[555094810]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555094810,
		555094809,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Military base, Badrshein',
gauge = '1435',
status = 'open',
comment = 'Assumed freight only.',
mode = 'freight'
where oid in (select edge from tmp);

-- Cairo (Ramses) to Qalyub
-- 4-track section

-- copy Qalyub station
-- copy 555003221 to 555038709
select rn_copy_node(array[555003221], array[555038709]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555002397,
		556003221,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cairo (Ramses) to Qalyub',
gauge = '1435',
status = 'open',
comment = '4-track section',
mode = 'mixed'
where oid in (select edge from tmp);

-- Qalyub to Banha
-- copy Banha station 555009754 to 555066737
select rn_copy_node(array[555009754], array[555066737]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              556003221,
		556009754,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Qalyub to Banha',
gauge = '1435',
status = 'open',
comment = 'double track section?',
mode = 'mixed'
where oid in (select edge from tmp);

-- Banha to Tanta
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              556009754,
		555034269,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Banha to Tanta',
gauge = '1435',
status = 'open',
comment = 'double track section?',
mode = 'mixed'
where oid in (select edge from tmp);

-- Tanta to Alexandria (Masr)

update africa_osm_nodes
set name = 'Masr (Alexandria)',
railway = 'station',
facility = ''
where oid = 555105359;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555034269,
		555105359,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tanta to Alexandria (Masr)',
gauge = '1435',
status = 'open',
comment = 'double track section. 4-track from Sidi Gaber to Alexandria',
mode = 'mixed'
where oid in (select edge from tmp);

-- Abis to Marsa Matruh

-- insert Abis station (showing on Bing Maps and schematic plan)
-- insert at 29.99530,31.20868

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 557000004,
 'station',
 'Abis',
 'Egypt',
 '1435',
 '',
 ST_SetSRID(ST_Point(29.99530,31.20868), 4326)
 )
;

-- copy to line
select rn_copy_node(array[557000004], array[555001984]);

-- split 555001983 at 555074678
select rn_split_edge(array[555001983], array[555074678]);
-- split 555003582 at 555074677
select rn_split_edge(array[555003582], array[555074677]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555074678,
		555016846,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Abis to Marsa Matruh',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);

-- Marsa Matruh to Al Sallum
-- not clear if this is open to passenger traffic or not?

-- for routing
-- change target node of 555050699 to 555105294
select rn_change_target(555050699, 555105294);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555105294,
		555010560,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Marsa Matruh to Al Sallum',
gauge = '1435',
status = 'open',
comment = 'unclear if this is open to passenger traffic',
mode = 'mixed'
where oid in (select edge from tmp);

-- Port of Dekheila

update africa_osm_nodes
set name = 'Port of Dekheila',
railway = 'stop',
facility = 'port',
gauge = '1435'
where oid = 555074490;

-- route into port
-- split 555003740 at 555074488
select rn_split_edge(array[555003740], array[555074488])

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555074488,
		555074490,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Dekheila',
gauge = '1435',
status = 'open',
comment = 'appears in use, see: https://www.egypttoday.com/Article/3/96777/Egyptian-authority-discloses-rail-freight-transport-development-plan',
mode = 'freight'
where oid in (select edge from tmp);

-- Alexandria Port

update africa_osm_nodes
set name = 'Alexandria Port (Container Terminal)',
railway = 'stop',
facility = 'port',
gauge = '1435'
where oid = 555128460;

-- add missing link b/w 555128459 and 555056176
select rn_insert_edge(555128459, 555056176, 556000040)

update africa_osm_edges
set type = 'conventional',
gauge = '1435',
status = 'open'
where oid = 556000040;

-- simplify
-- add link 555128510 to 555041033

select rn_insert_edge(555128510, 555041033, 556000041);

update africa_osm_edges
set type = 'conventional',
gauge = '1435',
status = 'open'
where oid = 556000041;

-- Alexandria Port (Container Terminal)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555056176,
		555128460,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Alexandria Port (Container Terminal)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- Alexandria port

update africa_osm_nodes
set name = 'Alexandria Port',
railway = 'stop',
facility = 'port',
gauge = '1435'
where oid = 555126482;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555064893,
		555126482,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Alexandria Port',
gauge = '1435',
status = 'open',
comment = 'Berths, oil terminal, additional container terminal',
mode = 'freight'
where oid in (select edge from tmp);

-- copy Mahattat al Qabbari station to line
-- note that this is disussed (e.g. see: https://www.youtube.com/watch?v=s8ys_ks8PNk)
select rn_copy_node(array[555008683], array[555003596])
select rn_split_edge(array[5550035961], array[556008683])

update africa_osm_nodes
set status = 'disused'
where oid = 556008683

-- Sidi Gaber to Rashid (Rosetta)
-- via Al Busaili

-- add link between Maamoura station and line to Rashid
-- link 555009964 to 555040831
select rn_insert_edge(555009964, 555040831, 556000042)

update africa_osm_edges
set type = 'conventional',
status = 'open'
where oid = 556000042;


update africa_osm_nodes
set gauge = '1000'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1000'))
and railway in ('station', 'halt', 'stop');

update africa_osm_nodes
set gauge = 'dual'
where (st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1000'))
and st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435')))
or
st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = 'dual'))
and railway in ('station', 'halt', 'stop');

-- extract tables for Egypt (backup)
create table egypt_osm_edges as select * from africa_osm_edges where country like '%Egypt%';
create table egypt_osm_nodes as select * from africa_osm_nodes where country like '%Egypt%';

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               ,
		,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			




























