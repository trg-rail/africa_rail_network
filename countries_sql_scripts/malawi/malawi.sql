-- Malawi

select railway, count(*) from africa_osm_nodes where country in ('Malawi') group by railway order by count desc;

select railway, count(*) from africa_osm_nodes where name is not null and country in ('Malawi') group by railway order by count desc;

select status, count(*) from africa_osm_edges where country in ('Malawi') group by status order by count desc;

select type, count(*) from africa_osm_edges where country in ('Malawi') group by type order by count desc;

select line, status, count(*) from africa_osm_edges where country in ('Malawi') and line is not null group by line, status order by count desc;

select structure, count(*) from africa_osm_edges where country in ('Malawi') group by structure order by count desc;

select gauge, count(*) from africa_osm_edges where country in ('Malawi') group by gauge order by gauge desc;


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

-- Sena line Mchinji (Zambian border) – Nkaya Junction

update africa_osm_nodes
set name = 'Nkaya'
where oid =  555031146;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555012146,
		555031146,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sena Line (Mchinji – Nkaya)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Nkaya Junction - Nayuchi
-- Part of Nacala Logistics Corridor. Main freight the transport of coal from Moatize coal mines in Mozambique to the port of Nacala

-- split 555064646 at 555064182
select rn_split_edge(array[555064646], array[555064182]);
--split 555002048 at 555126141
select rn_split_edge(array[555002048], array[555126141]);

update africa_osm_edges
set country = 'Malawi'
where oid = 5550151401;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555064182,
		559000040,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Nkaya Junction - Nayuchi',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Part of Nacala Logistics Corridor. Main freight the transport of coal from Moatize coal mines in Mozambique to the port of Nacala. Also passenger services'
where oid in (select edge from tmp);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555101888,
		555126141,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Nkaya Junction - Nayuchi',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Part of Nacala Logistics Corridor. Main freight the transport of coal from Moatize coal mines in Mozambique to the port of Nacala'
where oid in (select edge from tmp);


-- Nkaya - Limbe
-- this is open for freight and passenger services

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555031146,
		555007781,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Senna Line (Nkaya - Limbe)',
mode = 'mixed',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- add passenger services info on selected edges
-- Balaka - Nkaya
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555007803,
		555031146,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set mode = 'mixed'
where oid in (select edge from tmp);

-- Limbe - Nansadi

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555007781,
		555007634,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sena Line (Limbe - Nansadi)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'No passenger services. This section has been rehablitated (May 2021), see: https://bit.ly/3EPoc2a'
where oid in (select edge from tmp);

-- Nansadi - Luchenza


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555007634,
		555007801,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sena Line (Nansandi - Luchenza)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'No passenger services. It was reported in May 2021 that the rehabilitation of this section was at an advanced stage. See: https://bit.ly/3EPoc2a. Completion expected in December 2021 (see: https://bit.ly/3KXBMo2)'
where oid in (select edge from tmp);

-- Luchenza - Sandama 
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555007801,
		555007804,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sena Line (Luchenza - Sandama)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'rehabilitation',
comment = 'It was reported in July 2021 that the rehabilitation of this section would be completed by May 2022 (see: https://bit.ly/3KXBMo2). Delays were reported in June 2022 (see: http://bit.ly/3EOzns2). Assume may not be complete.'
where oid in (select edge from tmp);

-- Sandama - Bangula
-- disused
-- rehabilitation planned. See: https://times.mw/long-wait-for-rail-line-rehabilitation/

-- need to join missing sections across two sections of Shire River where bridges are missing.
select rn_insert_edge(555099470, 555090222, 556000084);
select rn_insert_edge(555090221, 555129531, 556000085);

-- prevent routing back via Mozambique
 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges where oid != 555100306',
             555007804,
		555031302,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sandama - Bangula',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Rehabilitation is expected. See: https://times.mw/long-wait-for-rail-line-rehabilitation/. Note that two bridges are missing across the Shire River. They have been added to the network for routing purposes.'
where oid in (select edge from tmp);

-- mark missing bridge sections over the Shire River as abandoned

update africa_osm_edges
set status = 'abandoned'
where oid in (556000084, 556000085);

