--- SVD Report 6/20/2014
--	Limit data by only taking materials with SG 40 and Z4
--	Mtype is ZTG and ZFG only
--'5041', '5051', '5101', '5111', '5121', '5161', '5191', '5201','5071','5141'
--'5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140'
--New Version of the SVD Reports
--Material
--Ship Plant
--Supply Plant
--Business Unit
--Strategy Group
--Safety Stock
--Weekly Usage (Avg 13wks)
--Weekly Forecast (Avg 13wks)
--DC On Hand Inventory
--In Transit to DC
--Past Due
--Due within Transit
--Due outside Transit till 13 wks
--Due outside 13 wks
--No Due Date
--Days of Supply
--13wk Intake vs Forecast
--Issue Indicator
--Planner Review Comment
--Last Comment Date
--USE STEPS
TRUNCATE TABLE INV_SAP_ITEM_SO_STAT;
INSERT INTO INV_SAP_ITEM_SO_STAT SELECT * FROM VIEW_INV_SAP_IMSO_LTIN13TMP;
INSERT INTO INV_SAP_ITEM_SO_STAT SELECT * FROM VIEW_INV_SAP_IMSO_LTOUT13TMP;
SELECT * FROM INV_SAP_ITEM_SO_STAT WHERE ID = '1756-IB16 A_5040'
--COMMENT 
CREATE TABLE INV_SAP_SVD_REPORT_COMMENT;
UPDATE p SET p1 = p1+1; --UPDATE COMMENT TO INV_SAP_SVD_REPORT;

--FINAL DOWNLOAD THE REPORT FORM THE DW..
SELECT * FROM INV_SAP_SVD_REPORT;

--INI SETUP
CREATE TABLE INV_SAP_ITEM_SO_STAT AS
SELECT * FROM VIEW_INV_SAP_IMSO_LTIN13TMP;
INSERT INTO INV_SAP_ITEM_SO_STAT SELECT * FROM VIEW_INV_SAP_SVD_REPORT;



--SALES OPEN STATUS
---DOUBLE CLICK AND SHOW THE RESULT
--TOT OPEN
SELECT * FROM VIEW_INV_SAP_OPEN_SO;
--PAST DUE 
SELECT * FROM VIEW_INV_SAP_OPEN_SO WHERE COMMITTED_DATE < SYSDATE - 1;
--WITH IN LT
--LEADTIME NEED TO CHANGE BY LT
SELECT * FROM VIEW_INV_SAP_OPEN_SO WHERE COMMITTED_DATE BETWEEN TO_CHAR(SYSDATE) AND TO_CHAR(SYSDATE-LEADTIME);
--LT - 13WEEKS
--LOWER THAN 13WEEKS
SELECT * FROM VIEW_INV_SAP_OPEN_SO WHERE COMMITTED_DATE BETWEEN TO_CHAR(SYSDATE - LEADTIME) AND TO_CHAR(SYSDATE-91);
--NO COMMITTED DATE
SELECT * FROM VIEW_INV_SAP_OPEN_SO WHERE COMMITTED_DATE IS NULL;

