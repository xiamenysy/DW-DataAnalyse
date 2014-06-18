--RCCP REPORT
--6/14/2014
--AUTHOR: HUANG MOYUE
--'5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140'
--OUTPUT, INPUT FOR TOTAL REQUIREMENT AND PO+PLAN ORDER
--Firm Customer Requirements
----SHOPPING CART
--IndReq
--vse/vsf
---How to calculate the week number.
---SELECT TO_CHAR(SYSDATE,'iw') AS weekn,
--  TO_CHAR(to_date('20050425','yyyymmdd'),'iw')      AS week1
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
  
  
  AND MATERIALID = '100-C09D10 A' AND PLANTID = '5040'
----------------------------------------------------------VIEW FOR RCCP-------------------------------------------------
DROP VIEW VIEW_INV_SAP_RCCP;
DROP TABLE INV_SAP_RCCP;
CREATE TABLE INV_SAP_RCCP AS 
SELECT * FROM VIEW_INV_SAP_RCCP where id = '100-C09D10 A_5040';
SELECT * FROM INV_SAP_RCCP where id = '1756-IB16 A_5040';

CREATE VIEW VIEW_INV_SAP_RCCP AS
SELECT RCCP.ID        AS ID,
  SYSDATE             AS LAST_REVIEW,
  RCCP.MATERIAL       AS MATERIAL,
  RCCP.CATALOG_DASH   AS CATALOG_DASH,
  RCCP.PLANT          AS PLANT,
  RCCP.MATERIAL_DES   AS MATERIAL_DES,
  RCCP.MRP_CONTROLLER AS MRP_CONTROLLER,
  RCCP.STRATEGY_GRP   AS STRATEGY_GRP,
  RCCP.SAFETY_STOCK   AS SAFETY_STOCK,
  RCCP.OH_QTY         AS OH_QTY,
  RCCP.UNIT           AS UNIT,
  RCCP.UNIT_COST      AS UNIT_COST,
  RCCP.PROD_BU        AS PROD_BU,
  RCCP.SP             AS SP,
  RCCP.VENDOR         AS VENDOR,
  RCCP.MIN_INV        AS MIN_INV,
  RCCP.TARGET_INV     AS TARGET_INV,
  RCCP.MAX_INV        AS MAX_INV,
  RCCP.Ind_Req_AVG,
  RCCP.Ind_Req_AVG_50,
  RCCP.Ind_Req_AVG_25,
  NVL(RCCP.Ind_Req_Week_1,0)               AS Ind_Req_Week_1,
  NVL(RCCP.Ind_Req_Week_2,0)               AS Ind_Req_Week_2,
  NVL(RCCP.Ind_Req_Week_3,0)               AS Ind_Req_Week_3,
  NVL(RCCP.Ind_Req_Week_4,0)               AS Ind_Req_Week_4,
  NVL(RCCP.Ind_Req_Week_5,0)               AS Ind_Req_Week_5,
  NVL(RCCP.Ind_Req_Week_6,0)               AS Ind_Req_Week_6,
  NVL(RCCP.Ind_Req_Week_7,0)               AS Ind_Req_Week_7,
  NVL(RCCP.Ind_Req_Week_8 ,0)              AS Ind_Req_Week_8,
  NVL(RCCP.Ind_Req_Week_9 ,0)              AS Ind_Req_Week_9,
  NVL(RCCP.Ind_Req_Week_10 ,0)             AS Ind_Req_Week_10,
  NVL(RCCP.Ind_Req_Week_11 ,0)             AS Ind_Req_Week_11,
  NVL(RCCP.Ind_Req_Week_12 ,0)             AS Ind_Req_Week_12,
  NVL(RCCP.Ind_Req_Week_13 ,0)             AS Ind_Req_Week_13,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_1,0)  AS FIRM_REQ_WEEK_1,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_2,0)  AS FIRM_REQ_WEEK_2,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_3,0)  AS FIRM_REQ_WEEK_3,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_4,0)  AS FIRM_REQ_WEEK_4,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_5,0)  AS FIRM_REQ_WEEK_5,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_6,0)  AS FIRM_REQ_WEEK_6,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_7,0)  AS FIRM_REQ_WEEK_7,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_8,0)  AS FIRM_REQ_WEEK_8,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_9,0)  AS FIRM_REQ_WEEK_9,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_10,0) AS FIRM_REQ_WEEK_10,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_11,0) AS FIRM_REQ_WEEK_11,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_12,0) AS FIRM_REQ_WEEK_12,
  NVL(FIRM_REQ_OPEN_PO.FIRM_REQ_WEEK_13,0) AS FIRM_REQ_WEEK_13,
  NVL(RCCP.TOT_Req_Week_1 ,0)              AS TOT_Req_Week_1,
  NVL(RCCP.TOT_Req_Week_2 ,0)              AS TOT_Req_Week_2,
  NVL(RCCP.TOT_Req_Week_3 ,0)              AS TOT_Req_Week_3,
  NVL(RCCP.TOT_Req_Week_4 ,0)              AS TOT_Req_Week_4,
  NVL(RCCP.TOT_Req_Week_5 ,0)              AS TOT_Req_Week_5,
  NVL(RCCP.TOT_Req_Week_6 ,0)              AS TOT_Req_Week_6,
  NVL(RCCP.TOT_Req_Week_7 ,0)              AS TOT_Req_Week_7,
  NVL(RCCP.TOT_Req_Week_8 ,0)              AS TOT_Req_Week_8,
  NVL(RCCP.TOT_Req_Week_9 ,0)              AS TOT_Req_Week_9,
  NVL(RCCP.TOT_Req_Week_10 ,0)             AS TOT_Req_Week_10,
  NVL(RCCP.TOT_Req_Week_11 ,0)             AS TOT_Req_Week_11,
  NVL(RCCP.TOT_Req_Week_12 ,0)             AS TOT_Req_Week_12,
  NVL(RCCP.TOT_Req_Week_13 ,0)             AS TOT_Req_Week_13,
  RCCP.Three_Sigma,
  RCCP.Three_Sigma_Load,
  NVL(RCCP.TOT_PO_PLO_Week_1,0)              AS TOT_PO_PLO_Week_1,
  NVL(RCCP.TOT_PO_PLO_Week_2,0)              AS TOT_PO_PLO_Week_2,
  NVL(RCCP.TOT_PO_PLO_Week_3,0)              AS TOT_PO_PLO_Week_3,
  NVL(RCCP.TOT_PO_PLO_Week_4,0)              AS TOT_PO_PLO_Week_4,
  NVL(RCCP.TOT_PO_PLO_Week_5,0)              AS TOT_PO_PLO_Week_5,
  NVL(RCCP.TOT_PO_PLO_Week_6,0)              AS TOT_PO_PLO_Week_6,
  NVL(RCCP.TOT_PO_PLO_Week_7,0)              AS TOT_PO_PLO_Week_7,
  NVL(RCCP.TOT_PO_PLO_Week_8,0)              AS TOT_PO_PLO_Week_8,
  NVL(RCCP.TOT_PO_PLO_Week_9,0)              AS TOT_PO_PLO_Week_9,
  NVL(RCCP.TOT_PO_PLO_Week_10,0)             AS TOT_PO_PLO_Week_10,
  NVL(RCCP.TOT_PO_PLO_Week_11,0)             AS TOT_PO_PLO_Week_11,
  NVL(RCCP.TOT_PO_PLO_Week_12,0)             AS TOT_PO_PLO_Week_12,
  NVL(RCCP.TOT_PO_PLO_Week_13,0)             AS TOT_PO_PLO_Week_13,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_1,0)     AS OPEN_OP_WEEK_1,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_2,0)     AS OPEN_OP_WEEK_2,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_3,0)     AS OPEN_OP_WEEK_3,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_4,0)     AS OPEN_OP_WEEK_4,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_5,0)     AS OPEN_OP_WEEK_5,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_6,0)     AS OPEN_OP_WEEK_6,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_7,0)     AS OPEN_OP_WEEK_7,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_8,0)     AS OPEN_OP_WEEK_8,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_9,0)     AS OPEN_OP_WEEK_9,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_10,0)    AS OPEN_OP_WEEK_10,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_11,0)    AS OPEN_OP_WEEK_11,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_12,0)    AS OPEN_OP_WEEK_12,
  NVL(FIRM_REQ_OPEN_PO.OPEN_OP_WEEK_13,0)    AS OPEN_OP_WEEK_13,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_1,0)   AS OPEN_PLAN_WEEK_1,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_2,0)   AS OPEN_PLAN_WEEK_2,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_3,0)   AS OPEN_PLAN_WEEK_3,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_4,0)   AS OPEN_PLAN_WEEK_4,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_5,0)   AS OPEN_PLAN_WEEK_5,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_6,0)   AS OPEN_PLAN_WEEK_6,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_7,0)   AS OPEN_PLAN_WEEK_7,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_8,0)   AS OPEN_PLAN_WEEK_8,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_9,0)   AS OPEN_PLAN_WEEK_9,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_10,0)  AS OPEN_PLAN_WEEK_10,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_11,0)  AS OPEN_PLAN_WEEK_11,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_12,0) AS OPEN_PLAN_WEEK_12,
  NVL(FIRM_REQ_OPEN_PO.OPEN_PLAN_WEEK_13,0)  AS OPEN_PLAN_WEEK_13
