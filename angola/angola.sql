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


-- Luanda Railway 
-- 1067m gauge
-- Bungo (Luanda) to Malanje
-- appears to be double track to Baia

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555006943,
		555030865,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Luanda Railway',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Malange Industrial site

-- split 555017047 at 555082619
select rn_split_edge(array[555017047], array[555082619]);

update africa_osm_nodes
set name = 'Malange industrial site',
railway = 'stop',
facility = 'unknown',
comment = 'Purpose of site unknown'
where oid = 555082620;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555030865,
		555082620,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Malange industrial site',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Dondo Branch (Zenza do Itombe - Dondo)

-- Create Dondo station node
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000015,
 'station',
 'Dondo',
 'Angola',
 null,
 null,
 ST_SetSRID(ST_Point(14.42486,-9.68774), 4326)
 )
;

select rn_copy_node(array[558000015], array[555047629]);

-- split 555047639 at 555090153
select rn_split_edge(array[555047639], array[555090153]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555090153,
		559000015,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Luanda Railway (Dondo Branch)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- New branch to serve New International Airport of Luanda
-- under construction
-- potential opening in 2023

select rn_insert_edge(555019356, 555132174, 556000066);
select rn_insert_edge(555132175, 555132176, 556000067);

update africa_osm_nodes
set name = 'International Airport of Luanda (New)',
railway ='station',
comment = 'Airport still under construction. It may open in 2023 - see: https://www.a1v2.pt/en/portfolio/railway/',
facility = 'airport'
where oid = 555132178;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555019356,
		555132178,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'International Airport of Luanda',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'construction',
comment = ''
where oid in (select edge from tmp);


-- Benguela Railway
-- Lobito – Luau and then connects into DRC (nr Dilolo)

-- copy Luau station
select rn_copy_node(array[555059146], array[555095775]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555046802,
		555123809,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Benguela Railway',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- freight services for Lobito Port

-- split 555099360 at 555099758
select rn_split_edge(array[555099360], array[555099758]);
-- split 555061456 at 555099760
-- split 555061458 at 555133790
select rn_split_edge(array[555061456, 555061458], array[555099760, 555133790]);

update africa_osm_nodes
set railway = 'stop',
name = 'Lobito Port',
facility = 'Port'
where oid = 555133789;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555099758,
		555133789,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Benguela Railway (Lobito Port)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Spur to Bimbas via Airport and Benguela

-- split 555124731 at 555151001
-- split 555061597 at 555151000
select rn_split_edge(array[555124731, 555061597], array[555151001, 555151000]);

-- copy Bimbas station
select rn_copy_node(array[555021471], array[555037931]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555151001,
		556021471,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Benguela Railway (Benguela spur)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

update africa_osm_nodes
set facility = 'airport',
name = 'Catumbela Airport'
where oid = 555021538;

-- Petroleum storage (Sonangol)
update africa_osm_nodes
set name = 'Sonangol facility',
railway = 'stop',
facility = 'Oil storage depot',
comment = 'Petroleum or gas storage facility'
where oid = 555110078;

-- split 555124709 at 555110077
select rn_split_edge(array[555124709], array[555110077]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555110077,
		555110078,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sonangol Petroleum facility',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

update africa_osm_nodes
set name = NULL,
railway = NULL
where oid = 555063029;

-- Moçâmedes Railway
-- Moçâmedes (called Namibe 1985-2016) - Menongue
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555030790,
		555019194,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Moçâmedes Railway',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Sacomar Mineral Port

update africa_osm_nodes
set name = 'Sacomar Mineral Port',
railway = 'stop',
facility = 'port'
where oid = 555057978;

-- split 555036052 at 555096036
select rn_split_edge(array[555036052], array[555096036]);
-- split 555075650 at 555109794
select rn_split_edge(array[555075650], array[555109794]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555096036,
		555057978,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sacomar Mineral Port',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Port of Moçâmedes (Namibe)

update africa_osm_nodes
set name = 'Port of Moçâmedes (Namibe)',
railway = 'stop',
facility = 'port'
where oid = 555049149;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555030790,
		555049149,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Moçâmedes (Namibe)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Menongue Fuel Terminal
-- now open, see: https://www.verangola.net/va/pt/042022/Energia/30256/Inaugurado-terminal-ferrovi%C3%A1rio-de-combust%C3%ADvel-em-Malanje.htm

update africa_osm_nodes
set name = 'Menongue Fuel Terminal',
facility = 'Oil storage depot',
railway = 'stop',
comment = 'Facility now open, see: bit.ly/3Pa6476'
where oid = 555126357;

-- split 555045134 at 555126353
select rn_split_edge(array[555045134], array[555126353]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555126353,
		555126357,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Menongue Fuel Terminal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Chamutete & Jamba Branch
-- in use (passenger and freight): see: https://www.verangola.net/va/en/042022/Transports/30514/CFM-train-connects-Lubango-to-Jamba-again-after-two-years-paralyzed.htm

-- copy Chamutete Cidade station
select rn_copy_node(array[555019541], array[555046080]);
-- split 555045185 at 555151199
select rn_split_edge(array[555045185], array[555151199]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555026067,
		555019548,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Chamutete Branch',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Jamba Branch
-- split 5550451851 at 555101051
select rn_split_edge(array[5550451851], array[555101051]);
-- split 555046079 at 555101052
select rn_split_edge(array[555046079], array[555101052]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555101052,
		555019213,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Jamba Branch',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Jamba Mine
update africa_osm_nodes
set name = 'Jamba Mine loading station',
railway = 'stop',
facility = 'mining',
comment = 'Jamba mine loading station appears abandoned'
where oid = 555099392;

-- split 555129758 at 555099392
select rn_split_edge(array[555129758], array[555099392]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555019213,
		555099392,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Jamba Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Quarry (nr Dois Irmãos)
update africa_osm_nodes
set name = 'Quarry',
railway = 'stop',
facility = 'Quarry'
where oid = 555090125;

-- split 555036571 at 555090126
select rn_split_edge(array[555036571], array[555090126]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555090126,
		555090125,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Quarry (nr Dois Irmãos)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Rail Freight Terminal (Estação da Arimba)
-- 555109759
update africa_osm_nodes
set railway = 'stop',
facility = 'Rail Freight Terminal',
name = 'Rail Freight Terminal'
where oid = 555109759;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555030705,
		555109759,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rail Freight Terminal (Estação da Arimba)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- fix stations

-- Filda
select rn_copy_node(array[555014853], array[555098128]);
-- Baia
select rn_copy_node(array[555030839], array[555036677]);
-- Catete
select rn_copy_node(array[555015636], array[555036660]);
-- Catumbela Airport
select rn_copy_node(array[555021538], array[555091806]);
-- Cavaco
select rn_copy_node(array[555030798], array[555027563]);
-- Caponte
select rn_copy_node(array[555045533], array[555051803]);
-- Ciambambo
select rn_copy_node(array[555063039], array[555036514]);
-- Catabola
select rn_copy_node(array[555030827], array[555099390]);
-- Camacupa
select rn_copy_node(array[555026517], array[555060581]);
-- Cavimbe
select rn_copy_node(array[555030829], array[555027497]);
-- Leua
select rn_copy_node(array[555028053], array[555047674]);
-- Sandando
select rn_copy_node(array[555028052], array[555047672]);
-- Lumeje
select rn_copy_node(array[555026515], array[555019952]);
-- Cassai
select rn_copy_node(array[555059145], array[555019951]);
-- Estação da Arimba
select rn_copy_node(array[555062994], array[555119977]);

select rn_copy_node(array[
555030738, 555020097, 555022473, 555030753, 555015601, 555015613, 555030767, 555054031,
555023326, 555030722, 555017129, 555030703, 555017143, 555017145, 555030691, 555030688,
555030641, 555030686, 555030685, 555017139, 555026050, 555026097, 555026095, 555026091,
555026090, 555026048, 555060538, 555026047, 555026057, 555030770
], array[
555036051, 555036567, 555047587, 555103625, 555036559, 555109819, 555109822, 555119782,
555119787, 555119967, 555119985, 555039300, 555039312, 555039320, 555039324, 555039305,
555075431, 555016831, 555016836, 555119882, 555119910, 555063405, 555063409, 555063413,
555063441, 555063445, 555063448, 555063470, 555039294, 555050346
]);

update africa_osm_nodes
set railway = 'station',
name = 'Lubango (Km 246)'
where oid = 555054575;

-- duplicate stations
update africa_osm_nodes
set railway = NULL,
name = NULL,
gauge = NULL
where oid in (
555035574,
555019349,
555062289,
555062994,
555030706
);

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
			
			
			





























