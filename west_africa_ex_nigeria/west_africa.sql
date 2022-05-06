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


-- check gauge in these countries
update africa_osm_nodes
set gauge = '1435'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435'))
and country = and railway in ('station', 'halt', 'stop');

-- extract tables for Egypt (backup)
create table egypt_osm_edges as select * from africa_osm_edges where country ;
create table egypt_osm_nodes as select * from africa_osm_nodes where country ;

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
			




























