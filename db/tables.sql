CREATE TABLE av_lokale_entzerrung.gemeinde_operate
(
  ogc_fid serial NOT NULL,
  gemeinde_operat character varying,
  operat_bfs integer,
  gemeinde character varying,
  gem_bfs integer,
  bemerkungen character varying,
  wkb_geometry geometry,
  CONSTRAINT gemeinde_operate_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE av_lokale_entzerrung.gemeinde_operate OWNER TO av_verifikation;
GRANT ALL ON TABLE av_lokale_entzerrung.gemeinde_operate TO av_verifikation;
GRANT SELECT ON TABLE av_lokale_entzerrung.gemeinde_operate TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.gemeinde_operate TO public;
COMMENT ON COLUMN av_lokale_entzerrung.gemeinde_operate.gemeinde_operat IS 'Entspricht (mehr oder weniger) den alten Gemeindegrenzen. Versucht die Geschichte/Herkunft eines Vermessungwerkes abzugrenzen (ohne Lose).'

CREATE INDEX idx_av_lokale_entzerrung_gemeinde_operate_wkb_geometry
  ON av_lokale_entzerrung.gemeinde_operate
  USING gist
  (wkb_geometry);

INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'gemeinde_operate', 'wkb_geometry', 2, '21781', 'MULTIPOLYGON');

-----------------------------------------

DROP TABLE av_lokale_entzerrung.lagefixpunkte;

CREATE TABLE av_lokale_entzerrung.lagefixpunkte
(
  ogc_fid serial NOT NULL,
  nummer character varying,
  punktzeichen character varying,
  hoehe double precision,
  hoehe_gemessen double precision,
  geometrie_lv03 geometry,  
  geometrie_lv95_trans geometry,
  geometrie_lv95_gemessen geometry,
  operat_bfs integer,
  dy double precision,
  dx double precision,
  dh double precision,
  fs double precision,  
  CONSTRAINT lagefixpunkte_pkey PRIMARY KEY (ogc_fid)
) WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.lagefixpunkte OWNER TO av_verifikation;
GRANT ALL ON TABLE av_lokale_entzerrung.lagefixpunkte TO av_verifikation;
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

INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'lagefixpunkte', 'geometrie_lv03', 2, '21781', 'POINT');
INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'lagefixpunkte', 'geometrie_lv95_trans', 2, '2056', 'POINT');
INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'lagefixpunkte', 'geometrie_lv95_gemessen', 2, '2056', 'POINT');

-----------------------------------------

DROP TABLE av_lokale_entzerrung.grenzpunkte;

CREATE TABLE av_lokale_entzerrung.grenzpunkte
(
  ogc_fid serial NOT NULL,
  nummer character varying,
  punktzeichen character varying,
  geometrie_lv03 geometry,  
  geometrie_lv95_trans geometry,
  geometrie_lv95_gemessen geometry,
  operat_bfs integer,
  dy double precision,
  dx double precision,
  fs double precision,  
  CONSTRAINT grenzpunkte_pkey PRIMARY KEY (ogc_fid)
) WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.grenzpunkte OWNER TO av_verifikation;
GRANT ALL ON TABLE av_lokale_entzerrung.grenzpunkte TO av_verifikation;
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

INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'grenzpunkte', 'geometrie_lv03', 2, '21781', 'POINT');
INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'grenzpunkte', 'geometrie_lv95_trans', 2, '2056', 'POINT');
INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'grenzpunkte', 'geometrie_lv95_gemessen', 2, '2056', 'POINT');

-----------------------------------------

CREATE TABLE av_lokale_entzerrung.hektarraster
(
  ogc_fid serial NOT NULL,
  operat_bfs integer,
  gem_bfs integer,
  wkb_geometry geometry,
  CONSTRAINT hektarraster_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.hektarraster OWNER TO av_verifikation;
GRANT ALL ON TABLE av_lokale_entzerrung.hektarraster TO av_verifikation;
GRANT SELECT ON TABLE av_lokale_entzerrung.hektarraster TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.hektarraster TO public;

CREATE INDEX idx_av_lokale_entzerrung_hektarraster_wkb_geometry
  ON av_lokale_entzerrung.hektarraster
  USING gist
  (wkb_geometry);
  
INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'hektarraster', 'wkb_geometry', 2, '21781', 'POLYGON');

