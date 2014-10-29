--Stock Item Performanct
--Author:Huang Moyue
--Date#:08012014

select LINECREATEDATE from INV_SAP_SALES_VBAK_VBAP_VBUP where LINECREATEDATE > sysdate -2
--Reset ReporT
--BackUP the data in tmp table
TRUNCATE TABLE STI_BY_BU_WEEK_TMP;
TRUNCATE TABLE STI_BY_ITEM_TMP;

INSERT INTO STI_BY_BU_WEEK_TMP SELECT COUNT(*) FROM STOCK_ITEM_STATUS_BY_BU_WEEK;
INSERT INTO STI_BY_ITEM_TMP AS SELECT * FROM STOCK_ITEM_STATUS_BY_ITEM;

--Reset the data from the tmp table
TRUNCATE TABLE STOCK_ITEM_STATUS_BY_BU_WEEK;
TRUNCATE TABLE STOCK_ITEM_STATUS_BY_ITEM;
INSERT INTO STOCK_ITEM_STATUS_BY_BU_WEEK AS SELECT count(*) FROM STI_BY_BU_WEEK_TMP;
INSERT INTO STOCK_ITEM_STATUS_BY_ITEM AS SELECT * FROM STI_BY_ITEM_TMP;
  
--VBA in Excel
1.sql_query	
  SELECT ID,
  MATERIAL,
  CATALOG_DASH,
  PLANT,
  MAT_DESC,
  BU,
  PROC_TYPE,
  MRP_CONTROLLER_KEY,
  MRP_CONTROLLER,
  MATL_TYPE,
  MRP_TYPE,
  STRATEGY_GRP,
  UNIT_COST,
  RECORDER_POINT,
  SAFETY_STOCK,
  LOT_SIZE,
  MIN_LOT_SIZE,
  LOT_ROUNDING_VALUE,
  GRT,
  PDT,
  OH_QTY,
  FC_AVG_WEEK,
  BACKLOG_OPEN,
  PAST_DUE_OPEN,
  LEAD_TIME,
  OH$$--,
  --MAX_INV,
  --TARGET_INV,
  --PRESENT_WEEK_STATUS
  FROM STOCK_ITEM_PERFORMANCE

