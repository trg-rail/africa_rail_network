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

update africa_osm_nodes
set name = 'Marrakech مراكش',
railway = 'station'
where oid = 555134634;

update africa_osm_nodes
set name = 'Gare d''El Jadida',
railway = 'station'
where oid = 555074025;

update africa_osm_nodes
set name = 'Gare de Sidi Bouknadel',
railway = 'station'
where oid = 555062472;


-- Taourirt - current railway value platform
update africa_osm_nodes
set railway = 'station'
where oid = 555035422;

update africa_osm_nodes
set name = 'Bouarfa',
railway = 'station'
where oid = 555107745;

-- add latin name where just arabic (if available)

update africa_osm_nodes
set name = 'Nzalat Laadam نزالة العظم',
railway = 'station'
where oid = 555027384;

update africa_osm_nodes
set name = 'Sidi Bou Othmane بوناكة',
railway = 'station'
where oid = 555007958;



-- set names where missing
update africa_osm_nodes
set name = 'Skhour Rhamna',
railway = 'station'
where oid = 555027383;

update africa_osm_nodes
set name = 'Sidi Abdallah',
railway = 'station'
where oid = 555007962;

update africa_osm_nodes
set name = 'unnamed',
railway = 'station'
where oid in (555037821, 555021325, 555022954, 555013399, 555025695);

update africa_osm_nodes
set name = 'Souaken',
railway = 'station'
where oid = 555025149;

update africa_osm_nodes
set name = 'Bab Tissera',
railway = 'station'
where oid = 555021322;

update africa_osm_nodes
set name = 'Ain Karma',
railway = 'station'
where oid = 555033248;

update africa_osm_nodes
set name = 'Fes Ville',
railway = 'station'
where oid = 555035429;

update africa_osm_nodes
set name = 'Touabaa',
railway = 'station'
where oid = 555025802;

update africa_osm_nodes
set name = 'Oued Amlil'
where oid = 555046416;

update africa_osm_nodes
set name = 'Nouaceur',
railway = 'station'
where oid = 556031481;


-- facilities

-- mines / industrial etc

-- OCP Phosphate mine, Benguerir
update africa_osm_nodes
set railway = 'stop',
name = 'OCP Benguerir (Phosphate Mine)',
facility = 'mine'
where oid = 555076761;

update africa_osm_nodes
set railway = 'stop',
name = 'OCP Youssoufia (Phosphate Mine)',
facility = 'mine'
where oid = 555132339;

update africa_osm_nodes
set railway = 'stop',
name = 'OCP Khouribga (Phosphate Mine)',
facility = 'mine'
where oid = 555077215;

update africa_osm_nodes
set railway = 'stop',
name = 'OCP Safi (Phosphate processing plant)',
facility = 'chemical_plant'
where oid = 555071248;

update africa_osm_nodes
set railway = 'stop',
name = 'Ben Guerir Air Base',
facility = 'military'
where oid = 555063407;

update africa_osm_nodes
set railway = 'stop',
name = 'Renault-Nissan Group',
facility = 'manufacturing'
where oid = 555089774;

update africa_osm_nodes
set railway = 'stop',
name = 'LafargeHolcim Maroc cement works (Fes)',
facility = 'manufacturing'
where oid = 555079035;

update africa_osm_nodes
set railway = 'stop',
name = 'LafargeHolcim Maroc cement works (Meknes)',
facility = 'manufacturing'
where oid = 555117768;

update africa_osm_nodes
set railway = 'stop',
name = 'Sonasid steel works',
facility = 'manufacturing'
where oid = 555090096;

update africa_osm_nodes
set railway = 'stop',
name = 'Jerada Power Station',
facility = 'utilities'
where oid = 555100350;

-- ports
update africa_osm_nodes
set railway = 'stop',
name = 'Tangor Container Port',
facility = 'container_port'
where oid = 555083287;

update africa_osm_nodes
set railway = 'stop',
name = 'Port of Jorf Lasfar',
facility = 'port'
where oid = 555118287;

update africa_osm_nodes
set railway = 'stop',
name = 'Port of Safi',
facility = 'port'
where oid = 555101363;

update africa_osm_nodes
set railway = 'stop',
name = 'Beni Nsar (Nadar) Port',
facility = 'port'
where oid = 555121673;

update africa_osm_nodes
set railway = 'stop',
name = 'Port of Casablanca',
facility = 'port'
where oid = 555118206;



-- create new station nodes
-- this is required as there can be several edges running through stations but the station node
-- is located on an edge that isn't used for the route.
-- Taourirt 
-- Chtouka
-- Nouaceur
-- Khouribga
-- Mers Sultan
-- Casa Voyageurs
-- Ain-Sebaa
-- Tangier Morora

