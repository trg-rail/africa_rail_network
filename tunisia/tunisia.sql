-- Tunisia

select railway, count(*) from africa_osm_nodes where country like '%Tunisia%' group by railway order by count desc;
select railway, count(*) from africa_osm_nodes where name is not null and country like '%Tunisia%' group by railway order by count desc;

select status, count(*) from africa_osm_edges where country like '%Tunisia%' group by status order by count desc;
select type, count(*) from africa_osm_edges where country like '%Tunisia%' group by type order by count desc;
select line, status, count(*) from africa_osm_edges where country like '%Tunisia%' and line is not null group by line, status order by count desc;
select structure, count(*) from africa_osm_edges where country like '%Tunisia%' group by structure order by count desc;
select gauge, count(*) from africa_osm_edges where country like '%Tunisia%' group by gauge order by gauge desc;


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

-- update where duplicate station nodes
update africa_osm_nodes
set name = NULL,
railway = NULL,
gauge =  NULL,
facility = NULL
where oid in ()


-- ports
update africa_osm_nodes
set railway = 'stop',
name = '',
facility = 'port'
where oid = ;

-- mines / industrial etc

update africa_osm_nodes
set railway = 'stop',
name = '',
facility = 'mine'
where oid = ;

-- industrial zones

update africa_osm_nodes
set railway = 'stop',
name = '',
facility = 'Industrial zone'
where oid = ;

-- create new nodes for stations that don't currently have a node or a suitable alternative
-- these then need to be located on the correct edge using the procedure below

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 557000000,
 'station',
 '',
 'Tunisia',
 '',
 '',
 ST_SetSRID(ST_Point(,), 4326)
 )
;

SELECT ST_SetSRID( ST_Point(8.00607,35.66806), 4326)

-- create new station (or other) nodes
-- this is required as there can be several edges running through stations but the station node
-- is located on an edge that isn't used for the route.

DO $$ DECLARE
-- create new station nodes
-- note: must not be a node coincident with the closest point (reassign that node as a station instead)
-- nodes INT8 ARRAY DEFAULT ARRAY [];
-- edges INT8 ARRAY DEFAULT ARRAY [];
nodes INT8 ARRAY DEFAULT ARRAY [];
edges INT8 ARRAY DEFAULT ARRAY [];
node INT8;
edge INT8;
idx INT;
closest_point GEOMETRY;
newline GEOMETRY;
orsource int8;
ortarget int8;
BEGIN
		for node, edge in select unnest(nodes), unnest(edges)
		LOOP

-- want a new station node on the nearest point on the required edge and split the edge for routing
-- find index of nearest segment to the point in the line. We want to insert a new point (vertex) into the line so we can split it at the station
-- use function ST_LineLocateN
SELECT ST_LineLocateN(e.geom, n.geom) from africa_osm_nodes n, africa_osm_edges e where n.oid = node and e.oid = edge
into idx;
-- closest point
select ST_ClosestPoint(e.geom, n.geom) from africa_osm_nodes n, africa_osm_edges e where n.oid = node and e.oid = edge into closest_point;
-- new line geometry with added point
select ST_AddPoint(e.geom, closest_point, idx) from africa_osm_edges e where e.oid = edge into newline;
-- original source and target
select target from africa_osm_edges where oid = edge into ortarget;
select source from africa_osm_edges where oid = edge into orsource;

raise notice 'counter: %', node || ' ' || edge || ' ' || idx || ' ' || orsource || ' ' || ortarget ;	

-- create new node for station
INSERT INTO africa_osm_nodes (name, geom, railway, country, oid)
SELECT name, closest_point, railway, country, oid + 1000000
FROM africa_osm_nodes
WHERE oid = node;
 
insert into africa_osm_edges 
with tmp as ( select a.*, ( st_dump ( st_split ( newline, closest_point ) ) ).geom as geom2 from africa_osm_edges a where oid = edge ),
	tmp2 as ( select geom2 as geom, country, length, ( oid :: text || row_number ( ) over ( ) ) :: int8 as oid, line, gauge, status, type, mode, structure, speed_freight, speed_passenger, comment, st_startpoint ( geom2 ), st_endpoint ( geom2 ) from tmp ) select
	a.geom,
	a.country,
	round(st_lengthspheroid(a.geom, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2 ) as length,
	b.oid as source,
	c.oid as target,
	a.oid,
	a.line,
	a.gauge,
	a.status,
	a.type,
	a.mode,
	a.structure,
	a.speed_freight,
	a.speed_passenger,
	a.comment
	from
		tmp2 a JOIN africa_osm_nodes b ON st_dwithin( b.geom, a.st_startpoint, .000000001 )
		-- need st_dwithin rather than st_intersects 
		JOIN africa_osm_nodes c ON st_dwithin ( c.geom, a.st_endpoint, .00000000001 )
		-- there can be additional nodes than the original target and source nodes at the original line end /start points
		-- so have to limit results 
		where b.oid in (ortarget, orsource) or c.oid in (ortarget,orsource)
	;
	
	-- delete the original edge
	delete 
	from
	africa_osm_edges 
	where
	oid = edge;
	
	-- delete original station node
	-- don't think will do that, will just select the station nodes that intersect the required routes.
	-- delete 
	-- from
	-- africa_osm_nodes 
	-- where
	-- oid = node;
	

END LOOP;
END $$;

-- psql code to fix routing issue. Splits edge at node.

DO $$ DECLARE
-- edges INT8 ARRAY DEFAULT ARRAY [];
 -- nodes INT8 ARRAY DEFAULT ARRAY [];
edges INT8 ARRAY DEFAULT ARRAY [];
nodes INT8 ARRAY DEFAULT ARRAY [];
edge int8;
node int8;
BEGIN
		for edge, node in select unnest(edges), unnest(nodes)
		LOOP
		raise notice'counter: %', edge || ' ' || node;
	insert into africa_osm_edges with tmp as (select a.*, (st_dump(st_split(a.geom, b.geom))).geom as geom2 from africa_osm_edges a, africa_osm_nodes b where a.oid = edge and b.oid = node),
	tmp2 as (select geom2 as geom, country, length, ( oid :: text || row_number ( ) over ( ) ) :: int8 as oid, line, gauge, status, type, mode, structure, speed_freight, speed_passenger, comment, st_startpoint ( geom2 ), st_endpoint ( geom2 ) from tmp ) select 
	a.geom,
	a.country,
	round(st_lengthspheroid(a.geom, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2 ) as length,
	b.oid as source,
	c.oid as target,
	a.oid,
	a.line,
	a.gauge,
	a.status,
	a.type,
	a.mode,
	a.structure,
	a.speed_freight,
	a.speed_passenger,
	a.comment 
	from
		tmp2
		a JOIN africa_osm_nodes b ON st_intersects ( b.geom, a.st_startpoint )
		JOIN africa_osm_nodes c ON st_intersects ( c.geom, a.st_endpoint );
	delete 
	from
		africa_osm_edges 
	where
		oid = edge;
END LOOP;
END $$;

-- update line information

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                ,
		,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = '',
gauge = '',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);


update africa_osm_nodes
set gauge = '1435'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435'))
and railway in ('station', 'halt', 'stop');

-- extract tables for tunisia (backup)
create table tunisia_osm_edges as select * from africa_osm_edges where country like '%Tunisia%';
create table tunisia_osm_nodes as select * from africa_osm_nodes where country like '%Tunisia%';
