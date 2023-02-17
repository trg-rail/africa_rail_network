-- Zimbabwe

select railway, count(*) from africa_osm_nodes where country in ('Zimbabwe') group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country in ('Zimbabwe') group by railway order by count desc;

select status, count(*) from africa_osm_edges where country in ('Zimbabwe') group by status order by count desc;

select type, count(*) from africa_osm_edges where country in ('Zimbabwe') group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country in ('Zimbabwe') and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country in ('Zimbabwe') group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country in ('Zimbabwe') group by gauge order by gauge desc;


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
 '',
 '',
 '',
 null,
 null,
 ST_SetSRID(ST_Point(), 4326)
 )
;

select rn_copy_node(array[], array[]);

-- add station
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000019,
 null,
 null,
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(25.85716,-17.92837), 4326)
 )
;

select rn_copy_node(array[558000019], array[555003219]);


-- Bulawayo - Victoria Falls (Zambia border)

-- add node at border

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000019,
 null,
 null,
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(25.85716,-17.92837), 4326)
 )
;

select rn_copy_node(array[558000019], array[555003219]);

-- border node: 559000019

-- add nodes for routing into Bulawayo junction

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000020,
 null,
 null,
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(28.56176,-20.13576), 4326)
 )
;

select rn_copy_node(array[558000020], array[555068323]);
-- node 559000020

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000021,
 null,
 null,
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(28.56171,-20.13563), 4326)
 )
;

select rn_copy_node(array[558000021], array[555017951]);
-- node 559000021

-- add link
select rn_insert_edge(559000020, 559000021, 556000070);

-- split 555068187 at 555104386
select rn_split_edge(array[555068187], array[555104386]);

-- split 555068336 at 555104191
select rn_split_edge(array[555068336], array[555104191]);
-- split 5550683362 at 555104433
select rn_split_edge(array[5550683362], array[555104433]);

-- split 555068188 at 555104432
select rn_split_edge(array[555068188], array[555104432]);

update africa_osm_nodes
set name = 'Bulawayo Station',
railway = 'station'
where oid = 555084216;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges
								where oid != 5550179511',
             555084216,
		559000019,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bulawayo - Victoria Falls (Zambia border)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = NULL
where oid in (select edge from tmp);


-- split 555068347 at 555104836
select rn_split_edge(array[555068347], array[555104836]);

-- Bulawayo - Plumtree (Botswana border)
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555084216,
		559000018,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bulawayo - Plumtree (Botswana border)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services currently suspended'
where oid in (select edge from tmp);


-- Beira–Bulawayo Railway
-- Bulawayo - Harare
-- Bulawayo - Plumtree (Botswana border)

update africa_osm_nodes
set name = 'Harare Station',
railway = 'station'
where oid = 555064270;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555104386,
		555064270,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beira-Bulawayo Railway (Bulawayo - Harare)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services currently suspended'
where oid in (select edge from tmp);

-- Beira-Bulawayo Railway (Harare - Mutare)
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555064270,
		555013377,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beira-Bulawayo Railway (Harare - Mutare)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services currently suspended'
where oid in (select edge from tmp);


-- Beira-Bulawayo Railway (Mutare - Mozambique border)
-- freight only

-- node on border

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000022,
 null,
 null,
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(32.71318,-19.00096), 4326)
 )
;

select rn_copy_node(array[558000022], array[555037138]);
-- node 559000022


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555013377,
		559000022,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beira-Bulawayo Railway (Mutare - Mozambique border)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Beitbridge Bulawayo Railway (BBR) – private (freight)
-- status unclear

-- split 555124341 at 555126359
select rn_split_edge(array[555124341], array[555126359]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555126359,
		555080103,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beitbridge Bulawayo Railway (BBR)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'See: https://bbr.co.zw'
where oid in (select edge from tmp);

-- BBR Marshalling Yard

update africa_osm_nodes
set name ='Beitbridge (BBR)',
railway = 'stop',
facility = 'Marshalling Yard'
where oid = 555081299;
 


-- Limpopo railway (Somabhula – Sango (Mozambique border)) 
 
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555041303,
		555044850,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Limpopo railway (Somabhula – Sango/Chicualacuala (Mozambique border))',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger service currently suspended'
where oid in (select edge from tmp);

-- no intermediate stations in the OSM data for the Limpopo linne in Zimbabwe.
-- add some key ones shown in old timetable: https://nrz.co.zw/intercity-coach-time-table/

--Cement	12:55	12:56
-- http://www.gomapper.com/travel/where-is/cement-station-located.html

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000023,
 'station',
 'Cement',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(28.68572,-20.11316), 4326)
 )
