SELECT infpunkt_id, p.inflokal_id,
DECODE(infconst_lokal_char_sid,
'S',
'W³asnoœciowe',
'L', 'Lokatorskie',
'W', 'Odrêbna w³asnoœæ',
'E',
'Eks. odr. w³.',
'F', 'Funkcyjne',
'K', 'Komunalne',
'N', 'Najem',
'D',
 'Dzier¿awa',
 'B',
 'Bez tytu³u prawnego',
 'I',
  'Inne',
 'A',
 'W³asnoœciowe bez cz³onkostwa',
 'C',
  'Odrêbna w³asnoœæ bez cz³onkostwa',
  infconst_lokal_char_nazwa) AS wlasnosc
FROM
  infpunkt p,
  inflokalhist h,
  infconst_lokal_char wl
  WHERE
  wl.infconst_lokal_char_sid = h.inflokalhist_charakter AND
  h.inflokal_id = p.inflokal_id
