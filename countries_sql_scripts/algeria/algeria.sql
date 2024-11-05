-- Morocco

select railway, count(*) from africa_osm_nodes where country like '%Algeria%' group by railway order by count desc;
select railway, count(*) from africa_osm_nodes where name is not null and country like '%Algeria%' group by railway order by count desc;

select status, count(*) from africa_osm_edges where country like '%Algeria%' group by status order by count desc;
select type, count(*) from africa_osm_edges where country like '%Algeria%' group by type order by count desc;
select line, status, count(*) from africa_osm_edges where country like '%Algeria%' and line is not null group by line, status order by count desc;
select structure, count(*) from africa_osm_edges where country like '%Algeria%' group by structure order by count desc;
select gauge, count(*) from africa_osm_edges where country like '%Algeria%' group by gauge order by gauge desc;


-- features
-- tunnel
update africa_osm_edges
set structure = 'tunnel'
where oid = 555052375;

-- incorrect nodes
-- nodes in Sidi Bel Abbes tram stops on heavy rail line.
-- Institut des Sciences Medicales and Boulevard Amarna
update africa_osm_nodes
set railway = null,
name = null
where oid in (555029711, 555029704);

-- set additional node for stations or update details

update africa_osm_nodes
set name = 'Centrale d''Oran محطة القطار وهران',
railway = 'station'
where oid = 555070202;

update africa_osm_nodes
set name = 'Centrale d''Oran محطة القطار وهران',
railway = 'station'
where oid = 555070202;

update africa_osm_nodes
set name = 'Arzew أرزيو',
railway = 'station'
where oid = 555037475;

update africa_osm_nodes
set name = 'Oued Tlelat وادي تليلات',
railway = 'station'
where oid = 555028940;

update africa_osm_nodes
set name = 'Mohammedia المحمدية',
railway = 'station'
where oid = 555026121;

update africa_osm_nodes
set name = 'El Khroub الخروب',
railway = 'station'
where oid = 555028467;

update africa_osm_nodes
set name = 'Touggourt تقرت',
railway = 'station'
where oid = 555028885;

update africa_osm_nodes
set name = 'El Guerrah (El Gourzi) القراح',
railway = 'station'
where oid = 555029101;

update africa_osm_nodes
set name = 'Souk Ahras سوق أهراس',
railway = 'station'
where oid = 555020338;

update africa_osm_nodes
set name = 'Tebessa تبسة',
railway = 'station'
where oid = 555020163;

update africa_osm_nodes
set name = 'Bordj Bou Arreridj',
railway = 'station'
where oid = 555062267;

update africa_osm_nodes
set name = 'Ghazaouet الغزوات',
railway = 'station'
where oid = 555026797;

update africa_osm_nodes
set name = 'Mostaganem مستغانم',
railway = 'station'
where oid = 555035026;

update africa_osm_nodes
set name = 'Béjaïa بجاية',
railway = 'station'
where oid = 555016805;

update africa_osm_nodes
set name = 'Skikda سكيكدة',
railway = 'station',
facility = 'port'
where oid = 555021776;

update africa_osm_nodes
set name = 'Sidi el Hemissi سيدي الهميسي',
railway = 'station'
where oid = 555020341;

update africa_osm_nodes
set name = 'Beni Saf',
railway = 'station'
where oid = 555129940;

update africa_osm_nodes
set name = 'Algiers International Airport محطة المطار هواري بومدين',
railway = 'station',
facility = 'airport'
where oid = 555062957;

update africa_osm_nodes
set name = 'Mecheria المشرية',
railway = 'station'
where oid = 555021213;

update africa_osm_nodes
set name = 'Relizane غليزان',
railway = 'station'
where oid = 555019766;

update africa_osm_nodes
set name = 'Baba Ali بابا علي',
railway = 'station'
where oid = 555003037;

update africa_osm_nodes
set name = 'Hussein Dey حسين داي',
railway = 'station'
where oid = 555062469;

update africa_osm_nodes
set name = 'Bab Ezzouar',
railway = 'station'
where oid = 555062365;

