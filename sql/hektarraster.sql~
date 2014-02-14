-- Unter Umständen noch ST_Union für TS-Gebiete.
-- Im Fall von Lüterswil (oder Gächliwil) sieht
-- es aber sogar besser aus ohne.


SELECT tol.go_gem_bfs, tol.gem_bfs, ha.geom
FROM
(
 SELECT FALSE, ST_SetSRID(ST_Translate(geom, 0 ,yseries),21781) as geom 
 FROM 
 (
   SELECT generate_series(0, dy, 200) as yseries, st_translate(geom, xseries, 0) as geom 
   FROM 
   (
     SELECT  generate_series(0, dx, 200) as xseries, dy, geom 
     FROM 
     (
       SELECT st_envelope(st_makeline(st_makepoint(xmin,ymin), st_makepoint(xmin+200, ymin+200))) as geom, 
                   ((xmax-xmin)::integer / 200::integer)*200 as dx, ((ymax-ymin)::integer / 200::integer)*200 as dy 
       FROM 
       (
         SELECT ST_XMin(geometrie) as xmin, ST_YMin(geometrie) as ymin, ST_XMax(geometrie) as xmax, ST_YMax(geometrie) as ymax 
         FROM
         (
          SELECT gem_bfs, geometrie
          FROM av_avdpool_ng.tseinteilung_toleranzstufe
          WHERE art = 1
         ) as ts,
         (
          SELECT go_gem_bfs, gem_bfs, wkb_geometry
          FROM av_lokale_entzerrung.gemeinde_operate
          WHERE go_gem_bfs = 2448
         ) gem
         WHERE gem.gem_bfs = ts.gem_bfs
         AND gem.wkb_geometry && ts.geometrie
         AND ST_Intersects(gem.wkb_geometry, ts.geometrie)
       ) as s1
     ) as t1
   ) as t2
 ) as t3
) as ha,

(
 SELECT gem.go_gem_bfs, gem.gem_bfs, ts.geometrie
 FROM
 (
  SELECT gem_bfs, geometrie
  FROM av_avdpool_ng.tseinteilung_toleranzstufe
  WHERE art = 1
 ) as ts,
 (
  SELECT go_gem_bfs, gem_bfs, wkb_geometry
  FROM av_lokale_entzerrung.gemeinde_operate
  WHERE go_gem_bfs = 2448
 ) gem
 WHERE gem.wkb_geometry && ts.geometrie
 AND ST_Intersects(ST_Buffer(gem.wkb_geometry, -1), ts.geometrie)
) as tol

WHERE tol.geometrie && ha.geom
AND ST_Intersects(tol.geometrie, ha.geom);