DO $$ DECLARE
-- create new station nodes
-- note: must not be a node coincident with the closest point (reassign that node as a station instead)
--nodes INT8 ARRAY DEFAULT ARRAY [555028771, 8283175981, 555031481, 555024932, 555007318, 555048489, 555062408, 555062153];
--edges INT8 ARRAY DEFAULT ARRAY [555084158, 555089696, 555004426, 555084551, 555004329, 555103683, 555004392, 555084807];
nodes INT8 ARRAY DEFAULT ARRAY [555062153];
edges INT8 ARRAY DEFAULT ARRAY [555084807];
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
-- allow routing out of Tanger Ville for LGV
-- split 88425 @ 77371
-- split 884251 (from above) @ 74354
-- allow accessto/from Tanger-Med line
-- split 555032587 @ 555101620
-- split 555091026 @ 555123363
-- allow access from Tanger-Med line to the old (non HST) Tanger -> Kenitra line
-- split 555084141 @ 555117940
-- allow route out of Fes station
-- allow route into Casa Port
-- split 555034342 @ 555120820
-- route from Rabat Agdal towards Temara
-- split 555030256 @ 555128402
-- routing into Jorf Lasfar port
-- split 555029415 @ 555118290
-- split 555013654 @ 555078433
-- routing freight line from OCP Mine at Benguerir to Safi Port
-- split 555023792 @ 555076760
-- routing freight line Khouribga
-- split 555084552 @ 555077214
-- routing freight at Port of Casa
-- split 555084178 @ 555118167
-- routing to Renault-Nissan Factory
-- split 555032589 @ 555089775
-- LafargeHolcim Maroc cement works (Fes)
-- split 555084194 @ 555117922
-- split 555084138 @ 555079034
-- LafargeHolcim Maroc cement works (Meknes)
-- split 555029717 @ 555115192
-- Jerada branch
-- split 555030005 @ 555100535 
-- split 5550300052 @ 555078983


DO $$ DECLARE
-- edges INT8 ARRAY DEFAULT ARRAY [555088425, 5550884251, 555032587, 555091026, 5550910261, 555084141, 555034342, 555030256, 555029415, 555013654, 555023792, 555084552, 555084178, 555032589, 555084194, 555084138, 555029717, 555030005, 5550300052];
 -- nodes INT8 ARRAY DEFAULT ARRAY [555077371, 555074354, 555101620, 555123363, 555101619, 555117940, 555120820, 555128402, 555118290, 555078433, 555076760, 555077214, 555118167, 555089775, 555117922, 555079034, 555115192, 555100535, 555078983];
edges INT8 ARRAY DEFAULT ARRAY [5550300052];
nodes INT8 ARRAY DEFAULT ARRAY [555078983];
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

-- additional edge approach to Kenitra join to non-hst line
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555103675 and b.oid = 555126426
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555103675,
555126426,
556000004
from tmp as a;

-- LGV dedicated line from Tanger Ville to just outside Kenitra
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555078810,
		555126426,
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

-- New edge for route into Kenitra
-- link 555079666 to 555123352
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555079666 and b.oid = 555123352
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555079666,
555123352,
556000002
from tmp as a;

-- Mechraa Bel Ksiri to Kenitra (old slow line)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555078798,
		555062822,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mechraa Bel Ksiri to Kenitra',
gauge = '1435',
comment = 'the old (not HST) Tanger to Kenitra line'
where oid in (select edge from tmp);

-- Sidi Yahya to Sidi Kacem 
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555078796,
		555078775,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sidi Yahya to Sidi Kacem',
gauge = '1435',
comment = ''
where oid in (select edge from tmp);

-- correct error edge 555084197
-- doublebacks on itself to node 555117994 which is the target node
-- rather than node 555100319
-- need to remove point 25
UPDATE africa_osm_edges
	SET geom = ST_RemovePoint(geom, 25),
	target = 555100319
	WHERE oid = 555084197;

-- Mechraa Bel Ksiri to Oujda
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555078798,
		555062419,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mechraa Bel Ksiri to Oujda',
gauge = '1435',
comment = ''
where oid in (select edge from tmp);

-- Oujda to Algerian Border (to Zoudj Bghal station)
-- disused
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555062419,
		555025503,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oujda to Zoudj Bghal (Algeria)',
gauge = '1435',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- get vertives for edge to insert Boufra station node
-- create table temp3 as (
-- select (ST_DumpPoints(geom)).path as path, oid, (ST_DumpPoints(geom)).geom FROM africa_osm_edges
-- where oid = 555072327;
-- )

-- Oujda to Bouarfa (freight only plus occassional tourist Oriental Destert Express)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555062419,
		555107745,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oujda to Bouarfa',
gauge = '1435',
status = 'open',
comment = 'Freight only except for the occasional private tourist service - the Oriental Desert Express',
mode = 'freight'
where oid in (select edge from tmp);

-- Taourirt to Beni Nsar Port (Nador Port)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555078945,
		555021120,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Taourirt to Beni Nsar Port (Nador Port)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);

-- Beni Nsar Port (Nador Port) Freight Terminal
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555068598,
		555121673,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beni Nsar Port (Nador Port) Freight Terminal',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- Kenitra to Casa Port
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555062822,
		555021845,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kenitra to Casa Port',
gauge = '1435',
status = 'open',
comment = 'Route of Train Navette Rapide (TNR) service',
mode = 'mixed'
where oid in (select edge from tmp);


