CREATE SCHEMA av_lokale_entzerrung
  AUTHORIZATION stefan;

GRANT ALL ON SCHEMA av_lokale_entzerrung TO stefan;
GRANT USAGE ON SCHEMA av_lokale_entzerrung TO mspublic;

-----------------------------------------


CREATE TABLE av_lokale_entzerrung.gemeinde_operate
(
  ogc_fid serial NOT NULL,
  gemeinde_operat character varying,
  operat_bfs integer,
  gemeinde character varying,
  gem_bfs integer,
  bemerkungen character varying,
  wkb_geometry geometry(MULTIPOLYGON,21781),
  CONSTRAINT gemeinde_operate_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE av_lokale_entzerrung.gemeinde_operate OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.gemeinde_operate TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.gemeinde_operate TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.gemeinde_operate TO public;
COMMENT ON COLUMN av_lokale_entzerrung.gemeinde_operate.gemeinde_operat IS 'Entspricht (mehr oder weniger) den alten Gemeindegrenzen. Versucht die Geschichte/Herkunft eines Vermessungwerkes abzugrenzen (ohne Lose).';

CREATE INDEX idx_av_lokale_entzerrung_gemeinde_operate_wkb_geometry
  ON av_lokale_entzerrung.gemeinde_operate
  USING gist
  (wkb_geometry);

--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'gemeinde_operate', 'wkb_geometry', 2, '21781', 'MULTIPOLYGON');

-----------------------------------------

--DROP TABLE av_lokale_entzerrung.lagefixpunkte;

CREATE TABLE av_lokale_entzerrung.lagefixpunkte
(
  ogc_fid serial NOT NULL,
  nummer character varying,
  punktzeichen character varying,
  hoehe double precision,
  hoehe_gemessen double precision,
  geometrie_lv03 geometry(POINT,21781),  
  geometrie_lv95_trans geometry(POINT,2056),
  geometrie_lv95_gemessen geometry(POINT,2056),
  operat_bfs integer,
  dy double precision,
  dx double precision,
  dh double precision,
  fs double precision,  
  CONSTRAINT lagefixpunkte_pkey PRIMARY KEY (ogc_fid)
) WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.lagefixpunkte OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.lagefixpunkte TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.lagefixpunkte TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.lagefixpunkte TO public;

CREATE INDEX idx_av_lokale_entzerrung_lagefixpunkte_geometrie_lv03
  ON av_lokale_entzerrung.lagefixpunkte
  USING gist
  (geometrie_lv03);

CREATE INDEX idx_av_lokale_entzerrung_lagefixpunkte_geometrie_lv95_trans
  ON av_lokale_entzerrung.lagefixpunkte
  USING gist
  (geometrie_lv95_trans);

CREATE INDEX idx_av_lokale_entzerrung_gemeinde_lagefixpunkte_lv95_gemessen
  ON av_lokale_entzerrung.lagefixpunkte
  USING gist
  (geometrie_lv95_gemessen);

--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'lagefixpunkte', 'geometrie_lv03', 2, '21781', 'POINT');
--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'lagefixpunkte', 'geometrie_lv95_trans', 2, '2056', 'POINT');
--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'lagefixpunkte', 'geometrie_lv95_gemessen', 2, '2056', 'POINT');

-----------------------------------------

--DROP TABLE av_lokale_entzerrung.grenzpunkte;

CREATE TABLE av_lokale_entzerrung.grenzpunkte
(
  ogc_fid serial NOT NULL,
  nummer character varying,
  punktzeichen character varying,
  geometrie_lv03 geometry(POINT,21781),  
  geometrie_lv95_trans geometry(POINT,2056),
  geometrie_lv95_gemessen geometry(POINT,2056),
  operat_bfs integer,
  dy double precision,
  dx double precision,
  fs double precision,  
  CONSTRAINT grenzpunkte_pkey PRIMARY KEY (ogc_fid)
) WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.grenzpunkte OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.grenzpunkte TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.grenzpunkte TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.grenzpunkte TO public;

