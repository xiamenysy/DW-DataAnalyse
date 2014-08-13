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
--COMMENT 

--1 clear all data in tmp
TRUNCATE TABLE INV_SAP_SVD_COMMENTS_TMP;
--2 Upload to tmp first
INSERT
INTO INV_SAP_SVD_COMMENTS_TMP
  (
    ID,
    LAST_COMMENT_DATE,
    COMMENTS,
    PLANNER,
    LAST_UPDATE_DATE
  )
  VALUES
  (
    'ID_1',
    'LAST_COMMENT_DATE_1',
    'COMMENTS_1',
    'PLANNER_1',
    SYSDATE
  );
  
--3 Merge data
MERGE INTO INV_SAP_SVD_COMMENTS SVD_COM USING
(SELECT ID,
  LAST_COMMENT_DATE,
  COMMENTS,
  PLANNER,
  LAST_UPDATE_DATE
FROM INV_SAP_SVD_COMMENTS_TMP
) TMP ON ( SVD_COM.ID=TMP.ID)
WHEN MATCHED THEN
  UPDATE
  SET SVD_COM.LAST_COMMENT_DATE = TMP.LAST_COMMENT_DATE,
    SVD_COM.COMMENTS            = TMP.COMMENTS,
    SVD_COM.PLANNER             = TMP.PLANNER,
    SVD_COM.LAST_UPDATE_DATE    = TMP.LAST_UPDATE_DATE WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      TMP.ID,
      TMP.LAST_COMMENT_DATE,
      TMP.COMMENTS,
      TMP.PLANNER,
      TMP.LAST_UPDATE_DATE
    );

SELECT * FROM view_INV_SAP_PP_OPT_X WHERE PLANT = '5040'
--Delete Comments
DELETE FROM INV_SAP_SVD_COMMENTS where ID = 'ID_1';