2.sql_create	
CREATE TABLE STOCK_ITEM_PERFORMANCE AS
  (SELECT SYSDATE                                          AS LAST_REVIEW_DATE,
      PP_FC_AVG.ID                                         AS ID,
      PP_FC_AVG.MATERIAL                                   AS MATERIAL,
      PP_FC_AVG.CATALOG_DASH                               AS CATALOG_DASH,
      PP_FC_AVG.PLANT                                      AS PLANT,
      PP_FC_AVG.MAT_DESC                                   AS MAT_DESC,
      PP_FC_AVG.PROD_BU                                    AS BU,
      PP_FC_AVG.PROC_TYPE                                  AS PROC_TYPE,
      PP_FC_AVG.MRP_CONTROLLER_KEY                         AS MRP_CONTROLLER_KEY,
      PP_FC_AVG.MRP_CONTROLLER                             AS MRP_CONTROLLER,
      PP_FC_AVG.MATL_TYPE                                  AS MATL_TYPE,
      PP_FC_AVG.MRP_TYPE                                   AS MRP_TYPE,
      PP_FC_AVG.STRATEGY_GRP                               AS STRATEGY_GRP,
      PP_FC_AVG.UNIT_COST                                  AS UNIT_COST,
      PP_FC_AVG.RECORDER_POINT                             AS RECORDER_POINT,
      PP_FC_AVG.SAFETY_STOCK                               AS SAFETY_STOCK,
      PP_FC_AVG.LOT_SIZE_DISLS                             AS LOT_SIZE,
      PP_FC_AVG.LOT_MIN_BUY                                AS MIN_LOT_SIZE,
      PP_FC_AVG.LOT_ROUNDING_VALUE                         AS LOT_ROUNDING_VALUE,
      PP_FC_AVG.GRT                                        AS GRT,
      PP_FC_AVG.PDT                                        AS PDT,
      PP_FC_AVG.OH_QTY                                     AS OH_QTY,
      NVL(PP_FC_AVG.FC_AVG_WEEK,0)                         AS FC_AVG_WEEK,
      NVL(BACKLOG_PASTDUE.BACKLOG_OPEN,0)                  AS BACKLOG_OPEN,
      NVL(BACKLOG_PASTDUE.PAST_DUE_OPEN,0)                 AS PAST_DUE_OPEN,
      PP_FC_AVG.LEAD_TIME                                  AS LEAD_TIME,
      (NVL(PP_FC_AVG.UNIT_COST,0)*NVL(PP_FC_AVG.OH_QTY,0)) AS OH$$,
      0                                                    AS MAX_INV,
      0                                                    AS TARGET_INV,
      0                                                    AS PRESENT_WEEK_STATUS,
      1                                                    AS COUNT_KEY
    FROM
      (SELECT PP.ID,
        PP.MATERIAL,
        PP.CATALOG_DASH,
        PP.PLANT,
        PP.MAT_DESC,
        PP.PROD_BU,
        PP.PROC_TYPE,
        PP.MRP_CONTROLLER_KEY,
        PP.MRP_CONTROLLER,
        PP.MATL_TYPE,
        PP.MRP_TYPE,
        PP.STRATEGY_GRP,
        PP.UNIT_COST,
        PP.RECORDER_POINT,
        PP.SAFETY_STOCK,
        PP.LOT_SIZE_DISLS,
        PP.LOT_MIN_BUY,
        PP.LOT_ROUNDING_VALUE,
        PP.GRT,
        PP.PDT,
        PP.LEAD_TIME,
        PP.OH_QTY,
        FC_AVG_WEEK.FC_AVG_WEEK
      FROM
        (SELECT ID,
          MATERIAL,
          CATALOG_DASH,
          PLANT,
          MAT_DESC,
          PROD_BU,
          PROC_TYPE ,
          MRP_CONTROLLER_KEY,
          MRP_CONTROLLER,
          MATL_TYPE,
          MRP_TYPE,
          STRATEGY_GRP,
          UNIT_COST,
          RECORDER_POINT,
          SAFETY_STOCK,
          LOT_SIZE_DISLS,
          LOT_MIN_BUY,
          LOT_ROUNDING_VALUE,
          GRT,
          PDT,
          LEAD_TIME,
          OH_QTY
        FROM INV_SAP_PP_OPT_X
        WHERE STRATEGY_GRP = '40'
        AND MATL_TYPE     IN ('ZFG','ZTG')
        AND PLANT         IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
        )PP
      LEFT JOIN
        (SELECT MATERIALID
          ||'_'
          ||PLANTID                           AS ID,
          MATERIALID                          AS MATERIALID,
          PLANTID                             AS PLANTID,
          CEIL(SUM(PLNMG_PLANNEDQUANTITY)/18) AS FC_AVG_WEEK
        FROM INV_SAP_PP_FRCST_PBIM_PBED
        WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate + 56) AND TO_CHAR(sysdate + 182))
        AND PLANTID                                                   IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
        AND VERSBP_VERSION = '00'
        GROUP BY MATERIALID,
          MATERIALID
          ||'_'
          ||PLANTID,
          PLANTID,
          MATERIALID
        )FC_AVG_WEEK
      ON PP.ID = FC_AVG_WEEK.ID
      ) PP_FC_AVG
    LEFT JOIN
      (SELECT BACKLOG_OPEN.ID           AS ID,
        BACKLOG_OPEN.OPEN_QTY           AS BACKLOG_OPEN,
        PAST_DUE_OPEN.PAST_DUE_OPEN_QTY AS PAST_DUE_OPEN
      FROM
        (SELECT MATERIAL
          ||'_'
          ||PLANT       AS ID,
          MATERIAL      AS MATERIALID,
          PLANT         AS PLANTID,
          SUM(OPEN_QTY) AS OPEN_QTY
        FROM INV_SAP_SALES_VBAK_VBAP_VBUP
        WHERE PLANT                   IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
        AND MAX_REQUEST_DATE < SYSDATE + 90
        AND SALESDOCTYPE              IN ('ZOR1','ZOR5')
        AND OPEN_QTY         > 0
        GROUP BY MATERIAL,
          PLANT
        )BACKLOG_OPEN
      LEFT JOIN
        (SELECT MATERIAL
          ||'_'
          ||PLANT       AS ID,
          MATERIAL      AS MATERIALID,
          PLANT         AS PLANTID,
          SUM(OPEN_QTY) AS PAST_DUE_OPEN_QTY
        FROM INV_SAP_SALES_VBAK_VBAP_VBUP
        WHERE PLANT                  IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
        AND MAX_COMMIT_DATE < SYSDATE - 1
        AND SALESDOCTYPE             IN ('ZOR1','ZOR5')
        AND OPEN_QTY        > 0
        GROUP BY MATERIAL,
          PLANT
        )PAST_DUE_OPEN
      ON PAST_DUE_OPEN.ID                    = BACKLOG_OPEN.ID
      )BACKLOG_PASTDUE ON BACKLOG_PASTDUE.ID = PP_FC_AVG.ID
  )
  
