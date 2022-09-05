-- Cameroon

select railway, count(*) from africa_osm_nodes where country like '%Cameroon%' group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country like '%Cameroon%' group by railway order by count desc;

select status, count(*) from africa_osm_edges where country like '%Cameroon%' group by status order by count desc;

select type, count(*) from africa_osm_edges where country like '%Cameroon%' group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country like '%Cameroon%' and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country like '%Cameroon%' group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country like '%Cameroon%' group by gauge order by gauge desc;

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
 null,
 null,
 '',
 '',
 '',
 ST_SetSRID(ST_Point(), 4326)
 )
;


-- Yaoundé - Ngaoundéré
-- served by couchette (191/192) and omnibus (stopping train, 112/113)

update africa_osm_nodes
set railway = 'station',
name = 'Ngaoundéré'
where oid = 555023199;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555020119,
		555023199,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Yaoundé - Ngaoundéré',
mode = 'mixed',
type = 'conventional',
gauge = '1000',
status = 'open',
comment = 'served by couchette (191/192) and omnibus (stopping train, 112/113)'
where oid in (select edge from tmp);

-- Douala - Yaoundé
-- served by omnibus (stopping train, 103/104), 181/184 (limited stop) and Train Express (185/186, 5 stops only) 

update africa_osm_nodes
set railway = 'station',
name = 'Douala'
where oid = 555106821;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555106821,
		555020119,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Douala - Yaoundé',
gauge = '1000',
status = 'open',
mode = 'mixed',
type = 'conventional',
comment = 'served by omnibus (stopping train, 103/104), 181/184 (limited stop) and Train Express (185/186, 5 stops only)'
where oid in (select edge from tmp);


-- Douala - Kumba
-- omnibus (stopping service, 172-177)

-- routing out from Douala
-- split 555051997 at 555130504
select rn_split_edge(array[555051997], array[555130504]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555106821,
		555026956,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Douala - Kumba',
gauge = '1000',
status = 'open',
mode = 'mixed',
type = 'conventional',
comment = 'served by omnibus (stopping service, 172-177)'
where oid in (select edge from tmp);

-- Port of Douala

-- split 555017179 at 555093225
select rn_split_edge(array[555017179], array[555093225]);

-- containter terminal
update africa_osm_nodes
set railway = 'stop',
name = 'Port of Douala (Container Terminal)',
facility = 'container_port'
where oid = 555021616;

update africa_osm_nodes
set railway = 'stop',
name = 'Port of Douala (General Cargo)',
facility = 'container_port'
where oid = 555093232;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555130504,
		555021616,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Douala',
gauge = '1000',
status = 'open',
mode = 'freight',
type = 'conventional',
comment = ''
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555093230,
		555093232,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Douala (General Cargo)',
gauge = '1000',
status = 'open',
mode = 'freight',
type = 'conventional',
comment = ''
where oid in (select edge from tmp);

-- disused Ngoumou - Mbalmayo

-- split 555044993 at 555093061
select rn_split_edge(array[555044993], array[555093061]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555093061,
		555057982,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ngoumou - Mbalmayo',
gauge = '1000',
status = 'disused',
mode = 'mixed',
type = 'conventional',
comment = ''
where oid in (select edge from tmp);

-- stations fixes

-- Dibamba
select rn_copy_node(array[555028436], array[555023755]);
-- Lungahé
select rn_copy_node(array[555028439], array[555023760]);
-- Edéa Croisement
select rn_copy_node(array[555062873], array[555085505]);
-- Gare voyageur de Messondo
select rn_copy_node(array[555040702], array[555066934]);
-- Eséka
select rn_copy_node(array[555028426], array[555070238]);
-- Minloh-Maloume
select rn_copy_node(array[555028445], array[555045172]);
-- Makak
-- Ngaoundal
update africa_osm_nodes
set railway = 'station'
where oid IN (555023207, 555023195);

-- Oweng
select rn_copy_node(array[555028461], array[555044995]);
-- Makor
select rn_copy_node(array[555024569], array[555071058]);
-- Mbargué
select rn_copy_node(array[555033373], array[555063362]);
-- Gare de Mengue Bibey
select rn_copy_node(array[555033371], array[555050778]);
-- Nanga Eboko
select rn_copy_node(array[555026391], array[555050018]);
-- Mbandjock
select rn_copy_node(array[555027618], array[555083494]);
-- Batchenga
select rn_copy_node(array[555033378], array[555050007]);
-- Gare d'Obala
select rn_copy_node(array[555024568], array[555050009]);

update africa_osm_nodes
set gauge = '1000'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1000'))
and country ='Cameroon' and railway in ('station', 'halt', 'stop');

-- extract tables for Egypt (backup)
create table cameroon_osm_edges as select * from africa_osm_edges where country = 'Cameroon';
create table cameroon_osm_nodes as select * from africa_osm_nodes where country = 'Cameroon';

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555026956,
		556024569,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			




























