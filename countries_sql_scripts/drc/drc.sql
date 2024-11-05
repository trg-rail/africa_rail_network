-- Democratic Republic of the Congo

select railway, count(*) from africa_osm_nodes where country in ('Democratic Republic of the Congo') group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country in ('Democratic Republic of the Congo') group by railway order by count desc;

select status, count(*) from africa_osm_edges where country in ('Democratic Republic of the Congo') group by status order by count desc;

select type, count(*) from africa_osm_edges where country in ('Democratic Republic of the Congo') group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country in ('Democratic Republic of the Congo') and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country in ('Democratic Republic of the Congo') group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country in ('Democratic Republic of the Congo') group by gauge order by gauge desc;


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


-- Matadi – Kinshasa Railway

-- copy Matadi station
select rn_copy_node(array[555026527], array[555015576]);

update africa_osm_nodes
set name = 'Kinshasa Est',
railway = 'station'
where oid = 555063324;

select rn_split_edge(array[555000120], array[555063325]);

-- ensure line goes via Lwila
select rn_split_edge(array[555000138, 555000136], array[555099088, 555099089]);

-- edge select must exclude: 
-- 5550001362, 555000137, 5550001381

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid not in (5550001362, 555000137, 5550001381)',
             556026527,
		555063324,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Matadi - Kinshasa Railway',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Matadi - Matadi Gateway Terminal (River Port)
update africa_osm_nodes
set name = 'Matadi Gateway Terminal',
railway = 'stop',
facility = 'River Port',
comment = 'Container and general cargo port: https://www.mgt.cd/en'
where oid = 555090067;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             556026527,
		555090067,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Matadi - Matadi Gateway Terminal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Mbanza-Ngungu Branch
-- this is for access to railway workshops only

update africa_osm_nodes
set name = 'ONATRA Railway Workshops',
railway = 'stop',
facility = 'railway'
where oid = 555074962;