3.sql_drop
	DROP TABLE STOCK_ITEM_PERFORMANCE

4.STOCK_ITEM_STATUS_BY_BU_WEEK
  INSERT
  INTO STOCK_ITEM_STATUS_BY_BU_WEEK
    (
      ID,
      LAST_REVIEW_DATE,
      PLANTID,
      BU,
      WEEK_STATUS_1,
      WEEK_STATUS_2,
      WEEK_STATUS_3,
      WEEK_STATUS_4,
      WEEK_STATUS_5
    )
  SELECT ID,
    LAST_REVIEW_DATE,
    PLANT,
    BU,
    SUM(WK_STATUS_1) AS WK_STATUS_1,
    SUM(WK_STATUS_2) AS WK_STATUS_2,
    SUM(WK_STATUS_3) AS WK_STATUS_3,
    SUM(WK_STATUS_4) AS WK_STATUS_4,
    SUM(WK_STATUS_5) AS WK_STATUS_5
  FROM
    (SELECT ID,
      LAST_REVIEW_DATE,
      PLANT,
      BU,
      CASE
        WHEN PRESENT_WEEK_STATUS = 1
        THEN COUNT_KEY
        ELSE 0
      END WK_STATUS_1,
      CASE
        WHEN PRESENT_WEEK_STATUS = 2
        THEN COUNT_KEY
        ELSE 0
      END WK_STATUS_2,
      CASE
        WHEN PRESENT_WEEK_STATUS = 3
        THEN COUNT_KEY
        ELSE 0
      END WK_STATUS_3,
      CASE
        WHEN PRESENT_WEEK_STATUS = 4
        THEN COUNT_KEY
        ELSE 0
      END WK_STATUS_4,
      CASE
        WHEN PRESENT_WEEK_STATUS = 5
        THEN COUNT_KEY
        ELSE 0
      END WK_STATUS_5
    FROM
      (SELECT LAST_REVIEW_DATE
        ||'_'
        ||PLANT
        ||'_'
        ||BU AS ID,
        LAST_REVIEW_DATE,
        PLANT,
        BU,
        PRESENT_WEEK_STATUS,
        COUNT_KEY
      FROM STOCK_ITEM_PERFORMANCE
      )
    )
  GROUP BY ID,
    LAST_REVIEW_DATE,
    PLANT,
    BU
  
