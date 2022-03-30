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
set name = 'La Goulette',
railway = 'station',
gauge = 'dual',
facility = null
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

update africa_osm_nodes
set name = 'Tabeddit محطة تابديت',
railway = 'station'
where oid = 556062228;

update africa_osm_nodes
set name = 'Redeyef الرديف',
railway = 'station'
where oid = 555062230;

update africa_osm_nodes
set name = 'Metlaoui المتلوي',
railway = 'station'
where oid = 555089794;

update africa_osm_nodes
set name = 'Mokine Marchandises',
railway = 'station'
where oid = 555064505;

update africa_osm_nodes
set name = 'Sousse Sud سوسة الجنوبية',
railway = 'station'
where oid = 556054466;

update africa_osm_nodes
set name = 'Monastir المنستير',
railway = 'station'
where oid = 555022961;

update africa_osm_nodes
set name = 'Mahdia',
railway = 'station'
where oid = 555010695;

update africa_osm_nodes
set name = 'Ben Bachir بن بشير',
railway = 'station'
where oid = 555055347;

update africa_osm_nodes
set name = 'La Pecherie المصيدة',
railway = 'station'
where oid = 555063122;


update africa_osm_nodes
set name = ' Menzel Bourguiba محطة منزل بورقيبة',
railway = 'station'
where oid = 555058940;

update africa_osm_nodes
set name = 'Sajanan سجنان',
railway = 'station'
where oid = 555055337;

update africa_osm_nodes
set name = 'Tamera تمرة',
railway = 'station'
where oid = 555036585;

update africa_osm_nodes
set name = 'Bou Salem بوسالم',
railway = 'station'
where oid = 555055346;

update africa_osm_nodes
set name = 'Sidi Othman',
railway = 'station'
where oid = 555018246;

update africa_osm_nodes
set name = 'Chaouat شواط',
railway = 'station'
where oid = 555063121;

update africa_osm_nodes
set name = 'Jedeida',
railway = 'station'
where oid = 555013249;

update africa_osm_nodes
set name = 'Oued Meliz محطة وادي مليز',
railway = 'station'
where oid = 555062244;

update africa_osm_nodes
set name = 'Jendouba V محطة جندوبة',
railway = 'station'
where oid = 555062243;

update africa_osm_nodes
set name = 'Sidi Smail سيدي إسماعيل',
railway = 'station'
where oid = 555055345;

update africa_osm_nodes
set name = 'Beja Voy باجة',
railway = 'station'
where oid = 555055343;

update africa_osm_nodes
set name = 'Jalta جالطة',
railway = 'station'
where oid = 555036583;

update africa_osm_nodes
set name = 'Tinja تينجة',
railway = 'station'
where oid = 555060726;

update africa_osm_nodes
set name = 'Tebourba طبربة',
railway = 'station'
where oid = 555062159;

update africa_osm_nodes
set name = 'Le Bardo ',
railway = 'station'
where oid = 555018160;

update africa_osm_nodes
set name = 'Cité Erraoudha',
railway = 'station'
where oid = 555002547;

update africa_osm_nodes
set name = 'Megrine Ryad مقرين الرياض',
railway = 'station'
where oid = 555018118;

update africa_osm_nodes
set name = 'Megrine مقرين',
railway = 'station'
where oid = 555018114;

update africa_osm_nodes
set name = 'Megrine مقرين',
railway = 'station'
where oid = 555018117;

update africa_osm_nodes
set name = 'Sidi Rezig',
railway = 'station'
where oid = 555018113;

update africa_osm_nodes
set name = 'Sidi Rezig',
railway = 'station'
where oid = 555018110;

update africa_osm_nodes
set name = 'Lycee Technique Rades معهد رادس',
railway = 'station'
where oid = 555018103;

update africa_osm_nodes
set name = 'Radès رادس',
railway = 'station'
where oid = 555018106;

update africa_osm_nodes
set name = 'Radés Méliane رادس مليان',
railway = 'station'
where oid = 555012694;

update africa_osm_nodes
set name = 'Ez-Zahra الزهراء',
railway = 'station'
where oid = 555036549;

update africa_osm_nodes
set name = 'Ezzahra Lycée معهد الزهراء',
railway = 'station'
where oid = 555011694;