update africa_osm_nodes
set name = 'Hamma Bouziane',
railway = 'station'
where oid = 555033610;

update africa_osm_nodes
set name = 'Constantine قسنطينة',
railway = 'station'
where oid = 555027612;

update africa_osm_nodes
set name = 'Sidi Mabrouk سيدي مبروك',
railway = 'station'
where oid = 555008156;

update africa_osm_nodes
set name = 'Béchar بشار',
railway = 'station'
where oid = 555024272;

update africa_osm_nodes
set name = 'Beni Ounif بني ونيف',
railway = 'station'
where oid = 555026335;

update africa_osm_nodes
set name = 'Aïn Séfra عين الصفراء',
railway = 'station'
where oid = 555021207;

update africa_osm_nodes
set name = 'Naâma النعامة',
railway = 'station'
where oid = 555026334;

update africa_osm_nodes
set name = 'Saïda سعيدة',
railway = 'station'
where oid = 555033671;

update africa_osm_nodes
set name = 'Youb يوب',
railway = 'station'
where oid = 555023299;

update africa_osm_nodes
set name = 'Telagh تلاغ',
railway = 'station'
where oid = 555023298;

update africa_osm_nodes
set name = 'Souani السواني',
railway = 'station'
where oid = 555025526;

update africa_osm_nodes
set name = 'Maghnia مغنية',
railway = 'station'
where oid = 555029523;

update africa_osm_nodes
set name = 'Tralimet محطة تراليمات',
railway = 'station'
where oid = 555063022;

update africa_osm_nodes
set name = 'Zalboun زلبون',
railway = 'station'
where oid = 555021058;

update africa_osm_nodes
set name = 'Ain Tallout عين تالوت',
railway = 'station'
where oid = 555038982;

update africa_osm_nodes
set name = 'El Amria العامرية',
railway = 'station'
where oid = 555014951;

update africa_osm_nodes
set name = 'Boutlelis بوتليليس',
railway = 'station'
where oid = 555028930;

update africa_osm_nodes
set name = 'Sidi Maârouf سيدي معروف',
railway = 'station'
where oid = 555011588;

update africa_osm_nodes
set name = 'Hassi Bounif حاسي بونيف',
railway = 'station'
where oid = 555011590;

update africa_osm_nodes
set name = 'Hassi Ameur حاسي عامر',
railway = 'station'
where oid = 555003344;

update africa_osm_nodes
set name = 'Djidiouia جديوية',
railway = 'station'
where oid = 555026147;

update africa_osm_nodes
set name = 'Oued Rhiou وادي ارهيو',
railway = 'station'
where oid = 555025225;

update africa_osm_nodes
set name = 'Bir Safsaf بئر صفصاف',
railway = 'station'
where oid = 555025223;

update africa_osm_nodes
set name = 'Boufarik بوفاريك',
railway = 'station'
where oid = 555003120;

update africa_osm_nodes
set name = 'Tizi Ouzou',
railway = 'station'
where oid = 555018888;

update africa_osm_nodes
set name = 'Oued Aïssi Universite وادي عيسي - الجامعة',
railway = 'station'
where oid = 555034539;

update africa_osm_nodes
set name = 'Ighzer Amokrane إغزار أمقران',
railway = 'station'
where oid = 555030545;

update africa_osm_nodes
set name = 'Sétif سطيف',
railway = 'station'
where oid = 555008160;

update africa_osm_nodes
set name = 'Aïn Kechra عين قشرة',
railway = 'station'
where oid = 555021769;

update africa_osm_nodes
set name = 'Oued Hamimine وادي حميم',
railway = 'station'
where oid = 555016572;

update africa_osm_nodes
set name = 'Ouled Rahmoune أولاد رحمون',
railway = 'station'
where oid = 555029102;

update africa_osm_nodes
set name = 'Aïn Beïda عين البيضاء',
railway = 'station'
where oid = 555021395;

