--AUTHOR:HUANG MOYUE
--DATE:7/10/2014
--THIS IS THE OLD VERSION OF THE RCCP REPORT SQL CODE. I WANT THE ALL DATA FROM DW. BUT THERE SOME ERRORS IN IT.
--SO I CHOOSE THE USE BI AND DW,JOIN TOGETHER. ALL DATA RUN IN DW.
--RCCP REPORT

DROP VIEW VIEW_INV_SAP_RCCP;
DROP TABLE INV_SAP_RCCP;
CREATE TABLE INV_SAP_RCCP AS
SELECT * FROM VIEW_INV_SAP_RCCP;

CREATE VIEW VIEW_INV_SAP_RCCP AS
SELECT RCCP_BAS_IND_SCSO_PL.ID                                                                                                                              AS ID,
  RCCP_BAS_IND_SCSO_PL.LAST_REVIEW                                                                                                                          AS LAST_REVIEW,
  RCCP_BAS_IND_SCSO_PL.MATERIAL                                                                                                                             AS MATERIAL,
  RCCP_BAS_IND_SCSO_PL.CATALOG_DASH                                                                                                                         AS CATALOG_DASH,
  RCCP_BAS_IND_SCSO_PL.PLANT                                                                                                                                AS PLANT,
  RCCP_BAS_IND_SCSO_PL.MATERIAL_DES                                                                                                                         AS MATERIAL_DES,
  RCCP_BAS_IND_SCSO_PL.MRP_CONTROLLER                                                                                                                       AS MRP_CONTROLLER,
  RCCP_BAS_IND_SCSO_PL.STRATEGY_GRP                                                                                                                         AS STRATEGY_GRP,
  RCCP_BAS_IND_SCSO_PL.SAFETY_STOCK                                                                                                                         AS SAFETY_STOCK,
  RCCP_BAS_IND_SCSO_PL.OH_QTY                                                                                                                               AS OH_QTY,
  RCCP_BAS_IND_SCSO_PL.UNIT                                                                                                                                 AS UNIT,
  RCCP_BAS_IND_SCSO_PL.UNIT_COST                                                                                                                            AS UNIT_COST,
  RCCP_BAS_IND_SCSO_PL.PROD_BU                                                                                                                              AS PROD_BU,
  RCCP_BAS_IND_SCSO_PL.SP                                                                                                                                   AS SP,
  RCCP_BAS_IND_SCSO_PL.VENDOR                                                                                                                               AS VENDOR,
  RCCP_BAS_IND_SCSO_PL.MIN_INV                                                                                                                              AS MIN_INV,
  RCCP_BAS_IND_SCSO_PL.TARGET_INV                                                                                                                           AS TARGET_INV,
  RCCP_BAS_IND_SCSO_PL.MAX_INV                                                                                                                              AS MAX_INV,
  RCCP_BAS_IND_SCSO_PL.Ind_Req_AVG                                                                                                                          AS Ind_Req_AVG,
  RCCP_BAS_IND_SCSO_PL.Ind_Req_AVG_50                                                                                                                       AS Ind_Req_AVG_50,
  RCCP_BAS_IND_SCSO_PL.Ind_Req_AVG_25                                                                                                                       AS Ind_Req_AVG_25,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_1,0)                                                                                                                AS Ind_Req_Week_1,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_2,0)                                                                                                                AS Ind_Req_Week_2,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_3,0)                                                                                                                AS Ind_Req_Week_3,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_4,0)                                                                                                                AS Ind_Req_Week_4,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_5,0)                                                                                                                AS Ind_Req_Week_5,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_6,0)                                                                                                                AS Ind_Req_Week_6,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_7,0)                                                                                                                AS Ind_Req_Week_7,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_8,0)                                                                                                                AS Ind_Req_Week_8,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_9,0)                                                                                                                AS Ind_Req_Week_9,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_10,0)                                                                                                               AS Ind_Req_Week_10,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_11,0)                                                                                                               AS Ind_Req_Week_11,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_12,0)                                                                                                               AS Ind_Req_Week_12,
  NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_13,0)                                                                                                               AS Ind_Req_Week_13,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_1,0)  + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_1,0))                                                      AS FIRM_REQ_WEEK_1,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_2,0)  + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_2,0))                                                      AS FIRM_REQ_WEEK_2,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_3,0)  + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_3,0))                                                      AS FIRM_REQ_WEEK_3,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_4,0)  + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_4,0))                                                      AS FIRM_REQ_WEEK_4,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_5,0)  + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_5,0))                                                      AS FIRM_REQ_WEEK_5,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_6,0)  + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_6,0))                                                      AS FIRM_REQ_WEEK_6,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_7,0)  + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_7,0))                                                      AS FIRM_REQ_WEEK_7,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_8,0)  + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_8,0))                                                      AS FIRM_REQ_WEEK_8,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_9,0)  + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_9,0))                                                      AS FIRM_REQ_WEEK_9,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_10,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_10,0))                                                     AS FIRM_REQ_WEEK_10,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_11,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_11,0))                                                     AS FIRM_REQ_WEEK_11,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_12,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_12,0))                                                     AS FIRM_REQ_WEEK_12,
  (NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_13,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_13,0))                                                     AS FIRM_REQ_WEEK_13,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_1,0)        + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_1,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_1,0))   AS TOT_Req_Week_1,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_2,0)        + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_2,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_2,0))   AS TOT_Req_Week_2,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_3,0)        + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_3,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_3,0))   AS TOT_Req_Week_3,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_4,0)        + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_4,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_4,0))   AS TOT_Req_Week_4,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_5,0)        + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_5,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_5,0))   AS TOT_Req_Week_5,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_6,0)        + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_6,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_6,0))   AS TOT_Req_Week_6,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_7,0)        + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_7,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_7,0))   AS TOT_Req_Week_7,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_8,0)        + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_8,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_8,0))   AS TOT_Req_Week_8,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_9,0)        + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_9,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_9,0))   AS TOT_Req_Week_9,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_10,0)       + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_10,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_10,0)) AS TOT_Req_Week_10,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_11,0)       + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_11,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_11,0)) AS TOT_Req_Week_11,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_12,0)       + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_12,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_12,0)) AS TOT_Req_Week_12,
  (NVL(RCCP_BAS_IND_SCSO_PL.Ind_Req_Week_13,0)       + NVL(RCCP_BAS_IND_SCSO_PL.SHOPPING_CART_WEEK_13,0) + NVL(RCCP_BAS_IND_SCSO_PL.SALES_ORDER_WEEK_13,0)) AS TOT_Req_Week_13,
  RCCP_BAS_IND_SCSO_PL.Three_Sigma                                                                                                                          AS Three_Sigma,
  RCCP_BAS_IND_SCSO_PL.Three_Sigma_Load                                                                                                                     AS Three_Sigma_Load,
  (NVL(OPEN_PO.OPEN_OP_WEEK_1,0)  + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_1,0))                                                                            AS TOT_PO_PLO_Week_1,
  (NVL(OPEN_PO.OPEN_OP_WEEK_2,0)  + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_2,0))                                                                            AS TOT_PO_PLO_Week_2,
  (NVL(OPEN_PO.OPEN_OP_WEEK_3,0)  + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_3,0))                                                                            AS TOT_PO_PLO_Week_3,
  (NVL(OPEN_PO.OPEN_OP_WEEK_4,0)  + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_4,0))                                                                            AS TOT_PO_PLO_Week_4,
  (NVL(OPEN_PO.OPEN_OP_WEEK_5,0)  + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_5,0))                                                                            AS TOT_PO_PLO_Week_5,
  (NVL(OPEN_PO.OPEN_OP_WEEK_6,0)  + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_6,0))                                                                            AS TOT_PO_PLO_Week_6,
  (NVL(OPEN_PO.OPEN_OP_WEEK_7,0)  + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_7,0))                                                                            AS TOT_PO_PLO_Week_7,
  (NVL(OPEN_PO.OPEN_OP_WEEK_8,0)  + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_8,0))                                                                            AS TOT_PO_PLO_Week_8,
  (NVL(OPEN_PO.OPEN_OP_WEEK_9,0)  + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_9,0))                                                                            AS TOT_PO_PLO_Week_9,
  (NVL(OPEN_PO.OPEN_OP_WEEK_10,0) + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_10,0))                                                                           AS TOT_PO_PLO_Week_10,
  (NVL(OPEN_PO.OPEN_OP_WEEK_11,0) + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_11,0))                                                                           AS TOT_PO_PLO_Week_11,
  (NVL(OPEN_PO.OPEN_OP_WEEK_12,0) + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_12,0))                                                                           AS TOT_PO_PLO_Week_12,
  (NVL(OPEN_PO.OPEN_OP_WEEK_13,0) + NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_13,0))                                                                           AS TOT_PO_PLO_Week_13,
  NVL(OPEN_PO.OPEN_OP_WEEK_1,0)                                                                                                                              AS OPEN_OP_WEEK_1,
  NVL(OPEN_PO.OPEN_OP_WEEK_2,0)                                                                                                                              AS OPEN_OP_WEEK_2,
  NVL(OPEN_PO.OPEN_OP_WEEK_3,0)                                                                                                                              AS OPEN_OP_WEEK_3,
  NVL(OPEN_PO.OPEN_OP_WEEK_4,0)                                                                                                                              AS OPEN_OP_WEEK_4,
  NVL(OPEN_PO.OPEN_OP_WEEK_5,0)                                                                                                                              AS OPEN_OP_WEEK_5,
  NVL(OPEN_PO.OPEN_OP_WEEK_6,0)                                                                                                                              AS OPEN_OP_WEEK_6,
  NVL(OPEN_PO.OPEN_OP_WEEK_7,0)                                                                                                                              AS OPEN_OP_WEEK_7,
  NVL(OPEN_PO.OPEN_OP_WEEK_8,0)                                                                                                                              AS OPEN_OP_WEEK_8,
  NVL(OPEN_PO.OPEN_OP_WEEK_9,0)                                                                                                                              AS OPEN_OP_WEEK_9,
  NVL(OPEN_PO.OPEN_OP_WEEK_10,0)                                                                                                                             AS OPEN_OP_WEEK_10,
  NVL(OPEN_PO.OPEN_OP_WEEK_11,0)                                                                                                                             AS OPEN_OP_WEEK_11,
  NVL(OPEN_PO.OPEN_OP_WEEK_12,0)                                                                                                                             AS OPEN_OP_WEEK_12,
  NVL(OPEN_PO.OPEN_OP_WEEK_13,0)                                                                                                                             AS OPEN_OP_WEEK_13,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_1,0)                                                                                                               AS OPEN_PLAN_WEEK_1,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_2,0)                                                                                                               AS OPEN_PLAN_WEEK_2,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_3,0)                                                                                                               AS OPEN_PLAN_WEEK_3,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_4,0)                                                                                                               AS OPEN_PLAN_WEEK_4,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_5,0)                                                                                                               AS OPEN_PLAN_WEEK_5,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_6,0)                                                                                                               AS OPEN_PLAN_WEEK_6,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_7,0)                                                                                                               AS OPEN_PLAN_WEEK_7,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_8,0)                                                                                                               AS OPEN_PLAN_WEEK_8,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_9,0)                                                                                                               AS OPEN_PLAN_WEEK_9,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_10,0)                                                                                                              AS OPEN_PLAN_WEEK_10,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_11,0)                                                                                                              AS OPEN_PLAN_WEEK_11,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_12,0)                                                                                                              AS OPEN_PLAN_WEEK_12,
  NVL(RCCP_BAS_IND_SCSO_PL.OPEN_PLAN_WEEK_13,0)                                                                                                              AS OPEN_PLAN_WEEK_13