-- Bangula - Marka
-- Rehabilitation project in place
-- see: https://www.gambetanews.com/malawi-govt-awards-marka-bangula-railway-to-contractor/
-- https://bit.ly/3ZtYgBT
-- Expected completion by end 2024.

update africa_osm_edge
set country = 'Mozambique' where oid = 5551202581;

update africa_osm_nodes
set railway = 'station'
where oid = 555031294;

-- insert missing edges
select rn_insert_edge(555144923, 555144924, 556000086);
select rn_insert_edge(555143160, 555144925, 556000087);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555031302,
		559000041,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Sena Line (Bangula - Marka)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'rehabilitation',
comment = 'Rehabilitation project taking place. See: https://bit.ly/3ZtYgBT. Expected completion by end of 2024.'
where oid in (select edge from tmp);

-- Spar to serve limestone quarry and cement plant at Changalume
-- This was run by Portland Cement but has apparently be out of use since 2002
-- Assume line is disused.
-- See: https://openjicareport.jica.go.jp/pdf/12124558_01.pdf (page 59)
-- There is an army barracks at Changalume so it's possible the line is used for troop transport. No sign on satellite imagery of use.

-- split 555049052 at 555112808
select rn_split_edge(array[555049052], array[555112808]);

-- split 555077899 at 555112806
select rn_split_edge(array[555077899], array[555112806]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112808,
		555031179,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Changalume branch',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'disused',
comment = 'Originally served Changalume limestone quarry and cement works. Most recent owner was Portland Cement, but they ceased operations in 2002. See: https://openjicareport.jica.go.jp/pdf/12124558_01.pdf (page 59). Assume this line is disused (though it may possibly be used in connection with an army barracks near the old quarry - no indication on satellite imagery)'
where oid in (select edge from tmp);


-- Freight Locations

-- National Oil Company of Malawi (NOCMA) Lilongwe Depot (fuel storage)

update africa_osm_nodes
set name = 'National Oil Company of Malawi (NOCMA) Lilongwe Depot',
railway = 'stop',
facility = 'fuel storage'
where oid = 555143152;

-- split 555086060 at 555143151
select rn_split_edge(array[555086060], array[555143151]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555143151,
		555143152,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'NOCMA Lilongwe Depot',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);



-- Kanengo Industrial Area

-- split 555003780 at 555112530
select rn_split_edge(array[555003780], array[555112530]);

update africa_osm_nodes
set name = 'Kanengo Industrial Area',
railway = 'stop',
facility = 'industrial area'
where oid = 555055240;

-- split 555086074 at 555138790
select rn_split_edge(array[555086074], array[555138790]);


 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555138790,
		555055240,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kanengo Industrial Area (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- split 555077701 at 555112514
-- split 555077700 at 555112504
-- split 555077699 at 555112503

select rn_split_edge(array[555077701,555077700,555077699], array[555112514,555112504,555112503]);

-- split 5550037802 at 555112500
select rn_split_edge(array[5550037802], array[555112500]);
-- split 555077702 at 555112506
select rn_split_edge(array[555077702], array[555112506]);
-- split 555077708 at 555138792
select rn_split_edge(array[555077708], array[555138792]);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112500,
		555112514,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kanengo Industrial Area (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112514,
		555138792,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Kanengo Industrial Area (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Manica Malawi Lilongwe Container Depot
	 
update africa_osm_nodes
set name = 'Manica Malawi Lilongwe Container Depot',
railway = 'stop',
facility = 'container terminal'
where oid = 555112507; 

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112514,
		555112507,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Manica Malawi Lilongwe Container Depot',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);
	 
	 
	 -- National Food Reserve Agency (Kanengo grain silos)
	
	 insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000097,
 null,
 null,
 'Malawi',
 null,
 null,
 ST_SetSRID(ST_Point(33.80740,-13.89337), 4326)
 )
;

select rn_copy_node(array[558000097], array[5550777082]);
-- 559000097

update africa_osm_nodes
set name = 'National Food Reserve Agency (grain silos)',
railway = 'stop',
facility = 'food storage',
comment = 'Unclear whether there is a rail connection into the facility'
where oid =  559000097;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555138792,
		559000097,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'National Food Reserve Agency (grain silos)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = 'Unclear whether there is a rail connection into the facility'
where oid in (select edge from tmp);
	 
	 -- Total Kanengo Fuel Depot
	 
	 update africa_osm_nodes
set name = 'Total Kanengo Fuel Depot',
railway = 'stop',
facility = 'fuel depot',
comment = ''
where oid =  555138793;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555138792,
		555138793,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Total Kanengo Fuel Depot',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

-- Kanengo station
 
 update africa_osm_nodes
 set name = 'Kanengo',
 railway = 'station'
 where oid = 555112521;
 
-- Chipoka Port (Lake Malawi)

-- split 555086722 at 555112545
-- split 555077725 at 555112548
-- split 555077726 at 555112549
-- split 555077728 at 555112553

select rn_split_edge(array[555086722,555077725,555077726,555077728], array[555112545,555112548,555112549,555112553]);

update africa_osm_nodes
set name = 'Chipoka Port (Lake Malawi)',
railway = 'stop',
facility = 'port (inland)'
where oid = 555112554;

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112545,
		555112554,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Chipoka Port (Lake Malawi)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);


-- Liwonde

-- split 555020970 at 555112580
-- split 555049071 at 555112589
-- split 555077751 at 555112586
-- split 555077749 at 555112585
-- split 555077746 at 555112583

select rn_split_edge(array[555020970,
555049071,
555077751,
555077749,
555077746
], array[555112580,
555112589,
555112586,
555112585,
555112583
]);

-- split 5550490711 at 555112588
-- split 5550209701 at 555073372
select rn_split_edge(array[5550490711,5550209701], array[555112588,555073372]);

-- Liwonde business area (access)

 with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112588,
		555073372,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Liwonde business area (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);

 -- Malawi Fertilizer Company
 
 update africa_osm_nodes
 set name = 'Malawi Fertilizer Company',
 railway = 'stop',
 facility = 'manufacturing'
 where oid = 555073371;
 
  with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555073372,
		555073371,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Malawi Fertilizer Company',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);
 
 
 -- The Agricultural Development and Marketing Corporation  (ADMARC) Rice Mill and Ground Nut Factory
 
  update africa_osm_nodes
 set name = 'ADMARC Rice Mill and Ground Nut Factory',
 railway = 'stop',
 facility = 'manufacturing',
 comment = 'Agricultural Development and Marketing Corporation'
 where oid = 555073373;
 
   with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555073372,
		555073373,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'ADMARC Rice Mill and Ground Nut Factory',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp);
 
 -- Mota-Engil, Malawi. Campus
   update africa_osm_nodes
 set name = 'Mota-Engil Malawi, Campus',
 railway = 'stop',
 facility = 'engineering',
 comment = ''
 where oid = 555101852;
	 
-- split 	 555062132 at 555101851
select rn_split_edge(array[555062132], array[555101851]);
	 
	   with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555101851,
		555101852,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Mota-Engil Malawi, Campus',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp); 
	 
-- Chirimba industrial area 
   update africa_osm_nodes
 set name = 'Chirimba industrial area',
 railway = 'stop',
 facility = 'industrial area',
 comment = ''
 where oid = 555112822;
	 

-- split 555077906 at 555112821
select rn_split_edge(array[555077906], array[555112821]);
-- split 555098066 at 555112818
select rn_split_edge(array[555098066], array[555112818]);


	   with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112818,
		555112822,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Chirimba industrial area (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp); 


  -- Chirimba Container Terminal CCTL
	
 update africa_osm_nodes
 set name = 'Chirimba Container Terminal CCTL',
 railway = 'stop',
 facility = 'container terminal',
 comment = ''
 where oid = 555112817;
 
 	   with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112821,
		555112817,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Chirimba Container Terminal CCTL',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp); 
	
	-- Blantyre Industrial Area
	  -- Fuel storage depot (various)
		-- Container terminal
 update africa_osm_nodes
 set name = 'Fuel storage depot (Blantyre)',
 railway = 'stop',
 facility = 'fuel depot',
 comment = ''
 where oid = 555112835;
 
 -- split 555003948 at 555112836
 -- split 555077916 at 555112837
 select rn_split_edge(array[555003948,555077916], array[555112836,555112837]);
 
  	   with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112836,
		555112837,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Blantyre Industrial Area (access)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp); 

  	   with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112837,
		555112835,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Fuel storage depot (Blantyre)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp); 

 update africa_osm_nodes
 set name = 'Container terminal (Blantyre)',
 railway = 'stop',
 facility = 'container terminal',
 comment = ''
 where oid = 555112840;	 
 
 -- split 555077917 at 555112839
 select rn_split_edge(array[555077917], array[555112839]);
 
   	   with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112837,
		555112840,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Container terminal (Blantyre)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp); 
	 