update africa_osm_nodes
set name = 'Chebaita Mokhtar شبايطة مختار',
railway = 'station'
where oid = 555021788;

update africa_osm_nodes
set name = 'Dréan الذرعان',
railway = 'station'
where oid = 555026254;

update africa_osm_nodes
set name = 'Chihani شيحاني',
railway = 'station'
where oid = 555021786;

update africa_osm_nodes
set name = 'Boukhamouza بوخموزة',
railway = 'station'
where oid = 555021782;

update africa_osm_nodes
set name = 'Oued Fragha وادي فراغة',
railway = 'station'
where oid = 555021784;

update africa_osm_nodes
set name = 'Boucheghouf بوشغوف',
railway = 'station'
where oid = 555021793;

update africa_osm_nodes
set name = 'Ain Affra',
railway = 'station'
where oid = 555021792;

update africa_osm_nodes
set name = 'Seggana سقانة',
railway = 'station'
where oid = 555036766;

update africa_osm_nodes
set name = 'Magra مقرة',
railway = 'station'
where oid = 555029190;

update africa_osm_nodes
set name = 'Berhoum برهوم',
railway = 'station'
where oid = 555028862;

update africa_osm_nodes
set name = 'Medjez',
railway = 'station'
where oid = 555016097;

update africa_osm_nodes
set name = 'Biskra بسكرة',
railway = 'station'
where oid = 555021418;

update africa_osm_nodes
set name = 'El M''Ghair المغير',
railway = 'station'
where oid = 555021813;

update africa_osm_nodes
set name = 'Djamaa جمعة',
railway = 'station'
where oid = 555021817;



-- update where duplicate station nodes
update africa_osm_nodes
set name = NULL,
railway = NULL,
gauge =  NULL,
facility = NULL
where oid in (555034048, 555062891, 555041734, 555019270, 555062409, 555032309, 555062440, 555062661 )


-- set names where missing
update africa_osm_nodes
set name = '',
railway = 'station'
where oid = ;

-- facilities

-- ports
update africa_osm_nodes
set railway = 'stop',
name = 'Annaba Port',
facility = 'port'
where oid = 555117847;

update africa_osm_nodes
set railway = 'stop',
name = 'Djendjen Port',
facility = 'port'
where oid = 555108067;

update africa_osm_nodes
set railway = 'stop',
name = 'Ghazaouet Port',
facility = 'port'
where oid = 555021070;

update africa_osm_nodes
set name = 'Oran Maritime (port) وهران البحرية',
railway = 'stop',
facility = 'port'
where oid = 555028159;

update africa_osm_nodes
set name = 'Mostaganem Port',
railway = 'stop',
facility = 'port'
where oid = 555107477;

update africa_osm_nodes
set name = 'Alger Port',
railway = 'stop',
facility = 'port'
where oid = 555070773;

update africa_osm_nodes
set name = 'Béjaïa Port',
railway = 'stop',
facility = 'port'
where oid = 555102264;

-- mines / industrial etc

update africa_osm_nodes
set railway = 'stop',
name = 'Djebel Onk (Phosphate Mine)',
facility = 'mine'
where oid = 555090465;

update africa_osm_nodes
set railway = 'stop',
name = 'Boukhadra (iron mine)',
facility = 'mine'
where oid = 555093712;

update africa_osm_nodes
set railway = 'stop',
name = 'El Ouenza (iron mine)',
facility = 'mine'
where oid = 555029032;

update africa_osm_nodes
set railway = 'stop',
name = 'El Hadjar Complex (steel plant)',
facility = 'manufacturing'
where oid = 555088535;

update africa_osm_nodes
set railway = 'stop',
name = 'Bellara Steel Complex',
facility = 'manufacturing'
where oid = 555105784;

update africa_osm_nodes
set railway = 'stop',
name = 'Naftal El Khroub Oil Depot',
facility = 'manufacturing'
where oid = 555091024;

-- industrial zones

update africa_osm_nodes
set railway = 'stop',
name = 'Sidi Bel Abbès Industrial Zone',
facility = 'Industrial zone'
where oid = 555083556;