DROP VIEW VIEW_INV_SAP_SVD_REPORT;
DROP TABLE INV_SAP_SVD_REPORT;
SELECT * FROM VIEW_INV_SAP_SVD_REPORT;
SELECT * FROM INV_SAP_SVD_REPORT WHERE TOT_OPEN_QTY <> 0 OR  STOCK_IN_TRANSIT_QTY <> 0 OR OH_QTY <> 0;
CREATE TABLE INV_SAP_SVD_REPORT AS 
SELECT * FROM VIEW_INV_SAP_SVD_REPORT;
CREATE VIEW VIEW_INV_SAP_SVD_REPORT AS
SELECT SPPX_FC_TRIN_OPEN_NOCM.ID                                                                                                       AS ID,
  SPPX_FC_TRIN_OPEN_NOCM.MATERIAL                                                                                                      AS MATERIAL,
  SPPX_FC_TRIN_OPEN_NOCM.CATALOG_DASH                                                                                                  AS CATALOG_DASH,
  SPPX_FC_TRIN_OPEN_NOCM.PLANT                                                                                                         AS PLANT,
  SPPX_FC_TRIN_OPEN_NOCM.VENDOR                                                                                                        AS VENDOR,
  SPPX_FC_TRIN_OPEN_NOCM.BU                                                                                                            AS BU,
  NVL(SPPX_FC_TRIN_OPEN_NOCM.LEAD_TIME,0)                                                                                              AS LEAD_TIME,
  SPPX_FC_TRIN_OPEN_NOCM.STRATEGY_GRP                                                                                                  AS STRATEGY_GRP,
  NVL(SPPX_FC_TRIN_OPEN_NOCM.SAFETY_STOCK,0)                                                                                           AS SAFETY_STOCK,
  NVL(SPPX_FC_TRIN_OPEN_NOCM.AVG13_USAGE_QTY,0)                                                                                        AS AVG13_USAGE_QTY,
  NVL(SPPX_FC_TRIN_OPEN_NOCM.FC_AVG13_WEEK_QTY,0)                                                                                      AS FC_AVG13_WEEK_QTY,
  NVL(SPPX_FC_TRIN_OPEN_NOCM.OH_QTY,0)                                                                                                 AS OH_QTY,
  NVL(SPPX_FC_TRIN_OPEN_NOCM.STOCK_IN_TRANSIT_QTY,0)                                                                                   AS STOCK_IN_TRANSIT_QTY,
  NVL(SPPX_FC_TRIN_OPEN_NOCM.TOT_OPEN_QTY,0)                                                                                           AS TOT_OPEN_QTY,
  NVL(SO_STAT.PASS_DUE_QTY,0)                                                                                                          AS PASS_DUE_QTY,
  NVL(SO_STAT.LT_OPEN_QTY,0)                                                                                                           AS LT_OPEN_QTY,
  NVL(SO_STAT.LT_WEEKS13_OPEN_QTY,0)                                                                                                   AS LT_WEEKS13_OPEN_QTY,
  NVL(SO_STAT.OUT_WEEKS13_OPEN_QTY,0)                                                                                                  AS OUT_WEEKS13_OPEN_QTY,
  NVL(SPPX_FC_TRIN_OPEN_NOCM.TOT_NO_COMMITTED_DATE_QTY,0)                                                                              AS TOT_NO_COMMITTED_DATE_QTY,
  NVL(SPPX_FC_TRIN_OPEN_NOCM.TOT_OPEN_QTY,0)+NVL(SPPX_FC_TRIN_OPEN_NOCM.STOCK_IN_TRANSIT_QTY,0)+ NVL(SPPX_FC_TRIN_OPEN_NOCM.OH_QTY, 0) AS CHECK_KEY
