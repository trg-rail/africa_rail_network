-- South Africa

select railway, count(*) from africa_osm_nodes where country in ('South Africa') group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country in ('South Africa') group by railway order by count desc;

select status, count(*) from africa_osm_edges where country in ('South Africa') group by status order by count desc;

select type, count(*) from africa_osm_edges where country in ('South Africa') group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country in ('South Africa') and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country in ('South Africa') group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country in ('South Africa') group by gauge order by gauge desc;


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

select rn_copy_node(array[555088831], array[555109496]);
-- split 555057610 at 555088831
select rn_split_edge(array[555057610], array[555088831]);

select rn_change_target(5550576101, 556088831);

-- Sishen - Saldanha Line
-- Freight only
-- iron ore - serve several mines near Sishen
-- electrified

-- Saldanha Iron Ore Terminal
-- Saldanha port

Update africa_osm_nodes
set name = 'Port of Saldanha',
facility = 'port',
railway = 'stop'
where oid =  555097172;

-- join 
select rn_copy_node(array[], array[]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555064147,
		555097172,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sishen - Saldanha Line',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Core Network. Primarily transport of iron ore - serves several mines near Sishen'
where oid in (select edge from tmp);

-- Iron Ore Terminal
Update africa_osm_nodes
set name = 'Iron Ore Terminal',
facility = 'terminal',
railway = 'stop'
where oid =  555137060;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            556088831,
		555137060,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sishen - Saldanha Line (Iron Ore Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Primarily transport of iron ore - serves several mines near Sishen. Electrified.'
where oid in (select edge from tmp);



-- Kolomela Mine
update africa_osm_nodes
set name = 'Kolomela Mine',
facility = 'mine',
railway = 'stop',
comment = 'Iron ore mine'
where oid = 555028653;

-- split 555078445 at 555111406
select rn_split_edge(array[555078445], array[555111406]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555111406,
		555028653,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sishen - Saldanha Line (Kolomela Mine)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

update africa_osm_edges
set structure = 'tunnel'
where oid in (555072295, 555070255);

update africa_osm_edges
set structure = 'bridge'
where oid in (555021187);

-- Khumani Mine
update africa_osm_nodes
set name = 'Khumani Mine',
facility = 'mine',
railway = 'stop',
comment = 'Iron ore mine'
where oid = 555084351;

-- split 555078438 at 555106327
select rn_split_edge(array[555078438], array[555106327]);

--split 555070538 at 555113410
select rn_split_edge(array[555070538], array[555113410]);
-- split 555039493 at 555084339
select rn_split_edge(array[555039493], array[555084339]);
-- split 5550394932 at 555084351
select rn_split_edge(array[5550394932], array[555084351]);
-- split 555078449 at 555113415
select rn_split_edge(array[555078449], array[555113415]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555106327,
		555084351,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sishen - Saldanha Line (Khumani Mine)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- link to Hotazel - Postmasburg line

-- split 55503949322 at 555106339
-- split 555089133 at 555106110
select rn_split_edge(array[55503949322,555089133], array[555106339,555106110]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid != 555039493222',
            555106110,
		555084351,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hotazel - Postmasburg Line (Khumani Mine)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Sishen Mine
update africa_osm_nodes
set name = 'Sishen Mine',
facility = 'mine',
railway = 'stop',
comment = 'Iron ore mine'
where oid = 555009459;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555064147,
		555009459,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sishen - Saldanha Line (Sishen Mine)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- link to Hotazel - Postmasburg line

-- split 555001939 at 555106113
select rn_split_edge(array[555001939], array[555106113]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555106113,
		555106110,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hotazel - Postmasburg Line (Sishen Mine)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

--  Kalbaskraal - Saldanha
-- Freight only

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555007534,
		555002086,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kalbaskraal - Saldanha',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Core Network'
where oid in (select edge from tmp);

-- link onto Sishen - Saldanha Line for port access

-- simplify
select rn_insert_edge(555010478, 555088813, 556000089);

-- split 555010553 at 555075274
select rn_split_edge(array[555010553], array[555075274]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555075274,
		555088813,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kalbaskraal - Saldanha (Port of Saldanha)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Core Network'
where oid in (select edge from tmp);

-- Malmesbury - Bitterfontein
-- Freight only

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555114111,
		555001944,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Malmesbury - Bitterfontein',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Core Network'
where oid in (select edge from tmp);

-- link to Sishen - Saldanha Line
select rn_split_edge(array[555047274], array[555075011]);

	 insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000100,
 null,
 null,
 'South Africa',
 null,
 null,
 ST_SetSRID(ST_Point(18.46917,-31.59718), 4326)
 )
;

select rn_copy_node(array[558000100], array[555024490]);
-- 559000100

select rn_insert_edge(559000100, 555088422, 556000090);
-- split 555003885 at 555088422
select rn_split_edge(array[555003885], array[555088422]);
-- split 555047274 at 555075011
select rn_split_edge(array[555047274], array[555075011]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555075011,
		555088422,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Malmesbury - Bitterfontein (Link to Sishen - Saldanha Line)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Core Network'
where oid in (select edge from tmp);


-- Metrorail Cape Town services

-- Cape Town access

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555045169,
		555008897,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cape Town (all routes)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Capetown - Ysterplaat
-- part Northern Line / Central Line / Malmesbury

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555008897,
		555000118,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Capetown - Ysterplaat',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Northern / Central / Malmesbury Lines'
where oid in (select edge from tmp);

-- Ysterplaat - Bellville via Monte Vista (Nothern Line)

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid not in (555030266, 555030268, 555030387, 555002567, 555030378)',
            555000118,
		555062120,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ysterplaat - Bellville via Monte Vista',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Nothern / Malmesbury Lines'
where oid in (select edge from tmp);


-- Cape Town - Salt River
-- Northern / Central / Southern / Cape Flats Lines

-- split 555112640 at 555072049
select rn_split_edge(array[555112640], array[555072049]);
-- split 555112458 at 555072050
select rn_split_edge(array[555112458], array[555072050]);


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555008897,
		555045341,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cape Town - Salt River',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Northern / Central / Southern / Cape Flats Lines'
where oid in (select edge from tmp);

-- Salt River - Maitland
-- Northern / Central / Cape Flats Lines

update africa_osm_nodes
set railway = 'station'
where oid = 555062087;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555045341,
		555062087,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Salt River - Maitland',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Northern / Central / Cape Flats Lines'
where oid in (select edge from tmp);

-- Maitland - Pinelands
-- Central / Cape Flats Lines

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555062087,
		555062090,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Maitland - Pinelands',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Central / Cape Flats Lines'
where oid in (select edge from tmp);

-- Maitland - Bellville
-- Northern Line (Bellville via Mutual)

--simplify routing into Bellville

select rn_insert_edge(555013585, 555062120, 556000091);

-- simplify routing from Maitland - Mutual
-- link 555072294 to 555062087
select rn_insert_edge(555072294, 555062087, 556000093);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555062087,
		555062120,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Maitland - Bellville',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Northern Line (Bellville via Mutual)'
where oid in (select edge from tmp);

-- Pinelands - Langa (Central Line via Maitland)

update africa_osm_nodes
set railway = 'station'
where oid = 555062651;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555062090,
		555062651,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pinelands - Langa',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Central Line via Maitland'
where oid in (select edge from tmp);

-- Yesterplaat - Langa (Central Line via Yesterplaat)

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555079179,
		555062651,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Yesterplaat - Langa',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Central Line via Yesterplaat'
where oid in (select edge from tmp);

-- Langa - Sarepta (Central Line)

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid not in (555112286, 555030764, 555030755, 555030763, 555033854, 555018713, 555017041)',
            555062651,
		555013632,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Langa - Sarepta',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Central Line'
where oid in (select edge from tmp);

-- Sarepta - Bellville
  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid not in (555112286, 555030764, 555030755, 555030763, 555033854, 555018713, 555017041)',
            555013632,
		555013607,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sarepta - Bellville',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Central Line / Northern Line'
where oid in (select edge from tmp);

-- Central line branches
-- Bonteheuwel - Chris Hani
-- Philippi - Kapteinship
-- The branches are out of use due to vandelisim and theft. See: http://bit.ly/3YAPe4o.

-- simplify
select rn_insert_edge(555013693, 555079527, 556000094);
-- split 555112264 at 555079527
select rn_split_edge(array[555112264], array[555079527]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555079527,
		555063097,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bonteheuwel - Chris Hani',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'suspended',
comment = 'Central Line. Branches out of use due to vandalism and theft. See: http://bit.ly/3YAPe4o.'
where oid in (select edge from tmp);

-- split 555081414 at 555116288
select rn_split_edge(array[555081414], array[555116288]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555116288,
		555046503,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Philippi - Kapteinship',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'suspended',
comment = 'Central Line. Branches out of use due to vandalism and theft. See: http://bit.ly/3YAPe4o.'
where oid in (select edge from tmp);

-- Bellville - Kraaifontein (Northern Line and Wellington Line)

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555062120,
		555000112,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bellville - Kraaifontein',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Nothern / Wellington / Malmesbury Lines'
where oid in (select edge from tmp);

-- Wellington Line (Kraaifontein - Wellington

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555000112,
		555046563,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Wellington Line (Kraaifontein - Wellington)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Malmesbury Line (Kraaifontein - Malmesbury)

-- simplify

select rn_insert_edge(555013649, 555079351, 556000092);




-- Port of Cape Town and Container Terminal

update africa_osm_nodes
set name = 'Port of Cape Town (container terminal)',
railway = 'stop',
facility = 'container terminal'
where oid = 555031839;

-- split 555112197 at 555115241
select rn_split_edge(array[555112197], array[555115241]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555115241,
		555031856,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Cape Town (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Core Network'
where oid in (select edge from tmp);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555031856,
		555031839,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Cape Town (container terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Core Network'
where oid in (select edge from tmp);

update africa_osm_nodes
set name ='Port of Cape Town (Berths B-D)',
railway = 'stop',
facility = 'port'
where oid = 555031611;

update africa_osm_nodes
set name ='Port of Cape Town (Berths E-L)',
railway = 'stop',
facility = 'port'
where oid = 555031755;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555031856,
		555031611,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Cape Town',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555031650,
		555031755,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line ='Port of Cape Town (Berths E-L)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            ,
		555031755,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Cape Town (Berths E-L)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555031856,
		,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Cape Town (berths)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Southern Line (metrorail)
-- Salt River - Fish Hoek
update africa_osm_nodes
set railway = 'station'
where oid = 555045341;

-- copy fish hoek station

select rn_copy_node(array[555000031], array[555015300]);

-- simplify
select rn_insert_edge(555072159, 555045341, 556000095);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid not in (555015548, 555019095)',
            555045341,
		556000031,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Salt River - Fish Hoek',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Southern Line'
where oid in (select edge from tmp);

-- Fish Hoek - Simon's Town (Shuttle)

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            556000031,
		555000036,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Fish Hoek - Simon''s Town',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Shuttle'
where oid in (select edge from tmp);

-- Cape Flats Line

-- split 555033824 at 555072315
select rn_split_edge(array[555033824], array[555072315]);

-- split 555112628 at 555072316
select rn_split_edge(array[555112628], array[555072316]);


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555072315,
		555072681,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pinelands- Heathfield',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Cape Flats Line'
where oid in (select edge from tmp);

-- Bellville Marshalling Yard - freight

update africa_osm_nodes
set name = 'Bellville Marshalling Yard',
facility = 'freight marshalling yard',
railway ='stop'
where oid = 555002609;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid != 555058502',
            555013566,
		555002609,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bellville Marshalling Yard',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555013603,
		555002609,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bellville Marshalling Yard',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Epping Industria 1 and 2

-- simplify routing
select rn_insert_edge(555064443, 555079514, 556000096);

-- split 555030763 at 555064443
select rn_split_edge(array[555030763], array[555064443]);

update africa_osm_nodes
set name = 'Epping Industria 1 and 2',
facility = 'industrial area',
railway = 'stop'
where oid = 555031979;


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555079514,
		555031979,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bellville Marshalling Yard',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Freight Line to Atlantis Industrial area

update africa_osm_nodes
set name = 'Atlantis Industrial',
railway = 'stop',
facility = 'industrial area'
where oid = 555015282;

-- split 5551121972 at 555115251
select rn_split_edge(array[5551121972], array[555115251]);
-- split 555030412 at 555115254
select rn_split_edge(array[555030412], array[555115254]);


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555115251,
		555015282,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Atlantis line',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Branch Line'
where oid in (select edge from tmp);

-- Montague Gardens Industrial Area

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555032102,
		555032107,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Montague Gardens Industrial Area',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Engen Cape Town fuel storage terminal
-- http://bit.ly/3TdiDk8


update africa_osm_nodes
set name = 'Engen Cape Town Terminal',
railway = 'stop',
facility = 'fuel storage'
where oid = 555032087;


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555115225,
		555032087,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Engen Cape Town Terminal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'see: http://bit.ly/3TdiDk8'
where oid in (select edge from tmp);

-- PPC Cement Works

update africa_osm_nodes
set name = 'PPC Cement Works',
railway = 'stop',
facility = 'manfacturing'
where oid = 555032110;


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555032104,
		555032110,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'PPC Cement Works',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Northern Line (Full)
-- Sarepta - Erste River

update africa_osm_nodes
set railway = 'station'
where oid = 555000105;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555013632,
		555063472,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sarepta - Erste River',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Northern Line (Full). Transnet Core Network.'
where oid in (select edge from tmp);

-- Erste River - Muldersvlei

select rn_copy_node(array[555000100], array[555112779]);
-- simplify routing
select rn_insert_edge(555056542, 556000100, 556000098);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid != 555112826',
            555063472,
		556000100,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Erste River - Muldersvlei',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Northern Line (Full)'
where oid in (select edge from tmp);

-- Erste River - Firgrove

-- split 555000475 at 555051181
select rn_split_edge(array[555000475], array[555051181]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555063472,
		555017655,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Erste River - Firgrove',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Northern Line (Full). Transnet Core Network. Overberg Line'
where oid in (select edge from tmp);

-- Firgrove - Van der Stel

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555017655,
		555051183,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Firgrove - Van der Stel',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Northern Line (Full). Transnet Branch Network. Overberg Line.'
where oid in (select edge from tmp);

-- Van der Stel - Strand
-- Northern Line (Full)
-- passenger only (?)

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555051183,
		555002396,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Van der Stel - Strand',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Northern Line (Full).'
where oid in (select edge from tmp);

-- Van der Stel - Klipdale
-- Overberg Branch Line
-- Freight only.

-- split 555039578 at 555067934
select rn_split_edge(array[555039578], array[555067934]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555051183,
		555006095,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Van der Stel - Klipdale',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Branch Network. Overberg Line.'
where oid in (select edge from tmp);

-- Klipdale - Protem

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555006095,
		555002071,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Klipdale - Protem',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Branch Network. Overberg Line.'
where oid in (select edge from tmp);

-- Klipdale - Bredasdorp
  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555067934,
		555008368,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Klipdale - Bredasdorp',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Branch Network. Overberg Line.'
where oid in (select edge from tmp);

-- Klipdale grain silos (Overberg Agri (Pty) Ltd)
update africa_osm_nodes
set name = 'Klipdale grain silos',
railway = 'stop',
facility = 'food storage',
comment = 'Overberg Agri (Pty) Ltd; see: https://bit.ly/3ThmLzz'
where oid = 555017418;

-- split 5550395782 at 555084844
select rn_split_edge(array[5550395782], array[555084844]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555084844,
		555017418,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Klipdale grain silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Bredasdorp grain silos (Overberg Agri (Pty) Ltd)
update africa_osm_nodes
set name = 'Bredasdorp grain silos',
railway = 'stop',
facility = 'food storage',
comment = 'Overberg Agri (Pty) Ltd; see: https://bit.ly/3ThmLzz'
where oid = 555084785;

-- split 555110562 at 555084784
select rn_split_edge(array[555110562], array[555084784]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555008368,
		555084785,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bredasdorp grain silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Caledon grain silos (Overberg Agri (Pty) Ltd)

	 insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, comment, geom)
 values (
 558000101,
 'stop',
 'Caledon grain silos',
 'South Africa',
 '1067',
 'food storage',
 'Overberg Agri (Pty) Ltd; see: https://bit.ly/3ThmLzz',
 ST_SetSRID(ST_Point(19.42724,-34.23739), 4326)
 )
;

select rn_copy_node(array[558000101], array[555025502]);
-- 559000101

-- split 555093565 at 555075818
select rn_split_edge(array[555093565], array[555075818]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555075818,
		559000101,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Caledon grain silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Maltings plant (South African Breweries (SAB))
-- production of malted barley.
update africa_osm_nodes
set name = 'Maltings plant',
railway = 'stop',
facility = 'food production',
comment = 'Production of malted barley - South African Breweries (SAB)'
where oid = 555067901;

-- split 5550935652 at 555067900
select rn_split_edge(array[5550935652], array[555067900]);


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555067900,
		555067901,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Maltings plant',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Munitions factory (Rheinmetall Denel Munition (Pty) Ltd)

update africa_osm_nodes
set name = 'Munitions factory (Rheinmetall Denel Munition)',
railway = 'stop',
facility = 'manufacturing',
comment = 'see: http://bit.ly/3ZMHBJM'
where oid = 555032064;

-- simplify routing
select rn_insert_edge(555017658, 555017655, 556000097);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555017655,
		555032064,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Munitions factory (Rheinmetall Denel Munition)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Line from Paarl to  Franschhoek is disused acccording to Transnet map
-- short length of Tram ("Wine Tram") in Franschhoek

-- simplfy
select rn_copy_node(array[555070934],array[555019300]);
select rn_insert_edge(555070934, 556070934, 556000099);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            556070934,
		555070931,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Paarl - Franschhoek',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Meadow Feeds Paarl (animal feed store)
update africa_osm_nodes
set name = 'Meadow Feeds Paarl (animal feed store)',
railway = 'stop',
facility = 'food storage'
where oid = 555022471;

-- split 555112794 at  555094460
select rn_split_edge(array[555112794], array[555094460]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555055402,
		555022471,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Meadow Feeds Paarl (animal feed store)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Porterville - Wellington
-- Transnet core network

-- Porterville - Hermon

select rn_copy_node(array[555000268], array[555011668]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555002068,
		556000268,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Porterville - Hermon',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Hermon - Wellington

-- split 555121333 at 555145739
select rn_split_edge(array[555121333], array[555145739]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            556000268,
		555046563,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hermon - Wellington',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);



-- Rheinmetall Denel Munition

update africa_osm_nodes
set name = 'Munitions factory (Rheinmetall Denel Munition)',
facility = 'manufacturing',
railway = 'stop'
where oid = 555055377;

-- simplify
select rn_insert_edge(555145663, 555098905, 556000100);

-- split 555110888 at 555091871
-- split 555050096 at 555145663
-- split 555121285 at 555091868
select rn_split_edge(array[555110888,555050096,555121285], array[555091871,555145663,555091868]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555091871,
		555055377,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Munitions factory (Rheinmetall Denel Munition)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- PPC Cement Works

-- update africa_osm_nodes
update africa_osm_nodes
set name = 'PPC Cement Works',
railway = 'stop',
facility = 'manfacturing'
where oid = 555068048;

-- split 555029162 at 555068047
select rn_split_edge(array[555029162], array[555068047]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555068047,
		555068048,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'PPC Cement Works',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Grain silos, Riebeek-Wes (Agrimark Grain)

update africa_osm_nodes
set name = 'Grain silos, Riebeek-Wes (Agrimark Grain)',
facility = 'food storage',
railway = 'stop'
where oid = 555091841;

-- split 555029158 at 555091842
select rn_split_edge(array[555029158], array[555091842]);
-- split 555050038 at 555091840
select rn_split_edge(array[555050038], array[555091840]);


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555091842,
		555091841,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Grain silos, Riebeek-Wes (Agrimark Grain)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Hermon - Worchester
-- Transnet core network

-- split 555011670 at 555094475
select rn_split_edge(array[555011670], array[555094475]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555094475,
		555003205,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hermon - Worcester',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Wolseley - Prince Alfred Hamlet
-- owned by Ceres - private freight line (in conjunction with Transnet)
-- reopened for freight on 2 June 2021

-- split 555111346 at 555068036
select rn_split_edge(array[555111346], array[555068036]);


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555068036,
		555002072,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Wolseley - Prince Alfred Hamlet',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Owned by Ceres - private freight line (in conjunction with Transnet) and reopened for freight on 2 June 2021. See: https://bit.ly/3FsggnU'
where oid in (select edge from tmp);

-- Worcester Industrial Area

update africa_osm_nodes
set name = 'Worcester Industrial Area',
railway = 'stop',
facility = 'industrial area'
where oid = 555015570;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555022445,
		555015570,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Worcester Industrial Area',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Worcester - Mossel Bay (Port of Mossel Bay)
-- Core Transnet network

-- Worcester - Voorbaai

select rn_copy_node(array[555002121], array[555028402]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555003205,
		556002121,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Worcester - Voorbaai',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Port of Mossel Bay
-- Transnet core network

-- split 555010480 at 555076703
select rn_split_edge(array[555010480], array[555076703]);

update africa_osm_nodes
set name = 'Port of Mossel Bay',
railway = 'stop',
facility = 'port'
where oid = 555076704;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555071570,
		555076704,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Mossel Bay',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);


-- Shell Downstream Fuel storage depot
update africa_osm_nodes
set name ='Fuel storage depot',
railway = 'stop',
facility = 'fuel storage'
where oid = 555037689;


-- split 555028400 at 555067951
-- split 555010477 at 555067970
select rn_split_edge(array[555028400,555010477], array[555067951,555067970]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555067931,
		555037689,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Fuel storage depot',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Petro SA Gas to Liquids (GTL) Refinery 
-- see: http://bit.ly/3mSOP0a

--split 555038643 at 555083813
select rn_split_edge(array[555038643], array[555083813]);
split 555128824 at 555083789
select rn_split_edge(array[555128824], array[555083789]);
-- split 555038634 at 555083798
select rn_split_edge(array[555038634], array[555083798]);



update africa_osm_nodes
set name = 'Petro SA Gas to Liquids (GTL) Refinery',
facility = 'fuel refinery',
railway = 'stop',
comment = 'see: http://bit.ly/3mSOP0a'
where oid = 555083813;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555083789,
		555083813,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Petro SA Gas to Liquids (GTL) Refinery',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- grain storage silos, Karringmelk
update africa_osm_nodes
set name = 'Grain storage silos, Karringmelk (SSK Feeds)',
railway = 'stop',
facility = 'food storage',
comment = 'see: https://www.ssk.co.za/en/grain/'
where oid = 555075290;

-- split 555056884 at 555075291
select rn_split_edge(array[555056884], array[555075291]);


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555075291,
		555075290,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Grain storage silos, Karringmelk (SSK Feeds)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- grain storage silos, Karringmelk
update africa_osm_nodes
set name = 'Grain storage silos, Ashton (SSK Feeds)',
railway = 'stop',
facility = 'food storage',
comment = 'see: https://www.ssk.co.za/en/grain/'
where oid = 555016284;

-- split 555050012 at 555082959
select rn_split_edge(array[555050012], array[555082959]);


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555082959,
		555016284,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Grain storage silos, Ashton (SSK Feeds)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Worcester -  De Aar

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555003205,
		555001114,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Worcester -  De Aar',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Voorbaai -- Klipplaat
-- Transnet branch line

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            556002121,
		555073433,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Voorbaai -- Klipplaat',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);

update africa_osm_nodes
set name = 'Voorbaai',
railway = 'station'
where oid = 555083814;

update africa_osm_edges
set line = null,
mode = 'mixed',
gauge = null
where oid = 5550284021;

-- George - Knysna
-- Disused

-- split 555090228 at 555067912
select rn_split_edge(array[555090228], array[555067912]);
-- split 555053160 at 555002024
select rn_split_edge(array[555053160], array[555002024]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555067912,
		555002024,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'George - Knysna',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Oudtshoom - Calitzdorp
-- disused

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555067906,
		555001964,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oudtshoom - Calitzdorp',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);



-- Metrorail (Port Elizabeth (Gqeberha))
-- Metrorail Eastern Cape (Diesel)
-- service currently suspended, e.g. see: https://www.thesouthafrican.com/news/trains-in-eastern-cape-suspended-east-london-prasa-breaking-21-september-2022/

-- Gqeberha (Port Elizabeth) - Kariega (Uitenhage)

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555048152,
		555007705,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gqeberha (Port Elizabeth) - Kariega (Uitenhage)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Metrorail Eastern Cape passenger line. Passenger services are currently suspended due to vandelisim and theft. See: https://bit.ly/3lafchP. Also Transnet branch line'
where oid in (select edge from tmp);

-- Port Elizabeth

-- access route
-- simplify routing
select rn_insert_edge(555121792, 555141342, 556000101);

-- split 555003428 at 555141342
select rn_split_edge(array[555003428], array[555141342]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid != 555107721',
            555121792,
		555036890,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port Elizabeth (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);

-- container terminal

update africa_osm_nodes
set name = 'Port Elizabeth (container terminal)',
facility = 'container terminal',
railway = 'stop'
where oid = 555002979;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555011984,
		555002979,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port Elizabeth (container terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);

-- MPT Quay - General Cargo
update africa_osm_nodes
set name = 'Port Elizabeth (MPT quay - General Cargo)',
facility = 'port',
railway = 'stop'
where oid = 555116337;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555003520,
		555116337,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port Elizabeth (MPT quay - General Cargo)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);

-- Bulk Terminal
update africa_osm_nodes
set name = 'Port Elizabeth (Bulk Terminal)',
facility = 'port',
railway = 'stop',
comment = 'Terminal is used for managanese export and includes manganese storage area'
where oid = 555141217;

select rn_split_edge(array[555091550], array[555141217]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555003520,
		555141217,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port Elizabeth (Bulk Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);

-- Fuel storage Terminal
update africa_osm_nodes
set name = 'Port Elizabeth (fuel storage terminal)',
facility = 'port',
railway = 'stop'
where oid = 555122592;

-- split 555003392 at 555122590
select rn_split_edge(array[555003392], array[555122590]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555036890,
		555122592,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port Elizabeth (Fuel storage Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);

-- PPC Cement Works
update africa_osm_nodes
set name = 'PPC Cement Works',
facility = 'manufacturing',
railway = 'stop'
where oid = 555011829;

-- simplify
select rn_insert_edge(555052009, 555121792, 556000103);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555121792,
		555011829,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'PPC Cement Works',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Avontuur Branch Line (Apple Express)
-- from Humewood Road - Avontuur (and spur to Patensie)
-- rehabilitation
-- 610mm gauge
-- primarily tourist trains APple Express - ceased in 2010.
-- see: https://www.appleexpresstrain.co.za

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555059498,
		555001941,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Avontuur Branch Line (Apple Express)',
mode = 'mixed',
type = 'conventional',
gauge = '610',
status = 'disused',
comment = 'Was used by the tourist train "Apple Express" and some freight services. Apple Express ceased in 2010 and freight services in 2011. Apple Express understood to be undertaking rehabilitation to Baywest Mall, see: https://www.appleexpresstrain.co.za and https://www.youtube.com/watch?v=9-DjjapeomU'
where oid in (select edge from tmp);

-- Patensie spur

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555063976,
		555000207,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Avontuur Branch Line (Apple Express)',
mode = 'mixed',
type = 'conventional',
gauge = '610',
status = 'disused',
comment = 'Was used by the tourist train "Apple Express" and some freight services. Apple Express ceased in 2010 and freight services in 2011. Apple Express understood to be undertaking rehabilitation to Baywest Mall, see: https://www.appleexpresstrain.co.za and https://www.youtube.com/watch?v=9-DjjapeomU'
where oid in (select edge from tmp);

-- section to Baywest mall

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555059498,
		555063255,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Avontuur Branch Line (Apple Express)',
mode = 'mixed',
type = 'conventional',
gauge = '610',
status = 'rehabilitation',
comment = 'Was used by the tourist train "Apple Express" and some freight services. Apple Express ceased in 2010 and freight services in 2011. Apple Express understood to be undertaking rehabilitation to Baywest Mall, see: https://www.appleexpresstrain.co.za and https://www.youtube.com/watch?v=9-DjjapeomU'
where oid in (select edge from tmp);


-- Klipplaat - Uitenhage
-- Transnet branch line

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555000832,
		555007705,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Klipplaat - Uitenhage (and Port Elizabeth)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line (and on to Port Elizabeth/Gqeberha)'
where oid in (select edge from tmp);


-- Klipplaat - Rosmead
-- Disused according to Transnet 2021 Annual Report map

--split 555027056 at 555094762
select rn_split_edge(array[555027056], array[555094762]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555000832,
		555094762,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Klipplaat - Rosmead',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Disused according to Transnet 2021 Annual Report map'
where oid in (select edge from tmp);

-- De Aar - Kimberley

-- copy Kimberley station
select rn_copy_node(array[555063120], array[555101781]);

update africa_osm_nodes
set name = 'Kimberley'
where oid = 556063120;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555001114,
		556063120,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'De Aar - Kimberley',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Naroegas (Nambiba border) - De Aar

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            559000016,
		555000243,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Naroegas (Nambiba border) - De Aar',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Upington - Kakamas
--  Transnet branch line

-- split 555034558 at 555068625
select rn_split_edge(array[555034558], arary[555068625]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555068625,
		555006504,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Upington - Kakamas',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);


-- De Aar - Port of Ngqura

update africa_osm_nodes
set name ='Port of Ngqura (container terminal)',
facility = 'container terminal',
railway = 'stop'
where oid = 555015569;

-- split 555015616 at 555141657
select rn_split_edge(array[555015616], array[555141657]);
-- split 555115329 at 555074156
select rn_split_edge(array[555115329], array[555074156]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555071366,
		555015569,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'De Aar - Port of Ngqura',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Department of Defense Ammunition Depot (De Aar)
update africa_osm_nodes
set name = 'Department of Defense Ammunition Depot (De Aar)',
railway = 'stop',
facility = 'military'
where oid = 555009118;

-- split 555000845 at 555069498
select rn_split_edge(array[555000845], array[555069498]);
-- split 555021719 at 555069499
select rn_split_edge(array[555021719], array[555069499]);


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555069498,
		555009118,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Department of Defense Ammunition Depot (De Aar)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Belmont - Douglas
-- Transnet branch line

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555048922,
		555008595,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Belmont - Douglas',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Branch line'
where oid in (select edge from tmp);

-- GWK grain storage silos, Douglas

update africa_osm_nodes
set name = 'GWK grain storage silos, Douglas',
railway = 'stop',
facility = 'food storage'
where oid = 555071632;

-- split 555119680 at 555071631
select rn_split_edge(array[555119680], array[555071631]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555071631,
		555071632,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'GWK grain storage silos, Douglas',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- East London metrorail
-- East London - Chiselhurst
-- Passenger only

update africa_osm_nodes
set railway = 'station'
where oid = 555000918;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555000918,
		555061722,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'East London - Chiselhurst (Metrorail)',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Metrorail Eastern Cape passenger line. Passenger services are currently suspended due to vandelisim and theft. See: https://bit.ly/3lafchP.'
where oid in (select edge from tmp);

-- Chiselhurst - Berlin (Ntabozuko)
-- Metrorail and Transnet

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555061722,
		555061736,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Chiselhurst - Berlin/Ntabozuko (Metrorail and Transnet)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Metrorail Eastern Cape passenger line. Passenger services are currently suspended due to vandelisim and theft. See: https://bit.ly/3lafchP. Also Transnet core network'
where oid in (select edge from tmp);

-- Port of East London

-- Container Terminal

update africa_osm_nodes
set name = 'Port of East London (container terminal)',
railway = 'stop',
facility = 'container terminal'
where oid = 555039836;

-- Vehicle Terminal
update africa_osm_nodes
set name = 'Port of East London (vehicle terminal)',
railway = 'stop',
facility = 'port'
where oid = 555006428;

-- Grain Terminal (Elevator/storage silos)
update africa_osm_nodes
set name = 'Port of East London (grain terminal)',
railway = 'stop',
facility = 'port',
comment = 'grain elevator and storage silos'
where oid = 555126640;

-- Fuel storage
update africa_osm_nodes
set name = 'Port of East London (fuel storage terminal)',
railway = 'stop',
facility = 'port',
comment = ''
where oid = 555126737;

-- Port access
  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555002326,
		555039651,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of East London (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Container terminal
  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555039818,
		555039836,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of East London (container terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Fuel storage terminal
  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555039651,
		555126737,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of East London (fuel storage terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- grain elevator and storage silos
  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid != 555096494',
            555039651,
		555126640,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of East London (grain terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Berlin - Queenstown/Komani
  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555061736,
		555001002,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Berlin - Queenstown/Komani',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Queenstown - Springfontein
-- Transnet core network
-- Also shared by Shosholoza Meyl Johannesburg – Queenstown (Komani) long distance passenger service.  

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555001002,
		555061540,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Queenstown - Springfontein',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Also shared by Shosholoza Meyl Johannesburg – Queenstown (Komani) long distance passenger service.'
where oid in (select edge from tmp);

-- Springfontein - Bloemfontein
update africa_osm_nodes
set railway = 'station' where oid = 555000425;

-- split 555036534 at 555145904
select rn_split_edge(array[555036534], array[555145904]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555061540,
		555000425,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sringfontein - Bloemfontein',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Also shared by Shosholoza Meyl Johannesburg – Queenstown (Komani) long distance passenger service.'
where oid in (select edge from tmp);


-- Springfontein - Noupoort

-- split 555121692 at 555153626
select rn_split_edge(array[555121692], array[555153626]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555145903,
		555069313,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Springfontein - Noupoort',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

--  Amabele - Mthatha
-- Transnet branch line

-- adjust incorrect edge
select rn_change_source(555011384, 555075086);
-- simplify
select rn_insert_edge(555000656, 555075086, 556000104);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555000656,
		555010015,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Amabele - Mthatha',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

-- Blaney - Cookhouse
-- Transnet core network

-- split 555017328 at 555065281
select rn_split_edge(array[555017328], array[555065281]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555055740,
		555065281,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Blaney - Cookhouse',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Addo - Kirkwood
-- Transnet branch line

-- split 555017431 at 555063694
select rn_split_edge(array[555017431], array[555063694]);



  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555000829,
		555063694,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Addo - Kirkwood',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

-- sunday rivers citrus company
-- largest grower, packer and exporter of South African citrus
-- see: https://www.srcc.co.za/about-srcc

update africa_osm_nodes
set name = 'Sunday Rivers Citrus Company',
railway = 'stop',
facility = 'food',
comment = 'Largest grower, packer and exporter of South African citrus. see: https://www.srcc.co.za/about-srcc'
where oid = 555003558;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555000829,
		555003558,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sunday Rivers Citrus Company',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Hotazel - Hamilton (Bloemfontein)

-- simplify
select rn_insert_edge(555081809, 555000476, 556000105);

--split 555012158 at 555001164
select rn_split_edge(array[555012158], array[555001164]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555001164,
		555000476,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hotazel - Hamilton (Bloemfontein)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Hotazel area mines etc

-- split 555057632 at 555084343
select rn_split_edge(array[555057632], array[555084343]);
-- split 555039495 at 555084341
select rn_split_edge(array[555039495], array[555084341]);
-- split 5550394952 at 555106472
select rn_split_edge(array[5550394952], array[555106472]);


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555001164,
		555084341,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hotazel Manganese Mines (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Black Rock Mine (Manganese)
update africa_osm_nodes
set name = 'Black Rock Mine',
railway = 'stop',
facility = 'mine',
comment = 'Manganese mine. See: https://www.mindat.org/loc-3065.html'
where oid = 555084342;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555084341,
		555084342,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Black Rock Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Wessels Mine (Manganese)
update africa_osm_nodes
set name = 'Wessels Mine',
railway = 'stop',
facility = 'mine',
comment = 'Manganese mine. See: https://www.mindat.org/loc-3071.html'
where oid = 555028636;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555084341 ,
		555028636,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Wessels Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Nchwaning Mines (Manganese)
update africa_osm_nodes
set name = 'Nchwaning Mines',
railway = 'stop',
facility = 'mine',
comment = 'Manganese mines. See: https://www.mindat.org/loc-55925.html'
where oid = 555106473;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555106472 ,
		555106473,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Nchwaning Mines',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Gloria Mine
update africa_osm_nodes
set name = 'Gloria Mine',
railway = 'stop',
facility = 'mine',
comment = 'Manganese mine. See: https://www.mindat.org/loc-11382.html'
where oid = 555106477;

--split 55503949522 at 555106476
select rn_split_edge(array[55503949522], array[555106476]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555106476,
		555106477,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gloria Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Hotazel Mine (Manganese)
update africa_osm_nodes
set name = 'Hotazel Mine',
railway = 'stop',
facility = 'mine',
comment = 'Manganese mine. See: https://www.mindat.org/loc-2413.html'
where oid = 555097200;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555084343,
		555097200,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hotazel Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kalagadi Mine (Manganese)

-- split 555070550 at 555107706
-- split 555070528 at 555106475
select rn_split_edge(array[555070550,555070528], array[555107706,555106475]);
-- split 5550121581 at 555106342
select rn_split_edge(array[5550121581], array[555106342]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555106342,
		555107706,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hotazel Manganese mines (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

update africa_osm_nodes
set name = 'Kalagadi Mine',
railway = 'stop',
facility = 'mine',
comment = 'Manganese mine. See: https://www.mindat.org/loc-252416.html'
where oid = 555106474;

-- split 5550705282 at 555106312
select rn_split_edge(array[5550705282], array[555106312]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555107706,
		555106474,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kalagadi Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kudumane Mine (Manganese)
update africa_osm_nodes
set name = 'Kudumane Mine',
railway = 'stop',
facility = 'mine',
comment = 'Manganese mine. See: https://www.mindat.org/loc-252417.html'
where oid = 555106338;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555107706,
		555106338,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kudumane Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- split 555012167 at 555106310
select rn_split_edge(array[555012167], array[555106310]);
-- split 555070525 at 555106309
select rn_split_edge(array[555070525], array[555106309]);
-- split 555070527 at 555106311
select rn_split_edge(array[555070527], array[555106311]);
--- spit 5550705272 at 555106311
select rn_split_edge(array[5550705272], array[555106311]);
-- split 55507052721 at 555106305
select rn_split_edge(array[55507052721], array[555106305]);


-- Tshipi Borwa Mine
update africa_osm_nodes
set name = 'Tshipi Borwa Mine',
railway = 'stop',
facility = 'mine',
comment = 'Manganese mine. See: https://www.mindat.org/loc-252415.html'
where oid = 555106305;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555106310,
		555106305,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tshipi Borwa Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Mamatwan Mine
update africa_osm_nodes
set name = 'Mamatwan Mine',
railway = 'stop',
facility = 'mine',
comment = 'Manganese mine. See: https://www.mindat.org/loc-11063.html'
where oid = 555023661;

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555106309,
		555023661,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mamatwan Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Bloemfontein - Maseru (Lesotho)
-- Transnet core network


insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000102,
 null,
 null,
 'South Africa',
 null,
 null,
 ST_SetSRID(ST_Point(26.22830,-29.12395), 4326)
 )
;

select rn_copy_node(array[558000102], array[555024074]);
-- 559000102
select rn_insert_edge(555060297, 559000102, 556000106);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555006239,
		555007933,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bloemfontein - Maseru (Lesotho)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);


-- Marselilles/Ladybrand - Bethlehem
-- disused according to Transnet 2021 Report map

-- split 555001013 at 555065429
select rn_split_edge(array[555001013], array[555065429]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555070604,
		555065429,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Marselilles/Ladybrand - Bethlehem',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'disused according to Transnet 2021 Report map'
where oid in (select edge from tmp);

-- split 555037459 at 555106135
select rn_split_edge(array[555037459], array[555106135]);
-- split 555004742 at 555000525
select rn_split_edge(array[555004742], array[555000525]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555106135,
		555000525,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Marselilles/Ladybrand - Bethlehem',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'disused according to Transnet 2021 Report map'
where oid in (select edge from tmp);

-- Ramatlabama (Botswana border) - Kamfersdam

-- split 555017290 at 555153564
select rn_split_edge(array[555017290], array[555153564]);
-- split 555004578 at 555120647
select rn_split_edge(array[555004578], array[555120647]);

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid not in  (555132862, 555025206) and country = ''South Africa'' ',
            555081222,
		555006583,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ramatlabama (Botswana border) - Kamfersdam',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Veertien Strome - Klerksdorp

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555060701,
		555001694,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Veertien Strome - Klerksdorp',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Bloemfontein - Vereeniging
-- Transnet core network
-- Shosholoza Meyl long distance passenger service Johannesburg – Queenstown/Komani 

  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555000425,
		555048499,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bloemfontein - Vereeniging',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Also Shosholoza Meyl long distance passenger service Johannesburg – Queenstown/Komani'
where oid in (select edge from tmp);

-- Klerksdorp - Houtheuwel
-- Transnet core network

update africa_osm_nodes
set railway = 'station' where oid = 555001694;

update africa_osm_nodes
set railway = null, name = null where oid = 555050291;


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid != 555000786 ',
            555001694,
		555000371,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Klerksdorp - Houtheuwel',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Cachet - Oberholzer

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555002320,
		555001762,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cachet - Oberholzer',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Welverdiend - Lichtenburg

--split 555027226 at 555068321
select rn_split_edge(array[555027226], array[555068321]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555068321,
		555001705,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Welverdiend - Lichtenburg',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Coligny - Pudimoe
-- Transnet branch line

-- split 555082843 at 555081255
select rn_split_edge(array[555082843], array[555081255]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555068328,
		555081255,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Coligny - Pudimoe',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

-- Vermaas - Makwassie
-- Transnet branch line

-- split 555052776 at 555091598
select rn_split_edge(array[555052776], array[555091598]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555091598,
		555068472,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Vermaas - Makwassie',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

-- Ottosdal - Klerksdorp
-- Transnet branch line

-- split 555014485 at 555070036
select rn_split_edge(array[555014485], array[555070036]);
-- split 555000784 at 555102363
select rn_split_edge(array[555000784], array[555102363]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555070036,
		555102363,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ottosdal - Klerksdorp',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

-- Orkney - Westleigh
-- Transnet branch line

-- split 555045051 at 555080021
select rn_split_edge(array[555045051], array[555080021]);
-- split 5550450512 at 555080223
select rn_split_edge(array[5550450512], array[555080223]);

-- copy Westleigh station
select rn_copy_node(array[555000646], array[555129701]);

-- simplify join 555044855 to 555000646
select rn_insert_edge(555044855, 556000646, 556000107);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555080021,
		556000646,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Orkney - Westleigh',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

-- Vierfontein - Bultfontein
-- Transnet branch line
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555071246,
		555001551,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Vierfontein - Bultfontein',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

-- Ancona - Whites
-- Transnet branch line

-- copy Whites
select rn_copy_node(array[555000630], array[555130350]);
-- simplify
select rn_insert_edge(556000630, 555059476, 556000108);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555065076,
		556000630,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ancona - Whites',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

--  Mafikeng- Krugersdorp
-- Transnet Core Network

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555120647,
		555059033,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mafikeng- Krugersdorp',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Randfontein - Bank
-- Transnet branch line

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555001468,
		555006317,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Randfontein - Bank',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

-- Kroonstad (Gunhill) - Danskraal

-- simplify
select rn_insert_edge(555023458, 555061536, 556000109);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555061536,
		555126906,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kroonstad (Gunhill) - Danskraal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Arlington - Marquard
-- Transnet branch line
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555006686,
		555000541,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Arlington - Marquard',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

-- Arlington - Heilbron

-- simplify
select rn_insert_edge(555000407, 555059369, 556000110);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555000407,
		555000499,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Arlington - Heilbron',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

-- Bethlehem - Balfour North
-- This line is open according to Transnet 2021 report map
-- but OSM has it abandoned or disused in parts
-- Transnet branch line

update africa_osm_nodes set railway = 'stop' where oid = 555000463;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555006734,
		555000463,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bethlehem - Frankfort',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line. This line is open according to Transnet 2021 report map. OSM has it disused or abandoned between Frankfort and Grootvlei'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555000463,
		555106605,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Frankfort - Grootvlei',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unclear',
comment = 'Transnet branch line. This line is open according to Transnet 2021 report map. OSM has it disused or abandoned between Frankfort and Grootvlei'
where oid in (select edge from tmp);

-- Grootvlei - Balfour North

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555106605,
		555065384,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Grootvlei - Balfour North',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line. This line is open according to Transnet 2021 report map. OSM has it abandoned or disused between Grootvlei and Redan'
where oid in (select edge from tmp);

-- Grootvlei - Redan

-- split 555017406 at 555063684
select rn_split_edge(array[555017406], array[555063684]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555106605,
		555063684,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Grootvlei - Redan',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unclear',
comment = 'Transnet branch line. This line is open according to Transnet 2021 report map. OSM has it abandoned or disused.'
where oid in (select edge from tmp);

-- Union - Danskraal
-- Transnet core network

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid not in (555003066, 555003067, 555105353)',
            555051755,
		555126906,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Union - Danskraal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Danskraal - Pietermaritzburg

select rn_copy_node(array[555030022], array[555044147]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555126906,
		556030022,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Danskraal - Pietermaritzburg',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Pietermaritzburg - Cato Ridge

update africa_osm_nodes
set railway = 'station' where oid = 555002388;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            556030022,
		555004004,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pietermaritzburg - Cato Ridge',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Cato Ridge - Pinetown
-- Old main line
update africa_osm_nodes set railway = 'station' where oid = 555080439;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555004004,
		555032667,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cato Ridge - Pinetown (old main line)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Old main line in/out Durban'
where oid in (select edge from tmp);

-- Durban Metrorail

-- Pinetown - Rossburgh (Old Main Line)

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555002388,
		555032667,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pinetown - Rossburgh (Old Main Line)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (Old Main Line).'
where oid in (select edge from tmp);

-- Rossborough access

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555032667,
		555005735,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rossburgh (Old and New Main Lines)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (Old and New Main Lines).'
where oid in (select edge from tmp);

-- Cato Ridge - Rossburgh (New Main Line)

-- simplify lines into Rossburgh
select rn_insert_edge(555005735, 555003755, 556000111);
delete from africa_osm_edges where oid = 556000111

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid not in (555047484, 555005688)',
            555003989,
		555005735,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cato Ridge - Rossburgh (New Main Line)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (New Main Line). Also Transnet core network.'
where oid in (select edge from tmp);

-- Merebank - Rossburgh

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555067650,
		555005735,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Merebank - Rossburgh',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (Chatsworth/Southern Coast/kwaMashu/Bluff lines). Also Transnet core network.'
where oid in (select edge from tmp);

-- Rossburgh access

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555005735,
		555061584,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rossburgh (access)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail and Transnet core network.'
where oid in (select edge from tmp);

-- Chatsworth Line
-- Merebank - Crossmoor

-- split 555081672 at 555147693
select rn_split_edge(array[555081672], array[555147693]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555067650,
		555061658,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Merebank - Crossmoor (Chatsworth Line)',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail.'
where oid in (select edge from tmp);

-- Merebank - Reunion
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555067650,
		555003890,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Merebank - Reunion',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (Southern Coast/kwaMashu/Bluff lines). Also Transnet core network.'
where oid in (select edge from tmp);

-- Reunion - Umlazi (kwaMashu - Umlazi Line)

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555003890,
		555049891,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Reunion - Umlazi (kwaMashu / Bluff Lines)',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail'
where oid in (select edge from tmp);

-- Reunion - Kelso
-- Southern Coast Line

update africa_osm_nodes
set railway = 'station' where oid = 555007056;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555003890,
		555007056,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Reunion - Kelso',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (Southern Coast Line). Also Transnet core network.'
where oid in (select edge from tmp);

-- Kelso - Port Shepstone
-- Transnet core network

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555007056,
		555012004,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kelso - Port Shepstone',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Port Shepstone - Harding
-- status unclear. Transnet 2021 Report map shows entire branch as closed
-- OSM has open to Paddock then abandoned.

-- Port Shepstone - Paddock

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555012004,
		555030852,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port Shepstone - Paddock',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unclear',
comment = 'Transnet 2021 Report map shows entire branch to Harding as closed OSM has open to Paddock then abandoned.'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555030852,
		555141652,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Paddock - Harding',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Transnet 2021 Report map shows entire branch to Harding as closed OSM has open to Paddock then abandoned.'
where oid in (select edge from tmp);

-- Bluff Line
-- Clairwood - Wests
-- mixed - some sharing with port freight

-- split 555005700 at 555080500
select rn_split_edge(array[555005700], array[555080500]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid not in (555005065, 555005264, 555005274)',
            555080500,
		555004998,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Clairwood - Wests',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (Bluff Line). Transnet core network (Port of Durban).'
where oid in (select edge from tmp);

-- correct Rossburgh issue
update africa_osm_edges
set line = null,
gauge = null
where oid in (555019459, 555006257,555124903,555005556,555124898, 555006253, 555019448, 555019449,555019530,555019491,555019460, 555006265);

-- Rossburgh - Durban
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555061584,
		555003679,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rossburgh - Durban',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (New Main/Old Main/Chatsworth/Southern Coast/kwaMashu/Bluff lines). Also Transnet core network.'
where oid in (select edge from tmp);

-- Durban - Umgeni
-- Northern Coast / kwaMashu Lines
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555003679,
		555003618,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Durban - Umgeni',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (kwaMashu/Northern Coast lines). Also Transnet core network.'
where oid in (select edge from tmp);

-- Umgeni - Duff's Road
-- via Red Hill
-- Northern Coast Line

update africa_osm_nodes
set railway = 'station' where oid = 555004614;

-- simplify into Duff's Road
select rn_insert_edge(555003601, 555004614, 556000112);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid not in (555033232,555033274)',
            555003618,
		555004614,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Umgeni - Duff''s Road (via Red Hill)',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (Northern Coast line).'
where oid in (select edge from tmp);

-- Umgeni - Duff's Road
-- via Effingham
-- Northern Coast /  kwaMashu Lines

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555003618,
		555004614,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Umgeni - Duff''s Road (via Effingham)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (Northern Coast / kwaMashu Lines). Also Transnet core network'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555004614,
		555057703,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Umgeni - Duff''s Road',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (Northern Coast / kwaMashu Lines). Also Transnet core network'
where oid in (select edge from tmp);

-- kwaMashu Line
-- kwaMashu
-- passenger
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555004608,
		555061657,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Duff''s Road - kwaMashu (kwaMashu Line)',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail.'
where oid in (select edge from tmp);

-- kwaMashu Line
-- Bridge City Station
-- passenger

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555057703,
		555009423,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Duff''s Road - Bridge City (kwaMashu Line)',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail.'
where oid in (select edge from tmp);

-- Duff's Road - Stanger
-- Northern Coast Line
-- Transnet core

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555057703,
		555061665,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Duff''s Road - Stanger',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (Northern Coast Line) and Transnet core network'
where oid in (select edge from tmp);


-- Port of Durban

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid != 555126135',
            555004705,
		555004639,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Durban',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Point and Leisure Precinct 
update africa_osm_nodes
set name = 'Port of Durban (Point and Leisure Precinct)',
railway = 'stop',
facility = 'port'
where oid = 555066658;

-- split 555007592 at 555066658
select rn_split_edge(array[555007592], array[555066658]);
-- split 555015487 at 555066648
select rn_split_edge(array[555015487], array[555066648]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid != 555126135',
            555057969,
		555066658,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Durban (Point and Leisure Precinct)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Maydon Wharf Precinct
update africa_osm_nodes
set name = 'Port of Durban (Maydon Wharf Precinct)',
railway = 'stop',
facility = 'port'
where oid = 555066080;

-- split 555007433 at 555066588
select rn_split_edge(array[555007433], array[555066588]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid != 555126135',
            555057969,
		555066080,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Durban (Maydon Wharf Precinct)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Container Precinct
update africa_osm_nodes
set name = 'Port of Durban (Container Precinct)',
railway = 'stop',
facility = 'port'
where oid = 555057555;


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid != 555126135',
            555057969,
		555057555,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Durban (Container Precinct)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Island View Precinct
update africa_osm_nodes
set name = 'Port of Durban (Island View Precinct)',
railway = 'stop',
facility = 'port'
where oid = 555067226;

-- split 555005339 at 555067221
select rn_split_edge(array[555005339], array[555067221]);
-- split 555009039 at 555067225
-- split 555009041 at 555067229
-- split 555009043 at 555067226
select rn_split_edge(array[555009039,555009041,555009043], array[555067225,555067229,555067226]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid != 555126135',
            555057199,
		555067226,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Durban (Island View Precinct)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Branch lines from Pietermaritzburg

-- Pietermaritzburg - Kranskop
-- disused from Potspruit (according to OSM)

-- simplify
select rn_insert_edge(555123283, 556030022, 556000113);
update africa_osm_edges set status = 'open' where oid = 556000113;
-- split 555117029 at 555123282
select rn_split_edge(array[555117029], array[555123282]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            556030022,
		555103655,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pietermaritzburg - Kranskop',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line. Disused from Potspruit (according to OSM)'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555103655,
		555012009,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pietermaritzburg - Kranskop',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Disused from Potspruit (according to OSM)'
where oid in (select edge from tmp);


-- Mount Alida branch line
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555071926,
		555008162,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mount Alida branch line',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

-- Dalton - Glenside branch line
-- disused from Fawn Leas - Glenside according to OSM

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555071922,
		555103503,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Dalton - Glenside',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line. Disused from Fawn Leas - Glenside according to OSM'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555103503,
		555012012,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Dalton - Glenside',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Disused from Fawn Leas - Glenside according to OSM'
where oid in (select edge from tmp);

-- Schroeders - Bruyns Hill branch line
-- disused

-- split 555067397 at 555144754
select rn_split_edge(array[555067397], array[555144754]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555144754,
		555012016,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Schroeders - Bruyns Hill',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Disused according to OSM'
where oid in (select edge from tmp);

-- Pietermaritzburg - Franklin
-- Transnet branch line

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
           555134591 ,
		555008196,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pietermaritzburg - Franklin',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);

-- Franklin - Kokstad
-- disused

update africa_osm_nodes
set name = 'Kokstad',
railway = 'stop'
where oid = ;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555008196 ,
		555120949,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Franklin - Kokstad',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Franklin - Matatiele
update africa_osm_nodes
set name = 'Matatiele',
railway = 'stop'
where oid = 555074692;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555070896 ,
		555074692,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Franklin - Kokstad',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'abandoned',
comment = 'Transnet 2021 Report indicates closed, OSM indicates abandoned.'
where oid in (select edge from tmp);

-- Donnybrook - Underberg
-- Transnet Branch line
-- open according to Transnet 2021 report

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555070918,
		555008236,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Donnybrook - Underberg',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line. Open according to Transnet 2021 report'
where oid in (select edge from tmp);

-- Pentrich - Richmond
-- Transnet branch line
-- according to Transnet 2021 report line is open - OSM says disused.

-- simplify
select rn_insert_edge(555134584, 555069389, 556000114);
-- split 555106760 at 555134584
select rn_split_edge(array[555106760], array[555134584]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555134584,
		555006833,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pentrich - Richmond',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unclear',
comment = 'Transnet branch line. Open according to Transnet 2021 report. OSM says disused.'
where oid in (select edge from tmp);

-- Ennersdale - Bergville
-- Transnet branch line
-- open according to Transnet 2021 Report

-- split 555033471 at 555070849
select rn_split_edge(array[555033471], array[555070849]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555070849,
		555013111,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ennersdale - Bergville',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line. Open according to Transnet 2021 report.'
where oid in (select edge from tmp);


-- Harrismith - Warden
-- Closed line according to Transnet 2021 report (though OSM says open)

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555065375,
		555000648,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Harrismith - Warden',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Closed line according to Transnet 2021 report (though OSM says open)'
where oid in (select edge from tmp);

-- Firham - Vrede
-- closed according to Transnet 2021 report map

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555119690,
		555000636,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Firham - Vrede',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Closed line according to Transnet 2021 report.'
where oid in (select edge from tmp);

-- Tutuka - New Denmark Colliery
-- Transnet 2021 Report map has this line closed. OSM says open.

update africa_osm_nodes
set name = 'New Denmark Colliery (Tutuka Power Station)',
railway = 'stop',
facility = 'mine'
where oid = 555127984;

select rn_split_edge(array[555047846], array[555127984]);
-- split 555111398 at 555070779
select rn_split_edge(array[555111398], array[555070779]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555070779,
		555127984,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tutuka - New Denmark Colliery',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Closed line according to Transnet 2021 report. Colliery probably dedicated to supplying Tutuka power station'
where oid in (select edge from tmp);

-- Palmford - Majuba Power Station
-- Believed to now be disused
-- Replaced by the new Esom private railway from near Ermelo
-- see: http://bit.ly/3LJAxta


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555058320,
		555011609,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Palmford - Majuba Power Station',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Believed to now be disused. Replaced by road transport and now the new Eskom private railway from near Ermelo. See: http://bit.ly/3LJAxta'
where oid in (select edge from tmp);


-- Springs - Hamelfontein

-- split  555127774 at 555150191
select rn_split_edge(array[555127774], array[555150191]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555001501,
		555150191,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Springs - Hamelfontein',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);


Update africa_osm_nodes set name = 'Broodsnyersplaas'
where oid = 555127800;

-- Pullenshope - Ermelo

-- split 555127800 at 555150190
select rn_split_edge(array[555127800], array[555150190]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid !=  5551278001',
            555008148,
		555045676,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pullenshope - Ermelo (Coal Line)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Electrified'
where oid in (select edge from tmp);

-- Transnet Depot, Ermelo

-- split 555024927 at 555077861
select rn_split_edge(array[555024927], array[555077861]);
-- split 555028515 at 555132615
select rn_split_edge(array[555028515], array[555132615]);

update africa_osm_nodes
set name = 'Transnet Depot, Ermelo',
railway = 'stop',
facility = 'railway'
where oid = 555075124;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555077861,
		555075124,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Transnet Depot, Ermelo',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Majuba Power Station (Eskom)
-- Private line
-- see: http://bit.ly/3LJAxta

update africa_osm_nodes
set name = 'Majuba Power Station (Eskom)'
where oid = 555011609;

--split 555052652 at 555149317
-- split 555024106 at 555093801
select rn_split_edge(array[555052652,555024106], array[555149317,555093801]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555036737,
		555011609,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Majuba Power Station (Eskom private line)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'New Eskom private railway to transport coal to power station from near Ermelo. See: http://bit.ly/3LJAxta.'
where oid in (select edge from tmp);

-- Ermelo (Transnet Depot) - Richards Bay Coal Terminal
-- Richards Bay Coal Line

-- split 555108738 at 555136201
select rn_split_edge(array[555108738], array[555136201]);
select rn_insert_edge(555136232, 555085235, 556000115);
update africa_osm_edges set status = 'open' where oid = 556000115;

select rn_copy_node(array[555129764], array[555100363]);

update africa_osm_nodes
set name = 'Vryheid (Transnet Depot)',
facility = 'railway',
railway = 'stop'
where oid = 556129764;

update africa_osm_nodes
set name = 'Port of Richards Bay (Coal Terminal)',
facility = 'port',
railway = 'stop',
comment = 'Coal terminal'
where oid = 555070788;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555045676,
		555070788,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ermelo - Richards Bay Coal Terminal (Coal Line)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Electrified'
where oid in (select edge from tmp);

-- split 555095261 at 555124492
select rn_split_edge(array[555095261], array[555124492]);

-- Port of Richards Bay (Fuel terminal)

-- split 555095127 at 555125998
-- split 555016330 at 555125896
select rn_split_edge(array[555095127,555016330], array[555125998,555125896]);

update africa_osm_nodes
set name = 'Port of Richards Bay (Fuel Terminal)',
facility = 'port',
railway = 'stop',
comment = ''
where oid = 555126081;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555125896,
		555126081,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Richards Bay (Fuel Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Port of Richards Bay (General and Bulk berths)
-- simplify
select rn_insert_edge(555124499, 555124492, 556000116);

-- split 555093586 at 555124182
select rn_split_edge(array[555093586], array[555124182]);


update africa_osm_nodes
set name = 'Port of Richards Bay (General and Bulk berths)',
facility = 'port',
railway = 'stop',
comment = ''
where oid = 555038867;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555124499,
		555038867,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Richards Bay (General and Bulk berths)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Stanger - Richards Bay
-- Transnet core network
-- freight only

--simplify
select rn_insert_edge(555076050, 555124499, 556000117);
update africa_osm_edges set status = 'open' where oid = 556000117;

-- split 555025801 at 555125597
select rn_split_edge(array[555025801], array[555125597]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid != 555019186',
            555061665,
		555124499,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Stanger - Richards Bay',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Vryheid - Glencoe
-- Transnet branch line
-- open

-- simplify
select rn_copy_node(array[555130373], array[555101381]);
select rn_insert_edge(555130373, 556130373, 556000118);
update africa_osm_edges set status = 'open' where oid = 556000118;
-- simplify 
-- split 555102569 at 555131135
select rn_split_edge(array[555102569], array[555131135]);
select rn_insert_edge(555131073, 555131135, 556000119);
update africa_osm_edges set status = 'open' where oid = 556000119;
-- split 555018517 at 555130373
select rn_split_edge(array[555018517], array[555130373]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid not in (5551013812, 5551013811, 5550185172, 555101429)',
            556130373,
		555131135,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Vryheid - Glencoe',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);

-- Hlobane Mine
-- probably disused as mine has closed

select rn_split_edge(array[555033482], array[555131399]);
update africa_osm_nodes
set name = 'Hlobane Mine',
railway = 'stop',
facility = 'mine',
comment = 'Believe to be closed, see: https://www.gem.wiki/Hlobane_View_Colliery'
where oid =  555131399;

-- split 555102818 at 555130341
select rn_split_edge(array[555102818], array[555130341]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555130373,
		555131399,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hlobane Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Mine believed to be closed, see: https://www.gem.wiki/Hlobane_View_Colliery, so this spur probably disused'
where oid in (select edge from tmp);

-- Empangeni - Nkwalini

select rn_copy_node(array[555011490], array[555094699]);
-- simplify
select rn_insert_edge(555125458, 555038714, 556000120);
update africa_osm_edges set status = 'open' where oid = 556000120;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            556011490,
		555008854,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Empangeni - Nkwalini',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);

-- Richards Bay Line
-- Golela (Eswatini border) - Nseleni

-- simplify
select rn_copy_node(array[555102188], array[555093730]);
select rn_insert_edge(555102188, 556102188, 556000121);
update africa_osm_edges set status = 'open' where oid = 556000121;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid != 555098283',
            555081227,
		556102188,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Golela (Eswatini border) - Nseleni (Richards Bay Line)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network'
where oid in (select edge from tmp);

-- Musina (Zimbabwe border) - Pyramid South

update africa_osm_nodes
set name = 'Transnet Pyramid South Depot',
railway = 'stop',
facility = 'railway'
where oid = 555072204;

-- Musina (Zimbabwe border) - Pyramid

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid != 555046942 ',
            555080103,
		555070707,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Musina (Zimbabwe border) - Pyramid',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Shosholoza Meyl long distance passenger service Musina - Johannesburg'
where oid in (select edge from tmp);

-- Pyramid -- Pyramid South

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid != 555046942 ',
            555070707,
		555072204,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pyramid - Pyramid South',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Pyramid South - Sentrarand Marshalling Yard
update africa_osm_nodes
set name = 'Sentrarand Marshalling Yard',
railway = 'stop',
facility = 'railway'
where oid = 555014114;

-- split 555104309 at 555143197
select rn_split_edge(array[555104309], array[555143197]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid not in (555117410, 555018591, 555117390, 555034809, 555120894, 555106893, 555016147, 555016148) ',
            555072204,
		555014114,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pyramid South - Sentrarand Marshalling Yard',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Coal Line'
where oid in (select edge from tmp);

-- Sentrarand Marshalling Yard - Welgedag depot

update africa_osm_nodes
set name = 'Transnet Welgedag Depot',
railway = 'stop',
facility = 'railway'
where oid = 555139427;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid not in (555011862, 555011863, 555107795, 555107800, 555107534,555107809,555031449) ',
            555014300,
		555139427,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sentrarand Marshalling Yard - Welgedag depot',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Coal Line'
where oid in (select edge from tmp);

-- Welgedag Depot - Pullenshope

-- split 555113172 at 555139652
-- split 555058904 at 555139653
select rn_split_edge(array[555113172,555058904], array[555139652,555139653]);
-- split 555019225 at 555065331
select rn_split_edge(array[555019225], array[555065331]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555139652,
		555070801,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Welgedag Depot - Pullenshope',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Coal Line'
where oid in (select edge from tmp);

-- Welgedag - Springs
-- Transnet core network

-- split 555058883 at 555139762
select rn_split_edge(array[555058883], array[555139762]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555139653,
		555140074,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Welgedag Depot - Springs',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Springs - Kaydale
-- Transnet core network

-- split 555044880 at 555068686
select rn_split_edge(array[555044880], array[555068686]);

update africa_osm_nodes set railway = 'station' where oid = 555001447;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid not in (555004493, 555113574,555004487,5550448802,5550448801) ',
            555001501,
		555001447,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Springs - Nigel',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Gauteng metrorail. OSM has the section from Nigel to Kaydale as disused, however, this is shown as part of the Transnet core network in the 2021 annual report map so assume open.'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid not in (555004493, 555113574,555004487,5550448802,5550448801) ',
            555001447,
		555068686,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Nigel - Kaydale',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. OSM has the section from Nigel to Kaydale as disused, however, ths is shown as part of the Transnet core network in the 2021 annual report map so assume open.'
where oid in (select edge from tmp);


-- Pyramid -- Pretoria Nord

update africa_osm_nodes
set railway = 'station'
where oid = 555001488;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa''  ',
            555070707,
		555001488,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pyramid -- Pretoria Nord',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Shosholoza Meyl long distance passenger service Musina - Johannesburg'
where oid in (select edge from tmp);

-- Komatipoort - Rayton
-- Core network

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            559000084,
		555061880,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Komatipoort (Mozambique border) - Rayton',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Groenbult - Kapnuiden
-- Transnet core network
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555070590,
		555007204,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Groenbult - Kapnuiden',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Hoedspruit - Phalaborwa
-- Core network
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555007164,
		555007168,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hoedspruit - Phalaborwa',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Palabora mine

update africa_osm_nodes
set name = 'Palabora mine',
railway = 'stop',
facility = 'mine',
comment = 'copper mine and smelter and refinery complex. See: https://www.palabora.com'
where oid = 555069720;

-- split 555013839 at 555069728
select rn_split_edge(array[555013839], array[555069728]);
-- split 5550138391 at 555069721
select rn_split_edge(array[5550138391], array[555069721]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555007168,
		555069720,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Palabora mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Komaitpoort - Eswatini border
-- core network

update africa_osm_nodes
set railway = 'station',
name = 'Komatipoort'
where oid = 555076336;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555020285,
		559000092,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Komaitpoort - Eswatini border',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555007168,
		555069720,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Palabora mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kaapmuiden - Barberton Noord
-- Transnet branch line

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555047211,
		555015071,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kaapmuiden - Barberton Noord',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line.'
where oid in (select edge from tmp);

-- Mbombela/Nelspruit - Rocky Drift
-- Tansnet branch line
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555071900,
		555071885,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mbombela/Nelspruit - Rocky Drift',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line. Transnet 2021 annual report has this branch line open, OSM says it is disused apart from the section between Mbombela and Rocky Drift'
where oid in (select edge from tmp);

-- Shell Fuel Depot, Rocky Drift

-- split 555018229 at 555081280
select rn_split_edge(array[555018229], array[555081280]);
-- split 555034745 at 555074359
select rn_split_edge(array[555034745], array[555074359]);


update africa_osm_nodes
set name = 'Shell Fuel Depot, Rocky Drift',
railway = 'stop',
facility = 'fuel depot'
where oid = 555010198;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555081280,
		555010198,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Shell Fuel Depot, Rocky Drift',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Graskop Branch

select rn_copy_node(array[555008787], array[555126486]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555071888,
		556008787,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Graskop Branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unclear',
comment = 'Transnet branch line. Transnet 2021 annual report has this branch line open, OSM says it is disused apart from the section between Mbombela and Rocky Drift'
where oid in (select edge from tmp);

-- Rocky Drift - White River/Plaston

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555071885,
		555073401,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rocky Drift - White River/Plaston',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unclear',
comment = 'Transnet branch line. Transnet 2021 annual report has this branch line open, OSM says it is disused apart from the section between Mbombela and Rocky Drift'
where oid in (select edge from tmp);

-- Steelpoort - Belfast
-- Core network

select rn_copy_node(array[555007247], array[555107940]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555058699,
		555001866,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Belfast - Steelpoort',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Derwent - Roossenekal
-- Core network

select rn_copy_node(array[555034422], array[555030895]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555065495,
		555001830,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Derwent - Roossenekal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network.'
where oid in (select edge from tmp);

-- Machadodorp - Ermelo
-- Core network
-- Coal Line

-- split 555014044 at 555075319
select rn_split_edge(array[555014044], array[555075319]);
-- split 555028511 at 555149558
select rn_split_edge(array[555028511], array[555149558]);
-- split 555026742 at 555149557
select rn_split_edge(array[555026742], array[555149557]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555075319,
		555149557,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Machadodorp - Ermelo',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Coal Line'
where oid in (select edge from tmp);

-- Buhrmanskop - Lothair
-- Transnet branch line

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555070674,
		555008036,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Buhrmanskop - Lothair',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);

-- Pullenshope - Wonderfontein
-- Core network
-- coal line

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555008148,
		555021903,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pullenshope - Wonderfontein',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Coal line'
where oid in (select edge from tmp);


-- Wonderfontein - Emalahleni
-- update comment to indicate Coal Line

select rn_copy_node(array[555034428], array[555004987]);
-- split 555004980 at 555065492
select rn_split_edge(array[555004980], array[555065492]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555021903,
		555065492,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set comment = 'Transnet core network. Wonderfontein - Emalahleni section part of Coal Line'
where oid in (select edge from tmp);

-- Emalahleni - Ogies
-- Core network
-- Coal Line

-- split 555019222 at 555139372
select rn_split_edge(array[555019222], array[555139372]);
-- split 555019223 at 555150015
select rn_split_edge(array[555019223], array[555150015]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid not in (555134629, 5550049801, 555134631)',
            555065492,
		555065331,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Emalahleni - Ogies',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Coal line'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid not in (555134629, 5550049801, 555134631)',
            555003348,
		555065330,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Emalahleni - Ogies',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Coal line'
where oid in (select edge from tmp);

-- Zebediela branch
-- disused

select rn_insert_edge(555070644, 555001755, 556000122);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555001755,
		555001878,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Zebediela branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);


-- Spoedwel branch
-- disused
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555070648,
		555001867,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Spoedwel branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Waterberg Line
-- Serves coalfields near Lephalale - the Waterberg coalfields (Grootegeluk coal mine)

update africa_osm_nodes
set name = 'Grootegeluk Coal Mine',
railway = 'stop',
facility = 'mine',
comment = 'coal mine'
where oid = 555134526;

update africa_osm_nodes
set name = 'Matimba Power Station',
railway = 'stop',
facility = 'power station'
where oid = 555084567;

update africa_osm_nodes
set name = 'Thabazimbi',
railway = 'station'
where oid = 555106624;

-- Lephalale - Thabazimbi
-- Waterberg Line

-- split 555039799 at 555084568
select rn_split_edge(array[555039799], array[555084568]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555084568,
		555106624,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Lephalale - Thabazimbi (Waterberg Line)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Core Network. Coal Line. Diesel'
where oid in (select edge from tmp);

-- Thabazimbi - Pyramid South

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555106624,
		555072204,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Thabazimbi - Pyramid South (Waterberg Line)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet Core Network. Coal Line. Electrified'
where oid in (select edge from tmp);

-- Pendoring - Atlanta
-- Branch line
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555070356,
		555010657,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pendoring - Beestekraal - Atlanta',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);

-- PPC Beestekraal
-- limestone mine and associated crushing plant facility
update africa_osm_nodes
set name = 'PPC Beestekraal',
railway = 'stop',
facility = 'mine',
comment = 'limestone mine and associated crushing plant facility'
where oid = 555074717;

select rn_split_edge(array[555023855], array[555074717]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555010657,
		555074717,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'PPC Beestekraal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Grootegeluk Coal Mine
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555084568,
		555134526,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Grootegeluk Coal Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Matimba Power Station
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555084568,
		555084567,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Matimba Power Station',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Armandelbult Complex

-- Dishaba Mine
-- various metals
-- http://bit.ly/3Kf7DzY

-- split 555067737 at 555103690
select rn_split_edge(array[555067737], array[555103690]);
-- split 555015372 at 555103719
select rn_split_edge(array[555015372], array[555103719]);
-- split 555067732 at 555103716
-- split 555067728 at 555103699
-- split 5550677372 at 555103700
select rn_split_edge(array[555067732,555067728,5550677372], array[555103716,555103699,555103700]);


update africa_osm_nodes
set name = 'Armandelbult Complex (Dishaba and Tumela mines)',
railway = 'stop',
facility = 'mine',
comment = 'Mining of platinum group (PGM) metals plus concentrators and chrome plant. See: http://bit.ly/3Kf7DzY'
where oid = 555103690;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555103719,
		555103690,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Armandelbult Complex',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Armandelbult Complex (Tiumela Mine 1 Shaft)

-- split 555067754 at 555103745
select rn_split_edge(array[555067754], array[555103745]);
-- split 555067727 at 555103746
select rn_split_edge(array[555067727], array[555103746]);


update africa_osm_nodes
set name = 'Armandelbult Complex (Tumela mine)',
railway = 'stop',
facility = 'mine',
comment = 'Mining of platinum group (PGM) metals plus concentrators and chrome plant. See: http://bit.ly/3Kf7DzY'
where oid = 555027892;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555103746,
		555027892,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Armandelbult Complex (Tumela mine)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- PPC Dwaalboom cement factory

-- split 555023896 at 555070353
select rn_split_edge(array[555023896], array[555070353]);

update africa_osm_nodes
set name = 'PPC Dwaalboom (Cement factory)',
railway = 'stop',
facility = 'manufacturing'
where oid = 555070353;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555070351,
		555070353,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'PPC Dwaalboom (Cement Factory)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Union Mine
-- various metals

update africa_osm_nodes
set name = 'Union Mine',
railway = 'stop',
facility = 'mine',
comment = 'platinum group (PGM) metals, see: http://bit.ly/40BPj9q'
where oid = 555050520;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555103701,
		555050520,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Union Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Impala Platinum Mines complex
-- see:  https://www.mindat.org/loc-11952.html

-- split 555039773 at 555084534
select rn_split_edge(array[555039773], array[555084534]);
-- split 555032823 at 555084532
select rn_split_edge(array[555032823], array[555084532]);
-- split 555039775 at 555084536
select rn_split_edge(array[555039775], array[555084536]);
-- split 555039774 at 555084540
-- split 555039765 at 555084542
select rn_split_edge(array[555039774,555039765], array[555084540,555084542]);

update africa_osm_nodes
set name = 'Impala Platinum Mines complex',
railway = 'stop',
facility = 'mine',
comment = 'Platinum mines. See: https://www.mindat.org/loc-11952.html' 
where oid = 555084535;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555084532,
		555084535,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Impala Platinum Mines complex',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Sibanye-Stillwater PGM mine and operation complex 
-- platinum group (PGM) metals

update africa_osm_nodes
set name = 'Sibanye-Stillwater PGM complex (West)',
railway = 'stop',
facility = 'mine',
comment = 'platinum group (PGM) metals mining and preocessing. See: http://bit.ly/3M5Jjlg'
where oid = 555033719;

-- split 555023669 at 555084482
select rn_split_edge(array[555023669], array[555084482]);
-- split 555087120 at 555118803
select rn_split_edge(array[555087120], array[555118803]);
-- split 555036605 at 555084478
select rn_split_edge(array[555036605], array[555084478]);
-- split 555035393 at 555084471
select rn_split_edge(array[555035393], array[555084471]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555084482,
		555033719,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sibanye-Stillwater PGM complex',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

update africa_osm_nodes
set name = 'Sibanye-Stillwater PGM complex (East)',
railway = 'stop',
facility = 'mine',
comment = 'platinum group (PGM) metals mining and preocessing. See: http://bit.ly/3M5Jjlg'
where oid = 555034078;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555084498,
		555034078,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sibanye-Stillwater PGM complex',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

update africa_osm_nodes
set name = 'Sibanye-Stillwater PGM complex (Siphumelele Mine)',
railway = 'stop',
facility = 'mine',
comment = 'platinum group (PGM) metals mining and preocessing. See: http://bit.ly/3M5Jjlg'
where oid = 555083680;

-- split 555035391 at 555083679
select rn_split_edge(array[555035391], array[555083679]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555081549,
		555083680,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sibanye-Stillwater PGM complex',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Rooiwal Power Station
-- believed to be mothballed. See: https://www.gem.wiki/Rooiwal_power_station

-- simplify
select rn_insert_edge(555070709, 555047526, 556000123);

update africa_osm_nodes
set name = 'Rooiwal Power Station',
railway = 'stop',
facility = 'power station',
comment = 'believed to be mothballed. See: https://www.gem.wiki/Rooiwal_power_station. Assume line is disused.'
where oid = 555030614;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555047526,
		555030614,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rooiwal Power Station',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Leeupan Colliery

	 insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000103,
 null,
 null,
 'South Africa',
 null,
 null,
 ST_SetSRID(ST_Point(28.72978,-26.16598), 4326)
 )
;

select rn_copy_node(array[558000103], array[555052650]);
-- 559000103

update africa_osm_nodes
set name = 'Leeupan Colliery',
railway = 'stop',
facility = 'mine',
comment = 'coal mine'
where oid = 559000103;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555047846,
		559000103,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Leeupan Colliery',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Delmas Colliery

-- split 555015029 at 555135165
select rn_split_edge(array[555015029], array[555135165]);

update africa_osm_nodes
set name = 'Delmas Colliery',
railway = 'stop',
facility = 'mine',
comment = 'coal mine'
where oid = 555135165;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555047851,
		555135165,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Delmas Colliery',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Silica mine (Thaba Chueu Mining)
update africa_osm_nodes
set name = 'Silica mine (Thaba Chueu Mining)',
railway = 'stop',
facility = 'mine',
comment = 'silica mine'
where oid = 555021912;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555058678,
		555021912,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Silica mine (Thaba Chueu Mining)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kendal Afgri Silo

update africa_osm_nodes
set name = 'Kendal Afgri Silo',
railway = 'stop',
facility = 'food storage',
comment = 'grain silos'
where oid = 555154284;

-- split 555019228 at 555139994
select rn_split_edge(array[555019228], array[555139994]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555139994,
		555154284,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kendal Afgri Silo',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Phola coal washing facility
-- see: https://draglobal.com/projects/phola-coal-mine/
-- largest coal washing  facility in South Africa

update africa_osm_nodes
set name = 'Phola coal washing facility',
railway = 'stop',
facility = 'mining',
comment = 'see: https://draglobal.com/projects/phola-coal-mine/ largest coal washing  facility in South Africa'
where oid = 555117008;

--split 555019226 at 555106301
select rn_split_edge(array[555019226], array[555106301]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555106301,
		555117008,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Phola coal washing facility',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Ogies grain silos
update africa_osm_nodes
set name = 'Ogies grain silos',
railway = 'stop',
facility = 'food storage',
comment = 'grain silos'
where oid = 555016118;

-- split 555107152 at 555134973
-- split 555036855 at 555134972
-- split 555113507 at 555134974
-- split 5550192252 at 555134975

select rn_split_edge(array[555107152, 555036855, 555113507, 5550192252], array[555134973, 555134972, 555134974, 555134975]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555134975,
		555016118,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ogies grain silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Goedgevonden Mine
-- https://miningdataonline.com/property/1166/Goedgevonden-Mine.aspx

update africa_osm_nodes
set name = 'Goedgevonden Mine',
railway = 'stop',
facility = 'mine',
comment = 'see: https://miningdataonline.com/property/1166/Goedgevonden-Mine.aspx'
where oid = 555135005;

-- split 555034771 at 555149997
select rn_split_edge(array[555034771], array[555149997]);
-- split 555107176 at 555149996
select rn_split_edge(array[555107176], array[555149996]);
-- split 555128062 at 555149958
select rn_split_edge(array[555128062], array[555149958]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555149997,
		555135005,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Goedgevonden Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

--  Arthur Taylor/ ATCOM collieries
update africa_osm_nodes
set name = 'Arthur Taylor/ ATCOM collieries',
railway = 'stop',
facility = 'mine',
comment = ''
where oid = 555058676;

-- split 555034776 at 555134925
select rn_split_edge(array[555034776], array[555134925]);

select rn_copy_node(array[555150279], array[5550347762]);
select rn_insert_edge(555150279, 556150279, 556000124);
update africa_osm_edges set status = 'open' where oid = 556000124;

select rn_split_edge(array[555011022], array[555150279]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            556150279,
		555058676,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Arthur Taylor/ ATCOM collieries',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Greenside Colliery
update africa_osm_nodes
set name = 'Greenside Colliery',
railway = 'stop',
facility = 'mine',
comment = 'coal mine'
where oid = 555072672;

update africa_osm_nodes
set railway = null where oid = 555061605;

select rn_copy_node(array[555061605], array[555107035]);
update africa_osm_nodes
set railway = 'station' where oid = 556061605;

-- split 555107036 at 555072666
select rn_split_edge(array[555107036], array[555072666]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555139377,
		555072672,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Greenside Colliery',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Landau Colliery (Kromdraai)

update africa_osm_nodes
set name = 'Landau Colliery (Kromdraai)',
railway = 'stop',
facility = 'mine',
comment = 'coal mine'
where oid = 555009022;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555072664,
		555009022,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Landau Colliery (Kromdraai)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Highveld steel (and industrial park)


update africa_osm_nodes
set name = 'Highveld steel (and industrial park)',
railway = 'stop',
facility = 'manufacturing',
comment = 'http://www.highveldindustrialpark.co.za/index.html'
where oid = 555050077;

-- split 555111288 at 555072669


-- split 555111278 at 555138514
select rn_split_edge(array[555111278], array[555138514]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555138535,
		555050077,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Highveld steel (and industrial park)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

update africa_osm_nodes
set name = 'Landau Colliery (Navigation)',
railway = 'stop',
facility = 'mine',
comment = 'coal mine'
where oid = 555079137;

-- split 555000858 at 555136985
select rn_split_edge(array[555000858], array[555136985]);
-- split 555000859 at 555079134
select rn_split_edge(array[555000859], array[555079134]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555079134,
		555079137,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Landau Colliery (Navigation)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Ferrobank industrial area, Emalahleni

-- split 555107887 at 555137603
-- split 555110122 at 555137606
select rn_split_edge(array[555107887,555110122], array[555137603,555137606]);
-- split 555110123 at 555082743
select rn_split_edge(array[555110123], array[555082743]);
-- split 555134629 at 555135521
select rn_split_edge(array[555134629], array[555135521]);


update africa_osm_nodes
set name = 'Ferrobank industrial area, Emalahleni',
railway = 'stop',
facility = 'industrial area',
comment = ''
where oid = 555048257;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555135521,
		555048257,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ferrobank industrial area, Emalahleni',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Middelburg Ferrochrome

update africa_osm_nodes
set name = 'Middelburg Ferrochrome',
railway = 'stop',
facility = 'manufacturing',
comment = 'Ferrochrome production, see: https://samancorcr.com/business_unit/middelburg-ferrochrome-mfc/'
where oid = 555135245;

-- split 555034675 at 555019700
select rn_split_edge(array[555034675], array[555019700]);
-- split 5550346751 at 555135258
select rn_split_edge(array[5550346751], array[555135258]);
-- split 555107544 at 555135259
select rn_split_edge(array[555107544], array[555135259]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555065493,
		555135245,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Middelburg Ferrochrome',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Columbus Stainless
update africa_osm_nodes
set name = 'Columbus Stainless',
railway = 'stop',
facility = 'manufacturing',
comment = 'Stainless steel production, see: https://www.columbus.co.zahttps://samancorcr.com/business_unit/middelburg-ferrochrome-mfc/'
where oid = 555081256;


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555135258,
		555081256,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Columbus Stainless',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Pullenshope Colliery
update africa_osm_nodes
set name = 'Pullenshope Colliery',
railway = 'stop',
facility = 'mine',
comment = 'coal mine'
where oid = 555058571;

-- split 555016354 at 555096576
select rn_split_edge(array[555016354], array[555096576]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555096576,
		555058571,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pullenshope Colliery',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Bank Colliery (Goedehoop North)
-- see: https://www.gem.wiki/Goedehoop_coal_mine
update africa_osm_nodes
set name = 'Bank Colliery (Goedehoop North)',
railway = 'stop',
facility = 'mine',
comment = 'coal mine, see: see: https://www.gem.wiki/Goedehoop_coal_mine'
where oid = 555048711;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555058629,
		555048711,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bank Colliery (Goedehoop North)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Goedehoop Colliery (Goedehoop South)
update africa_osm_nodes
set name = 'Goedehoop Colliery (Goedehoop South)',
railway = 'stop',
facility = 'mine',
comment = 'coal mine, see: https://www.gem.wiki/Goedehoop_coal_mine'
where oid = 555019047;

select rn_insert_edge(555058599, 555058595, 556000125);
update africa_osm_edges set status = 'open' where oid = 556000125;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555058595,
		555019047,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Goedehoop Colliery (Goedehoop South)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Eskom Arnot Power Station
update africa_osm_nodes
set name = 'Arnot Power Station (Eskom)',
railway = 'stop',
facility = 'power station',
comment = ''
where oid = 555127995;

select rn_change_target(555127823, 555048696);
-- split 555127823 at 555127994
select rn_split_edge(array[555127823], array[555127994]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555048696,
		555127995,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Arnot Power Station (Eskom)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Mafube Collier (Rapid Coal Loading - Rail Transfer)
-- Mafube colliery is about 13km North and link be conveyors

	 insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, comment, geom)
 values (
 558000104,
 'stop',
 'Mafube Colliery (Rapid Coal Loading - Rail Transfer)',
 'South Africa',
 '1067',
 'mine',
 'Mafube colliery is about 13km North and link be conveyors',
 ST_SetSRID(ST_Point(29.77093,-25.91411), 4326)
 )
;

select rn_copy_node(array[558000104], array[555052620]);
-- 559000104

-- split 555030901 at 555093768
select rn_split_edge(array[555030901], array[555093768]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555093768,
		559000104,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mafube Colliery (Rail Transfer)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Dorstfontein colliery complex

update africa_osm_nodes
set name = 'Dorstfontein colliery complex (Rapid Coal Loading - Rail Transfer)',
railway = 'stop',
facility = 'mine',
comment = ' transfer to rail from conveyors. Mine is about 11km south'
where oid = 555088611;

 -- split 555127894 at 555149910
 select rn_split_edge(array[555127894], array[555149910]);
 
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555149910,
		555088611,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Dorstfontein colliery complex (Rapid Coal Loading - Rail Transfer)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Afgri Bronkhorstspruit Silos
update africa_osm_nodes
set name = 'Afgri Bronkhorstspruit Silos',
railway = 'stop',
facility = 'food storage',
comment = 'grain silos'
where oid = 555013514;

-- split 555030287 at 555079124
 select rn_split_edge(array[555030287], array[555079124]);
 
 select rn_insert_edge(555079138, 555079136, 556000126);
 update africa_osm_edges set status = 'open' where oid = 556000126;


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555079136,
		555013514,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Afgri Bronkhorstspruit Silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Sasol Synfuels complex, Secunda
-- operates the world's only commercial coal-based synthetic fuels manufacturing facility, producing synthesis gas (syngas) through coal gasification and natural gas reforming.

update africa_osm_nodes
set name = 'Sasol Synfuels Complex, Secunda',
railway = 'stop',
facility = 'manufacturing',
comment = 'operates the world''s only commercial coal-based synthetic fuels manufacturing facility, producing synthesis gas (syngas) through coal gasification and natural gas reforming'
where oid = 555058487;

select rn_insert_edge(555099465, 555133450, 556000127);
 update africa_osm_edges set status = 'open' where oid = 556000127;
 
 -- split 555030746 at 555133484
  select rn_split_edge(array[555030746], array[555133484]);
	-- split 555034746 at 555133450
  select rn_split_edge(array[555034746], array[555133450]);
	-- split 555105469 at 555133486
	 select rn_split_edge(array[555105469], array[555133486]);



 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555133450,
		555058487,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sasol Synfuels Complex, Secunda',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Sasol Explosives, Ekandustria
update africa_osm_nodes
set name = 'Sasol Explosives, Ekandustria',
railway = 'stop',
facility = 'manufacturing',
comment = 'manufacture of mining explosives'
where oid = 555047617;

-- split 555113084 at 555139406
	 select rn_split_edge(array[555113084], array[555139406]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555008085,
		555047617,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sasol Explosives, Ekandustria',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'unclear',
comment = 'OSM says disused in part.'
where oid in (select edge from tmp);

-- Gauteng metrorail

-- Vereeniging - Germiston
-- created in parts to ensure route.

select rn_copy_node(array[555050277], array[555082426]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555048499,
		555013459,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Vereeniging - Germiston',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail and Shosholoza Meyl long distance passenger service Johannesburg – Queenstown/Komani. Transnet core network'
where oid in (select edge from tmp);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555013459,
		556050277,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Vereeniging - Germiston',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail and Shosholoza Meyl long distance passenger service Johannesburg – Queenstown/Komani. Transnet core network'
where oid in (select edge from tmp);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            556050277,
		555024426,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Vereeniging - Germiston',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail and Shosholoza Meyl long distance passenger service Johannesburg – Queenstown/Komani. Transnet core network'
where oid in (select edge from tmp);

--  Germiston - Johannesburg Park Station
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555024426,
		555003240,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Germiston - Johannesburg Park Station',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail and Shosholoza Meyl long distance passenger service Johannesburg – Queenstown/Komani. Transnet core network'
where oid in (select edge from tmp);

-- Elsburg - Kwesine
-- simplify
select rn_insert_edge(555032897, 555013457, 556000128);
 update africa_osm_edges set status = 'open' where oid = 556000128;
update africa_osm_nodes set railway = 'station' where oid = 555001416;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid not in (555082473, 555082474, 555058989) ',
            555032897,
		555001416,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Elsburg - Kwesine',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

-- Elsberg - President (via Webber)
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid not in (555082473, 555096169, 555082436)',
            555116727,
		555032868,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Elsberg - President (via Webber)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

-- India - New Canada
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid not in (555059291, 555111189, 555114186) ',
            555024520,
		555014395,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'India - New Canada',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);


-- George Goch - Kaserne West (via Benrose)

update africa_osm_nodes set railway = 'station' where oid = 555061786;
update africa_osm_nodes set railway = null where oid = 555032838;

select rn_insert_edge(555062338, 555061786, 556000129);
update africa_osm_edges set status = 'open' where oid = 556000129;


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid not in (555095675, 555095674, 555013351, 555013499) ',
            555061786,
		555032854,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'George Goch - Kaserne West (via Benrose)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

-- Vereeniging - Midway
-- Also Transnet core network

-- split 555001871 at 555152047
-- split 555108325 at 555152048
select rn_split_edge(array[555001871,555108325], array[555152047,555152048]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid not in (5550018712, 5550018711) ',
            555152047,
		555146405,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Vereeniging - Midway',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Gauteng metrorail'
where oid in (select edge from tmp);

-- Oberholzer - Midway

-- in sections to ensure correct route

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555001762,
		555006317,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oberholzer - Midway',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Gauteng metrorail'
where oid in (select edge from tmp);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555006317,
		555146405,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oberholzer - Midway',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Gauteng metrorail'
where oid in (select edge from tmp);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555146405,
		555061794,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oberholzer - Midway',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Gauteng metrorail'
where oid in (select edge from tmp);

-- Midway - New Canada

update africa_osm_nodes
set railway = null where oid = 555001457;

update africa_osm_nodes
set railway = null where oid = 555056153;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555061794,
		555000141,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Midway - New Canada',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Gauteng metrorail'
where oid in (select edge from tmp);

-- Naledi - New Canada
-- metrorail, including Soweto Business Express

update africa_osm_nodes
set railway = null where oid = 555061817;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555001440,
		555056154,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Naledi - New Canada',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail, including Soweto Business Express'
where oid in (select edge from tmp);

-- New Canada - Langlaagte
update africa_osm_nodes
set railway = null where oid = 555049199;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555000141,
		555055957,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'New Canada - Langlaagte',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Gauteng metrorail, including Soweto Business Express'
where oid in (select edge from tmp);

select rn_copy_node(array[555001320], array[555082250]);

-- Randfontein - Krugersdorp
-- Branch line

update africa_osm_nodes set railway = 'station' where oid = 555001468;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555001468,
		555059033,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Randfontein - Krugersdorp',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line. Gauteng metrorail.'
where oid in (select edge from tmp);

-- Krugersdorp - Johannesburg Park Station
-- multiple sections to ensure correct route

select rn_copy_node(array[555001414], array[555082008]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555059033,
		555055957,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Krugersdorp - Johannesburg Park Station',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Gauteng metrorail.'
where oid in (select edge from tmp);




-- GauTrain
-- 1435mm Gauge!
-- https://www.gautrain.co.za
-- electrified
-- Top speed	160 km/h (100 mph)

update africa_osm_nodes
set railway = 'station' where oid = 555036511;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555047516,
		555036511,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'GauTrain (North/South)',
mode = 'passenger',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'GauTrain'
where oid in (select edge from tmp);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555036511,
		555061838,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'GauTrain (North/South and East/West)',
mode = 'passenger',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'GauTrain'
where oid in (select edge from tmp);

update africa_osm_nodes
set railway = 'station' where oid = 555047519;

update africa_osm_nodes
set railway = 'station' where oid = 555061838;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555061838,
		555047519,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'GauTrain (North/South)',
mode = 'passenger',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'GauTrain'
where oid in (select edge from tmp);

-- simplify
select rn_insert_edge(555061838, 555122219, 556000130);
update africa_osm_edges set status = 'open' where oid = 556000130;

update africa_osm_nodes
set name = 'Rhodesfield (GauTrain)',
railway = 'station'
where oid = 555047515;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555061838,
		555047515,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'GauTrain (East/West and Airport)',
mode = 'passenger',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'GauTrain'
where oid in (select edge from tmp);

update africa_osm_nodes
set railway = null where oid = 555036513;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555047515,
		555047513,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'GauTrain (Airport)',
mode = 'passenger',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'GauTrain'
where oid in (select edge from tmp);

-- section from Pretoria - Hatfield

update africa_osm_nodes
set name = 'Hatfield (GauTrain)' where oid =  555008774;

-- simplify
select rn_change_source(555102515, 555047519);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555036024,
		555008774,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'GauTrain (Pretoria - Hatfield)',
mode = 'passenger',
type = 'conventional',
gauge = '1435',
status = 'open',
comment = 'GauTrain'
where oid in (select edge from tmp);

-- SWITCH TO 1067mm GAUGE

-- Germiston - Pretoria
-- Transnet Core
-- Metrorail
-- and Shosholoza Meyl long distance passenger service Musina - Johannesburg

-- simplify
select rn_insert_edge(555116712, 555024444, 556000131);
update africa_osm_edges set status = 'open' where oid = 556000131;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555024444,
		555008844,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Germiston - Pretoria',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network, GauTeng Metrorail, Shosholoza Meyl long distance passenger service Musina - Johannesburg'
where oid in (select edge from tmp);

-- Kaalfontein - Leralla
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555063682,
		555061840,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kaalfontein - Leralla',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'GauTeng Metrorail'
where oid in (select edge from tmp);

-- Olifantsfontein/Oakmoor - Sentrarand Marshalling Yard
-- Transnet core network
-- Freight

-- split 555012029 at 555064819
select rn_split_edge(array[555012029], array[555064819]	);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555064819,
		555048208,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Olifantsfontein/Oakmoor - Sentrarand Marshalling Yard',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. electrified'
where oid in (select edge from tmp);

-- additional link

select rn_insert_edge(555034523, 555001452, 556000132);
update africa_osm_edges set status = 'open' where oid = 556000132;
-- simplify
select rn_copy_node(array[555039209], array[555003309]);
select rn_change_target(555012026, 556039209);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555001452,
		555002917,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Olifantsfontein/Oakmoor - Sentrarand Marshalling Yard',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. electrified'
where oid in (select edge from tmp);

-- Germiston - Springs

-- split 555082423 at 555116689
select rn_split_edge(array[555082423], array[555116689]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open''  ',
            555116689,
		555014309,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Germiston - Springs',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network, GauTeng Metrorail'
where oid in (select edge from tmp);

-- Skansdam - Transnet Welgedag Depot
-- Core network
-- Freight only

-- split 555134481 at 555140952
-- split 555019581 at 555140951
select rn_split_edge(array[555134481,555019581], array[555140952,555140951]);
-- split 5550588831 at 555098041
select rn_split_edge(array[5550588831], array[555098041]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid not in (555004492) ',
            555140951,
		555098041,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Skansdam - Transnet Welgedag Depot',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Electrified.'
where oid in (select edge from tmp);

-- links
-- split 555004646 at 555065389
select rn_split_edge(array[555004646], array[555065389]);
select rn_change_target(555017607, 555140251);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555065389,
		555140251,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line junction',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Electrified.'
where oid in (select edge from tmp);

-- split 555004648 at 555140254
-- split 555017783 at 555140257
select rn_split_edge(array[555004648,555017783], array[555140254,555140257]);
select rn_insert_edge(555140254, 555140257, 556000133);
update africa_osm_edges set status = 'open' where oid = 556000133;
select rn_copy_node(array[555065392], array[555115674]);
select rn_change_target(555004649, 556065392);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555140257,
		556065392,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line junction',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network. Electrified.'
where oid in (select edge from tmp);

-- split 5550177832 at 555068695
select rn_split_edge(array[5550177832], array[555068695);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555140576,
		555068695,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line link',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Electrified.'
where oid in (select edge from tmp);

-- Dunswart - Daveyton

-- split 555119593 at 555140449
-- split 555119590 at 555140448
select rn_split_edge(array[555119593,555119590], array[555140449,555140448]);

update africa_osm_nodes
set railway = null where oid = 555061593;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555140448,
		555061594,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Dunswart - Daveyton',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

-- Pretoria - Pretoria Wes
-- Core network
-- Metrorail

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555008844,
		555001489,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pretoria - Pretoria Wes',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network, Gauteng metrorail'
where oid in (select edge from tmp);

-- Pretoria Wes - Pretoria Nord
-- Core network
-- Metrorail

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555001489,
		555001488,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pretoria Wes - Pretoria Nord',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network, Gauteng metrorail'
where oid in (select edge from tmp);

-- Saulsville - Pretoria Wes
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555001514,
		555000063,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Saulsville - Pretoria Wes',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

-- Rebecca - Schuttestraat

update africa_osm_nodes set railway = null where oid = 555036150;
select rn_copy_node(array[555001471], array[555089528]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555036091,
		555036086,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rebecca - Schuttestraat',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

-- Hercules - Belle Ombre

update africa_osm_nodes set railway = null where oid = 555050696;
select rn_copy_node(array[555001389], array[555089751]);
--simplify
select rn_insert_edge(555121681, 555036165, 556000134);
update africa_osm_edges set status = 'open' where oid = 556000134;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555036165,
		555050698,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hercules - Belle Ombre',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555036091,
		555036086,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rebecca - Schuttestraat',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

-- Hercules - Pienaarspoort

-- split 5550897512 at 555121691
select rn_split_edge(array[5550897512], array[555121691]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555121691,
		555048236,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hercules - Pienaarspoort',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

-- Rayton - Pienaarspoort
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555061880,
		555048236,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rayton - Pienaarspoort',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet core network, Gauteng metrorail'
where oid in (select edge from tmp);

-- freight link

update africa_osm_nodes
set railway = null where oid in (555063236,555048384);

-- simplify
select rn_insert_edge(555035791, 555001372, 556000135);
update africa_osm_edges set status = 'open' where oid = 556000135;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555135440,
		555001372,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Greenview Junction (freight link)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Rayton - Cullinan

update africa_osm_nodes set railway = 'station' where oid = 555001333;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555008080,
		555001333,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rayton - Cullinan',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Believed to only be used for tourist tours by steam train to the diamond mine adjacent to Cullinan station.'
where oid in (select edge from tmp);

-- Pretoria - Koedoespoort

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555096535,
		555035977,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pretoria - Koedoespoort',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

-- Rovos Rail
-- private tourist train

select rn_copy_node(array[555050299], array[555090084]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555068488,
		556050299,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rovos Railway station (private)',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Station used by tourist trains'
where oid in (select edge from tmp);

-- Pretoria Nord - De Wildt

update africa_osm_nodes
set railway = null where oid = 555049908;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555053387,
		555049901,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Pretoria Nord - De Wildt',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

-- Winternest - Mabopane

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555068342,
		555001430,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Winternest - Mabopane',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

-- Lafarge Tswana Lime Quarry
update africa_osm_nodes
set name = 'Lafarge Tswana Lime',
railway = 'stop',
facility = 'quarry',
comment = 'limestone quarry'
where oid = 555050653;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555001705,
		555050653,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Lafarge Tswana Lime Quarry',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Springbokan grain silos
update africa_osm_nodes
set name = 'Springbokan grain silos',
railway = 'stop',
facility = 'food storage'
where oid =  555050654;

-- split 555014510 at 555138726
select rn_split_edge(array[555014510], array[555138726]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555138726,
		555050654,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Springbokan grain silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Lafarge Lichtenburg limestone quarry and plant

select rn_copy_node(array[555138715], array[555111605]);

update africa_osm_nodes
set name = 'Lafarge Lichtenburg (limestone quarry and plant)',
railway = 'stop',
facility = 'quarry',
comment = ''
where oid = 556138715;

-- split 555011842 at 555138720
select rn_split_edge(array[555011842], array[555138720]);
-- split 555011245 at 555068635
select rn_split_edge(array[555011245], array[555068635]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555068635,
		556138715,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Lafarge Lichtenburg (limestone quarry and plant)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- NWK Lichtenburg grain silos

update africa_osm_nodes
set name = 'NWK Lichtenburg grain silos',
railway = 'stop',
facility = 'food storage'
where oid =  555076109;

select rn_insert_edge(555001705, 555076108, 556000136);
update africa_osm_edges set status = 'open' where oid = 556000136;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555001705,
		555076109,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'NWK Lichtenburg grain silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Afrisam Dudfield Cement Factory

update africa_osm_nodes
set name = 'Afrisam Dudfield Cement Factory',
railway = 'stop',
facility = 'manufacturing'
where oid =  555007411;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555070039,
		555007411,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Afrisam Dudfield Cement Factory',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- NWK Hibernia Grain silos
update africa_osm_nodes
set name = 'NWK Hibernia Grain silos',
railway = 'stop',
facility = 'food storage'
where oid =  555105806;

-- split 555014502 at 555105807

select rn_split_edge(array[555014502], array[555105807]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555105807,
		555105806,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'NWK Hibernia Grain silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Vaal Reefs Goldmine complex

update africa_osm_nodes
set name = 'Vaal Reefs gold mine complex',
railway = 'stop',
facility = 'mine',
comment = 'Gold mine. Access point'
where oid = 555033116;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555080223,
		555033116,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Vaal Reefs gold mine complex (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Tshepong Harmony Gold Mine
update africa_osm_nodes
set name = 'Tshepong Harmony Gold Mine',
railway = 'stop',
facility = 'mine',
comment = 'Gold mine'
where oid = 555011393;

-- split 555029578 at 555075857
select rn_split_edge(array[555029578], array[555075857]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555075857,
		555011393,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tshepong Harmony Gold Mine',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Senwes Grainlink Odendaalsrus grain silos

-- split 555025599 at 555075879
select rn_split_edge(array[555025599], array[555075879]);

update africa_osm_nodes
set name = 'Senwes Grainlink Odendaalsrus grain silos',
railway = 'stop',
facility = 'food storage'
where oid =  555151631;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555075879,
		555151631,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Senwes Grainlink Odendaalsrus grain silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Welkom gold mines (access)

-- split 555025587 at 555075848
select rn_split_edge(array[555025587], array[555075848]);

update africa_osm_nodes
set name = 'Welkom gold mines (access)',
railway = 'stop',
facility = 'mine'
where oid =  555052656;

-- split 555117030 at 555117110
select rn_split_edge(array[555117030], array[555117110]);
-- split 5551170301 at 555075847
select rn_split_edge(array[5551170301], array[555075847]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555117110,
		555052656,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Welkom gold mines (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Senwes Grainlink Hennenman grain silos
update africa_osm_nodes
set name = 'Senwes Grainlink Hennenman grain silos',
railway = 'stop',
facility = 'food storage'
where oid =  555089268;

-- Tiger Milling Hennenman - grain mill

update africa_osm_nodes
set name = 'Tiger Milling Hennenman',
railway = 'stop',
facility = 'food manufacture',
comment = 'grain mill'
where oid =  555019615;

-- split 555131741 at 555091626
select rn_split_edge(array[555131741], array[555091626]);
-- split 555049792 at 555089266
select rn_split_edge(array[555049792], array[555089266]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555060187,
		555019615,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tiger Milling Hennenman',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555019614,
		555089268,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Senwes Grainlink Hennenman grain silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Shell Fuel storage depot
update africa_osm_nodes
set name = 'Shell Fuel storage depot, Kroonstad',
railway = 'stop',
facility = 'fuel storage depot',
comment = ''
where oid =  555059175;

-- split 555070191 at 555136443
select rn_split_edge(array[555070191], array[555136443]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555138645,
		555059175,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Shell Fuel storage depot, Kroonstad',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


update africa_osm_nodes
set name = 'Senwes Grainlink Viljoenskroon grain silos',
railway = 'stop',
facility = 'food storage'
where oid =  555019156;

update africa_osm_nodes
set name = 'Senwes Grainlink Viljoenskroon grain silos',
railway = 'stop',
facility = 'food storage'
where oid =  555151795;

select rn_insert_edge(555059609, 555059608, 556000137);
update africa_osm_edges set status = 'open' where oid = 556000137;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555059609,
		555019156,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Senwes Grainlink Viljoenskroon grain silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- split 555045023 at 555151795
select rn_split_edge(array[555045023], array[555151795]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555059609,
		555151795,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Senwes Grainlink Viljoenskroon grain silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- ArcelorMittal South Africa Vanderbijlpark Steel works

update africa_osm_nodes
set name = 'ArcelorMittal South Africa Vanderbijlpark Steel works',
railway = 'stop',
facility = 'manufacturing'
where oid = 555152289;

-- simplify
select rn_copy_node(array[555063596],array[555035454]);
select rn_insert_edge(555063596, 556063596, 556000138);
update africa_osm_edges set status = 'open' where oid = 556000138;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            556063596,
		555152289,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'ArcelorMittal South Africa Vanderbijlpark Steel works',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Lethano Power Station (Eskom)
update africa_osm_nodes
set name = 'Lethano Power Station (Eskom)',
railway = 'stop',
facility = 'power station'
where oid = 555053252;

-- split 555070853 at 555152411
-- split 555132686 at 555152412
select rn_split_edge(array[555070853,555132686], array[555152411,555152412]);
-- split 555134463 at 555065423
select rn_split_edge(array[555134463], array[555065423]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555152412,
		555053252,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Lethano Power Station (Eskom)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Tongaat Hulett Starch Kliprivier Facility
-- wet-milling operation is the major producer of starch and glucose 
update africa_osm_nodes
set name = 'Tongaat Hulett Starch Kliprivier Facility',
railway = 'stop',
facility = 'food production',
comment = 'wet-milling operation is the major producer of starch and glucose 
update africa_osm_nodes'
where oid = 555140735;

-- simplify
select rn_copy_node(array[555076832], array[555045437]);
select rn_change_target(555026770, 556076832);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            556076832,
		555140735,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tongaat Hulett Starch Kliprivier Facility',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- AFGRI Nigel Silo

update africa_osm_nodes
set name = 'AFGRI Nigel Silo',
railway = 'stop',
facility = 'food storage',
comment = 'grain silos'
where oid = 555011915;

-- split 555011932 at 555073117
select rn_split_edge(array[555011932], array[555073117]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555073117,
		555011915,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'AFGRI Nigel Silo',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Gibela train manufacturing plant
update africa_osm_nodes
set name = 'Gibela train manufacturing plant',
railway = 'stop',
facility = 'manufacturing',
comment = ''
where oid = 555128101;

-- split 555100139 at 555128100
select rn_split_edge(array[555100139], array[555128100]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555128100,
		555128101,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gibela train manufacturing plant',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Union Carriage and Wagon
update africa_osm_nodes
set name = 'Union Carriage and Wagon',
railway = 'stop',
facility = 'manufacturing',
comment = 'rail rolling stock manufacture'
where oid = 555073115;

-- split 555020161 at 555129425
select rn_split_edge(array[555020161], array[555129425]);
-- split 5550201611 at 555073114
select rn_split_edge(array[5550201611], array[555073114]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555073114,
		555073115,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Union Carriage and Wagon factory',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Enstra Paper - paper recycling
update africa_osm_nodes
set name = 'Enstra Paper',
railway = 'stop',
facility = 'manufacturing',
comment = 'paper recycling'
where oid = 555139632;

-- split 555058959 at 555139632
select rn_split_edge(array[555058959], array[555139632]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555068654,
		555139632,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Enstra Paper',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Colossal Concrete Products
-- railway sleepes etc

update africa_osm_nodes
set name = 'Colossal Concrete Products',
railway = 'stop',
facility = 'manufacturing',
comment = 'railway sleepers and other concrete products for rail infrastructure'
where oid = 555051574;

-- split 555012989 at 555140065
select rn_split_edge(array[555012989], array[555140065]);
-- split 555118973 at 555154176
select rn_split_edge(array[555118973], array[555154176]);
-- split 555012983 at 555072480
select rn_split_edge(array[555012983], array[555072480]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555054058,
		555051574,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Colossal Concrete Products',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Impala Refining Services
-- Metals refining

update africa_osm_nodes
set name = 'Impala Refining Services',
railway = 'stop',
facility = 'manufacturing',
comment = 'base and precious metals refining'
where oid = 555098083;

-- split 5550589591 at 555098072
select rn_split_edge(array[5550589591], array[555098072]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555098072,
		555098083,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Impala Refining Services',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Alrode fuel depot
update africa_osm_nodes
set name = 'Alrode fuel depot',
railway = 'stop',
facility = 'fuel depot',
comment = ''
where oid = 555072610;

-- split 555032297 at 555080018
-- split 555123448 at 555140286
select rn_split_edge(array[555032297,555123448], array[555080018,555140286]);
-- split 555113744 at 555080015
select rn_split_edge(array[555113744], array[555080015]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555140286,
		555072610,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Alrode fuel depot',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kelvin Power Station
update africa_osm_nodes
set name = 'Kelvin Power Station',
railway = 'stop',
facility = 'power station',
comment = ''
where oid = 555072538;

--simplify
select rn_insert_edge(555054005, 555001406, 556000139);
update africa_osm_edges set status = 'open' where oid = 556000139;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555001406,
		555072538,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kelvin Power Station',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Modderfontein industrial area, Kempton Park
update africa_osm_nodes
set name = 'Modderfontein industrial area, Kempton Park',
railway = 'stop',
facility = 'industrial area',
comment = ''
where oid = 555054233;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555014312,
		555054233,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Modderfontein industrial area, Kempton Park',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Isando Industrial Park

-- simplify
select rn_copy_node(array[555054278], array[555090636]);
select rn_insert_edge(555054278, 556054278, 556000140);
update africa_osm_edges set status = 'open' where oid = 556000140;

update africa_osm_nodes
set name = 'Isando Industrial Park',
railway = 'stop',
facility = 'industrial area',
comment = ''
where oid = 555007492;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            556054278,
		555007492,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Isando Industrial Park',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Nesrec branch
-- Metrorail
-- Passenger  -not regularly used


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555032721,
		555001439,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Nasrec branch',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail. Not regularly used.'
where oid in (select edge from tmp);

-- Bidvest SACD freight terminal
update africa_osm_nodes
set name = 'Bidvest SACD freight terminal',
railway = 'stop',
facility = 'container terminal',
comment = ''
where oid = 555070117;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555032954,
		555070117,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bidvest SACD freight terminal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- PPC Jupiter Cement Factory 

update africa_osm_nodes
set name = 'PPC Jupiter Cement Factory',
railway = 'stop',
facility = 'manufacturing',
comment = ''
where oid = 555069654;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555032934,
		555069654,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'PPC Jupiter Cement Factory',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Engen fuel depot
update africa_osm_nodes
set name = 'Engen fuel depot',
railway = 'stop',
facility = 'fuel depot',
comment = ''
where oid = 555141003;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555032739,
		555141003,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Engen fuel depot',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Westgate
-- Gauteng metrorail

update africa_osm_nodes
set railway = null where oid = 555061831;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555056234,
		555001523,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Westgate branch',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail'
where oid in (select edge from tmp);

-- Faraday
-- Gauteng metrorail

update africa_osm_nodes
set railway = null where oid = 555032860;

-- split 555000991 at 555116626
select rn_split_edge(array[555000991], array[555116626]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555116626,
		555032858,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Faraday branch',
mode = 'passenger',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Gauteng metrorail.'
where oid in (select edge from tmp);

-- Afrisam Cement Factory
update africa_osm_nodes
set name = 'Afrisam Cement Factory, Roodepoort',
railway = 'stop',
facility = 'manufacturing',
comment = ''
where oid = 555056385;

-- split 555003798 at 555146918
select rn_split_edge(array[555003798], array[555146918]);


select rn_copy_node(array[555056408], array[555122236]);
-- simplify
select rn_insert_edge(555000349, 556056408, 556000141);
update africa_osm_edges set status = 'open' where oid = 556000141;
-- split 555000741 at 555063575
select rn_split_edge(array[555000741], array[555063575]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            556056408,
		555056385,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Afrisam Cement Factory, Roodepoort',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- South Germiston Industrial Park
update africa_osm_nodes
set name = 'South Germiston Industrial Park',
railway = 'stop',
facility = 'industrial area',
comment = ''
where oid = 555014333;

--- split 555082427 at 555116691
select rn_split_edge(array[555082427], array[555116691]);
-- split 5550824272 at 555080007
select rn_split_edge(array[5550824272], array[555080007]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555116692,
		555014333,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'South Germiston Industrial Park',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Germiston marshalling yards
update africa_osm_nodes
set name = 'Germiston marshalling yards',
railway = 'stop',
facility = 'railway',
comment = ''
where oid = 555093475;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555056342,
		555093475,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Germiston marshalling yards',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Meadow Feeds - Northern Region
-- Animal feed store
update africa_osm_nodes
set name = 'Meadow Feeds - Northern Region',
railway = 'stop',
facility = 'food storage',
comment = 'Animal feed store'
where oid = 555150769;

select rn_copy_node(array[555061749], array[555129344]);
select rn_copy_node(array[555150772], array[5551293441]);

select rn_insert_edge(555150772, 556150772, 556000142);
update africa_osm_edges set status = 'open' where oid = 556000142;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            556150772,
		555150769,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Meadow Feeds - Northern Region',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Richards Bay Minerals (RioTinto)
update africa_osm_nodes
set name = 'Richards Bay Minerals (RioTinto)',
railway = 'stop',
facility = 'mining',
comment = 'sand mining - mineral extraction. See: https://www.riotinto.com/en/operations/south-africa/richards-bay-minerals'
where oid = 555125864;

-- split 555095109 at 555096346
select rn_split_edge(array[555095109], array[555096346]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555096346,
		555125864,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Richards Bay Minerals (RioTinto)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Mondi Richards Bay Mill
update africa_osm_nodes
set name = 'Mondi Richards Bay Mill',
railway = 'stop',
facility = 'manufacturing',
comment = 'bleached hardwood pulp and white top kraft linerboard.'
where oid = 555038462;

-- split 555044714 at 555124542
select rn_split_edge(array[555044714], array[555124542]);

-- simplify
select rn_copy_node(array[555088324], array[555093729]);
select rn_change_source(555044712, 556088324);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            556088324,
		555038462,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mondi Richards Bay Mill',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- various Richards Bay Freight

-- split 555016345 at 555124357
select rn_split_edge(array[555016345], array[555124357]);
-- split 555093622 at 555124310
select rn_split_edge(array[555093622], array[555124310]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555124357,
		555124310,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Freight spur',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Foskor Richards Bay
--  sulphuric acid (H2SO4), phosphoric acid (P2O5) and granular fertiliser (MAP/DAP)
update africa_osm_nodes
set name = 'Foskor Richards Bay',
railway = 'stop',
facility = 'manufacturing',
comment = 'sulphuric acid (H2SO4), phosphoric acid (P2O5) and granular fertiliser (MAP/DAP)'
where oid = 555038407;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555124310,
		555038407,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Foskor Richards Bay',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Central Timber Cooperative, Richards Bay
update africa_osm_nodes
set name = 'Central Timber Cooperative, Richards Bay',
railway = 'stop',
facility = 'manufacturing',
comment = 'timber, woodchip mill'
where oid = 555038416;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555124310,
		555038416,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Central Timber Cooperative, Richards Bay',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Grindrod dry-bulk terminal, Richards Bay
update africa_osm_nodes
set name = 'Grindrod dry-bulk terminal, Richards Bay',
railway = 'stop',
facility = 'freight terminal',
comment = ''
where oid = 555124356;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555078492,
		555124356,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Grindrod dry-bulk terminal, Richards Bay',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- BHP Billiton Bayside
-- Aluminium casthouse
-- Smelter closed

update africa_osm_nodes
set name = 'BHP Billiton Bayside',
railway = 'stop',
facility = 'manufacturing',
comment = 'Aluminium casthouse, semlter believed to be closed.'
where oid = 555124324;

-- split 555093437 at 555124197
select rn_split_edge(array[555093437], array[555124197]);
-- split 555093505 at 555124230
-- split 555093453 at 555124325
-- split 555093484 at 555124195
-- split 555093482 at 555124231
select rn_split_edge(array[555093505,555093453,555093484,555093482], array[555124230,555124325,555124195,555124231]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555124197,
		555124324,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'BHP Billiton Bayside',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- ArcelorMittal Newcastle Works
-- Long steel products

update africa_osm_nodes
set name = 'ArcelorMittal Newcastle Works',
railway = 'stop',
facility = 'manufacturing',
comment = 'Long steel products'
where oid = 555076405;

-- split 555050612 at 555076405
select rn_split_edge(array[555050612], array[555076405]);
-- split 555050609 at 555076379
select rn_split_edge(array[555050609], array[555076379]);
-- split 555026150 at 555130316
select rn_split_edge(array[555026150], array[555130316]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555076379,
		555076384,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Freight spur',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555076379,
		555076384,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'ArcelorMittal Newcastle Works',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Natal Portland Cement Company
-- Cement factory

update africa_osm_nodes
set name = 'Natal Portland Cement Company, Newcastle',
railway = 'stop',
facility = 'manufacturing',
comment = 'cement manufacturing'
where oid = 555042080;

-- split 555026165 at 555076383
select rn_split_edge(array[555026165], array[555076383]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid != 555101311',
            555076384,
		555042080,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Natal Portland Cement Company, Newcastle',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

update africa_osm_nodes set railway = 'station' where oid = 555003361;
-- simplify
select rn_insert_edge(555128219, 555003361, 556000143);
update africa_osm_edges set status = 'open' where oid = 556000143;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid != 555101311',
            555042080,
		555003361,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Natal Portland Cement Company, Newcastle',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Karbochem Industrial Complex, Newcastle
-- Chemicals company

update africa_osm_nodes
set name = 'Karbochem Industrial Complex, Newcastle',
railway = 'stop',
facility = 'manufacturing',
comment = 'chemicals manufacturing and associated power plant'
where oid = 555091649;

-- split 555049832 at 555091648
select rn_split_edge(array[555049832], array[555091648]);
-- split 555098641 at 555091650
select rn_split_edge(array[555098641], array[555091650]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555091650,
		555091649,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Karbochem Industrial Complex, Newcastle',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Vryheid Afgri Silo
update africa_osm_nodes
set name = 'Vryheid Afgri Silo',
railway = 'stop',
facility = 'food storage',
comment = 'grain silos'
where oid = 555044091;

-- split 555051684 at 555131332
select rn_split_edge(array[555051684], array[555131332]);
-- split 555023274 at 555131318
-- split 555102779 at 555131303
select rn_split_edge(array[555023274,555102779], array[555131318,555131303]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555131318,
		555044091,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Vryheid Afgri Silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Paulpietersburg Afgri Silo
update africa_osm_nodes
set name = 'Paulpietersburg Afgri Silo',
railway = 'stop',
facility = 'food storage',
comment = 'grain silos'
where oid = 555045433;

-- split 555104166 at 555132403
select rn_split_edge(array[555104166], array[555132403]);
-- split 555104168 at 555132399
-- split 555104162 at 555132413
select rn_split_edge(array[555104168,555104162], array[555132399,555132413]);
select rn_insert_edge(555132413, 555132433, 556000144);
update africa_osm_edges set status = 'open' where oid = 556000144;
--split 555104182 at 555132433
select rn_split_edge(array[555104182], array[555132433]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555132403,
		555045433,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Paulpietersburg Afgri Silos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Komati Sugar Mill (RCL Foods)
update africa_osm_nodes
set name = 'Komati Sugar Mill (RCL Foods)',
railway = 'stop',
facility = 'food production',
comment = 'sugar mill'
where oid = 555058838;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555006303,
		555058838,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Komati Sugar Mill (RCL Foods)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Malelane Sugar Mill (RCL Foods)
update africa_osm_nodes
set name = 'Malelane Sugar Mill (RCL Foods)',
railway = 'stop',
facility = 'food production',
comment = 'sugar mill'
where oid = 555068227;

-- split 555128576 at 555150340
select rn_split_edge(array[555128576], array[555150340]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555089125,
		555068227,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Malelane Sugar Mill (RCL Foods)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Mangenese Metal Company, Mbombela/Nelspruit

update africa_osm_nodes
set name = 'Mangenese Metal Company, Mbombela/Nelspruit',
railway = 'stop',
facility = 'manufacturing',
comment = 'manganese refinery'
where oid = 555047109;

-- split 555106275 at 555134318
-- split 555022903 at 555134319
select rn_split_edge(array[555106275,555022903], array[555134318,555134319]);
-- split 5550229031 at 555069414
-- split 555046877 at 555074372
-- split 555022913 at 555146230
select rn_split_edge(array[5550229031,555046877,555022913], array[555069414,555074372,555146230]);
-- split 555046884 at 555134196
select rn_split_edge(array[555046884], array[555134196]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555134318,
		555146230,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Freight spur',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555146230,
		555047109,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mangenese Metal Company, Mbombela/Nelspruit',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Fuel depot, Mbombela/Nelspruit 
update africa_osm_nodes
set name = 'Fuel depot, Mbombela/Nelspruit',
railway = 'stop',
facility = 'fuel depot',
comment = ''
where oid = 555047170;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555146230,
		555047170,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Fuel depot, Mbombela/Nelspruit',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Lydenburg Afgri Silo
update africa_osm_nodes
set name = 'Lydenburg Afgri Silo',
railway = 'stop',
facility = 'food storage',
comment = 'grain silos'
where oid = 555027968;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555027974,
		555027968,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Lydenburg Afgri Silo',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Glencore Lydenburg Smelter
-- ferrochrome smelter
update africa_osm_nodes
set name = 'Glencore Lydenburg Smelter',
railway = 'stop',
facility = 'manufacturing',
comment = 'ferrochrome smelter'
where oid = 555048733;


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555011173,
		555048733,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Glencore Lydenburg Smelter',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Tubatse Ferrochrome
update africa_osm_nodes
set name = 'Tubatse Ferrochrome, Steelpoort',
railway = 'stop',
facility = 'manufacturing',
comment = 'ferrochrome smelter'
where oid = 555048749;

-- split 555022772 at 555074275
select rn_split_edge(array[555022772], array[555074275]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555071837,
		555048749,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tubatse Ferrochrome, Steelpoort',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Idwala Lime Quarry
update africa_osm_nodes
set name = 'Idwala Lime Quarry',
railway = 'stop',
facility = 'quarry',
comment = 'limestone quarry'
where oid = 555068860;

-- split 555012175 at 555068860
select rn_split_edge(array[555012175], array[555068860]);
-- split 555012226 at 555068791
select rn_split_edge(array[555012226], array[555068791]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555068791,
		555068860,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Idwala Lime Quarry',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Department of Defence Ammunition Depot, Vaalharts Nedersetting
update africa_osm_nodes
set name = 'Department of Defence Ammunition Depot, Vaalharts Nedersetting',
railway = 'stop',
facility = 'military'
where oid = 555012283;

-- split 555132866 at 555077408
select rn_split_edge(array[555132866], array[555077408]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555077408,
		555012283,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Department of Defence Ammunition Depot, Vaalharts Nedersetting',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Natal Portland Cement, Simuma
update africa_osm_nodes
set name = 'Natal Portland Cement Factory, Simuma',
railway = 'stop',
facility = 'manufacturing'
where oid = 555075844;

-- split 555122742 at 555075843
select rn_split_edge(array[555122742], array[555075843]);
-- split 555013463 at 555071272
select rn_split_edge(array[555013463], array[555071272]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555071272,
		555075844,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Natal Portland Cement Factory, Simuma',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Sappi Saiccor Paper Mill, Umkomaas
-- See: https://www.sappi.com/saiccor-mill
update africa_osm_nodes
set name = 'Sappi Saiccor Paper Mill, Umkomaas',
railway = 'stop',
facility = 'manufacturing',
comment = 'see: https://www.sappi.com/saiccor-mill'
where oid = 555067762;

-- split 555005912 at 555067780
select rn_split_edge(array[555005912], array[555067780]);
-- split 555010128 at 555146617
select rn_split_edge(array[555010128], array[555146617]);

update africa_osm_nodes
set railway = null where oid = 555003934;

-- simplify
select rn_insert_edge(555067776, 555061632, 556000145);
update africa_osm_edges set status = 'open' where oid = 556000145;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555061632,
		555067762,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sappi Saiccor Paper Mill, Umkomaas',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Anchor Yeast, Umbogintwini Industrial Complex
update africa_osm_nodes
set name = 'Anchor Yeast, Umbogintwini Industrial Complex',
railway = 'stop',
facility = 'manufacturing',
comment = 'see:https://www.anchor.co.za/who-we-are/our-production-facility/'
where oid = 555057263;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555003899,
		555057263,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Anchor Yeast, Umbogintwini Industrial Complex',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Engen Oil Refinery, Merebank, Durban
-- see: https://www.engen.co.za/about/manufacturing
-- Reported to be converted to fuel storage facility in 2023
-- see: http://bit.ly/3MKwNbc

update africa_osm_nodes
set name = 'Engen Oil Refinery, Wentworth, Durban',
railway = 'stop',
facility = 'oil refinery',
comment = 'see: https://www.engen.co.za/about/manufacturing. Reported to be converted to fuel storage facility in 2023, see: http://bit.ly/3MKwNbc'
where oid = 555067613;

-- split 555005727 at 555147676
--split 555009763 at 555147677
select rn_split_edge(array[555005727,555009763], array[555147676,555147677]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555147677,
		555067613,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Engen Oil Refinery, Merebank, Durban',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- SAPREF oil refinery
-- https://www.sapref.com/who-we-are
update africa_osm_nodes
set name = 'SAPREF oil refinery, Prospecton, Durban',
railway = 'stop',
facility = 'oil refinery',
comment = 'see: https://www.sapref.com/who-we-are'
where oid = 555147630;

--simplify
select rn_insert_edge(555065848, 555065849, 556000146);
update africa_osm_edges set status = 'open' where oid = 556000146;

-- split 555005793  at 555147631
select rn_split_edge(array[555005793], array[555147631]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555065849,
		555147630,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'SAPREF oil refinery, Prospecton, Durban',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Access World container rail transfer

update africa_osm_nodes
set name = 'Access World, Rossburgh, Durban (container rail transfer)',
railway = 'stop',
facility = 'container terminal',
comment = ''
where oid = 555066259;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' and oid not in (555009540,555009539) ',
            555056914,
		555066259,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Access World, Rossburgh, Durban (container rail transfer)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Tongaat Hulett Sugar Maidstone Mill
update africa_osm_nodes
set name = 'Tongaat Hulett Sugar Maidstone Mill',
railway = 'stop',
facility = 'food production',
comment = ''
where oid = 555004580;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555004577,
		555004580,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tongaat Hulett Sugar Maidstone Mill',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Gledhow Sugar Mill
update africa_osm_nodes
set name = 'Gledhow Sugar Company - Gledhow Mill',
railway = 'stop',
facility = 'food production',
comment = ''
where oid = 555106024;

-- split 555029606 at 555078670
select rn_split_edge(array[555029606], array[555078670]);
-- split 555046628 at 555078674
select rn_split_edge(array[555046628], array[555078674]);
-- split 555070134 at 555078676 
select rn_split_edge(array[555070134], array[555078676]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555078674,
		555106024,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gledhow Sugar Company - Gledhow Mill',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Sappi Stanger Paper Mill
update africa_osm_nodes
set name = 'Sappi Stanger Paper Mill',
railway = 'stop',
facility = 'manufacturing',
comment = ''
where oid = 555106016;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555078670,
		555106016,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sappi Stanger Paper Mill',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Tongaat Hulett Sugar Amatikulu Mill
update africa_osm_nodes
set name = 'Tongaat Hulett Sugar Amatikulu Mill',
railway = 'stop',
facility = 'food production',
comment = ''
where oid = 555120918;

-- split 555094945 at 555125737
select rn_split_edge(array[555094945], array[555125737]);
-- split 555094957 at 555089770
select rn_split_edge(array[555094957], array[555089770]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555125737,
		555120918,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tongaat Hulett Sugar Amatikulu Mill',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Tongaat Hulett Sugar Felixton Mill
update africa_osm_nodes
set name = 'Tongaat Hulett Sugar Felixton Mill',
railway = 'stop',
facility = 'food production',
comment = ''
where oid = 555125564;

-- split 555094808 at 555125588
select rn_split_edge(array[555094808], array[555125588]);
-- split 555094795 at 555125569
select rn_split_edge(array[555094795], array[555125569]);
-- split 555094781 at 555125554
select rn_split_edge(array[555094781], array[555125554]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555125588,
		555125564,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tongaat Hulett Sugar Felixton Mill',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Mpact Felixton Paper Mill

update africa_osm_nodes
set name = 'Mpact Felixton Paper Mill',
railway = 'stop',
facility = 'manufacturing',
comment = ''
where oid = 555125583;

-- simplify
select rn_insert_edge(555125582, 555038741, 556000147);
update africa_osm_edges set status = 'open' where oid = 556000147;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555038741,
		555125583,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mpact Felixton Paper Mill',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Port of East London (vehicle Terminal)

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''open'' ',
            555006426,
		555006428,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of East London (vehicle Terminal)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- additional disused/abandoned lines

-- Alicedale - Port Alfred

-- split 555017399 at 555097426
select rn_split_edge(array[555017399], array[555097426]);
-- split 555036329 at 555063700
select rn_split_edge(array[555036329], array[555063700]);
-- split 5550363291 at 555097427
select rn_split_edge(array[5550363291], array[555097427]);


-- simplify
select rn_insert_edge(int8, int8, int8)

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555097426,
		555000944,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Alicedale - Port Alfred',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Barkly Bridge - Alexandria
-- mix of abandoned and disused

-- split 555017448 at 555106933
select rn_split_edge(array[555017448], array[555106933]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555106933,
		555000660,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Barkly Bridge - Alexandria',
mode = 'freight',
type = 'conventional',
gauge = '1067',
comment = ''
where oid in (select edge from tmp);

-- Cookhouse - Somerset East

-- split 555054133 at 555065503
select rn_split_edge(array[555054133], array[555065503]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555065503,
		555001032,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Cookhouse - Somerset East',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Fort Beaufort - Seymour
-- Lifted according to Transnet map - mark as abandoned

-- split 555001606 at 555067837
select rn_split_edge(array[555001606], array[555067837]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555067837,
		555000984,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Fort Beaufort - Seymour',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'razed',
comment = 'Lifted according to Transnet 2021 report network map'
where oid in (select edge from tmp);

-- Sterkstroom - Maclear

-- split 555025492 at 555138863
select rn_split_edge(array[555025492], array[555138863]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555138863,
		555000901,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sterkstroom - Maclear',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Molteno - Jamestown

update africa_osm_nodes
set railway = 'station' where oid = 555000844;

-- split 555047051 at 555138865
select rn_split_edge(array[555047051], array[555138865]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555138865,
		555000844,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Molteno - Jamestown',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'razed',
comment = 'Lifted according to Transnet 2021 report network map'
where oid in (select edge from tmp);

-- Rosmead - Stormberg

-- split 555054332 at 555064771
-- split 5550270562 at 555094765
select rn_split_edge(array[555054332,5550270562], array[555064771,555094765]);
-- split 555047058 at 555097216
select rn_split_edge(array[555047058], array[555097216]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
            555094765,
		555097216,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rosmead - Stormberg',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Schoombee - Hofmeyr

-- split 555091847 at 555063652
select rn_split_edge(array[555091847], array[555063652]);

update africa_osm_nodes
set railway = 'station' where oid = 555000795;


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555063652,
		555000795,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Schoombee - Hofmeyr',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Dreunberg - Sannaspos
-- mix of disused and abandoned (OSM)

-- split 555017711 at 555063609
select rn_split_edge(array[555017711], array[555063609]);
-- split 555116986 at 555127941
-- split 555116990 at 555142978
select rn_split_edge(array[555116986,555116990], array[555127941,555142978]);
-- split 5551169902 at 555142981
select rn_split_edge(array[5551169902], array[555142981]);
-- split 555024823 at 555142982
select rn_split_edge(array[555024823], array[555142982]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid not in (5550177112, 5550177111)',
           555063609,
		555000596,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Dreunberg - Sannaspos',
mode = 'freight',
type = 'conventional',
gauge = '1067',
comment = ''
where oid in (select edge from tmp);


-- Aliwal North - Barkly East

update africa_osm_nodes
set railway = 'station' where oid = 555000688;

-- split 555021518 at 555131009
select rn_split_edge(array[555021518], array[555131009]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and status = ''disused'' ',
           555131009,
		555000688,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Aliwal North - Barkly East',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);


-- Springfontein - Koffiefontein

-- simplify
select rn_change_source(555121688, 555153626);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555153626,
		555000502,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Springfontein - Koffiefonteint',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'abandoned',
comment = ''
where oid in (select edge from tmp);

-- Grovèput - Copperton

-- spit 555110482 at 555069490
select rn_split_edge(array[555110482], array[555069490]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555069490,
		555001112,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Grovèput - Copperton',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'razed',
comment = 'Lifted according to Transnet 2021 report network map'
where oid in (select edge from tmp);


-- Hutchinson - Calvinia

select rn_copy_node(array[555063046], array[555107783]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555063533,
		556063046,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Hutchinson - Calvinia',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'abandoned',
comment = ''
where oid in (select edge from tmp);

-- Sakrivier branch

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555063639,
		555001254,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sakrivier branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'abandoned',
comment = ''
where oid in (select edge from tmp);


-- Touws River - Ladismith

update africa_osm_nodes
set railway = 'station' where oid = 555006510;

-- split 555000676 at 555067908
select rn_split_edge(array[555000676], array[555067908]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555067908,
		555006510,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Touws River - Ladismith',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'razed',
comment = 'Lifted according to Transnet 2021 report network map'
where oid in (select edge from tmp);

-- Carthill - Kelso

-- split 555086255 at 555119403
-- split 555086259 at 555119402
-- split 555019474 at 555119407
select rn_split_edge(array[555086255,555086259,555019474], array[555119403,555119402,555119407]);



with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid not in (555085526, 555016347)',
           555070794,
		555119407,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Carthill - Kelso',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'razed',
comment = 'Lifted according to Transnet 2021 report network map'
where oid in (select edge from tmp);

-- Ixopo - Madonela

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555070939,
		555008262,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ixopo - Madonela',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'razed',
comment = 'Lifted according to Transnet 2021 report network map'
where oid in (select edge from tmp);


-- Charlestown - Bethal
-- disused and abandoned

select rn_change_source(555016116, 555149697);

-- split 555034648 at 555071067
select rn_split_edge(array[555034648], array[555071067]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' and oid not in (555127089, 555127088, 555034781, 555127156, 555040826, 5550346482, 555127699, 555127710, 555127707)',
           555058325,
		555149697,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Charlestown - Bethal',
mode = 'freight',
type = 'conventional',
gauge = '1067',
comment = ''
where oid in (select edge from tmp);

-- Magaliesburg - Hercules
-- abandoned

-- split 555032351 at 555068478
select rn_split_edge(array[555032351], array[555068478]);
-- split 555089746 at 555121696
-- split  55508975122 at 555121695
select rn_split_edge(array[555089746,55508975122], array[555121696,555121695]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555064133,
		555121695,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Magaliesburg - Hercules',
mode = 'freight',
type = 'conventional',
gauge = '1067',
comment = ''
where oid in (select edge from tmp);

-- Nylstroom - Vaalwater

-- split 555105747 at 555071886
select rn_split_edge(array[555105747], array[555071886]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555071886,
		555001850,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Nylstroom - Vaalwater',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'razed',
comment = 'Lifted according to Transnet 2021 report network map'
where oid in (select edge from tmp);

-- Heilbron - Wolwehoek
-- closed/abandoned

select rn_change_source(555131930, 555060036);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555000499,
		555060036,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Heilbron - Wolwehoek',
mode = 'freight',
type = 'conventional',
gauge = '1067',
comment = ''
where oid in (select edge from tmp);

-- Utrecht branch

-- split 5550986412 at 555076803
select rn_split_edge(array[5550986412], array[555076803]);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555076803,
		555011886,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Utrecht branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
comment = ''
where oid in (select edge from tmp);

-- Dover - Vredefort

update africa_osm_nodes
set railway = 'station',
name = 'Vredefort'
where oid = 555011567;

-- split 5551316812 at 555152540
select rn_split_edge(array[5551316812], array[555152540]);

select rn_change_source(555121818, 555152540);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555152540,
		555011567,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Dover - Vredefort',
mode = 'freight',
type = 'conventional',
gauge = '1067',
comment = ''
where oid in (select edge from tmp);

-- Theunissen - Winburg

-- simplify

select rn_copy_node(array[555152607], array[555021640]);
select rn_change_target(555131777, 556152607);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           556152607,
		555000632,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Theunissen - Winburg',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = ''
where oid in (select edge from tmp);

-- Gingindlovu - Eshowe
-- abandoned/razed

-- split 555094931 at 555125762
select rn_split_edge(array[555094931], array[555125762]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where country = ''South Africa'' ',
           555125698,
		555050770,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gingindlovu - Eshowe',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'abandoned',
comment = 'appears razed'
where oid in (select edge from tmp);


-- stations
-- Kamfersdam
select rn_copy_node(array[555003293], array[555117744]);
-- Veertien Strome
update africa_osm_nodes
set name = 'Veertien Strome',
railway = 'station'
where oid = 555071362;

-- Ferguson
select rn_copy_node(array[555001365], array[555095487]);
-- Mount Edgecombe
update africa_osm_nodes set name = 'Mount Edgecombe', railway = 'station' where oid = 555003593;
-- Kloof
update africa_osm_nodes set name = 'Kloof', railway = 'station' where oid = 555065757;
-- Hillcrest
select rn_copy_node(array[555004067], array[555005681]);
-- Cliffdale
select rn_copy_node(array[555014538], array[555005954]);
-- Umbilo
select rn_copy_node(array[555004127], array[555006254]);
-- Canelands
update africa_osm_nodes set name = 'Canelands', railway = 'station' where oid = 555066424;
-- Verulam
update africa_osm_nodes set name = 'Verulam', railway = 'station' where oid = 555066463;
-- Montclair
update africa_osm_nodes set name = 'Montclair', railway = 'station' where oid = 555062575;
-- Pelgrim
select rn_copy_node(array[555061644], array[555009972]);
-- Chatsglen
update africa_osm_nodes set name = 'Chatsglen', railway = 'station' where oid = 555067797;
-- Westcliff
update africa_osm_nodes set name = 'Westcliff', railway = 'station' where oid = 555067799;
-- Bayview
update africa_osm_nodes set name = 'Bayview', railway = 'station' where oid = 555067800;
-- Power Van Station
select rn_copy_node(array[555007776], array[555010423]);
-- Power
select rn_copy_node(array[555002066], array[555010424]);
-- Colesberg
select rn_copy_node(array[555001109], array[555013076]);
-- West Taffin
select rn_copy_node(array[555047188], array[555013186]);
-- Bergendal
select rn_copy_node(array[555034430], array[555013995]);
-- Alkmaar
select rn_copy_node(array[555047155], array[555014003]);
-- Penicuik
select rn_copy_node(array[555044113], array[555017204]);
-- Hillview
select rn_copy_node(array[555032961], array[555019313]);
-- Ottawa
select rn_copy_node(array[555061674], array[555020188]);
-- Uithoek
select rn_copy_node(array[555043869], array[555029525]);
-- Tayside
select rn_copy_node(array[555007731], array[555029534]);
-- Ngweni
select rn_copy_node(array[555008141], array[555029631]);
-- Mhlosinga
select rn_copy_node(array[555008143], array[555029634]);
-- Mlamlankunzi
select rn_copy_node(array[555000140], array[555032440]);
-- Shallcross
select rn_copy_node(array[555004552], array[555032866]);
-- Inchanga
select rn_copy_node(array[555004064], array[555045839]);
-- Keimoes
select rn_copy_node(array[555001176], array[555050801]);
-- Klawer
select rn_copy_node(array[555002006], array[555051831]);
-- Croesus
select rn_copy_node(array[555001329], array[555053572]);
-- Longdale
update africa_osm_nodes set name = 'Longdale', railway = 'station' where oid = 555062624;
-- Worcester
select rn_copy_node(array[555061696], array[555053864]);
-- Matjiesfontein
select rn_copy_node(array[555062040], array[555055280]);
-- Fonteine
select rn_copy_node(array[555061856], array[555056829]);
-- Hoogte
select rn_copy_node(array[555000496], array[555057802]);
-- Kempton Park
select rn_copy_node(array[555061846], array[555058743]);
-- Van Riebeeckpark
select rn_copy_node(array[555061845], array[555058793]);
-- Boksburg
select rn_copy_node(array[555061526], array[555059057]);
-- President
update africa_osm_nodes set name = 'President', railway = 'station' where oid = 555062324;
-- Boksburg East
update africa_osm_nodes set name = 'Boksburg East', railway = 'station' where oid = 555063245;
-- Ncwadi
select rn_copy_node(array[555008289], array[555067141]);
-- New Hanover
update africa_osm_nodes set name = 'New Hanover', railway = 'station' where oid = 555103414;
-- Lydenburg
select rn_copy_node(array[555048736], array[555067956]);
-- Scheepersnek
select rn_copy_node(array[555029465], array[555072866]);
-- Hugoslaagte
select rn_copy_node(array[555029554], array[555073115]);
-- Phomolong
select rn_copy_node(array[555001482], array[555081842]);
-- Crown
select rn_copy_node(array[555001331], array[555081907]);
-- Grosvenor
update africa_osm_nodes set name = 'Grosvenor', railway = 'station' where oid = 555062628;
-- Germiston West
update africa_osm_nodes set name = 'Germiston West', railway = 'station' where oid = 555062723;
-- Germiston South
select rn_copy_node(array[555001376], array[555082462]);
-- Jupiter
select rn_copy_node(array[555001403], array[555082624]);
-- Ravensklip
update africa_osm_nodes set name = 'Ravensklip', railway = 'station' where oid = 555062322;
-- Lowlands
select rn_copy_node(array[555003357], array[555085787]);
-- Harvard
select rn_copy_node(array[555058387], array[555086590]);
-- Villieria
update africa_osm_nodes set name = 'Villieria', railway = 'station' where oid = 555059485;
-- Loftus Versveldpark
update africa_osm_nodes set name = 'Loftus Versveldpark', railway = 'station' where oid = 555059645;
-- Mitchel Street
select rn_copy_node(array[555001463], array[555089525]);
-- Daspoort
select rn_copy_node(array[555061859], array[555089753]);
-- Cor Delfos
select rn_copy_node(array[555048566], array[555090294]);
-- eLubana
select rn_copy_node(array[555013320], array[555093724]);
-- Birchleigh
select rn_copy_node(array[555061844], array[555094834]);
-- Paarl
update africa_osm_nodes set name = 'Paarl', railway = 'station' where oid = 555126437;
-- Schuttestraat
select rn_copy_node(array[555009082], array[555096123]);
-- Orlando
update africa_osm_nodes set name = 'Orlando', railway = 'station' where oid = 555062320;
-- Beaconsfield
update africa_osm_nodes set name = 'Beaconsfield', railway = 'station' where oid = 555041422;
-- Tendeka
select rn_copy_node(array[555028349], array[555101383]);
-- Wesselsnek
select rn_copy_node(array[555003353], array[555101932]);
-- Pepworth
select rn_copy_node(array[555003352], array[555101970]);
-- Wasbank
select rn_copy_node(array[555013329], array[555102426]);
-- Dundee
select rn_copy_node(array[555007729], array[555102653]);
-- Malonjeni
select rn_copy_node(array[555007730], array[555102707]);
-- Bushlands
select rn_copy_node(array[555008139], array[555102881]);
-- Bayala
select rn_copy_node(array[555008142], array[555102917]);
-- iSangeyana
select rn_copy_node(array[555008128], array[555103078]);
-- eNgolothi
select rn_copy_node(array[555008127], array[555103173]);
-- iNtshamanzi
select rn_copy_node(array[555011883], array[555103198]);
-- Ulundi
select rn_copy_node(array[555006744], array[555103259]);
-- uLoliwe
select rn_copy_node(array[555013323], array[555103360]);
-- Ngogweni
select rn_copy_node(array[555006743], array[555103455]);
-- Bloubank
select rn_copy_node(array[555013304], array[555103476]);
-- Mahalumbe
select rn_copy_node(array[555044846], array[555103555]);
-- Paulpietersburg
select rn_copy_node(array[555007940], array[555104167]);
-- Kromkloof
select rn_copy_node(array[555001718], array[555104513]);
-- Kwaggastroom
select rn_copy_node(array[555061803], array[555104551]);
-- Waterval-Onder
select rn_copy_node(array[555034436], array[555105977]);
-- Boulders
select rn_copy_node(array[555047216], array[555106437]);
-- Balmoral
select rn_copy_node(array[555002310], array[555107079]);
-- Bosmanstraat
select rn_copy_node(array[555000062], array[555108320]);
-- Forfar
select rn_copy_node(array[555001362], array[555109322]);
-- Slabberts
select rn_copy_node(array[555000580], array[555109579]);
-- Firham
select rn_copy_node(array[555058388], array[555109750]);
-- Tutuka
update africa_osm_nodes set name = 'Tutuka', railway = 'station' where oid = 555049256;
-- Kaalfontein
select rn_copy_node(array[555061843], array[555110540]);
-- Medunsa
update africa_osm_nodes set name = 'Medunsa', railway = 'station' where oid = 555054602;
-- Koppie Alleen
select rn_copy_node(array[555058369], array[555111339]);
-- Hattingsspruit
select rn_copy_node(array[555003359], array[555111743]);
-- Matshaye
select rn_copy_node(array[555028049], array[555112342]);
-- Ireagh
select rn_copy_node(array[555028048], array[555112344]);
-- Delmas
select rn_copy_node(array[555061606], array[555113330]);
-- Natalspruit
select rn_copy_node(array[555051081], array[555113826]);
-- Rooikop
select rn_copy_node(array[555001478], array[555114024]);
-- Lenasia
select rn_copy_node(array[555061795], array[555114447]);
-- Centlivres
update africa_osm_nodes set name = 'Centlivres', railway = 'station' where oid = 555052717;
-- Sprucewell
select rn_copy_node(array[555003448], array[555116233]);
-- Kraal
select rn_copy_node(array[555001420], array[555116270]);
-- Viljoensdrif
select rn_copy_node(array[555061538], array[555117544]);
-- Limindlela
select rn_copy_node(array[555061841], array[555119465]);
-- Zonkizizwe
select rn_copy_node(array[555001530], array[555119631]);
-- Sportpark
select rn_copy_node(array[555001517], array[555119760]);
-- Olifantsfontein
select rn_copy_node(array[555061852], array[555119865]);
-- Georgedale
select rn_copy_node(array[555014604], array[555121027]);
-- Fouriesburg
select rn_copy_node(array[555000456], array[555121668]);
-- Mdantsane
select rn_copy_node(array[555061731], array[555122016]);
-- Florida
select rn_copy_node(array[555061760], array[555122230]);
-- Unified
select rn_copy_node(array[555061761], array[555122231]);
-- Hamberg
select rn_copy_node(array[555061759], array[555122237]);
-- Nancefield
select rn_copy_node(array[555061791], array[555122251]);
-- Beaufort West
update africa_osm_nodes set name = 'Beaufort West', railway = 'station' where oid = 555090026;
-- Kliptown
select rn_copy_node(array[555061792], array[555122485]);
-- Beechwick
select rn_copy_node(array[555013288], array[555127143]);
-- Bethal
select rn_copy_node(array[555028674], array[555127706]);
-- Hamelfontein
select rn_copy_node(array[555023771], array[555127775]);
-- Arbor
select rn_copy_node(array[555058683], array[555128056]);
-- Breyten (BTN)
select rn_copy_node(array[555007988], array[555128486]);
-- Magnesite
select rn_copy_node(array[555007200], array[555128550]);
-- Central
select rn_copy_node(array[555001315], array[555129080]);
-- Millsite
select rn_copy_node(array[555061750], array[555129081]);
-- Jordaan
select rn_copy_node(array[555000488], array[555129645]);
-- Kroonstad
select rn_copy_node(array[555061535], array[555129655]);
-- Rooiwal
select rn_copy_node(array[555000589], array[555129714]);
-- Koppies
update africa_osm_nodes set name = 'Koppies', railway = 'station' where oid = 555062775;
-- Heuningspruit
select rn_copy_node(array[555000500], array[555129788]);
-- Grasslands
select rn_copy_node(array[555001665], array[555130100]);
-- Allanridge
select rn_copy_node(array[555000400], array[555130239]);
-- Kalkvlakte
select rn_copy_node(array[555000516], array[555130345]);
-- Holfontein
select rn_copy_node(array[555000494], array[555130371]);
-- Geneva
select rn_copy_node(array[555000482], array[555130411]);
-- Wolwehoek
select rn_copy_node(array[555007603], array[555131502]);
-- Leeustroom
select rn_copy_node(array[555000522], array[555131678]);
-- Greenlands
select rn_copy_node(array[555000484], array[555131679]);
-- Dover
select rn_copy_node(array[555000442], array[555131681]);
-- Serfontein
select rn_copy_node(array[555000573], array[555131706]);
-- Virginia
select rn_copy_node(array[555000640], array[555131711]);
-- Hennenman
select rn_copy_node(array[555000498], array[555131757]);
-- Vetrivier
select rn_copy_node(array[555000608], array[555131827]);
-- Eensgevonden
select rn_copy_node(array[555000467], array[555131831]);
-- Theunissen
select rn_copy_node(array[555000612], array[555131892]);
-- Diamantoord
select rn_copy_node(array[555001131], array[555134103]);
-- Felixton
select rn_copy_node(array[555013306], array[5550948082]);
-- Glencoe
select rn_copy_node(array[555003358], array[5551025691]);
-- Hlobane
select rn_copy_node(array[555008900], array[5551028182]);
-- Piet Retief
select rn_copy_node(array[555008100], array[5551087381]);
-- Glenroy
select rn_copy_node(array[555001375], array[5551156741]);
-- Amerika
select rn_copy_node(array[555000411], array[5551297012]);
-- Tongaat
select rn_copy_node(array[555048424], array[555007206]);
-- Moses Mabhida
select rn_copy_node(array[555061647], array[555007923]);
-- Fairview
select rn_copy_node(array[555034432], array[555014047]);
-- Estcourt
select rn_copy_node(array[555034303], array[555085811]);
-- Quail
update africa_osm_nodes set name = 'Quail', railway = 'station' where oid = 555062787;
-- Komvoorhoogte
select rn_copy_node(array[555013328], array[555103478]);
-- Residensia
select rn_copy_node(array[555061801], array[555104550]);
-- Hoedspruit
select rn_copy_node(array[555001679], array[555108034]);
-- Woodstock
update africa_osm_nodes set name = 'Woodstock', railway = 'station' where oid = 555045343;
-- Mountain View
select rn_copy_node(array[555001901], array[555032318]);
-- Phefeni
select rn_copy_node(array[555001481], array[5550818421]);
-- eMakwazini
select rn_copy_node(array[555013321], array[555102995]);
-- Pretoria Gautrain
update africa_osm_nodes set name = 'Pretoria Gautrain', railway = 'station' where oid = 555047519;


-- Winklespruit
update africa_osm_nodes set name = 'Winklespruit', railway = 'station' where oid = 555065882;
--Isipingo
update africa_osm_nodes set name = 'Isipingo', railway = 'station' where oid = 555067672;
-- Ilfracombe
update africa_osm_nodes set name = 'Ilfracombe', railway = 'station' where oid = 555065887;
-- Clevenland
update africa_osm_nodes set name = 'Cleveland' where oid = 555032887;
-- Havenside
update africa_osm_nodes set name = 'Havenside', railway = 'station' where oid = 555062584;

-- Palmford
select rn_copy_node(array[555013289], array[5551271431]);
-- Georgina
select rn_copy_node(array[555061758], array[5551222371]);
-- Mtsotso
select rn_copy_node(array[555061730], array[5551220162]);
-- Eatonside
select rn_copy_node(array[555061802], array[5551045511]);
-- Mzimhlope
select rn_copy_node(array[555000144], array[5550818422]);
-- iNtshamanzi
select rn_copy_node(array[555011883], array[555103198]);
-- Elandsfontein
select rn_copy_node(array[555061848], array[555090672]);
-- Mayfair
select rn_copy_node(array[555000143], array[555082012]);

-- Platrand
select rn_copy_node(array[555058373], array[555127301]);
-- Dube
select rn_copy_node(array[555001349], array[555081840]);



update africa_osm_nodes set railway = null where oid = 555041612;

update africa_osm_nodes
set gauge = '610'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '610'))
and country in ('South Africa') and railway in ('station', 'halt', 'stop');

update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('South Africa') and railway in ('station', 'halt', 'stop');

update africa_osm_nodes
set gauge = '1435'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435'))
and country in ('South Africa') and railway in ('station', 'halt', 'stop');

-- remove duplicated stations/stops on network lines

with tmp as (
select name from africa_osm_nodes where country = 'South Africa' and gauge is not null and railway = 'station' order by name
)
update africa_osm_nodes 
set railway = null
where country = 'South Africa' and gauge is not null and railway = 'stop' and name in (select name from tmp);

-- identify oids of station/stop/halt nodes that need to be copied to network edge and the oid of the edge
with tmp as (
select * from africa_osm_nodes where
country = 'South Africa' and "railway" IN ('halt','stop','station') and gauge is null and "name" NOT IN (select name from africa_osm_nodes where country = 'South Africa' and gauge = '1067' and "railway" IN ('halt','stop','station') and name is not null order by name) order by name
), tmp2 as (
select distinct on (name) name, oid, geom from tmp 
), tmp3 as (
-- find nearest 
SELECT tmp2.name, tmp2.oid as node_oid, lines.oid as line_oid, st_distance(st_transform(tmp2.geom, 3857), st_transform(lines.geom, 3857))
FROM tmp2, africa_osm_edges lines
where lines.country = 'South Africa' and lines.line is not null and lines.gauge = '1067'
ORDER by tmp2.name),
-- by selecting distinct on name and ordering by st_distance we get the nearest edge oid
tmp4 as (
select distinct on (name) name, st_distance, node_oid, line_oid from tmp3 where st_distance < 25 order by name, st_distance asc),
-- some line oids are repeated and so the renumbering when split will fail for subsequent node copies. Therefore just get distinct. Then will repeat after.
tmp5 as (
select distinct on (line_oid) * from tmp4 order by line_oid
)
select * from tmp5

-- extract tables (backup)
create table southafrica_osm_edges as select * from africa_osm_edges where country in ('South Africa');
create table southafrica_osm_nodes as select * from africa_osm_nodes where country in ('South Africa');

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555031150,
		555038407,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			