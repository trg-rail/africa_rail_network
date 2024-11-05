-- Mozambique

select railway, count(*) from africa_osm_nodes where country in ('Mozambique') group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country in ('Mozambique') group by railway order by count desc;

select status, count(*) from africa_osm_edges where country in ('Mozambique') group by status order by count desc;

select type, count(*) from africa_osm_edges where country in ('Mozambique') group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country in ('Mozambique') and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country in ('Mozambique') group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country in ('Mozambique') group by gauge order by gauge desc;


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


-- Nacala Coal Terminal (Nacala-a-Velha)
update africa_osm_nodes
set name = 'Nacala Coal Terminal (Nacala-a-Velha)',
facility = 'Coal Terminal (port)',
railway = 'stop'
where oid = 555043650;

-- Nacala Port

-- split 555064756 at 555112788
select rn_split_edge(array[555064756], array[555112788]);
-- split 5550647561 at 555112777
-- split 555077864 at 555101884
-- split 555064643 at 555112778
-- split 555077865 at 555112780
select rn_split_edge(array[5550647561,555077864,555064643,555077865], array[555112777,555101884,555112778,555112780]);

-- Container Terminal
update africa_osm_nodes
set name = 'Nacala Port (container terminal)',
facility = 'Container Terminal',
railway = 'stop'
where oid = 555112781;

-- general port
update africa_osm_nodes
set name = 'Nacala Port',
facility = 'Port',
railway = 'stop'
where oid = 555112788;

-- Nacala - Cuamba line
-- Nacala Port - Nampula (Freight only)

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555026542,
		555112788,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Nacala - Cuamba',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Appear to be no passenger services on this Nacala - Napula section. See: http://bit.ly/3Zbj7t5'
where oid in (select edge from tmp);