update africa_osm_nodes
set railway = 'stop',
name = 'To Rouïba-Reghaïa Industrial Zone',
facility = 'Industrial zone'
where oid = 555063874;

-- create new nodes for stations that don't currently have a node or a suitable alternative
-- these then need to be located on the correct edge using the procedure below

insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 557000000,
 'station',
 'Morsott',
 'Algeria',
 '',
 '',
 ST_SetSRID(ST_Point(8.00607,35.66806), 4326)
 )
;

SELECT ST_SetSRID( ST_Point(8.00607,35.66806), 4326)

-- create new station (or other) nodes
-- this is required as there can be several edges running through stations but the station node
-- is located on an edge that isn't used for the route.
-- create node on edge 555065285 for branch to Arzew
-- copy 555014903 onto edge 555065285
-- Arzew
-- Oued Tlelat
-- Bechar
-- Tabia
-- Mohammedia
-- Mostaganem
-- Birtouta
-- El Harrach
-- Thenia
-- El Khroub
-- Ramdane Djamel
-- Oued Kebrit (555021867 to 555091271)
-- El Hadjar (555016666 to 555084061)
-- Line from steel work join line ta Oued Ziad (555088536 to 555014814)
-- Line to Jijel, did to link into line from Ramdane Djamel (555098824 to 555064374)
-- Line to Djendjen Port (555108105 copy to 555053980)
-- Ghazaouet (555026797 to 555046830)
-- Line to Alger/Algiers Port (555099998 to 555056971)
-- Mecheria (555021213 to 555050725)
-- El Biodh (555032299 to 555050726)
-- Relizane (555019766 to 555084298)
-- Chlef (555024661 to 555061309)
-- Chiffa (555006824 to 555090848)
-- Blida (555026156 to 555090851)
-- Beni Mered (555024340 to 555090840)
-- Baba Ali (555003037 to 555088075)
-- Aïn Naâdja (555003039 to 555084955)
-- Gué de Constantine (555003040 to 5550849552)
-- Agha (555002474 to 555002346)
-- Oued Semmar (555002234 to 555001332)
-- Dar El Beida (555002233 to 555051628)
-- ZI Rouiba (555028900 to 555066899)
-- Rouiba SNVI (555028861 to 5550668991)
-- Beni Mensour (555033823 to 555070262)
-- Hamma Bouziane (555033610 to 555039894)
-- Constantine (555027612 to 555039891)
-- Medjez Sfa (555021800 to 555076976)
-- Morsott (557000000 to 555036783)

DO $$ DECLARE
-- create new station nodes
-- note: must not be a node coincident with the closest point (reassign that node as a station instead)
-- nodes INT8 ARRAY DEFAULT ARRAY [555014903, 555037475, 555028940, 555024272, 555021009, 555026121, 555035026, 555003119, 555003041, 555002212, 555028467, 555021773, 555021867, 555016666, 555088536, 555098824, 555108105, 555026797, 555099998, 555021213, 555032299, 555019766, 555024661, 555006824, 555026156, 555024340, 555003037, 555003039, 555003040, 555002474, 555002234, 555002233, 555028900, 555028861, 555033823, 555033610, 555027612, 555021800, 557000000];
-- edges INT8 ARRAY DEFAULT ARRAY [555065285, 555068139, 555096463, 555059088, 555050232, 555063511, 555041694, 555088093, 555003535, 555001189, 555102241, 555019956, 555091271, 555084061, 555014814, 555064374, 555053980, 555046830, 555056971, 555050725, 555050726, 555084298, 555061309, 555090848, 555090851, 555090840, 555088075, 555084955, 5550849552, 555002346, 555001332, 555051628, 555066899, 5550668991, 555070262, 555039894, 555039891, 555076976, 555036783];
nodes INT8 ARRAY DEFAULT ARRAY [557000000];
edges INT8 ARRAY DEFAULT ARRAY [555036783];
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

