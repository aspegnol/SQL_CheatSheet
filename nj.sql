SELECT * FROM 
(SELECT 
ch.kdcharpracy_id , 
ch.kdcharpracy_data_zatr , 
o.kdosoba_symbol, 
o.kdosoba_nazwa, 
ts.Staznj AS stazdzis, 
SUBSTR(ts.Staznj,1,2)+1 AS lataNJ, 
SUBSTR(ts.Stazzaklad,1,2) AS lataZAKL 
FROM kdcharpracy ch ,kdosoba1 o1, kdosoba o,
TABLE(kdpackage.kdtabstaze(ch.kdcharpracy_id,:data,NULL)) ts 
WHERE 
ch.kdosoba1_id=o1.kdosoba1_id 
AND o1.kdosoba_id=o.kdosoba_id 
AND ch.KDCHARPRACY_DATA_ZWOLN IS NULL 
AND ch.kdumowadef_id='1' 
AND ch.kdcharpracy_czy_akt='1' 
ORDER BY o.kdosoba_symbol) 
WHERE
--albo zatrudnieni przed 01.01.2001 
(kdcharpracy_data_zatr<TO_DATE('01-01-2001','DD-MM-YYYY') OR 
-- albo przepracowali na 01.01 biezacego roku 10 lat w zakladzie 
(kdcharpracy_data_zatr>=TO_DATE('01-01-2001','DD-MM-YYYY') 
AND lataZAKL >=5 ) ) 

