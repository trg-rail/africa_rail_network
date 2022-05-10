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

-- extract tables for Egypt (backup)
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
		