update africa_osm_nodes
set name = 'Bou Kornine بوقرنين',
railway = 'station'
where oid = 555011699;

update africa_osm_nodes
set name = 'Hammam Lif حمام الأنف',
railway = 'station'
where oid = 555011701;

update africa_osm_nodes
set name = 'Arret Du Stade الملعب',
railway = 'station'
where oid = 555018101;

update africa_osm_nodes
set name = 'Tahar Sfar الطاهر صفر',
railway = 'station'
where oid = 555011698;

update africa_osm_nodes
set name = 'Hammam Chat حمام الشط',
railway = 'station'
where oid = 555011714;

update africa_osm_nodes
set name = 'Bir El Bey بئر الباي',
railway = 'station'
where oid = 555012695;

update africa_osm_nodes
set name = 'Borj Cedria برج السدرية',
railway = 'station'
where oid = 555012692;

update africa_osm_nodes
set name = 'Erriadh الرياض',
railway = 'station'
where oid = 555036545;

update africa_osm_nodes
set name = 'Fondouk Jedid فندق الجديد',
railway = 'station'
where oid = 555016514;

update africa_osm_nodes
set name = 'Khanguet',
railway = 'station'
where oid = 555016512;

update africa_osm_nodes
set name = 'Grombalia قرمبالية',
railway = 'station'
where oid = 555054490;

update africa_osm_nodes
set name = 'Turki تركي',
railway = 'station'
where oid = 555036543;

update africa_osm_nodes
set name = 'Belli بلي',
railway = 'station'
where oid = 555016585;

update africa_osm_nodes
set name = 'Bou Arkoub بوعرقوب',
railway = 'station'
where oid = 555054492;

update africa_osm_nodes
set name = 'Hammamet الحمامات',
railway = 'station'
where oid = 555056571;

update africa_osm_nodes
set name = 'Omar Khayem عمر الخيام',
railway = 'station'
where oid = 555013443;

update africa_osm_nodes
set name = 'M''Razka المرازقة',
railway = 'station'
where oid = 555028106;

update africa_osm_nodes
set name = 'Sidi Mtir سيدي مطير',
railway = 'station'
where oid = 555036619;

update africa_osm_nodes
set name = 'Bouficha بوفيشة',
railway = 'station'
where oid = 555054494;

update africa_osm_nodes
set name = 'Ain Rahma عين الرحمة',
railway = 'station'
where oid = 555036618;

update africa_osm_nodes
set name = 'Parc Friguia منتزه فريقيا',
railway = 'station'
where oid = 555036620;

update africa_osm_nodes
set name = 'Enfida النفيضة',
railway = 'station'
where oid = 555054495;

update africa_osm_nodes
set name = 'Menzel Gare منزل المحطة',
railway = 'station'
where oid = 555054496;

update africa_osm_nodes
set name = 'Sidi Bou Ali سيدي بوعلي',
railway = 'station'
where oid = 555054477;

update africa_osm_nodes
set name = 'Kalaa Kebira القلعة الكبرى',
railway = 'station'
where oid = 555054476;

update africa_osm_nodes
set name = 'Sousse Marchandise سوسة بضائع',
railway = 'station'
where oid = 555036557;

update africa_osm_nodes
set name = 'M''seken Messadine المسعدين',
railway = 'station'
where oid = 555036559;

update africa_osm_nodes
set name = 'Sousse Voyageurs سوسة',
railway = 'station'
where oid = 555054467;

update africa_osm_nodes
set name = 'Sousse Bab Jdid سوسة باب الجديد',
railway = 'station'
where oid = 555007562;

update africa_osm_nodes
set name = 'Sousse Mohamed V سوسة محمد الخامس',
railway = 'station'
where oid = 555017958;

update africa_osm_nodes
set name = 'Sousse Zone Industrielle',
railway = 'station'
where oid = 555017961;

update africa_osm_nodes
set name = 'Sahline Ville الساحلين',
railway = 'station'
where oid = 555017960;

update africa_osm_nodes
set name = 'Sahline Sebkha الساحلين سبخة',
railway = 'station'
where oid = 555017959;

update africa_osm_nodes
set name = 'Les Hotels Monastirنزل المنستير',
railway = 'station'
where oid = 555017957;

update africa_osm_nodes
set name = 'Aeroport Skanes Monastir مطار المنستير',
railway = 'station'
where oid = 555017956;