-- Limbe
  -- Limbe Auction Floors (Tobacco Auction)
	-- Total Energies Limbe Depot - https://times.mw/pil-resumes-rail-fuel-haulage/ 
	 -- https://pilmw.com/2022/08/11/pil-relaunches-cargo-train-fuel-transportation%EF%BF%BC%EF%BF%BC/


-- dry port - Limbe railway sidings - https://times.mw/limbe-dry-port-to-cost-5-5-million/?amp=1

	 insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000098,
 null,
 null,
 'Malawi',
 null,
 null,
 ST_SetSRID(ST_Point(35.06511,-15.82180), 4326)
 )
;

select rn_copy_node(array[558000098], array[555085095]);
-- 559000098

	 insert into africa_osm_nodes (
oid, railway, name, country, gauge, facility, geom)
 values (
 558000099,
 'stop',
 'Limbe Dry Port',
 'Malawi',
 null,
 'dry port',
 ST_SetSRID(ST_Point(35.06393,-15.82077), 4326)
 )
;

select rn_insert_edge(559000098, 558000099, 556000088);

   	   with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             559000098,
		558000099,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Limbe Dry Port',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp); 

update africa_osm_nodes
set comment = 'https://times.mw/limbe-dry-port-to-cost-5-5-million/?amp=1'
where oid = 558000099;
 

