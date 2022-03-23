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
set name = 'Tunis محطة تونس',
railway = 'station',
gauge = '1000'
where oid = 555002402;

update africa_osm_nodes
set name = 'Tunis محطة تونس',
railway = 'station',
gauge = '1435'
where oid = 555011661;

update africa_osm_nodes
set name = 'Ghardimaou غار الدماء',
railway = 'station'
where oid = 555078199;

update africa_osm_nodes
set name = 'Mateur ماطر',
railway = 'station'
where oid = 555018220;

update africa_osm_nodes
set name = 'Sidi M''Himech',
railway = 'station'
where oid = 555018182;

update africa_osm_nodes
set name = 'Bizerte بَنْزَرْت‎',
railway = 'station'
where oid = 555012948;

update africa_osm_nodes
set name = 'Gabes قابس',
railway = 'station'
where oid = 555054515;

update africa_osm_nodes
set name = 'Jebal Jelloud',
railway = 'station'
where oid = 555018121;

update africa_osm_nodes
set name = 'Port La Goulette Sud',
railway = 'station',
gauge = '1435',
facility = 'port'
where oid = 555042215;

update africa_osm_nodes
set name = 'Port La Goulette Sud',
railway = 'station',
gauge = '1000',
facility = 'port'
where oid = 556042215;

update africa_osm_nodes
set name = 'Kasserine القصرين',
railway = 'station'
where oid = 555055078;

update africa_osm_nodes
set name = 'Le Kef محطة الكاف',
railway = 'station'
where oid = 556062252;

update africa_osm_nodes
set name = 'Tajerouine تاجروين',
railway = 'station'
where oid = 555018482;

update africa_osm_nodes
set name = 'Bir Bourekba بئر بورقبة',
railway = 'station'
where oid = 556054493;

update africa_osm_nodes
set name = 'Nabeul Voyageurs',
railway = 'station'
where oid = 555010618;

update africa_osm_nodes
set name = 'Jilma',
railway = 'station'
where oid = 556060776;

update africa_osm_nodes
set name = 'Kalâa Seghira القلعة الصغرى',
railway = 'station'
where oid = 556054474;

update africa_osm_nodes
set name = 'Ghraiba الغريبة',
railway = 'station'
where oid = 555023109;

update africa_osm_nodes
set name = 'Tozeur توزر',
railway = 'station'
where oid = 555071107;




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
name = 'El Fouladh steel works (Menzel Bourguiba)',
facility = 'manufacturing'
where oid = 555018241;

update africa_osm_nodes
set railway = 'stop',
name = 'Sehib Mine (Phosphate)',
facility = 'mine'
where oid = 555017802;

update africa_osm_nodes
set railway = 'stop',
name = 'M''dhilla Mine (Phosphate)',
facility = 'mine'
where oid = 555017817;

-- industrial zones

update africa_osm_nodes
set railway = 'stop',
name = '',
facility = 'Industrial zone'
where oid = ;

-- insert node to enable link to be inserted
-- will then be inserted onto correct edge below
-- routing to Tajerouine
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 557000001,
 null,
 null,
 'Tunisia',
 '',
 '',
 ST_SetSRID(ST_Point(8.67944,35.84812), 4326)
 )
;

-- node for Aguila station
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 557000002,
 'station',
 'Aguila',
 'Tunisia',
 '',
 '',
 ST_SetSRID(ST_Point(8.76839,34.37969), 4326)
 )
;


SELECT ST_SetSRID( ST_Point(8.00607,35.66806), 4326)

-- create new station (or other) nodes
-- this is required as there can be several edges running through stations but the station node
-- is located on an edge that isn't used for the route.
-- copy Port La Goulette - Sud 555042215 to 555025933
-- copy Le Kef 555062252 to 555043283
-- copy Bir Bourekba 555054493 to 555042264
-- copy Jilma 555060776 to 555084260
-- copy Kalaa Sghira 555054474 to 555045726
-- connect from Line 12 north of M'Saken
-- copy 555064498 to 555041978
-- copy Mdhila 555060747 to 555041413
-- node for Aguila 557000002 to 555041428