FROM
  (SELECT RCCP_BASIC_IND_SC_SO.ID              AS ID,
    RCCP_BASIC_IND_SC_SO.LAST_REVIEW           AS LAST_REVIEW,
    RCCP_BASIC_IND_SC_SO.MATERIAL              AS MATERIAL,
    RCCP_BASIC_IND_SC_SO.CATALOG_DASH          AS CATALOG_DASH,
    RCCP_BASIC_IND_SC_SO.PLANT                 AS PLANT,
    RCCP_BASIC_IND_SC_SO.MATERIAL_DES          AS MATERIAL_DES,
    RCCP_BASIC_IND_SC_SO.MRP_CONTROLLER        AS MRP_CONTROLLER,
    RCCP_BASIC_IND_SC_SO.STRATEGY_GRP          AS STRATEGY_GRP,
    RCCP_BASIC_IND_SC_SO.SAFETY_STOCK          AS SAFETY_STOCK,
    RCCP_BASIC_IND_SC_SO.OH_QTY                AS OH_QTY,
    RCCP_BASIC_IND_SC_SO.UNIT                  AS UNIT,
    RCCP_BASIC_IND_SC_SO.UNIT_COST             AS UNIT_COST,
    RCCP_BASIC_IND_SC_SO.PROD_BU               AS PROD_BU,
    RCCP_BASIC_IND_SC_SO.SP                    AS SP,
    RCCP_BASIC_IND_SC_SO.VENDOR                AS VENDOR,
    RCCP_BASIC_IND_SC_SO.MIN_INV               AS MIN_INV,
    RCCP_BASIC_IND_SC_SO.TARGET_INV            AS TARGET_INV,
    RCCP_BASIC_IND_SC_SO.MAX_INV               AS MAX_INV,
    RCCP_BASIC_IND_SC_SO.Ind_Req_AVG           AS Ind_Req_AVG,
    RCCP_BASIC_IND_SC_SO.Ind_Req_AVG_50        AS Ind_Req_AVG_50,
    RCCP_BASIC_IND_SC_SO.Ind_Req_AVG_25        AS Ind_Req_AVG_25,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_1        AS Ind_Req_Week_1,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_2        AS Ind_Req_Week_2,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_3        AS Ind_Req_Week_3,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_4        AS Ind_Req_Week_4,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_5        AS Ind_Req_Week_5,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_6        AS Ind_Req_Week_6,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_7        AS Ind_Req_Week_7,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_8        AS Ind_Req_Week_8,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_9        AS Ind_Req_Week_9,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_10       AS Ind_Req_Week_10,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_11       AS Ind_Req_Week_11,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_12       AS Ind_Req_Week_12,
    RCCP_BASIC_IND_SC_SO.Ind_Req_Week_13       AS Ind_Req_Week_13,
    RCCP_BASIC_IND_SC_SO.Three_Sigma           AS Three_Sigma,
    RCCP_BASIC_IND_SC_SO.Three_Sigma_Load      AS Three_Sigma_Load,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_1  AS SHOPPING_CART_WEEK_1,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_2  AS SHOPPING_CART_WEEK_2,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_3  AS SHOPPING_CART_WEEK_3,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_4  AS SHOPPING_CART_WEEK_4,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_5  AS SHOPPING_CART_WEEK_5,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_6  AS SHOPPING_CART_WEEK_6,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_7  AS SHOPPING_CART_WEEK_7,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_8  AS SHOPPING_CART_WEEK_8,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_9  AS SHOPPING_CART_WEEK_9,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_10 AS SHOPPING_CART_WEEK_10,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_11 AS SHOPPING_CART_WEEK_11,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_12 AS SHOPPING_CART_WEEK_12,
    RCCP_BASIC_IND_SC_SO.SHOPPING_CART_WEEK_13 AS SHOPPING_CART_WEEK_13,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_1    AS SALES_ORDER_WEEK_1,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_2    AS SALES_ORDER_WEEK_2,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_3    AS SALES_ORDER_WEEK_3,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_4    AS SALES_ORDER_WEEK_4,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_5    AS SALES_ORDER_WEEK_5,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_6    AS SALES_ORDER_WEEK_6,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_7    AS SALES_ORDER_WEEK_7,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_8    AS SALES_ORDER_WEEK_8,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_9    AS SALES_ORDER_WEEK_9,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_10   AS SALES_ORDER_WEEK_10,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_11   AS SALES_ORDER_WEEK_11,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_12   AS SALES_ORDER_WEEK_12,
    RCCP_BASIC_IND_SC_SO.SALES_ORDER_WEEK_13   AS SALES_ORDER_WEEK_13,
    OPEN_PLAN.WK_1                             AS OPEN_PLAN_WEEK_1,
    OPEN_PLAN.WK_2                             AS OPEN_PLAN_WEEK_2,
    OPEN_PLAN.WK_3                             AS OPEN_PLAN_WEEK_3,
    OPEN_PLAN.WK_4                             AS OPEN_PLAN_WEEK_4,
    OPEN_PLAN.WK_5                             AS OPEN_PLAN_WEEK_5,
    OPEN_PLAN.WK_6                             AS OPEN_PLAN_WEEK_6,
    OPEN_PLAN.WK_7                             AS OPEN_PLAN_WEEK_7,
    OPEN_PLAN.WK_8                             AS OPEN_PLAN_WEEK_8,
    OPEN_PLAN.WK_9                             AS OPEN_PLAN_WEEK_9,
    OPEN_PLAN.WK_10                            AS OPEN_PLAN_WEEK_10,
    OPEN_PLAN.WK_11                            AS OPEN_PLAN_WEEK_11,
    OPEN_PLAN.WK_12                            AS OPEN_PLAN_WEEK_12,
    OPEN_PLAN.WK_13                            AS OPEN_PLAN_WEEK_13
  FROM
    (SELECT RCCP_BASIC_IND_SC.ID              AS ID,
      RCCP_BASIC_IND_SC.LAST_REVIEW           AS LAST_REVIEW,
      RCCP_BASIC_IND_SC.MATERIAL              AS MATERIAL,
      RCCP_BASIC_IND_SC.CATALOG_DASH          AS CATALOG_DASH,
      RCCP_BASIC_IND_SC.PLANT                 AS PLANT,
      RCCP_BASIC_IND_SC.MATERIAL_DES          AS MATERIAL_DES,
      RCCP_BASIC_IND_SC.MRP_CONTROLLER        AS MRP_CONTROLLER,
      RCCP_BASIC_IND_SC.STRATEGY_GRP          AS STRATEGY_GRP,
      RCCP_BASIC_IND_SC.SAFETY_STOCK          AS SAFETY_STOCK,
      RCCP_BASIC_IND_SC.OH_QTY                AS OH_QTY,
      RCCP_BASIC_IND_SC.UNIT                  AS UNIT,
      RCCP_BASIC_IND_SC.UNIT_COST             AS UNIT_COST,
      RCCP_BASIC_IND_SC.PROD_BU               AS PROD_BU,
      RCCP_BASIC_IND_SC.SP                    AS SP,
      RCCP_BASIC_IND_SC.VENDOR                AS VENDOR,
      RCCP_BASIC_IND_SC.MIN_INV               AS MIN_INV,
      RCCP_BASIC_IND_SC.TARGET_INV            AS TARGET_INV,
      RCCP_BASIC_IND_SC.MAX_INV               AS MAX_INV,
      RCCP_BASIC_IND_SC.Ind_Req_AVG           AS Ind_Req_AVG,
      RCCP_BASIC_IND_SC.Ind_Req_AVG_50        AS Ind_Req_AVG_50,
      RCCP_BASIC_IND_SC.Ind_Req_AVG_25        AS Ind_Req_AVG_25,
      RCCP_BASIC_IND_SC.Ind_Req_Week_1        AS Ind_Req_Week_1,
      RCCP_BASIC_IND_SC.Ind_Req_Week_2        AS Ind_Req_Week_2,
      RCCP_BASIC_IND_SC.Ind_Req_Week_3        AS Ind_Req_Week_3,
      RCCP_BASIC_IND_SC.Ind_Req_Week_4        AS Ind_Req_Week_4,
      RCCP_BASIC_IND_SC.Ind_Req_Week_5        AS Ind_Req_Week_5,
      RCCP_BASIC_IND_SC.Ind_Req_Week_6        AS Ind_Req_Week_6,
      RCCP_BASIC_IND_SC.Ind_Req_Week_7        AS Ind_Req_Week_7,
      RCCP_BASIC_IND_SC.Ind_Req_Week_8        AS Ind_Req_Week_8,
      RCCP_BASIC_IND_SC.Ind_Req_Week_9        AS Ind_Req_Week_9,
      RCCP_BASIC_IND_SC.Ind_Req_Week_10       AS Ind_Req_Week_10,
      RCCP_BASIC_IND_SC.Ind_Req_Week_11       AS Ind_Req_Week_11,
      RCCP_BASIC_IND_SC.Ind_Req_Week_12       AS Ind_Req_Week_12,
      RCCP_BASIC_IND_SC.Ind_Req_Week_13       AS Ind_Req_Week_13,
      RCCP_BASIC_IND_SC.Three_Sigma           AS Three_Sigma,
      RCCP_BASIC_IND_SC.Three_Sigma_Load      AS Three_Sigma_Load,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_1  AS SHOPPING_CART_WEEK_1,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_2  AS SHOPPING_CART_WEEK_2,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_3  AS SHOPPING_CART_WEEK_3,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_4  AS SHOPPING_CART_WEEK_4,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_5  AS SHOPPING_CART_WEEK_5,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_6  AS SHOPPING_CART_WEEK_6,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_7  AS SHOPPING_CART_WEEK_7,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_8  AS SHOPPING_CART_WEEK_8,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_9  AS SHOPPING_CART_WEEK_9,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_10 AS SHOPPING_CART_WEEK_10,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_11 AS SHOPPING_CART_WEEK_11,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_12 AS SHOPPING_CART_WEEK_12,
      RCCP_BASIC_IND_SC.SHOPPING_CART_WEEK_13 AS SHOPPING_CART_WEEK_13,
      SALES_OPEN.SALES_ORDER_WEEK_1           AS SALES_ORDER_WEEK_1,
      SALES_OPEN.SALES_ORDER_WEEK_2           AS SALES_ORDER_WEEK_2,
      SALES_OPEN.SALES_ORDER_WEEK_3           AS SALES_ORDER_WEEK_3,
      SALES_OPEN.SALES_ORDER_WEEK_4           AS SALES_ORDER_WEEK_4,
      SALES_OPEN.SALES_ORDER_WEEK_5           AS SALES_ORDER_WEEK_5,
      SALES_OPEN.SALES_ORDER_WEEK_6           AS SALES_ORDER_WEEK_6,
      SALES_OPEN.SALES_ORDER_WEEK_7           AS SALES_ORDER_WEEK_7,
      SALES_OPEN.SALES_ORDER_WEEK_8           AS SALES_ORDER_WEEK_8,
      SALES_OPEN.SALES_ORDER_WEEK_9           AS SALES_ORDER_WEEK_9,
      SALES_OPEN.SALES_ORDER_WEEK_10          AS SALES_ORDER_WEEK_10,
      SALES_OPEN.SALES_ORDER_WEEK_11          AS SALES_ORDER_WEEK_11,
      SALES_OPEN.SALES_ORDER_WEEK_12          AS SALES_ORDER_WEEK_12,
      SALES_OPEN.SALES_ORDER_WEEK_13          AS SALES_ORDER_WEEK_13
    FROM
      (SELECT RCCP_BASIC_IND.ID             AS ID,
        RCCP_BASIC_IND.LAST_REVIEW          AS LAST_REVIEW,
        RCCP_BASIC_IND.MATERIAL             AS MATERIAL,
        RCCP_BASIC_IND.CATALOG_DASH         AS CATALOG_DASH,
        RCCP_BASIC_IND.PLANT                AS PLANT,
        RCCP_BASIC_IND.MATERIAL_DES         AS MATERIAL_DES,
        RCCP_BASIC_IND.MRP_CONTROLLER       AS MRP_CONTROLLER,
        RCCP_BASIC_IND.STRATEGY_GRP         AS STRATEGY_GRP,
        RCCP_BASIC_IND.SAFETY_STOCK         AS SAFETY_STOCK,
        RCCP_BASIC_IND.OH_QTY               AS OH_QTY,
        RCCP_BASIC_IND.UNIT                 AS UNIT,
        RCCP_BASIC_IND.UNIT_COST            AS UNIT_COST,
        RCCP_BASIC_IND.PROD_BU              AS PROD_BU,
        RCCP_BASIC_IND.SP                   AS SP,
        RCCP_BASIC_IND.VENDOR               AS VENDOR,
        RCCP_BASIC_IND.MIN_INV              AS MIN_INV,
        RCCP_BASIC_IND.TARGET_INV           AS TARGET_INV,
        RCCP_BASIC_IND.MAX_INV              AS MAX_INV,
        RCCP_BASIC_IND.Ind_Req_AVG          AS Ind_Req_AVG,
        RCCP_BASIC_IND.Ind_Req_AVG_50       AS Ind_Req_AVG_50,
        RCCP_BASIC_IND.Ind_Req_AVG_25       AS Ind_Req_AVG_25,
        RCCP_BASIC_IND.Ind_Req_Week_1       AS Ind_Req_Week_1,
        RCCP_BASIC_IND.Ind_Req_Week_2       AS Ind_Req_Week_2,
        RCCP_BASIC_IND.Ind_Req_Week_3       AS Ind_Req_Week_3,
        RCCP_BASIC_IND.Ind_Req_Week_4       AS Ind_Req_Week_4,
        RCCP_BASIC_IND.Ind_Req_Week_5       AS Ind_Req_Week_5,
        RCCP_BASIC_IND.Ind_Req_Week_6       AS Ind_Req_Week_6,
        RCCP_BASIC_IND.Ind_Req_Week_7       AS Ind_Req_Week_7,
        RCCP_BASIC_IND.Ind_Req_Week_8       AS Ind_Req_Week_8,
        RCCP_BASIC_IND.Ind_Req_Week_9       AS Ind_Req_Week_9,
        RCCP_BASIC_IND.Ind_Req_Week_10      AS Ind_Req_Week_10,
        RCCP_BASIC_IND.Ind_Req_Week_11      AS Ind_Req_Week_11,
        RCCP_BASIC_IND.Ind_Req_Week_12      AS Ind_Req_Week_12,
        RCCP_BASIC_IND.Ind_Req_Week_13      AS Ind_Req_Week_13,
        RCCP_BASIC_IND.Three_Sigma          AS Three_Sigma,
        RCCP_BASIC_IND.Three_Sigma_Load     AS Three_Sigma_Load,
        SHOPPING_CART.SHOPPING_CART_WEEK_1  AS SHOPPING_CART_WEEK_1,
        SHOPPING_CART.SHOPPING_CART_WEEK_2  AS SHOPPING_CART_WEEK_2,
        SHOPPING_CART.SHOPPING_CART_WEEK_3  AS SHOPPING_CART_WEEK_3,
        SHOPPING_CART.SHOPPING_CART_WEEK_4  AS SHOPPING_CART_WEEK_4,
        SHOPPING_CART.SHOPPING_CART_WEEK_5  AS SHOPPING_CART_WEEK_5,
        SHOPPING_CART.SHOPPING_CART_WEEK_6  AS SHOPPING_CART_WEEK_6,
        SHOPPING_CART.SHOPPING_CART_WEEK_7  AS SHOPPING_CART_WEEK_7,
        SHOPPING_CART.SHOPPING_CART_WEEK_8  AS SHOPPING_CART_WEEK_8,
        SHOPPING_CART.SHOPPING_CART_WEEK_9  AS SHOPPING_CART_WEEK_9,
        SHOPPING_CART.SHOPPING_CART_WEEK_10 AS SHOPPING_CART_WEEK_10,
        SHOPPING_CART.SHOPPING_CART_WEEK_11 AS SHOPPING_CART_WEEK_11,
        SHOPPING_CART.SHOPPING_CART_WEEK_12 AS SHOPPING_CART_WEEK_12,
        SHOPPING_CART.SHOPPING_CART_WEEK_13 AS SHOPPING_CART_WEEK_13
      FROM
        (SELECT ID        AS ID,
          LAST_REVIEW     AS LAST_REVIEW,
          MATERIAL        AS MATERIAL,
          CATALOG_DASH    AS CATALOG_DASH,
          PLANT           AS PLANT,
          MAT_DESC        AS MATERIAL_DES,
          MRP_CONTROLLER  AS MRP_CONTROLLER,
          STRATEGY_GRP    AS STRATEGY_GRP,
          SAFETY_STOCK    AS SAFETY_STOCK,
          OH_QTY          AS OH_QTY,
          UNIT            AS UNIT,
          UNIT_COST       AS UNIT_COST,
          PROD_BU         AS PROD_BU,
          ULTIMATE_SOURCE AS SP,
          VENDOR_KEY      AS VENDOR,
          MIN_INV         AS MIN_INV,
          TARGET_INV      AS TARGET_INV,
          MAX_INV         AS MAX_INV,
          0               AS Ind_Req_AVG,
          0               AS Ind_Req_AVG_50,
          0               AS Ind_Req_AVG_25,
          0               AS Ind_Req_Week_1,
          0               AS Ind_Req_Week_2,
          0               AS Ind_Req_Week_3,
          0               AS Ind_Req_Week_4,
          0               AS Ind_Req_Week_5,
          0               AS Ind_Req_Week_6,
          0               AS Ind_Req_Week_7,
          0               AS Ind_Req_Week_8,
          0               AS Ind_Req_Week_9,
          0               AS Ind_Req_Week_10,
          0               AS Ind_Req_Week_11,
          0               AS Ind_Req_Week_12,
          0               AS Ind_Req_Week_13,
          0               AS Three_Sigma,
          0               AS Three_Sigma_Load
        FROM VIEW_INV_SAP_PP_OPT_X
        WHERE PLANT IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
        )RCCP_BASIC_IND
      LEFT JOIN
        (SELECT ID AS ID,
          WK_1     AS SHOPPING_CART_WEEK_1,
          WK_2     AS SHOPPING_CART_WEEK_2,
          WK_3     AS SHOPPING_CART_WEEK_3,
          WK_4     AS SHOPPING_CART_WEEK_4,
          WK_5     AS SHOPPING_CART_WEEK_5,
          WK_6     AS SHOPPING_CART_WEEK_6,
          WK_7     AS SHOPPING_CART_WEEK_7,
          WK_8     AS SHOPPING_CART_WEEK_8,
          WK_9     AS SHOPPING_CART_WEEK_9,
          WK_10    AS SHOPPING_CART_WEEK_10,
          WK_11    AS SHOPPING_CART_WEEK_11,
          WK_12    AS SHOPPING_CART_WEEK_12,
          WK_13    AS SHOPPING_CART_WEEK_13
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
          )
        )SHOPPING_CART
      ON SHOPPING_CART.ID = RCCP_BASIC_IND.ID
      )RCCP_BASIC_IND_SC
    LEFT JOIN
      (SELECT ID,
        MATERIALID,
        SUM(WEEK_1)  AS SALES_ORDER_WEEK_1,
        SUM(WEEK_2)  AS SALES_ORDER_WEEK_2,
        SUM(WEEK_3)  AS SALES_ORDER_WEEK_3,
        SUM(WEEK_4)  AS SALES_ORDER_WEEK_4,
        SUM(WEEK_5)  AS SALES_ORDER_WEEK_5,
        SUM(WEEK_6)  AS SALES_ORDER_WEEK_6,
        SUM(WEEK_7)  AS SALES_ORDER_WEEK_7,
        SUM(WEEK_8)  AS SALES_ORDER_WEEK_8,
        SUM(WEEK_9)  AS SALES_ORDER_WEEK_9,
        SUM(WEEK_10) AS SALES_ORDER_WEEK_10,
        SUM(WEEK_11) AS SALES_ORDER_WEEK_11,
        SUM(WEEK_12) AS SALES_ORDER_WEEK_12,
        SUM(WEEK_13) AS SALES_ORDER_WEEK_13
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
          WHERE REQUIREDDELIVERYDATE < TO_CHAR(sysdate + 10)
          AND SALESDOCTYPE                            IN ('ZOR1','ZOR5')
          AND OPENQTY                > 0
          )
        )
      GROUP BY ID,
        MATERIALID
      )SALES_OPEN
    ON SALES_OPEN.ID = RCCP_BASIC_IND_SC.ID
    )RCCP_BASIC_IND_SC_SO
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
          DATEDELIVERY,
          PONUMBER,
          PO_OPENQTY AS OPEN_PLAN_QTY
          FROM INV_SAP_IO_INPUTS_DAILY 
        WHERE INPUT_TYPE IN ('PLAN_PD_PO','FIRM')
        AND DATEDELIVERY < TO_CHAR(sysdate + 10) AND PLANTID IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
        --SELECT * FROM  INV_SAP_IO_INPUTS_DAILY WHERE MATERIALID = '1769-OW16 A' AND PLANTID = '5040' AND PONUMBER = '1554930410'
        )
      )
    GROUP BY ID,
      MATERIALID
    )OPEN_PLAN
  ON OPEN_PLAN.ID = RCCP_BASIC_IND_SC_SO.ID
  )RCCP_BAS_IND_SCSO_PL
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
ON OPEN_PO.ID = RCCP_BAS_IND_SCSO_PL.ID;

