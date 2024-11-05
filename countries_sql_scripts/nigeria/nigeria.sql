-- Nigeria

select railway, count(*) from africa_osm_nodes where country like '%Nigeria%' group by railway order by count desc;
select railway, count(*) from africa_osm_nodes where name is not null and country like '%Nigeria%' group by railway order by count desc;

select status, count(*) from africa_osm_edges where country like '%Nigeria%' group by status order by count desc;
select type, count(*) from africa_osm_edges where country like '%Nigeria%' group by type order by count desc;
select line, status, count(*) from africa_osm_edges where country like '%Nigeria%' and line is not null group by line, status order by count desc;
select structure, count(*) from africa_osm_edges where country like '%Nigeria%' group by structure order by count desc;
select gauge, count(*) from africa_osm_edges where country like '%Nigeria%' group by gauge order by gauge desc;

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

-- update line information
-- Lagos (Mobolaji Johnson Station) - Ibadan SGR

update africa_osm_nodes
set name = 'Lagos (Mobolaji Johnson)',
railway = 'station'
where oid = 555059579;


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555059579,
		555063158,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Lagos - Ibadan (LITS)',
gauge = '1435',
status = 'open',
comment = 'Opened 10 June 2021. Double track'
where oid in (select edge from tmp);

-- Apapa Port (Freight)
-- need to sort out issues with OSM data provided to indicate
-- separate standard and cape gauge tracks to Apapa.

INSERT INTO africa_osm_edges (oid, country, source, target, status, type, mode, geom) VALUES (
556000060, 'Nigeria',NULL , NULL, 'open', 'conventional', 'freight',
'0102000020E610000023000000147D837128030B400515FF98B2FA19401245F8944B030B40247D7F466BFA1940060859B268030B404D35FC010EFA1940E1B669B76D030B4056078BC2A8F9194082054FAF65030B40D7F3766D65F91940BE9D05994F030B404F4E8C2212F919402CC44A6017030B402156625CB7F81940A85FBAE69E020B400B002BAB3BF819406360698039020B40020F9558F4F71940F4E0197F3A010B40575E553464F7194073B414E29E000B40ABE83CEB0DF719406BB87C18D7FF0A40F35393339CF61940591443B978FF0A40AF31905468F61940F1C49C65E6FE0A402DCC69C816F619402B994662E5FD0A40A73D722289F5194049CD1E36BEFB0A40ADD9CF6752F41940F13210AD38FA0A40862AD3F178F3194003E9418513F90A40B9F51E5CD1F219405CB7045E72F60A40795AD38C55F119409961B3C0D8F40A40D04B9E206CF01940BF2F9DE703F30A40FFADA74567EF19402F8E6D8BA8F20A40D7D982E534EF1940FF0BCC7EA7ED0A401C77F0AE60EC1940EAA385325EEC0A409730D45D4BEB19401DF0155587E90A403020E9345FE8194073D80F6A9EE80A40E5A1A6C27DE71940BAB6E172A9E70A4003CE62785CE619401F550D609BE50A40ECC89DDA27E419403AD45F2B67E50A4029C2A102E8E31940B404CDFE3AE50A4072D6E3309EE319409BF07CE622E50A40F91BA36150E319403E3F62DE1AE50A408EA25DA1EAE21940ED976FE21EE50A409E3C98C5B0E219402DCA371F5BE50A405524BA3EEFE11940BD6B677BB6E50A40027D3C70D3E01940');

select rn_change_source(556000060, 555151722);
select rn_copy_node(array[555148289], array[556000060]);
select rn_change_target(556000060, 556148289);
select rn_change_source(555125507, 556148289);

select rn_split_edge(array[555093367], array[555148289]);
select rn_split_edge(array[5550933672], array[555148290]);
delete from africa_osm_edges where oid = 55509336721;


