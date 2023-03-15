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



-- Klipplaat - Port Elizabeth (Gqeberha)
-- Transnet branch line


  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555000832,
		,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Klipplaat - Port Elizabeth',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Transnet branch line'
where oid in (select edge from tmp);


select distinct facility from africa_osm_nodes
update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('South Africa') and railway in ('station', 'halt', 'stop');



-- extract tables (backup)
create table southafrica_osm_edges as select * from africa_osm_edges where country in ('South Africa');
create table southafrica_osm_nodes as select * from africa_osm_nodes where country in ('South Africa');

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555031137,
		555102738,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			