update africa_osm_nodes
set name = 'La Faculte المنستير الكلية',
railway = 'station'
where oid = 555022965;

update africa_osm_nodes
set name = 'La Faculte 2 المنستير الكلية 2',
railway = 'station'
where oid = 555036578;

update africa_osm_nodes
set name = 'Monastir Zone Industrielle',
railway = 'station'
where oid = 555036622;

update africa_osm_nodes
set name = 'Frina الفرينة',
railway = 'station'
where oid = 555036575;

update africa_osm_nodes
set name = 'Khnis/Bembla خنيس - بنبلة',
railway = 'station'
where oid = 555036574;

update africa_osm_nodes
set name = 'Ksiba Bennane قصيبة المديوني - بنان',
railway = 'station'
where oid = 555017980;

update africa_osm_nodes
set name = 'Bouhjar بوحجر',
railway = 'station'
where oid = 555036573;

update africa_osm_nodes
set name = 'Lamta لمطة',
railway = 'station'
where oid = 555012784;

update africa_osm_nodes
set name = 'Sayeda صيادة',
railway = 'station'
where oid = 555012781;

update africa_osm_nodes
set name = 'Ksar Helal Zone Industrielle',
railway = 'station'
where oid = 555012779;

update africa_osm_nodes
set name = 'Ksar Helal قصر هلال',
railway = 'station'
where oid = 555012783;

update africa_osm_nodes
set name = 'Moknine Griba مكنين قريبع',
railway = 'station'
where oid = 555012782;

update africa_osm_nodes
set name = 'Moknine Voyageurs المكنين',
railway = 'station'
where oid = 555017972;

update africa_osm_nodes
set name = 'Teboulba Zone Industrielle',
railway = 'station'
where oid = 555012780;

update africa_osm_nodes
set name = 'Teboulba طبلبة',
railway = 'station'
where oid = 555036621;

update africa_osm_nodes
set name = 'Bekalta البقالطة',
railway = 'station'
where oid = 555036569;

update africa_osm_nodes
set name = 'Charaf الشرف',
railway = 'station'
where oid = 555036568;

update africa_osm_nodes
set name = 'Baghdedi بغدادي',
railway = 'station'
where oid = 555036567;

update africa_osm_nodes
set name = 'Sidi Masaoud سيدي مسعود',
railway = 'station'
where oid = 555036565;

update africa_osm_nodes
set name = 'Borj Arif برج عريف',
railway = 'station'
where oid = 555036564;

update africa_osm_nodes
set name = 'Mahdia Ezzahra الزهراء المهدية',
railway = 'station'
where oid = 555036563;

update africa_osm_nodes
set name = 'Sidi Bou Goubrine بوقبرين',
railway = 'station'
where oid = 555054498;

update africa_osm_nodes
set name = '',
railway = 'station'
where oid = ;






-- update where duplicate or unwanted station nodes
update africa_osm_nodes
set name = NULL,
railway = NULL,
gauge =  NULL,
facility = NULL
where oid in (555062158, 555018214, 555036589, 555062124, 558000003, 555022967, 555036566 )

-- updated if unnamed
update africa_osm_nodes
set name = 'unnamed halt',
railway = 'halt'
where oid in (555018215, 555055341, 555018213, 555002558)


-- ports
update africa_osm_nodes
set railway = 'stop',
name = 'Bizerte Port',
facility = 'port'
where oid = 555012953;

update africa_osm_nodes
set railway = 'stop',
name = 'Sousse Port',
facility = 'port'
where oid = 555126662;

update africa_osm_nodes
set railway = 'stop',
name = 'Sfax-Sidi Youssef Port',
facility = 'port'
where oid = 555017910;

update africa_osm_nodes
set railway = 'stop',
name = 'Port of Gabès',
facility = 'port'
where oid = 555085435;

update africa_osm_nodes
set railway = 'stop',
name = 'Port of Radès (container)',
facility = 'port'
where oid = 555064404;

update africa_osm_nodes
set railway = 'stop',
name = 'Port of Radès (specialized berths)',
facility = 'port'
where oid = 555017565;


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

update africa_osm_nodes
set railway = 'stop',
name = 'M''dhilla Phosphate Works',
facility = 'manufacturing'
where oid = 555017810;

