---Usage Guide
--1. Run INV_SAP_PP_REPORT_WEEKLY, INV_SAP_PP_MVKE fetch from remote to local. Run data
-- on the local device. 
--2.After refresh data to the latest, run Report.

---PP TABLE FOR WEEKLY 

---Refresh Catalog Table
---Add Catalog table every 1 month...
---All plants '5041', '5051', '5101', '5111', '5121', '5161', '5191', '5201','5071','5141'


SELECT * FROM INV_SAP_PP_OPTIMIZATION WHERE MATERIALID = 'PN-163130';
DROP TABLE INV_SAP_MATERIAL_CATALOG;
CREATE TABLE INV_SAP_MATERIAL_CATALOG AS 
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_MATERIAL_CATALOG@ROCKWELL_DBLINK;
SELECT * FROM INV_SAP_MATERIAL_CATALOG;


SELECT * FROM INV_SAP_PP_REPORT_WEEKLY;

----Current Series
DROP TABLE INV_SAP_PP_MVKE;
CREATE TABLE INV_SAP_PP_MVKE AS
SELECT  MATERIALID
      ||'_'
      ||DIRECT_SHIP_PLANT            AS ID,
  MATERIALID,
  CURRENT_SERIES,
  DIRECT_SHIP_PLANT
FROM DWQ$LIBRARIAN.INV_SAP_PP_MVKE@ROCKWELL_DBLINK
WHERE CURRENT_SERIES   = 'X'
AND DIRECT_SHIP_PLANT IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5190','5170');
SELECT * FROM INV_SAP_PP_MVKE;

DROP TABLE INV_SAP_MATERIAL_CATALOG;
CREATE TABLE INV_SAP_MATERIAL_CATALOG AS
SELECT 
*
FROM DWQ$LIBRARIAN.INV_SAP_MATERIAL_CATALOG@ROCKWELL_DBLINK;

--Material Id join together with Catalog#
SELECT ISPM.ID AS ID,
  ISPM.MATERIALID,
  ISPM.CURRENT_SERIES,
  ISMC.CATALOG#
FROM
  (SELECT MATERIALID,
    ID,
    CURRENT_SERIES,
    DIRECT_SHIP_PLANT
  FROM INV_SAP_PP_MVKE
  )ISPM
LEFT JOIN
  ( SELECT MATERIALID, CATALOG_STRING1 FROM INV_SAP_MATERIAL_CATALOG
  )ISMC
ON ISPM.MATERIALID = ISMC.MATERIALID;


---PP REPORT
--V_1.0

SELECT 
  (INPRW.PLANTID - 1)      AS PLANTID,
  INPRW.MATERIALID         AS MATERIALID,
  MAT_CATA.CURRENT_SERIES  AS CURRENT_SERIES,
  MAT_CATA.CATALOG_STRING1 AS CATALOG_STRING,
  INPRW.MAT_DESC           AS MAT_DESC,
  INPRW.SAFETY_STK         AS SAFETY_STK,
  INPRW.LOT_SIZE           AS LOT_SIZE,
  INPRW.OH_QTY             AS OH_QTY,
  INPRW.UNIT_COST          AS UNIT_COST,
  INPRW.OH_$$              AS OH_$$,
  INPRW.MAX_INV_$$         AS MAX_INV_$$,
  INPRW.OH_WOS             AS OH_WOS,
  INPRW.PLAN_INV_WOS       AS PLAN_INV_WOS,
  SUBSTR(INPRW.PROD_BU,0,3)  AS PROD_BU,
  INPRW.PROD_FAM           AS PROD_FAM,
  INPRW.PROD_HIERARCHY     AS PROD_HIERARCHY,
  INPRW.MRP_CONTROLLER     AS MRP_CONTROLLER,
  INPRW.STRATEGY_GRP       AS STRATEGY_GRP,
  INPRW.MRP_TYPE           AS MRP_TYPE,
  INPRW.SP_MATL_STAT_MMSTA AS MATERIAL_STATUS,
  INPRW.SPC_PROC_KEY_SOBSL AS SPC_PROC_KEY_SOBSL,
  INPRW.VENDOR_NAME        AS VENDOR_NAME,
  INPRW.LOT_ROUNDING_VALUE AS LOT_ROUNDING_VALUE,
  INPRW.AVG52_USAGE_QTY    AS AVG52_USAGE_QTY,
  INPRW.STDEV52_USAGE      AS STDEV52_USAGE,
  INPRW.AVG26_USAGE_QTY    AS AVG26_USAGE_QTY,
  INPRW.STDEV26_USAGE      AS STDEV26_USAGE,
  INPRW.AVG13_USAGE_QTY    AS AVG13_USAGE_QTY,
  INPRW.STDEV13_USAGE      AS STDEV13_USAGE,
  INPRW.Q1_LINES           AS Q1_LINES,
  INPRW.Q2_LINES           AS Q2_LINES,
  INPRW.Q3_LINES           AS Q3_LINES,
  INPRW.Q4_LINES           AS Q4_LINES,
  INPRW.Q1_FREQ_COUNT      AS Q1_FREQ_COUNT,
  INPRW.Q2_FREQ_COUNT      AS Q2_FREQ_COUNT,
  INPRW.Q3_FREQ_COUNT      AS Q3_FREQ_COUNT,
  INPRW.Q4_FREQ_COUNT      AS Q4_FREQ_COUNT,
  (INPRW.GRT + INPRW.PDT)  AS LEAD_TIME,
  INPRW.GRT                AS GRT,
  INPRW.PDT                AS PDT,
  INPRW.MEINS_ISSUE_UOM    AS MEINS_ISSUE_UOM,
  INPRW.PURCH_GROUP_EKGRP  AS PURCH_GROUP_EKGRP,
  INPRW.MATL_TYPE_MTART    AS MATL_TYPE_MTART
