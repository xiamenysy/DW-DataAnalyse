--RCCP REPORT
--6/14/2014
--AUTHOR: HUANG MOYUE
--'5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140'
--OUTPUT, INPUT FOR TOTAL REQUIREMENT AND PO+PLAN ORDER
--DATA FROM BI REPORT MCBZ
--How to calculate the week number.
--SELECT TO_CHAR(SYSDATE,'iw') AS weekn,
--TO_CHAR(to_date('20050425','yyyymmdd'),'iw')      AS week1
--ITEM MATL TYPE: ZTG ZFG
--SG:40, Z4
--Function show
SELECT ID,
  MATERIALID,
  SUM(WEEK_1) AS WK_1,
  SUM(WEEK_2) AS WK_2,
  SUM(WEEK_3) AS WK_3,
  SUM(WEEK_4) AS WK_4,
  SUM(WEEK_5) AS WK_5,
  SUM(WEEK_6) AS WK_6,
  SUM(WEEK_7) AS WK_7,
  SUM(WEEK_8) AS WK_8,
  SUM(WEEK_9) AS WK_9,
  SUM(WEEK_10) AS WK_10,
  SUM(WEEK_11) AS WK_11,
  SUM(WEEK_12) AS WK_12,
  SUM(WEEK_13) AS WK_13
FROM
  (SELECT MATERIALID
    ||'_'
    ||PLANTID AS ID,
    MATERIALID,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw')
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_1,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 1
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_2,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 2
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_3,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 3
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_4,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 4
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_5,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 5
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_6,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 6
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_7,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 7
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_8,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 8
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_9,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 9
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_10,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 10
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_11,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 11
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_12,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 12
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_13,
    PLANTID
  FROM
    (SELECT MATERIALID,
      PLANTID,
      PDATU_DELIV_ORDFINISHDATE,
      TO_CHAR(PDATU_DELIV_ORDFINISHDATE,'iw') AS WEEK_NUMBER,
      MEINS_BASEUNITOFMEASURE,
      PLNMG_PLANNEDQUANTITY,
      BEDAEP_REQUIREMENTSTYPE,
      VERSBP_VERSION
    FROM INV_SAP_PP_FRCST_PBIM_PBED
    WHERE VERSBP_VERSION = '55'
    AND PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 91)
    )
  )group by ID, MATERIALID;
  
-----------------------------------------------------------------------------------------------------------------------------
--New RCCP
--1. Upload the mcbz data into the indreq table
--Clear the table
CREATE TABLE INV_SAP_RCCP_INDREQ AS 
SELECT * FROM SYSTEM.INV_SAP_RCCP_INDREQ@ROCKWELL_LOCAL_BK;
SELECT count(*) FROM INV_SAP_RCCP_INDREQ;

DROP TABLE INV_SAP_RCCP_INDREQ;
TRUNCATE TABLE INV_SAP_RCCP_INDREQ;
INSERT INTO INV_SAP_RCCP_INDREQ(
PLANT,
MAP_CONTROLLER,
MATERIAL,
ELEMENT_INDICATOR,
IND_REQ_WK_0,
IND_REQ_WK_1,
IND_REQ_WK_2,
IND_REQ_WK_3,
IND_REQ_WK_4,
IND_REQ_WK_5,
IND_REQ_WK_6,
IND_REQ_WK_7,
IND_REQ_WK_8,
IND_REQ_WK_9,
IND_REQ_WK_10,
IND_REQ_WK_11,
IND_REQ_WK_12
) VALUES ('PLANT_1',
'MAP_CONTROLLER_1',
'MATERIAL_1',
'ELEMENT_INDICATOR_1',
IND_REQ_WK_0_1,
IND_REQ_WK_1_1,
IND_REQ_WK_2_1,
IND_REQ_WK_3_1,
IND_REQ_WK_4_1,
IND_REQ_WK_5_1,
IND_REQ_WK_6_1,
IND_REQ_WK_7_1,
IND_REQ_WK_8_1,
IND_REQ_WK_9_1,
IND_REQ_WK_10_1,
IND_REQ_WK_11_1,
IND_REQ_WK_12_1
);