5.Fetch Data STOCK_ITEM_STATUS_BY_BU_WEEK	
  SELECT * FROM STOCK_ITEM_STATUS_BY_BU_WEEK
  
6.STOCK_ITEM_STATUS_BY_ITEM	
  INSERT
  INTO STOCK_ITEM_STATUS_BY_ITEM
    (
      ID,
      LAST_REVIEW_DATE,
      PLANT,
      BU,
      MATERIAL,
      STATUS
    )
  SELECT DISTINCT *
  FROM
    (SELECT LAST_REVIEW_DATE
      ||'_'
      ||PLANT
      ||'_'
      ||BU
      ||'_'
      ||MATERIAL AS ID,
      LAST_REVIEW_DATE,
      PLANT,
      BU,
      MATERIAL,
      PRESENT_WEEK_STATUS
    FROM STOCK_ITEM_PERFORMANCE
    )
    
7.Fecth data STOCK_ITEM_STATUS_BY_ITEM
SELECT * FROM STOCK_ITEM_STATUS_BY_ITEM
  
  
  
  
  
CREATE TABLE STOCK_ITEM_STATUS_BY_ITEM_B AS
SELECT * FROM STOCK_ITEM_STATUS_BY_ITEM WHERE LAST_REVIEW_DATE > sysdate -8
  
CREATE TABLE STOCK_ITEM_STATUS_BY_BU_WEEK_B AS 
SELECT * FROM STOCK_ITEM_STATUS_BY_BU_WEEK WHERE LAST_REVIEW_DATE > sysdate -8

  
  
  
DELETE FROM STOCK_ITEM_STATUS_BY_ITEM WHERE LAST_REVIEW_DATE > sysdate - 2;

DELETE FROM STOCK_ITEM_STATUS_BY_BU_WEEK WHERE LAST_REVIEW_DATE > sysdate - 2;



------------------------------------------------------------------------------------------------------------------------
--CREATE NEW CHART FOR 40 INV
CREATE TABLE STOCK_ITEM_PERFORMANCE_REC AS SELECT * FROM STOCK_ITEM_PERFORMANCE;



TRUNCATE TABLE STOCK_ITEM_PERFORMANCE_REC;











"INSERT INTO INV_SAP_DMT_FRD_P15(
LAST_REVIEW_DATE,
ID,
MATERIAL,
CATALOG_DASH,
PLANT,
MAT_DESC,
BU,
PROC_TYPE,
MRP_CONTROLLER_KEY,
MRP_CONTROLLER,
MATL_TYPE,
MRP_TYPE,
STRATEGY_GRP,
UNIT_COST,
RECORDER_POINT,
SAFETY_STOCK,
LOT_SIZE,
MIN_LOT_SIZE,
LOT_ROUNDING_VALUE,
GRT,
PDT,
OH_QTY,
FC_AVG_WEEK,
BACKLOG_OPEN,
PAST_DUE_OPEN,
LEAD_TIME,
OH$$,
MAX_INV,
TARGET_INV,
PRESENT_WEEK_STATUS,
COUNT_KEY
) VALUES (LAST_REVIEW_DATE,
ID,
MATERIAL,
CATALOG_DASH,
PLANT,
MAT_DESC,
BU,
PROC_TYPE,
MRP_CONTROLLER_KEY,
MRP_CONTROLLER,
MATL_TYPE,
MRP_TYPE,
STRATEGY_GRP,
UNIT_COST,
RECORDER_POINT,
SAFETY_STOCK,
LOT_SIZE,
MIN_LOT_SIZE,
LOT_ROUNDING_VALUE,
GRT,
PDT,
OH_QTY,
FC_AVG_WEEK,
BACKLOG_OPEN,
PAST_DUE_OPEN,
LEAD_TIME,
OH$$,
MAX_INV,
TARGET_INV,
PRESENT_WEEK_STATUS,
1
)

















