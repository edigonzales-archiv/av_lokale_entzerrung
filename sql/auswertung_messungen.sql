SELECT 1 as ogc_fid, (ST_Dump(the_geom)).geom
FROM
(
 SELECT operat_bfs, ST_Union(ST_Buffer(geometrie_lv03, 20)) as the_geom
 FROM 
 (
  SELECT operat_bfs, 'gp'::varchar as typ, geometrie_lv03
  FROM av_lokale_entzerrung.grenzpunkte as gp, av_avdpool_ng.tseinteilung_toleranzstufe as ts 
  WHERE gp.operat_bfs = 2522 AND fs IS NOT NULL 
  AND ts.art_txt = 'TS2' 
  AND gp.geometrie_lv03 && ts.geometrie
  AND ST_Intersects(gp.geometrie_lv03, ts.geometrie)

  UNION

  SELECT operat_bfs, 'fp'::varchar as typ, geometrie_lv03
  FROM av_lokale_entzerrung.lagefixpunkte as fp, av_avdpool_ng.tseinteilung_toleranzstufe as ts 
  WHERE fp.operat_bfs = 2522 AND fs IS NOT NULL 
  AND ts.art_txt = 'TS2'
  AND fp.geometrie_lv03 && ts.geometrie
  AND ST_Intersects(fp.geometrie_lv03, ts.geometrie)
 ) as a
 GROUP BY operat_bfs
) as b