-- route out of Algiers
-- split 555002336 @ 555064349
-- split 5550569711 @ 555118638
-- route from Oed Tlelat on to Bechar line
-- split 555091243 @ 555108536
-- routing after Tabia
-- split 555067840 at 555092037
-- routing from Marsat el Hadadj onto line for Mohammedia 
-- split 555041687 @ 555085864
-- Mostaganem branch to port
-- split 555041695 @ 555120491
-- routing El Harrach to Thenia line
-- split 555045807 @ 555107551
-- routing into Bordj Bou Arreridj
-- split 555044939 @ 555100870
-- route into/out of Setif
-- split 555084113 @ 555072739
-- split 555084114 @ 555117895
-- routing between El Gourzi and Ramdane Djamel
-- split 555049025 @ 555091596
-- problems north of Bekira
-- split 555084092 @ 555117861
-- routing north out of Constantine
-- split 555084099 @ 555126832
-- route into Aïn Touta
-- split 555045849 @ 555107823
-- split 555084284 @ 555107822
-- split 5550842841 @ 555107021
-- route from Aïn M'lila to El Aouinet line
-- split 555072335 @ 555107766
-- split 555072341 @ 555107765
-- route from Oued Kebrit to iron mines
-- split 555052524 at 555093708
-- split 555052528 at 555093713
-- station at Sidi Aammar
-- split 555028288 @ 555012683
-- route to Annaba Port
-- split 555014823 at 555136396
-- line to Jijel from Ramdane Djamel
-- split 555060184 @ 555093513
-- Djendjen Port
-- split 555072716 @ 555108141
-- split 555072757 @ 555108140
-- Bellara steel plant
-- split 555052896 @ 555105788
-- split 555069897 @ 555105787
-- Alger Port
-- split 555061782 @ 555070774
-- Bejaia Port
-- split 555046249 @ 555102265
-- Enable routing from Souk Ahras to Sidi el Hemissi line
-- split 555063184 at 555107048
-- Routing from Sidi el Hemissi to Tunisian border
-- split 555083966 @ 555090643
-- routing into Beni Saf 
-- split 555047865 @ 555090334
-- to To Rouïba-Reghaïa Industrial Zone
-- split 555090862 @ 555063873
-- Thenia to Oued Aissi
-- split 555071283 at 555149190

DO $$ DECLARE
-- edges INT8 ARRAY DEFAULT ARRAY [555002336, 5550569711, 555091243, 555067840, 555041687, 555041695, 555045807, 555044939, 555049025, 555084092, 555084099, 555084113, 555084114, 555045849, 555084284, 5550842841, 555072335, 555072341, 555052524, 555052528, 555028288, 555014823, 555060184, 555072716, 555072757, 555052896, 555069897, 555061782, 555046249, 555063184, 555083966, 555047865, 555090862, 555071283];
 -- nodes INT8 ARRAY DEFAULT ARRAY [555064349, 555118638, 555108536, 555092037, 555085864, 555120491, 555107551, 555100870, 555091596, 555117861, 555126832, 555072739, 555117895, 555107823, 555107822, 555107021, 555107766, 555107765, 555093708, 555093713, 555012683, 555136396, 555093513, 555108141, 555108140, 555105788, 555105787, 555070774, 555102265, 555107048, 555090643, 555090334, 555063873, 555149190];
edges INT8 ARRAY DEFAULT ARRAY [555071283];
nodes INT8 ARRAY DEFAULT ARRAY [555149190];
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

-- Alger/Algiers to El Harrach

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555003515,
		555064876,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Alger/Algiers to El Harrach',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);


-- Alger/Algiers Port
-- Need to edit edge 555061780 and amend the first coordinate (source) to be 556099998
-- routing to Alger Port

UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, 0, (select geom from africa_osm_nodes where oid = 556099998)),
	source = 556099998
	WHERE oid = 555061780;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                556099998,
		555070773,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Alger/Algiers Port',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight'
where oid in (select edge from tmp);



-- El Harrach to Oran
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555064876,
		555070202,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'El Harrach to Oran',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed'