-- split 	555077928 at 555112853
select rn_split_edge(array[555077928], array[555112853]);
-- split 555077926 at 555112871
select rn_split_edge(array[555077926], array[555112871]);

select rn_change_target(5550779282, 559000098);

   	   with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             559000098,
		555112871,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Limbe Sidings (industrial area)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp); 

-- Limbe Auction Floors (Tobacco Auction)
-- Total Energies Limbe Depot - https://times.mw/pil-resumes-rail-fuel-haulage/ 
 
update africa_osm_nodes
set name = 'Limbe Auction Floors (Tobacco)',
railway = 'stop',
facility = 'Commodity auctions'
where oid = 555112854;


update africa_osm_nodes
set name = 'Total Energies Limbe Depot',
railway = 'stop',
facility = 'fuel depot',
comment = 'https://times.mw/pil-resumes-rail-fuel-haulage/'
where oid = 555112872;

   	   with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112871,
		555112854,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Limbe Auction Floors (Tobacco)',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp); 

   	   with tmp as(
SELECT X.* FROM pgr_dijkstra(
                'SELECT oid as id, source, target, length AS cost FROM africa_osm_edges',
             555112871,
		555112872,
		false
		) AS X
		ORDER BY seq)
update africa_osm_edges
set line = 'Total Energies Limbe Depot',
mode = 'freight',
type = 'conventional',
gauge = '1067',
status = 'open',
comment = ''
where oid in (select edge from tmp); 

-- fix stations
select rn_copy_node(array[555031294], array[5551202582]);

update africa_osm_nodes
set gauge = '1067'
where st_intersects(geom, (select st_collect(geom) from africa_osm_edges where gauge = '1067'))
and country in ('Malawi') and railway in ('station', 'halt', 'stop');

-- extract tables (backup)
create table malawi_osm_edges as select * from africa_osm_edges where country in ('Malawi');
create table malawi_osm_nodes as select * from africa_osm_nodes where country in ('Malawi');

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
			
			
			





























