SELECT ch.kdcharpracy_id ,
--wyznacza date emerytury na dzien wejsciowy
kdplpackage.wyznaczdateemerytury(kdcharpracy_id,:data) dataem ,
--staz  na dzien daty emerytury
(select Stazemeryt from table(kdpackage.kdtabstaze(ch.kdcharpracy_id,kdplpackage.wyznaczdateemerytury(ch.kdcharpracy_id,:data),NULL))) stazzaklad,
--ilosc lat stazu dzien daty emerytury
substr((select Stazemeryt from table(kdpackage.kdtabstaze(ch.kdcharpracy_id,kdplpackage.wyznaczdateemerytury(ch.kdcharpracy_id,:data),NULL))),1,2)  lata,
--staz na dzien wejsciowy
(SELECT Stazemeryt from table(kdpackage.kdtabstaze(ch.kdcharpracy_id, :data,NULL)))   stazdzis,
--lata na dzien wejsciowy
substr((SELECT Stazemeryt from table(kdpackage.kdtabstaze(ch.kdcharpracy_id,:data,NULL))),1,2)   lataM

FROM kdcharpracy ch

