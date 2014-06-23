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
  

-------------------------REPORT----------------------------
--RCCP REPORT
DROP VIEW VIEW_INV_SAP_RCCP;
DROP TABLE INV_SAP_RCCP;
CREATE TABLE INV_SAP_RCCP AS
SELECT * FROM VIEW_INV_SAP_RCCP;
CREATE VIEW VIEW_INV_SAP_RCCP AS 
SELECT RCCP_BS_IND_FIRM_PLAN.ID            AS ID,
  RCCP_BS_IND_FIRM_PLAN.LAST_REVIEW        AS LAST_REVIEW,
  RCCP_BS_IND_FIRM_PLAN.MATERIAL           AS MATERIAL,
  RCCP_BS_IND_FIRM_PLAN.CATALOG_DASH       AS CATALOG_DASH,
  RCCP_BS_IND_FIRM_PLAN.PLANT              AS PLANT,
  RCCP_BS_IND_FIRM_PLAN.MATERIAL_DES       AS MATERIAL_DES,
  RCCP_BS_IND_FIRM_PLAN.MRP_CONTROLLER     AS MRP_CONTROLLER,
  RCCP_BS_IND_FIRM_PLAN.STRATEGY_GRP       AS STRATEGY_GRP,
  RCCP_BS_IND_FIRM_PLAN.SAFETY_STOCK       AS SAFETY_STOCK,
  RCCP_BS_IND_FIRM_PLAN.OH_QTY             AS OH_QTY,
  RCCP_BS_IND_FIRM_PLAN.UNIT               AS UNIT,
  RCCP_BS_IND_FIRM_PLAN.UNIT_COST          AS UNIT_COST,
  RCCP_BS_IND_FIRM_PLAN.PROD_BU            AS PROD_BU,
  RCCP_BS_IND_FIRM_PLAN.SP                 AS SP,
  RCCP_BS_IND_FIRM_PLAN.VENDOR             AS VENDOR,
  RCCP_BS_IND_FIRM_PLAN.MIN_INV            AS MIN_INV,
  RCCP_BS_IND_FIRM_PLAN.TARGET_INV         AS TARGET_INV,
  RCCP_BS_IND_FIRM_PLAN.MAX_INV            AS MAX_INV,
  RCCP_BS_IND_FIRM_PLAN.Ind_Req_AVG        AS Ind_Req_AVG,
  RCCP_BS_IND_FIRM_PLAN.Ind_Req_AVG_50     AS Ind_Req_AVG_50,
  RCCP_BS_IND_FIRM_PLAN.Ind_Req_AVG_25     AS Ind_Req_AVG_25,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_1,0)     AS Ind_Req_Week_1,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_2,0)     AS Ind_Req_Week_2,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_3,0)     AS Ind_Req_Week_3,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_4,0)     AS Ind_Req_Week_4,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_5,0)     AS Ind_Req_Week_5,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_6,0)     AS Ind_Req_Week_6,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_7,0)     AS Ind_Req_Week_7,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_8,0)     AS Ind_Req_Week_8,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_9,0)     AS Ind_Req_Week_9,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_10,0)    AS Ind_Req_Week_10,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_11,0)    AS Ind_Req_Week_11,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_12,0)    AS Ind_Req_Week_12,
  NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_13,0)   AS Ind_Req_Week_13,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_1,0)    AS FIRM_REQ_WEEK_1,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_2,0)    AS FIRM_REQ_WEEK_2,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_3,0)    AS FIRM_REQ_WEEK_3,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_4,0)    AS FIRM_REQ_WEEK_4,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_5,0)    AS FIRM_REQ_WEEK_5,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_6,0)    AS FIRM_REQ_WEEK_6,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_7,0)    AS FIRM_REQ_WEEK_7,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_8,0)    AS FIRM_REQ_WEEK_8,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_9,0)    AS FIRM_REQ_WEEK_9,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_10,0)   AS FIRM_REQ_WEEK_10,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_11,0)   AS FIRM_REQ_WEEK_11,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_12,0)   AS FIRM_REQ_WEEK_12,
  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_13,0)   AS FIRM_REQ_WEEK_13,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_1,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_1,0))    AS TOT_Req_Week_1,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_2,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_2,0))    AS TOT_Req_Week_2,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_3,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_3,0))    AS TOT_Req_Week_3,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_4,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_4,0))    AS TOT_Req_Week_4,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_5,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_5,0))    AS TOT_Req_Week_5,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_6,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_6,0))    AS TOT_Req_Week_6,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_7,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_7,0))    AS TOT_Req_Week_7,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_8,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_8,0))    AS TOT_Req_Week_8,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_9,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_9,0))    AS TOT_Req_Week_9,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_10,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_10,0))    AS TOT_Req_Week_10,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_11,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_11,0))    AS TOT_Req_Week_11,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_12,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_12,0))    AS TOT_Req_Week_12,
  (NVL(RCCP_BS_IND_FIRM_PLAN.Ind_Req_Week_13,0) +  NVL(RCCP_BS_IND_FIRM_PLAN.FIRM_REQ_WEEK_13,0))    AS TOT_Req_Week_13,
  RCCP_BS_IND_FIRM_PLAN.Three_Sigma        AS Three_Sigma,
  RCCP_BS_IND_FIRM_PLAN.Three_Sigma_Load   AS Three_Sigma_Load,
  (NVL(OPEN_PO.OPEN_OP_WEEK_1,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_1,0))  AS TOT_PO_PLO_Week_1,
  (NVL(OPEN_PO.OPEN_OP_WEEK_2,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_2,0))  AS TOT_PO_PLO_Week_2,
  (NVL(OPEN_PO.OPEN_OP_WEEK_3,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_3,0))  AS TOT_PO_PLO_Week_3,
  (NVL(OPEN_PO.OPEN_OP_WEEK_4,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_4,0))  AS TOT_PO_PLO_Week_4,
  (NVL(OPEN_PO.OPEN_OP_WEEK_5,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_5,0))  AS TOT_PO_PLO_Week_5,
  (NVL(OPEN_PO.OPEN_OP_WEEK_6,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_6,0))  AS TOT_PO_PLO_Week_6,
  (NVL(OPEN_PO.OPEN_OP_WEEK_7,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_7,0))  AS TOT_PO_PLO_Week_7,
  (NVL(OPEN_PO.OPEN_OP_WEEK_8,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_8,0))  AS TOT_PO_PLO_Week_8,
  (NVL(OPEN_PO.OPEN_OP_WEEK_9,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_9,0))  AS TOT_PO_PLO_Week_9,
  (NVL(OPEN_PO.OPEN_OP_WEEK_10,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_10,0))  AS TOT_PO_PLO_Week_10,
  (NVL(OPEN_PO.OPEN_OP_WEEK_11,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_11,0))  AS TOT_PO_PLO_Week_11,
  (NVL(OPEN_PO.OPEN_OP_WEEK_12,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_12,0))  AS TOT_PO_PLO_Week_12,
  (NVL(OPEN_PO.OPEN_OP_WEEK_13,0) + NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_13,0))  AS TOT_PO_PLO_Week_13,
  NVL(OPEN_PO.OPEN_OP_WEEK_1,0)                             AS OPEN_OP_WEEK_1,
  NVL(OPEN_PO.OPEN_OP_WEEK_2,0)                             AS OPEN_OP_WEEK_2,
  NVL(OPEN_PO.OPEN_OP_WEEK_3,0)                             AS OPEN_OP_WEEK_3,
  NVL(OPEN_PO.OPEN_OP_WEEK_4,0)                             AS OPEN_OP_WEEK_4,
  NVL(OPEN_PO.OPEN_OP_WEEK_5,0)                             AS OPEN_OP_WEEK_5,
  NVL(OPEN_PO.OPEN_OP_WEEK_6,0)                             AS OPEN_OP_WEEK_6,
  NVL(OPEN_PO.OPEN_OP_WEEK_7,0)                             AS OPEN_OP_WEEK_7,
  NVL(OPEN_PO.OPEN_OP_WEEK_8,0)                             AS OPEN_OP_WEEK_8,
  NVL(OPEN_PO.OPEN_OP_WEEK_9,0)                             AS OPEN_OP_WEEK_9,
  NVL(OPEN_PO.OPEN_OP_WEEK_10,0)                            AS OPEN_OP_WEEK_10,
  NVL(OPEN_PO.OPEN_OP_WEEK_11,0)                            AS OPEN_OP_WEEK_11,
  NVL(OPEN_PO.OPEN_OP_WEEK_12,0)                            AS OPEN_OP_WEEK_12,
  NVL(OPEN_PO.OPEN_OP_WEEK_13,0)                            AS OPEN_OP_WEEK_13,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_1,0)               AS OPEN_PLAN_WEEK_1,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_2,0)               AS OPEN_PLAN_WEEK_2,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_3,0)               AS OPEN_PLAN_WEEK_3,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_4,0)               AS OPEN_PLAN_WEEK_4,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_5,0)               AS OPEN_PLAN_WEEK_5,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_6,0)               AS OPEN_PLAN_WEEK_6,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_7,0)               AS OPEN_PLAN_WEEK_7,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_8,0)               AS OPEN_PLAN_WEEK_8,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_9,0)               AS OPEN_PLAN_WEEK_9,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_10,0)              AS OPEN_PLAN_WEEK_10,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_11,0)              AS OPEN_PLAN_WEEK_11,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_12,0)              AS OPEN_PLAN_WEEK_12,
  NVL(RCCP_BS_IND_FIRM_PLAN.OPEN_PLAN_WEEK_13,0)              AS OPEN_PLAN_WEEK_13