-- Nacala container terminal
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112777,
		555112781,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Nacala Port (Container Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Nacala Coal Terminal (Nacala-a-Velha)

-- split 555064714 at 555145211
select rn_split_edge(array[555064714], array[555145211]);
-- split 5550647141 at 555145288
select rn_split_edge(array[5550647141], array[555145288]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555101973,
		555043650,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Nacala Coal Terminal (Nacala-a-Velha)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Nacala - Cuamba line
-- Nampula - Cuamba section (has passenger services)

-- correct gap
select rn_change_target(555049018, 555130594);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555026542,
		555031149,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Nacala - Cuamba',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services on this section. See: http://bit.ly/3Zbj7t5'
where oid in (select edge from tmp);

-- Cuamba - Lichinga

-- simplify
select rn_insert_edge(555112622, 555031149, 556000080);
--split 555077768 at 555112622
select rn_split_edge(array[555077768], array[555112622]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555031149,
		555031150,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cuamba - Lichinga',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services on this section. See: http://bit.ly/3Zbj7t5'
where oid in (select edge from tmp);

-- Cuamba - Entre Lagos (Malawi border)

-- split edge at border with Malawi
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000040,
 null,
 null,
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(35.87807,-14.98191), 4326)
 )
;

select rn_copy_node(array[558000040], array[555015140]);
-- 559000040

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555031149,
		555006758,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cuamba - Entre Lagos',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services on this section. See: http://bit.ly/3Zbj7t5'
where oid in (select edge from tmp);

-- Entre Lagos - Malawi border
-- assumed freight only

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555006758,
		559000040,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Entre Lagos - Malawi border',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- stations 
update africa_osm_nodes 
set name = 'Catur'
where oid = 555035481;

update africa_osm_nodes 
set name = 'Lóchue'
where oid = 555031168;

update africa_osm_nodes 
set name = 'Nataleia'
where oid = 555020548;

update africa_osm_nodes 
set name = 'Namecuna'
where oid = 555024351;

update africa_osm_nodes 
set name = 'Liala'
where oid = 555031169;

update africa_osm_nodes 
set name = 'Iapala'
where oid = 555028803;

update africa_osm_nodes 
set name = 'Nicupi'
where oid = 555024356;

update africa_osm_nodes 
set name = 'Meconta'
where oid = 555031170;

update africa_osm_nodes 
set name = 'Anchilo'
where oid = 555031172;

update africa_osm_nodes 
set name = 'unnamed'
where oid = 555031173;

-- Sena line (Dondo - Mutarara)

-- split 555050156 at 555113026
select rn_split_edge(array[555050156], array[555113026]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555071734,
		555113026,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sena Line (Dondo - Mutarara)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services between Beira and Mutarara. See: https://bit.ly/3IJlKN9'
where oid in (select edge from tmp);

-- Mutarara - Moatize

-- add new Moatize station node
select rn_copy_node(array[555026535], array[555100923]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555113026,
		556026535,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mutarara - Moatize',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services between Mutarara and Moatize. See: https://bit.ly/3IJlKN9'
where oid in (select edge from tmp);

-- Moatize Coal Mine
update africa_osm_nodes
set name = 'Moatize Coal Mine',
facility = 'mine',
railway = 'stop'
where oid = 555102738;

-- split 555066299 at 555126149
-- spit 555095414 at 555087802
select rn_split_edge(array[555066299,555095414], array[555126149,555087802]);

-- Moatize Coal Mine (Sena Line)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555087801,
		555126149,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Moatize Coal Mine (Mutarara - Moatize line access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Moatize Coal Mine (Mozambique) - Nyaka (Malawi)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555102738,
		555064183,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Moatize Coal Mine (Mozambique) - Nyaka (Malawi)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Part of Nacala Logistics Corridor. Main purpose to transport coal from Moatize coal mines to the port of Nacala via Malawi. The section between Moatize and Nyaka was a new line and was first used in 2015. See: https://en.wikipedia.org/wiki/Nacala_Logistics_Corridor'
where oid in (select edge from tmp);

-- Sena Line (Mutarara - Vila Nova da Fronteira section)
-- and Malawi border
-- Open 2023. Has been rehabilitated see: https://bit.ly/3SipKaC

-- insert node at Malawui border

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000041,
 null,
 null,
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(35.19423,-17.12829), 4326)
 )
;

select rn_copy_node(array[558000041], array[555120258]);
-- 559000041

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555113026,
		559000041,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sena Line (Mutarara - Vila Nova da Fronteira)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Line was rehabilitated and opened to traffic in 2023 to transport construction materials to Malawi for rehabilitation work on the line in Malawi. See: https://bit.ly/3SipKaC'
where oid in (select edge from tmp);


-- Inhamitanga - Marromeu

-- add missing station
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000042,
 'station',
 'Km 70',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(35.72936,-18.26844), 4326)
 )
;

select rn_copy_node(array[558000042], array[555037502]);
-- 559000042

-- split 555053211 at 555083036
select rn_split_edge(array[555053211], array[555083036]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555083036,
		555016393,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Inhamitanga - Marromeu',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services. See: https://bit.ly/3IJlKN9, Reconstruction completed in 2008. See: https://allafrica.com/stories/200806060924.html'
where oid in (select edge from tmp);

-- Sena Sugar Mill
update africa_osm_nodes
set name = 'Sena Sugar Mill',
railway = 'stop',
facility = 'food manufacturing'
where oid = 555113090;

-- split 555049893 at 555113090
select rn_split_edge(array[555049893], array[555113090]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555016393,
		555113090,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sena Sugar Mill',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Beira-Bulawayo Railway (Beira - Machipanda)
-- Has been undergoing rehabilitation to improve speeds and increase wagon weight. See: https://allafrica.com/stories/202107131004.html [new speed should be 60km/h – was expected to be completed in 2022]
-- Suggestion that will reopen for passenger services: https://clubofmozambique.com/news/mozambique-beira-zimbabwe-line-passenger-trains-to-resume-in-2022-domingo-172105/


-- Beira - Dondo
-- Passenger services on this stretch

update africa_osm_nodes
set name = 'Beira',
railway = 'station'
where oid = 555042540;

-- Dondo station

select rn_copy_node(array[555130742], array[555102101]);

update africa_osm_nodes
set name = 'Dondo',
railway = 'station'
where oid = 556130742;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555042540,
		556130742,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beira-Bulawayo Railway (Beira - Dondo)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Scheduled passenger services on this section. See: https://bit.ly/3IJlKN9'
where oid in (select edge from tmp);

-- Beira-Bulawayo Railway (Dondo - Machipanda)

-- add stations
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000043,
 'station',
 'Machipanda',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(32.72819,-18.99204), 4326)
 )