DO $$ DECLARE
-- create new station nodes
-- note: must not be a node coincident with the closest point (reassign that node as a station instead)
-- nodes INT8 ARRAY DEFAULT ARRAY [557000001, 555042215, 555062252, 555054493, 555060776, 555054474, 555064498, 555060747, 557000002];
-- edges INT8 ARRAY DEFAULT ARRAY [555084267, 555025933, 555043283, 555042264, 555084260, 555045726, 555041978, 555041413, 555041428];
nodes INT8 ARRAY DEFAULT ARRAY [557000002];
edges INT8 ARRAY DEFAULT ARRAY [555041428];
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
-- route south out of Mateur
-- split 555028096 at 555086819
-- split 555028115 at 555086818
-- route from Mateur Sud onto Tamera line
-- split 555028119 at 555077658
-- route into Tamera
-- split 555111846 at 555086842
-- route into Jedeida
-- split 555029315 at 555083372
-- route from Tinja to Menzel Bourguiba line
-- split 555028057 at 555086848
-- split 555042812 at 555086854
-- dual gauge from Jebal Jelloud to La Goulette
-- split 555026320 at 555076508
-- split 5550263201 at 555117781
-- split 555029421 at 555085113
-- split 555026313 at 555076466
-- split 555026240 at 555076507
-- split 555026286 at 555076439
-- loop linking dual gauge track from La Goulette to standard gauge track serving north of Tunis
-- split 555027102 at 555074617
-- split 555023279 at 555074616
-- split 555066827 at 555076525
-- route from Bir Kassa to La Goulette
-- split 555026878 at 555002536
-- split 5550268781 at 555064390
-- routing out of Kasserine to Jilma
-- split 555041533 at 555087464
-- routing out of Ghraiba into Tozeur line
-- split 555034496 at 555081180
-- routing into Aguila from Sehib line
-- split 555037260 at 555085552
-- split 5550414281 at 555085551
-- routing to M'dhilla Mine
-- split 555041412 at 555085509

DO $$ DECLARE
-- edges INT8 ARRAY DEFAULT ARRAY [555028119, 555028096, 555028115, 555029315, 555028057, 555042812, 555026320, 5550263201, 555029421, 555026313, 555026240, 555026286, 555027102, 555023279, 555066827, 555026878, 5550268781, 555041533, 555034496, 555037260, 5550414281, 555041412];
-- nodes INT8 ARRAY DEFAULT ARRAY [555077658, 555086819,  555086818, 555083372, 555086848, 555086854, 555076508, 555117781, 555085113, 555076466, 555076507, 555076439, 555074617, 555074616, 555076525, 555002536, 555064390, 555087464, 555081180, 555085552, 555085551, 555085509];
edges INT8 ARRAY DEFAULT ARRAY [555041412];
nodes INT8 ARRAY DEFAULT ARRAY [555085509];
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

-- TA Tunis to Algerian border (Ghardimaou)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555011661,
		555078199,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line TA: Tunis - Algerian border (Ghardimaou)',
gauge = '1435',
status = 'open',
comment = 'Passenger services only to Ghardimaou',
mode = 'mixed'
where oid in (select edge from tmp);

-- Ghardimaou to Algerian Border (freight only)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555078199,
		555078163,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ghardimaou - Algerian Border',
gauge = '1435',
status = 'open',
comment = 'Freight only, border not open to passenger traffic',
mode = 'freight'
where oid in (select edge from tmp);

-- Mateur to Sidi M'Himech
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555086819,
		555078144,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 3: Mateur - Sidi M''Himech',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);

-- Mateur (Mateur Sud) to Tamera
-- disused - no timetabled services
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555077658,
		555036585,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 2: Mateur (Mateur Sud) - Tamera',
gauge = '1435',
status = 'disused',
comment = 'Line abandoned from Tamera to Tabarka',
mode = 'mixed'
where oid in (select edge from tmp);

-- Line 1 Jedeida to Bizerte

-- simplify routing
-- link 555013250 to 555013249
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555013250 and b.oid = 555013249
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555013250,
555013249,
556000020
from tmp as a;

-- missing edge
-- link 555062154 to 555078012
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555062154 and b.oid = 555078012
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555062154,
555078012,
556000021
from tmp as a;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555013249,
		555012948,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 1: Jedeida - Bizerte',
gauge = '1435',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Tinja to Menzel Nourguiba (El Fouladh steel works)
-- freight only now
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555086848,
		555018241,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 4: Tinja - Menzel Nourguiba (El Fouladh steel works)',
gauge = '1435',
status = 'unknown',
comment = 'Might be freight only or disused. No passengers services listed and see: https://egtre.info/wiki/Tunisia_-_General_Information. Not clear if El Fouladh steel works is still served by the railway.',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Line 5 - Tunis to Gabes
-- metre gauge
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555002402,
		555054515,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 5: Tunis - Gabes',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Jebal Jelloud to La Goulette (dual gauge track)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555076508,
		555085113,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Jebal Jelloud - La Goulette (dual gauge track)',
gauge = 'dual',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- link dual track to access Jebal Jelloud station (1000 gauge)
-- from 555076508 to 555076525
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555076508 and b.oid = 555076525
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555076508,
555076525,
556000022
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000'
where oid = 556000022

-- Jebal Jelloud to La Goulette (link to dual gauge track)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555076525,
		555076508,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Jebal Jelloud - Port La Goulette Sud (metre <-> dual gauge)',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Loop from dual gauge track from La Goulette to standard gauge track serving  north of Tunis
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555076508,
		555074616,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'dual gauge - standard gauge link (Jebal Jelloud <-> Line TA)',