update africa_osm_nodes
set railway = 'stop',
name = 'Redeyef Mine (Phosphate)',
facility = 'mine'
where oid = 555085780;

update africa_osm_nodes
set railway = 'stop',
name = 'Metlaoui Phosphate Washing Plant',
facility = 'manufacturing'
where oid = 555085679;

update africa_osm_nodes
set railway = 'stop',
name = 'Tunisian Sugar and Yeast Companies',
facility = 'manufacturing'
where oid = 555078177;

update africa_osm_nodes
set railway = 'stop',
name = 'Bizerte Cement',
facility = 'manufacturing'
where oid = 555012925;

update africa_osm_nodes
set railway = 'stop',
name = 'Enfidha Cement',
facility = 'manufacturing'
where oid = 555086349;

update africa_osm_nodes
set railway = 'stop',
name = 'Thyna Salt Works',
facility = 'mining'
where oid = 555017902;

update africa_osm_nodes
set railway = 'stop',
name = 'Tunisian Indian Fertilizers (TIFERT)',
facility = 'manufacturing'
where oid = 555017888;

update africa_osm_nodes
set railway = 'stop',
name = 'Tunisian Chemical Group',
facility = 'manufacturing'
where oid = 555015049;

update africa_osm_nodes
set railway = 'stop',
name = 'Gabès Cement Company',
facility = 'manufacturing'
where oid = 555017763;

update africa_osm_nodes
set railway = 'stop',
name = 'Umm al-Arais Phosphate Mine',
facility = 'mine'
where oid = 555082944;

update africa_osm_nodes
set railway = 'stop',
name = 'Jérissa Iron Ore Mine',
facility = 'mine'
where oid = 555118034;



-- industrial zones

update africa_osm_nodes
set railway = 'stop',
name = 'Sfax Zone Industrielle Poudrière 1',
facility = 'Industrial zone'
where oid = 555017951;

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

-- node for Erriadh station
-- not needed
-- insert into africa_osm_nodes (
-- oid, railway, name, country, gauge, facility, geom)
--  values (
--  557000003,
--  'station',
--  'Erriadh',
--  'Tunisia',
--  '',
--  '',
--  ST_SetSRID(ST_Point(10.42152,36.69828), 4326)
--  )
-- ;



SELECT ST_SetSRID( ST_Point(8.00607,35.66806), 4326)

-- create new station (or other) nodes
-- this is required as there can be several edges running through stations but the station node
-- is located on an edge that isn't used for the route.
-- copy La Goulette 555042215 to 555025933
-- copy Le Kef 555062252 to 555043283
-- copy Bir Bourekba 555054493 to 555042264
-- copy Jilma 555060776 to 555084260
-- copy Kalaa Sghira 555054474 to 555045726
-- connect from Line 12 north of M'Saken
-- copy 555064498 to 555041978
-- copy Mdhila 555060747 to 555041413
-- node for Aguila 557000002 to 555041428
-- copy for Tabeddit 555062228 to 5550415802
-- copy for Erriadh 557000003 to 555063054
-- copy for Sousse Sud 555054466 to 555054792
-- copy Ben Bachir 555055347 to 555029019
-- routing from Ghannouch to cement work copy 555085460 to 555034358
-- copy Oued Meliz 555062244 to 555029005
-- copy Jendouba V 555062243 to 555042741
-- copy Sidi Smail 555055345 to 555028994
-- copy 555055344 to 555029000
-- copy Beja Voy 555055343 to 555028951
-- copy Beja Marchandises 555036582 to 55502895122
-- copy Jalta 555036583 to 555028132
-- copy Tinja 555060726 to 555028057
-- copy Tebourba 555062159 to 555066801
-- copy Ez-Zahra 555036549 to 555026405
-- copy Grombalia 555054490 to 555053037
-- copy Turki 555036543 to 555053034
-- copy Bou Arkoub 555054492 to 555092059
-- copy Bouficha 555054494 to 555042227
-- copy Enfida 555054495 to 555042187
-- copy Menzel 555054496 to 555042204
-- copy Sidi Bou Ali 555054477 to 555042138
-- copy M'seken Messadine 555036559 to 555042094
-- copy Sousse Voyageurs 555054467 to 555091840
-- copy Sousse Zone Industrielle 555017961 to 555042064
-- copy Les Hotels Monastir 555017957 to 555042052
-- copy Aeroport Skanes Monastir 555017956 to 555042054
-- copy Monastir Zone Industrielle 555036622 to 555042070
-- copy Khnis/Bembla 555036574 to 555041972
-- copy Sayeda 555012781 to 555119544
-- copy Ksar Helal Zone Industrielle 555012779 to 555119549
-- copy Moknine Griba 555012782 to 555119554
-- copy Moknine Voyageurs 555017972 to 555119556
-- copy Bekalta 555036569 to 555023969