FROM
  (SELECT SPPX_FC_TRIN_OPEN.ID,
    SPPX_FC_TRIN_OPEN.MATERIAL,
    SPPX_FC_TRIN_OPEN.CATALOG_DASH,
    SPPX_FC_TRIN_OPEN.PLANT,
    SPPX_FC_TRIN_OPEN.VENDOR,
    SPPX_FC_TRIN_OPEN.BU,
    SPPX_FC_TRIN_OPEN.STRATEGY_GRP,
    SPPX_FC_TRIN_OPEN.SAFETY_STOCK,
    SPPX_FC_TRIN_OPEN.AVG13_USAGE_QTY,
    SPPX_FC_TRIN_OPEN.LEAD_TIME,
    SPPX_FC_TRIN_OPEN.FC_AVG13_WEEK_QTY,
    SPPX_FC_TRIN_OPEN.OH_QTY,
    SPPX_FC_TRIN_OPEN.STOCK_IN_TRANSIT_QTY,
    SPPX_FC_TRIN_OPEN.TOT_OPEN_QTY,
    NO_COMMITTED_DATE.TOT_NO_COMMITTED_DATE_QTY
  FROM
    (SELECT SPPX_FC_TRIN.ID,
      SPPX_FC_TRIN.MATERIAL,
      SPPX_FC_TRIN.CATALOG_DASH,
      SPPX_FC_TRIN.PLANT,
      SPPX_FC_TRIN.VENDOR,
      SPPX_FC_TRIN.BU,
      SPPX_FC_TRIN.STRATEGY_GRP,
      SPPX_FC_TRIN.SAFETY_STOCK,
      SPPX_FC_TRIN.AVG13_USAGE_QTY,
      SPPX_FC_TRIN.LEAD_TIME,
      SPPX_FC_TRIN.FC_AVG13_WEEK_QTY,
      SPPX_FC_TRIN.OH_QTY,
      SPPX_FC_TRIN.STOCK_IN_TRANSIT_QTY,
      TOT_OPEN.TOT_OPEN_QTY
    FROM
      (SELECT PPX_FC.ID,
        PPX_FC.MATERIAL,
        PPX_FC.CATALOG_DASH,
        PPX_FC.PLANT,
        PPX_FC.VENDOR,
        PPX_FC.BU,
        PPX_FC.STRATEGY_GRP,
        PPX_FC.SAFETY_STOCK,
        PPX_FC.AVG13_USAGE_QTY,
        PPX_FC.LEAD_TIME,
        PPX_FC.FC_AVG13_WEEK_QTY,
        PPX_FC.OH_QTY,
        STOCK_IN_TRAINST.STOCK_IN_TRANSIT_QTY
      FROM
        (SELECT SALES_PP_X.ID,
          SALES_PP_X.MATERIAL,
          SALES_PP_X.CATALOG_DASH,
          SALES_PP_X.PLANT,
          SALES_PP_X.VENDOR,
          SALES_PP_X.BU,
          SALES_PP_X.STRATEGY_GRP,
          SALES_PP_X.SAFETY_STOCK,
          SALES_PP_X.AVG13_USAGE_QTY,
          SALES_PP_X.LEAD_TIME,
          FC_AVG13_WEEK.FC_AVG13_WEEK_QTY,
          SALES_PP_X.OH_QTY
        FROM
          (SELECT ID,
            MATERIAL,
            PLANT,
            CATALOG_DASH,
            SAFETY_STOCK,
            OH_QTY,
            STRATEGY_GRP,
            SUBSTR(VENDOR_KEY,0,4) AS VENDOR,
            SUBSTR(PROD_BU,0,3)    AS BU,
            AVG13_USAGE_QTY,
            LEAD_TIME
          FROM VIEW_INV_SAP_PP_OPT_X
          WHERE MATL_TYPE IN ('ZTG','ZFG')
          AND PLANT       IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
          )SALES_PP_X
        LEFT JOIN
          ---FC 13 WEEKS AVG
          (
          SELECT MATERIALID
            ||'_'
            ||PLANTID                           AS ID,
            MATERIALID                          AS MATERIALID,
            PLANTID                             AS PLANTID,
            CEIL(SUM(PLNMG_PLANNEDQUANTITY)/13) AS FC_AVG13_WEEK_QTY
          FROM INV_SAP_PP_FRCST_PBIM_PBED
          WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 91))
          AND VERSBP_VERSION = '00'
          GROUP BY MATERIALID,
            PLANTID
          )FC_AVG13_WEEK
        ON SALES_PP_X.ID = FC_AVG13_WEEK.ID
        )PPX_FC
      LEFT JOIN
        (
        --Stock In Stransit To DC
        SELECT MATERIALID
          ||'_'
          ||PLANTID AS ID,
          MATERIALID,
          PLANTID,
          SUM(DELIVERY_QTY_SUOM) AS STOCK_IN_TRANSIT_QTY
        FROM INV_SAP_LIKP_LIPS_DAILY
        WHERE REFERENCE_DOC_TRIM IN
          (SELECT EBELNPURCHDOCNO
          FROM INV_SAP_PP_PO_HISTORY
          WHERE DELIVERYCOMPLETE IS NULL
          )
        AND CHANGED_ON_DATE IS NULL --THIS DATA IS IMPORTANT. IT SHOW THE REAL QTY IN TRANSIT.
        GROUP BY MATERIALID,
          MATERIALID,
          PLANTID
        )STOCK_IN_TRAINST
      ON STOCK_IN_TRAINST.ID = PPX_FC.ID
      )SPPX_FC_TRIN
    LEFT JOIN
      --TOT OPEN
      (
      SELECT MATERIAL
        ||'_'
        || PLANT AS ID,
        MATERIAL,
        PLANT,
        NVL(SUM(OPEN_QTY),0) AS TOT_OPEN_QTY
      FROM INV_SAP_SALES_VBAK_VBAP_VBUP
      GROUP BY 
        MATERIAL,
        PLANT
      )TOT_OPEN
    ON TOT_OPEN.ID = SPPX_FC_TRIN.ID
    )SPPX_FC_TRIN_OPEN
  LEFT JOIN
    --TOT NO_COMMITTED_DATE
    (
    SELECT MATERIAL
      ||'_'
      || PLANT AS ID,
      MATERIAL,
      PLANT,
      NVL(SUM(OPEN_QTY),0) AS TOT_NO_COMMITTED_DATE_QTY
    FROM INV_SAP_SALES_VBAK_VBAP_VBUP
    WHERE MAX_COMMIT_DATE IS NULL 
    GROUP BY 
      MATERIAL,
      PLANT
    )NO_COMMITTED_DATE
  ON NO_COMMITTED_DATE.ID = SPPX_FC_TRIN_OPEN.ID
  )SPPX_FC_TRIN_OPEN_NOCM