FROM
  (SELECT RCCP_BASIC.ID          AS ID,
    RCCP_BASIC.LAST_REVIEW       AS LAST_REVIEW,
    RCCP_BASIC.MATERIAL          AS MATERIAL,
    RCCP_BASIC.CATALOG_DASH      AS CATALOG_DASH,
    RCCP_BASIC.PLANT             AS PLANT,
    RCCP_BASIC.MAT_DESC          AS MATERIAL_DES,
    RCCP_BASIC.MRP_CONTROLLER    AS MRP_CONTROLLER,
    RCCP_BASIC.STRATEGY_GRP      AS STRATEGY_GRP,
    RCCP_BASIC.SAFETY_STOCK      AS SAFETY_STOCK,
    RCCP_BASIC.OH_QTY            AS OH_QTY,
    RCCP_BASIC.UNIT              AS UNIT,
    RCCP_BASIC.UNIT_COST         AS UNIT_COST,
    RCCP_BASIC.PROD_BU           AS PROD_BU,
    RCCP_BASIC.PLANT_SP_MATL_STA AS SP,
    RCCP_BASIC.VENDOR_KEY        AS VENDOR,
    RCCP_BASIC.MIN_INV           AS MIN_INV,
    RCCP_BASIC.TARGET_INV        AS TARGET_INV,
    RCCP_BASIC.MAX_INV           AS MAX_INV,
    0                            AS Ind_Req_AVG,
    0                            AS Ind_Req_AVG_50,
    0                            AS Ind_Req_AVG_25,
    IndReq.WK_1                  AS Ind_Req_Week_1,
    IndReq.WK_2                  AS Ind_Req_Week_2,
    IndReq.WK_3                  AS Ind_Req_Week_3,
    IndReq.WK_4                  AS Ind_Req_Week_4,
    IndReq.WK_5                  AS Ind_Req_Week_5,
    IndReq.WK_6                  AS Ind_Req_Week_6,
    IndReq.WK_7                  AS Ind_Req_Week_7,
    IndReq.WK_8                  AS Ind_Req_Week_8,
    IndReq.WK_9                  AS Ind_Req_Week_9,
    IndReq.WK_10                 AS Ind_Req_Week_10,
    IndReq.WK_11                 AS Ind_Req_Week_11,
    IndReq.WK_12                 AS Ind_Req_Week_12,
    IndReq.WK_13                 AS Ind_Req_Week_13,
    RCCP_BASIC.OUT_QTY_W01       AS TOT_Req_Week_1,
    RCCP_BASIC.OUT_QTY_W02       AS TOT_Req_Week_2,
    RCCP_BASIC.OUT_QTY_W03       AS TOT_Req_Week_3,
    RCCP_BASIC.OUT_QTY_W04       AS TOT_Req_Week_4,
    RCCP_BASIC.OUT_QTY_W05       AS TOT_Req_Week_5,
    RCCP_BASIC.OUT_QTY_W06       AS TOT_Req_Week_6,
    RCCP_BASIC.OUT_QTY_W07       AS TOT_Req_Week_7,
    RCCP_BASIC.OUT_QTY_W08       AS TOT_Req_Week_8,
    RCCP_BASIC.OUT_QTY_W09       AS TOT_Req_Week_9,
    RCCP_BASIC.OUT_QTY_W10       AS TOT_Req_Week_10,
    RCCP_BASIC.OUT_QTY_W11       AS TOT_Req_Week_11,
    RCCP_BASIC.OUT_QTY_W12       AS TOT_Req_Week_12,
    RCCP_BASIC.OUT_QTY_W13       AS TOT_Req_Week_13,
    0                            AS Three_Sigma,
    0                            AS Three_Sigma_Load,
    0                            AS TOT_PO_PLO_Week_1,
    0                            AS TOT_PO_PLO_Week_2,
    0                            AS TOT_PO_PLO_Week_3,
    0                            AS TOT_PO_PLO_Week_4,
    0                            AS TOT_PO_PLO_Week_5,
    0                            AS TOT_PO_PLO_Week_6,
    0                            AS TOT_PO_PLO_Week_7,
    0                            AS TOT_PO_PLO_Week_8,
    0                            AS TOT_PO_PLO_Week_9,
    0                            AS TOT_PO_PLO_Week_10,
    0                            AS TOT_PO_PLO_Week_11,
    0                            AS TOT_PO_PLO_Week_12,
    0                            AS TOT_PO_PLO_Week_13
  FROM
    (SELECT ID,
      MATERIALID,
      SUM(WEEK_1)  AS WK_1,
      SUM(WEEK_2)  AS WK_2,
      SUM(WEEK_3)  AS WK_3,
      SUM(WEEK_4)  AS WK_4,
      SUM(WEEK_5)  AS WK_5,
      SUM(WEEK_6)  AS WK_6,
      SUM(WEEK_7)  AS WK_7,
      SUM(WEEK_8)  AS WK_8,
      SUM(WEEK_9)  AS WK_9,
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
        WHERE VERSBP_VERSION = '00'
        AND PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 91)
        )
      )
    GROUP BY ID,
      MATERIALID
    )IndReq
  LEFT JOIN
    (SELECT ID,
      LAST_REVIEW,
      MATERIAL,
      CATALOG_DASH,
      CATALOG_NO_DASH,
      MRP_CONTROLLER,
      STRATEGY_GRP,
      PLANT,
      MAT_DESC,
      SAFETY_STOCK,
      OH_QTY,
      UNIT,
      UNIT_COST,
      PROD_BU,
      PLANT_SP_MATL_STA,
      VENDOR_KEY,
      MIN_INV,
      TARGET_INV,
      MAX_INV,
      OUT_QTY_W01,
      OUT_QTY_W02,
      OUT_QTY_W03,
      OUT_QTY_W04,
      OUT_QTY_W05,
      OUT_QTY_W06,
      OUT_QTY_W07,
      OUT_QTY_W08,
      OUT_QTY_W09,
      OUT_QTY_W10,
      OUT_QTY_W11,
      OUT_QTY_W12,
      OUT_QTY_W13
    FROM VIEW_INV_SAP_PP_OPT_X
    WHERE PLANT IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
    )RCCP_BASIC
  ON IndReq.ID = RCCP_BASIC.ID
  )RCCP