;

select rn_copy_node(array[558000023], array[555069295]);

--Heany Junction	13:16	13:18

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000024,
 'station',
 'Heany Junction',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(28.78557,-20.08156), 4326)
 )
;

select rn_copy_node(array[558000024], array[5551243412]);

--Shangani	14:55	14:57
-- 29.36881,-19.77907
-- https://morningmirror.africanherd.com/bulawayo-morning-mirror-newspaper/dear-old-shangani.htm
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000025,
 'station',
 'Shangani',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(29.36881,-19.77907), 4326)
 )
;

select rn_copy_node(array[558000025], array[555068597]);

--Somabhula	15:45	16:07
-- https://tracks4africa.co.za/listings/item/w367397/somabhula/

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000026,
 'station',
 'Somabhula',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(29.66302,-19.69739), 4326)
 )
;

select rn_copy_node(array[558000026], array[555099636]);

--Bannockburn	18:43	18:48

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000027,
 'station',
 'Bannockburn',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(29.87175,-20.29125), 4326)
 )
;

select rn_copy_node(array[558000027], array[555123649]);

--Ngezi	21:00	21:06

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000028,
 'station',
 'Ngezi',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(30.39979,-20.57852), 4326)
 )
;

select rn_copy_node(array[558000028], array[555123802]);


--Ngungubane (Ngungumbane)	22:12	22:13
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000029,
 'station',
 'Ngungubane (Ngungumbane)',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(30.43704,-20.77154), 4326)
 )
;

select rn_copy_node(array[558000029], array[555084127]);


--Sarahuru	22:49	22:50
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000030,
 'station',
 'Sarahuru',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(30.54485,-20.99085), 4326)
 )
;

select rn_copy_node(array[558000030], array[555033603]);

--Rutenga	23:50	00:50

select rn_copy_node(array[555147424], array[555033590]);

update africa_osm_nodes
set name = 'Rutenga',
railway = 'station'
where oid = 556147424;

--Mbizi	01:56	02:01
select rn_copy_node(array[555056834], array[555034995]);

update africa_osm_nodes
set name ='Mbizi',
railway = 'station'
where oid = 556056834;

--Makambe siding	03:04	03:05
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000031,
 'station',
 'Makambe siding',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(31.38954,-21.51943), 4326)
 )
;

select rn_copy_node(array[558000031], array[555033528]);

--Sango 06:25	07:00
update africa_osm_nodes
set name = 'Sango',
railway = 'station'
where oid = 555080718;

--Chicualacuala (Mozambiquw) 07:06

-- Rutenga-Beitbridge railway
-- Assumed Freight only

-- split 555034862 at 555064677
select rn_split_edge(array[555034862], array[555064677]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555014685,
		555064677,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rutenga-Beitbridge railway',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Mbizi - Mkwasine Branch
-- passenger service between Mbizi and Chiredzi (prior to Covid-19)
-- primarily serves Sugar cane estates and mills

-- stations

--Mbizi	06:50	08:30

--Chingwizi	siding 08:56	08:57
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000032,
 'station',
 'Chingwizi siding',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(31.14813,-21.29288), 4326)
 )
;

select rn_copy_node(array[558000032], array[555086950]);

--Lundi siding	09:33	09:34
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000033,
 'station',
 'Lundi siding',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(31.28519,-21.15879), 4326)
 )
;

select rn_copy_node(array[558000033], array[555033541]);


--Triangle	11:11	11:20

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000034,
 'station',
 'Triangle',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(31.46807,-21.02233), 4326)
 )
;

select rn_copy_node(array[558000034], array[5550335531]);

--Chiredzi
update africa_osm_nodes
set name = 'Chiredzi',
railway = 'station'
where oid = 555119677;


update africa_osm_nodes
set name = 'Mkwasine Sugar Estate',
railway = 'stop',
facility = 'Agriculture',
comment = 'Sugar cane estate. Cut cane transported by rail to sugar mills at Hippo Valley and Triangle'
where oid = 555091456;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555014686,
		555119677,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mbizi - Chiredzi (Chiredzi Branch)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Passenger services ran prior to Covid-19 between Mbizi and Chiredzi'
where oid in (select edge from tmp);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555119677,
		555091456,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Chiredzi - Mkwasine (Chiredzi Branch)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Primarily serves Sugar cane estates and mills'
where oid in (select edge from tmp);