FROM
  (SELECT ID,
    LAST_REVIEW,
    PROC_TYPE,
    MATERIALID,
    PLANTID,
    MAT_DESC,
    SAFETY_STK,
    LOT_SIZE,
    OH_QTY,
    UNIT_COST,
    OH_$$,
    MAX_INV_$$,
    OH_WOS,
    PLAN_INV_WOS,
    PROD_BU,
    PROD_FAM,
    PROD_HIERARCHY,
    MRP_CONTROLLER,
    PURCH_GROUP,
    STRATEGY_GRP,
    MRP_TYPE,
    SP_MATL_STAT_MMSTA,
    SPC_PROC_KEY_SOBSL,
    VENDOR_NAME,
    LOT_ROUNDING_VALUE,
    AVG52_USAGE_QTY,
    STDEV52_USAGE,
    AVG26_USAGE_QTY,
    STDEV26_USAGE,
    AVG13_USAGE_QTY,
    STDEV13_USAGE,
    Q1_LINES,
    Q2_LINES,
    Q3_LINES,
    Q4_LINES,
    Q1_FREQ_COUNT,
    Q2_FREQ_COUNT,
    Q3_FREQ_COUNT,
    Q4_FREQ_COUNT,
    GRT,
    PDT,
    MEINS_ISSUE_UOM,
    PURCH_GROUP_EKGRP,
    MATL_TYPE_MTART
  FROM INV_SAP_PP_REPORT_WEEKLY
  )INPRW
LEFT JOIN
  (SELECT ISPM.ID AS ID,
    ISPM.MATERIALID,
    ISPM.CURRENT_SERIES,
    ISMC.CATALOG_STRING1
  FROM
    (SELECT MATERIALID,
      ID,
      CURRENT_SERIES,
      DIRECT_SHIP_PLANT
    FROM INV_SAP_PP_MVKE WHERE CURRENT_SERIES = 'X'
    )ISPM
  LEFT JOIN
    ( SELECT MATERIALID, CATALOG_STRING1 FROM INV_SAP_MATERIAL_CATALOG
    )ISMC
  ON ISPM.MATERIALID        = ISMC.MATERIALID
  ) MAT_CATA ON MAT_CATA.ID = INPRW.ID;
  