LEFT JOIN
  (SELECT FIRE_REQ.ID              AS ID,
    FIRE_REQ.FIRM_REQ_WEEK_1       AS FIRM_REQ_WEEK_1,
    FIRE_REQ.FIRM_REQ_WEEK_2       AS FIRM_REQ_WEEK_2,
    FIRE_REQ.FIRM_REQ_WEEK_3       AS FIRM_REQ_WEEK_3,
    FIRE_REQ.FIRM_REQ_WEEK_4       AS FIRM_REQ_WEEK_4,
    FIRE_REQ.FIRM_REQ_WEEK_5       AS FIRM_REQ_WEEK_5,
    FIRE_REQ.FIRM_REQ_WEEK_6       AS FIRM_REQ_WEEK_6,
    FIRE_REQ.FIRM_REQ_WEEK_7       AS FIRM_REQ_WEEK_7,
    FIRE_REQ.FIRM_REQ_WEEK_8       AS FIRM_REQ_WEEK_8,
    FIRE_REQ.FIRM_REQ_WEEK_9       AS FIRM_REQ_WEEK_9,
    FIRE_REQ.FIRM_REQ_WEEK_10      AS FIRM_REQ_WEEK_10,
    FIRE_REQ.FIRM_REQ_WEEK_11      AS FIRM_REQ_WEEK_11,
    FIRE_REQ.FIRM_REQ_WEEK_12      AS FIRM_REQ_WEEK_12,
    FIRE_REQ.FIRM_REQ_WEEK_13      AS FIRM_REQ_WEEK_13,
    OPEN_PO_PLAN.OPEN_OP_WEEK_1    AS OPEN_OP_WEEK_1,
    OPEN_PO_PLAN.OPEN_OP_WEEK_2    AS OPEN_OP_WEEK_2,
    OPEN_PO_PLAN.OPEN_OP_WEEK_3    AS OPEN_OP_WEEK_3,
    OPEN_PO_PLAN.OPEN_OP_WEEK_4    AS OPEN_OP_WEEK_4,
    OPEN_PO_PLAN.OPEN_OP_WEEK_5    AS OPEN_OP_WEEK_5,
    OPEN_PO_PLAN.OPEN_OP_WEEK_6    AS OPEN_OP_WEEK_6,
    OPEN_PO_PLAN.OPEN_OP_WEEK_7    AS OPEN_OP_WEEK_7,
    OPEN_PO_PLAN.OPEN_OP_WEEK_8    AS OPEN_OP_WEEK_8,
    OPEN_PO_PLAN.OPEN_OP_WEEK_9    AS OPEN_OP_WEEK_9,
    OPEN_PO_PLAN.OPEN_OP_WEEK_10   AS OPEN_OP_WEEK_10,
    OPEN_PO_PLAN.OPEN_OP_WEEK_11   AS OPEN_OP_WEEK_11,
    OPEN_PO_PLAN.OPEN_OP_WEEK_12   AS OPEN_OP_WEEK_12,
    OPEN_PO_PLAN.OPEN_OP_WEEK_13   AS OPEN_OP_WEEK_13,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_1  AS OPEN_PLAN_WEEK_1,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_2  AS OPEN_PLAN_WEEK_2,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_3  AS OPEN_PLAN_WEEK_3,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_4  AS OPEN_PLAN_WEEK_4,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_5  AS OPEN_PLAN_WEEK_5,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_6  AS OPEN_PLAN_WEEK_6,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_7  AS OPEN_PLAN_WEEK_7,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_8  AS OPEN_PLAN_WEEK_8,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_9  AS OPEN_PLAN_WEEK_9,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_10 AS OPEN_PLAN_WEEK_10,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_11 AS OPEN_PLAN_WEEK_11,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_12 AS OPEN_PLAN_WEEK_12,
    OPEN_PO_PLAN.OPEN_PLAN_WEEK_13 AS OPEN_PLAN_WEEK_13
  FROM
    (SELECT SHOPPING_CART.ID                   AS ID,
      (SHOPPING_CART.WK_1  + SALES_OPEN.WK_1)  AS FIRM_REQ_WEEK_1,
      (SHOPPING_CART.WK_2  + SALES_OPEN.WK_2)  AS FIRM_REQ_WEEK_2,
      (SHOPPING_CART.WK_3  + SALES_OPEN.WK_3)  AS FIRM_REQ_WEEK_3,
      (SHOPPING_CART.WK_4  + SALES_OPEN.WK_4)  AS FIRM_REQ_WEEK_4,
      (SHOPPING_CART.WK_5  + SALES_OPEN.WK_5)  AS FIRM_REQ_WEEK_5,
      (SHOPPING_CART.WK_6  + SALES_OPEN.WK_6)  AS FIRM_REQ_WEEK_6,
      (SHOPPING_CART.WK_7  + SALES_OPEN.WK_7)  AS FIRM_REQ_WEEK_7,
      (SHOPPING_CART.WK_8  + SALES_OPEN.WK_8)  AS FIRM_REQ_WEEK_8,
      (SHOPPING_CART.WK_9  + SALES_OPEN.WK_9)  AS FIRM_REQ_WEEK_9,
      (SHOPPING_CART.WK_10 + SALES_OPEN.WK_10) AS FIRM_REQ_WEEK_10,
      (SHOPPING_CART.WK_11 + SALES_OPEN.WK_11) AS FIRM_REQ_WEEK_11,
      (SHOPPING_CART.WK_12 + SALES_OPEN.WK_12) AS FIRM_REQ_WEEK_12,
      (SHOPPING_CART.WK_13 + SALES_OPEN.WK_13) AS FIRM_REQ_WEEK_13
    FROM
      (SELECT ID,
        MATERIALID,
        SUM(WEEK_1)  AS WK_1,
        SUM(WEEK_2)  AS WK_2,
        SUM(WEEK_3)  AS WK_3,
        SUM(WEEK_4)  AS WK_4,
        SUM(WEEK_5)  AS WK_5,
        SUM(WEEK_6)  AS WK_6,
        SUM(WEEK_7)  AS WK_7,
        SUM(WEEK_8)  AS WK_8,
        SUM(WEEK_9)  AS WK_9,
        SUM(WEEK_10) AS WK_10,
        SUM(WEEK_11) AS WK_11,
        SUM(WEEK_12) AS WK_12,
        SUM(WEEK_13) AS WK_13
      FROM
        (SELECT ID,
          MATERIALID,
          PLANTID,
          CASE
            WHEN WEEK_NUMBER <= TO_CHAR(SYSDATE,'iw')
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_1,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 1
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_2,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 2
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_3,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 3
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_4,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 4
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_5,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 5
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_6,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 6
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_7,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 7
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_8,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 8
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_9,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 9
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_10,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 10
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_11,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 11
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_12,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 12
            THEN SHOPPING_CART_OPEN
            ELSE 0
          END WEEK_13
        FROM
          (SELECT MATERIALID
            ||'_'
            ||PLANTID AS ID,
            MATERIALID,
            PLANTID,
            TO_CHAR(COMMITTED_DATE,'iw') AS WEEK_NUMBER,
            COMMITTEDQTY                 AS SHOPPING_CART_OPEN
          FROM INV_SAP_PP_PO_HISTORY
          WHERE BSART_PURCHDOCTYPE       = 'ZUB'
          AND ELIKZDELIVERYCOMPLETEDIND IS NULL
          AND COMMITTED_DATE             < TO_CHAR(sysdate + 91)
          )
        )
      GROUP BY ID,
        MATERIALID
      )SHOPPING_CART
    LEFT JOIN
      (
	  SELECT ID,
        MATERIALID,
        SUM(WEEK_1)  AS WK_1,
        SUM(WEEK_2)  AS WK_2,
        SUM(WEEK_3)  AS WK_3,
        SUM(WEEK_4)  AS WK_4,
        SUM(WEEK_5)  AS WK_5,
        SUM(WEEK_6)  AS WK_6,
        SUM(WEEK_7)  AS WK_7,
        SUM(WEEK_8)  AS WK_8,
        SUM(WEEK_9)  AS WK_9,
        SUM(WEEK_10) AS WK_10,
        SUM(WEEK_11) AS WK_11,
        SUM(WEEK_12) AS WK_12,
        SUM(WEEK_13) AS WK_13
      FROM
        (SELECT ID,
          MATERIALID,
          PLANTID,
          CASE
            WHEN WEEK_NUMBER <= TO_CHAR(SYSDATE,'iw')
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_1,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 1
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_2,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 2
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_3,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 3
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_4,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 4
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_5,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 5
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_6,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 6
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_7,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 7
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_8,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 8
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_9,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 9
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_10,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 10
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_11,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 11
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_12,
          CASE
            WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 12
            THEN SALE_OPEN_QTY
            ELSE 0
          END WEEK_13
        FROM
          (SELECT MATERIALID
            ||'_'
            ||PLANTID                          AS ID,
            MATERIALID                         AS MATERIALID,
            PLANTID                            AS PLANTID,
            TO_CHAR(REQUIREDDELIVERYDATE,'iw') AS WEEK_NUMBER,
            REQUIREDDELIVERYDATE,
            SALESDOC,
            OPENQTY AS SALE_OPEN_QTY
          FROM INV_SAP_SALES_HST
          WHERE REQUIREDDELIVERYDATE < TO_CHAR(sysdate + 91)
          AND SALESDOCTYPE                            IN ('ZOR1','ZOR5')
          AND OPENQTY                > 0
          )
        )
      GROUP BY ID,
        MATERIALID
      )SALES_OPEN
    ON SALES_OPEN.ID = SHOPPING_CART.ID
    )FIRE_REQ
  LEFT JOIN
    (
	SELECT OPEN_PO.ID AS ID,
      OPEN_PO.WK_1     AS OPEN_OP_WEEK_1,
      OPEN_PO.WK_2     AS OPEN_OP_WEEK_2,
      OPEN_PO.WK_3     AS OPEN_OP_WEEK_3,
      OPEN_PO.WK_4     AS OPEN_OP_WEEK_4,
      OPEN_PO.WK_5     AS OPEN_OP_WEEK_5,
      OPEN_PO.WK_6     AS OPEN_OP_WEEK_6,
      OPEN_PO.WK_7     AS OPEN_OP_WEEK_7,
      OPEN_PO.WK_8     AS OPEN_OP_WEEK_8,
      OPEN_PO.WK_9     AS OPEN_OP_WEEK_9,
      OPEN_PO.WK_10    AS OPEN_OP_WEEK_10,
      OPEN_PO.WK_11    AS OPEN_OP_WEEK_11,
      OPEN_PO.WK_12    AS OPEN_OP_WEEK_12,
      OPEN_PO.WK_13    AS OPEN_OP_WEEK_13,
      OPEN_PLAN.WK_1   AS OPEN_PLAN_WEEK_1,
      OPEN_PLAN.WK_2   AS OPEN_PLAN_WEEK_2,
      OPEN_PLAN.WK_3   AS OPEN_PLAN_WEEK_3,
      OPEN_PLAN.WK_4   AS OPEN_PLAN_WEEK_4,
      OPEN_PLAN.WK_5   AS OPEN_PLAN_WEEK_5,
      OPEN_PLAN.WK_6   AS OPEN_PLAN_WEEK_6,
      OPEN_PLAN.WK_7   AS OPEN_PLAN_WEEK_7,
      OPEN_PLAN.WK_8   AS OPEN_PLAN_WEEK_8,
      OPEN_PLAN.WK_9   AS OPEN_PLAN_WEEK_9,
      OPEN_PLAN.WK_10  AS OPEN_PLAN_WEEK_10,
      OPEN_PLAN.WK_11  AS OPEN_PLAN_WEEK_11,
      OPEN_PLAN.WK_12  AS OPEN_PLAN_WEEK_12,
      OPEN_PLAN.WK_13  AS OPEN_PLAN_WEEK_13
    FROM
      (SELECT ID,
        MATERIALID,
        SUM(WEEK_1)  AS WK_1,
        SUM(WEEK_2)  AS WK_2,
        SUM(WEEK_3)  AS WK_3,
        SUM(WEEK_4)  AS WK_4,
        SUM(WEEK_5)  AS WK_5,
        SUM(WEEK_6)  AS WK_6,
        SUM(WEEK_7)  AS WK_7,
        SUM(WEEK_8)  AS WK_8,
        SUM(WEEK_9)  AS WK_9,
        SUM(WEEK_10) AS WK_10,
        SUM(WEEK_11) AS WK_11,
        SUM(WEEK_12) AS WK_12,
        SUM(WEEK_13) AS WK_13
      FROM
        (
		SELECT ID,
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
            TO_CHAR(COMMITTED_DATE,'iw') AS WEEK_NUMBER,
            COMMITTEDQTY                 AS OPEN_PO_QTY
          FROM INV_SAP_PP_PO_HISTORY
          WHERE BSART_PURCHDOCTYPE      IN ('ZST','ZNB')
          AND ELIKZDELIVERYCOMPLETEDIND IS NULL
          AND COMMITTED_DATE             < TO_CHAR(sysdate + 91)
          )
        )
      GROUP BY ID,
        MATERIALID
      )OPEN_PO
    LEFT JOIN
      (
	  SELECT ID,
        MATERIALID,
        SUM(WEEK_1)  AS WK_1,
        SUM(WEEK_2)  AS WK_2,
        SUM(WEEK_3)  AS WK_3,
        SUM(WEEK_4)  AS WK_4,
        SUM(WEEK_5)  AS WK_5,
        SUM(WEEK_6)  AS WK_6,
        SUM(WEEK_7)  AS WK_7,
        SUM(WEEK_8)  AS WK_8,
        SUM(WEEK_9)  AS WK_9,
        SUM(WEEK_10) AS WK_10,
        SUM(WEEK_11) AS WK_11,
        SUM(WEEK_12) AS WK_12,
        SUM(WEEK_13) AS WK_13
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
    ON OPEN_PLAN.ID                        = OPEN_PO.ID
    )OPEN_PO_PLAN ON FIRE_REQ.ID           = OPEN_PO_PLAN.ID
  )FIRM_REQ_OPEN_PO ON FIRM_REQ_OPEN_PO.ID = RCCP.ID; 

    