-- Sugar cane mills
-- Triangle
update africa_osm_nodes
set name = 'Triangle sugarcane processing mill (Tongaat Hullet)',
railway = 'stop',
facility = 'Food manufacturing' 
where oid = 555102831;

-- split 555033553 at 555102824
-- split 555066385 at 555102833
-- split 555066393 at 555102825
select rn_split_edge(array[555033553, 555066385, 555066393], array[555102824, 555102833, 555102825]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555102824,
		555102831,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Triangle sugarcane processing mill',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Hippo Valley
update africa_osm_nodes
set name = 'Hippo Valley sugarcane processing mill (Tongaat Hullet)',
railway = 'stop',
facility = 'Food manufacturing' 
where oid = 555119922;

-- split 555086565 at 555147437
select rn_split_edge(array[555086565], array[555147437]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555147437,
		555119922,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hippo Valley sugarcane processing mill',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Gweru - Masvingo branch
-- freight only

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555063796,
		555029061,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gweru - Masvingo branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Masvingo industrial area

update africa_osm_nodes
set railway = 'stop',
facility = 'industrial area',
name = 'Masvingo industrial area'
where oid = 555064694;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555029061,
		555064694,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gweru - Masvingo branch (industrial area)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Shurugwi Branch
-- freight only
update africa_osm_nodes
set railway = 'stop',
name = 'Shurugwi'
where oid = 555101596;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555063793,
		555101596,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Shurugwi Branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Railway Block chrome mine
-- closed
-- assume spur is disused

update africa_osm_nodes
set name = 'Railway Block chrome mine',
railway = 'stop',
facility = 'mine',
comment = 'presumed disused as the mine is closed. See: https://www.thezimbabwean.co/2011/01/zimasco-closes-chrome-mine/' 
where oid = 555103070;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555026498,
		555103070,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Railway Block chrome mine spur',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'presumed disused as the mine is closed. See: https://www.thezimbabwean.co/2011/01/zimasco-closes-chrome-mine/'
where oid in (select edge from tmp);

update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('Zimbabwe') and railway in ('station', 'halt', 'stop');

-- Shurugwi Peak Railway
-- 610mm gauge
-- as mine has closed, assume disused

update africa_osm_nodes
set name = 'Shurugwi Peak Railway',
railway = 'stop',
facility = 'mine railway'
where oid = 555101601;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555101601,
		555097082,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Shurugwi Peak Railway',
mode = 'freight',
type = 'conventional',
gauge = '610',
status = 'disused',
comment = 'presumed disused as the mine is closed. See: https://www.thezimbabwean.co/2011/01/zimasco-closes-chrome-mine/'
where oid in (select edge from tmp);

-- Chinhoyi Branch 
-- Kildonan/Zave (Zawi)
-- have been passenger services in the past but not more recently. See: https://allafrica.com/stories/200705220623.html

update africa_osm_nodes
set name = 'Zave (Zawi)',
railway = 'station'
where oid = 555087971;

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000035,
 'station',
 'Lion''s Den',
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(30.02215,-17.26764), 4326)
 )
;

select rn_copy_node(array[558000035], array[555044098]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555107605,
		555087971,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Harare - Zave (Chinhoyi Branch)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Freight only, though there have been passenger services in the 2000s: https://allafrica.com/stories/200705220623.html'
where oid in (select edge from tmp);

-- Kildonan spur
-- Maryland Junction - Kildonan

update africa_osm_nodes
set name = 'Kildonan siding',
railway = 'stop',
comment = 'Ferrochrome ore is transferred here by road from mines at Mutorashanga (largely owned by Zimasco)'
where oid = 555091464;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555088896,
		555091464,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Maryland Junction - Kildonan',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Shamva Branch
-- Mount Hampden Junction - Shamva

update africa_osm_nodes
set name = 'Shamva',
railway = 'stop'
where oid = 555082767;

-- split 555101539 at 555082767
select rn_split_edge(array[555101539], array[555082767]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555065133,
		555082767,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mount Hampden Junction - Shamva (Shamva Branch)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);



-- Manica container depot, Harare (Kambuzuma district of Harare)
-- https://www.freightnews.co.za/article/new-manica-terminal-harare 

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000036,
 'stop',
 'Manica container depot',
 'Zimbabwe',
 null,
 'Container terminal',
 ST_SetSRID(ST_Point(30.99281,-17.86046), 4326)
 )
;

select rn_copy_node(array[558000036], array[555072215]);

-- split 555048810 at 555090877
-- split 555072214 at 555090833

