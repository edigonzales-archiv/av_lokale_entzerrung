CREATE OR REPLACE VIEW av_lokale_entzerrung.v_messungen_statistik AS 

SELECT a.*, b.gemeinde_operat || ' (' || a.operat_bfs || ')' as gemeinde_operat, b.gemeinde || ' (' || b.gem_bfs || ')' as gemeinde, b.gem_bfs, b.wkb_geometry as geometry
FROM
(
 SELECT *   
 FROM
 (
  SELECT ts2.*, ts3.ts3_mean, ts3.ts3_stddev, ts3.ts3_min, ts3.ts3_max, ts3.ts3_68, ts3.ts3_95,
         ts4.ts4_mean, ts4.ts4_stddev, ts4.ts4_min, ts4.ts4_max, ts4.ts4_68, ts4.ts4_95
  FROM
  (
   SELECT ogc_fid, operat_bfs, fs_mean::integer::text || 'mm' as ts2_mean, 
          fs_stddev::integer::text || 'mm' as ts2_stddev, fs_min::integer::text || 'mm' as ts2_min, 
          fs_max::integer::text || 'mm' as ts2_max, fs_68::integer::text || 'mm' as ts2_68, 
          fs_95::integer::text || 'mm' as ts2_95
   FROM av_lokale_entzerrung.operat_statistik
   WHERE toleranzstufe = 2
  ) as ts2
  FULL JOIN  
  (
   SELECT operat_bfs, fs_mean::integer::text || 'mm' as ts3_mean, 
         fs_stddev::integer::text || 'mm' as ts3_stddev, fs_min::integer::text || 'mm' as ts3_min, 
         fs_max::integer::text || 'mm' as ts3_max, fs_68::integer::text || 'mm' as ts3_68, 
         fs_95::integer::text || 'mm' as ts3_95
   FROM av_lokale_entzerrung.operat_statistik
   WHERE toleranzstufe = 3
  ) as ts3
  ON ts2.operat_bfs = ts3.operat_bfs
  FULL JOIN
  (
   SELECT operat_bfs, fs_mean::integer::text || 'mm' as ts4_mean, 
          fs_stddev::integer::text || 'mm' as ts4_stddev, fs_min::integer::text || 'mm' as ts4_min, 
          fs_max::integer::text || 'mm' as ts4_max, fs_68::integer::text || 'mm' as ts4_68, 
          fs_95::integer::text || 'mm' as ts4_95
   FROM av_lokale_entzerrung.operat_statistik
   WHERE toleranzstufe = 4
  ) as ts4
  ON ts2.operat_bfs = ts4.operat_bfs
 ) as stat
) as a, av_lokale_entzerrung.gemeinde_operate as b
WHERE a.operat_bfs = b.operat_bfs;

ALTER TABLE av_lokale_entzerrung.v_messungen_statistik OWNER TO stefan;
GRANT ALL ON TABLE av_lokale_entzerrung.v_messungen_statistik TO stefan;
GRANT SELECT ON TABLE av_lokale_entzerrung.v_messungen_statistik TO mspublic;