---------Backup Codes---------------
SELECT INPRW.PROC_TYPE     AS PROC_TYPE,
  INPRW.MATERIALID         AS MATERIALID,
  MAT_CATA.CURRENT_SERIES  AS CURRENT_SERIES,
  MAT_CATA.CATALOG_STRING1 AS CATALOG_STRING,
  (INPRW.PLANTID - 1)           AS PLANTID,
  INPRW.MAT_DESC           AS MAT_DESC,
  INPRW.SAFETY_STK         AS SAFETY_STK,
  INPRW.LOT_SIZE           AS LOT_SIZE,
  INPRW.OH_QTY             AS OH_QTY,
  INPRW.UNIT_COST          AS UNIT_COST,
  INPRW.OH_$$              AS OH_$$,
  INPRW.MAX_INV_$$         AS MAX_INV_$$,
  INPRW.OH_WOS             AS OH_WOS,
  INPRW.PLAN_INV_WOS       AS PLAN_INV_WOS,
  INPRW.PROD_BU            AS PROD_BU,
  INPRW.PROD_FAM           AS PROD_FAM,
  INPRW.PROD_HIERARCHY     AS PROD_HIERARCHY,
  INPRW.MRP_CONTROLLER     AS MRP_CONTROLLER,
  INPRW.PURCH_GROUP        AS PURCH_GROUP,
  INPRW.STRATEGY_GRP       AS STRATEGY_GRP,
  INPRW.MRP_TYPE           AS MRP_TYPE,
  INPRW.SP_MATL_STAT_MMSTA AS SP_MATL_STAT_MMSTA,
  INPRW.SPC_PROC_KEY_SOBSL AS SPC_PROC_KEY_SOBSL,
  INPRW.VENDOR_NAME        AS VENDOR_NAME,
  INPRW.LOT_ROUNDING_VALUE AS LOT_ROUNDING_VALUE,
  INPRW.AVG52_USAGE_QTY    AS AVG52_USAGE_QTY,
  INPRW.STDEV52_USAGE      AS STDEV52_USAGE,
  INPRW.AVG26_USAGE_QTY    AS AVG26_USAGE_QTY,
  INPRW.STDEV26_USAGE      AS STDEV26_USAGE,
  INPRW.AVG13_USAGE_QTY    AS AVG13_USAGE_QTY,
  INPRW.STDEV13_USAGE      AS STDEV13_USAGE,
  INPRW.Q1_LINES           AS Q1_LINES,
  INPRW.Q2_LINES           AS Q2_LINES,
  INPRW.Q3_LINES           AS Q3_LINES,
  INPRW.Q4_LINES           AS Q4_LINES,
  INPRW.Q1_FREQ_COUNT      AS Q1_FREQ_COUNT,
  INPRW.Q2_FREQ_COUNT      AS Q2_FREQ_COUNT,
  INPRW.Q3_FREQ_COUNT      AS Q3_FREQ_COUNT,
  INPRW.Q4_FREQ_COUNT      AS Q4_FREQ_COUNT,
  INPRW.GRT                AS GRT,
  INPRW.PDT                AS PDT,
  INPRW.MEINS_ISSUE_UOM    AS MEINS_ISSUE_UOM,
  INPRW.PURCH_GROUP_EKGRP  AS PURCH_GROUP_EKGRP,
  INPRW.MATL_TYPE_MTART    AS MATL_TYPE_MTART
FROM
  (SELECT ID,
    LAST_REVIEW,
    PROC_TYPE,
    MATERIALID,
    PLANTID,
    MAT_DESC,
    SAFETY_STK,
    LOT_SIZE,
    OH_QTY,
    UNIT_COST,
    OH_$$,
    MAX_INV_$$,
    OH_WOS,
    PLAN_INV_WOS,
    PROD_BU,
    PROD_FAM,
    PROD_HIERARCHY,
    MRP_CONTROLLER,
    PURCH_GROUP,
    STRATEGY_GRP,
    MRP_TYPE,
    SP_MATL_STAT_MMSTA,
    SPC_PROC_KEY_SOBSL,
    VENDOR_NAME,
    LOT_ROUNDING_VALUE,
    AVG52_USAGE_QTY,
    STDEV52_USAGE,
    AVG26_USAGE_QTY,
    STDEV26_USAGE,
    AVG13_USAGE_QTY,
    STDEV13_USAGE,
    Q1_LINES,
    Q2_LINES,
    Q3_LINES,
    Q4_LINES,
    Q1_FREQ_COUNT,
    Q2_FREQ_COUNT,
    Q3_FREQ_COUNT,
    Q4_FREQ_COUNT,
    GRT,
    PDT,
    MEINS_ISSUE_UOM,
    PURCH_GROUP_EKGRP,
    MATL_TYPE_MTART
  FROM INV_SAP_PP_REPORT_WEEKLY
  )INPRW
LEFT JOIN
  (SELECT ISPM.ID AS ID,
    ISPM.MATERIALID,
    ISPM.CURRENT_SERIES,
    ISMC.CATALOG_STRING1
  FROM
    (SELECT MATERIALID,
      ID,
      CURRENT_SERIES,
      DIRECT_SHIP_PLANT
    FROM INV_SAP_PP_MVKE
    )ISPM
  LEFT JOIN
    ( SELECT MATERIALID, CATALOG_STRING1 FROM INV_SAP_MATERIAL_CATALOG
    )ISMC
  ON ISPM.MATERIALID        = ISMC.MATERIALID
  ) MAT_CATA ON MAT_CATA.ID = INPRW.ID;
  
  