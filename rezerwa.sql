SELECT
m3.kdcharpracy_id,
m1.pllista_mies_ksieg AS mc1,
m2.pllista_mies_ksieg AS mc2,
m3.pllista_mies_ksieg AS mc3,
Nvl(m3.wart,0) + Nvl(m2.wart,0) + Nvl(m1.wart,0) AS wart_z_3_mc
FROM
(
SELECT
li.pllista_mies_ksieg,
os.kdcharpracy_id,
Sum(lida.pllistadana_wartosc_uwzg) wart

FROM
  pllista li,
  pllistadana lida,
  plskladnikdef def,
  pllistaosoba os
WHERE
  li.pllista_id=lida.pllista_id
  AND lida.plskladnikdef_id=def.plskladnikdef_id
  AND os.pllistaosoba_id=lida.pllistaosoba_id
  AND li.pllista_rok_ksieg=:rok
  AND def.plskladnikdef_symbol IN (1001,1002,1003,1010,1020,1022,1023,1024,1025,1026,1027,1028,1029,1031,1032)
  AND NOT EXISTS  (SELECT plskladnikdef_id
                   FROM pllistadana, pllistaosoba
                   WHERE pllistadana.pllista_id=li.pllista_id
                         AND pllistaosoba.pllistaosoba_id=pllistadana.pllistaosoba_id
                         AND pllistadana.pllistaosoba_id=os.pllistaosoba_id
                         AND plskladnikdef_id IN (5,1117)
                   )
GROUP BY
li.pllista_mies_ksieg,
os.kdcharpracy_id
) m3,
(
SELECT
li.pllista_mies_ksieg,
os.kdcharpracy_id,
Sum(lida.pllistadana_wartosc_uwzg) wart
FROM
  pllista li,
  pllistadana lida,
  plskladnikdef def,
  pllistaosoba os
WHERE
  li.pllista_id=lida.pllista_id
  AND lida.plskladnikdef_id=def.plskladnikdef_id
  AND os.pllistaosoba_id=lida.pllistaosoba_id
  AND li.pllista_rok_ksieg=:rok
  AND def.plskladnikdef_symbol IN (1001,1002,1003,1010,1020,1022,1023,1024,1025,1026,1027,1028,1029,1031,1032)
  AND NOT EXISTS  (SELECT plskladnikdef_id
                   FROM pllistadana, pllistaosoba
                   WHERE pllistadana.pllista_id=li.pllista_id
                         AND pllistaosoba.pllistaosoba_id=pllistadana.pllistaosoba_id
                         AND pllistadana.pllistaosoba_id=os.pllistaosoba_id
                         AND plskladnikdef_id IN (5,1117)
                   )
GROUP BY
li.pllista_mies_ksieg,
os.kdcharpracy_id
) m2,
(
SELECT
li.pllista_mies_ksieg,
os.kdcharpracy_id,
Sum(lida.pllistadana_wartosc_uwzg) wart
FROM
  pllista li,
  pllistadana lida,
  plskladnikdef def,
  pllistaosoba os
WHERE
  li.pllista_id=lida.pllista_id
  AND lida.plskladnikdef_id=def.plskladnikdef_id
  AND os.pllistaosoba_id=lida.pllistaosoba_id
  AND li.pllista_rok_ksieg=:rok
  AND def.plskladnikdef_symbol IN (1001,1002,1003,1010,1020,1022,1023,1024,1025,1026,1027,1028,1029,1031,1032)
  AND NOT EXISTS  (SELECT plskladnikdef_id
                   FROM pllistadana, pllistaosoba
                   WHERE pllistadana.pllista_id=li.pllista_id
                         AND pllistaosoba.pllistaosoba_id=pllistadana.pllistaosoba_id
                         AND pllistadana.pllistaosoba_id=os.pllistaosoba_id
                         AND plskladnikdef_id IN (5,1117)
                   )
GROUP BY
li.pllista_mies_ksieg,
os.kdcharpracy_id
) m1
WHERE
     To_Number(m1.pllista_mies_ksieg) > To_Number(m2.pllista_mies_ksieg)
     AND To_Number(m2.pllista_mies_ksieg) > To_Number(m3.pllista_mies_ksieg)
     AND m3.kdcharpracy_id = m2.kdcharpracy_id
     AND m3.kdcharpracy_id = m1.kdcharpracy_id   
ORDER BY m3.kdcharpracy_id, m3.pllista_mies_ksieg desc