;

select rn_copy_node(array[558000043], array[555037153]);
-- 559000043

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000044,
 'station',
 'Chainca',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(32.81749,-18.93098), 4326)
 )
;

select rn_copy_node(array[558000044], array[555053179]);
-- 559000044

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000045,
 'station',
 'Manica',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(32.86740,-18.93596), 4326)
 )
;

select rn_copy_node(array[558000045], array[555086939]);
-- 559000045

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000046,
 'station',
 'Revue',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(33.02380,-18.96694), 4326)
 )
;

select rn_copy_node(array[558000046], array[555053190]);
-- 559000046

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000047,
 'station',
 'Elvas',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(33.07574,-18.97222), 4326)
 )
;

select rn_copy_node(array[558000047], array[555071973]);
-- 559000047

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000048,
 'station',
 'Bandula',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(33.14019,-19.01269), 4326)
 )
;

select rn_copy_node(array[558000048], array[555036906]);
-- 559000048

update africa_osm_nodes
set name = 'Garuso'
where oid = 555016123;

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000049,
 'station',
 'Belas',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(33.21874,-18.94512), 4326)
 )
;

select rn_copy_node(array[558000049], array[555086904]);
-- 559000049

update africa_osm_nodes
set name = 'Matsinho'
where oid = 555013378;

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000050,
 'station',
 'Almada',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(33.32207,-18.96820), 4326)
 )
;

select rn_copy_node(array[558000050], array[555036893]);
-- 559000050

update africa_osm_nodes
set name = 'Charamba'
where oid = 555020699;

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000051,
 'station',
 'Tembe',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(33.42978,-19.03257), 4326)
 )
;

select rn_copy_node(array[558000051], array[555036898]);
-- 559000051

update africa_osm_nodes
set railway = null
where oid = 555025742;

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000052,
 'station',
 'Gafumpe',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(33.56857,-19.10185), 4326)
 )
;

select rn_copy_node(array[558000052], array[555030072]);
-- 559000052


insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000053,
 'station',
 'Bengo',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(33.60872,-19.07819), 4326)
 )
;

select rn_copy_node(array[558000053], array[555101325]);
-- 559000053


insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000054,
 'station',
 'Gondola',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(33.64641,-19.08593), 4326)
 )
;

select rn_copy_node(array[558000054], array[555086899]);
-- 559000054


insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000055,
 'station',
 'Amatongas',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(33.77379,-19.10011), 4326)
 )
;

select rn_copy_node(array[558000055], array[555029684]);
-- 559000055


insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000056,
 'station',
 'Inchope',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(33.88771,-19.19697), 4326)
 )
;

select rn_copy_node(array[558000056], array[555053195]);
-- 559000056

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000057,
 'station',
 'Jasse',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(33.99458,-19.23523), 4326)
 )
;

select rn_copy_node(array[558000057], array[555104849]);
-- 559000057


insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000058,
 'station',
 'Siluvo',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.02596,-19.24441), 4326)
 )
;

select rn_copy_node(array[558000058], array[555104792]);
-- 559000058


insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000059,
 'station',
 'Nharichonga',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.13134,-19.25688), 4326)
 )
;

select rn_copy_node(array[558000059], array[555053255]);
-- 559000059

