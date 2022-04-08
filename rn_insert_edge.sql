
CREATE OR REPLACE FUNCTION

-- example use
-- select rn_insert_edge(555153957, 555003102, 556000039)

hvt.rn_insert_edge(start_node int8, end_node int8, node_oid int8)
returns void as $$
BEGIN
with tmp as
(
select st_makeline(a.geom, b.geom) as line, a.country from africa_osm_nodes a, africa_osm_nodes b where a.oid = $1 and b.oid = $2
)
insert into africa_osm_edges
select 
a.line,
a.country,
round(st_lengthspheroid(a.line, 'SPHEROID["WGS 84",6378137,298.257223563]')::numeric,2) as length,
$1,
$2,
$3
from tmp as a;
END;
$$ language 'plpgsql' VOLATILE;




CREATE OR REPLACE FUNCTION

hvt.rn_change_source(edge int8, node int8)
returns void as $$
BEGIN
UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, 0, (select geom from africa_osm_nodes where oid = $2)),
	source = $2
	WHERE oid = $1;
END;
$$ language 'plpgsql' VOLATILE;


CREATE OR REPLACE FUNCTION

hvt.rn_change_target(edge int8, node int8)
returns void as $$
BEGIN
UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, ST_NPoints ( geom ) - 1, (select geom from africa_osm_nodes where oid = $2)),
	target = $2
	WHERE oid = $1;
END;
$$ language 'plpgsql' VOLATILE;