--2. GENERATE REPORT
DROP VIEW VIEW_INV_SAP_RCCP;
SELECT * FROM VIEW_INV_SAP_RCCP;
SELECT ID,
  MATERIAL,
  CATALOG_DASH,
  PLANT,
  MATERIAL_DES,
  MRP_CONTROLLER,
  MRP_TYPE,
  STRATEGY_GRP,
  SAFETY_STOCK,
  OH_QTY,
  UNIT,
  UNIT_COST,
  PROD_BU,
  PRODUCTION_PLANT,
  VENDOR,
  MIN_INV,
  TARGET_INV,
  MAX_INV,
  IND_REQ_AVG,
  IND_REQ_AVG_50,
  IND_REQ_AVG_25,
  IND_REQ_WEEK_0,
  IND_REQ_WEEK_1,
  IND_REQ_WEEK_2,
  IND_REQ_WEEK_3,
  IND_REQ_WEEK_4,
  IND_REQ_WEEK_5,
  IND_REQ_WEEK_6,
  IND_REQ_WEEK_7,
  IND_REQ_WEEK_8,
  IND_REQ_WEEK_9,
  IND_REQ_WEEK_10,
  IND_REQ_WEEK_11,
  IND_REQ_WEEK_12,
  FIRM_REQ_WEEK_0,
  FIRM_REQ_WEEK_1,
  FIRM_REQ_WEEK_2,
  FIRM_REQ_WEEK_3,
  FIRM_REQ_WEEK_4,
  FIRM_REQ_WEEK_5,
  FIRM_REQ_WEEK_6,
  FIRM_REQ_WEEK_7,
  FIRM_REQ_WEEK_8,
  FIRM_REQ_WEEK_9,
  FIRM_REQ_WEEK_10,
  FIRM_REQ_WEEK_11,
  FIRM_REQ_WEEK_12,
  TOT_REQ_WEEK_0,
  TOT_REQ_WEEK_1,
  TOT_REQ_WEEK_2,
  TOT_REQ_WEEK_3,
  TOT_REQ_WEEK_4,
  TOT_REQ_WEEK_5,
  TOT_REQ_WEEK_6,
  TOT_REQ_WEEK_7,
  TOT_REQ_WEEK_8,
  TOT_REQ_WEEK_9,
  TOT_REQ_WEEK_10,
  TOT_REQ_WEEK_11,
  TOT_REQ_WEEK_12,
  THREE_SIGMA,
  THREE_SIGMA_LOAD,
  TOT_PO_PLO_WEEK_0,
  TOT_PO_PLO_WEEK_1,
  TOT_PO_PLO_WEEK_2,
  TOT_PO_PLO_WEEK_3,
  TOT_PO_PLO_WEEK_4,
  TOT_PO_PLO_WEEK_5,
  TOT_PO_PLO_WEEK_6,
  TOT_PO_PLO_WEEK_7,
  TOT_PO_PLO_WEEK_8,
  TOT_PO_PLO_WEEK_9,
  TOT_PO_PLO_WEEK_10,
  TOT_PO_PLO_WEEK_11,
  TOT_PO_PLO_WEEK_12,
  OPEN_OP_WEEK_0,
  OPEN_OP_WEEK_1,
  OPEN_OP_WEEK_2,
  OPEN_OP_WEEK_3,
  OPEN_OP_WEEK_4,
  OPEN_OP_WEEK_5,
  OPEN_OP_WEEK_6,
  OPEN_OP_WEEK_7,
  OPEN_OP_WEEK_8,
  OPEN_OP_WEEK_9,
  OPEN_OP_WEEK_10,
  OPEN_OP_WEEK_11,
  OPEN_OP_WEEK_12,
  PLAN_OP_WEEK_0,
  PLAN_OP_WEEK_1,
  PLAN_OP_WEEK_2,
  PLAN_OP_WEEK_3,
  PLAN_OP_WEEK_4,
  PLAN_OP_WEEK_5,
  PLAN_OP_WEEK_6,
  PLAN_OP_WEEK_7,
  PLAN_OP_WEEK_8,
  PLAN_OP_WEEK_9,
  PLAN_OP_WEEK_10,
  PLAN_OP_WEEK_11,
  PLAN_OP_WEEK_12
FROM VIEW_INV_SAP_RCCP
WHERE UNIT NOT   IN ('IN')
AND KEY          <> 0
AND STRATEGY_GRP IN ('Z4','40');