update africa_osm_nodes
set name = 'Nhamatanda'
where oid = 555062965;


insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000060,
 'station',
 'Lamego',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.31680,-19.33225), 4326)
 )
;

select rn_copy_node(array[558000060], array[555102059]);
-- 559000060

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000061,
 'station',
 'Tica',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.43658,-19.40658), 4326)
 )
;

select rn_copy_node(array[558000061], array[555102010]);
-- 559000061

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000062,
 'station',
 'Ponte do Púngoè',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.52287,-19.47651), 4326)
 )
;

select rn_copy_node(array[558000062], array[555053220]);
-- 559000062

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000063,
 'station',
 'Mafambisse',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.61889,-19.54607), 4326)
 )
;

select rn_copy_node(array[558000063], array[555101237]);
-- 559000063

update africa_osm_nodes
set comment ='Satellite imagery indicates a station and platform at this location, it may not be known as Mafambisse station'
where oid = 559000063;

-- Beira-Bulawayo Railway (Dondo - Machipanda)

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            556130742,
		559000043,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beira-Bulawayo Railway (Dondo - Machipanda)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'There do not appear to be passenger services on this section of line currently. However, there are plans to refurbish stations and reinstate services. See: http://bit.ly/3xIEMNl. This line has be rehabilitated recently to improve freight speeds and wagon weight; see: https://bit.ly/3kinzYb and http://bit.ly/3Kvs641.'
where oid in (select edge from tmp);

-- Beira-Bulawayo Railway (Machipanda - Zimbabwe border)

update africa_osm_edges
set country = 'Mozambique'
where oid = 5550371382;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            559000043,
		559000022,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beira-Bulawayo Railway (Machipanda - Zimbabwe border)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'There do not appear to be passenger services on this section of line currently. However, there are plans to refurbish stations and reinstate services. See: http://bit.ly/3xIEMNl. This line has be rehabilitated recently to improve freight speeds and wagon weight; see: https://bit.ly/3kinzYb and http://bit.ly/3Kvs641.'
where oid in (select edge from tmp);

-- Various facilities in Beira port

-- terminal access

-- split 555017986 at 555095234
select rn_split_edge(array[555017986], array[555095234]);
-- split 555054879 at 555095230
-- split 555054875 at 555084816
-- split 555040030 at 555106137
-- split 555070274 at 555130444
-- split 555101552 at 555130445
select rn_split_edge(array[555054879,555054875,555040030,555070274,555101552], array[555095230,555084816,555106137,555130444,555130445]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555095234,
		555130445,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beira Port (access to terminals)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Beira fuel terminal (storage)
update africa_osm_nodes
set name = 'Beira Port - Fuel Terminal',
facility = 'Fuel terminal',
railway = 'stop',
comment = 'Storage. Various operators'
where oid = 555130072;

-- split 555054878 at 555106140
select rn_split_edge(array[555054878], array[555106140]);
-- split 555070277 at 555130071
select rn_split_edge(array[555070277], array[555130071]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555095230,
		555130072,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beira Port - Fuel Terminal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Beira Grain Terminal (https://www.cornelder.co.mz)
update africa_osm_nodes
set name = 'Beira Port - Grain Terminal',
facility = 'food storage',
railway = 'stop',
comment = 'https://www.cornelder.co.mz'
where oid = 555130446;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555130445,
		555130446,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beira Port - Grain Terminal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Beira Port (General Cargo Terminal)
update africa_osm_nodes
set name = 'Beira Port - General Cargo Terminal',
facility = 'port',
railway = 'stop',
comment = 'https://www.cornelder.co.mz'
where oid = 555043194;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555130445,
		555043194,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beira Port - General Cargo Terminal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Beira coal terminal (https://nectargroup.co.uk/case-study/beira-coal-terminal/)
update africa_osm_nodes
set name = 'Beira Port - Coal Terminal',
facility = 'port',
railway = 'stop',
comment = 'https://nectargroup.co.uk/case-study/beira-coal-terminal/'
where oid = 555095229;

-- freight spurs

-- Cement Plant, Inhaminga (Intercement Dondo)
update africa_osm_nodes
set name ='Cement Plant, Inhaminga (Intercement Dondo)',
railway = 'stop',
facility = 'manufacturing'
where oid = 555101949;

-- split 555102100 at 555130591

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555130591,
		555101949,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cement Plant, Inhaminga (Intercement Dondo)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Mafambisse Sugar Mill
update africa_osm_nodes
set name = 'Mafambisse Sugar Mill',
facility = 'food production',
railway = 'stop'
where oid = 555130731;

-- split 555101236 at 555101957
select rn_split_edge(array[555101236], array[555101957]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555101957,
		555130731,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mafambisse Sugar Mill',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555084816,
		555095229,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beira Port - Coal Terminal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Beira container terminal (https://www.cornelder.co.mz)
update africa_osm_nodes
set name = 'Beira Port - Container Terminal',
facility = 'port',
railway = 'stop',
comment = 'https://www.cornelder.co.mz'
where oid = 555017403;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555106137,
		555017403,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beira Port - Container Terminal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- additional stations on the Beira - Moatize line

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000064,
 'station',
 '',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.86124,-19.76062), 4326)
 )
;

select rn_copy_node(array[558000064], array[555017992]);
-- 559000064

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000065,
 'station',
 'Semacuesa',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.72379,-19.21182), 4326)
 )
