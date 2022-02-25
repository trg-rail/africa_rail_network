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

-- facilities

-- ports
update africa_osm_nodes
set railway = 'stop',
name = 'International Container Terminal',
facility = 'container_port'
where oid = 555083287;



-- psql code to fix routing issue. Splits edge at node.
-- allow routing out of Tanger Ville for LGV
-- split 88425 @ 77371
-- split 884251 (from above) @ 74354
--allow accessto/from Tanger-Med line
-- split 555032587 @ 555101620
-- split 555091026 @ 555123363
-- allow access from Tanger-Med line to the old (non HST) Tanger -> Kenitra line



DO $$ DECLARE
-- edges INT8 ARRAY DEFAULT ARRAY [555088425, 5550884251, 555032587, 555091026, 5550910261];
 -- nodes INT8 ARRAY DEFAULT ARRAY [555077371, 555074354, 555101620, 555123363, 555101619];
edges INT8 ARRAY DEFAULT ARRAY [5550910261];
nodes INT8 ARRAY DEFAULT ARRAY [555101619];
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

-- Merged lines approach to Tanger Ville
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555063041,
		555078810,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Enter/exit Tanger Ville ',
gauge = '1435',
speed_passenger = null,
comment = 'Shared enter/exit Tanger Ville'
where oid in (select edge from tmp);

-- LGV dedicated line from Tanger Ville to just outside Kenitra
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555078810,
		555103675,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ligne à Grande Vitesse [LGV] Tanger - Kénitra',
gauge = '1435',
speed_passenger = 320,
comment = 'Dedicated high speed line. Operating speed 320 km/h. Electrified.'
where oid in (select edge from tmp);


-- Add link to simplify routing -> Tanger Med line access to Tanger Ville approach; connect node 76904 to node 78810 
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555076904 and b.oid = 555078810
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555076904,
555078810,
556000000
from tmp as a;

-- Line from Tanger Ville to Tanger Med station
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555078810,
		555062367,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tanger - Tanger-Med',
gauge = '1435',
comment = 'Open now to passengers, see: https://en.wikipedia.org/wiki/Tanger-Med'
where oid in (select edge from tmp);

-- Line from Tanger-Med to Tanger-Med Port
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555062367,
		555083287,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tanger-Med - Tanger-Med Port',
gauge = '1435',
mode = 'freight'
where oid in (select edge from tmp);

-- Add link to simplify routing -> Tanger Ville approach to the old (not high speed) Tanger - Kenitra line connect node 555078810 to 555134163
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555078810 and b.oid = 555134163
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555078810,
555134163,
556000001
from tmp as a;


-- Line from Tanger-Med to join line South to Kenitra
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555101620,
		555101619,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tanger - Tanger-Med',
gauge = '1435'
where oid in (select edge from tmp);

-- Tanger to Mechraa Bel Ksiri (old slow line)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555101619,
		555078798,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tanger to Mechraa Bel Ksiri',
gauge = '1435',
comment = 'the old (not HST) Tanger to Kenitra line'
where oid in (select edge from tmp);