---CREATE INV_SAP_RCCP_INDREQ, USER WILL UPLOAD DATA TO THIS TABLE.
DROP TABLE INV_SAP_RCCP_INDREQ;
CREATE TABLE INV_SAP_RCCP_INDREQ 
(
  PLANT VARCHAR2(20) NOT NULL 
, MAP_CONTROLLER VARCHAR2(200) 
, MATERIAL VARCHAR2(200) 
, ELEMENT_INDICATOR VARCHAR2(20) 
, IND_REQ_WK_0 NUMBER 
, IND_REQ_WK_1 NUMBER 
, IND_REQ_WK_2 NUMBER 
, IND_REQ_WK_3 NUMBER 
, IND_REQ_WK_4 NUMBER 
, IND_REQ_WK_5 NUMBER 
, IND_REQ_WK_6 NUMBER 
, IND_REQ_WK_7 NUMBER 
, IND_REQ_WK_8 NUMBER 
, IND_REQ_WK_9 NUMBER 
, IND_REQ_WK_10 NUMBER 
, IND_REQ_WK_11 NUMBER 
, IND_REQ_WK_12 NUMBER 
);



GRC 5040
HK   5050
India  5070
Tai Wan  5110
Malaysia  5120
Philippines   5160
Thailand   5190
SGP      5200  





SELECT MATERIALID
  ||'_'
  ||PLANTID AS ID,
  MATERIALID,
  CASE WHEN INPUT_TYPE = 'PLAN_PD_PO'
  THEN 'PLAN_ODR'
  ELSE 'FIRM'
  END ORDER_TYPE,
  PLANTID,
  DATEDELIVERY,
  PONUMBER,
  PO_OPENQTY AS OPEN_PLAN_QTY
FROM INV_SAP_IO_INPUTS_DAILY
WHERE INPUT_TYPE                   IN ('PLAN_PD_PO','FIRM') AND MATERIAL = '196477'
AND DATEDELIVERY  < TO_CHAR(sysdate + 42)
AND PLANTID                        IN ('5040', '5050', '5110', '5120', '5160', '5190', '5200','5070')



SELECT *
FROM INV_SAP_IO_INPUTS_DAILY
WHERE INPUT_TYPE                   IN ('PLAN_PD_PO','FIRM') AND MATERIALID = '196477'
AND DATEDELIVERY  < TO_CHAR(sysdate + 42)
AND PLANTID                        IN ('5050')