where oid in (select edge from tmp);

-- add link between 555070203 and 555078101 
-- simplify routing to Oran port
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555070203 and b.oid = 555078101
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555070203,
555078101,
556000007
from tmp as a;

-- Oran to Oran Maritime (port)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555070203,
		555028159,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oran to Oran Maritime (port)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);

-- Oran to Arzew branch

-- Need to edit edge 555071266 and amend the first coordinate (source) to be
-- node 556014903 rather than 555014903 to simplify routing to Oran.

UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, 0, (select geom from africa_osm_nodes where oid = 556014903)),
	source = 556014903
	WHERE oid = 555071266;
	
-- Oran to Arzew
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                556014903,
		556037475,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oran to Arzew',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Es Sénia (Oran) to Béni Saf
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555003255,
		555129940,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Es Sénia (Oran) to Béni Saf',
gauge = '1435',
status = 'open',
comment = 'single track',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);



-- Oued Tlelat to Béchar
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                556028940,
		556024272,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oued Tlelat to Béchar',
gauge = '1435',
status = 'open',
comment = 'Not electrified.',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Moulay Slissen to Saïda
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555080824,
		555033671,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Moulay Slissen to Saïda',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- add link between 555092074 and 556021009
-- simplify routing from Tabia to Akid Abbess line
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555092074 and b.oid = 556021009
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555092074,
556021009,
556000008
from tmp as a;

-- Tabia to Akid Abbes (Zouj Beghal)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                556021009,
		555025504,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tabia to Akid Abbes (Zouj Beghal)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Akid Abbes (Zouj Beghal) to Ghazaouet
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                555025504,
		556026797,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Akid Abbes (Zouj Beghal) to Ghazaouet',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Ghazaouet to Ghazaouet Port
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
                556026797,
		555021070,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ghazaouet to Ghazaouet Port',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);

-- add link between 555017876 and 556026121
-- simplify routing from Marsat el Hadjadj into Mohammedia station
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555017876 and b.oid = 556026121
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555017876,
556026121,
556000009
from tmp as a;

-- Marsat el Hadjadj to Mohammedia
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555062820,
		556026121,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Marsat el Hadjadj to Mohammedia',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Mostaganem line
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555085864,
		556035026,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mostaganem branch',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Mostaganem port
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555120491,
		555107477,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mostaganem port',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);

-- Birtouta to Zéralda
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               556003119,
		555033399,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Birtouta to Zéralda',
gauge = '1435',
status = 'open',
comment = 'Opened 2016. Electrified. Double-track.',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- add link between 
-- simplify routing from El Harrach to Thénia line
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555064876 and b.oid = 555107551
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555064876,
555107551,
556000010
from tmp as a;

-- El Harrach to Thénia
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555064876,
		556002212,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'El Harrach to Thénia',
gauge = '1435',
status = 'open',
comment = 'Double track; electrified',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Thénia to Bordj Bou Arreridj
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               556002212,
		555062267,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Thénia to Bordj Bou Arreridj',
gauge = '1435',
status = 'open',
comment = 'Single track.',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Bordj Bou Arreridj to El Guerrah (El Gourzi)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555062267,
		555029101,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bordj Bou Arreridj to El Guerrah (El Gourzi)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- El Guerrah (El Gourzi) to El Khroub
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555029101,
		556028467,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'El Guerrah (El Gourzi) to El Khroub',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);


-- add link to sort out data problems north of Bekira
-- link 555084695 to 555117869
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555084695 and b.oid = 555117869
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555084695,
555117869,
556000011
from tmp as a;

-- remove last 4 coordinates from edge 555084087
DO $$ DECLARE
BEGIN
		FOR i IN 1..4
		LOOP
		UPDATE africa_osm_edges 
		SET geom = ST_RemovePoint ( geom, ST_NPoints ( geom ) - 1 ) 
	WHERE
		oid = 555084087 ;
	END loop;

END $$;