-- simplify routing at Sidi el Aidi for line to Marrakech and branch to Wad Zam
-- link 555028771 with 555033618

with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555028771 and b.oid = 555033618
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555028771,
555033618,
556000003
from tmp as a;

-- Casablanca to Marrakech
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555065206,
		555134634,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Casablanca to Marrakech',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);

-- Bouskoura to Mohammed V International Airport
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
         555065257,
		555021757,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bouskoura to Mohammed V International Airport',
gauge = '1435',
status = 'open',
comment = 'Part fo TNR Al Bidaoui (Casablanca - Mohammed V International Airport',
mode = 'mixed'
where oid in (select edge from tmp);

-- Bouskoura to El Jadida
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
         555081547,
		555074025,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bouskoura to El Jadida',
gauge = '1435',
status = 'open',
comment = 'Part of TNR Casablanca - El Jadida route',
mode = 'mixed'
where oid in (select edge from tmp);


-- El Jadida to Port of Jorf Lasfar
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
         555074025,
		555118287,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'El Jadida to Port of Jorf Lasfar',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);


-- Need to edit edge 555032067 and amend the first coordinate (source) to be
-- node 556028771 rather than 555028771 to simplify routing to Oued Zem.

UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, 0, (select geom from africa_osm_nodes where oid = 556028771)),
	source = 556028771
	WHERE oid = 555032067;

-- Sidi el Aidi to Oued Zem
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
        556028771,
		555028772,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sidi el Aidi to Oued Zem',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);

-- Need to edit edge 555023792 and amend the last coordinate (target) to be
-- node 555020393 rather than 555074682 to simplify routing to Safi branch line.

UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, ST_NumPoints(geom) - 1, (select geom from africa_osm_nodes where oid = 555020393)),
	target = 555020393
	WHERE oid = 555023792;

-- Ben Guerir to Safi
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
        555020393,
		555028588,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ben Guerir to Safi',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);

-- Safi to Port of Safi
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
        555028588,
		555101363,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Safi to Port of Safi',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);


-- OCP Mine (Benguerir) to Safi line
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
        555076761,
		555076760,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'OCP Mine (Benguerir) to Safi line',
gauge = '1435',
status = 'open',
comment = 'OCP Phosphate mines. Freight route to Safi Port',
mode = 'freight'
where oid in (select edge from tmp);

-- OCP Phosphate Processing plant
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
        555077822,
		555071248,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'OCP phosphate processing plant',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- Benguerir Air Base
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
        555063406,
		555063407,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Benguerir Air Base',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- OCP Youssoufia Mine
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
        555101617,
		555132339,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'OCP Youssoufia Mine',
gauge = '1435',
status = 'open',
comment = 'OCP Phosphate mines',
mode = 'freight'
where oid in (select edge from tmp);

-- OCP Khouribga Mine
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
       555077214,
		555077215,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'OCP Khouribga Mine',
gauge = '1435',
status = 'open',
comment = 'OCP Phosphate mines',
mode = 'freight'
where oid in (select edge from tmp);

-- Freight line to Port of Casa
-- link to simplify routing
-- 555118161 to 555118159
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555118161 and b.oid = 555118159
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555118161,
555118159,
556000005
from tmp as a;

-- Port of Casablanca (Freight)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
       555118161,
		555118206,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Casablanca',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- Renault-Nissan Group (Freight)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
       555089775,
		555089774,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Renault-Nissan Group Factory',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- LafargeHolcim Maroc cement works (Fes)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
       555081212,
		555079035,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'LafargeHolcim Maroc cement works (Fes)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- LafargeHolcim Maroc cement works (Meknes)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
       555115192,
		555117768,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'LafargeHolcim Maroc cement works (Meknes)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);

-- link 555090095 to 555020067
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555090095 and b.oid = 555020067
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555090095,
555020067,
556000006
from tmp as a;


-- Sonasid steel works (Nador)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
       555020067,
		555090096,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sonasid steel works (Nador)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);


-- Guenfouda to Jerada branch
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
       555100535,
		555100350,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Guenfouda to Jerada branch (Jerada Power Station)',
gauge = '1435',
status = 'open',
comment = 'Appears to serve Jerada coal-powered power station. Coal imported via Nador port',
mode = 'freight'
where oid in (select edge from tmp);


update africa_osm_nodes
set gauge = '1435'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435'))
and railway in ('station', 'halt', 'stop');

-- decided to split out arabic and english/latin names to separate fields
UPDATE africa_osm_nodes
SET    name_arabic = (
   SELECT array_to_string(ARRAY(SELECT regexp_matches(name, '[\u0600-\u06FF]+', 'g')), ' ')
   )
 where country like '%Morocco%';
 
 UPDATE africa_osm_nodes
SET    name = (
   SELECT array_to_string(ARRAY(SELECT regexp_matches(name, '[^\u0600-\u06FF]+', 'g')), ' ')
   )
 where country like '%Morocco%';


-- extract tables for morocco (backup)
create table morocco_osm_edges as select * from africa_osm_edges where country like '%Morocco%';
create table morocco_osm_nodes as select * from africa_osm_nodes where country like '%Morocco%';
