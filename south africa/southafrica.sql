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

select distinct facility from africa_osm_nodes
update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('South Africa') and railway in ('station', 'halt', 'stop');


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
set railway = 'staion' where oid = 555002388;

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
comment = 'Durban Metrorail (Chatsworth/Southern Coast/kwaMashu-Umlazi/Bluff lines). Also Transnet core network.'
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
comment = 'Durban Metrorail (Southern Coast/kwaMashu-Umlazi/Bluff lines). Also Transnet core network.'
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
set line = 'Reunion - Umlazi (kwaMashu - Umlazi / Bluff Lines)',
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
comment = 'Durban Metrorail (New Main/Old Main/Chatsworth/Southern Coast/kwaMashu-Umlazi/Bluff lines). Also Transnet core network.'
where oid in (select edge from tmp);

-- Durban - Umgeni
-- Northern Coast / kwaMashu-Umlazi Lines
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
comment = 'Durban Metrorail (kwaMashu-Umlazi/Northern Coast lines). Also Transnet core network.'
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
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Durban Metrorail (Northern Coast line).'
where oid in (select edge from tmp);

-- stations
-- Kamfersdam
select rn_copy_node(array[555003293], array[555117744]);
-- Veertien Strome
update africa_osm_nodes
set name = 'Veertien Strome',
railway = 'station'
where oid = 555071362;

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
			