DROP VIEW VIEW_INV_SAP_RCCP;
CREATE VIEW VIEW_INV_SAP_RCCP AS
SELECT BS_MCBZ_PO.ID                                                                                                                                                                                                                                                                                                                                                                                                                                AS ID,
  BS_MCBZ_PO.MATERIAL                                                                                                                                                                                                                                                                                                                                                                                                                               AS MATERIAL,
  BS_MCBZ_PO.CATALOG_DASH                                                                                                                                                                                                                                                                                                                                                                                                                           AS CATALOG_DASH,
  BS_MCBZ_PO.PLANT                                                                                                                                                                                                                                                                                                                                                                                                                                  AS PLANT,
  BS_MCBZ_PO.MATERIAL_DES                                                                                                                                                                                                                                                                                                                                                                                                                           AS MATERIAL_DES,
  BS_MCBZ_PO.MRP_CONTROLLER                                                                                                                                                                                                                                                                                                                                                                                                                         AS MRP_CONTROLLER,
  BS_MCBZ_PO.MRP_TYPE                                                                                                                                                                                                                                                                                                                                                                                                                               AS MRP_TYPE,
  BS_MCBZ_PO.STRATEGY_GRP                                                                                                                                                                                                                                                                                                                                                                                                                           AS STRATEGY_GRP,
  BS_MCBZ_PO.SAFETY_STOCK                                                                                                                                                                                                                                                                                                                                                                                                                           AS SAFETY_STOCK,
  BS_MCBZ_PO.OH_QTY                                                                                                                                                                                                                                                                                                                                                                                                                                 AS OH_QTY,
  BS_MCBZ_PO.UNIT                                                                                                                                                                                                                                                                                                                                                                                                                                   AS UNIT,
  BS_MCBZ_PO.UNIT_COST                                                                                                                                                                                                                                                                                                                                                                                                                              AS UNIT_COST,
  BS_MCBZ_PO.PROD_BU                                                                                                                                                                                                                                                                                                                                                                                                                                AS PROD_BU,
  BS_MCBZ_PO.PRODUCTION_PLANT                                                                                                                                                                                                                                                                                                                                                                                                                       AS PRODUCTION_PLANT,
  BS_MCBZ_PO.VENDOR                                                                                                                                                                                                                                                                                                                                                                                                                                 AS VENDOR,
  BS_MCBZ_PO.MIN_INV                                                                                                                                                                                                                                                                                                                                                                                                                                AS MIN_INV,
  BS_MCBZ_PO.TARGET_INV                                                                                                                                                                                                                                                                                                                                                                                                                             AS TARGET_INV,
  BS_MCBZ_PO.MAX_INV                                                                                                                                                                                                                                                                                                                                                                                                                                AS MAX_INV,
  0                                                                                                                                                                                                                                                                                                                                                                                                                                                 AS Ind_Req_AVG,
  0                                                                                                                                                                                                                                                                                                                                                                                                                                                 AS Ind_Req_AVG_50,
  0                                                                                                                                                                                                                                                                                                                                                                                                                                                 AS Ind_Req_AVG_25,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_0,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS IND_REQ_WEEK_0,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_1,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS IND_REQ_WEEK_1,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_2,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS IND_REQ_WEEK_2,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_3,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS IND_REQ_WEEK_3,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_4,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS IND_REQ_WEEK_4,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_5,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS IND_REQ_WEEK_5,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_6,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS IND_REQ_WEEK_6,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_7,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS IND_REQ_WEEK_7,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_8,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS IND_REQ_WEEK_8,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_9,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS IND_REQ_WEEK_9,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_10,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS IND_REQ_WEEK_10,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_11,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS IND_REQ_WEEK_11,
  NVL(BS_MCBZ_PO.IND_REQ_WEEK_12,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS IND_REQ_WEEK_12,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_0,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS FIRM_REQ_WEEK_0,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_1,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS FIRM_REQ_WEEK_1,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_2,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS FIRM_REQ_WEEK_2,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_3,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS FIRM_REQ_WEEK_3,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_4,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS FIRM_REQ_WEEK_4,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_5,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS FIRM_REQ_WEEK_5,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_6,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS FIRM_REQ_WEEK_6,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_7,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS FIRM_REQ_WEEK_7,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_8,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS FIRM_REQ_WEEK_8,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_9,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS FIRM_REQ_WEEK_9,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_10,0)                                                                                                                                                                                                                                                                                                                                                                                                                AS FIRM_REQ_WEEK_10,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_11,0)                                                                                                                                                                                                                                                                                                                                                                                                                AS FIRM_REQ_WEEK_11,
  NVL(BS_MCBZ_PO.FIRM_REQ_WEEK_12,0)                                                                                                                                                                                                                                                                                                                                                                                                                AS FIRM_REQ_WEEK_12,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_0,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS TOT_REQ_WEEK_0,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_1,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS TOT_REQ_WEEK_1,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_2,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS TOT_REQ_WEEK_2,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_3,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS TOT_REQ_WEEK_3,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_4,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS TOT_REQ_WEEK_4,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_5,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS TOT_REQ_WEEK_5,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_6,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS TOT_REQ_WEEK_6,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_7,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS TOT_REQ_WEEK_7,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_8,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS TOT_REQ_WEEK_8,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_9,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS TOT_REQ_WEEK_9,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_10,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS TOT_REQ_WEEK_10,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_11,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS TOT_REQ_WEEK_11,
  NVL(BS_MCBZ_PO.TOT_REQ_WEEK_12,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS TOT_REQ_WEEK_12,
  0                                                                                                                                                                                                                                                                                                                                                                                                                                                 AS Three_Sigma,
  0                                                                                                                                                                                                                                                                                                                                                                                                                                                 AS Three_Sigma_Load,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_0,0)  + NVL(OPEN_PLAN.PLAN_OP_WEEK_0,0)                                                                                                                                                                                                                                                                                                                                                                               AS TOT_PO_PLO_WEEK_0,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_1,0)  + NVL(OPEN_PLAN.PLAN_OP_WEEK_1,0)                                                                                                                                                                                                                                                                                                                                                                               AS TOT_PO_PLO_WEEK_1,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_2,0)  + NVL(OPEN_PLAN.PLAN_OP_WEEK_2,0)                                                                                                                                                                                                                                                                                                                                                                               AS TOT_PO_PLO_WEEK_2,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_3,0)  + NVL(OPEN_PLAN.PLAN_OP_WEEK_3,0)                                                                                                                                                                                                                                                                                                                                                                               AS TOT_PO_PLO_WEEK_3,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_4,0)  + NVL(OPEN_PLAN.PLAN_OP_WEEK_4,0)                                                                                                                                                                                                                                                                                                                                                                               AS TOT_PO_PLO_WEEK_4,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_5,0)  + NVL(OPEN_PLAN.PLAN_OP_WEEK_5,0)                                                                                                                                                                                                                                                                                                                                                                               AS TOT_PO_PLO_WEEK_5,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_6,0)  + NVL(OPEN_PLAN.PLAN_OP_WEEK_6,0)                                                                                                                                                                                                                                                                                                                                                                               AS TOT_PO_PLO_WEEK_6,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_7,0)  + NVL(OPEN_PLAN.PLAN_OP_WEEK_7,0)                                                                                                                                                                                                                                                                                                                                                                               AS TOT_PO_PLO_WEEK_7,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_8,0)  + NVL(OPEN_PLAN.PLAN_OP_WEEK_8,0)                                                                                                                                                                                                                                                                                                                                                                               AS TOT_PO_PLO_WEEK_8,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_9,0)  + NVL(OPEN_PLAN.PLAN_OP_WEEK_9,0)                                                                                                                                                                                                                                                                                                                                                                               AS TOT_PO_PLO_WEEK_9,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_10,0) + NVL(OPEN_PLAN.PLAN_OP_WEEK_10,0)                                                                                                                                                                                                                                                                                                                                                                              AS TOT_PO_PLO_WEEK_10,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_11,0) + NVL(OPEN_PLAN.PLAN_OP_WEEK_11,0)                                                                                                                                                                                                                                                                                                                                                                              AS TOT_PO_PLO_WEEK_11,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_12,0) + NVL(OPEN_PLAN.PLAN_OP_WEEK_12,0)                                                                                                                                                                                                                                                                                                                                                                              AS TOT_PO_PLO_WEEK_12,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_0,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS OPEN_OP_WEEK_0,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_1,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS OPEN_OP_WEEK_1,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_2,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS OPEN_OP_WEEK_2,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_3,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS OPEN_OP_WEEK_3,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_4,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS OPEN_OP_WEEK_4,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_5,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS OPEN_OP_WEEK_5,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_6,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS OPEN_OP_WEEK_6,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_7,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS OPEN_OP_WEEK_7,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_8,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS OPEN_OP_WEEK_8,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_9,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS OPEN_OP_WEEK_9,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_10,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS OPEN_OP_WEEK_10,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_11,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS OPEN_OP_WEEK_11,
  NVL(BS_MCBZ_PO.OPEN_OP_WEEK_12,0)                                                                                                                                                                                                                                                                                                                                                                                                                 AS OPEN_OP_WEEK_12,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_0,0)                                                                                                                                                                                                                                                                                                                                                                                                                   AS PLAN_OP_WEEK_0,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_1,0)                                                                                                                                                                                                                                                                                                                                                                                                                   AS PLAN_OP_WEEK_1,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_2,0)                                                                                                                                                                                                                                                                                                                                                                                                                   AS PLAN_OP_WEEK_2,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_3,0)                                                                                                                                                                                                                                                                                                                                                                                                                   AS PLAN_OP_WEEK_3,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_4,0)                                                                                                                                                                                                                                                                                                                                                                                                                   AS PLAN_OP_WEEK_4,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_5,0)                                                                                                                                                                                                                                                                                                                                                                                                                   AS PLAN_OP_WEEK_5,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_6,0)                                                                                                                                                                                                                                                                                                                                                                                                                   AS PLAN_OP_WEEK_6,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_7,0)                                                                                                                                                                                                                                                                                                                                                                                                                   AS PLAN_OP_WEEK_7,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_8,0)                                                                                                                                                                                                                                                                                                                                                                                                                   AS PLAN_OP_WEEK_8,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_9,0)                                                                                                                                                                                                                                                                                                                                                                                                                   AS PLAN_OP_WEEK_9,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_10,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS PLAN_OP_WEEK_10,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_11,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS PLAN_OP_WEEK_11,
  NVL(OPEN_PLAN.PLAN_OP_WEEK_12,0)                                                                                                                                                                                                                                                                                                                                                                                                                  AS PLAN_OP_WEEK_12,
  (NVL(BS_MCBZ_PO.TOT_REQ_WEEK_0,0)+NVL(BS_MCBZ_PO.TOT_REQ_WEEK_1,0)+NVL(BS_MCBZ_PO.TOT_REQ_WEEK_2,0)+NVL(BS_MCBZ_PO.TOT_REQ_WEEK_3,0)+NVL(BS_MCBZ_PO.TOT_REQ_WEEK_4,0)+NVL(BS_MCBZ_PO.TOT_REQ_WEEK_5,0)+NVL(BS_MCBZ_PO.TOT_REQ_WEEK_6,0)+NVL(BS_MCBZ_PO.TOT_REQ_WEEK_7,0)+NVL(BS_MCBZ_PO.TOT_REQ_WEEK_8,0)+NVL(BS_MCBZ_PO.TOT_REQ_WEEK_9,0)+NVL(BS_MCBZ_PO.TOT_REQ_WEEK_10,0)+NVL(BS_MCBZ_PO.TOT_REQ_WEEK_11,0)+NVL(BS_MCBZ_PO.TOT_REQ_WEEK_12,0)) AS KEY
