-- Gabon

select railway, count(*) from africa_osm_nodes where country = 'Gabon' group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country = 'Gabon' group by railway order by count desc;

select status, count(*) from africa_osm_edges where country = 'Gabon' group by status order by count desc;

select type, count(*) from africa_osm_edges where country = 'Gabon' group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country = 'Gabon' and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country = 'Gabon' group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country = 'Gabon' group by gauge order by gauge desc;

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



-- Trans-Gabon Railway

-- copy Owendon station to another edge
select rn_copy_node(array[555022945], array[555094368]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              556022945,
		555017527,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Trans-Gabon Railway',
mode = 'mixed',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'Single track'
where oid in (select edge from tmp);

-- Owendo port

-- split 555025328 at 555125285
select rn_split_edge(array[555025328], array[555125285]);

-- Owendo Port 555075602
update africa_osm_nodes
set name = 'Port of Owendo',
facility = 'port',
railway = 'stop'
where oid = 555075602;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              556022945,
		555075602,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Owendo',
mode = 'freight',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Moanda Mine (Manganese)

update africa_osm_nodes
set name = 'Moanda Mine (Manganese)',
railway = 'stop',
facility = 'mine'
where oid = 555104826;

-- split 555083184 at 555104827
-- split 555057990 at 555130808
select rn_split_edge(array[555083184, 555057990], array[555104827, 555130808]);
-- split 5550579902 at 555117099
select rn_split_edge(array[5550579902], array[555117099]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555130808,
		555104826,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Moanda Mine',
mode = 'freight',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- update/copy stations as required
-- Andem
select rn_copy_node(array[555034875], array[555098687]);
-- Gare d'Abanga
select rn_copy_node(array[555034874], array[555120025]);
-- Gare de Bissouma
select rn_copy_node(array[555034889], array[555098678]);
-- Gare de Ayem
select rn_copy_node(array[555034873], array[555087395]);
-- Gare de La Lopé
select rn_copy_node(array[555034879], array[555087376]);
-- Gare d'Offoué
select rn_copy_node(array[555034878], array[555087378]);
-- Gare de Lastoursville
select rn_copy_node(array[555034882], array[555102465]);
-- Gare de Moanda
select rn_copy_node(array[555033246], array[55505799021]);


update africa_osm_nodes
set gauge = '1435'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435'))
and country ='Gabon' and railway in ('station', 'halt', 'stop');

-- extract tables for Egypt (backup)
create table gabon_osm_edges as select * from africa_osm_edges where country = 'Gabon';
create table gabon_osm_nodes as select * from africa_osm_nodes where country = 'Gabon';

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
			




























