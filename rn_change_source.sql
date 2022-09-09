CREATE OR REPLACE FUNCTION "hvt"."rn_change_source"("edge" int8, "node" int8)
  RETURNS "pg_catalog"."void" AS $BODY$
BEGIN
UPDATE africa_osm_edges
	SET geom = ST_SetPoint(geom, 0, (select geom from africa_osm_nodes where oid = $2)),
	source = $2
	WHERE oid = $1;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100