CREATE INDEX idx_av_lokale_entzerrung_grenzpunkte_geometrie_lv03
  ON av_lokale_entzerrung.grenzpunkte
  USING gist
  (geometrie_lv03);

CREATE INDEX idx_av_lokale_entzerrung_grenzpunkte_geometrie_lv95_trans
  ON av_lokale_entzerrung.grenzpunkte
  USING gist
  (geometrie_lv95_trans);

CREATE INDEX idx_av_lokale_entzerrung_gemeinde_grenzpunkte_lv95_gemessen
  ON av_lokale_entzerrung.grenzpunkte
  USING gist
  (geometrie_lv95_gemessen);

--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'grenzpunkte', 'geometrie_lv03', 2, '21781', 'POINT');
--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'grenzpunkte', 'geometrie_lv95_trans', 2, '2056', 'POINT');
--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'grenzpunkte', 'geometrie_lv95_gemessen', 2, '2056', 'POINT');

-----------------------------------------

CREATE TABLE av_lokale_entzerrung.hektarraster
(
  ogc_fid serial NOT NULL,
  operat_bfs integer,
  gem_bfs integer,
  wkb_geometry geometry(POLYGON,21781),
  CONSTRAINT hektarraster_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.hektarraster OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.hektarraster TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.hektarraster TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.hektarraster TO public;

CREATE INDEX idx_av_lokale_entzerrung_hektarraster_wkb_geometry
  ON av_lokale_entzerrung.hektarraster
  USING gist
  (wkb_geometry);
  
--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'hektarraster', 'wkb_geometry', 2, '21781', 'POLYGON');

-----------------------------------------

CREATE TABLE av_lokale_entzerrung.cluster_messungen
(
  ogc_fid serial NOT NULL,
  operat_bfs integer,
  wkb_geometry geometry(POLYGON,21781),
  CONSTRAINT cluster_messungen_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.cluster_messungen OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.cluster_messungen TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.cluster_messungen TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.cluster_messungen TO public;

CREATE INDEX idx_av_lokale_entzerrung_cluster_messungen_wkb_geometry
  ON av_lokale_entzerrung.cluster_messungen
  USING gist
  (wkb_geometry);
  
--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'cluster_messungen', 'wkb_geometry', 2, '21781', 'POLYGON');

--------------------------------------------

CREATE TABLE av_lokale_entzerrung.average_messungen
(
  ogc_fid serial NOT NULL,
  dy_avg double precision,
  dx_avg double precision,
  fs_avg double precision,
  toleranzstufe integer,
  operat_bfs integer,
  wkb_geometry geometry(POINT,21781),
  CONSTRAINT average_messungen_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.average_messungen OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.average_messungen TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.average_messungen TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.average_messungen TO public;

CREATE INDEX idx_av_lokale_entzerrung_average_messungen_wkb_geometry
  ON av_lokale_entzerrung.average_messungen
  USING gist
  (wkb_geometry);
  
--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'average_messungen', 'wkb_geometry', 2, '21781', 'POINT');

--------------------------------------------