INSERT INTO africa_osm_edges (oid, country, source, target, status, type, mode, geom) VALUES (
556000061, 'Nigeria',NULL , NULL, 'open', 'conventional', 'freight',
'0102000020E61000001400000024CD170AC5E50A406721114FD5E019408213305F19E60A400C9C66F2CFDF1940E65E5CBA73E60A40986C048BDBDE1940D8E931FBB3E60A40A48D6225E4DD194051AF9C1BD4E60A40BEDD334DA4DD1940BBFFDC7C34E70A402973C3A614DD1940BF1CF4A356E90A40FB58170FD2DA1940BB70EAD787EA0A40BBB8C5C1B2D91940D14333D784EB0A40F0F45F1231D91940CE022CBE69EC0A4069EC4F55C5D81940CD97290BB6EC0A4011DDF77C85D8194029DE41600AED0A4074524DC70DD81940BB4CFAE58EED0A40BC5D806908D71940EF0998630BEE0A40AE3812F428D61940EC3393FDA3EE0A40168D6E8839D51940604DF451F5EF0A4016F6C366D2D319400B65FA3CDEF00A4092AEC8FFDAD219403BE190A13FF20A40B61917E567D11940017EF4FF93F60A40C5322A31AECD19404245BA891CF70A40A358507D32CD1940');

select rn_change_source(556000061, 555148289);
select rn_copy_node(array[555124093], array[556000061]);

update africa_osm_nodes
set name = 'Apapa Port',
railway = 'stop',
facility = 'port',
gauge = 1435
where oid = 555124093;

update africa_osm_nodes
set name = 'Apapa Port',
railway = 'stop',
facility = 'port',
gauge = 1067
where oid = 556124093;

-- standard gauge to Apapa Port
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555059579,
		555124093,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Apapa Port (LITS)',
gauge = '1435',
status = 'open',
mode = 'freight',
comment = 'There may in future be passenger services as it appears that a station is under construction.'
where oid in (select edge from tmp);

-- cape gauge to Apapa Port

select rn_split_edge(array[555130489], array[555078714]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
               555078714,
		556124093,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Apapa Port (Cape gauge)',
gauge = '1067',
status = 'open',
mode = 'freight',
comment = 'This older cape gauge link to Apapa Port Would appear to be open for freight services. E.g., see: https://www.apmterminals.com/en/apapa/about/rail'
where oid in (select edge from tmp);

-- Cape Gauge Western Line
-- Lagos to Nguru

update africa_osm_nodes
set name = 'Lagos Terminus',
railway = 'station',
gauge = '1067'
where oid = 555009645;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555009645,
		555017251,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Western Line (Lagos - Nguru)',
gauge = '1067',
status = 'open',
mode = 'mixed',
comment = 'Line is thought to be open and serviceable with some freight activity from Apapa port (but only to terminals for transfer to lorries at Ebute Metta and Ijoko). Currently (11/08/2022) passenger services are suspended due to terrorist activity.'
where oid in (select edge from tmp);

-- Cape Gauge Western branch; Minna to Baro

-- enable routing onto branch
select rn_split_edge(array[555063377], array[555116975]);

-- no recorded stations on this route
-- add stop at Baro Port

-- insert node to enable link to be inserted
insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000010,
 'stop',
 'Baro Port',
 'Nigeria',
 '',
 '',
 ST_SetSRID(ST_Point(6.41851,8.61206), 4326)
 )
;

select rn_copy_node(array[558000010], array[555097769]);

update africa_osm_nodes
set gauge = '1067',
facility = 'port'
where oid = 559000010;

-- Cape Gauge Western Line
-- Lagos to Nguru
with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555116975,
		555039481,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Minna - Baro',
gauge = '1067',
status = 'rehabilitation',
mode = 'mixed',
comment = 'Rehabilitation contract said to have been awarded with extension to Baro Port. See: https://constructionreviewonline.com/news/minna-baro-railway-in-nigeria-to-undergo-us-192m-rehabilitation-project/'
where oid in (select edge from tmp);


-- Lagos Rail Mass Transit (LRMT) Blue Line

-- Phase 1 to Mile 2

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555041951,
		555041946,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Lagos Rail Mass Transit (LRMT) Blue Line',
gauge = '1435',
status = 'construction',
mode = 'passenger',
comment = 'Phase 1 - Marina <-> Mile 2 largely complete and expected to start operating in Q1 2023.'
where oid in (select edge from tmp);


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555041946,
		555129002,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Lagos Rail Mass Transit (LRMT) Blue Line',
gauge = '1435',
status = 'construction',
mode = 'passenger',
comment = 'Later phase, 2022 satellite imagery suggests little progress yet beyond Mile 2. Eventually planned to terminate at Okokomaiko'
where oid in (select edge from tmp);

-- Abuja Rail Mass Transit (ARMT)

-- Yellow Line - Abuja <-> Nnamdi Azikiwe International Airport  via Idu

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
              555040980,
		555040990,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Abuja Rail Mass Transit (ARMT) Yellow Line',