-- change last coordinate of 555084087 to coordinate of node 555090757
UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, ST_NPoints ( geom ) - 1, (select geom from africa_osm_nodes where oid = 555090757)),
	target = 555090757
	WHERE oid = 555084087;

-- El Khroub to Ramdane Djamel
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              556028467,
		555021773,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'El Khroub to Ramdane Djamel',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Change first coordinate of 5550199562 to node 555021773
-- simplify routing out of Ramdane Djamel to Skikda
UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, 0, (select geom from africa_osm_nodes where oid = 555021773)),
	source = 555021773
	WHERE oid = 5550199562;

-- Ramdane Djamel to Skikda
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555021773,
		555021776,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ramdane Djamel to Skikda',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Beni Mansour to Béjaia
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555087512,
	555016805,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beni Mansour to Béjaia',
gauge = '1435',
status = 'open',
comment = 'Single track',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Béjaia Port
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555102265 ,
	555102264,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Béjaia Port',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);

-- Link 555088467 to 555100865
-- simplify routing out of Bordj Bou Arreridj to M'Sila

with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555088467 and b.oid = 555100865
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555088467,
555100865,
556000012
from tmp as a;


-- Bordj Bou Arreridj to M'Sila
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555088467,
	555016099,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bordj Bou Arreridj to M''Sila',
gauge = '1435',
status = 'open',
comment = 'Single track.',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- M'Sila to Aïn Touta
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555082724,
	555029015,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'M''Sila to Aïn Touta',
gauge = '1435',
status = 'open',
comment = 'Single track.',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Aïn Touta to Touggourt
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555029015,
	555028885,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Aïn Touta to Touggourt',
gauge = '1435',
status = 'open',
comment = 'Single track.',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- link El Guerrah / Gourzi to Ain Touta line
-- simplify routing add link between 555029101 and 555107730
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555029101 and b.oid = 555107720
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555029101,
555107720,
556000013
from tmp as a;

-- El Guerrah / El Gourzi to Aïn Touta
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555029101,
	555029015,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'El Guerrah / El Gourzi to Aïn Touta',
gauge = '1435',
status = 'open',
comment = 'Single track.',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Aïn M'lila to El Aouinet (Souk Ahras to Tebessa line)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555107766,
	555082668,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Aïn M''lila to El Aouinet (joins Souk Ahras to Tebessa line)',
gauge = '1435',
status = 'open',
comment = 'Single track. Opened 2009',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Souk Ahras to Tebessa
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555020338,
	555020163,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Souk Ahras to Tebessa',
gauge = '1435',
status = 'open',
comment = 'Single track. Electrified',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Tebessa to Djebel Onk (Phosphate Mine)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555020163,
	555090465,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tebessa to Djebel Onk (Phosphate Mine)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);

-- simplify routing Oued Kebrut to Iron mines
-- link 555093708 to 556021867
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555093708 and b.oid = 556021867
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555093708,
556021867,
556000014
from tmp as a;


-- Oued Kebrit to El Ouenza and Boukhadra Iron mines
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           556021867,
	555029032,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oued Kebrit to El Ouenza and Boukhadra Iron mines',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555093713,
	555093712,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Oued Kebrit to El Ouenza and Boukhadra Iron mines',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);

-- Annaba to Souk Ahras
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555027117,
	555020338,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Annaba to Souk Ahras',
gauge = '1435',
status = 'open',
comment = 'Electrified. Single track',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Annaba to Sidi Aammar (surburban)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555027117,
	555012683,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Annaba to Sidi Aammar (surburban)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- freight serves steel works (El Hadjar Complex)
-- link line up at Oued Ziad (seems ok from Google Earth)
-- 555088536 to 556088536
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555088536 and b.oid = 556088536
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555088536,
556088536,
556000015
from tmp as a;

-- simplify lines at steel complex
-- 555088538 to 555088535
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555088538 and b.oid =  555088535
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555088538,
555088535,
556000016
from tmp as a;

-- El Hadjar to Oued Ziad
-- need to exclude edge 5550840611 to precent routing via El Hadjar north
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid != 5550840611',
           555077747,
	556088536,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'El Hadjar to Oued Ziad',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);