FROM
  (SELECT BS_MCBZ_TOT_IND_FIRM.ID         AS ID,
    BS_MCBZ_TOT_IND_FIRM.MATERIAL         AS MATERIAL,
    BS_MCBZ_TOT_IND_FIRM.CATALOG_DASH     AS CATALOG_DASH,
    BS_MCBZ_TOT_IND_FIRM.PLANT            AS PLANT,
    BS_MCBZ_TOT_IND_FIRM.MATERIAL_DES     AS MATERIAL_DES,
    BS_MCBZ_TOT_IND_FIRM.MRP_CONTROLLER   AS MRP_CONTROLLER,
    BS_MCBZ_TOT_IND_FIRM.MRP_TYPE         AS MRP_TYPE,
    BS_MCBZ_TOT_IND_FIRM.STRATEGY_GRP     AS STRATEGY_GRP,
    BS_MCBZ_TOT_IND_FIRM.SAFETY_STOCK     AS SAFETY_STOCK,
    BS_MCBZ_TOT_IND_FIRM.OH_QTY           AS OH_QTY,
    BS_MCBZ_TOT_IND_FIRM.UNIT             AS UNIT,
    BS_MCBZ_TOT_IND_FIRM.UNIT_COST        AS UNIT_COST,
    BS_MCBZ_TOT_IND_FIRM.PROD_BU          AS PROD_BU,
    BS_MCBZ_TOT_IND_FIRM.PRODUCTION_PLANT AS PRODUCTION_PLANT,
    BS_MCBZ_TOT_IND_FIRM.VENDOR           AS VENDOR,
    BS_MCBZ_TOT_IND_FIRM.MIN_INV          AS MIN_INV,
    BS_MCBZ_TOT_IND_FIRM.TARGET_INV       AS TARGET_INV,
    BS_MCBZ_TOT_IND_FIRM.MAX_INV          AS MAX_INV,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_0   AS TOT_REQ_WEEK_0,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_1   AS TOT_REQ_WEEK_1,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_2   AS TOT_REQ_WEEK_2,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_3   AS TOT_REQ_WEEK_3,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_4   AS TOT_REQ_WEEK_4,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_5   AS TOT_REQ_WEEK_5,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_6   AS TOT_REQ_WEEK_6,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_7   AS TOT_REQ_WEEK_7,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_8   AS TOT_REQ_WEEK_8,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_9   AS TOT_REQ_WEEK_9,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_10  AS TOT_REQ_WEEK_10,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_11  AS TOT_REQ_WEEK_11,
    BS_MCBZ_TOT_IND_FIRM.TOT_REQ_WEEK_12  AS TOT_REQ_WEEK_12,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_0   AS IND_REQ_WEEK_0,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_1   AS IND_REQ_WEEK_1,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_2   AS IND_REQ_WEEK_2,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_3   AS IND_REQ_WEEK_3,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_4   AS IND_REQ_WEEK_4,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_5   AS IND_REQ_WEEK_5,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_6   AS IND_REQ_WEEK_6,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_7   AS IND_REQ_WEEK_7,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_8   AS IND_REQ_WEEK_8,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_9   AS IND_REQ_WEEK_9,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_10  AS IND_REQ_WEEK_10,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_11  AS IND_REQ_WEEK_11,
    BS_MCBZ_TOT_IND_FIRM.IND_REQ_WEEK_12  AS IND_REQ_WEEK_12,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_0  AS FIRM_REQ_WEEK_0,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_1  AS FIRM_REQ_WEEK_1,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_2  AS FIRM_REQ_WEEK_2,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_3  AS FIRM_REQ_WEEK_3,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_4  AS FIRM_REQ_WEEK_4,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_5  AS FIRM_REQ_WEEK_5,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_6  AS FIRM_REQ_WEEK_6,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_7  AS FIRM_REQ_WEEK_7,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_8  AS FIRM_REQ_WEEK_8,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_9  AS FIRM_REQ_WEEK_9,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_10 AS FIRM_REQ_WEEK_10,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_11 AS FIRM_REQ_WEEK_11,
    BS_MCBZ_TOT_IND_FIRM.FIRM_REQ_WEEK_12 AS FIRM_REQ_WEEK_12,
    OPEN_PO.OPEN_OP_WEEK_0                AS OPEN_OP_WEEK_0,
    OPEN_PO.OPEN_OP_WEEK_1                AS OPEN_OP_WEEK_1,
    OPEN_PO.OPEN_OP_WEEK_2                AS OPEN_OP_WEEK_2,
    OPEN_PO.OPEN_OP_WEEK_3                AS OPEN_OP_WEEK_3,
    OPEN_PO.OPEN_OP_WEEK_4                AS OPEN_OP_WEEK_4,
    OPEN_PO.OPEN_OP_WEEK_5                AS OPEN_OP_WEEK_5,
    OPEN_PO.OPEN_OP_WEEK_6                AS OPEN_OP_WEEK_6,
    OPEN_PO.OPEN_OP_WEEK_7                AS OPEN_OP_WEEK_7,
    OPEN_PO.OPEN_OP_WEEK_8                AS OPEN_OP_WEEK_8,
    OPEN_PO.OPEN_OP_WEEK_9                AS OPEN_OP_WEEK_9,
    OPEN_PO.OPEN_OP_WEEK_10               AS OPEN_OP_WEEK_10,
    OPEN_PO.OPEN_OP_WEEK_11               AS OPEN_OP_WEEK_11,
    OPEN_PO.OPEN_OP_WEEK_12               AS OPEN_OP_WEEK_12
  FROM
    (SELECT BS_MCBZ_TOT_IND.ID         AS ID,
      BS_MCBZ_TOT_IND.MATERIAL         AS MATERIAL,
      BS_MCBZ_TOT_IND.CATALOG_DASH     AS CATALOG_DASH,
      BS_MCBZ_TOT_IND.PLANT            AS PLANT,
      BS_MCBZ_TOT_IND.MATERIAL_DES     AS MATERIAL_DES,
      BS_MCBZ_TOT_IND.MRP_CONTROLLER   AS MRP_CONTROLLER,
      BS_MCBZ_TOT_IND.MRP_TYPE         AS MRP_TYPE,
      BS_MCBZ_TOT_IND.STRATEGY_GRP     AS STRATEGY_GRP,
      BS_MCBZ_TOT_IND.SAFETY_STOCK     AS SAFETY_STOCK,
      BS_MCBZ_TOT_IND.OH_QTY           AS OH_QTY,
      BS_MCBZ_TOT_IND.UNIT             AS UNIT,
      BS_MCBZ_TOT_IND.UNIT_COST        AS UNIT_COST,
      BS_MCBZ_TOT_IND.PROD_BU          AS PROD_BU,
      BS_MCBZ_TOT_IND.PRODUCTION_PLANT AS PRODUCTION_PLANT,
      BS_MCBZ_TOT_IND.VENDOR           AS VENDOR,
      BS_MCBZ_TOT_IND.MIN_INV          AS MIN_INV,
      BS_MCBZ_TOT_IND.TARGET_INV       AS TARGET_INV,
      BS_MCBZ_TOT_IND.MAX_INV          AS MAX_INV,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_0   AS TOT_REQ_WEEK_0,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_1   AS TOT_REQ_WEEK_1,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_2   AS TOT_REQ_WEEK_2,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_3   AS TOT_REQ_WEEK_3,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_4   AS TOT_REQ_WEEK_4,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_5   AS TOT_REQ_WEEK_5,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_6   AS TOT_REQ_WEEK_6,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_7   AS TOT_REQ_WEEK_7,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_8   AS TOT_REQ_WEEK_8,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_9   AS TOT_REQ_WEEK_9,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_10  AS TOT_REQ_WEEK_10,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_11  AS TOT_REQ_WEEK_11,
      BS_MCBZ_TOT_IND.TOT_REQ_WEEK_12  AS TOT_REQ_WEEK_12,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_0   AS IND_REQ_WEEK_0,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_1   AS IND_REQ_WEEK_1,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_2   AS IND_REQ_WEEK_2,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_3   AS IND_REQ_WEEK_3,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_4   AS IND_REQ_WEEK_4,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_5   AS IND_REQ_WEEK_5,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_6   AS IND_REQ_WEEK_6,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_7   AS IND_REQ_WEEK_7,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_8   AS IND_REQ_WEEK_8,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_9   AS IND_REQ_WEEK_9,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_10  AS IND_REQ_WEEK_10,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_11  AS IND_REQ_WEEK_11,
      BS_MCBZ_TOT_IND.IND_REQ_WEEK_12  AS IND_REQ_WEEK_12,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_0    AS FIRM_REQ_WEEK_0,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_1    AS FIRM_REQ_WEEK_1,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_2    AS FIRM_REQ_WEEK_2,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_3    AS FIRM_REQ_WEEK_3,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_4    AS FIRM_REQ_WEEK_4,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_5    AS FIRM_REQ_WEEK_5,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_6    AS FIRM_REQ_WEEK_6,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_7    AS FIRM_REQ_WEEK_7,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_8    AS FIRM_REQ_WEEK_8,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_9    AS FIRM_REQ_WEEK_9,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_10   AS FIRM_REQ_WEEK_10,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_11   AS FIRM_REQ_WEEK_11,
      REQ_MCBZ_FIRM.FIRM_REQ_WEEK_12   AS FIRM_REQ_WEEK_12
    FROM
      (SELECT BS_MCBZ_TOT.ID         AS ID,
        BS_MCBZ_TOT.MATERIAL         AS MATERIAL,
        BS_MCBZ_TOT.CATALOG_DASH     AS CATALOG_DASH,
        BS_MCBZ_TOT.PLANT            AS PLANT,
        BS_MCBZ_TOT.MATERIAL_DES     AS MATERIAL_DES,
        BS_MCBZ_TOT.MRP_CONTROLLER   AS MRP_CONTROLLER,
        BS_MCBZ_TOT.MRP_TYPE         AS MRP_TYPE,
        BS_MCBZ_TOT.STRATEGY_GRP     AS STRATEGY_GRP,
        BS_MCBZ_TOT.SAFETY_STOCK     AS SAFETY_STOCK,
        BS_MCBZ_TOT.OH_QTY           AS OH_QTY,
        BS_MCBZ_TOT.UNIT             AS UNIT,
        BS_MCBZ_TOT.UNIT_COST        AS UNIT_COST,
        BS_MCBZ_TOT.PROD_BU          AS PROD_BU,
        BS_MCBZ_TOT.PRODUCTION_PLANT AS PRODUCTION_PLANT,
        BS_MCBZ_TOT.VENDOR           AS VENDOR,
        BS_MCBZ_TOT.MIN_INV          AS MIN_INV,
        BS_MCBZ_TOT.TARGET_INV       AS TARGET_INV,
        BS_MCBZ_TOT.MAX_INV          AS MAX_INV,
        BS_MCBZ_TOT.TOT_REQ_WEEK_0   AS TOT_REQ_WEEK_0,
        BS_MCBZ_TOT.TOT_REQ_WEEK_1   AS TOT_REQ_WEEK_1,
        BS_MCBZ_TOT.TOT_REQ_WEEK_2   AS TOT_REQ_WEEK_2,
        BS_MCBZ_TOT.TOT_REQ_WEEK_3   AS TOT_REQ_WEEK_3,
        BS_MCBZ_TOT.TOT_REQ_WEEK_4   AS TOT_REQ_WEEK_4,
        BS_MCBZ_TOT.TOT_REQ_WEEK_5   AS TOT_REQ_WEEK_5,
        BS_MCBZ_TOT.TOT_REQ_WEEK_6   AS TOT_REQ_WEEK_6,
        BS_MCBZ_TOT.TOT_REQ_WEEK_7   AS TOT_REQ_WEEK_7,
        BS_MCBZ_TOT.TOT_REQ_WEEK_8   AS TOT_REQ_WEEK_8,
        BS_MCBZ_TOT.TOT_REQ_WEEK_9   AS TOT_REQ_WEEK_9,
        BS_MCBZ_TOT.TOT_REQ_WEEK_10  AS TOT_REQ_WEEK_10,
        BS_MCBZ_TOT.TOT_REQ_WEEK_11  AS TOT_REQ_WEEK_11,
        BS_MCBZ_TOT.TOT_REQ_WEEK_12  AS TOT_REQ_WEEK_12,
        REQ_MCBZ_IND.IND_REQ_WEEK_0  AS IND_REQ_WEEK_0,
        REQ_MCBZ_IND.IND_REQ_WEEK_1  AS IND_REQ_WEEK_1,
        REQ_MCBZ_IND.IND_REQ_WEEK_2  AS IND_REQ_WEEK_2,
        REQ_MCBZ_IND.IND_REQ_WEEK_3  AS IND_REQ_WEEK_3,
        REQ_MCBZ_IND.IND_REQ_WEEK_4  AS IND_REQ_WEEK_4,
        REQ_MCBZ_IND.IND_REQ_WEEK_5  AS IND_REQ_WEEK_5,
        REQ_MCBZ_IND.IND_REQ_WEEK_6  AS IND_REQ_WEEK_6,
        REQ_MCBZ_IND.IND_REQ_WEEK_7  AS IND_REQ_WEEK_7,
        REQ_MCBZ_IND.IND_REQ_WEEK_8  AS IND_REQ_WEEK_8,
        REQ_MCBZ_IND.IND_REQ_WEEK_9  AS IND_REQ_WEEK_9,
        REQ_MCBZ_IND.IND_REQ_WEEK_10 AS IND_REQ_WEEK_10,
        REQ_MCBZ_IND.IND_REQ_WEEK_11 AS IND_REQ_WEEK_11,
        REQ_MCBZ_IND.IND_REQ_WEEK_12 AS IND_REQ_WEEK_12
      FROM
        (SELECT RCCP_BASIC_IND.ID         AS ID,
          RCCP_BASIC_IND.MATERIAL         AS MATERIAL,
          RCCP_BASIC_IND.CATALOG_DASH     AS CATALOG_DASH,
          RCCP_BASIC_IND.PLANT            AS PLANT,
          RCCP_BASIC_IND.MATERIAL_DES     AS MATERIAL_DES,
          RCCP_BASIC_IND.MRP_CONTROLLER   AS MRP_CONTROLLER,
          RCCP_BASIC_IND.MRP_TYPE         AS MRP_TYPE,
          RCCP_BASIC_IND.STRATEGY_GRP     AS STRATEGY_GRP,
          RCCP_BASIC_IND.SAFETY_STOCK     AS SAFETY_STOCK,
          RCCP_BASIC_IND.OH_QTY           AS OH_QTY,
          RCCP_BASIC_IND.UNIT             AS UNIT,
          RCCP_BASIC_IND.UNIT_COST        AS UNIT_COST,
          RCCP_BASIC_IND.PROD_BU          AS PROD_BU,
          RCCP_BASIC_IND.PRODUCTION_PLANT AS PRODUCTION_PLANT,
          RCCP_BASIC_IND.VENDOR           AS VENDOR,
          RCCP_BASIC_IND.MIN_INV          AS MIN_INV,
          RCCP_BASIC_IND.TARGET_INV       AS TARGET_INV,
          RCCP_BASIC_IND.MAX_INV          AS MAX_INV,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_0     AS TOT_REQ_WEEK_0,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_1     AS TOT_REQ_WEEK_1,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_2     AS TOT_REQ_WEEK_2,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_3     AS TOT_REQ_WEEK_3,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_4     AS TOT_REQ_WEEK_4,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_5     AS TOT_REQ_WEEK_5,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_6     AS TOT_REQ_WEEK_6,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_7     AS TOT_REQ_WEEK_7,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_8     AS TOT_REQ_WEEK_8,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_9     AS TOT_REQ_WEEK_9,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_10    AS TOT_REQ_WEEK_10,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_11    AS TOT_REQ_WEEK_11,
          REQ_MCBZ_TOT.TOT_REQ_WEEK_12    AS TOT_REQ_WEEK_12
        FROM
          (SELECT ID        AS ID,
            MATERIAL        AS MATERIAL,
            CATALOG_DASH    AS CATALOG_DASH,
            PLANT           AS PLANT,
            MAT_DESC        AS MATERIAL_DES,
            MRP_CONTROLLER  AS MRP_CONTROLLER,
            MRP_TYPE        AS MRP_TYPE,
            STRATEGY_GRP    AS STRATEGY_GRP,
            SAFETY_STOCK    AS SAFETY_STOCK,
            OH_QTY          AS OH_QTY,
            UNIT            AS UNIT,
            UNIT_COST       AS UNIT_COST,
            PROD_BU         AS PROD_BU,
            ULTIMATE_SOURCE AS PRODUCTION_PLANT,
            VENDOR_KEY      AS VENDOR,
            MIN_INV         AS MIN_INV,
            TARGET_INV      AS TARGET_INV,
            MAX_INV         AS MAX_INV
          FROM VIEW_INV_SAP_PP_OPT_X
          WHERE PLANT   IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
          AND MATL_TYPE IN ('ZTG','ZFG')
          )RCCP_BASIC_IND
        LEFT JOIN
          (SELECT MATERIAL
            ||'_'
            ||PLANT AS ID,
            PLANT,
            MATERIAL,
            SUM(IND_REQ_WK_0)  AS TOT_REQ_WEEK_0,
            SUM(IND_REQ_WK_1)  AS TOT_REQ_WEEK_1,
            SUM(IND_REQ_WK_2)  AS TOT_REQ_WEEK_2,
            SUM(IND_REQ_WK_3)  AS TOT_REQ_WEEK_3,
            SUM(IND_REQ_WK_4)  AS TOT_REQ_WEEK_4,
            SUM(IND_REQ_WK_5)  AS TOT_REQ_WEEK_5,
            SUM(IND_REQ_WK_6)  AS TOT_REQ_WEEK_6,
            SUM(IND_REQ_WK_7)  AS TOT_REQ_WEEK_7,
            SUM(IND_REQ_WK_8)  AS TOT_REQ_WEEK_8,
            SUM(IND_REQ_WK_9)  AS TOT_REQ_WEEK_9,
            SUM(IND_REQ_WK_10) AS TOT_REQ_WEEK_10,
            SUM(IND_REQ_WK_11) AS TOT_REQ_WEEK_11,
            SUM(IND_REQ_WK_12) AS TOT_REQ_WEEK_12
          FROM INV_SAP_RCCP_INDREQ
          GROUP BY PLANT,
            MATERIAL
          )REQ_MCBZ_TOT
        ON REQ_MCBZ_TOT.ID = RCCP_BASIC_IND.ID
        )BS_MCBZ_TOT
      LEFT JOIN
        (SELECT MATERIAL
          ||'_'
          ||PLANT AS ID,
          PLANT,
          MAP_CONTROLLER,
          MATERIAL,
          ELEMENT_INDICATOR,
          IND_REQ_WK_0  AS IND_REQ_WEEK_0,
          IND_REQ_WK_1  AS IND_REQ_WEEK_1,
          IND_REQ_WK_2  AS IND_REQ_WEEK_2,
          IND_REQ_WK_3  AS IND_REQ_WEEK_3,
          IND_REQ_WK_4  AS IND_REQ_WEEK_4,
          IND_REQ_WK_5  AS IND_REQ_WEEK_5,
          IND_REQ_WK_6  AS IND_REQ_WEEK_6,
          IND_REQ_WK_7  AS IND_REQ_WEEK_7,
          IND_REQ_WK_8  AS IND_REQ_WEEK_8,
          IND_REQ_WK_9  AS IND_REQ_WEEK_9,
          IND_REQ_WK_10 AS IND_REQ_WEEK_10,
          IND_REQ_WK_11 AS IND_REQ_WEEK_11,
          IND_REQ_WK_12 AS IND_REQ_WEEK_12
        FROM INV_SAP_RCCP_INDREQ
        WHERE ELEMENT_INDICATOR = 'PP'
        )REQ_MCBZ_IND
      ON REQ_MCBZ_IND.ID = BS_MCBZ_TOT.ID
      )BS_MCBZ_TOT_IND
    LEFT JOIN
      (SELECT MATERIAL
        ||'_'
        ||PLANT AS ID,
        PLANT,
        MATERIAL,
        SUM(IND_REQ_WK_0)  AS FIRM_REQ_WEEK_0,
        SUM(IND_REQ_WK_1)  AS FIRM_REQ_WEEK_1,
        SUM(IND_REQ_WK_2)  AS FIRM_REQ_WEEK_2,
        SUM(IND_REQ_WK_3)  AS FIRM_REQ_WEEK_3,
        SUM(IND_REQ_WK_4)  AS FIRM_REQ_WEEK_4,
        SUM(IND_REQ_WK_5)  AS FIRM_REQ_WEEK_5,
        SUM(IND_REQ_WK_6)  AS FIRM_REQ_WEEK_6,
        SUM(IND_REQ_WK_7)  AS FIRM_REQ_WEEK_7,
        SUM(IND_REQ_WK_8)  AS FIRM_REQ_WEEK_8,
        SUM(IND_REQ_WK_9)  AS FIRM_REQ_WEEK_9,
        SUM(IND_REQ_WK_10) AS FIRM_REQ_WEEK_10,
        SUM(IND_REQ_WK_11) AS FIRM_REQ_WEEK_11,
        SUM(IND_REQ_WK_12) AS FIRM_REQ_WEEK_12
      FROM INV_SAP_RCCP_INDREQ
      WHERE ELEMENT_INDICATOR IN ('VC','VI','VJ')
      GROUP BY PLANT,
        MATERIAL
      )REQ_MCBZ_FIRM
    ON REQ_MCBZ_FIRM.ID = BS_MCBZ_TOT_IND.ID
    )BS_MCBZ_TOT_IND_FIRM
  LEFT JOIN
    (SELECT ID,
      MATERIALID,
      SUM(WEEK_1)  AS OPEN_OP_WEEK_0,
      SUM(WEEK_2)  AS OPEN_OP_WEEK_1,
      SUM(WEEK_3)  AS OPEN_OP_WEEK_2,
      SUM(WEEK_4)  AS OPEN_OP_WEEK_3,
      SUM(WEEK_5)  AS OPEN_OP_WEEK_4,
      SUM(WEEK_6)  AS OPEN_OP_WEEK_5,
      SUM(WEEK_7)  AS OPEN_OP_WEEK_6,
      SUM(WEEK_8)  AS OPEN_OP_WEEK_7,
      SUM(WEEK_9)  AS OPEN_OP_WEEK_8,
      SUM(WEEK_10) AS OPEN_OP_WEEK_9,
      SUM(WEEK_11) AS OPEN_OP_WEEK_10,
      SUM(WEEK_12) AS OPEN_OP_WEEK_11,
      SUM(WEEK_13) AS OPEN_OP_WEEK_12
    FROM
      (SELECT ID,
        MATERIALID,
        PLANTID,
        CASE
          WHEN WEEK_NUMBER <= TO_CHAR(SYSDATE,'iw')
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_1,
        CASE
          WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 1
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_2,
        CASE
          WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 2
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_3,
        CASE
          WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 3
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_4,
        CASE
          WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 4
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_5,
        CASE
          WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 5
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_6,
        CASE
          WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 6
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_7,
        CASE
          WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 7
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_8,
        CASE
          WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 8
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_9,
        CASE
          WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 9
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_10,
        CASE
          WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 10
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_11,
        CASE
          WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 11
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_12,
        CASE
          WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 12
          THEN OPEN_PO_QTY
          ELSE 0
        END WEEK_13
      FROM
        (SELECT MATERIALID
          ||'_'
          ||PLANTID AS ID,
          MATERIALID,
          PLANTID,
          TO_CHAR(SLFDTSTATDELIVERYDATE,'iw') AS WEEK_NUMBER,
          COMMITTEDQTY                 AS OPEN_PO_QTY
        FROM INV_SAP_PP_PO_HISTORY
        WHERE BSART_PURCHDOCTYPE      IN ('ZST','ZNB')
        AND ELIKZDELIVERYCOMPLETEDIND IS NULL
        AND SLFDTSTATDELIVERYDATE             < TO_CHAR(sysdate + 91)
        )
      )
    GROUP BY ID,
      MATERIALID
    )OPEN_PO
  ON OPEN_PO.ID = BS_MCBZ_TOT_IND_FIRM.ID
  )BS_MCBZ_PO