select rn_split_edge(array[555048810, 555072214], array[555090877, 555090833]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555090878,
		559000036,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Manica container depot, Harare',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Harare Thermal Power Station

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000037,
 'stop',
 'Harare Thermal Power Station',
 'Zimbabwe',
 null,
 'Power station',
 ST_SetSRID(ST_Point(31.02967,-17.84457), 4326)
 )
;

select rn_copy_node(array[558000037], array[555068088]);

-- split 555075351 at 555104060
-- split 555068087 at 555104059
select rn_split_edge(array[555075351, 555068087], array[555104060, 555104059]);
-- split 5550680872 at 555104057
select rn_split_edge(array[5550680872], array[555104057]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555109636,
		559000037,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Harare Thermal Power Station',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Lion's Den Grain Silos (Grain Marketing Board)
-- Largest grain stores in Zimbabwe (third largest in world?)
-- see: https://www.herald.co.zw/gmb-needs-3m-for-lions-den-silos/

update africa_osm_nodes
set name = 'Grain Silos (Grain Marketing Board)',
railway = 'stop',
facility = 'food storage',
comment = 'Largest grain store in Zimbabwe ("third largest in world")
see: https://www.herald.co.zw/gmb-needs-3m-for-lions-den-silos/'
where oid = 555120311;

-- split 5550440982 at 555120310
select rn_split_edge(array[5550440982], array[555120310]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555120310,
		555120311,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Lion''s Den Grain Silos (Grain Marketing Board)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Chinhoyi

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000038,
 null,
 null,
 'Zimbabwe',
 null,
 null,
 ST_SetSRID(ST_Point(30.18258,-17.37476), 4326)
 )
;

select rn_copy_node(array[558000038], array[555044116]);
delete from africa_osm_nodes where oid = 558000038;

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000039,
 'stop',
 'Grain depot (Grain Marketing Board)',
 'Zimbabwe',
 null,
 'food storage',
 ST_SetSRID(ST_Point(30.18433,-17.37458), 4326)
 )
;

select rn_insert_edge(559000038, 558000039, 556000071);