-- Ramdane Djamel to Annaba
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555021773,
	555070098,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ramdane Djamel to Annaba',
gauge = '1435',
status = 'open',
comment = 'Single track',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- simplify link to Annaba port
-- link 555117801  to 555136395
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555117801 and b.oid =  555136395
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555117801,
555136395,
556000017
from tmp as a;

-- Annaba Port
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555117801,
	555117847,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Annaba Port',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);

-- Ramdane Djamel to Jijel
-- link 555093513 to 556098824
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555093513 and b.oid = 556098824
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555093513,
556098824,
556000018
from tmp as a;

-- Ramdane Djamel to Jijel
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           556098824,
	555028009,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ramdane Djamel to Jijel',
gauge = '1435',
status = 'open',
comment = 'Double-track',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Djendjen Port
-- change last node / target of 555072748 to node 556108105
UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, ST_NumPoints(geom) - 1, (select geom from africa_osm_nodes where oid = 556108105)),
	target = 556108105
	WHERE oid = 555072748;

-- Djendjen Port
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           556108105,
	555108067,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Djendjen Port',
gauge = '1435',
status = 'open',
comment = '',
mode = 'Freight',
type = 'conventional'
where oid in (select edge from tmp);

-- Bellara steel complex
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555105788,
	555105784,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bellara steel complex',
gauge = '1435',
status = 'open',
comment = '',
mode = 'Freight',
type = 'conventional'
where oid in (select edge from tmp);

-- Souk Ahras to Sidi el Hemissi
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555107048,
	555020341,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Souk Ahras to Sidi el Hemissi',
gauge = '1435',
status = 'open',
comment = '',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

-- Sidi el Hemissi to Ghardimaou (Tunisian border)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555020341,
	555078163,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sidi el Hemissi to Ghardimaou (Tunisian border)',
gauge = '1435',
status = 'open',
comment = 'Freight only, border not open to passenger traffic',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);

--  Sidi Lahssen to Sidi Bel Abbès Industrial Zone
-- link 555083557 to 555016699
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555083557 and b.oid =  555016699
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555083557,
555016699,
556000019
from tmp as a;

--  Sidi Lahssen to Sidi Bel Abbès Industrial Zone
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
          555016699,
	555083556,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sidi Lahssen to Sidi Bel Abbès Industrial Zone',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);

-- Bab Ezzouar to Algiers International Airport
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
          555092991,
	555062957,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bab Ezzouar to Algiers International Airport',
gauge = '1435',
status = 'open',
comment = '',
mode = 'passenger',
type = 'conventional'
where oid in (select edge from tmp);

-- Access too Rouïba-Reghaïa Industrial Zone
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
          555063873,
	555063874,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Rouïba-Reghaïa Industrial Zone (access)',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
where oid in (select edge from tmp);

-- Thénia to Oued Aïssi
-- need to prevent routing via old disused line - remove oid 555086658
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid != 555086658',
          555063786,
	555021475,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Thénia to Oued Aïssi',
gauge = '1435',
status = 'open',
comment = 'Electrified',
mode = 'mixed',
type = 'conventional'
where oid in (select edge from tmp);

SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
          555063786,
	555021475,
		false
		) AS X
		ORDER BY seq
		
-- Naftal El Khroub Oil Depot
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
          555091050,
	555091024,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Naftal El Khroub Oil Depot',
gauge = '1435',
status = 'open',
comment = '',
mode = 'freight',
type = 'conventional'
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
 where country = 'Algeria';
 
 UPDATE africa_osm_nodes
SET    name = (
   SELECT array_to_string(ARRAY(SELECT regexp_matches(name, '[^\u0600-\u06FF]+', 'g')), ' ')
   )
 where country = 'Algeria';

-- extract tables for algeria (backup)
create table algeria_osm_edges as select * from africa_osm_edges where country like '%Algeria%';
create table algeria_osm_nodes as select * from africa_osm_nodes where country like '%Algeria%';
