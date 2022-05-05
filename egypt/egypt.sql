-- Egypt

select railway, count(*) from africa_osm_nodes where country like '%Egypt%' group by railway order by count desc;
select railway, count(*) from africa_osm_nodes where name is not null and country like '%Egypt%' group by railway order by count desc;

select status, count(*) from africa_osm_edges where country like '%Egypt%' group by status order by count desc;
select type, count(*) from africa_osm_edges where country like '%Egypt%' group by type order by count desc;
select line, status, count(*) from africa_osm_edges where country like '%Egypt%' and line is not null group by line, status order by count desc;
select structure, count(*) from africa_osm_edges where country like '%Egypt%' group by structure order by count desc;
select gauge, count(*) from africa_osm_edges where country like '%Egypt%' group by gauge order by gauge desc;

-- trap running entire script
update rubbish set rubish


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
comment = 'status unclear, no scheduled services.',
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
comment = 'unclear if this is open to passenger traffic - no scheduled services',
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
select rn_copy_node(array[555008683], array[555003596]);
select rn_split_edge(array[5550035961], array[556008683]);

update africa_osm_nodes
set status = 'disused'
where oid = 556008683;

-- Sidi Gaber to Rashid (Rosetta)
-- via Al Busaili

-- add link between Maamoura station and line to Rashid
-- link 555009964 to 555040831
select rn_insert_edge(555009964, 555040831, 556000042);
-- add link to simplify routing from Sidi Gaber
select rn_insert_edge(555070219, 555028171, 556000043);

update africa_osm_edges
set type = 'conventional',
status = 'open'
where oid in (556000042, 556000043);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555070219,
		555062410,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sidi Gaber to Rashid (Rosetta)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);

-- Maamoura to Abu Quir

-- additional station node for Abu Quir
update africa_osm_nodes
set railway = 'station',
name = 'Abu Quir',
name_arabic = 'أبو قير'
where oid = 555028168;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009964,
		555028168,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Maamoura to Abu Quir',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Al Busayit (Al Busayli) to Al-Qasabi