-- split 555044109 at 555087975
select rn_split_edge(array[555044109], array[555087975]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555087975,
		558000039,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Chinhoyi grain depot (Grain Marketing Board)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Darwendale Tunnels Military Cantonment
-- 555088904

update africa_osm_nodes
set name = 'Darwendale Tunnels Military Cantonment',
railway = 'stop',
facility = 'military'
where oid = 555088904;

-- split 555095716 at 555088905
select rn_split_edge(array[555095716], array[555088905]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555088901,
		555088904,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Darwendale Tunnels Military Cantonment',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Trojan Nickel Mine
-- https://miningdataonline.com/property/1249/Trojan-Mine.aspx

update africa_osm_nodes
set name = 'Trojan Nickel Mine',
railway = 'stop',
facility = 'mine',
comment = 'Nickel mine. See:  https://miningdataonline.com/property/1249/Trojan-Mine.aspx'
where oid = 555080935;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555080933,
		555080935,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Trojan Nickel Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Bundura grain and cotton depots

update africa_osm_nodes
set name= 'Bundura grain and cotton depots',
facility = 'storage',
railway = 'stop'
where oid = 555090978;

-- split 555034028 at 555014831
select rn_split_edge(array[555034028], array[555014831]);
-- split 5550340281 at 555090977
select rn_split_edge(array[5550340281], array[555090977]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555014831,
		555090978,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bundura grain and cotton depots',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'status unclear.'
where oid in (select edge from tmp);

-- Asplindale business area (Harare)
update africa_osm_nodes
set name = 'Asplindale business area (Harare)',
facility = 'Business area',
railway = 'stop'
where oid = 555065152;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555065151,
		555065152,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Asplindale business area (Harare)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'status unclear.'
where oid in (select edge from tmp);

-- Workington Business area (Harare)

update africa_osm_nodes
set name = 'Workington business area (Harare)',
facility = 'Business area',
railway = 'stop'
where oid = 555109635;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555104060,
		555109635,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Workington business area (Harare)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'status unclear.'
where oid in (select edge from tmp);

-- Southerton business area (Harare)

update africa_osm_nodes
set name = 'Southerton business area (Harare)',
facility = 'Business area',
railway = 'stop'
where oid = 555119316;

select rn_insert_edge(555109636, 555109605, 556000072);

-- split 555001335 at 555109636
-- split 555003302 at 555109605
-- split 555003301 at 555064809
-- split 555003294 at 555119315

select rn_split_edge(array[555001335, 555003302, 555003301, 555003294], array[555109636, 555109605, 555064809, 555119315]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555109636,
		555119316,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Southerton business area (Harare)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'status unclear.'
where oid in (select edge from tmp);

-- Willowvale Industrial area (Harare)

update africa_osm_nodes
set name = 'Willowvale business area (Harare)',
facility = 'Business Area',
railway = 'stop'
where oid = 555109542;

-- split 555004258 at 555109541
select rn_split_edge(array[555004258], array[555109541]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555109541,
		555109542,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Willowvale business area (Harare)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'status unclear.'
where oid in (select edge from tmp);

-- Msasa Fuel Depot, Harare (NOIC)
update africa_osm_nodes
set name = 'Msasa Fuel Depot (NOIC)',
railway = 'stop',
facility = 'Fuel depot',
comment = 'There is a petroleum pipeline from Beira in Mozambique to Msasa depot in Harare. See: https://allafrica.com/stories/201503270241.html'
where oid = 555101996;

-- split 555037064 at 555101999
select rn_split_edge(array[555037064], array[555101999]);

--split 555064836 at 555101998
select rn_split_edge(array[555064836], array[555101998]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555101999,
		555101996,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Msasa Fuel Depot, Harare (NOIC)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Manresa cement plant (Lafarge)

update africa_osm_nodes
set name = 'Manresa cement plant (Lafarge)',
railway = 'stop',
facility = 'Cement plant'
where oid = 555109550;

-- split 555037067 at 555109547
select rn_split_edge(array[], array[]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555109547,
		555109550,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Manresa cement plant (Lafarge)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Marondera business area

update africa_osm_nodes set name = 'Marondera' where oid =555020668;

-- simplify routing from Marondera station
select rn_insert_edge(555020668, 555108601, 556000073);

update africa_osm_nodes
set name = 'Marondera business area',
facility = 'Business area',
railway = 'stop'
where oid = 555108574;

-- split 555073283 at 555108601
-- split 555073282 at 555108575
select rn_split_edge(array[555073283, 555073282], array[555108601, 555108575]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555020668,
		555108574,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Marondera business area',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Nyakamete Industrial Area (Mutare)

update africa_osm_nodes
set name = 'Nyakamete Industrial Area (Mutare)',
facility = 'Business area',
railway = 'stop'
where oid = 555095110;

-- split 555083429 at 555084676
-- split 555039151 at 555084151

select rn_split_edge(array[555083429, 555039151], array[555084676, 555084151]);

-- split 5550391511 at 555084150
-- split 555039167 at 555084651

select rn_split_edge(array[5550391511, 555039167], array[555084150, 555084651]);

-- split 555039157 at 555084650
select rn_split_edge(array[555039157], array[555084650]);
-- split 5550391572 at 555084135
select rn_split_edge(array[5550391572], array[555084135]);
-- split 555039156 at 555084153
-- split 555039173 at 555095109
select rn_split_edge(array[555039156, 555039173], array[555084153, 555095109]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555084676,
		555095110,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Nyakamete Industrial Area (Mutare)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Mutare grain store (Grain Marketing Board)
-- 555084154

update africa_osm_nodes
set name = 'Mutare grain store (Grain Marketing Board)',
railway = 'stop',
facility = 'Food storage'
where oid = 555084154;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555095109,
		555084154,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mutare grain store (Grain Marketing Board)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Feruka Oil Refinery
update africa_osm_nodes
set name = 'Feruka Oil Refinery',
railway = 'stop',
facility = 'Oil refinery',
comment = 'Connected by the Feruka Pipeline to Beira in Mozambique where Zimbabwe''s fuel imports are shipped via. See: http://bit.ly/3lB735N'
where oid = 555091018;

-- split 555036924 at 555091019
select rn_split_edge(array[555036924], array[555091019]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555091019,
		555091018,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Feruka Oil Refinery',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Spur built 2021. See: http://bit.ly/3lB735N'
where oid in (select edge from tmp);

-- Grain Marketing Board - Rusape
update africa_osm_nodes
set name = 'Grain depot, Rusape (Grain Marketing Board)',
railway = 'stop',
facility = 'Food storage'
where oid = 555118565;

-- split 555084894 at 555118566
-- split 555084897 at 555118569
-- spit 555084899 at 555118573
-- split 555084900 at 555118575
-- split 555037117 at 555118577

select rn_split_edge(array[555084894,555084897,555084899,555084900,555037117], array[555118566,555118569,555118573,555118575,555118577]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555118577,
		555118565,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Grain depot, Rusape (GMB)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Grain silos (GMB) Chegutu
update africa_osm_nodes
set name = 'Grain silos, Chegutu (Grain Marketing Board)',
railway = 'stop',
facility = 'Food storage'
where oid = 555107410;

-- simplify routing
select rn_insert_edge(555107402, 555029212, 556000074);

--split 555071994 at 555107402
-- split 555072006 at 555107400
-- split 555071993 at 555107409
select rn_split_edge(array[555071994, 555072006, 555071993], array[555107402,555107400,555107409]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555029212,
		555107410,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Grain silos, Chegutu (Grain Marketing Board)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Empress Nickel Refinery, Kadoma
update africa_osm_nodes
set name = 'Empress Nickel Refinery, Kadoma',
railway = 'stop',
facility = 'manufacturing',
comment = 'see: https://www.riozim.co.zw/?page_id=231'
where oid = 555106830;

-- split 555037080 at 555106829
select rn_split_edge(array[555037080], array[555106829]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555106829,
		555106830,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Empress Nickel Refinery, Kadoma',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kadona paper mills
update africa_osm_nodes
set name = 'Kadona paper mills',
railway = 'stop',
facility = 'manufacturing'
where oid = 555138781;

-- split 555037076 at 555138775
select rn_split_edge(array[555037076], array[555138775]);
-- split 555111692 at 555138768
select rn_split_edge(array[555111692], array[555138768]);
-- simplify
select rn_insert_edge(555138775, 555138768, 556000075);
-- split 5551116921 at 555138781
select rn_split_edge(array[5551116921], array[555138781]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555138775,
		555138781,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kadona paper mills',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Sable Chemical Industries, Kwekwe
-- manufacturer of nitrogen-based fertilizer
update africa_osm_nodes
set name = 'Sable Chemical Industries, Kwekwe',
railway = 'stop',
facility = 'manufacturing',
comment = 'manufacturer of nitrogen-based fertilizer, see: https://en.wikipedia.org/wiki/Sable_Chemicals'
where oid = 555120589;

-- split 555037096 at 555120588
select rn_split_edge(array[555037096], array[555120588]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555120588,
		555120589,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sable Chemical Industries, Kwekwe',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Zimasco Kwekwe
-- Chrome smelting (production of ferrochrome)
update africa_osm_nodes
set railway = 'stop',
name = 'Zimasco Kwekwe',
comment = 'Chrome smelting (production of ferrochrome)'
where oid = 555109398;

-- split 555074818 at 555109395
select rn_split_edge(array[555074818], array[555109395]);
-- split 555074875 at 555109397
select rn_split_edge(array[555074875], array[555109397]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555082833,
		555109398,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Zimasco Kwekwe',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kweke industrial area
update africa_osm_nodes
set name = 'Kweke industrial area',
railway = 'stop',
facility = 'Industrial area'
where oid = 555030351;

-- simplify routing
select rn_insert_edge(555109333, 555109355, 556000076);
-- split 555074809 at 555109333
select rn_split_edge(array[555074809], array[555109333]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555109333,
		555030351,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kweke industrial area',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Zisco steel plant, Redcliff
-- reported in Feb. 2022 that has been closed for a decade but hopes of operations starting again.
-- assume currently disused.

update africa_osm_nodes
set name = 'Zisco steel plant (Redcliff)',
railway = 'stop',
facility = 'manufacturing',
comment = 'Reported in 2022 that has been closed since 2008 but hopes of operations starting again, perhaps in 2023. See: https://bit.ly/3K5EnMi'
where oid = 555129030;

-- split 555050136 at 555129030
select rn_split_edge(array[555050136], array[555129030]);
-- split 555037099 at 555091905
select rn_split_edge(array[555037099], array[555091905]);
-- split 555050122 at 555091906
select rn_split_edge(array[555050122], array[555091906]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555091905,
		555129030,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Zisco steel plant, Redcliff',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Reported in 2022 that the plant has been closed since 2008 but hopes of operations starting again, perhaps in 2023. See: https://bit.ly/3K5EnMi. Assume that the rail spur is disused currently'
where oid in (select edge from tmp);

-- Grain depot, Gweru (Grain Marketing Board)
update africa_osm_nodes
set name = 'Grain depot, Gweru (Grain Marketing Board)',
railway = 'stop',
facility = 'food storage'
where oid = 555118401;

-- split 555039205 at 555118406
select rn_split_edge(array[555039205], array[555118406]);
-- split 555039212 at 555084185
select rn_split_edge(array[555039212], array[555084185]);
-- split 555084610 at 555118403
select rn_split_edge(array[555084610], array[555118403]);
-- split 5550846101 at 555118402
select rn_split_edge(array[5550846101], array[555118402]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555063796,
		555118401,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Grain depot, Gweru (Grain Marketing Board)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Zimbabwe Alloys (ZimAlloys) Chrome mine and smelting plant
update africa_osm_nodes
set name = 'Zimbabwe Alloys chrome mine and smelting plant',
railway = 'stop',
facility = 'mine'
where oid = 555118399;

-- split 55508461011 at 555118400
select rn_split_edge(array[55508461011], array[555118400]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555118402,
		555118399,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Zimbabwe Alloys chrome mine and smelting plant',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Zuva Gweru Terminal (petroleum storage)
update africa_osm_nodes
set name = 'Zuva Gweru Terminal',
railway = 'stop',
facility = 'fuel storage terminal'
where oid = 555104955;

-- split 555001200 at 555084193
-- split 555039213 at 555104956
select rn_split_edge(array[555001200,555039213], array[555084193,555104956]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555084193,
		555104955,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Zimbabwe Alloys chrome mine and smelting plant',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Shangani Mine
-- Nickel
-- see http://bit.ly/40S3qse

update africa_osm_nodes
set name = 'Shangani Mine',
railway = 'stop',
facility = 'mine',
comment = 'Nickel mine. See: http://bit.ly/40S3qse'
where oid = 555128160;

-- split 555068591 at 555128161
select rn_split_edge(array[555068591], array[555128161]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555128161,
		555128160,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Shangani Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Kelvin industrial area, Bulawayo

update africa_osm_nodes
set name = 'Kelvin industrial area, Bulawayo',
railway = 'stop',
facility = 'Industrial area'
where oid = 555104218;

-- split 555095685 at 555104224
select rn_split_edge(array[555095685], array[555104224]);

-- split 555068234 at 555104218
select rn_split_edge(array[555068234], array[555104218]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555104426,
		555104218,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kelvin industrial area, Bulawayo',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- stone quarry (Davis Granite)
update africa_osm_nodes
set name = 'Stone quarry (Davis Granite)',
railway = 'stop',
facility = 'quarry'
where oid = 555123520;

-- split 555068233 at 555123519
select rn_split_edge(array[555068233], array[555123519]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555123519,
		555123520,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Stone quarry (Davis Granite)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Bulawayo grain silos (Grain Marketing Board)
update africa_osm_nodes
set name = 'Bulawayo grain silos (Grain Marketing Board)',
facility = 'food storage',
railway = 'stop'
where oid = 555104219;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555104218,
		555104219,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bulawayo grain silos (Grain Marketing Board)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Fuel storage terminals (ZUVA and Total)
update africa_osm_nodes
set name = 'Fuel storage terminals (ZUVA and Total)',
railway = 'stop',
facility = 'fuel storage'
where oid = 555104469;

-- split 5550683472 at 555104866
select rn_split_edge(array[5550683472], array[555104866]);
-- split 555068194 at 555104867
-- split 555068236 at 555104156
-- split 555068237 at 555104469
select rn_split_edge(array[555068194,555068236,555068237], array[555104867,555104156,555104469]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555104866,
		555104469,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Fuel storage terminals (ZUVA and Total)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Bulawayo Power Station
update africa_osm_nodes
set name = 'Bulawayo Power Station',
railway = 'stop',
facility = 'power station'
where oid = 555084170;

-- split 555039192 at 555104891
select rn_split_edge(array[555039192], array[555104891]);
-- simplify
select rn_insert_edge(555104836, 555104891, 556000077);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555104836,
		555084170,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bulawayo Power Station',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Belmont and Donnington industrial areas, Bulawayo

update africa_osm_nodes
set name = 'Belmont and Donnington industrial areas, Bulawayo',
railway = 'stop',
facility = 'industrial area'
where oid = 555077131;

-- split 555095684 at 555104851
-- split 555068199 at 555104622
-- split 555027136 at 555077131
select rn_split_edge(array[555095684,555068199,555027136], array[555104851,555104622,555077131]);

-- simplify join 555091546 to 555104622
select rn_insert_edge(555091546, 555104622, 556000078);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555104851,
		555077131,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Belmont and Donnington industrial areas, Bulawayo',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Hwange Colliery Railway
-- Privately owned - exchange to NRZ at Thomson Junction
-- see: https://en.wikipedia.org/wiki/Hwange_Colliery
update africa_osm_nodes
set name = 'Hwange Colliery',
railway = 'stop',
facility = 'mine',
comment = 'Coal mine'
where oid = 555097008;

-- split 555020913 at 555119549
-- split 555036939 at 555097004
select rn_split_edge(array[555020913,555036939], array[555119549,555097004]);

-- split 5550369392 at 555097011
-- split 555057381 at 555096996
-- split 555057329 at 555096997
-- split 555057330 at 555096940
-- split 555057326 at 555096966
select rn_split_edge(array[5550369392,555057381,555057329,555057330,555057326], array[555097011,555096996,555096997,555096940,555096966]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555119549,
		555097008,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hwange Colliery Railway',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Privately owned railway - exchange with NRZ at Thomson Junction. See: https://en.wikipedia.org/wiki/Hwange_Colliery'
where oid in (select edge from tmp);

-- Hwange Thermal Power Station
-- see: https://en.wikipedia.org/wiki/Hwange_Thermal_Power_Station

update africa_osm_nodes
set name = 'Hwange Thermal Power Station',
facility = 'power station',
railway = 'stop',
comment = 'See: https://en.wikipedia.org/wiki/Hwange_Thermal_Power_Station'
where oid = 555082775

-- split 555036938 at 555082774
select rn_split_edge(array[555036938], array[555082774]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555097004,
		555082775,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hwange Thermal Power Station',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Zuva Hwange fuel terminal
update africa_osm_nodes
set name = 'ZUVA Hwange fuel terminal',
facility = 'fuel storage',
railway = 'stop'
where oid = 555117041;

-- insert (simplified) missing connection to main line
select rn_insert_edge(555117042, 555028021, 556000079);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555028021,
		555117041,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Zuva Hwange fuel terminal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Colleen Bawn Limestone mine (Pretoria Portland Cement)
update africa_osm_nodes
set name = 'Colleen Bawn limestone mine (Pretoria Portland Cement)',
railway = 'stop',
facility = 'mine',
comment = 'Limestone mine. See: https://en.wikipedia.org/wiki/Colleen_Bawn'
where oid = 555091004;

-- Colleen Bawn Cement Plant (Pretoria Portland Cement)
update africa_osm_nodes
set name = 'Colleen Bawn cement plant (Pretoria Portland Cement)',
railway = 'stop',
facility = 'manufacturing',
comment = 'Cement plant. See: https://en.wikipedia.org/wiki/Colleen_Bawn'
where oid = 555091005;

-- split 555091633 at 555091007
select rn_split_edge(array[555091633], array[555091007]);
-- split 555049222 at 555091006
select rn_split_edge(array[555049222], array[555091006]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555091007,
		555091004,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Colleen Bawn Limestone mine (Pretoria Portland Cement)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555091006,
		555091005,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Colleen Bawn Cement Plant (Pretoria Portland Cement)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Gwanda grain depot (Grain Marketing Board)
update africa_osm_nodes
set name = 'Gwanda grain depot (Grain Marketing Board)',
railway = 'stop',
facility = 'food storage'
where oid = 555107879;

-- split 555033610 at 555107878
select rn_split_edge(array[555033610], array[555107878]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555107878,
		555107879,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gwanda grain depot (Grain Marketing Board)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Zvishavane Branch
-- freight only

update africa_osm_nodes
set name = 'Zvishavane',
railway = 'stop'
where oid = 555147288;

-- split 

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555027634,
		555147288,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Zvishavane Branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- correct stations

-- Chegutu
select rn_copy_node(array[555062516], array[555037043]);
-- Kwekwe
select rn_copy_node(array[555062592], array[555074812]);
-- Gweru 
select rn_copy_node(array[555062222], array[555095708]);
-- Plumtree
select rn_copy_node(array[555008697], array[555074962]);
-- Mpopoma
select rn_copy_node(array[555050506], array[555099014]);

update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('Zimbabwe') and railway in ('station', 'halt', 'stop');

update africa_osm_nodes
set gauge = '610'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '610'))
and country in ('Zimbabwe') and railway in ('station', 'halt', 'stop');

-- extract tables (backup)
create table zimbabwe_osm_edges as select * from africa_osm_edges where country in ('Zimbabwe');
create table zimbabwe_osm_nodes as select * from africa_osm_nodes where country in ('Zimbabwe');

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555146813,
		555046348,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			
			
			





