FROM
  (SELECT RCCP_BS_IND_FIRM.ID           AS ID,
    RCCP_BS_IND_FIRM.LAST_REVIEW        AS LAST_REVIEW,
    RCCP_BS_IND_FIRM.MATERIAL           AS MATERIAL,
    RCCP_BS_IND_FIRM.CATALOG_DASH       AS CATALOG_DASH,
    RCCP_BS_IND_FIRM.PLANT              AS PLANT,
    RCCP_BS_IND_FIRM.MATERIAL_DES       AS MATERIAL_DES,
    RCCP_BS_IND_FIRM.MRP_CONTROLLER     AS MRP_CONTROLLER,
    RCCP_BS_IND_FIRM.STRATEGY_GRP       AS STRATEGY_GRP,
    RCCP_BS_IND_FIRM.SAFETY_STOCK       AS SAFETY_STOCK,
    RCCP_BS_IND_FIRM.OH_QTY             AS OH_QTY,
    RCCP_BS_IND_FIRM.UNIT               AS UNIT,
    RCCP_BS_IND_FIRM.UNIT_COST          AS UNIT_COST,
    RCCP_BS_IND_FIRM.PROD_BU            AS PROD_BU,
    RCCP_BS_IND_FIRM.SP                 AS SP,
    RCCP_BS_IND_FIRM.VENDOR             AS VENDOR,
    RCCP_BS_IND_FIRM.MIN_INV            AS MIN_INV,
    RCCP_BS_IND_FIRM.TARGET_INV         AS TARGET_INV,
    RCCP_BS_IND_FIRM.MAX_INV            AS MAX_INV,
    RCCP_BS_IND_FIRM.Ind_Req_AVG        AS Ind_Req_AVG,
    RCCP_BS_IND_FIRM.Ind_Req_AVG_50     AS Ind_Req_AVG_50,
    RCCP_BS_IND_FIRM.Ind_Req_AVG_25     AS Ind_Req_AVG_25,
    RCCP_BS_IND_FIRM.Ind_Req_Week_1     AS Ind_Req_Week_1,
    RCCP_BS_IND_FIRM.Ind_Req_Week_2     AS Ind_Req_Week_2,
    RCCP_BS_IND_FIRM.Ind_Req_Week_3     AS Ind_Req_Week_3,
    RCCP_BS_IND_FIRM.Ind_Req_Week_4     AS Ind_Req_Week_4,
    RCCP_BS_IND_FIRM.Ind_Req_Week_5     AS Ind_Req_Week_5,
    RCCP_BS_IND_FIRM.Ind_Req_Week_6     AS Ind_Req_Week_6,
    RCCP_BS_IND_FIRM.Ind_Req_Week_7     AS Ind_Req_Week_7,
    RCCP_BS_IND_FIRM.Ind_Req_Week_8     AS Ind_Req_Week_8,
    RCCP_BS_IND_FIRM.Ind_Req_Week_9     AS Ind_Req_Week_9,
    RCCP_BS_IND_FIRM.Ind_Req_Week_10    AS Ind_Req_Week_10,
    RCCP_BS_IND_FIRM.Ind_Req_Week_11    AS Ind_Req_Week_11,
    RCCP_BS_IND_FIRM.Ind_Req_Week_12    AS Ind_Req_Week_12,
    RCCP_BS_IND_FIRM.Ind_Req_Week_13    AS Ind_Req_Week_13,
    RCCP_BS_IND_FIRM.Three_Sigma        AS Three_Sigma,
    RCCP_BS_IND_FIRM.Three_Sigma_Load   AS Three_Sigma_Load,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_1    AS FIRM_REQ_WEEK_1,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_2    AS FIRM_REQ_WEEK_2,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_3    AS FIRM_REQ_WEEK_3,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_4    AS FIRM_REQ_WEEK_4,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_5    AS FIRM_REQ_WEEK_5,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_6    AS FIRM_REQ_WEEK_6,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_7    AS FIRM_REQ_WEEK_7,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_8    AS FIRM_REQ_WEEK_8,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_9    AS FIRM_REQ_WEEK_9,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_10   AS FIRM_REQ_WEEK_10,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_11   AS FIRM_REQ_WEEK_11,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_12   AS FIRM_REQ_WEEK_12,
    RCCP_BS_IND_FIRM.FIRM_REQ_WEEK_13   AS FIRM_REQ_WEEK_13,
    OPEN_PLAN.WK_1                      AS OPEN_PLAN_WEEK_1,
    OPEN_PLAN.WK_2                      AS OPEN_PLAN_WEEK_2,
    OPEN_PLAN.WK_3                      AS OPEN_PLAN_WEEK_3,
    OPEN_PLAN.WK_4                      AS OPEN_PLAN_WEEK_4,
    OPEN_PLAN.WK_5                      AS OPEN_PLAN_WEEK_5,
    OPEN_PLAN.WK_6                      AS OPEN_PLAN_WEEK_6,
    OPEN_PLAN.WK_7                      AS OPEN_PLAN_WEEK_7,
    OPEN_PLAN.WK_8                      AS OPEN_PLAN_WEEK_8,
    OPEN_PLAN.WK_9                      AS OPEN_PLAN_WEEK_9,
    OPEN_PLAN.WK_10                     AS OPEN_PLAN_WEEK_10,
    OPEN_PLAN.WK_11                     AS OPEN_PLAN_WEEK_11,
    OPEN_PLAN.WK_12                     AS OPEN_PLAN_WEEK_12,
    OPEN_PLAN.WK_13                     AS OPEN_PLAN_WEEK_13
  FROM
    (SELECT RCCP_BASIC_IND.ID           AS ID,
      RCCP_BASIC_IND.LAST_REVIEW        AS LAST_REVIEW,
      RCCP_BASIC_IND.MATERIAL           AS MATERIAL,
      RCCP_BASIC_IND.CATALOG_DASH       AS CATALOG_DASH,
      RCCP_BASIC_IND.PLANT              AS PLANT,
      RCCP_BASIC_IND.MATERIAL_DES       AS MATERIAL_DES,
      RCCP_BASIC_IND.MRP_CONTROLLER     AS MRP_CONTROLLER,
      RCCP_BASIC_IND.STRATEGY_GRP       AS STRATEGY_GRP,
      RCCP_BASIC_IND.SAFETY_STOCK       AS SAFETY_STOCK,
      RCCP_BASIC_IND.OH_QTY             AS OH_QTY,
      RCCP_BASIC_IND.UNIT               AS UNIT,
      RCCP_BASIC_IND.UNIT_COST          AS UNIT_COST,
      RCCP_BASIC_IND.PROD_BU            AS PROD_BU,
      RCCP_BASIC_IND.SP                 AS SP,
      RCCP_BASIC_IND.VENDOR             AS VENDOR,
      RCCP_BASIC_IND.MIN_INV            AS MIN_INV,
      RCCP_BASIC_IND.TARGET_INV         AS TARGET_INV,
      RCCP_BASIC_IND.MAX_INV            AS MAX_INV,
      RCCP_BASIC_IND.Ind_Req_AVG        AS Ind_Req_AVG,
      RCCP_BASIC_IND.Ind_Req_AVG_50     AS Ind_Req_AVG_50,
      RCCP_BASIC_IND.Ind_Req_AVG_25     AS Ind_Req_AVG_25,
      RCCP_BASIC_IND.Ind_Req_Week_1     AS Ind_Req_Week_1,
      RCCP_BASIC_IND.Ind_Req_Week_2     AS Ind_Req_Week_2,
      RCCP_BASIC_IND.Ind_Req_Week_3     AS Ind_Req_Week_3,
      RCCP_BASIC_IND.Ind_Req_Week_4     AS Ind_Req_Week_4,
      RCCP_BASIC_IND.Ind_Req_Week_5     AS Ind_Req_Week_5,
      RCCP_BASIC_IND.Ind_Req_Week_6     AS Ind_Req_Week_6,
      RCCP_BASIC_IND.Ind_Req_Week_7     AS Ind_Req_Week_7,
      RCCP_BASIC_IND.Ind_Req_Week_8     AS Ind_Req_Week_8,
      RCCP_BASIC_IND.Ind_Req_Week_9     AS Ind_Req_Week_9,
      RCCP_BASIC_IND.Ind_Req_Week_10    AS Ind_Req_Week_10,
      RCCP_BASIC_IND.Ind_Req_Week_11    AS Ind_Req_Week_11,
      RCCP_BASIC_IND.Ind_Req_Week_12    AS Ind_Req_Week_12,
      RCCP_BASIC_IND.Ind_Req_Week_13    AS Ind_Req_Week_13,
      RCCP_BASIC_IND.Three_Sigma        AS Three_Sigma,
      RCCP_BASIC_IND.Three_Sigma_Load   AS Three_Sigma_Load,
      FIRM_REQ.FIRM_REQ_WEEK_1          AS FIRM_REQ_WEEK_1,
      FIRM_REQ.FIRM_REQ_WEEK_2          AS FIRM_REQ_WEEK_2,
      FIRM_REQ.FIRM_REQ_WEEK_3          AS FIRM_REQ_WEEK_3,
      FIRM_REQ.FIRM_REQ_WEEK_4          AS FIRM_REQ_WEEK_4,
      FIRM_REQ.FIRM_REQ_WEEK_5          AS FIRM_REQ_WEEK_5,
      FIRM_REQ.FIRM_REQ_WEEK_6          AS FIRM_REQ_WEEK_6,
      FIRM_REQ.FIRM_REQ_WEEK_7          AS FIRM_REQ_WEEK_7,
      FIRM_REQ.FIRM_REQ_WEEK_8          AS FIRM_REQ_WEEK_8,
      FIRM_REQ.FIRM_REQ_WEEK_9          AS FIRM_REQ_WEEK_9,
      FIRM_REQ.FIRM_REQ_WEEK_10         AS FIRM_REQ_WEEK_10,
      FIRM_REQ.FIRM_REQ_WEEK_11         AS FIRM_REQ_WEEK_11,
      FIRM_REQ.FIRM_REQ_WEEK_12         AS FIRM_REQ_WEEK_12,
      FIRM_REQ.FIRM_REQ_WEEK_13         AS FIRM_REQ_WEEK_13
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
        0                            AS Three_Sigma,
        0                            AS Three_Sigma_Load
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
          MAX_INV
        FROM VIEW_INV_SAP_PP_OPT_X
        WHERE PLANT IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140') 
        )RCCP_BASIC
      ON IndReq.ID = RCCP_BASIC.ID
      )RCCP_BASIC_IND
    LEFT JOIN
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
      LEFT JOIN
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
      ON SALES_OPEN.ID         = SHOPPING_CART.ID
      )FIRM_REQ ON FIRM_REQ.ID = RCCP_BASIC_IND.ID
    )RCCP_BS_IND_FIRM
  LEFT JOIN
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
  ON OPEN_PLAN.ID = RCCP_BS_IND_FIRM.ID
  )RCCP_BS_IND_FIRM_PLAN
LEFT JOIN
  (SELECT ID,
    MATERIALID,
    SUM(WEEK_1)  AS OPEN_OP_WEEK_1,
    SUM(WEEK_2)  AS OPEN_OP_WEEK_2,
    SUM(WEEK_3)  AS OPEN_OP_WEEK_3,
    SUM(WEEK_4)  AS OPEN_OP_WEEK_4,
    SUM(WEEK_5)  AS OPEN_OP_WEEK_5,
    SUM(WEEK_6)  AS OPEN_OP_WEEK_6,
    SUM(WEEK_7)  AS OPEN_OP_WEEK_7,
    SUM(WEEK_8)  AS OPEN_OP_WEEK_8,
    SUM(WEEK_9)  AS OPEN_OP_WEEK_9,
    SUM(WEEK_10) AS OPEN_OP_WEEK_10,
    SUM(WEEK_11) AS OPEN_OP_WEEK_11,
    SUM(WEEK_12) AS OPEN_OP_WEEK_12,
    SUM(WEEK_13) AS OPEN_OP_WEEK_13
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
ON OPEN_PO.ID = RCCP_BS_IND_FIRM_PLAN.ID;