--VIEW SVD REPORT
DROP VIEW VIEW_INV_SAP_SVD_REPORT;
CREATE TABLE INV_SAP_SVD_REPORT AS 
SELECT * FROM VIEW_INV_SAP_SVD_REPORT;
CREATE VIEW VIEW_INV_SAP_SVD_REPORT AS                                                                                                                                     AS
  SELECT SPPX_FC_TRIN_OPEN_NOCM.ID                                                                                                         AS ID,
    SPPX_FC_TRIN_OPEN_NOCM.MATERIAL                                                                                                        AS MATERIAL,
    SPPX_FC_TRIN_OPEN_NOCM.CATALOG_DASH                                                                                                    AS CATALOG_DASH,
    SPPX_FC_TRIN_OPEN_NOCM.PLANT                                                                                                           AS PLANT,
    SPPX_FC_TRIN_OPEN_NOCM.VENDOR                                                                                                          AS VENDOR,
    SPPX_FC_TRIN_OPEN_NOCM.BU                                                                                                              AS BU,
    NVL(SPPX_FC_TRIN_OPEN_NOCM.LEAD_TIME,0)                                                                                                AS LEAD_TIME,
    SPPX_FC_TRIN_OPEN_NOCM.STRATEGY_GRP                                                                                                    AS STRATEGY_GRP,
    SPPX_FC_TRIN_OPEN_NOCM.MRP_TYPE                                                                                                        AS MRP_TYPE,
    NVL(SPPX_FC_TRIN_OPEN_NOCM.SAFETY_STOCK,0)                                                                                             AS SAFETY_STOCK,
    NVL(SPPX_FC_TRIN_OPEN_NOCM.AVG13_USAGE_QTY,0)                                                                                          AS AVG13_USAGE_QTY,
    NVL(SPPX_FC_TRIN_OPEN_NOCM.FC_AVG13_WEEK_QTY,0)                                                                                        AS FC_AVG13_WEEK_QTY,
    NVL(SPPX_FC_TRIN_OPEN_NOCM.OH_QTY,0)                                                                                                   AS OH_QTY,
    NVL(SPPX_FC_TRIN_OPEN_NOCM.UNIT_COST,0)                                                                                                AS UNIT_COST,
    SPPX_FC_TRIN_OPEN_NOCM.MRP_CONTROLLER                                                                                                  AS MRP_CONTROLLER,
    NVL(SPPX_FC_TRIN_OPEN_NOCM.STOCK_IN_TRANSIT_QTY,0)                                                                                     AS STOCK_IN_TRANSIT_QTY,
    NVL(SPPX_FC_TRIN_OPEN_NOCM.TOT_OPEN_QTY,0)                                                                                             AS TOT_OPEN_QTY,
    NVL(SO_STAT.PASS_DUE_QTY,0)                                                                                                            AS PASS_DUE_QTY,
    NVL(SO_STAT.LT_OPEN_QTY,0)                                                                                                             AS LT_OPEN_QTY,
    NVL(SO_STAT.LT_WEEKS13_OPEN_QTY,0)                                                                                                     AS LT_WEEKS13_OPEN_QTY,
    NVL(SO_STAT.OUT_WEEKS13_OPEN_QTY,0)                                                                                                    AS OUT_WEEKS13_OPEN_QTY,
    NVL(SPPX_FC_TRIN_OPEN_NOCM.TOT_NO_COMMITTED_DATE_QTY,0)                                                                                AS TOT_NO_COMMITTED_DATE_QTY,
    NVL(SPPX_FC_TRIN_OPEN_NOCM.ULTIMATE_SOURCE,0)                                                                                          AS PRODUCTION_PLANT,
    (NVL(SPPX_FC_TRIN_OPEN_NOCM.TOT_OPEN_QTY,0)+NVL(SPPX_FC_TRIN_OPEN_NOCM.STOCK_IN_TRANSIT_QTY,0)+ NVL(SPPX_FC_TRIN_OPEN_NOCM.OH_QTY, 0)) AS CHECK_KEY
  FROM
    (SELECT SPPX_FC_TRIN_OPEN.ID,
      SPPX_FC_TRIN_OPEN.MATERIAL,
      SPPX_FC_TRIN_OPEN.CATALOG_DASH,
      SPPX_FC_TRIN_OPEN.PLANT,
      SPPX_FC_TRIN_OPEN.VENDOR,
      SPPX_FC_TRIN_OPEN.BU,
      SPPX_FC_TRIN_OPEN.STRATEGY_GRP,
      SPPX_FC_TRIN_OPEN.MRP_TYPE,
      SPPX_FC_TRIN_OPEN.SAFETY_STOCK,
      SPPX_FC_TRIN_OPEN.AVG13_USAGE_QTY,
      SPPX_FC_TRIN_OPEN.LEAD_TIME,
      SPPX_FC_TRIN_OPEN.FC_AVG13_WEEK_QTY,
      SPPX_FC_TRIN_OPEN.OH_QTY,
      SPPX_FC_TRIN_OPEN.UNIT_COST,
      SPPX_FC_TRIN_OPEN.MRP_CONTROLLER,
      SPPX_FC_TRIN_OPEN.ULTIMATE_SOURCE,
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
        SPPX_FC_TRIN.MRP_TYPE,
        SPPX_FC_TRIN.SAFETY_STOCK,
        SPPX_FC_TRIN.AVG13_USAGE_QTY,
        SPPX_FC_TRIN.LEAD_TIME,
        SPPX_FC_TRIN.FC_AVG13_WEEK_QTY,
        SPPX_FC_TRIN.OH_QTY,
        SPPX_FC_TRIN.UNIT_COST,
        SPPX_FC_TRIN.MRP_CONTROLLER,
        SPPX_FC_TRIN.ULTIMATE_SOURCE,
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
          PPX_FC.MRP_TYPE,
          PPX_FC.SAFETY_STOCK,
          PPX_FC.AVG13_USAGE_QTY,
          PPX_FC.LEAD_TIME,
          PPX_FC.FC_AVG13_WEEK_QTY,
          PPX_FC.UNIT_COST,
          PPX_FC.MRP_CONTROLLER,
          PPX_FC.OH_QTY,
          PPX_FC.ULTIMATE_SOURCE,
          STOCK_IN_TRAINST.STOCK_IN_TRANSIT_QTY
        FROM
          (SELECT SALES_PP_X.ID,
            SALES_PP_X.MATERIAL,
            SALES_PP_X.CATALOG_DASH,
            SALES_PP_X.PLANT,
            SALES_PP_X.VENDOR,
            SALES_PP_X.BU,
            SALES_PP_X.STRATEGY_GRP,
            SALES_PP_X.MRP_TYPE,
            SALES_PP_X.SAFETY_STOCK,
            SALES_PP_X.AVG13_USAGE_QTY,
            SALES_PP_X.LEAD_TIME,
            SALES_PP_X.UNIT_COST,
            SALES_PP_X.MRP_CONTROLLER,
            FC_AVG13_WEEK.FC_AVG13_WEEK_QTY,
            SALES_PP_X.OH_QTY,
            SALES_PP_X.ULTIMATE_SOURCE
          FROM
            (SELECT ID,
              MATERIAL,
              PLANT,
              CATALOG_DASH,
              SAFETY_STOCK,
              OH_QTY,
              STRATEGY_GRP,
              MRP_TYPE,
              SUBSTR(VENDOR_KEY,0,4) AS VENDOR,
              SUBSTR(PROD_BU,0,3)    AS BU,
              AVG13_USAGE_QTY,
              LEAD_TIME,
              UNIT_COST,
              MRP_CONTROLLER,
              ULTIMATE_SOURCE
            FROM INV_SAP_PP_OPT_X
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
        SELECT ID,
          MATERIAL,
          PLANT,
          NVL(SUM(OPEN_QTY),0) AS TOT_OPEN_QTY
        FROM INV_SAP_BACKLOG_SO
        GROUP BY ID,
          MATERIAL,
          PLANT
        )TOT_OPEN
      ON TOT_OPEN.ID = SPPX_FC_TRIN.ID
      )SPPX_FC_TRIN_OPEN
    LEFT JOIN
      --TOT NO_COMMITTED_DATE
      (
      SELECT ID,
        MATERIAL,
        PLANT,
        NVL(SUM(OPEN_QTY),0) AS TOT_NO_COMMITTED_DATE_QTY
      FROM INV_SAP_BACKLOG_SO
      WHERE COMMITTED_DATE IS NULL
      GROUP BY ID,
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




  

--VBA in Excel  
1.Clear INV_SAP_ITEM_SO_STAT table
TRUNCATE TABLE INV_SAP_ITEM_SO_STAT	
2.Insert VIEW_INV_SAP_IMSO_LTIN13TMP	
INSERT INTO INV_SAP_ITEM_SO_STAT SELECT * FROM VIEW_INV_SAP_IMSO_LTIN13TMP
3.Insert VIEW_INV_SAP_IMSO_LTOUT13TMP	
INSERT INTO INV_SAP_ITEM_SO_STAT SELECT * FROM VIEW_INV_SAP_IMSO_LTOUT13TMP
4.Fetch_Data 	
SELECT SVD_BASIC.ID,
  SVD_BASIC.MATERIAL,
  SVD_BASIC.CATALOG_DASH,
  SVD_BASIC.PLANT,
  SVD_BASIC.VENDOR,
  SVD_BASIC.PRODUCTION_PLANT,
  SVD_BASIC.BU,
  SVD_BASIC.MRP_TYPE,
  SVD_BASIC.LEAD_TIME,
  SVD_BASIC.MRP_CONTROLLER,
  SVD_BASIC.UNIT_COST,
  SVD_BASIC.STRATEGY_GRP,
  SVD_BASIC.SAFETY_STOCK,
  SVD_BASIC.AVG13_USAGE_QTY,
  SVD_BASIC.FC_AVG13_WEEK_QTY,
  SVD_BASIC.OH_QTY,
  SVD_BASIC.STOCK_IN_TRANSIT_QTY,
  SVD_BASIC.TOT_OPEN_QTY,
  SVD_BASIC.PASS_DUE_QTY,
  SVD_BASIC.LT_OPEN_QTY,
  SVD_BASIC.LT_WEEKS13_OPEN_QTY,
  SVD_BASIC.OUT_WEEKS13_OPEN_QTY,
  SVD_BASIC.TOT_NO_COMMITTED_DATE_QTY,
  SVD_BASIC.TOT_OPEN_VALUE,
  0 AS Days_of_Supply,
  0 AS wk13_Intake_fc,
  0 AS Issu_ind,
  SVD_COMM.PLANNER,
  SVD_COMM.COMMENTS,
  SVD_COMM.LAST_COMMENT_DATE
FROM
  (SELECT ID,
    MATERIAL,
    CATALOG_DASH,
    PLANT,
    VENDOR,
    BU,
    MRP_TYPE,
    LEAD_TIME,
    MRP_CONTROLLER,
    UNIT_COST,
    STRATEGY_GRP,
    SAFETY_STOCK,
    AVG13_USAGE_QTY,
    FC_AVG13_WEEK_QTY,
    PRODUCTION_PLANT,
    OH_QTY,
    STOCK_IN_TRANSIT_QTY,
    CEIL(NVL(TOT_OPEN_QTY*UNIT_COST,0)) AS TOT_OPEN_VALUE,
    TOT_OPEN_QTY,
    PASS_DUE_QTY,
    LT_OPEN_QTY,
    LT_WEEKS13_OPEN_QTY,
    OUT_WEEKS13_OPEN_QTY,
    TOT_NO_COMMITTED_DATE_QTY
  FROM VIEW_INV_SAP_SVD_REPORT
  WHERE CHECK_KEY  <> 0
  AND BU NOT       IN ('ACS', 'VIS', 'SFW', 'ESB', 'CCT', 'SSB', 'LVM', 'MVM', 'MVD')
  AND STRATEGY_GRP IN ('40','Z4')
  )SVD_BASIC
LEFT JOIN
  (SELECT ID,
    LAST_COMMENT_DATE,
    COMMENTS,
    PLANNER,
    LAST_UPDATE_DATE
  FROM INV_SAP_SVD_COMMENTS
  )SVD_COMM
ON SVD_BASIC.ID = SVD_COMM.ID
5.Clear Comments TMP	
TRUNCATE TABLE INV_SAP_SVD_COMMENTS_TMP
6.Upload to tmp	
INSERT
INTO INV_SAP_SVD_COMMENTS_TMP
  (
    ID,
    LAST_COMMENT_DATE,
    COMMENTS,
    PLANNER,
    LAST_UPDATE_DATE
  )
  VALUES
  (
    'ID_1',
    SYSDATE,
    'COMMENTS_1',
    'PLANNER_1',
    SYSDATE
  )
7.Merge into standard	
MERGE INTO INV_SAP_SVD_COMMENTS SVD_COM USING
(SELECT ID,
  LAST_COMMENT_DATE,
  COMMENTS,
  PLANNER,
  LAST_UPDATE_DATE
FROM INV_SAP_SVD_COMMENTS_TMP
) TMP ON ( SVD_COM.ID=TMP.ID)
WHEN MATCHED THEN
  UPDATE
  SET SVD_COM.LAST_COMMENT_DATE = TMP.LAST_COMMENT_DATE,
    SVD_COM.COMMENTS            = TMP.COMMENTS,
    SVD_COM.PLANNER             = TMP.PLANNER,
    SVD_COM.LAST_UPDATE_DATE    = TMP.LAST_UPDATE_DATE WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      TMP.ID,
      TMP.LAST_COMMENT_DATE,
      TMP.COMMENTS,
      TMP.PLANNER,
      TMP.LAST_UPDATE_DATE
    )
8.TOT OPEN QTY	
SELECT * FROM INV_SAP_BACKLOG_SO WHERE ID = 'id_1'
9.PAST DUE 
SELECT * FROM INV_SAP_BACKLOG_SO WHERE COMMITTED_DATE < SYSDATE - 1 AND  ID = 'id_1'
10.OPEN	WITH IN LT	
SELECT * FROM INV_SAP_BACKLOG_SO WHERE COMMITTED_DATE BETWEEN TO_CHAR(SYSDATE) AND TO_CHAR(SYSDATE  + LT_1)  AND  ID = 'id_1'
11.LT - 13WEEKS	
SELECT * FROM INV_SAP_BACKLOG_SO WHERE COMMITTED_DATE BETWEEN TO_CHAR(SYSDATE + LT_1) AND TO_CHAR(SYSDATE+91) AND  ID = 'id_1'
12.OUT 13 WEEKS	
SELECT * FROM INV_SAP_BACKLOG_SO WHERE COMMITTED_DATE > SYSDATE + LT_1 AND  ID = 'id_1'	
13.NO COMMITTED DATE
SELECT * FROM INV_SAP_BACKLOG_SO WHERE COMMITTED_DATE IS NULL AND ID = 'id_1'
14.DELETE COMMENTS							
DELETE FROM INV_SAP_SVD_COMMENTS WHERE ID = 'ID_1'								