;

select rn_copy_node(array[558000065], array[555065974]);
-- 559000065

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000066,
 'station',
 'Derunde',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.80663,-19.07415), 4326)
 )
;

select rn_copy_node(array[558000066], array[555065972]);
-- 559000066

update africa_osm_nodes
set name = 'Muanza'
where oid = 555026566;


insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000067,
 'station',
 'Condué',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.84447,-18.72312), 4326)
 )
;

select rn_copy_node(array[558000067], array[555065966]);
-- 559000067

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000068,
 'station',
 'Mazamba',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.95797,-18.58351), 4326)
 )
;

select rn_copy_node(array[558000068], array[5550659661]);
-- 559000068

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000069,
 'station',
 'Nangue',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(35.31925,-17.90177), 4326)
 )
;

select rn_copy_node(array[558000069], array[555053209]);
-- 559000069

update africa_osm_nodes
set name = 'Caia'
where oid = 555034356;

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000070,
 'station',
 'Murraça',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(35.25095,-17.70990), 4326)
 )
;

select rn_copy_node(array[558000070], array[555012112]);
-- 559000070


insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000071,
 'station',
 'Magagade',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(35.12587,-17.61942), 4326)
 )
;

select rn_copy_node(array[558000071], array[555012113]);
-- 559000071

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000072,
 'station',
 'Inharuca',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(35.05093,-17.49999), 4326)
 )
;

select rn_copy_node(array[558000072], array[555120290]);
-- 559000072

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000073,
 'station',
 'Chavandira',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(35.01608,-17.26534), 4326)
 )
;

select rn_copy_node(array[558000073], array[555050184]);
-- 559000073

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000074,
 'station',
 'Sinjal',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.90775,-17.03700), 4326)
 )
;

select rn_copy_node(array[558000074], array[555050189]);
-- 559000074

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000075,
 'station',
 'Chiueza',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.53257,-16.52025), 4326)
 )
;

select rn_copy_node(array[558000075], array[555050214]);
-- 559000075

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000076,
 'station',
 'Mecito',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.34032,-16.29471), 4326)
 )
;

select rn_copy_node(array[558000076], array[555050221]);
-- 559000076

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000077,
 'station',
 'Necungas',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.26463,-16.17139), 4326)
 )
;

select rn_copy_node(array[558000077], array[555055160]);
-- 559000077

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000078,
 'station',
 'Mecondezi',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(34.23648,-16.08679), 4326)
 )