CREATE TABLE av_lokale_entzerrung.operat_statistik
(
  ogc_fid serial NOT NULL,
  fs_mean double precision,
  fs_stddev double precision,
  fs_min double precision,
  fs_max double precision,
  fs_68 double precision,
  fs_95 double precision,
  toleranzstufe integer,
  operat_bfs integer,
  CONSTRAINT operat_statistik_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.operat_statistik OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.operat_statistik TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.operat_statistik TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.operat_statistik TO public;


--------------------------------------------


CREATE TABLE av_lokale_entzerrung.chenyx06_lv03
(
  ogc_fid serial NOT NULL,
  nummer character varying,
  wkb_geometry geometry(MULTIPOLYGON,21781),
  CONSTRAINT chenyx06_lv03_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.chenyx06_lv03 OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.chenyx06_lv03 TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_lv03 TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_lv03 TO public;

CREATE INDEX idx_av_lokale_entzerrung_chenyx06_lv03_wkb_geometry
  ON av_lokale_entzerrung.chenyx06_lv03
  USING gist
  (wkb_geometry);
  
--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'chenyx06_lv03', 'wkb_geometry', 2, '21781', 'MULTIPOLYGON');

--------------------------------------------

CREATE TABLE av_lokale_entzerrung.chenyx06_lv95
(
  ogc_fid serial NOT NULL,
  nummer character varying,
  wkb_geometry geometry(MULTIPOLYGON,2056),
  CONSTRAINT chenyx06_lv95_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.chenyx06_lv95 OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.chenyx06_lv95 TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_lv95 TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_lv95 TO public;

CREATE INDEX idx_av_lokale_entzerrung_chenyx06_lv95_wkb_geometry
  ON av_lokale_entzerrung.chenyx06_lv95
  USING gist
  (wkb_geometry);
  
--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'chenyx06_lv95', 'wkb_geometry', 2, '2056', 'MULTIPOLYGON');

--------------------------------------------

CREATE TABLE av_lokale_entzerrung.chenyx06_tsp_lv03
(
  ogc_fid serial NOT NULL,
  nummer character varying,
  wkb_geometry geometry(POINT,21781),
  CONSTRAINT chenyx06_tsp_lv03_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.chenyx06_tsp_lv03 OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.chenyx06_tsp_lv03 TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_tsp_lv03 TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_tsp_lv03 TO public;

CREATE INDEX idx_av_lokale_entzerrung_chenyx06_tsp_lv03_wkb_geometry
  ON av_lokale_entzerrung.chenyx06_tsp_lv03
  USING gist
  (wkb_geometry);
  
--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'chenyx06_tsp_lv03', 'wkb_geometry', 2, '21781', 'POINT');

--------------------------------------------

CREATE TABLE av_lokale_entzerrung.chenyx06_tsp_lv95
(
  ogc_fid serial NOT NULL,
  nummer character varying,
  wkb_geometry geometry(POINT,2056),
  CONSTRAINT chenyx06_tsp_lv95_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.chenyx06_tsp_lv95 OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.chenyx06_tsp_lv95 TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_tsp_lv95 TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_tsp_lv95 TO public;

CREATE INDEX idx_av_lokale_entzerrung_chenyx06_tsp_lv95_wkb_geometry
  ON av_lokale_entzerrung.chenyx06_tsp_lv95
  USING gist
  (wkb_geometry);
  
--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'chenyx06_tsp_lv95', 'wkb_geometry', 2, '2056', 'POINT');


--------------------------------------------

CREATE TABLE av_lokale_entzerrung.qgis_projekte
(
  ogc_fid serial NOT NULL,
  "projektname" character varying,
  qgs_string character varying,
  CONSTRAINT qgis_projekte_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.qgis_projekte OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.qgis_projekte TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.qgis_projekte TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.qgis_projekte TO public;

--------------------------------------------

CREATE TABLE av_lokale_entzerrung.kontrollmessungen_lfp2
(
  ogc_fid serial NOT NULL,
  nummer VARCHAR(100), 
  dy DOUBLE PRECISION,
  dx DOUBLE PRECISION,
  fs DOUBLE PRECISION,
  the_geom geometry(POINT,21781),
  CONSTRAINT kontrollmessungen_lfp2_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.kontrollmessungen_lfp2 OWNER TO av_verifikation;
GRANT ALL ON TABLE av_lokale_entzerrung.kontrollmessungen_lfp2 TO av_verifikation;
GRANT SELECT ON TABLE av_lokale_entzerrung.kontrollmessungen_lfp2 TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.kontrollmessungen_lfp2 TO public;

CREATE INDEX idx_av_lokale_entzerrung_kontrollmessungen_lfp2_the_geom
  ON av_lokale_entzerrung.kontrollmessungen_lfp2
  USING gist
  (the_geom);
  
--INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'kontrollmessungen_lfp2', 'the_geom', 2, '21781', 'POINT');

