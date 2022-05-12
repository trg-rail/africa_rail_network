-- Egypt

select railway, count(*) from africa_osm_nodes where country IN ('Mauritania',
'Senegal',
'Mali',
'Guinea',
'Sierra Leone',
'Liberia',
'Burkina Faso',
'Côte d''Ivoire',
'Ghana',
'Togo',
'Benin')
 group by railway order by count desc;
 
 
select railway, count(*) from africa_osm_nodes where name is not null and country IN ('Mauritania',
'Senegal',
'Mali',
'Guinea',
'Sierra Leone',
'Liberia',
'Burkina Faso',
'Côte d''Ivoire',
'Ghana',
'Togo',
'Benin') group by railway order by count desc;

select status, count(*) from africa_osm_edges where country IN ('Mauritania',
'Senegal',
'Mali',
'Guinea',
'Sierra Leone',
'Liberia',
'Burkina Faso',
'Côte d''Ivoire',
'Ghana',
'Togo',
'Benin') group by status order by count desc;

select type, count(*) from africa_osm_edges where country IN ('Mauritania',
'Senegal',
'Mali',
'Guinea',
'Sierra Leone',
'Liberia',
'Burkina Faso',
'Côte d''Ivoire',
'Ghana',
'Togo',
'Benin') group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country IN ('Mauritania',
'Senegal',
'Mali',
'Guinea',
'Sierra Leone',
'Liberia',
'Burkina Faso',
'Côte d''Ivoire',
'Ghana',
'Togo',
'Benin') and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country IN ('Mauritania',
'Senegal',
'Mali',
'Guinea',
'Sierra Leone',
'Liberia',
'Burkina Faso',
'Côte d''Ivoire',
'Ghana',
'Togo',
'Benin') group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country IN ('Mauritania',
'Senegal',
'Mali',
'Guinea',
'Sierra Leone',
'Liberia',
'Burkina Faso',
'Côte d''Ivoire',
'Ghana',
'Togo',
'Benin') group by gauge order by gauge desc;

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

update africa_osm_nodes
set name_arabic = name
where country = 'Mauritania';

update africa_osm_nodes
set name = 'Nouadhibou'
where oid = 555062007;

update africa_osm_nodes
set name = null,
name_arabic = null
where oid = 555062006;

update africa_osm_nodes
set name = 'Port of Cansado',
railway = 'stop',
facility = 'port'
where oid = 555148925;

update africa_osm_nodes
set name = 'M''Haoudat mine',
railway = 'stop',
facility = 'mine'
where oid = 555029748;

update africa_osm_nodes
set name = 'Guelb El Rhein mine',
railway = 'stop',
facility = 'mine'
where oid = 555019101;

update africa_osm_nodes
set name = 'Tuadschil (Touajil)'
where oid = 555023077;

update africa_osm_nodes
set name = 'Choum'
where oid = 555023067;

update africa_osm_nodes
set name = 'Ben Amira'
where oid = 555023066;

update africa_osm_nodes
set name = 'Inal'
where oid = 555023059;

update africa_osm_nodes
set name = 'Agueijit'
where oid = 555023058;

update africa_osm_nodes
set railway = null
where oid = 555023057;

update africa_osm_nodes
set name = 'Boulenoir',
railway = 'station'
where oid = 555154932;




-- Mauritania Railway
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555062007,
		555054550,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mauritania Railway',
gauge = '1435',
status = 'open',
comment = 'Primarily a freight line. A passenger carriage may be provided. Many travel on the iron ore wagons. No tickets or fares',
mode = 'mixed'
where oid in (select edge from tmp);

-- Nouadhibou to Port of Cansado
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555062007,
		555148925,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Nouadhibou to Port of Cansado',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- Zoueratte iron ore mines
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555068318,
		555029748,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Zoueratte iron ore mines',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);


-- Senegal

update africa_osm_nodes
set railway = 'station'
where oid = 555056530

update africa_osm_nodes
set railway = 'station',
name = 'Diamniadio'
where oid = 555063114

-- Train Express Regional 
-- phase 1 - Dakar to Diamniadio
-- 1435mm gauge double track

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555056530,
		555063114,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Train Express Regional (Dakar - Diamniadio)',
