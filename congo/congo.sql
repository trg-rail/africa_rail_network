-- Congo-Brazzaville

select railway, count(*) from africa_osm_nodes where country = 'Congo-Brazzaville' group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country = 'Congo-Brazzaville' group by railway order by count desc;

select status, count(*) from africa_osm_edges where country = 'Congo-Brazzaville' group by status order by count desc;

select type, count(*) from africa_osm_edges where country = 'Congo-Brazzaville' group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country = 'Congo-Brazzaville' and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country = 'Congo-Brazzaville' group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country = 'Congo-Brazzaville' group by gauge order by gauge desc;

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

-- Congo-Ocean Railway (COR) 

-- copy Pointe-Noire to another edge
select rn_copy_node(array[555026529], array[555092026]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              556026529,
		555014250,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Congo-Ocean Railway (COR)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Congo-Ocean Railway (Bilinga – Dolisie loop)
-- remove edge to ensure loop used
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid not in (555064161)',
              555101506,
		555101554,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bilinga – Dolisie loop (COR)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Opened 1985. A 91km loop to provide better alignment for heavy iron ore traffic. The loop is normally used in one direction only, with returning traffic using the original line. See: https://www.sinfin.net/railways/world/congo-brazzaville.html'
where oid in (select edge from tmp);


-- Congo-Ocean Railway (Mont Bélo - Mbinda branch)

-- split 555064202 at 555101474
select rn_split_edge(array[555064202], array[555101474]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555101474,
		555038591,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mont Bélo - Mbinda branch (COR)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'rehabilitation',
comment = 'All services appear to have been suspended in April 2021, see: https://lesechos-congobrazza.com/societe/7865-congo-la-suppression-du-train-mbinda-est-un-acte-criminel-selon-les-populations-de-l-ex-cite-comilog. Rehabilitation reported to have begun in April 2022, see: https://www.railways.africa/newsxpress/railways-africa-newsxpress-week-16-2022/.'
where oid in (select edge from tmp);

-- Pointe-Noire (port)

update africa_osm_nodes
set name = 'Pointe-Noire (port)',
railway = 'stop',
facility = 'port'
where oid = 555072966;

-- split 5550920262 at 555123172
select rn_split_edge(array[5550920262], array[555123172]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555123172,
		555072966,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pointe-Noire (port)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Brazzaville river port
update africa_osm_nodes
set name = 'Brazzaville river port',
facility= 'port',
railway = 'stop'
where oid = 555122501;

update africa_osm_nodes
set name = 'GPL S.A (Liquefied Gas)',
railway = 'stop',
facility = 'manufacturing'
where oid = 555101755

--split 555092037 at 555072967
select rn_split_edge(array[555092037], array[555072967]);
-- split 555094417 at 555122500 
select rn_split_edge(array[555094417], array[555122500]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555014250,
		555122501,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Brazzaville river port',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555063363,
		555101755,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'GPL S.A (Liquefied Gas)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- sort out stations

-- TiéTié
select rn_copy_node(array[555022068], array[555082916]);
-- Ntombo
select rn_copy_node(array[555026479], array[555064257]);
-- La Gare de Nkayi
select rn_copy_node(array[555063074], array[555094401]);
--Madingou
select rn_copy_node(array[555026463], array[555094403]);
-- Kibossi
select rn_copy_node(array[555036776], array[555064510]);


update africa_osm_nodes
set name = 'Mvoungouti',
railway = 'station'
where oid = 555101553


update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country ='Congo-Brazzaville' and railway in ('station', 'halt', 'stop');

-- extract tables for Egypt (backup)
create table congo_brazzaville_osm_edges as select * from africa_osm_edges where country = 'Congo-Brazzaville';
create table congo_brazzaville_osm_nodes as select * from africa_osm_nodes where country = 'Congo-Brazzaville';

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555072966,
		555122501,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			




