LEFT JOIN
  (SELECT ID,
    MATERIALID,
    SUM(WEEK_1)  AS PLAN_OP_WEEK_0,
    SUM(WEEK_2)  AS PLAN_OP_WEEK_1,
    SUM(WEEK_3)  AS PLAN_OP_WEEK_2,
    SUM(WEEK_4)  AS PLAN_OP_WEEK_3,
    SUM(WEEK_5)  AS PLAN_OP_WEEK_4,
    SUM(WEEK_6)  AS PLAN_OP_WEEK_5,
    SUM(WEEK_7)  AS PLAN_OP_WEEK_6,
    SUM(WEEK_8)  AS PLAN_OP_WEEK_7,
    SUM(WEEK_9)  AS PLAN_OP_WEEK_8,
    SUM(WEEK_10) AS PLAN_OP_WEEK_9,
    SUM(WEEK_11) AS PLAN_OP_WEEK_10,
    SUM(WEEK_12) AS PLAN_OP_WEEK_11,
    SUM(WEEK_13) AS PLAN_OP_WEEK_12
  FROM
    (SELECT ID,
      MATERIALID,
      PLANTID,
      CASE
        WHEN WEEK_NUMBER <= TO_CHAR(SYSDATE,'iw')
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_1,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 1
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_2,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 2
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_3,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 3
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_4,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 4
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_5,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 5
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_6,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 6
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_7,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 7
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_8,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 8
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_9,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 9
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_10,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 10
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_11,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 11
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_12,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 12
        THEN OPEN_PLAN_QTY
        ELSE 0
      END WEEK_13
    FROM
      (SELECT MATERIALID
        ||'_'
        ||PLANTID AS ID,
        MATERIALID,
        PLANTID,
        TO_CHAR(DATEDELIVERY,'iw') AS WEEK_NUMBER,
        PONUMBER,
        PO_OPENQTY AS OPEN_PLAN_QTY
      FROM INV_SAP_IO_INPUTS_DAILY
      WHERE INPUT_TYPE = 'PLAN_PD_PO'
      AND DATEDELIVERY < TO_CHAR(sysdate + 91)
      )
    )
  GROUP BY ID,
    MATERIALID
  )OPEN_PLAN
ON BS_MCBZ_PO.ID = OPEN_PLAN.ID;