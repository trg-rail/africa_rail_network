-- Morocco

select railway, count(*) from africa_osm_nodes where country like '%Morocco%' group by railway order by count desc;
select railway, count(*) from africa_osm_nodes where name is not null and country like '%Morocco%' group by railway order by count desc;

select railway, count(*) from africa_osm_edges where country like '%Morocco%' group by railway order by count desc;
select name, railway, count(*) from africa_osm_edges where country like '%Morocco%' group by name, railway  order by count desc;
select bridge, count(*) from africa_osm_edges where country like '%Morocco%' group by bridge order by count desc;