gauge = '1435',
status = 'open',
comment = 'Phase 1. Opened 27 December 2021. Will eventually continue to Blaise Diagne International Airport. Double tracked. Electrified',
mode = 'passenger'
where oid in (select edge from tmp);

-- copy halt 555020014 to 555116014
select rn_copy_node(array[555020014], array[555116014]);
-- wrong location
update africa_osm_nodes
set name = null,
railway = null
where oid = 556020014;

-- copy Colobane halt 555027054 to 5551160141
select rn_copy_node(array[555027054], array[5551160141]);
-- wrong location
update africa_osm_nodes
set name = 'Colobane'
where oid = 556027054;

-- copy Hann halt 555034091 to 55511601411
select rn_copy_node(array[555034091], array[55511601411]);
-- wrong location
update africa_osm_nodes
set name = 'Hann'
where oid = 556034091;

-- Dalifort halt
update africa_osm_nodes
set railway = 'halt',
name = 'Dalifort'
where oid = 555063068;

-- Baux Maraîchers halt
update africa_osm_nodes
set railway = 'halt',
name = 'Baux Maraîchers'
where oid = 555063070;

-- node for Pikine halt
select rn_copy_node(array[555138103], array[555116012]);
update africa_osm_nodes
set railway = 'halt',
name = 'Pikine'
where oid = 556138103;

-- Yeumbeul
update africa_osm_nodes
set railway = 'halt',
name = 'Yeumbeul'
where oid = 555063062;

-- create node for Keur Mbaye Fall (KMF) halt
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000005,
 'halt',
 'Keur Mbaye Fall (KMF)',
 'Senegal',
 '',
 '',
 ST_SetSRID(ST_Point(-17.31373,14.74387), 4326)
 )
;

select rn_copy_node(array[558000005], array[555116010]);

-- Rufisque
update africa_osm_nodes
set railway = 'halt',
name = 'Rufisque'
where oid = 555063065;

-- create node for PNR halt
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000006,
 'halt',
 'PNR',
 'Senegal',
 '',
 '',
 ST_SetSRID(ST_Point(-17.28402,14.72320), 4326)
 )
;

select rn_copy_node(array[558000006], array[5551160101]);

-- Bargny 
select rn_copy_node(array[555034704], array[555116037]);

-- Dakar port to Thiès
-- Freight only currently

-- Dakar Port
update africa_osm_nodes
set railway = 'stop',
name = 'Dakar Port ',
facility = 'port'
where oid = 555118935;