--split 555094625 at 555150511 for routing
select rn_split_edge(array[555094625], array[555150511]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555150511,
		555009916,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Al Busayit (Al Busayli) to Al-Qasabi',
gauge = '1435',
status = 'open',
comment = 'status unclear as no scheduled services in ENR timetable',
mode = 'mixed'
where oid in (select edge from tmp);

-- Mutubis to Desouk
-- simplify routing
-- copy a node and add link
select rn_copy_node(array[555090553], array[555052569]);
select rn_insert_edge(555009720, 556090553, 556000044);

update africa_osm_edges
set type = 'conventional',
status = 'open'
where oid = 556000044;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555093852,
		555009720,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mutubis to Desouk',
gauge = '1435',
status = 'open',
comment = 'status unclear as no scheduled services in ENR timetable',
mode = 'mixed'
where oid in (select edge from tmp);


-- 'Damnhour to Mahalet Rouh
-- reorganise Mahalet Rouh station nodes

update africa_osm_nodes
set railway = 'station',
name = 'Mahalet Rouh',
name_arabic = 'محلة روح'
where oid in (555073861);

update africa_osm_nodes
set railway = null,
name = null,
name_arabic = null
where oid in (555009791, 555008650);

-- routing from Danhour
-- split 555024014 at 555073963
select rn_split_edge(array[555024014], array[555073963]);
-- split 555069693 at 555121187
select rn_split_edge(array[555069693], array[555121187]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555073963,
		555009720,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Damnhour to Desouk',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009720,
		555073861,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Desouk to Mahalet Rouh',
gauge = '1435',
status = 'open',
comment = 'Status unclear, no scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Qallin to Shirbeen

-- routing from Qallin
-- split 555089033 at 555121171
select rn_split_edge(array[555089033], array[555121171]);

-- routing into Shirbeen
-- change target node of 555045483 to 555048969
select rn_change_target(555045483, 555048969);
delete from africa_osm_edges where oid = 555045484;


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555121171,
		555048969,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Qallin to Shirbeen',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Al Zaqaziq to Damietta 

-- split 555069052 at 555123796
select rn_split_edge(array[555069052], array[555123796])
-- split 555069309 at 555105449
select rn_split_edge(array[555069309], array[555105449])
-- split 555092932 at 555105450
select rn_split_edge(array[555092932], array[555105450])

-- update additinal node for correct placement of Damietta station
update africa_osm_nodes
set railway = 'station',
name = 'Damietta',
name_arabic = 'دمياط'
where oid = 555105453

update africa_osm_nodes
set railway = null,
name = null,
name_arabic = null
where oid = 555009641

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009693,
		555105453,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Al Zaqaziq to Damietta',
gauge = '1435',
status = 'open',
comment = 'Services in ENR online timetable (as EL-ZQAZYQ)',
mode = 'mixed'
where oid in (select edge from tmp);

-- Damietta port

-- Node for container terminal
update africa_osm_nodes
set railway = 'stop',
name = 'Damietta Port (container terminal)',
facility = 'port',
name_arabic = null
where oid = 555074507

update africa_osm_nodes
set railway = 'stop',
name = 'Damietta Port (grain terminal)',
facility = 'port',
name_arabic = null
where oid = 555074509

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555105452,
		555074508,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Damietta Port',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555074508,
		555074507,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Damietta Port (Container Terminal)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555074508,
		555074509,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Damietta Port (Grain Terminal)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- Kafr Saad to Kafr Suleiman

update africa_osm_nodes
set name = 'Kafra Saad'
where oid = 555010002;

-- split 555069200 at 555074014
select rn_split_edge(array[555069200], array[555074014]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555074014,
		555010003,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kafr Saad to Kafr Suleiman',
gauge = '1435',
status = 'open',
comment = 'Status unclear, no scheduled services in ENR timetable',
mode = 'mixed'
where oid in (select edge from tmp);

-- Ras al Khalij loop

-- split 555069190 at 555074965
-- split 555069188 at 555074966
select rn_split_edge(array[555069190, 555069188], array[555074965, 555074966]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid != 5550691882',
             555074965,
		555074966,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ras al Khalij loop',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Mansoura to Matariya

-- split 555109425 at 555105563
select rn_split_edge(array[555109425], array[555105563]);

update africa_osm_nodes
set name = 'Matariya'
where oid = 555010962;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555105563,
		555010962,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mansoura to Matariya',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Abu Kabir to El Salheya

update africa_osm_nodes
set railway = 'station',
name = 'El Salheya'
where oid = 555105476;

-- split 555067854 at 555105476
select rn_split_edge(array[555067854], array[555105476]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555069219,
		555105476,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Abu Kabir to El Salheya',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Fakous to Al Samaanah

-- simplify routing
-- link 555028259 to 555009955
select rn_insert_edge(555028259, 555009955, 556000045);

update africa_osm_edges
set type = 'conventional',
status = 'open'
where oid in (556000045);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009955,
		555009943,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Fakous to Al Samaanah',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Tanta to El Mansura

-- split 555089097 at 555073861
select rn_split_edge(array[555089097], array[555073861]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555073629,
		555105449,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tanta to El Mansura',
gauge = '1435',
status = 'open',
comment = 'Double track',
mode = 'mixed'
where oid in (select edge from tmp);

-- Banha to Al-Zaqaziq

-- simplify routing out of Banha

-- link 556009754 to 555062490
select rn_insert_edge(556009754, 555062490, 556000046);
update africa_osm_edges
set type = 'conventional',
status = 'open'
where oid in (556000046);

-- split 354929456 at 556009754
select rn_split_edge(array[354929456], array[556009754])

-- routing into  Al-Zaqaziq

-- copy node 555105326 to line 555033081
select rn_copy_node(array[555105326], array[555033081]);
-- insert line between 555080491 and 556105326
select rn_insert_edge(555080491, 556105326, 556000047);

update africa_osm_edges
set type = 'conventional',
status = 'open'
where oid in (556000047);

--split 555069055 at 555105317
select rn_split_edge(array[555069055], array[555105317]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             556009754,
		555009693,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Banha to Al-Zaqaziq',
gauge = '1435',
status = 'open',
comment = 'Double track',
mode = 'mixed'
where oid in (select edge from tmp);

-- Al-Zaqaziq to El Esmailiyah
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555069218,
		555009614,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Al-Zaqaziq to El Ismailiyah',
gauge = '1435',
status = 'open',
comment = 'Double track',
mode = 'mixed'
where oid in (select edge from tmp);

-- El Esmailiyah to Port Said

-- new node fr Port Said station
update africa_osm_nodes
set name = 'Port Said',
name_arabic = 'بورسعيد',
railway = 'station'
where oid = 555003420;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009614,
		555003420,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'El Esmailiyah to Port Said',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);

-- Port Said (Container Terminal)

-- insert node
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 557000005,
 'stop',
 'Port Said (Container Terminal)',
 'Egypt',
 '',
 'port',
 ST_SetSRID(ST_Point(32.29832,31.24367), 4326)
 )
;

-- insert edge
select rn_insert_edge(555003421, 557000005, 556000048);

update africa_osm_edges
set type = 'conventional',
status = 'open'
where oid in (556000048);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555003421,
		557000005,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port Said (Container Terminal)',
gauge = '1435',
status = 'open',
comment = 'Not confirmed',
mode = 'freight'
where oid in (select edge from tmp);

-- Ber El Abd branch line

-- disused due to additional shipping lane on Suez Canal
-- New swing bridge currently under construction

-- add bridge and connecting edge
-- new node
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 557000006,
 null,
 null,
 'Egypt',
 null,
 null,
 ST_SetSRID(ST_Point(32.34661,30.65476), 4326)
 )
;
-- bridge
select rn_insert_edge(555120644, 557000006, 556000049);
update africa_osm_edges
set type = 'conventional',
status = 'construction',
structure = 'movable bridge',
line = 'Ber El Abd branch line',
mode = 'mixed'
where oid in (556000049);

select rn_insert_edge(557000006, 555097353, 556000050);
update africa_osm_edges
set type = 'conventional',
status = 'disused',
mode = 'mixed'
where oid in (556000050);

-- east of new shipping lane
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             557000006,
		555009998,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ber El Abd branch line',
gauge = '1435',
status = 'disused',
comment = 'Out of use since opening of additional Suez Canal shipping lane. New swing bridge is under construction which will enable the line to reopen',
mode = 'mixed'
where oid in (select edge from tmp);

-- route onto Ber El Abd branch
-- west of new shipping lane
-- split 555038363 at 555105309
select rn_split_edge(array[555038363], array[555105309]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555105309,
		555120644,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ber El Abd branch line',
gauge = '1435',
status = 'disused',
comment = 'Out of use since opening of additional Suez Canal shipping lane. New swing bridge is under construction which will enable the line to reopen. See: https://en.wikipedia.org/wiki/El_Ferdan_Railway_Bridge',
mode = 'mixed'
where oid in (select edge from tmp);


-- El Wasfiya to Suez

-- route to suez
-- split 555022096 at 555073909
select rn_split_edge(array[555022096], array[555073909]);
-- split 555004593 at 555073910
select rn_split_edge(array[555004593], array[555073910]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555073909,
		555022882,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'El Wasfiya to Suez',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);

-- Suez to Adly Mansour

-- line may not currently be in use
-- mark as rehabilitation (see: https://egyptindependent.com/transport-minister-inspects-pilot-operation-of-lrt-to-the-new-administrative-capital)

-- create station for Adly Manosur
select rn_copy_node(array[555153933], array[555103907]);

update africa_osm_nodes
set name = 'Adly Mansour',
name_arabic = 'عدلى منصور',
railway = 'station',
status = 'construction'
where oid = 556153933;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             556153933,
		555022882,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Adly Mansour (Cairo) to Suez',
gauge = '1435',
status = 'rehabilitation',
comment = 'Not thought to be services currently. see: https://egyptindependent.com/transport-minister-inspects-pilot-operation-of-lrt-to-the-new-administrative-capital',
mode = 'mixed'
where oid in (select edge from tmp);

-- Suez to Sokhna Port

-- insert new edge
select rn_insert_edge(555010004, 555074016, 556000051);

update africa_osm_edges
set type = 'conventional',
gauge = null,
status = 'open'
where oid in (556000051);

-- split edge
select rn_split_edge(array[555022421], array[555074016])

-- rename node for Sokhna Port
update africa_osm_nodes
set name = 'Sokhna Port',
railway = 'stop',
facility = 'port'
where oid = 555024218;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555074018,
		555024218,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Suez to Sokhna Port',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Assumed freight only. Apparently not disused, see: https://www.sis.gov.eg/Story/160371/1st-container-freight-train-operated-from-Sokhna-to-West-Port-Said-port?lang=en-us',
mode = 'freight'
where oid in (select edge from tmp);


-- Kafr El-Zayat to Menuf

-- split 555022226 at 555119035
select rn_split_edge(array[555022226], array[555119035]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555119035,
		555039038,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kafr El-Zayat to Menuf',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Tanta to Menuf

-- simplify routing join 555120864 to 555034269
select rn_insert_edge(555120864, 555034269, 556000052);

update africa_osm_edges
set type = 'conventional',
gauge = null,
status = 'open'
where oid in (556000052);

-- simplify routing into Menuf join 555073998 to 555039038
select rn_insert_edge(555073998, 555039038, 556000053);

update africa_osm_edges
set type = 'conventional',
gauge = null,
status = 'open'
where oid in (556000053);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555034269,
		555039038,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tanta to Menuf',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Banha to Menuf

-- split 555012295 at 555105456
select rn_split_edge(array[555012295], array[555105456]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555105456,
		555073998,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Banha to Menuf',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);


-- Qalyub to Menuf

-- split 555086228 at 555073977
select rn_split_edge(array[555086228], array[555073977]);

-- copy node 555105622 to 5550387091
select rn_copy_node(array[555105622], array[5550387091]);

-- change source of 555069496 to 556105622
select rn_change_source(555069496, 556105622);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             556105622,
		555039038,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Qalyub to Menuf',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);


-- Cairo to Ityai Al-Barud
-- split 555103862 at 555065055
select rn_split_edge(array[555103862], array[555065055]);
-- split 555013652 at 555065054
select rn_split_edge(array[555013652], array[555065054]);
-- split 555024023 at 555099317
select rn_split_edge(array[555024023], array[555099317]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555065054,
		555099317,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cairo to Ityai Al-Barud',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Scheduled services (from Bashteel)',
mode = 'mixed'
where oid in (select edge from tmp);

-- Mahattat al Tayriyah to Sidi Marghab 
-- status unknown
-- split 555003736 at 555105448
-- split 555069166 at 555099319
select rn_split_edge(array[555003736, 555069166], array[555105448, 555099319]);
-- split 555070082 at 555099304
select rn_split_edge(array[555070082], array[555099304]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555099304,
		555105448,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mahattat al Tayriyah to Sidi Marghab',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Status unclear, no scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Al Zaqaziq to Tanta

-- split 555069689 at 555105701
select rn_split_edge(array[555069689], array[555105701]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid not in (555033078, 5550690551)',
            555080491,
		555074519,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Al Zaqaziq to Tanta',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Zifta to Banha

-- join 555105454 to 555009766 to simplify routing from Zifta
select rn_insert_edge(555105454, 555009766, 556000054);

update africa_osm_edges
set type = 'conventional',
gauge = null,
status = 'open'
where oid in (556000054);

-- split 5550122951 at 555065393
select rn_split_edge(array[5550122951], array[555065393]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555105454,
		555065393,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Zifta to Banha',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Santa to Mahalet Rouh

-- simplify routing
-- link 555073829 to 555105724
select rn_insert_edge(555073829, 555105724, 556000055);

update africa_osm_edges
set type = 'conventional',
gauge = null,
status = 'open'
where oid in (556000055);

-- split 555022008 at 555105724
select rn_split_edge(array[555022008], array[555105724]);
-- split 555089096 at 555130128
select rn_split_edge(array[555089096], array[555130128]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555073829,
		555130128,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Santa to Mahalet Rouh',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Al Zaqaziq to Qalyub

-- link 555105620 to 555083851
select rn_insert_edge(555105620, 555083851, 556000056);

update africa_osm_edges
set type = 'conventional',
gauge = null,
status = 'open'
where oid in (556000056);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555105318,
		555083851,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Al Zaqaziq to Qalyub',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Status unclear, no scheduled services',
mode = 'mixed'
where oid in (select edge from tmp);

-- Shebin Al-Qanater to El Marg

-- split 555069565 at 555074493
select rn_split_edge(array[555069565], array[555074493]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555074493,
		555065057,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Shebin Al-Qanater to Al Marj',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Scheduled services on part of this route',
mode = 'mixed'
where oid in (select edge from tmp);

-- Branch for New Borg El Arab (Borg El Arab El Gedida)
-- new city in Alexandria Governorate
-- station in timetable but no current services

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555040793,
		555028149,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Branch for New Borg El Arab',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Station serving new city (no currently scheduled services)',
mode = 'mixed'
where oid in (select edge from tmp);

-- Branch to El Zawya El Hamra (Al Farz?)

-- change source of 555069971 to 555105876
select rn_change_source(555069971, 555105876)

update africa_osm_nodes
set name = 'El Zawya El Hamra'
where oid = 555003100;

-- not clear current status - in ENR timetable but no scheduled services
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555105876,
		555003100,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Branch to El Zawya El Hamra',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Branch to El Zawya El Hamra station (no currently scheduled services)',
mode = 'mixed'
where oid in (select edge from tmp);

-- Mohamed Naguib Military Base

update africa_osm_nodes
set name = 'Mohamed Naguib Military Base',
railway = 'stop',
facility = 'military'
where oid = 555030745;

select distinct facility from africa_osm_nodes

-- split 555024372 at 555112878
select rn_split_edge(array[555024372], array[555112878]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555112878,
		555030745,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mohamed Naguib Military Base',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- Baris (Paris) branch
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555065398,
		555062264,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Baris (Paris) branch',
type = 'conventional',
gauge = '1435',
status = 'disused',
comment = 'Presumed disused. May be reopened as part of planned Abou Tartour to Safaga rehabilitation?',
mode = 'mixed'
where oid in (select edge from tmp);


-- update stations

update africa_osm_nodes
set name = 'Arad'
where oid = 555021205;

update africa_osm_nodes
set name = 'Samla'
where oid = 555003139;

update africa_osm_nodes
set name = 'El Hamam'
where oid = 555024927;

update africa_osm_nodes
set name = 'EL Gharbaniat'
where oid = 555003131;

update africa_osm_nodes
set name = 'Borg El Arab'
where oid = 555003130;

update africa_osm_nodes
set name = 'Bahig'
where oid = 555040791;

update africa_osm_nodes
set name = 'King Marriot',
name_arabic = null
where oid = 555044264;

update africa_osm_nodes
set name = 'El Amreya',
name_arabic = null
where oid = 555044265;

update africa_osm_nodes
set name = 'M-El Max',
name_arabic = null
where oid = 555040895;

update africa_osm_nodes
set name = 'El Raml'
where oid = 555028890;

update africa_osm_nodes
set name = 'El Eslah',
railway = 'station'
where oid = 555040823;

update africa_osm_nodes
set name = 'El Baharia Academy'
where oid = 555024980;

update africa_osm_nodes
set name = 'El Rahmanyh'
where oid = 555062866;

update africa_osm_nodes
set name = 'El Shohadaa'
where oid = 555009842;

update africa_osm_nodes
set name = 'Magdy Ghazy'
where oid = 555019318;

update africa_osm_nodes
set name = 'El Kom El Taweel'
where oid = 555008654;

update africa_osm_nodes
set name = 'Kafr Saad El Balad'
where oid = 555010001;

-- node for Qutur station
select rn_copy_node(array[555028254], array[555089010])

update africa_osm_nodes
set name = 'Qutur',
railway = 'station'
where oid = 556028254;

update africa_osm_nodes
set name = 'Gelbana'
where oid = 555010347;

update africa_osm_nodes
set name = 'El Gabal El Asfar'
where oid = 555003228;

update africa_osm_nodes
set name = 'Rosetta',
name_arabic = 'رشيد'
where oid = 555062410;

update africa_osm_nodes
set name = 'Nahtay'
where oid = 555028248;

update africa_osm_nodes
set name = 'El Manshyet El Kobra'
where oid = 555006692;

update africa_osm_nodes
set name = 'El Santa'
where oid = 555028249;

update africa_osm_nodes
set name = 'Nat El Kom'
where oid = 555015718;

update africa_osm_nodes
set name = 'El Galatma'
where oid = 555008643;

update africa_osm_nodes
set name = 'El Manashy',
name_arabic = null
where oid = 555015257;

update africa_osm_nodes
set name = 'El Fant'
where oid = 555023707;

update africa_osm_nodes
set name = 'Damarees',
name_arabic = null
where oid = 555010991;

update africa_osm_nodes
set name = 'Dishna'
where oid = 555023730;

update africa_osm_nodes
set name = 'Qift'
where oid = 555023733;

update africa_osm_nodes
set name = 'Armnt'
where oid = 555009566;

update africa_osm_nodes
set name = 'El Kalh'
where oid = 555010024;

update africa_osm_nodes
set name = 'El Atwani'
where oid = 555010021;

update africa_osm_nodes
set name = 'Idfu'
where oid = 555033909;

-- copy Radiseya station node 555033429 to 555028348
select rn_copy_node(array[555033429], array[555028348]);

update africa_osm_nodes
set name = 'Radiseya'
where oid = 556033429;

-- copy unknown station 555033428 to 555028352 (exists on satellite view)

select rn_copy_node(array[555033428], array[555028352]);

-- node for Shebin Al-Qanater station
select rn_copy_node(array[555009999], array[555069551]);

update africa_osm_nodes
set name = 'Gaafr El Sadiq'
where oid = 555033426;

update africa_osm_nodes
set name = 'Shatb'
where oid = 555023736;

update africa_osm_nodes
set name = 'Baris (Paris)'
where oid = 555003457;

update africa_osm_nodes
set name = 'unknown'
where oid in (555003137, 555011315, 555009963, 555009980, 555010350, 555016713, 555016711, 555014810, 555026310, 555028262, 555062373, 555003461, 555010022, 556033428, 555037071, 555028344, 555033439, 555038427, 555028163, 555012741, 555022849, 555022850);

-- remove duplicate stations or incorrect station nodes
update africa_osm_nodes
set name = null,
railway = null,
gauge = null
where oid in (555062867, 555063166, 555009841, 555062898, 555009846, 555028252, 555009906, 555062392)


update africa_osm_nodes
set gauge = '1435'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435'))
and country ='Egypt' and railway in ('station', 'halt', 'stop');

-- extract tables for Egypt (backup)
create table egypt_osm_edges as select * from africa_osm_edges where country like '%Egypt%';
create table egypt_osm_nodes as select * from africa_osm_nodes where country like '%Egypt%';

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555008624,
		555007469,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			




