--------------------------------------------

CREATE TABLE av_lokale_entzerrung.chenyx06_lv03
(
  ogc_fid serial NOT NULL,
  nummer character varying,
  wkb_geometry geometry,
  CONSTRAINT chenyx06_lv03_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.chenyx06_lv03 OWNER TO av_verifikation;
GRANT ALL ON TABLE av_lokale_entzerrung.chenyx06_lv03 TO av_verifikation;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_lv03 TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_lv03 TO public;

CREATE INDEX idx_av_lokale_entzerrung_chenyx06_lv03_wkb_geometry
  ON av_lokale_entzerrung.chenyx06_lv03
  USING gist
  (wkb_geometry);
  
INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'chenyx06_lv03', 'wkb_geometry', 2, '21781', 'MULTIPOLYGON');

--------------------------------------------

CREATE TABLE av_lokale_entzerrung.chenyx06_lv95
(
  ogc_fid serial NOT NULL,
  nummer character varying,
  wkb_geometry geometry,
  CONSTRAINT chenyx06_lv95_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.chenyx06_lv95 OWNER TO av_verifikation;
GRANT ALL ON TABLE av_lokale_entzerrung.chenyx06_lv95 TO av_verifikation;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_lv95 TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_lv95 TO public;

CREATE INDEX idx_av_lokale_entzerrung_chenyx06_lv95_wkb_geometry
  ON av_lokale_entzerrung.chenyx06_lv95
  USING gist
  (wkb_geometry);
  
INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'chenyx06_lv95', 'wkb_geometry', 2, '2056', 'MULTIPOLYGON');

--------------------------------------------

CREATE TABLE av_lokale_entzerrung.chenyx06_tsp_lv03
(
  ogc_fid serial NOT NULL,
  nummer character varying,
  wkb_geometry geometry,
  CONSTRAINT chenyx06_tsp_lv03_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.chenyx06_tsp_lv03 OWNER TO av_verifikation;
GRANT ALL ON TABLE av_lokale_entzerrung.chenyx06_tsp_lv03 TO av_verifikation;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_tsp_lv03 TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_tsp_lv03 TO public;

CREATE INDEX idx_av_lokale_entzerrung_chenyx06_tsp_lv03_wkb_geometry
  ON av_lokale_entzerrung.chenyx06_tsp_lv03
  USING gist
  (wkb_geometry);
  
INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'chenyx06_tsp_lv03', 'wkb_geometry', 2, '21781', 'POINT');

--------------------------------------------

CREATE TABLE av_lokale_entzerrung.chenyx06_tsp_lv95
(
  ogc_fid serial NOT NULL,
  nummer character varying,
  wkb_geometry geometry,
  CONSTRAINT chenyx06_tsp_lv95_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE av_lokale_entzerrung.chenyx06_tsp_lv95 OWNER TO av_verifikation;
GRANT ALL ON TABLE av_lokale_entzerrung.chenyx06_tsp_lv95 TO av_verifikation;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_tsp_lv95 TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.chenyx06_tsp_lv95 TO public;

CREATE INDEX idx_av_lokale_entzerrung_chenyx06_tsp_lv95_wkb_geometry
  ON av_lokale_entzerrung.chenyx06_tsp_lv95
  USING gist
  (wkb_geometry);
  
INSERT INTO geometry_columns VALUES ('"', 'av_lokale_entzerrung', 'chenyx06_tsp_lv95', 'wkb_geometry', 2, '2056', 'POINT');


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

ALTER TABLE av_lokale_entzerrung.qgis_projekte OWNER TO av_verifikation;
GRANT ALL ON TABLE av_lokale_entzerrung.qgis_projekte TO av_verifikation;
GRANT SELECT ON TABLE av_lokale_entzerrung.qgis_projekte TO mspublic;
GRANT SELECT ON TABLE av_lokale_entzerrung.qgis_projekte TO public;


