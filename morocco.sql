-- Morocco

select railway, count(*) from africa_osm_nodes where country like '%Morocco%' group by railway order by count desc;
select railway, count(*) from africa_osm_nodes where name is not null and country like '%Morocco%' group by railway order by count desc;

select railway, count(*) from africa_osm_edges where country like '%Morocco%' group by railway order by count desc;
select name, railway, count(*) from africa_osm_edges where country like '%Morocco%' group by name, railway  order by count desc;
select bridge, count(*) from africa_osm_edges where country like '%Morocco%' group by bridge order by count desc;


-- set additional node for stations
update africa_osm_nodes
set name = 'Tanger Ville',
railway = 'station'
where oid = 63041;


-- psql code to fix routing issue. Splits edge at node.
-- allow routing out of Tanger Ville
-- split 88425 @ 74354



DO $$ DECLARE
 --edges INT ARRAY DEFAULT ARRAY [88425];
 --nodes INT ARRAY DEFAULT ARRAY [];
edges INT ARRAY DEFAULT ARRAY [88425];
nodes INT ARRAY DEFAULT ARRAY [];
edge INT;
node INT;
BEGIN
		for edge, node in select unnest(edges), unnest(nodes)
		LOOP
		raise notice'counter: %', edge || ' ' || node;
	insert into africa_osm_edges with tmp as (select a.*, (st_dump(st_split(a.geom, b.geom))).geom as geom2 from africa_osm_edges a, africa_osm_nodes b where a.oid = edge and b.oid = node),
	tmp2 as (select geom2 as geom, country, length, ( oid :: text || row_number ( ) over ( ) ) :: int as oid, line, gauge, status, type, mode, structure, speed_freight, speed_passenger, comment, st_startpoint ( geom2 ), st_endpoint ( geom2 ) from tmp ) select 
	a.geom,
	a.country,
	round( st_length ( st_transform ( a.geom, 32736 ) ) :: numeric, 2 ) as length,
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
                63041,
		134163,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Makadara-Nanyuki'
where oid in (select edge from tmp);