LEFT JOIN
  (SELECT ID,
    MATERIAL,
    PLANT,
    LEAD_TIME,
    PASS_DUE_QTY,
    LT_OPEN_QTY,
    LT_WEEKS13_OPEN_QTY,
    OUT_WEEKS13_OPEN_QTY
  FROM INV_SAP_ITEM_SO_STAT
  )SO_STAT
ON SO_STAT.ID = SPPX_FC_TRIN_OPEN_NOCM.ID;

--CREATE CALCULATE TABLE FOR SALES ORDER STATISTICS
--Statics of Sales Order

CREATE VIEW VIEW_INV_SAP_IMSO_LTIN13TMP AS
SELECT ID,
  MATERIAL,
  PLANT,
  LEAD_TIME,
  PASS_DUE             AS PASS_DUE_QTY,
  (LT_OPEN             - PASS_DUE) AS LT_OPEN_QTY,
  (LT_WEEKS13_OPEN - LT_OPEN)  AS LT_WEEKS13_OPEN_QTY,
  OUT_WEEKS13_OPEN                     AS OUT_WEEKS13_OPEN_QTY
FROM
  (SELECT ID,
    MATERIAL,
    PLANT,
    LEAD_TIME,
    SUM(PASS_DUE)            AS PASS_DUE,
    SUM(LT_OPEN)             AS LT_OPEN,
    SUM(LT_WEEKS13_OPEN) AS LT_WEEKS13_OPEN,
    SUM(OUT_WEEKS13_OPEN)        AS OUT_WEEKS13_OPEN
  FROM
    (SELECT ID,
      SALES_DOC,
      MATERIAL,
      PLANT,
      LEAD_TIME,
      CASE
        WHEN COMMITTED_DATE < SYSDATE - 1
        THEN OPEN_QTY
        ELSE 0
      END PASS_DUE,
      CASE
        WHEN COMMITTED_DATE < SYSDATE + LEAD_TIME
        THEN OPEN_QTY
        ELSE 0
      END LT_OPEN,
      CASE
        WHEN COMMITTED_DATE < SYSDATE + 91
        THEN OPEN_QTY
        ELSE 0
      END LT_WEEKS13_OPEN,
      CASE
        WHEN COMMITTED_DATE > SYSDATE + 91
        THEN OPEN_QTY
        ELSE 0
      END OUT_WEEKS13_OPEN
    FROM
      (SELECT SALES_OPEN.ID,
        SALES_OPEN.SALES_DOC,
        SALES_OPEN.MATERIAL,
        SALES_OPEN.PLANT,
        SALES_OPEN.OPEN_QTY,
        SALES_OPEN.COMMITTED_DATE,
        ITEM_LT.LEAD_TIME
      FROM (
        (SELECT ID,
          SALES_DOC,
          MATERIAL,
          PLANT,
          OPEN_QTY,
          COMMITTED_DATE
        FROM VIEW_INV_SAP_OPEN_SO
        )SALES_OPEN
      LEFT JOIN
        (SELECT ID, MATERIAL, LEAD_TIME FROM VIEW_INV_SAP_PP_OPT_X
        )ITEM_LT
      ON SALES_OPEN.ID = ITEM_LT.ID)
      )WHERE LEAD_TIME < 91
    )
  GROUP BY ID,
    MATERIAL,
    PLANT,
    LEAD_TIME
  );