DO $$ DECLARE
-- create new station nodes
-- note: must not be a node coincident with the closest point (reassign that node as a station instead)
-- nodes INT8 ARRAY DEFAULT ARRAY [557000001, 555042215, 555062252, 555054493, 555060776, 555054474, 555064498, 555060747, 557000002, 557000003, 555054466, 555055347, 555085460, 555062244, 555062243, 555055345, 555055344, 555055343, 555036582, 555036583, 555060726, 555062159, 555036549, 555054490, 555036543, 555054492, 555054494, 555054495, 555054496, 555054477, 555036559, 555054467, 555017961, 555017957, 555017956, 555036622, 555036574, 555012781, 555012779, 555012782, 555017972, 555036569];
-- edges INT8 ARRAY DEFAULT ARRAY [555084267, 555025933, 555043283, 555042264, 555084260, 555045726, 555041978, 555041413, 555041428, 555063054, 555054792, 555029019, 555034358, 555029005, 555042741, 555028994, 555029000, 555028951, 5550289512, 555028132, 555028057, 555066801, 555026405, 555053037, 555053034, 555092059, 555042227, 555042187, 555042204, 555042138, 555042094, 555091840, 555042064, 555042052, 555042054, 555042070, 555041972, 555119544, 555119549, 555119554, 555119556, 555023969];
nodes INT8 ARRAY DEFAULT ARRAY [555036569];
edges INT8 ARRAY DEFAULT ARRAY [555023969];
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
-- split 5550280571 at 555086848
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
-- routing into/out of Tabeditt
-- split 555049721 at 555085743
-- split 5550415801 at 555085744
-- split 555041591 at 555091579
-- split 555047399 at 555085805
-- split 5550473991 at 555085792
-- routing into Metlaoui from phosphate washing plant
-- split 555041459 at 555085697
-- routing from Borj Cedria to Erriadh
-- split 555026353 at 555086382
-- routing in/out Monastir
-- split 555055468 at 555095691
-- routing from Gafsa to Aouinet line
-- split 555084239 at 555085641
-- split 555041422 at 555085505
-- split 555041312 at 555085496
-- split 555037254 at 555085497
-- routing into Aouinet from Gafsa
-- split 555034474 at 555118020
-- routing to Bizerte port
-- split 555028737 at 555077998
-- routing to Sousse Port
-- split 555096415 at 555126661
-- routing into Sfx-Sidi port
-- split 555041828 at 555086060
-- split 555034365 at 555085974
-- routing to Port of Gabes
-- split 555041266 at 555085427
-- split 555041263 at 555085487
-- routing to Port of Rabes container terminal
-- split 555042391 at 555064403
-- routing to Beja food manufacturers
-- split 555029008 at 555078178
-- split 555028951 at 555078198
-- routing to Bizerte Cement
-- split 555028768 at 555078008
-- routing to Enfidha Cement
-- split 555042142 at 555086266
-- routing to Sfax Zone Industrielle Poudrière 1
-- split 555041833 at 555085986
-- split 555041821 at 555085990
-- routing to Thyna salt works
-- split 555084238 at 555085940
-- split 555054930 at  555085939
-- split 5550842382 at 555085960
-- TIFERT (Tunisian Indian Fertilizers) access
-- split 555041757 at 555085891
-- routing from Ghannouch to Gabes cement
-- split 555041293 at 555085425
-- routing to M'dhilla Phosphate Works
-- split 5550414131 at 555085510
-- routing to  Umm al-Arais Phosphate mine
-- split 555037273 at 555082943
-- routing to Jérissa Iron Ore Mine
-- split 555044843 at 555087300

