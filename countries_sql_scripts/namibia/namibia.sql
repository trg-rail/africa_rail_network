-- Namibia

select railway, count(*) from africa_osm_nodes where country in ('Namibia') group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country in ('Namibia') group by railway order by count desc;

select status, count(*) from africa_osm_edges where country in ('Namibia') group by status order by count desc;

select type, count(*) from africa_osm_edges where country in ('Namibia') group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country in ('Namibia') and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country in ('Namibia') group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country in ('Namibia') group by gauge order by gauge desc;


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

-- Karasburg – Keetmanshoop – Windhoek
-- passenger services and freight on this section

-- split 555034810 at 555122387
select rn_split_edge(array[555034810], array[555122387]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555062151,
		555009480,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Karasburg – Windhoek',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Karasburg - Nakop (S. Africa border)

-- add node to split at SA Border

-- add station
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000016,
 null,
 null,
 'Namibia',
 null,
 null,
 ST_SetSRID(ST_Point(19.99921,-28.10065), 4326)
 )
;

select rn_copy_node(array[558000016], array[555052688]);
update africa_osm_edges set country = 'Namibia' where oid = 5550526882;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009480,
		559000016,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Karasburg – Nakop (and SA border)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'No passenger services on this section of line (apart from tourist cruise trains)'
where oid in (select edge from tmp);

-- Seeheim Junction - Luderitz Port
-- freight use only

update africa_osm_nodes
set name = 'Luderitz Port',
railway = 'stop',
facility = 'port'
where oid = 555039533;

