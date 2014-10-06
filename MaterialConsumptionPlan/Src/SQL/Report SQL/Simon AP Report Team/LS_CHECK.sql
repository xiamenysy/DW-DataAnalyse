--Porject Name: LS CHECK
--Author: Huang Moyue 
--Mail: mhuang1@ra.rockwell.com
--Date:09/26/2014
--Summary: LOT SIZE CHECK. 

SELECT PLANT,
  MATERIAL,
  GRT,
  CASE
    WHEN LOT_SIZE_DISLS <> 'WB'
    THEN 'Need To Check'
    ELSE 'Changed Done'
  END LS_CHECK
FROM INV_SAP_PP_OPT_X
WHERE PLANT IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140');