-- split 555085392 at 555068222
select rn_split_edge(array[555085392], array[555068222]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555118935,
		555068224,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Dakar-Bamako (Dakar - Thiès)',
gauge = '1000',
status = 'open',
comment = 'Section between Dakar and Diamniadio rebuilt with completion in 2020. Diamniado - Thiès presumed open and in use for access to the GC sand mine near Mékhé and ICS Phosphate mine near Mboro. Beleived to be freight only.',
mode = 'freight'
where oid in (select edge from tmp);

-- ICS fertilizer plant, Dakar

update africa_osm_nodes
set railway = 'stop',
name = 'ICS fertilizer plant',
facility = 'chemical_plant'
where oid = 555105274;

-- split 555085397 at 555068259
select rn_split_edge(array[555085397], array[555068259])

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555068259,
		555105274,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'ICS fertilizer plant',
gauge = '1000',
status = 'open',
comment = 'Assumed in operation to link to ICS phosphate mine near Mboro',
mode = 'freight'
where oid in (select edge from tmp);

-- Thiès to Mékhé
-- Freight only

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555068224,
		555027089,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Thiès to Mékhé',
gauge = '1000',
status = 'open',
comment = 'Serves ICS Phosphate mine and GC sand mine',
mode = 'freight'
where oid in (select edge from tmp);

-- ICS Mboro (Sand mine)

update africa_osm_nodes
set railway = 'stop',
name = 'CS Mboro (Sand mine)',
facility = 'mining'
where oid = 555138544;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555083768,
		555138544,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'CS Mboro (Sand mine)',
gauge = '1000',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- ICS Mboro (Phosphate mine)
update africa_osm_nodes
set railway = 'stop',
name = 'ICS Mboro (Phosphate mine)',
facility = 'mining'
where oid = 555123119;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555027089,
		555123119,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'ICS Mboro (Phosphate mine)',
gauge = '1000',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- Dakar-Niger (Thiès-Tambacounda)
-- appears to be subject to rehabilitation

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555068224,
		555024837,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Dakar-Niger (Thiès-Tambacounda)',
gauge = '1000',
status = 'rehabilitation',
comment = 'Appears to have ongoing rehabilitation work. A longer term upgrade project is possible with completion in 2027 which may open line to passenger traffic also.',
mode = 'freight'
where oid in (select edge from tmp);

-- Senegal and Mali
-- Dakar-Niger (Tambacounda-Bamako)
-- disused
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555024837,
		555027181,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Dakar-Niger (Tambacounda-Bamako)',
gauge = '1000',
status = 'disused',
comment = 'Understood to have been no freight or passenger services since 2018 on this stretch of the Dakar-Niger line across Senegal and Mali.',
mode = 'mixed'
where oid in (select edge from tmp);

-- Dakar-Niger (Mbacké branch)
-- disused
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555064668,
		555028874,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Dakar-Niger (Mbacké branch)',
gauge = '1000',
status = 'disused',
comment = 'Understood to have been no freight or passenger services since at least 2018.',
mode = 'mixed'
where oid in (select edge from tmp);

-- copy stations to lines
-- Kati 555055219 to 555022530
select rn_copy_node(array[555055219], array[555022530]);
-- Kita 555007340 to 555014410
select rn_copy_node(array[555007340], array[555014410]);
-- Toukoto 555042318 to 555042634
select rn_copy_node(array[555042318], array[555042634]);
-- Kidira 555029120 to 555010987
select rn_copy_node(array[555029120], array[555010987]);

-- Guinea

-- Need additional edge and nodes for standard gauge line into Conakry Port
INSERT INTO africa_osm_nodes (oid, country, geom) VALUES (557000007,'Guinea','0101000020E610000028316E3F77542BC0423066F46F182340');
INSERT INTO africa_osm_nodes (oid, country, geom) VALUES (557000008,'Guinea',
'0101000020E61000000F65C004B6622BC05F474067B60B2340');

INSERT INTO africa_osm_edges (oid, country, source, target, status, type, mode, geom) VALUES (
556000057, 'Guinea', 557000007, 557000008, 'open', 'conventional', 'mixed',
'0102000020E61000002600000028316E3F77542BC0423066F46F182340985CC08B11552BC07AA0986C2F182340A1253B8D9B552BC043BDE284F7172340C87D18D5E1552BC077D6CB72DA17234063D142FA77562BC09A215EC09D17234043C92EADE2562BC03BD2FF06711723405AC638C481572BC08A456A2D3017234002C7A30506582BC05262B445F81623406A7A964392582BC049856EBABF162340BA3E1C5DCD582BC06979B77DA61623408F7B2A01FC582BC0446458368E162340CB93C1F613592BC06AF268847F162340BC8F375049592BC05368E2DC58162340958875FB7E592BC0502564DC2A162340D47EA4749A592BC06E3B151C0E162340E3F5B18ADD592BC010656869BA152340CD35F8DC0B5A2BC060B66A137D1523408F2BFED9415A2BC0385E8DCB361523409F1BBDF65D5A2BC080BE7E60121523402A1A4282AD5A2BC0789EBAD4AB14234066A55CE73D5B2BC0DDC341B6EE132340290049619E5B2BC0089BFE9B6E1323400180D505FB5B2BC0372EEB88F5122340684793CD355C2BC0AF0DFE80A9122340691160C78A5C2BC0554ACA5F3912234026D284B6E05C2BC0FE86963EC91123402124F2A1275D2BC0400A42486C112340FD5FAE4D8B5D2BC00CF786F1E910234058F3DCFFB05D2BC094C65806BA102340076EE813D05F2BC0D975C6D2F70D2340C60CA58629602BC0C5BB3ABC860D23406F9A8C5835602BC0A440A3FF780D23400C7B330E53602BC0DA598CED5B0D2340526D7943F3602BC00AFEAC18E10C2340973AC0B0E6612BC01B8FB34F330C2340B3E55CDC3E622BC0E2CD65E4F70B234084ED89728D622BC0DF8AE7E3C90B23400F65C004B6622BC05F474067B60B2340');

update africa_osm_edges
set length = st_length(geom::geography)
where oid = 556000057;

-- change nodes to link to new edge
select rn_change_target(555014126, 557000007);
select rn_change_source(555013783, 557000008);

-- Standard Gauge Conakry Port to Kindia 
-- part has the Conakry Express passenger service

-- split 555058012 at 555102295
-- split 555013689 at 555069679
select rn_split_edge(array[555058012, 555013689], array[555102295, 555069679]);
-- split 555013691 at 555097513
select rn_split_edge(array[555013691], array[555097513]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555026987,
		555026982,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Conakry-Kindia (CBK) Portovoya-Km36',
gauge = '1435',
status = 'open',
comment = 'This section used by Conakry Express passenger service as well as CBK freight (Bauxite)',
mode = 'mixed'
where oid in (select edge from tmp);

-- Conakry port nodes
update africa_osm_nodes
set railway = 'stop',
facility = 'port',
name = 'Conakry Port (Kindia Bauxite)',
gauge = '1435'
where oid = 555102316;

update africa_osm_nodes
set railway = 'stop',
facility = 'port',
name = 'Conakry Port (to/from Fria)',
gauge = '1000'
where oid = 555069670

-- Line to Conakry Port (Kindia Bauxite)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555102316,
		555026987,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Conakry Port (Kindia Bauxite)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- to Rusal Bauxite mines

update africa_osm_nodes
set name = 'Rusal Bauxite mine',
railway = 'stop',
facility = 'mine'
where oid IN (555081475, 555083825)

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555026982,
		555081475,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Conakry-Kindia (CBK) Km36-Kindia',
gauge = '1435',
status = 'open',
comment = 'This section used by CBK (Bauxite)',
mode = 'freight'
where oid in (select edge from tmp);

-- split 555064932 at 555083824
select rn_split_edge(array[555064932], array[555083824]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555083824,
		555083825,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Conakry-Kindia (CBK) Km36-Kindia',
gauge = '1435',
status = 'open',
comment = 'This section used by CBK (Bauxite)',
mode = 'freight'
where oid in (select edge from tmp);

-- 1000mm line Conakry to Fria alumina refinery

update africa_osm_nodes
set railway = 'stop',
facility = 'manufacturing',
name = 'Fria alumina refinery',
gauge = '1000'
where oid = 555123459

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555069670,
		555123459,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Conakry-Fria (Rusal alumina refinery)',
gauge = '1000',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- ports/berths western Guinea

update africa_osm_nodes
set name = 'Daplion Barge Terminal',
railway = 'stop',
facility = 'port',
gauge = '1435'
where oid = 555042696

update africa_osm_nodes
set name = 'Dougoula Barge Terminal',
railway = 'stop',
facility = 'port',
gauge = '1435'
where oid = 555126198

update africa_osm_nodes
set name = 'Kamsar Bauxite Processing Plant and Port',
railway = 'stop',
facility = 'port',
gauge = '1435'
where oid = 555096377

-- bauxite mines
update africa_osm_nodes
set name = 'Bauxite mines',
facility = 'mine',
railway = 'stop'
where oid IN (555096397, 555096389, 555092223);

-- Kamsar to Sangarédi
-- standard gauge
-- passenger section

-- Kamsar station
-- copy 555121291 to 555050597
select rn_copy_node(array[555121291], array[555050597]);

update africa_osm_nodes
set railway = 'station',
name = 'Kamsar',
gauge = '1435'
where oid = 556121291;

update africa_osm_nodes
set railway = 'station',
name = 'Sangarédi',
gauge = '1435'
where oid = 555023280;

-- split 555130032 at 555092220
select rn_split_edge(array[555130032], array[555092220]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                556121291,
		555023280,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Boké Railway (Kamsar-Sangarédi)',
gauge = '1435',
status = 'open',
comment = 'Primarily carries Bauxite from mines to Kamsar processing plant and port or Dougoula Barge Terminal. Some passenger services also on this part.',
mode = 'mixed'
where oid in (select edge from tmp);

update africa_osm_edges set line = null where oid IN (5551300322, 555051769, 555103548, 555050594, 5550505951)

-- mine access
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555092224,
		555092223,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Boké Railway (Kamsar-Sangarédi)',
gauge = '1435',
status = 'open',
comment = 'Bauxite from mines to Kamsar processing plant and port or Dougoula Barge Terminal',
mode = 'freight'
where oid in (select edge from tmp);

-- split 555101431 at 555096388
select rn_split_edge(array[555101431], array[555096388]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555096388,
		555096389,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Boké Railway (Kamsar-Sangarédi)',
gauge = '1435',
status = 'open',
comment = 'Bauxite from mines to Kamsar processing plant and port or Dougoula Barge Terminal',
mode = 'freight'
where oid in (select edge from tmp);

-- split 555085668 at 555096398
select rn_split_edge(array[555085668], array[555096398]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555096398,
		555096397,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Boké Railway (Kamsar-Sangarédi)',
gauge = '1435',
status = 'open',
comment = 'Bauxite from mines to Kamsar processing plant and port or Dougoula Barge Terminal',
mode = 'freight'
where oid in (select edge from tmp);

-- Dougoula Barge Terminal line

-- split 555056620 at 555126199
select rn_split_edge(array[555056620], array[555126199]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555126199,
		555126198,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Boké Railway (Dougoula Barge Terminal)',
gauge = '1435',
status = 'open',
comment = 'Bauxite from mines to Kamsar processing plant and port or Dougoula Barge Terminal',
mode = 'freight'
where oid in (select edge from tmp);

-- Kamsar Bauxite Processing Plant and Port 

-- split 555050595 at  555151448
select rn_split_edge(array[555050595], array[555151448]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                556121291,
		555096377,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Boké Railway (Kamsar Bauxite Processing Plant and Port)',
gauge = '1435',
status = 'open',
comment = 'Bauxite from mines to Kamsar processing plant and port or Dougoula Barge Terminal',
mode = 'freight'
where oid in (select edge from tmp);

-- Santou-Dapilon standard gauge railway opened in 2021

update africa_osm_nodes
set name = 'Houda and Santou II mines',
railway = 'stop',
facility = 'mine'
where oid = 555151321

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555151321,
		555042696,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Santou-Dapilon',
gauge = '1435',
status = 'open',
comment = 'Bauxite from mines to Dapilon Barge Terminal. Opened in 2021.',
mode = 'freight'
where oid in (select edge from tmp);

-- station names
update africa_osm_nodes
set name = 'Boké'
where oid = 555023269;

update africa_osm_nodes
set name = 'Kolaboui'
where oid = 555023261;

-- split 555056608 at 555096414
select rn_split_edge(array[555056608], array[555096414]);
-- split 5550566081 at 555096413
select rn_split_edge(array[5550566081], array[555096413]);
-- copy Kolaboui station 555023261 to 55505660812
select rn_copy_node(array[555023261], array[55505660812]);
-- copy Boke station 555023269 to 555100827
select rn_copy_node(array[555023269], array[555100827]);
-- copy Simbaya 555026978 to 5550136891
select rn_copy_node(array[555026978], array[5550136891]);

-- Sierra Leone

-- Pepel Port - Tonkolili iron ore mines

-- split 555029173 at 555100165
select rn_split_edge(array[555029173], array[555100165]);

update africa_osm_nodes
set railway = 'stop',
name = 'Pepel Port',
facility = 'port'
where oid = 555100165;

update africa_osm_nodes
set railway = 'stop',
name = 'Tonkolili iron ore mines',
facility = 'mine'
where oid = 555090073;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555090073,
		555100165,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tonkolili-Pepel',
gauge = '1067',
status = 'open',
comment = 'Connects iron ore mines in Tonkolili with Pepel Port',
mode = 'freight'
where oid in (select edge from tmp);


-- Liberia

-- Buchanan Port

-- split 555061548 at 555099447
select rn_split_edge(array[555061548], array[555099447]);

update africa_osm_nodes
set railway = 'stop',
facility = 'port',
name = 'Buchanan Port'
where oid = 555099446;

-- Tokadeh mine
-- split 555087426 at 555100003
select rn_split_edge(array[555087426], array[555100003]);
-- split 555087425 at 555100006
select rn_split_edge(array[555087425], array[555100006]);
-- split 555061790 at 555100005
select rn_split_edge(array[555061790], array[555100005]);

update africa_osm_edges set line = null, gauge = null where oid in (5550874252, 5550874261, 555061790)

update africa_osm_nodes
set railway = 'stop',
facility = 'mine',
name = 'Tokadeh mine'
where oid = 555100004;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555100004,
		555099446,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Buchanan-Tokadeh',
gauge = '1435',
status = 'open',
comment = 'Connects iron ore mine at Tokadeh with Buchanan Port. Rebuilt by Arcelor Mittal in 2011',
mode = 'freight'
where oid in (select edge from tmp);

-- Monrovia Port

update africa_osm_nodes
set railway = 'stop',
facility = 'port',
name = 'Monrovia Port'
where oid = 555074602

-- Bong Mine

-- split 555060005 at 555096371
select rn_split_edge(array[555060005], array[555096371]);

update africa_osm_nodes
set railway = 'stop',
facility = 'mine',
name = 'Bong Mine'
where oid = 555096370

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555096370,
		555074602,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bong Mine Railway',
gauge = '1435',
status = 'disused',
comment = 'Connected iron ore mine at Bong with Monrovia port. Believed to be disused after latest mining activity ended in 2016.',
mode = 'freight'
where oid in (select edge from tmp);

-- Côte d'Ivoire and Burkina Faso

-- Abidjan-Ouagadougou railway
-- passenger service and freight
-- metre gauge
-- note that most of the rural stations are closed.

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555029854,
		555030523,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Abidjan-Ouagadougou railway',
gauge = '1000',
status = 'open',
comment = 'Note: Most of the rural stations on this route are closed to passenger services.',
mode = 'mixed'
where oid in (select edge from tmp);

-- Port of Abidjan

update africa_osm_nodes
set railway = 'stop',
name = 'Port of Abidjan',
facility = 'port'
where oid = 555026892;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555029854,
		555026892,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Abidjan',
gauge = '1000',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- disused section from Ouagadougou to Kaya

-- add link
select rn_insert_edge(555101167, 555127725, 556000058);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555002241,
		555030631,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Abidjan-Ouagadougou railway (Kaya branch)',
gauge = '1000',
status = 'disused',
type = 'conventional',
comment = 'Believed to be disused',
mode = 'mixed'
where oid in (select edge from tmp);


-- stations
update africa_osm_nodes
set railway = 'station'
where oid IN (555008518, 555008519, 555008520, 555008522, 555030070, 555010330, 555030201, 555027189, 555008477, 555026164, 555021831, 555027253, 555021740, 555017264, 555017259);

-- copy Agboville 555029881 to 555073728
select rn_copy_node(array[555029881], array[555073728]);

-- check gauge in these countries
update africa_osm_nodes
set gauge = '1435'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435'))
and country IN ('Mauritania',
'Senegal',
'Mali',
'Guinea',
'Sierra Leone',
'Liberia',
'Burkina Faso',
'Côte d''Ivoire',
'Ghana',
'Togo',
'Benin') and railway in ('station', 'halt', 'stop');

update africa_osm_nodes
set gauge = '1000'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1000'))
and country IN ('Mauritania',
'Senegal',
'Mali',
'Guinea',
'Sierra Leone',
'Liberia',
'Burkina Faso',
'Côte d''Ivoire',
'Ghana',
'Togo',
'Benin') and railway in ('station', 'halt', 'stop');

update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country IN ('Mauritania',
'Senegal',
'Mali',
'Guinea',
'Sierra Leone',
'Liberia',
'Burkina Faso',
'Côte d''Ivoire',
'Ghana',
'Togo',
'Benin') and railway in ('station', 'halt', 'stop');


-- extract tables for  (backup)
create table egypt_osm_edges as select * from africa_osm_edges where country ;
create table egypt_osm_nodes as select * from africa_osm_nodes where country ;

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
		