;

select rn_copy_node(array[558000078], array[5550551602]);
-- 559000078

update africa_osm_nodes
set name = 'Cambulatsitsi'
where oid = 555031295;

-- add stations - Nacala - Cuamba line

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000079,
 'station',
 'Riane',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(37.76216,-15.00426), 4326)
 )
;

select rn_copy_node(array[558000079], array[555099779]);
-- 559000079

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000080,
 'station',
 'Outeiro',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(38.23099,-15.10361), 4326)
 )
;

select rn_copy_node(array[558000080], array[555059018]);
-- 559000080

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000081,
 'station',
 'Rente',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(38.51334,-14.99282), 4326)
 )
;

select rn_copy_node(array[558000081], array[555059028]);
-- 559000081

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000082,
 'station',
 'Muapaliua',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(38.74615,-14.90988), 4326)
 )
;

select rn_copy_node(array[558000082], array[555059041]);
-- 559000082

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000083,
 'station',
 'Multivaze',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(38.96358,-15.00286), 4326)
 )
;

select rn_copy_node(array[558000083], array[555117209]);
-- 559000083


-- Maputo port lines

-- Maputo

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555020778,
		555095353,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Maputo (in/out)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Limpopo Railway Maputo - Zimbabwe border

-- split 555095683 at 555103622
-- split 555078241 at 555103621
select rn_split_edge(array[555095683,555078241], array[555103622,555103621]);

update africa_osm_nodes
set name = 'Chicualacuala',
railway = 'station'
where oid = 555080707;

-- split 555086981 at 555113104
select rn_split_edge(array[555086981], array[555113104]);
-- split 5550869812 at 555113108
-- split 555078221 at 555113109
select rn_split_edge(array[5550869812,555078221], array[555113108,555113109]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555113109,
		555083219,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Limpopo Railway (Maputo - Chicualacuala)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services, see: http://bit.ly/3Z3521e'
where oid in (select edge from tmp);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555103622,
		555080707,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Limpopo Railway (Maputo - Chicualacuala)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services, see: http://bit.ly/3Z3521e'
where oid in (select edge from tmp);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555080707,
		555044850,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Limpopo Railway (Chicualacuala -  Zimbabwe border)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'No direct passenger trains across the border - necessary to cross border by foot. See: http://bit.ly/41la7TW'
where oid in (select edge from tmp);

-- Ressano Garcia Line (Maputo - Ressano Garcia (SA Border))
-- have to walk to Komatipoort station in SA - no cross border passenger trains.
-- see: https://www.seat61.com/Mozambique.htm

-- copy ressano garcia station
select rn_copy_node(array[555062380], array[555101320]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555095353,
		556062380,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ressano Garcia Line (Maputo - Ressano Garcia)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services, see: http://bit.ly/3Z3521e'
where oid in (select edge from tmp);

-- add node for border with SA
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000084,
 null,
 null,
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(31.98728,-25.43914), 4326)
 )
;

select rn_copy_node(array[558000084], array[555016141]);
-- 559000084

update africa_osm_edges
set country = 'Mozambique'
where oid = 5550161411;


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             556062380,
		559000084,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ressano Garcia Line (Ressano Garcia - SA Border)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'No direct passenger trains across the border - necessary to cross border by foot. See: http://bit.ly/3ZdLxm7 . Freight can cross border, see: https://bit.ly/3kluKPl'
where oid in (select edge from tmp);

-- Goba line
  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555095353,
		555016503,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Goba line (Maputo - Goba)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services, see: http://bit.ly/3Z3521e'
where oid in (select edge from tmp);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555016503,
		555078710,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Goba line (Goba - Eswatini border)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Freight only across border. See: https://bit.ly/3kluKPl'
where oid in (select edge from tmp);

-- Salamanga branch line
-- freight only

update africa_osm_nodes
set name = 'Salamanga limestone quarry',
railway = 'stop',
facility = 'quarry'
where oid = 555083227;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555083225,
		555083227,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Salamanga Branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Maputo Port

