SET standard_conforming_strings = OFF;
DROP TABLE IF EXISTS "public"."additional_nodes_1435_conakry_port" CASCADE;
BEGIN;
CREATE TABLE "public"."additional_nodes_1435_conakry_port" ( "ogc_fid" SERIAL, CONSTRAINT "additional_nodes_1435_conakry_port_pk" PRIMARY KEY ("ogc_fid") );
SELECT AddGeometryColumn('public','additional_nodes_1435_conakry_port','wkb_geometry',4326,'POINT',2);
CREATE INDEX "additional_nodes_1435_conakry_port_wkb_geometry_geom_idx" ON "public"."additional_nodes_1435_conakry_port" USING GIST ("wkb_geometry");
INSERT INTO "public"."additional_nodes_1435_conakry_port" ("wkb_geometry" ) VALUES ('0101000020E610000028316E3F77542BC0423066F46F182340');
INSERT INTO "public"."additional_nodes_1435_conakry_port" ("wkb_geometry" ) VALUES ('0101000020E61000000F65C004B6622BC05F474067B60B2340');
COMMIT;