gauge = '1435',
status = 'open',
comment = 'Probably for freight only?',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- insert link for dual guage to standard to La Goulette
-- link 555085113 to 555042215
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555085113 and b.oid = 555042215
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555085113,
555042215,
556000023
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1435'
where oid = 556000023

-- insert link for dual guage to metre to La Goulette
-- link 
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555085113 and b.oid = 556042215
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555085113,
556042215,
556000024
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000'
where oid = 556000024

-- From dual gauge to Port La Goulette - Sud 1435
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555085113,
		555042215,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'dual gauge - Port La Goulette Sud (standard gauge)',
gauge = '1435',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);


-- From dual gauge to Port La Goulette - Sud 1000
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555085113,
		556042215,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'dual gauge - Port La Goulette Sud (metre gauge)',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Line 6 Tunis (Jebal Jelloud) - Kasserine metre gauge

-- simplify routing from Jebal Jelloud to Kasserine line
-- link 555076914 to 555018121
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555076914 and b.oid = 555018121
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555076914,
555018121,
556000025
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'open'
where oid = 556000025

-- mixed (freight and passenger) services to Kalaa Khasba only
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555018121,
		555018488,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 6: Tunis (Jebal Jelloud) - Kalaa Khasba',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);


-- freight only from Kalaa Khasba to Kasserine
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555018488,
		555055078,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 6: Tunis (Jebal Jelloud) - Kalaa Khasba',
gauge = '1000',
status = 'open',
comment = 'Open for freight only - see map at: https://en.wikipedia.org/wiki/Soci%C3%A9t%C3%A9_Nationale_des_Chemins_de_Fer_Tunisiens',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);


-- Line 7 Bir Kassa - Port La Goulette Sud (metre gauge)

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555064390,
		556042215,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 7: Bir Kassa - Port La Goulette Sud',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Line 8 Les Salines - Le Kef
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555087223,
		556062252,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 8: Les Salines - Le Kef',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);


-- Line 9 Fej Ettameur to Tajerouine
-- insert line between 558000001 and 555033640
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 558000001 and b.oid = 555033640
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
558000001,
555033640,
556000026
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'open'
where oid = 556000026

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555033640,
		555018482,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 9: Fej Ettameur to Tajerouine',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Line 10 Bir Bourekba - Nabeul
-- link to simplify routing
-- link 556054493 to 555077843
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 556054493 and b.oid = 555077843
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
556054493,
555077843,
556000027
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'open'
where oid = 556000027

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              556054493,
		555010618,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 10: Bir Bourekba - Nabeul',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Line 11 Kasserine to Jilma
-- no timetabled services on this line. 
-- According to this map: https://commons.wikimedia.org/wiki/File:Reseau_cft_tunisie.svg (August 2018) it is freight only on this section, Jilma to Kalaa Sghira is disused (or abandoned according to OSM).

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555055078 ,
		556060776,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 11: Kasserine - Jilma',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Line 12 Kalâa Seghira to M'Saken (via Sousse)
-- link to simplfy routing
-- 556054474 to 555056531

with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 556054474 and b.oid = 555056531
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
556054474,
555056531,
556000028
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'open'
where oid = 556000028

-- change source vertex of line 555054793 to node 556064498
-- simplify routing into M'Saken from Sousse (Line 12)
UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, 0, (select geom from africa_osm_nodes where oid = 556064498)),
	source = 556064498
	WHERE oid = 555054793;

-- need to remove links to ensure route via Sousse
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid not in (5550457262, 555002756, 555084215)',
             556054474,
		556064498,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 12: Kalâa Seghira - M''Saken (via Sousse)',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Line 13 Ghraiba - Tozeur
-- insert link between 555023109 and 555081180
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555023109 and b.oid = 555081180
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555023109,
555081180,
556000029
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'open'
where oid = 556000029

-- change source vertex of line 555054793 to node 556064498
-- simplify routing into M'Saken from Sousse (Line 12)
UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, 0, (select geom from africa_osm_nodes where oid = 556064498)),
	source = 556064498
	WHERE oid = 555054793;


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555023109,
		555071107,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 13: Ghraiba - Tozeur',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Line 17 Founi - El Hamada

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555071105,
		555114105,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 17: Founi - El Hamada',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Line 14: Aguila - Sehib
-- pedestrian services to M'dhilla
-- freight only from M'dhilla to Sehib phosphate mine.

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             558000002,
		556060747,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 14: Aguila - M''dhilla',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             556060747,
		555017802,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 14: M''dhilla - Sehib Mine',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- M'dhilla to M'dhilla mine (freight)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555085509,
		555017817,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'M''dhilla - M''dhilla Mine',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);


update africa_osm_nodes
set gauge = '1435'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435'))
and railway in ('station', 'halt', 'stop');

-- extract tables for tunisia (backup)
create table tunisia_osm_edges as select * from africa_osm_edges where country like '%Tunisia%';
create table tunisia_osm_nodes as select * from africa_osm_nodes where country like '%Tunisia%';

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555011661,
		555042215,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			




