-- split 5550956831 at 555091423
select rn_split_edge(array[5550956831], array[555091423]);
-- split 555049550 at 555103620
select rn_split_edge(array[555049550], array[555103620]);
-- split 555067621 at 555103623
select rn_split_edge(array[555067621], array[555103623]);
-- split 555078240 at 555103631
select rn_split_edge(array[555078240], array[555103631]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555091423,
		555103631,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Maputo Port (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Maputo Port (Container Terminal)

-- simplify missing line

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000085,
 null,
 null,
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(32.54824,-25.95847), 4326)
 )
;

select rn_insert_edge(555103631, 558000085, 556000081);

update africa_osm_nodes
set name = 'Maputo Port (Container Terminal)',
facility = 'port',
railway = 'stop'
where oid = 558000085;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555103631,
		558000085,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Maputo Port (Container Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Maputo Port (Ferrochrome Terminal)

update africa_osm_nodes
set name = 'Maputo Port (Ferrochrome Terminal)',
facility = 'port',
railway = 'stop'
where oid = 555027831;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555103631,
		555027831,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Maputo Port (Ferrochrome Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Maputo Port (Sugar Terminal)

update africa_osm_nodes
set name = 'Maputo Port (Sugar Terminal)',
facility = 'port',
railway = 'stop'
where oid = 555103624;

-- split 5550782401 at 555069353
select rn_split_edge(array[5550782401], array[555069353]);
-- split 555013107 at 555103625
select rn_split_edge(array[555013107], array[555103625]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555103631,
		555103624,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Maputo Port (Sugar Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Matola Port (access)

-- split 555067860 at 555095373
select rn_split_edge(array[555067860], array[555095373]);
-- split 555055169 at 555091425
-- split 555067862 at 555091426
select rn_split_edge(array[555055169,555067862], array[555091425,555091426]);
-- split 5550678622 at 555103824
select rn_split_edge(array[5550678622], array[555103824]);
-- split 55506786022 at 555091431
select rn_split_edge(array[55506786022], array[555091431]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555006411,
		555091430,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Matola Port (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Matola Coal Terminal

update africa_osm_nodes
set name = 'Matola Port (Coal Terminal)',
railway = 'stop',
facility = 'port'
where oid = 555095358;

-- split 555055173 at 555095372
select rn_split_edge(array[555055173], array[555095372]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555095373,
		555095358,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Matola Port (Coal Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Matola Bulk Terminal
-- https://www.portmaputo.com/port-info/matola-bulk-terminal/
-- Grain, Aluminium, Fuel

-- split 5550678602 at 555094183
select rn_split_edge(array[5550678602], array[555094183]	);

update africa_osm_nodes
set name = 'Matola Port (Bulk Terminal)',
railway = 'stop',
facility = 'port',
comment = 'Berths for Grain, aluminium and fuel. See: http://bit.ly/3Ize275'
where oid = 555022157;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555095373,
		555022157,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Matola Port (Bulk Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Matola Port (Grain Terminal -STEMA)

update africa_osm_nodes
set name = 'Matola Port Grain Terminal (STEMA)',
railway = 'stop',
facility = 'food storage'
where oid = 555091438;

-- split 555067861 at 555091430
select rn_split_edge(array[555067861], array[555091430]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555091431,
		555091438,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Matola Port (Grain Terminal -STEMA)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Fuel Terminal

update africa_osm_nodes
set name = 'Matola Port (Fuel Terminal)',
railway = 'stop',
facility = 'fuel terminal'
where oid = 555091420;

-- split 555049557 at 555091421
select rn_split_edge(array[555049557], array[555091421]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555091431,
		555091420,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Matola Port (Fuel Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- cement works
update africa_osm_nodes
set name = 'Matola Port (cement works - Cimentos de Moçambique)',
railway = 'stop',
facility = 'manufacturing'
where oid = 555103825;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555091430,
		555103825,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Matola Port (cement works - Cimentos de Moçambique)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- additional stations

-- Cabine B
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000086,
 'station',
 'Cabine B',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(32.54845,-25.95350), 4326)
 )
;

select rn_copy_node(array[558000086], array[555067625]);
-- 559000086

-- Infulene

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000087,
 'station',
 'Infulene',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(32.52828,-25.93680), 4326)
 )
;

select rn_copy_node(array[558000087], array[5550782211]);
-- 559000087

-- Machava
select rn_copy_node(array[555025670], array[5550551691]);
-- Beluluane
update africa_osm_nodes
set railway = 'station'
where oid = 555037490;

-- matola gare

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000088,
 'station',
 'Matola Gare',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(32.45093,-25.82881), 4326)
 )
;

select rn_copy_node(array[558000088], array[555016131]);
-- 559000088

-- Pessene Station

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000089,
 'station',
 'Pessene',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(32.34649,-25.69495), 4326)
 )
;

select rn_copy_node(array[558000089], array[555053316]);
-- 559000089

-- Movene
update africa_osm_nodes
set name = 'Movene',
railway = 'stop'
where oid = 555034827;

-- Movene
update africa_osm_nodes
set name = 'Incomati',
railway = 'stop'
where oid = 555034826;

-- Gare De Mercadorias
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000090,
 'station',
 'Gare De Mercadorias',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(32.59746,-25.92415), 4326)
 )
;

select rn_copy_node(array[558000090], array[555037839]);
-- 559000090

-- Bairro Ferroviário
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000091,
 'station',
 'Bairro Ferroviário',
 'Mozambique',
 null,
 null,
 ST_SetSRID(ST_Point(32.61369,-25.91644), 4326)
 )
;

select rn_copy_node(array[558000091], array[555016071]);
-- 559000091

update africa_osm_nodes
set railway = null
where oid = 555062414;

-- spurs

-- Stone quarry (Hipermaquinas Moc Lda)
update africa_osm_nodes
set name = 'Quarry (Hipermaquinas Moc Lda)',
railway = 'stop',
facility = 'quarry'
where oid = 555126623;

-- split 555037874 at 555126622
select rn_split_edge(array[555037874], array[555126622]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555126622,
		555126623,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Quarry (Hipermaquinas Moc Lda)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Cement works (Sunera cimentos LDA, Boane)
update africa_osm_nodes
set name = 'Cement works (Sunera cimentos LDA, Boane)',
facility = 'manufacturing',
railway = 'stop',
comment = 'Manufactures pozzolanic cement. See: https://www.suneracimentos.com'
where oid = 555094178;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555083228 ,
		555094178,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cement works (Sunera cimentos LDA, Boane)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- correct stations

-- cateme
select rn_copy_node(array[555027385], array[555078192]);
-- Cambulatsitsi
select rn_copy_node(array[555031295], array[55505516022]);
-- Sena
select rn_copy_node(array[555034955], array[555120276]);
-- Nhamatanda
select rn_copy_node(array[555062965], array[555053233]);
-- Chokwe
select rn_copy_node(array[555019330], array[555038767]);
-- Manhica
select rn_copy_node(array[555023246], array[555047730]);
-- Maputo
select rn_copy_node(array[555011565], array[555049537]);
-- Boane
select rn_copy_node(array[555031304], array[555037877]);
select rn_copy_node(array[], array[]);
select rn_copy_node(array[], array[]);
select rn_copy_node(array[], array[]);
select rn_copy_node(array[], array[]);
select rn_copy_node(array[], array[]);
select rn_copy_node(array[], array[]);


update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('Mozambique') and railway in ('station', 'halt', 'stop');

-- extract tables (backup)
create table mozambique_osm_edges as select * from africa_osm_edges where country in ('Mozambique');
create table mozambique_osm_nodes as select * from africa_osm_nodes where country in ('Mozambique');

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
			
			
			





























