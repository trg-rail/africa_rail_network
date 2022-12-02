-- Angola

select railway, count(*) from africa_osm_nodes where country in ('Angola') group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country in ('Angola') group by railway order by count desc;

select status, count(*) from africa_osm_edges where country in ('Angola') group by status order by count desc;

select type, count(*) from africa_osm_edges where country in ('Angola') group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country in ('Angola') and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country in ('Angola') group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country in ('Angola') group by gauge order by gauge desc;


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




update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('Angola') and railway in ('station', 'halt', 'stop');

update africa_osm_nodes
set gauge = '1000'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1000'))
and country in ('Angola') and railway in ('station', 'halt', 'stop');

-- extract tables (backup)
create table angola_osm_edges as select * from africa_osm_edges where country in ('Angola');
create table angola_osm_nodes as select * from africa_osm_nodes where country in ('Angola');

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
			
			
			





