DO $$ DECLARE
-- edges INT8 ARRAY DEFAULT ARRAY [555028119, 555028096, 555028115, 555029315, 5550280571, 555042812, 555026320, 5550263201, 555029421, 555026313, 555026240, 555026286, 555027102, 555023279, 555066827, 555026878, 5550268781, 555041533, 555034496, 555037260, 5550414281, 555041412, 555049721, 5550415801, 555041591,  555047399, 5550473991, 555041459, 555026353, 555055468, 555084239, 555041422, 555041312, 555037254, 555034474, 555028737, 555096415, 555041828, 555034365, 555041266, 555041263, 555042391, 555029008, 555028951, 555028768, 555042142, 555041833, 555041821, 555084238, 555054930, 5550842382, 555041757, 555041293, 5550414131, 555037273, 555044843];
-- nodes INT8 ARRAY DEFAULT ARRAY [555077658, 555086819,  555086818, 555083372, 555086848, 555086854, 555076508, 555117781, 555085113, 555076466, 555076507, 555076439, 555074617, 555074616, 555076525, 555002536, 555064390, 555087464, 555081180, 555085552, 555085551, 555085509, 555085743, 555085744, 555091579, 555085805, 555085792, 555085697, 555086382, 555095691, 555085641, 555085505, 555085496, 555085497, 555118020, 555077998, 555126661, 555086060, 555085974, 555085427, 555085487, 555064403, 555078178, 555078198, 555078008, 555086266, 555085986, 555085990, 555085940, 555085939, 555085960, 555085891, 555085425, 555085510, 555082943, 555087300];
edges INT8 ARRAY DEFAULT ARRAY [555044843];
nodes INT8 ARRAY DEFAULT ARRAY [555087300];
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

-- Bizerte Port
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555077997,
		555012953,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bizerte Port',
gauge = '1435',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
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

-- Port of Gabès

-- link 555014969 to 555085427
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555014969 and b.oid = 555085427
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555014969,
555085427,
556000035
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'open'
where oid = 556000035;


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555014969,
		555085435,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Gabès',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);


-- Borj Cedria - Erriadh
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555076567,
		555036545,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Borj Cedria - Erriadh',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Sfax-Sidi Youssef Port
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555085974,
		555017910,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sfax-Sidi Youssef Port',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);


-- Line 20: Jebal Jelloud - La Goulette
-- insert link for dual gauge to La Goulette
-- link 555085113 to 556042215
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
gauge = 'dual'
where oid = 556000024;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555076508,
		556042215,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 20: Jebal Jelloud - La Goulette',
gauge = 'dual',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Port of Rodes (specialized berths)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             556042215,
		555085116,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Radès (specialized berths)',
gauge = 'dual',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
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
set line = 'Line 20: Jebal Jelloud - La Goulette (metre <-> dual gauge)',
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


-- Port of Rades (speciliazed berths)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555085113,
		556042215,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Radès',
gauge = 'dual',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Port of Rades (container terminal)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555064403,
		555064404,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Port of Radès (container terminal)',
gauge = 'dual',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
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


-- Line 7 Bir Kassa - La Goulette

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555064390,
		556042215,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 7: Bir Kassa - La Goulette',
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
where oid = 556000026;

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
where oid = 556000027;

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
where oid = 556000028;

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

-- Sousse Port
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555126661,
		555126662,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sousse Port',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
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
where oid = 556000029;

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

-- M'dhilla to M'dhilla Phosphate Works (freight)
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555085510,
		555017810,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = ' M''dhilla to M''dhilla Phosphate Works',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);


-- Kasserine to Tabeddit
-- Freight only. See: https://commons.wikimedia.org/wiki/File:Reseau_cft_tunisie.svg
-- Also confirmed no passenger services in the SNCFT online timetable for this part of Line  15

-- simplify routing from Kasserine onto Line 15 (Metlaoui)
-- link 555055078 to 555016261
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555055078 and b.oid = 555016261
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555055078,
555016261,
556000030
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'open'
where oid = 556000030;


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555055078,
		556062228,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 15: Kasserine - Tabeditt',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Line 16: Tabediit - Redayef
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555085744,
		555062230,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 16: Tabediit - Redayef',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Redeyef Mine