gauge = '1435',
status = 'open',
mode = 'passenger',
comment = 'Abuja CBD <-> Nnamdi Azikiwe International Airport'
where oid in (select edge from tmp);

update africa_osm_nodes
set facility = 'airport'
where oid = 555040990;

-- Blue Line - Idu to Gbazango 

-- add link to simplify interchange at Idu
select rn_insert_edge(555040988, 555062874, 556000060);

-- remove station from 555062874
update africa_osm_nodes
set railway = null,
name = null
where oid = 555062874;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555040988,
		555041001,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Abuja Rail Mass Transit (ARMT) Blue Line',
gauge = '1435',
status = 'open',
mode = 'passenger',
comment = 'Idu <-> Gbazango'
where oid in (select edge from tmp);


-- Abuja (Idu) – Kaduna Rigasa (AKTS)
-- standard gauge, opened 26 July 2016
-- Currently suspended (https://nrc.gov.ng/2022/05/19/press-release-19th-may-2022/). This was due to an attack on a train with explosives on 28 March 2022 damaging track. Max speed 100km/h according to https://en.wikipedia.org/wiki/Rail_transport_in_Nigeria.

-- add link to simplify interchange at Idu
select rn_insert_edge(555040988, 555039069, 556000061);

-- remove station from 555062874
update africa_osm_nodes
set railway = null,
name = null
where oid = 555039069;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555040988,
		555062804,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Abuja (Idu) – Kaduna Rigasa (AKTS)',
gauge = '1435',
status = 'open',
mode = 'mixed',
comment = 'Services currently suspended due to attack with explosives in March 2022. (https://nrc.gov.ng/2022/05/19/press-release-19th-may-2022/). Max speed 100km/h according to https://en.wikipedia.org/wiki/Rail_transport_in_Nigeria.'
where oid in (select edge from tmp);

-- Warri – Itakpe (WITS) Originally planned to supply the Ajaokuta Steel Mill with iron ore from Itakpe and coal imported via Warri. One service daily each way.

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555041593,
		555041588,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Warri – Itakpe (WITS)',
gauge = '1435',
status = 'open',
mode = 'mixed',
comment = 'One service daily each way. Originally planned to supply the Ajaokuta Steel Mill with iron ore from Itakpe and coal imported via Warri.'
where oid in (select edge from tmp);

-- remove duplicate station 
update africa_osm_nodes
set railway = null,
name = null
where oid = 555041591;

-- Ajaokuta Steel Mill

update africa_osm_nodes
set facility = 'manufacturing',
railway = 'stop',
name = 'Ajaokuta Steel Mill'
where oid = 555082787;


with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555082784,
		555082787,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ajaokuta Steel Mill',
gauge = '1435',
status = 'open',
mode = 'freight',
comment = 'The steel plant is out of use (and may never have produced steel). See: https://www.premiumtimesng.com/news/more-news/526405-fg-approves-n853-million-for-ajaokuta-steel-concession-consultants.html'
where oid in (select edge from tmp);

-- Itakpe Iron Ore mine
update africa_osm_nodes
set facility = 'mine',
railway = 'stop',
name = 'Itakpe Mine (Iron ore)'
where oid = 555129384;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555041588,
		555129384,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Itakpe Iron Ore mine',
gauge = '1435',
status = 'open',
mode = 'freight',
comment = ''
where oid in (select edge from tmp);

-- Warri steel plant - Premium Steel and Mines Limited
update africa_osm_nodes
set facility = 'manufacturing',
railway = 'stop',
name = 'Premium Steel and Mines Limited'
where oid = 555069981;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555041593,
		555069981,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Steel manufacturing plant',
gauge = '1435',
status = 'open',
mode = 'freight',
comment = 'Premium Steel and Mines Limited'
where oid in (select edge from tmp);

-- Cape Gauge (1067) Eastern Line – Port Harcourt to Maiduguri 
-- split 555065348 at 555085088 for route into Maiduguri
select rn_split_edge(array[555065348], array[555085088]);
-- route North from Kuru
select rn_split_edge(array[555036713], array[555082898]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555016568,
		555016479,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Eastern Line – Port Harcourt <-> Maiduguri ',
gauge = '1067',
status = 'rehabilitation',
mode = 'mixed',
comment = 'see: https://bit.ly/3wGag6V and https://bit.ly/3Q1STnV. Section from Port Harcourt to Enugu to be completed first, potentially by September 2022. Throughout there may be changes to the original route and new branches. Line to remain 1067mm gauge.'
where oid in (select edge from tmp);

-- Eastern Line - Kaduna <-> Kafanchan 
-- Also thought to be part of the rehabilitation.
-- at some point gauge interchange - see: https://www.youtube.com/watch?v=V2psUk_VSc4&ab_channel=NedMedia

-- allow routing into Kaduna from Kafanchan 
select rn_split_edge(array[555035110, 555014199], array[555081401, 555081416]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
            555090725 ,
		555081416,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Linking Line – Kafanchan <-> Kaduna',
gauge = '1067',
status = 'rehabilitation',
mode = 'mixed',
comment = 'Thought to be part of the Port Harcourt to Maiduguri rehabilitation project, eventually with potential interchange with standard guage at Rigachikun'
where oid in (select edge from tmp);

-- Kuru to Jos branch
-- assumed to be rehabilitation as part of Port Harcourt to Maiduguri  project
update africa_osm_nodes
set railway = 'station',
name = 'Jos'
where oid = 555095378;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555082898,
		555095378,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kuru <-> Jos',
gauge = '1067',
status = 'rehabilitation',
mode = 'mixed',
comment = 'Thought to be part of the Port Harcourt to Maiduguri rehabilitation project'
where oid in (select edge from tmp);

-- Ashaka cement plant

update africa_osm_nodes
set railway = 'stop',
facility = 'manufacturing',
name = 'Ashaka cement plant'
where oid = 555113186;

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555085092,
		555113186,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Ashaka cement plant',
gauge = '1067',
status = 'rehabilitation',
mode = 'freight',
comment = 'Status unclear. May come back into use once the Port Harcourt to Maiduguri line is rehabilitated'
where oid in (select edge from tmp);

-- Branch of Western Line - Zaria to Kaura Namoda 
-- current status unclear. Thought to be out of use and potentially subject to rehabilitation?

-- route out of Zaria
select rn_split_edge(array[555070822], array[555107360]);

with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555107360,
		555031374,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Zaria <-> Kaura Namoda ',
gauge = '1067',
status = 'unknown',
mode = 'mixed',
comment = 'Status unclear. Was apparenty rehabilitated 2014/15 but is probably out of use currently'
where oid in (select edge from tmp);


-- sort out station/stop/halt nodes
-- Kajola
update africa_osm_nodes
set railway = 'station',
gauge = '1435'
where oid = 555061238;

-- Abeokuta
update africa_osm_nodes
set name = 'Abeokuta'
where oid = 555020031;

-- Adio
update africa_osm_nodes
set name = 'Adio'
where oid = 555020036;

-- Ilorin
update africa_osm_nodes
set name = 'Ilorin'
where oid = 555019552;

-- Minna
update africa_osm_nodes
set name = 'Minna'
where oid = 555020028;

-- Kuchi
update africa_osm_nodes
set name = 'Kuchi'
where oid = 555020005;

-- Jaji
update africa_osm_nodes
set name = 'Jaji'
where oid = 555042717;

-- Omi-Adio
update africa_osm_nodes
set railway = 'station',
gauge = '1067'
where oid = 555055453;

-- Wupa
update africa_osm_nodes
set railway = 'station',
gauge = '1435'
where oid = 555027348;

-- Kaduna North
update africa_osm_nodes
set name = 'Kaduna North',
railway = 'station',
gauge = '1435'
where oid = 555113665;

-- Aba
select rn_copy_node(array[555063049], array[555066583]);

-- unknown
update africa_osm_nodes
set name = 'unknown'
where oid in (555020030, 555020359, 555020358, 555020008, 555020006, 555020410, 555024274, 555031376, 555016478, 555016476, 555016475, 555031406, 555031412, 555019857, 555019681);

update africa_osm_nodes
set gauge = '1435'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1435'))
and country ='Nigeria' and railway in ('station', 'halt', 'stop');

update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country ='Nigeria' and railway in ('station', 'halt', 'stop');


-- extract tables for Egypt (backup)
create table nigeria_osm_edges as select * from africa_osm_edges where country = 'Nigeria';
create table nigeria_osm_nodes as select * from africa_osm_nodes where country = 'Nigeria';

-- test routing
		SELECT X.*, a.line, a.status, a.gauge, b.railway, b.name FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where line is not null',
               555009645,
		555016479,
		false
		) AS X left join
		africa_osm_edges as a on a.oid = X.edge left join
		africa_osm_nodes as b on b.oid = X.node
		ORDER BY seq;
			




