-- split 555012575 at 555108288
select rn_split_edge(array[555012575], array[555108288]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555108288,
		555074962,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mbanza-Ngungu Branch (Matadi-Kinshasa Railway)',
mode = 'railway_use',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Services ONATRA railway workshops'
where oid in (select edge from tmp);


-- Kinshasa river port

update africa_osm_nodes
set name = 'Kinshasa Port',
facility = 'River Port',
railway = 'stop'
where oid = 555051325;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555000049,
		555051325,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kinshasa River Port',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Ndjili Airport
-- disused

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555063361,
		555008767,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ndjili Airport Branch (Matadi-Kinshasa Railway)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Believed to be disused. See: bit.ly/3OIx7X5'
where oid in (select edge from tmp);


-- Great Lakes Line
-- Kisangani (Congo river port) – Ubundu
-- 1000mm gauge

-- split 555098913 at 555089332
select rn_split_edge(array[555098913], array[555089332]);
select rn_split_edge(array[5550989131], array[555089327]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555012471,
		555012469,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Great Lakes Line (Kisangani – Ubundu)',
mode = 'mixed',
type = 'conventional',
gauge = '1000',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Kisangani Port

update africa_osm_nodes
set name = 'Kisangani Port',
facility = 'River Port',
railway = 'stop',
comment = 'The River Port is believed to be currently abandoned and out of use'
where oid = 555026660;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555071268,
		555026660,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = '',
mode = 'freight',
type = 'conventional',
gauge = '1000',
status = 'disused',
comment = 'Assume disused as port is abandoned'
where oid in (select edge from tmp);
 

-- Ubundu River Port

-- split edges
select rn_split_edge(array[555046291, 555046292, 555046296], array[555089330, 555089337, 555089339]);

update africa_osm_nodes
set name = 'Ubundu River Port',
railway = 'stop',
facility = 'River Port',
comment = 'River port on the Upper Congo river (Lualaba)'
where oid = 555089340;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555012469,
		555089340,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ubundu River Port',
mode = 'freight',
type = 'conventional',
gauge = '1000',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- duplicate stations
update africa_osm_nodes
set railway = null,
gauge = null
where oid in (555062450, 555062451);

-- Great Lakes Lines - Kindu - Kalémié
-- 1067mm gauge

select rn_split_edge(array[555054221], array[555094591]);
select rn_split_edge(array[555054206], array[555094716]);
select rn_split_edge(array[555054101], array[555094686]);
select rn_split_edge(array[555044403], array[555094594]);
select rn_split_edge(array[555063903], array[555094592]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555062375 ,
		555010681,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Great Lakes Line (Kindu - Kalémié Port)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Section between Niemba - Kalémié Port may be out of use'
where oid in (select edge from tmp);


-- Kalémié Port Berths

update africa_osm_nodes
set railway = 'stop',
facility = 'River Port',
name = 'Kalémié Port (Berths)'
where oid = 555101321;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555010681 ,
		555101321,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Great Lakes Line (Kalémié Port Berths)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'May be out of use'
where oid in (select edge from tmp);

-- Katanga Line
-- Kabalo-Sakania

-- Kabalo-Kamina

-- simplify at Kabalo
-- insert pseudo link from 555012516 to 555101399
select rn_insert_edge(555012516, 555101399, 556000063);

-- copy kamina station
select rn_copy_node(array[555036699], array[555095783]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555012516,
		556036699,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Katanga Line (Kabalo-Kamina)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Kamina - Tenke

-- copy Tenke station 555063051 to 555104115
select rn_copy_node(array[555063051], array[555104115]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             556036699,
		556063051,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Katanga Line (Kamina-Tenke)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Apparently Electrified b/w Lubumbashi - Tenke - Kamina'
where oid in (select edge from tmp);

-- Tenke-Sakania

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             556063051,
		555077255,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Katanga Line (Tenke-Sakania)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kambove branch
-- status unclear

update africa_osm_nodes
set name = 'Kambove Mine (Gécamines)',
railway = 'stop',
facility = 'mine',
comment = 'Copper and cobalt'
where oid = 555110571;

-- split 555015718 at 555068922
select rn_split_edge(array[555015718], array[555068922]);
-- split 555012372 at 555110570
select rn_split_edge(array[555012372], array[555110570]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555068922,
		555030885,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Katanga Line (Kambove branch)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'unknown',
comment = ''
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555030885,
		555110571,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kambove Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unknown',
comment = ''
where oid in (select edge from tmp);

-- Mushosi Mine (Copper)

update africa_osm_nodes
set name = 'Mushosi Mine (Sodimico.SA)',
railway = 'stop',
facility = 'mine',
comment = 'Copper. Status unclear. https://www.mindat.org/loc-54653.html'
where oid = 555101606;

-- split 555121593 at 555101607
select rn_split_edge(array[555121593], array[555101607]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555101607,
		555101606,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mushosi Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unknown',
comment = ''
where oid in (select edge from tmp);

-- Kipushi branch
-- status unclear, part marked on SNCC map
-- planned rehabilitation?

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555069078,
		555030894,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Katanga Line (Munama-Kipushi branch)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'rehabilitation',
comment = 'Probably freight only. Plans to rebuild line announced in May 2020. See: bit.ly/3Fekvnm'
where oid in (select edge from tmp);


-- Kipushi Mine (Zinc/Copper)
-- In September 2022, construction started to re-open the mine, with production planned to start in late 2024 (https://en.wikipedia.org/wiki/Kipushi_Mine).
-- railway rebuild https://miningdigital.com/smart-mining/ivanhoe-mines-rebuild-significant-drc-railway-line-kpushi-project

update africa_osm_nodes
set name = 'Kipushi Mine',
railway = 'stop',
facility = 'mine',
comment = 'Zinc/Copper Mine. https://www.mindat.org/loc-4312.html'
where oid = 555110651;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555030894,
		555110651,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kipushi Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'rehabilitation',
comment = 'Work ongoing to open the mine and rebuild the railway. See: https://en.wikipedia.org/wiki/Kipushi_Mine and bit.ly/3Fekvnm'
where oid in (select edge from tmp);

-- Cobalt Mines
-- Mines are believed to be operating, see: https://www.mining-technology.com/marketdata/ten-largest-cobalts-mines-2021/
-- Unclear if railway is in use. Little evidence of it in operation on Google Earth
-- Etoile Mine
-- Ruashi Mine

update africa_osm_nodes
set name = 'Etoile Mine',
railway = 'stop',
facility = 'mine',
comment = 'Cobalt Mine https://www.mindat.org/loc-4331.html'
where oid = 555069136;

update africa_osm_nodes
set name = 'Ruashi Mine',
railway = 'stop',
facility = 'mine',
comment = 'Cobalt Mine https://www.mindat.org/loc-4338.html'
where oid = 555023787;

-- split 555015688 at 555068945
select rn_split_edge(array[555015688], array[555068945]);
-- split 555012625 at 555097394
select rn_split_edge(array[555012625], array[555097394]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555068945,
		555069136,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cobalt Mines (Etoile and Ruashi)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unknown',
comment = 'Probably disused.'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555097394,
		555023787,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cobalt Mines (Etoile and Ruashi)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unknown',
comment = 'Probably disused.'
where oid in (select edge from tmp);

-- Gecamines - slag treatment
-- status unknown

update africa_osm_nodes
set name = 'Gecamines (slag treatment plant)',
facility = 'mining',
railway = 'stop'
where oid = 555008339;

-- split 555057938 at 555138664
select rn_split_edge(array[555057938], array[555138664]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555138664,
		555008339,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gecamines (slag treatment plant)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unknown',
comment = 'Probably disused.'
where oid in (select edge from tmp);

-- Kakanda Mines (abandoned Copper Mines)

update africa_osm_nodes
set name = 'Kakanda Mines (abandoned)',
facility = 'mining',
railway = 'stop',
comment = 'Copper mines (abandoned). https://www.mindat.org/loc-14765.html'
where oid = 555110529;

-- pseudo line to simplify branch
select rn_insert_edge(555030883, 555110522, 556000064);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555030883,
		555110529,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kakanda Copper Mines',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Mines are abandoned'
where oid in (select edge from tmp);

-- Tenke Fungurume Mine (Copper/Cobalt)
-- status of line unknown
update africa_osm_nodes
set name = 'Tenke Fungurume Mine',
facility = 'mining',
railway = 'stop',
comment = 'Copper/Cobalt mines https://en.wikipedia.org/wiki/Tenke_Fungurume_Mine'
where oid = 555117318;

-- simplify routing from Fungurume

select rn_copy_node(array[555123098], array[555057244]);
select rn_insert_edge(555030882, 556123098, 556000065);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555030882,
		555117318,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tenke Fungurume Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unknown',
comment = ''
where oid in (select edge from tmp);

-- Benguela Line
-- Tenke - Dilolo (Angolan border)
-- Electrified Tenke – Mutshatsha
-- Refurbished 2018
-- 1067mm

-- Dilol station
update africa_osm_nodes
set railway = 'station',
name = 'Dilolo'
where oid = 555063015;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555069002,
		555123809,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Benguela Line (Tenke-Dilolo)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Refurbished in 2018. Electrified Tenke – Mutshatsha'
where oid in (select edge from tmp);

-- Kisenge Mine (Managanese)
-- https://www.mindat.org/loc-265088.html
-- out of use, potential to be relaunched (see: bit.ly/3OU6tKV)

-- split 555015655 at 555110254
select rn_split_edge(array[555015655], array[555110254]);

update africa_osm_nodes
set name = 'Kisenge Mine',
railway = 'stop',
facility = 'mining',
comment = 'Managanese mine. Out of use, potential to be relaunched (see: bit.ly/3OU6tKV)'
where oid = 555117241;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555110254,
		555117241,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kisenge Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Mine out of use; branch assumed disused.'
where oid in (select edge from tmp);

-- Kamoto Mine (Copper)
-- https://www.mindat.org/loc-413059.html

update africa_osm_nodes
set name = 'Kamoto Mine',
railway = 'stop',
facility = 'mining',
comment = 'Copper mine. https://www.mindat.org/loc-413059.html'
where oid = 555101331;

-- split 555012397 at 555110393
select rn_split_edge(array[555012397], array[555110393]);
-- split 555076123 at 555110390
select rn_split_edge(array[555076123], array[555110390]);
-- split 555019949 at 555110391
select rn_split_edge(array[555019949], array[555110391]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555110393,
		555101331,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kamoto Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Mine is open, assume branch line is.'
where oid in (select edge from tmp);

-- Tilwezembe mine (Copper and Cobalt)
-- https://www.mindat.org/loc-270448.html

update africa_osm_nodes
set name = 'Tilwezembe Mine',
railway = 'stop',
facility = 'mining',
comment = 'Copper/Cobalt mine. https://www.mindat.org/loc-270448.html. The mine is officially closed but illegal artisanal mining is occurring: bit.ly/3UmURkW'
where oid = 555069021;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555070490,
		555069021,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tilwezembe Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Likely to be disused as the mine is officially closed but illegal artisanal mining is occurring: bit.ly/3UmURkW'
where oid in (select edge from tmp);


-- Kasai Line
-- Kamia - Ilebo
-- 1067mm
-- 555070633

-- duplicate station at Ilebo
update africa_osm_nodes
set railway = NULL
where oid IN (555062806, 555062805);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555070633,
		555035023,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kasai Line',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Ilebo Port
update africa_osm_nodes
set name = 'Ilebo Port',
railway = 'stop',
facility = 'River Port'
where oid = 555034779;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
          555035023,
		555034779,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ilebo Port',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- SEP CONGO oil storage depot
update africa_osm_nodes
set name = 'SEP CONGO oil storage depot',
railway = 'stop',
facility = 'Oil storage depot'
where oid = 555120126;

-- split 555020015 at 555120125
select rn_split_edge(array[555020015], array[555120125]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
          555120125,
		555120126,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'SEP CONGO oil storage depot',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kamina Air Base
-- Military

update africa_osm_nodes
set name = 'Kamina Air Base',
railway = 'stop',
facility = 'military'
where oid = 555069047;

-- split 555012541 at 555069128
select rn_split_edge(array[555012541], array[555069128]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
          555069128,
		555069047,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kamina Air Base',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Spur to Kongolo
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
          555087916,
		555012517,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Great Lakes Line (Kongolo spur)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- fix station issues

-- Tshimbulu
select rn_copy_node(array[555012509], array[555020073]);
-- Katshilao
select rn_copy_node(array[555025872], array[555015779]);
-- Likasi
select rn_copy_node(array[555006856], array[555044570]);
-- Munama
select rn_copy_node(array[555026423], array[555012536]);

update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('Democratic Republic of the Congo') and railway in ('station', 'halt', 'stop');

update africa_osm_nodes
set gauge = '1000'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1000'))
and country in ('Democratic Republic of the Congo') and railway in ('station', 'halt', 'stop');

-- extract tables (backup)
create table drc_osm_edges as select * from africa_osm_edges where country in ('Democratic Republic of the Congo');
create table drc_osm_nodes as select * from africa_osm_nodes where country in ('Democratic Republic of the Congo');

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555035023,
		555020943,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			
			
			





