-- missing link between 555085801 and 555085781
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555085801 and b.oid = 555085781
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555085801,
555085781,
556000031
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'open'
where oid = 556000031;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555062230,
		555085780,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Redayef - Redayef Mine',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Line 15: Tabeditt - Metlaoui
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            556062228,
		555071169,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 15: Tabeditt - Metlaoui',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Metlaoui Phosphate Washing Plant
-- link 555017833 to 555071169
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555017833 and b.oid = 555071169
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555017833,
555071169,
556000032
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'open'
where oid = 556000032

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555071169,
		555085679,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Metlaoui Phosphate Washing Plant',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);


-- Line 18: M'Saken - Moknine
-- appears to be disused (certainly for passenger services)
-- unclear whether used for freight at all
-- link for routing from 555064497 to 555002662
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555064497 and b.oid = 555002662
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555064497,
555002662,
556000033
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'disused'
where oid = 556000033;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555064497,
		555064505,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 18: M''Saken - Moknine',
gauge = '1000',
status = 'disused',
comment = 'Could be used for freight?',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Line 22: Sousse - Mahdia

-- Link to route from Sousse Sud to Mahdia line
-- link 555070155 to 555029728
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555070155 and b.oid = 555029728
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555070155,
555029728,
556000034
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'open'
where oid = 556000034;

-- to Monastir
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555070155,
		555022961,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 22: Sousse - Monastir (Sahel Metro)',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- to Mahdia
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555095691,
		555010695,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 22: Monastir - Mahdia (Sahel Metro)',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'mixed'
where oid in (select edge from tmp);

-- Line 21: Gafsa - El Aouinet
-- appears to be freight only
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555085641,
		555118020,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Line 21: Gafsa - El Aouinet',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);


-- Beja Tunisian Sugar Company, Tunisian Yeast Company
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555078198,
		555078177,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Beja - Food Manufacturers',
gauge = '1435',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Ginor (Ben Bachir) - Sugar Manufacture And Refining
-- link 555086757 to 556055347
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555086757 and b.oid = 556055347
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555086757,
556055347,
556000036
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1435',
status = 'open'
where oid = 556000036;


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            556055347,
		555086758,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ginor (Sugar Manufacture/Refining)',
gauge = '1435',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Bizerte Cement
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555078008,
		555012925,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Bizerte Cement',
gauge = '1435',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Enfidha Cement
-- link 555013268 to 555086266
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 555013268 and b.oid = 555086266
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
555013268,
555086266,
556000037
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'open'
where oid = 556000037;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555086266,
		555086349,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Enfidha Cement',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Sfax Zone Industrielle Poudrière 1
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555085985,
		555017951,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sfax Zone Industrielle Poudrière 1',
gauge = '1000',
status = 'open',
comment = 'Appears to serve a specific facility but name and function unknown.',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Thyna salt works
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
          555085939 ,
		555017902,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Thyna salt works',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Tunisian Chemical Group and TIFERT
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
          555081131 ,
		555015049,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tunisian Chemical Group and TIFERT',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
          555085891 ,
		555017888,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Tunisian Chemical Group and TIFERT',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Gabès Cement Company
-- link 556085460 to 555085425
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = 556085460 and b.oid = 555085425
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
556085460,
555085425,
556000038
from tmp as a;

update africa_osm_edges set
type = 'conventional',
gauge = '1000',
status = 'open'
where oid = 556000038;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           556085460,
		555017763,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Gabès Cement Company',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Umm al-Arais Phosphate Mine
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555082943,
		555082944,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Umm al-Arais Phosphate Mine',
gauge = '1000',
status = 'open',
comment = '',
type = 'conventional',
mode = 'freight'
where oid in (select edge from tmp);

-- Jérissa Iron Ore Mine
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
           555087300,
		555118034,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Jérissa Iron Ore Mine',
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

update africa_osm_nodes
set gauge = '1000'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1000'))
and railway in ('station', 'halt', 'stop');

update africa_osm_nodes
set gauge = 'dual'
where (st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1000'))
and st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435')))
or
st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = 'dual'))
and railway in ('station', 'halt', 'stop');

-- extract tables for tunisia (backup)
create table tunisia_osm_edges as select * from africa_osm_edges where country like '%Tunisia%';
create table tunisia_osm_nodes as select * from africa_osm_nodes where country like '%Tunisia%';

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555017802,
		555064404,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			




