-- split 555012889 at 555126590
select rn_split_edge(array[555012889], array[555126590]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555002232,
		555039533,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Seeheim Junction - Luderitz Port',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'No passenger services on this section line. Aus - Luderitz section reopened in 2019. Port connected to network, see: http://bit.ly/3GQgaXb'
where oid in (select edge from tmp);

-- Windhoek - Gobabis
-- Freight only
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555072720,
		555012220,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gobabis Branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'No passenger services on this line.'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555081309,
		555072721,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gobabis Branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'No passenger services on this line.'
where oid in (select edge from tmp);

-- Windhoek - Kranzberg
-- passenger services on this section (and on to Walvis Bay)
-- split 555067036 at 555103150
select rn_split_edge(ARRAY[555067036], ARRAY[555103150]);

-- change target of edge 555090771 from 555122388 to 555081305
select rn_change_target(555090771, 555081305);
-- split 555090763 at 555081305
select rn_split_edge(array[555090763], array[555081305]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555062151,
		555018535,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Windhoek - Kranzberg',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kranzberg - Walvis Bay
-- open to pedestrian and freight
--- In operational but poor condition and slow speeds. A rehabilitation has commenced post covid. IN two parts. Part 1 (Walvis Bay to Arandis) and Part 2 (Arandis to Kranzberg). Three year project will enable when finished freight at 80 km/h and passenger at up to 100 km/h. 

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555018535,
		555000195,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kranzberg - Walvis Bay',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'In operational but poor condition and slow speeds. A rehabilitation has commenced post covid. IN two parts. Part 1 (Walvis Bay to Arandis) and Part 2 (Arandis to Kranzberg). Three year project will enable when finished freight at 80 km/h and passenger at up to 100 km/h.'
where oid in (select edge from tmp);

-- Walvis Bay Port

-- Walvis Bay New Container Terminal
update africa_osm_nodes
set railway = 'stop',
name = 'Walvis Bay Port (New Container Terminal)',
facility = 'Container Terminal'
where oid = 555132396;

-- Walvis Bay Port
update africa_osm_nodes
set railway = 'stop',
name = 'Walvis Bay Port',
facility = 'Port'
where oid = 555031220;

-- split 555104134 at 555132390
-- split 555104130 at 555112953
select rn_split_edge(array[555104134, 555104130], array[555132390, 555112953]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555000195,
		555132396,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Walvis Bay Port',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555031263,
		555031220,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Walvis Bay Port',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kranzberg - Tsumeb
-- Freight only (no passenger services at present)

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555018535,
		555009722,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kranzberg - Tsumeb',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'No passenger services on this section of line'
where oid in (select edge from tmp);

-- Tsumeb - Ondangwa
-- Pasenger and freight
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009722,
		555012414,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tsumeb - Ondangwa',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Ondangwa – Oshikango
-- passenger and freight

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555012414,
		555016165,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ondangwa – Oshikango',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Otavi - Grootfontein
-- freight only

-- split 555034968 at 555064060
select rn_split_edge(array[555034968], array[555064060]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555064060,
		555018543,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Otavi - Grootfontein',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Otjiwarongo - Outjo
-- disused - see https://www.youtube.com/watch?v=zrGtT-W7j_4

-- split 555096485 at 555123094
select rn_split_edge(array[555096485], array[555123094]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555123094,
		555018542,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Otjiwarongo - Outjo',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Probably closed in 1993. See: https://www.youtube.com/watch?v=zrGtT-W7j_4'
where oid in (select edge from tmp);


-- Ongopolo mine

update africa_osm_nodes
set name = 'Ongopolo Mine',
railway = 'stop',
facility = 'Copper Smelter',
comment = 'Former mine, now believed to be primarily a complex copper concentrate smelter. See: http://bit.ly/3Wkuvkx. Rail connection said to be in use.'
where oid = 555123575;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555009722,
		555123575,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ongopolo Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Rössing Mine
-- Uranium mine 

update africa_osm_nodes
set name = 'Rössing Uranium Mine',
facility = 'Mine',
railway = 'stop',
comment = 'Uranium mining and processing'
where oid =  555087786;

-- split 555000561 at 555123071
select rn_split_edge(array[555000561], array[555123071]);
-- split 555091818 at 555087787
select rn_split_edge(array[555091818], array[555087787]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555123071,
		555087786,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rössing Uranium Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Grootfontein Air Force Base

update africa_osm_nodes
set name ='Grootfontein Air Force Base',
railway = 'stop',
facility = 'Military'
where oid = 555077928;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555018543,
		555077928,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Grootfontein Air Force Base',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open'
where oid in (select edge from tmp);

-- Namib Mills, Otavi
update africa_osm_nodes
set name = 'Namib Mills, Otavi',
railway = 'stop',
facility = 'manufacturing',
comment = 'A maize and mahangu mill'
where oid = 555087579;

-- simplify routing
select rn_insert_edge(555064060, 555087566, 556000068);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555064060,
		555087579,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Namib Mills, Otavi',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open'
where oid in (select edge from tmp);

-- Namcor fuel depot (Otjiwarongon)
-- node 555017425

update africa_osm_nodes
set name = 'Namcor fuel depot (Otjiwarongon)',
railway = 'stop',
facility = 'Fuel depot'
where oid = 555017425;

-- split 5550964851 at 555084862
-- split 555040079 at 555084854
-- split 555040084 at 555084858
-- split 555040087 at 555084857
select rn_split_edge(array[5550964851,555040079,555040084,555040087], array[555084862,555084854,555084858,555084857]);
select rn_split_edge(array[5550400791], array[555084861]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555084862,
		555017425,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Namcor fuel depot (Otjiwarongon)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open'
where oid in (select edge from tmp);


-- Namcor fuel depot (Ondangwa)
-- node 555087618

update africa_osm_nodes
set name = 'Namcor fuel depot (Ondangwa)',
railway = 'stop',
facility = 'Fuel depot'
where oid = 555087618;

-- split 555037041 at 555087619
select rn_split_edge(array[555037041], array[555087619]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555087619,
		555087618,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Namcor fuel depot (Ondangwa)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open'
where oid in (select edge from tmp);

-- Northern Industrial Area, Windhoek
-- 555104948
update africa_osm_nodes
set name = 'Northern Industrial Area, Windhoek',
facility = 'Industrial Area',
railway = 'stop'
where oid = 555104948;

-- split 555090771 at 555122389
-- split 555015282 at 555104942
-- split 555068786 at 555104944

select rn_split_edge(array[555090771,555015282,555068786], array[555122389,555104942,555104944]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555122389,
		555104948,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Northern Industrial Area, Windhoek',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open'
where oid in (select edge from tmp);


-- TransNamib Windhoek Container Depot (WINCON) 
update africa_osm_nodes
set name = 'TransNamib Windhoek Container Depot (WINCON)',
facility = 'Container Terminal (inland)',
railway = 'stop'
where oid = 555132505;

-- split 555085585 at 555070267
select rn_split_edge(array[555085585], array[555070267]);
-- split 555015283 at 555132505
select rn_split_edge(array[555015283], array[555132505]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555070267,
		555132505,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'TransNamib Windhoek Container Depot (WINCON)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open'
where oid in (select edge from tmp);

-- fix stations not on the defined lines

-- Ohangwena
select rn_copy_node(array[555030609], array[555021865]);
-- Uchab
select rn_copy_node(array[555018654], array[555001735]);
-- Kaalkop
select rn_copy_node(array[555018564], array[555001714]);
-- Otuwe
select rn_copy_node(array[555018563], array[555078711]);
-- Okozongoro
select rn_copy_node(array[555018565], array[555086691]);
-- Epako
select rn_copy_node(array[555018566], array[555011175]);
--
select rn_copy_node(array[555018567], array[555021326]);
-- Omaruru
select rn_copy_node(array[555012256], array[555021327]);
-- Okanono
select rn_copy_node(array[555018571], array[555078572]);
--
select rn_copy_node(array[555018570], array[555063894]);
-- Etiro
select rn_copy_node(array[555018569], array[555063895]);
--
select rn_copy_node(array[555018568], array[555066414]);
-- Arandis
select rn_copy_node(array[555018591], array[5550005611]);
-- Rössing
select rn_copy_node(array[555037129], array[555000563]);
-- Swakopmund
select rn_copy_node(array[555037115], array[555000570]);
-- Karibib
select rn_copy_node(array[555012257], array[555078576]);
-- Hoffnung
select rn_copy_node(array[555018586], array[555071835]);
-- Neudamm (Ondekaremba)
select rn_copy_node(array[555018584], array[555056167]);
--
select rn_copy_node(array[555017571], array[555054319]);
-- Seeis
select rn_copy_node(array[555018582], array[555054315]);
-- Witvlei
select rn_copy_node(array[555018651], array[555103855]);
-- Asab
select rn_copy_node(array[555018649], array[555087858]);
-- Feldschuhhorn
select rn_copy_node(array[555018681], array[555070808]);
-- Konkiep
select rn_copy_node(array[555018680], array[555070947]);
-- Buchholzbrunn
select rn_copy_node(array[555017173], array[555039442]);
-- Holoog
select rn_copy_node(array[555018527], array[555076702]);
-- Grünau
select rn_copy_node(array[555018530], array[555039417]);
-- Seeheim Noor duplicate
update africa_osm_nodes
set railway = null,
name = null
where oid = 555041062;


update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('Namibia') and railway in ('station', 'halt', 'stop');

-- extract tables (backup)
create table namibia_osm_edges as select * from africa_osm_edges where country in ('Namibia');
create table namibia_osm_nodes as select * from africa_osm_nodes where country in ('Namibia');

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
			
			
			





