--CREATE CALCULATE TABLE FOR SALES ORDER STATISTICS
--Statics of Sales Order
CREATE VIEW VIEW_INV_SAP_IMSO_LTOUT13TMP AS
SELECT ID,
  MATERIAL,
  PLANT,
  LEAD_TIME,
  PASS_DUE             AS PASS_DUE_QTY,
  (LT_OPEN             - PASS_DUE) AS LT_OPEN_QTY,
  0  AS LT_WEEKS13_OPEN_QTY,
  OUT_WEEKS13_OPEN                     AS OUT_WEEKS13_OPEN_QTY
FROM
  (SELECT ID,
    MATERIAL,
    PLANT,
    LEAD_TIME,
    SUM(PASS_DUE)            AS PASS_DUE,
    SUM(LT_OPEN)             AS LT_OPEN,
    SUM(OUT_WEEKS13_OPEN)        AS OUT_WEEKS13_OPEN
  FROM
    (SELECT ID,
      SALES_DOC,
      MATERIAL,
      PLANT,
      LEAD_TIME,
      CASE
        WHEN COMMITTED_DATE < SYSDATE - 1
        THEN OPEN_QTY
        ELSE 0
      END PASS_DUE,
      CASE
        WHEN COMMITTED_DATE < SYSDATE + LEAD_TIME
        THEN OPEN_QTY
        ELSE 0
      END LT_OPEN,
      CASE
        WHEN COMMITTED_DATE > SYSDATE + 91
        THEN OPEN_QTY
        ELSE 0
      END OUT_WEEKS13_OPEN
    FROM
      (SELECT SALES_OPEN.ID,
        SALES_OPEN.SALES_DOC,
        SALES_OPEN.MATERIAL,
        SALES_OPEN.PLANT,
        SALES_OPEN.OPEN_QTY,
        SALES_OPEN.COMMITTED_DATE,
        ITEM_LT.LEAD_TIME
      FROM (
        (SELECT ID,
          SALES_DOC,
          MATERIAL,
          PLANT,
          OPEN_QTY,
          COMMITTED_DATE
        FROM VIEW_INV_SAP_OPEN_SO
        )SALES_OPEN
      LEFT JOIN
        (SELECT ID, MATERIAL, LEAD_TIME FROM VIEW_INV_SAP_PP_OPT_X
        )ITEM_LT
      ON SALES_OPEN.ID = ITEM_LT.ID)
      )WHERE LEAD_TIME > 91
    )
  GROUP BY ID,
    MATERIAL,
    PLANT,
    LEAD_TIME
  );
