---Log News
--Rememner the 3 months and all difference..

---Source Table From DW_RA
Drop table INV_SAP_PP_OPTIMIZATION;
CREATE TABLE INV_SAP_PP_OPTIMIZATION AS
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION@ROCKWELL_DBLINK WHERE PLANTID IN ('5040', '5070', '5100', '5110', '5140', '5200'); 

Drop table INV_SAP_SALES_VBAK_VBAP_VBUP;
CREATE TABLE INV_SAP_SALES_VBAK_VBAP_VBUP AS
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP@ROCKWELL_DBLINK WHERE PLANT IN ('5040', '5070', '5100', '5110', '5140', '5200');

DROP TABLE INV_SAP_PP_FRCST_PBIM_PBED;
CREATE TABLE INV_SAP_PP_FRCST_PBIM_PBED AS
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_FRCST_PBIM_PBED@ROCKWELL_DBLINK WHERE PLANTID IN ('5040', '5070', '5100', '5110', '5140', '5200');

Drop table INV_SAP_SALES_HST;
CREATE TABLE INV_SAP_SALES_HST AS
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_SALES_HST@ROCKWELL_DBLINK WHERE PLANTID IN ('5040', '5070', '5100', '5110', '5140', '5200');

SELECT * FROM INV_SAP_SALES_HST WHERE MATERIALID = '100-C23KJ10 C'AND PLANTID = '5040';

select * from INV_SAP_SALES_HST where MATERIALID = '1762-L40BWA C' AND PLANTID = '5140';


---Upload History Data
truncate TABLE STOCK_ITEM_STATUS_BY_BU_WEEK;
SELECT * FROM STOCK_ITEM_STATUS_BY_BU_WEEK where id = '09-JUN-14_5140_ICM-INTGR COND MONITOR';
SELECT count(*) FROM STOCK_ITEM_STATUS_BY_BU_WEEK;
DROP TABLE STOCK_ITEM_STATUS_BY_BU_WEEK;
CREATE TABLE STOCK_ITEM_STATUS_BY_BU_WEEK AS SELECT * FROM STI_BY_BU_WEEK_TMP;
CREATE TABLE STI_BY_BU_WEEK_TMP AS SELECT * FROM STOCK_ITEM_STATUS_BY_BU_WEEK

SELECT * FROM STOCK_ITEM_STATUS_BY_ITEM;
truncate TABLE STOCK_ITEM_STATUS_BY_ITEM;
SELECT * FROM STOCK_ITEM_STATUS_BY_ITEM where id = '23-JUN-14_5140_KNX-KINETIX_198754-Q09';
SELECT count(*) FROM STOCK_ITEM_STATUS_BY_ITEM;
drop table STOCK_ITEM_STATUS_BY_ITEM
CREATE TABLE SSTOCK_ITEM_STATUS_BY_ITEM_TMP AS SELECT * FROM STOCK_ITEM_STATUS_BY_ITEM
CREATE TABLE STOCK_ITEM_STATUS_BY_ITEM AS SELECT * FROM SSTOCK_ITEM_STATUS_BY_ITEM_TMP

DROP TABLE STOCK_ITEM_STATUS_BY_BU_WEEK;
drop table STOCK_ITEM_STATUS_BY_ITEM;
CREATE TABLE STOCK_ITEM_STATUS_BY_BU_WEEK AS SELECT * FROM STI_BY_BU_WEEK_TMP;
CREATE TABLE STOCK_ITEM_STATUS_BY_ITEM AS SELECT * FROM SSTOCK_ITEM_STATUS_BY_ITEM_TMP;

--------------Upload item status by item history
CREATE TABLE STOCK_ITEM_STATUS_BY_ITEM AS
  (SELECT 
      LAST_REVIEW_DATE||'_'||PLANTID||'_'||BU AS ID,
      LAST_REVIEW_DATE AS LAST_REVIEW_DATE,
      PLANTID              AS PLANTID,
      BU                   AS BU,
      MATERIALID  AS MATERIAL,
      0     AS STATUS
FROM STOCK_ITEM_PERFORMANCE);

SELECT * FROM STOCK_ITEM_STATUS_BY_ITEM WHERE ID = '19-May-14_5140_198754-Q09_KNX-KINETIX';
truncate TABLE STOCK_ITEM_STATUS_BY_ITEM;
DROP TABLE STOCK_ITEM_STATUS_BY_ITEM;
SELECT COUNT(*) FROM STOCK_ITEM_STATUS_BY_ITEM;

--INSERT DATA IN THE STOCK_ITEM_STATUS_BY_ITEM
INSERT INTO STOCK_ITEM_STATUS_BY_ITEM
(
    ID,
LAST_REVIEW_DATE,
PLANTID,
BU,
MATERIAL,
STATUS
  )
SELECT DISTINCT * FROM(
SELECT LAST_REVIEW_DATE||'_'||PLANTID||'_'||BU||'_'||MATERIALID AS ID,
LAST_REVIEW_DATE,PLANTID,BU,MATERIALID,
CASE WHEN PRESENT_WEEK_STATUS < 7 THEN PRESENT_WEEK_STATUS ELSE END
FROM STOCK_ITEM_PERFORMANCE where materialid = '800F-ALM A'
);

--Gennerate Report
SELECT LAST_REVIEW_DATE, PLANTID, MATERIAL, STATUS FROM STOCK_ITEM_STATUS_BY_ITEM WHERE PLANTID = '5040';

-----Color item report, History_Week_Status_BYItem
INSERT
INTO STOCK_ITEM_STATUS_BY_ITEM
  (
    ID,
    LAST_REVIEW_DATE,
    PLANTID,
    BU,
    MATERIAL,
    STATUS
  )
SELECT 
  SIP.LAST_REVIEW_DATE
      ||'_'
      ||SIP.PLANTID
      ||'_'
      ||SIP.MATERIALID 
      ||'_'
      ||SIP.BU AS ID,
  SIP.LAST_REVIEW_DATE           AS LAST_REVIEW_DATE,
  SIP.PLANTID                    AS PLANTID,
  SIP.BU                         AS BU,
  SIP.MATERIALID                 AS MATERIALID,
  SIP.Present_Week_Status        AS Present_Week_Status
FROM STOCK_ITEM_PERFORMANCE SIP;
truncate TABLE STOCK_ITEM_STATUS_BY_ITEM;
SELECT * FROM STOCK_ITEM_STATUS_BY_ITEM WHERE ID = '26-May-14_5200_1756-OF8 A_CLX-CONTROLLOGIX NETLINX';

---STOCK_ITEM_PERFORMANCE Local Version
DROP TABLE STOCK_ITEM_PERFORMANCE;
SELECT * FROM STOCK_ITEM_PERFORMANCE;
CREATE TABLE STOCK_ITEM_PERFORMANCE AS
  (SELECT 
      SYSDATE                              AS LAST_REVIEW_DATE,
      PP_FC_AVG.ID                     AS ID,
      PP_FC_AVG.MATERIALID                 AS MATERIALID,
      PP_FC_AVG.PLANTID                    AS PLANTID,
      PP_FC_AVG.Material_Description       AS Material_Description,
      PP_FC_AVG.BU                         AS BU,
      PP_FC_AVG.Procurement_Type           AS Procurement_Type,
      PP_FC_AVG.MRP_CONTROLLER_ID          AS MRP_CONTROLLER_ID,
      PP_FC_AVG.MRP_CONTROLLER             AS MRP_CONTROLLER,
      PP_FC_AVG.MATL_TYPE                  AS MATL_TYPE,
      PP_FC_AVG.MRP_TYPE                   AS MRP_TYPE,
      PP_FC_AVG.Stock_Strategy             AS Stock_Strategy,
      PP_FC_AVG.Unit_Price                 AS Unit_Price,
      PP_FC_AVG.Reorder_Point              AS Reorder_Point,
      PP_FC_AVG.Safety_stock_Qty           AS Safety_stock_Qty,
      PP_FC_AVG.LOT_SIZE                   AS LOT_SIZE,
      PP_FC_AVG.Min_LOT_SIZE               AS Min_LOT_SIZE,
      PP_FC_AVG.Rounding_val               AS Rounding_val,
      PP_FC_AVG.GRT                        AS GRT,
      PP_FC_AVG.PDT                        AS PDT,
      PP_FC_AVG.IPT                        AS IPT,
      PP_FC_AVG.OH_QTY                     AS OH_QTY,
      NVL(PP_FC_AVG.FC_AVG_WEEK,0)         AS FC_AVG_WEEK,
      NVL(BACKLOG_PASTDUE.BACKLOG_OPEN,0)  AS BACKLOG_OPEN,
      NVL(BACKLOG_PASTDUE.PAST_DUE_OPEN,0) AS PAST_DUE_OPEN,
      0                                 AS Lead_Time,
      0                                 AS OH$$,
      0                                 AS MAX_INV,
      0                                 AS TARGET_INV,
      0                                 AS Present_Week_Status,
      1                                 AS COUNT_KEY
FROM
  (SELECT PP.ID                    AS ID,
    PP.MATERIALID                  AS MATERIALID,
    PP.PLANTID                     AS PLANTID,
    PP.Material_Description        AS Material_Description,
    PP.BU                          AS BU,
    PP.Procurement_Type            AS Procurement_Type,
    PP.MRP_CONTROLLER_ID           AS MRP_CONTROLLER_ID,
    PP.MRP_CONTROLLER              AS MRP_CONTROLLER,
    PP.MATL_TYPE                   AS MATL_TYPE,
    PP.MRP_TYPE                    AS MRP_TYPE,
    PP.Stock_Strategy              AS Stock_Strategy,
    PP.Unit_Price                  AS Unit_Price,
    PP.Reorder_Point               AS Reorder_Point,
    PP.Safety_stock_Qty            AS Safety_stock_Qty,
    PP.LOT_SIZE                    AS LOT_SIZE,
    PP.Min_LOT_SIZE                AS Min_LOT_SIZE,
    PP.Rounding_val                AS Rounding_val,
    PP.GRT                         AS GRT,
    PP.PDT                         AS PDT,
    PP.IPT                         AS IPT,
    PP.OH_QTY                      AS OH_QTY,
    FC_AVG_WEEK.FC_AVG_WEEK        AS FC_AVG_WEEK
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID            AS ID,
      MATERIALID           AS MATERIALID,
      PLANTID              AS PLANTID,
      MAT_DESC             AS Material_Description,
      PROD_BU              AS BU,
      PROC_TYPE            AS Procurement_Type,
      MRP_CONTROLLER_DISPO AS MRP_CONTROLLER_ID,
      MRP_CONTROLLER       AS MRP_CONTROLLER,
      MATL_TYPE_MTART      AS MATL_TYPE,
      MRP_TYPE             AS MRP_TYPE,
      STRATEGY_GRP         AS Stock_Strategy,
      UNIT_COST            AS Unit_Price,
      REORDER_PT           AS Reorder_Point,
      SAFETY_STK           AS Safety_stock_Qty,
      LOT_SIZE_DISLS       AS LOT_SIZE,
      LOT_MIN_BUY          AS Min_LOT_SIZE,
      LOT_ROUNDING_VALUE   AS Rounding_val,
      GRT                  AS GRT,
      PDT                  AS PDT,
      IPT                  AS IPT,
      OH_QTY               AS OH_QTY
    FROM INV_SAP_PP_OPTIMIZATION
    WHERE STRATEGY_GRP   = '40'
    AND MATL_TYPE_MTART IN ('ZFG','ZTG')
    AND PLANTID         IN ('5040', '5070', '5100', '5110', '5140', '5200')
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
    AND PLANTID                                                                        IN ('5040', '5070', '5100', '5110', '5140', '5200')
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
    (SELECT MATERIALID
      ||'_'
      ||PLANTID       AS ID,
      MATERIALID      AS MATERIALID,
      PLANTID         AS PLANTID,
      SUM(OPENQTY) AS OPEN_QTY
    FROM INV_SAP_SALES_HST
    WHERE PLANTID                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND REQUIREDDELIVERYDATE < SYSDATE + 90 AND SALESDOCTYPE IN ('ZOR1','ZOR5') AND OPENQTY > 0 
    GROUP BY 
    MATERIALID,
    PLANTID
    )BACKLOG_OPEN
  LEFT JOIN
    (SELECT MATERIALID
      ||'_'
      ||PLANTID       AS ID,
      MATERIALID      AS MATERIALID,
      PLANTID         AS PLANTID,
      SUM(OPENQTY) AS PAST_DUE_OPEN_QTY
    FROM INV_SAP_SALES_HST
    WHERE PLANTID                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND REQUIREDDELIVERYDATE < SYSDATE - 1 AND SALESDOCTYPE IN ('ZOR1','ZOR5') AND OPENQTY > 0
    GROUP BY 
      MATERIALID,
      PLANTID
    )PAST_DUE_OPEN
  ON PAST_DUE_OPEN.ID                    = BACKLOG_OPEN.ID
  )BACKLOG_PASTDUE ON BACKLOG_PASTDUE.ID = PP_FC_AVG.ID);
  
      
---Prepare Data in STOCK_ITEM_STATUS_BY_BU_WEEK
INSERT INTO STOCK_ITEM_STATUS_BY_BU_WEEK
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
SELECT DISTINCT * FROM(
  (SELECT LAST_REVIEW_DATE
      ||'_'
      ||PLANTID
      ||'_'
      ||BU             AS ID,
      LAST_REVIEW_DATE AS LAST_REVIEW_DATE,
      PLANTID          AS PLANTID,
      BU               AS BU,
      0                AS WEEK_STATUS_1,
      0                AS WEEK_STATUS_2,
      0                AS WEEK_STATUS_3,
      0                AS WEEK_STATUS_4,
      0                AS WEEK_STATUS_5
    FROM STOCK_ITEM_PERFORMANCE
    WHERE PLANTID IN ('5040', '5070', '5100', '5110', '5140', '5200'))
    );
    



-----------------------------------------------------------------------------------------------------------
--Testing Area!!!
-----------------------------------------------------------------------------------------------------------

---Caculate Avg_FC_By_Week
SELECT *
FROM INV_SAP_PP_FRCST_PBIM_PBED
WHERE MATERIALID   = 'PN-83667'
AND PLANTID        = '5200'
AND VERSBP_VERSION = '55';

SELECT MATERIALID
      ||'_'
      ||PLANTID                     AS ID,
      MATERIALID                    AS MATERIALID,
      PLANTID                       AS PLANTID,
      CEIL(SUM(PLNMG_PLANNEDQUANTITY)/26) AS PLANNED_QUANTITY
    FROM INV_SAP_PP_FRCST_PBIM_PBED
    WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
    AND PLANTID IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND VERSBP_VERSION = '55'
    AND MATERIALID = 'PN-83667'
    GROUP BY MATERIALID,
      MATERIALID
      ||'_'
      ||PLANTID,
      PLANTID, MATERIALID;

SELECT MATERIALID,
  PLANTID,
  PLNMG_PLANNEDQUANTITY,
  PDATU_DELIV_ORDFINISHDATE
FROM INV_SAP_PP_FRCST_PBIM_PBED
WHERE PLANTID      = '5040'
AND MATERIALID     = '199-DR1 B'
AND VERSBP_VERSION = '55'
AND (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
;

    
---BACKLOG SALES ORDERS, NOT ADD 3 MONTHS
SELECT MATERIAL
  ||'_'
  ||PLANT       AS ID,
  MATERIAL      AS MATERIALID,
  PLANT         AS PLANTID,
  NVL(SUM(OPEN_QTY), 0) AS OPEN_QTY
FROM INV_SAP_SALES_VBAK_VBAP_VBUP
WHERE PLANT IN ('5040', '5070', '5100', '5110', '5140', '5200')
AND MATERIAL = '889D-F4AC-5 B' AND PLANT = '5070'
AND MAX_COMMIT_DATE < SYSDATE + 90
GROUP BY MATERIAL
  ||'_'
  ||PLANT,
  MATERIAL,
  PLANT;

SELECT * FROM INV_SAP_SALES_VBAK_VBAP_VBUP WHERE MATERIAL = '1756-IB32 B' AND PLANT = '5070' AND MAX_COMMIT_DATE < SYSDATE + 90;

---PAST DUE SALES ORDER
SELECT MATERIAL
  ||'_'
  ||PLANT       AS ID,
  MATERIAL      AS MATERIALID,
  PLANT         AS PLANTID,
  NVL (SUM(OPEN_QTY), 0) AS PASS_DUE_OPEN_QTY
FROM INV_SAP_SALES_VBAK_VBAP_VBUP
WHERE PLANT        IN ('5040', '5070', '5100', '5110', '5140', '5200')
AND MAX_COMMIT_DATE < SYSDATE - 1
AND MATERIAL = '800F-ALM A'
GROUP BY MATERIAL
  ||'_'
  ||PLANT,
  MATERIAL,
  PLANT;

---JOIN TOGETHER
SELECT * FROM
(
SELECT BACKLOG_OPEN.ID AS ID,
BACKLOG_OPEN.OPEN_QTY AS BACKLOG_OPEN,
PASS_DUE_OPEN.PASS_DUE_OPEN_QTY AS PASS_DUE_OPEN
FROM
(SELECT MATERIAL
  ||'_'
  ||PLANT       AS ID,
  MATERIAL      AS MATERIALID,
  PLANT         AS PLANTID,
  NVL(SUM(OPEN_QTY), 0) AS OPEN_QTY
FROM INV_SAP_SALES_VBAK_VBAP_VBUP
WHERE PLANT IN ('5040', '5070', '5100', '5110', '5140', '5200')
GROUP BY MATERIAL
  ||'_'
  ||PLANT,
  MATERIAL,
  PLANT)BACKLOG_OPEN
LEFT JOIN
(SELECT MATERIAL
  ||'_'
  ||PLANT       AS ID,
  MATERIAL      AS MATERIALID,
  PLANT         AS PLANTID,
  NVL(SUM(OPEN_QTY), 0) AS PASS_DUE_OPEN_QTY
FROM INV_SAP_SALES_VBAK_VBAP_VBUP
WHERE PLANT        IN ('5040', '5070', '5100', '5110', '5140', '5200')
AND MAX_COMMIT_DATE < SYSDATE - 1
GROUP BY MATERIAL
  ||'_'
  ||PLANT,
  MATERIAL,
  PLANT)PASS_DUE_OPEN
  ON PASS_DUE_OPEN.ID = BACKLOG_OPEN.ID
) WHERE ID = '800F-ALM A_5040';
  
  
--- JOIN FC_AVG, PASSDUE, BACKLOG_OPEN
SELECT * FROM
(
SELECT FC_AVG_WEEK.ID           AS ID,
  FC_AVG_WEEK.PLANNED_QUANTITY  AS FC_AVG_WEEK,
  BACKLOG_PASTDUE.BACKLOG_OPEN  AS BACKLOG_OPEN,
  BACKLOG_PASTDUE.PAST_DUE_OPEN AS PAST_DUE_OPEN
FROM
  (SELECT MATERIALID
    ||'_'
    ||PLANTID                               AS ID,
    MATERIALID                              AS MATERIALID,
    PLANTID                                 AS PLANTID,
    ROUND(SUM(PLNMG_PLANNEDQUANTITY)/26, 0) AS PLANNED_QUANTITY
  FROM INV_SAP_PP_FRCST_PBIM_PBED
  WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
  AND PLANTID                                                                        IN ('5040', '5070', '5100', '5110', '5140', '5200')
  AND VERSBP_VERSION = '55'
  GROUP BY MATERIALID,
    MATERIALID
    ||'_'
    ||PLANTID,
    PLANTID,
    MATERIALID
  )FC_AVG_WEEK
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
      NVL(SUM(OPEN_QTY), 0) AS OPEN_QTY
    FROM INV_SAP_SALES_VBAK_VBAP_VBUP
    WHERE PLANT IN ('5040', '5070', '5100', '5110', '5140', '5200')
    GROUP BY MATERIAL
      ||'_'
      ||PLANT,
      MATERIAL,
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
    WHERE PLANT                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MAX_COMMIT_DATE < SYSDATE - 1
    GROUP BY MATERIAL
      ||'_'
      ||PLANT,
      MATERIAL,
      PLANT
    )PAST_DUE_OPEN
  ON PAST_DUE_OPEN.ID                = BACKLOG_OPEN.ID
  )BACKLOG_PASTDUE ON FC_AVG_WEEK.ID = BACKLOG_PASTDUE.ID) WHERE ID = '800F-ALM A_5040';


---PP Information
SELECT MATERIALID
    ||'_'
    ||PLANTID  AS ID,
    MATERIALID AS MATERIALID,
    PLANTID    AS PLANTID,
    MAT_DESC                AS Material_Description,
    PROD_BU                 AS BU,
    PROC_TYPE               AS Procurement_Type,
    MRP_CONTROLLER_DISPO    AS MRP_CONTROLLER_ID,
    MRP_CONTROLLER          AS MRP_CONTROLLER,
    MATL_TYPE_MTART         AS MATL_TYPE,
    MRP_TYPE                AS MRP_TYPE,
    STRATEGY_GRP            AS Stock_Strategy,
    UNIT_COST               AS Unit_Price,
    REORDER_PT              AS Reorder_Point,
    SAFETY_STK              AS Safety_stock_Qty,
    LOT_SIZE_DISLS          AS LOT_SIZE,
    LOT_MIN_BUY             AS Min_LOT_SIZE,
    LOT_ROUNDING_VALUE      AS Rounding_val,
    GRT                     AS GRT,
    PDT                     AS PDT,
    IPT                     AS IPT,
    OH_QTY                  AS OH_QTY,
    OH_$$                   AS OH_$$
  FROM INV_SAP_PP_OPTIMIZATION
  WHERE STRATEGY_GRP   = '40'
  AND MATL_TYPE_MTART IN ('ZFG','ZTG')
  AND PLANTID         IN ('5040', '5070', '5100', '5110', '5140', '5200')
  AND MATERIALID = '800HAUS1HZ4';
  


---Report-----

SELECT * FROM
(
SELECT MATERIALID
    ||'_'
    ||PLANTID  AS ID,
    MATERIALID AS MATERIALID,
    PLANTID    AS PLANTID,
    MAT_DESC                AS Material_Description,
    PROD_BU                 AS BU,
    PROC_TYPE               AS Procurement_Type,
    MRP_CONTROLLER_DISPO    AS MRP_CONTROLLER_ID,
    MRP_CONTROLLER          AS MRP_CONTROLLER,
    MATL_TYPE_MTART         AS MATL_TYPE,
    MRP_TYPE                AS MRP_TYPE,
    STRATEGY_GRP            AS Stock_Strategy,
    UNIT_COST               AS Unit_Price,
    REORDER_PT              AS Reorder_Point,
    SAFETY_STK              AS Safety_stock_Qty,
    LOT_SIZE_DISLS          AS LOT_SIZE,
    LOT_MIN_BUY             AS Min_LOT_SIZE,
    LOT_ROUNDING_VALUE      AS Rounding_val,
    GRT                     AS GRT,
    PDT                     AS PDT,
    IPT                     AS IPT,
    OH_QTY                  AS OH_QTY,
    OH_$$                   AS OH_$$
  FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION
  WHERE STRATEGY_GRP   = '40'
  AND MATL_TYPE_MTART IN ('ZFG','ZTG')
  AND PLANTID         IN ('5040', '5070', '5100', '5110', '5140', '5200')
)PP
LEFT JOIN
(
SELECT FC_AVG_WEEK.ID           AS ID,
  FC_AVG_WEEK.PLANNED_QUANTITY  AS FC_AVG_WEEK,
  BACKLOG_PASTDUE.BACKLOG_OPEN  AS BACKLOG_OPEN,
  BACKLOG_PASTDUE.PAST_DUE_OPEN AS PAST_DUE_OPEN
FROM
  (SELECT MATERIALID
    ||'_'
    ||PLANTID                               AS ID,
    MATERIALID                              AS MATERIALID,
    PLANTID                                 AS PLANTID,
    ROUND(SUM(PLNMG_PLANNEDQUANTITY)/26, 0) AS PLANNED_QUANTITY
  FROM DWQ$LIBRARIAN.INV_SAP_PP_FRCST_PBIM_PBED
  WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
  AND PLANTID                                                                        IN ('5040', '5070', '5100', '5110', '5140', '5200')
  AND VERSBP_VERSION = '55'
  GROUP BY MATERIALID,
    MATERIALID
    ||'_'
    ||PLANTID,
    PLANTID,
    MATERIALID
  )FC_AVG_WEEK
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
    FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
    WHERE PLANT IN ('5040', '5070', '5100', '5110', '5140', '5200')
    GROUP BY MATERIAL
      ||'_'
      ||PLANT,
      MATERIAL,
      PLANT
    )BACKLOG_OPEN
  LEFT JOIN
    (SELECT MATERIAL
      ||'_'
      ||PLANT       AS ID,
      MATERIAL      AS MATERIALID,
      PLANT         AS PLANTID,
      SUM(OPEN_QTY) AS PAST_DUE_OPEN_QTY
    FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
    WHERE PLANT                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MAX_COMMIT_DATE < SYSDATE - 1
    GROUP BY MATERIAL
      ||'_'
      ||PLANT,
      MATERIAL,
      PLANT
    )PAST_DUE_OPEN
  ON PAST_DUE_OPEN.ID                = BACKLOG_OPEN.ID
  )BACKLOG_PASTDUE ON FC_AVG_WEEK.ID = BACKLOG_PASTDUE.ID
)FC_BACKLOG_PASTDU
ON PP.ID = FC_BACKLOG_PASTDU.ID;




SELECT MATERIALID
      ||'_'
      ||PLANTID       AS ID,
      MATERIALID      AS MATERIALID,
      PLANTID         AS PLANTID,
      SUM(OPENQTY) AS PAST_DUE_OPEN_QTY
    FROM INV_SAP_SALES_HST
    WHERE PLANTID                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND REQUIREDDELIVERYDATE < SYSDATE - 1 AND SALESDOCTYPE IN ('ZOR1','ZOR5')
    GROUP BY MATERIALID ||'_' ||PLANTID, MATERIALID, PLANTID,SALESDOCTYPE;
      
      
  
---LOCAL VERSION------------------------------    SELECT * FROM DWQ$LIBRARIAN.INV_SAP_SALES_HST WHERE SALESDOC = '6501892883';--------------------------------
--V0.1
SELECT PP.ID                             AS ID,
  PP.MATERIALID                          AS MATERIALID,
  PP.PLANTID                             AS PLANTID,
  PP.Material_Description                AS Material_Description,
  PP.BU                                  AS BU,
  PP.Procurement_Type                    AS Procurement_Type,
  PP.MRP_CONTROLLER_ID                   AS MRP_CONTROLLER_ID,
  PP.MRP_CONTROLLER                      AS MRP_CONTROLLER,
  PP.MATL_TYPE                           AS MATL_TYPE,
  PP.MRP_TYPE                            AS MRP_TYPE,
  PP.Stock_Strategy                      AS Stock_Strategy,
  PP.Unit_Price                          AS Unit_Price,
  PP.Reorder_Point                       AS Reorder_Point,
  PP.Safety_stock_Qty                    AS Safety_stock_Qty,
  PP.LOT_SIZE                            AS LOT_SIZE,
  PP.Min_LOT_SIZE                        AS Min_LOT_SIZE,
  PP.Rounding_val                        AS Rounding_val,
  PP.GRT                                 AS GRT,
  PP.PDT                                 AS PDT,
  PP.IPT                                 AS IPT,
  PP.OH_QTY                              AS OH_QTY,
  NVL(FC_BACKLOG_PASTDU.FC_AVG_WEEK,0)   AS FC_AVG_WEEK,
  NVL(FC_BACKLOG_PASTDU.BACKLOG_OPEN,0)  AS BACKLOG_OPEN,
  NVL(FC_BACKLOG_PASTDU.PAST_DUE_OPEN,0) AS PAST_DUE_OPEN
FROM
  (SELECT MATERIALID
    ||'_'
    ||PLANTID            AS ID,
    MATERIALID           AS MATERIALID,
    PLANTID              AS PLANTID,
    MAT_DESC             AS Material_Description,
    PROD_BU              AS BU,
    PROC_TYPE            AS Procurement_Type,
    MRP_CONTROLLER_DISPO AS MRP_CONTROLLER_ID,
    MRP_CONTROLLER       AS MRP_CONTROLLER,
    MATL_TYPE_MTART      AS MATL_TYPE,
    MRP_TYPE             AS MRP_TYPE,
    STRATEGY_GRP         AS Stock_Strategy,
    UNIT_COST            AS Unit_Price,
    REORDER_PT           AS Reorder_Point,
    SAFETY_STK           AS Safety_stock_Qty,
    LOT_SIZE_DISLS       AS LOT_SIZE,
    LOT_MIN_BUY          AS Min_LOT_SIZE,
    LOT_ROUNDING_VALUE   AS Rounding_val,
    GRT                  AS GRT,
    PDT                  AS PDT,
    IPT                  AS IPT,
    OH_QTY               AS OH_QTY
  FROM INV_SAP_PP_OPTIMIZATION
  WHERE STRATEGY_GRP   = '40'
  AND MATL_TYPE_MTART IN ('ZFG','ZTG')
  AND PLANTID         IN ('5040', '5070', '5100', '5110', '5140', '5200')
  )PP
LEFT JOIN
  (SELECT FC_AVG_WEEK.ID          AS ID,
    FC_AVG_WEEK.PLANNED_QUANTITY  AS FC_AVG_WEEK,
    BACKLOG_PASTDUE.BACKLOG_OPEN  AS BACKLOG_OPEN,
    BACKLOG_PASTDUE.PAST_DUE_OPEN AS PAST_DUE_OPEN
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID                               AS ID,
      MATERIALID                              AS MATERIALID,
      PLANTID                                 AS PLANTID,
      CEIL(SUM(PLNMG_PLANNEDQUANTITY)/26) AS PLANNED_QUANTITY
    FROM INV_SAP_PP_FRCST_PBIM_PBED
    WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
    AND PLANTID                                                                        IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND VERSBP_VERSION = '55'
    GROUP BY MATERIALID,
      MATERIALID
      ||'_'
      ||PLANTID,
      PLANTID,
      MATERIALID
    )FC_AVG_WEEK
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
      WHERE PLANT IN ('5040', '5070', '5100', '5110', '5140', '5200')
      GROUP BY MATERIAL
        ||'_'
        ||PLANT,
        MATERIAL,
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
      WHERE PLANT                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
      AND MAX_COMMIT_DATE < SYSDATE - 1
      GROUP BY MATERIAL
        ||'_'
        ||PLANT,
        MATERIAL,
        PLANT
      )PAST_DUE_OPEN
    ON PAST_DUE_OPEN.ID                = BACKLOG_OPEN.ID
    )BACKLOG_PASTDUE ON FC_AVG_WEEK.ID = BACKLOG_PASTDUE.ID
  )FC_BACKLOG_PASTDU ON PP.ID          = FC_BACKLOG_PASTDU.ID;
  
  
  
  
  --V0.2 fv join backlog local version
SELECT PP_FC_AVG.ID                    AS ID,
  PP_FC_AVG.MATERIALID                 AS MATERIALID,
  PP_FC_AVG.PLANTID                    AS PLANTID,
  PP_FC_AVG.Material_Description       AS Material_Description,
  PP_FC_AVG.BU                         AS BU,
  PP_FC_AVG.Procurement_Type           AS Procurement_Type,
  PP_FC_AVG.MRP_CONTROLLER_ID          AS MRP_CONTROLLER_ID,
  PP_FC_AVG.MRP_CONTROLLER             AS MRP_CONTROLLER,
  PP_FC_AVG.MATL_TYPE                  AS MATL_TYPE,
  PP_FC_AVG.MRP_TYPE                   AS MRP_TYPE,
  PP_FC_AVG.Stock_Strategy             AS Stock_Strategy,
  PP_FC_AVG.Unit_Price                 AS Unit_Price,
  PP_FC_AVG.Reorder_Point              AS Reorder_Point,
  PP_FC_AVG.Safety_stock_Qty           AS Safety_stock_Qty,
  PP_FC_AVG.LOT_SIZE                   AS LOT_SIZE,
  PP_FC_AVG.Min_LOT_SIZE               AS Min_LOT_SIZE,
  PP_FC_AVG.Rounding_val               AS Rounding_val,
  PP_FC_AVG.GRT                        AS GRT,
  PP_FC_AVG.PDT                        AS PDT,
  PP_FC_AVG.IPT                        AS IPT,
  PP_FC_AVG.OH_QTY                     AS OH_QTY,
  NVL(PP_FC_AVG.FC_AVG_WEEK,0)         AS FC_AVG_WEEK,
  NVL(BACKLOG_PASTDUE.BACKLOG_OPEN,0)  AS BACKLOG_OPEN,
  NVL(BACKLOG_PASTDUE.PAST_DUE_OPEN,0) AS PAST_DUE_OPEN
FROM
  (SELECT PP.ID                    AS ID,
    PP.MATERIALID                  AS MATERIALID,
    PP.PLANTID                     AS PLANTID,
    PP.Material_Description        AS Material_Description,
    PP.BU                          AS BU,
    PP.Procurement_Type            AS Procurement_Type,
    PP.MRP_CONTROLLER_ID           AS MRP_CONTROLLER_ID,
    PP.MRP_CONTROLLER              AS MRP_CONTROLLER,
    PP.MATL_TYPE                   AS MATL_TYPE,
    PP.MRP_TYPE                    AS MRP_TYPE,
    PP.Stock_Strategy              AS Stock_Strategy,
    PP.Unit_Price                  AS Unit_Price,
    PP.Reorder_Point               AS Reorder_Point,
    PP.Safety_stock_Qty            AS Safety_stock_Qty,
    PP.LOT_SIZE                    AS LOT_SIZE,
    PP.Min_LOT_SIZE                AS Min_LOT_SIZE,
    PP.Rounding_val                AS Rounding_val,
    PP.GRT                         AS GRT,
    PP.PDT                         AS PDT,
    PP.IPT                         AS IPT,
    PP.OH_QTY                      AS OH_QTY,
    FC_AVG_WEEK.FC_AVG_WEEK        AS FC_AVG_WEEK
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID            AS ID,
      MATERIALID           AS MATERIALID,
      PLANTID              AS PLANTID,
      MAT_DESC             AS Material_Description,
      PROD_BU              AS BU,
      PROC_TYPE            AS Procurement_Type,
      MRP_CONTROLLER_DISPO AS MRP_CONTROLLER_ID,
      MRP_CONTROLLER       AS MRP_CONTROLLER,
      MATL_TYPE_MTART      AS MATL_TYPE,
      MRP_TYPE             AS MRP_TYPE,
      STRATEGY_GRP         AS Stock_Strategy,
      UNIT_COST            AS Unit_Price,
      REORDER_PT           AS Reorder_Point,
      SAFETY_STK           AS Safety_stock_Qty,
      LOT_SIZE_DISLS       AS LOT_SIZE,
      LOT_MIN_BUY          AS Min_LOT_SIZE,
      LOT_ROUNDING_VALUE   AS Rounding_val,
      GRT                  AS GRT,
      PDT                  AS PDT,
      IPT                  AS IPT,
      OH_QTY               AS OH_QTY
    FROM INV_SAP_PP_OPTIMIZATION
    WHERE STRATEGY_GRP   = '40'
    AND MATL_TYPE_MTART IN ('ZFG','ZTG')
    AND PLANTID         IN ('5040', '5070', '5100', '5110', '5140', '5200')
    )PP
  LEFT JOIN
    (SELECT MATERIALID
      ||'_'
      ||PLANTID                           AS ID,
      MATERIALID                          AS MATERIALID,
      PLANTID                             AS PLANTID,
      CEIL(SUM(PLNMG_PLANNEDQUANTITY)/26) AS FC_AVG_WEEK
    FROM INV_SAP_PP_FRCST_PBIM_PBED
    WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
    AND PLANTID                                                                        IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND VERSBP_VERSION = '55'
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
    WHERE PLANT IN ('5040', '5070', '5100', '5110', '5140', '5200')
    GROUP BY MATERIAL
      ||'_'
      ||PLANT,
      MATERIAL,
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
    WHERE PLANT                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MAX_COMMIT_DATE < SYSDATE - 1
    GROUP BY MATERIAL
      ||'_'
      ||PLANT,
      MATERIAL,
      PLANT
    )PAST_DUE_OPEN
  ON PAST_DUE_OPEN.ID                    = BACKLOG_OPEN.ID
  )BACKLOG_PASTDUE ON BACKLOG_PASTDUE.ID = PP_FC_AVG.ID;
  
  
  --V 0.3 fv join backlog local version, add 3 months
  SELECT PP_FC_AVG.ID                    AS ID,
  PP_FC_AVG.MATERIALID                 AS MATERIALID,
  PP_FC_AVG.PLANTID                    AS PLANTID,
  PP_FC_AVG.Material_Description       AS Material_Description,
  PP_FC_AVG.BU                         AS BU,
  PP_FC_AVG.Procurement_Type           AS Procurement_Type,
  PP_FC_AVG.MRP_CONTROLLER_ID          AS MRP_CONTROLLER_ID,
  PP_FC_AVG.MRP_CONTROLLER             AS MRP_CONTROLLER,
  PP_FC_AVG.MATL_TYPE                  AS MATL_TYPE,
  PP_FC_AVG.MRP_TYPE                   AS MRP_TYPE,
  PP_FC_AVG.Stock_Strategy             AS Stock_Strategy,
  PP_FC_AVG.Unit_Price                 AS Unit_Price,
  PP_FC_AVG.Reorder_Point              AS Reorder_Point,
  PP_FC_AVG.Safety_stock_Qty           AS Safety_stock_Qty,
  PP_FC_AVG.LOT_SIZE                   AS LOT_SIZE,
  PP_FC_AVG.Min_LOT_SIZE               AS Min_LOT_SIZE,
  PP_FC_AVG.Rounding_val               AS Rounding_val,
  PP_FC_AVG.GRT                        AS GRT,
  PP_FC_AVG.PDT                        AS PDT,
  PP_FC_AVG.IPT                        AS IPT,
  PP_FC_AVG.OH_QTY                     AS OH_QTY,
  NVL(PP_FC_AVG.FC_AVG_WEEK,0)         AS FC_AVG_WEEK,
  NVL(BACKLOG_PASTDUE.BACKLOG_OPEN,0)  AS BACKLOG_OPEN,
  NVL(BACKLOG_PASTDUE.PAST_DUE_OPEN,0) AS PAST_DUE_OPEN
FROM
  (SELECT PP.ID                    AS ID,
    PP.MATERIALID                  AS MATERIALID,
    PP.PLANTID                     AS PLANTID,
    PP.Material_Description        AS Material_Description,
    PP.BU                          AS BU,
    PP.Procurement_Type            AS Procurement_Type,
    PP.MRP_CONTROLLER_ID           AS MRP_CONTROLLER_ID,
    PP.MRP_CONTROLLER              AS MRP_CONTROLLER,
    PP.MATL_TYPE                   AS MATL_TYPE,
    PP.MRP_TYPE                    AS MRP_TYPE,
    PP.Stock_Strategy              AS Stock_Strategy,
    PP.Unit_Price                  AS Unit_Price,
    PP.Reorder_Point               AS Reorder_Point,
    PP.Safety_stock_Qty            AS Safety_stock_Qty,
    PP.LOT_SIZE                    AS LOT_SIZE,
    PP.Min_LOT_SIZE                AS Min_LOT_SIZE,
    PP.Rounding_val                AS Rounding_val,
    PP.GRT                         AS GRT,
    PP.PDT                         AS PDT,
    PP.IPT                         AS IPT,
    PP.OH_QTY                      AS OH_QTY,
    FC_AVG_WEEK.FC_AVG_WEEK        AS FC_AVG_WEEK
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID            AS ID,
      MATERIALID           AS MATERIALID,
      PLANTID              AS PLANTID,
      MAT_DESC             AS Material_Description,
      PROD_BU              AS BU,
      PROC_TYPE            AS Procurement_Type,
      MRP_CONTROLLER_DISPO AS MRP_CONTROLLER_ID,
      MRP_CONTROLLER       AS MRP_CONTROLLER,
      MATL_TYPE_MTART      AS MATL_TYPE,
      MRP_TYPE             AS MRP_TYPE,
      STRATEGY_GRP         AS Stock_Strategy,
      UNIT_COST            AS Unit_Price,
      REORDER_PT           AS Reorder_Point,
      SAFETY_STK           AS Safety_stock_Qty,
      LOT_SIZE_DISLS       AS LOT_SIZE,
      LOT_MIN_BUY          AS Min_LOT_SIZE,
      LOT_ROUNDING_VALUE   AS Rounding_val,
      GRT                  AS GRT,
      PDT                  AS PDT,
      IPT                  AS IPT,
      OH_QTY               AS OH_QTY
    FROM INV_SAP_PP_OPTIMIZATION
    WHERE STRATEGY_GRP   = '40'
    AND MATL_TYPE_MTART IN ('ZFG','ZTG')
    AND PLANTID         IN ('5040', '5070', '5100', '5110', '5140', '5200')
    )PP
  LEFT JOIN
    (SELECT MATERIALID
      ||'_'
      ||PLANTID                           AS ID,
      MATERIALID                          AS MATERIALID,
      PLANTID                             AS PLANTID,
      CEIL(SUM(PLNMG_PLANNEDQUANTITY)/26) AS FC_AVG_WEEK
    FROM INV_SAP_PP_FRCST_PBIM_PBED
    WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
    AND PLANTID                                                                        IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND VERSBP_VERSION = '55'
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
    WHERE PLANT IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MAX_COMMIT_DATE < SYSDATE + 90
    GROUP BY MATERIAL
      ||'_'
      ||PLANT,
      MATERIAL,
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
    WHERE PLANT                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MAX_COMMIT_DATE < SYSDATE - 1
    GROUP BY MATERIAL
      ||'_'
      ||PLANT,
      MATERIAL,
      PLANT
    )PAST_DUE_OPEN
  ON PAST_DUE_OPEN.ID                    = BACKLOG_OPEN.ID
  )BACKLOG_PASTDUE ON BACKLOG_PASTDUE.ID = PP_FC_AVG.ID;
  
  
  
  
  ---testing 3 months
  SELECT BACKLOG_OPEN.ID            AS ID,
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
  WHERE PLANT                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
  AND MAX_COMMIT_DATE < SYSDATE + 90
  GROUP BY MATERIAL
    ||'_'
    ||PLANT,
    MATERIAL,
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
  WHERE PLANT                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
  AND MAX_COMMIT_DATE < SYSDATE - 1
  GROUP BY MATERIAL
    ||'_'
    ||PLANT,
    MATERIAL,
    PLANT
  )PAST_DUE_OPEN
ON PAST_DUE_OPEN.ID = BACKLOG_OPEN.ID;



  --V 0.4 fv join backlog local version, add Last_Review_Date, Lead_Time,OH$$,MAX_INV,TARGET_INV,Present_Week_Status

DROP TABLE STOCK_ITEM_PERFORMANCE;
CREATE TABLE STOCK_ITEM_PERFORMANCE AS
  (SELECT 
      SYSDATE                              AS LAST_REVIEW_DATE,
      PP_FC_AVG.ID                     AS ID,
      PP_FC_AVG.MATERIALID                 AS MATERIALID,
      PP_FC_AVG.PLANTID                    AS PLANTID,
      PP_FC_AVG.Material_Description       AS Material_Description,
      PP_FC_AVG.BU                         AS BU,
      PP_FC_AVG.Procurement_Type           AS Procurement_Type,
      PP_FC_AVG.MRP_CONTROLLER_ID          AS MRP_CONTROLLER_ID,
      PP_FC_AVG.MRP_CONTROLLER             AS MRP_CONTROLLER,
      PP_FC_AVG.MATL_TYPE                  AS MATL_TYPE,
      PP_FC_AVG.MRP_TYPE                   AS MRP_TYPE,
      PP_FC_AVG.Stock_Strategy             AS Stock_Strategy,
      PP_FC_AVG.Unit_Price                 AS Unit_Price,
      PP_FC_AVG.Reorder_Point              AS Reorder_Point,
      PP_FC_AVG.Safety_stock_Qty           AS Safety_stock_Qty,
      PP_FC_AVG.LOT_SIZE                   AS LOT_SIZE,
      PP_FC_AVG.Min_LOT_SIZE               AS Min_LOT_SIZE,
      PP_FC_AVG.Rounding_val               AS Rounding_val,
      PP_FC_AVG.GRT                        AS GRT,
      PP_FC_AVG.PDT                        AS PDT,
      PP_FC_AVG.IPT                        AS IPT,
      PP_FC_AVG.OH_QTY                     AS OH_QTY,
      NVL(PP_FC_AVG.FC_AVG_WEEK,0)         AS FC_AVG_WEEK,
      NVL(BACKLOG_PASTDUE.BACKLOG_OPEN,0)  AS BACKLOG_OPEN,
      NVL(BACKLOG_PASTDUE.PAST_DUE_OPEN,0) AS PAST_DUE_OPEN,
      0                                 AS Lead_Time,
      0                                 AS OH$$,
      0                                 AS MAX_INV,
      0                                 AS TARGET_INV,
      0                                 AS Present_Week_Status
FROM
  (SELECT PP.ID                    AS ID,
    PP.MATERIALID                  AS MATERIALID,
    PP.PLANTID                     AS PLANTID,
    PP.Material_Description        AS Material_Description,
    PP.BU                          AS BU,
    PP.Procurement_Type            AS Procurement_Type,
    PP.MRP_CONTROLLER_ID           AS MRP_CONTROLLER_ID,
    PP.MRP_CONTROLLER              AS MRP_CONTROLLER,
    PP.MATL_TYPE                   AS MATL_TYPE,
    PP.MRP_TYPE                    AS MRP_TYPE,
    PP.Stock_Strategy              AS Stock_Strategy,
    PP.Unit_Price                  AS Unit_Price,
    PP.Reorder_Point               AS Reorder_Point,
    PP.Safety_stock_Qty            AS Safety_stock_Qty,
    PP.LOT_SIZE                    AS LOT_SIZE,
    PP.Min_LOT_SIZE                AS Min_LOT_SIZE,
    PP.Rounding_val                AS Rounding_val,
    PP.GRT                         AS GRT,
    PP.PDT                         AS PDT,
    PP.IPT                         AS IPT,
    PP.OH_QTY                      AS OH_QTY,
    FC_AVG_WEEK.FC_AVG_WEEK        AS FC_AVG_WEEK
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID            AS ID,
      MATERIALID           AS MATERIALID,
      PLANTID              AS PLANTID,
      MAT_DESC             AS Material_Description,
      PROD_BU              AS BU,
      PROC_TYPE            AS Procurement_Type,
      MRP_CONTROLLER_DISPO AS MRP_CONTROLLER_ID,
      MRP_CONTROLLER       AS MRP_CONTROLLER,
      MATL_TYPE_MTART      AS MATL_TYPE,
      MRP_TYPE             AS MRP_TYPE,
      STRATEGY_GRP         AS Stock_Strategy,
      UNIT_COST            AS Unit_Price,
      REORDER_PT           AS Reorder_Point,
      SAFETY_STK           AS Safety_stock_Qty,
      LOT_SIZE_DISLS       AS LOT_SIZE,
      LOT_MIN_BUY          AS Min_LOT_SIZE,
      LOT_ROUNDING_VALUE   AS Rounding_val,
      GRT                  AS GRT,
      PDT                  AS PDT,
      IPT                  AS IPT,
      OH_QTY               AS OH_QTY
    FROM INV_SAP_PP_OPTIMIZATION
    WHERE STRATEGY_GRP   = '40'
    AND MATL_TYPE_MTART IN ('ZFG','ZTG')
    AND PLANTID         IN ('5040', '5070', '5100', '5110', '5140', '5200')
    )PP
  LEFT JOIN
    (SELECT MATERIALID
      ||'_'
      ||PLANTID                           AS ID,
      MATERIALID                          AS MATERIALID,
      PLANTID                             AS PLANTID,
      CEIL(SUM(PLNMG_PLANNEDQUANTITY)/26) AS FC_AVG_WEEK
    FROM INV_SAP_PP_FRCST_PBIM_PBED
    WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
    AND PLANTID                                                                        IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND VERSBP_VERSION = '55'
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
    WHERE PLANT IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MAX_COMMIT_DATE < SYSDATE + 90
    GROUP BY MATERIAL
      ||'_'
      ||PLANT,
      MATERIAL,
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
    WHERE PLANT                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MAX_COMMIT_DATE < SYSDATE - 1
    GROUP BY MATERIAL
      ||'_'
      ||PLANT,
      MATERIAL,
      PLANT
    )PAST_DUE_OPEN
  ON PAST_DUE_OPEN.ID                    = BACKLOG_OPEN.ID
  )BACKLOG_PASTDUE ON BACKLOG_PASTDUE.ID = PP_FC_AVG.ID);
  
  
  
  ---UPDATE AND INSERT
  UPDATE STOCK_ITEM_PERFORMANCE SET STOCK_ITEM_PERFORMANCE.LEAD_TIME = '100' WHERE STOCK_ITEM_PERFORMANCE.ID  = '100-DS1-11 A_5200';
  UPDATE STOCK_ITEM_PERFORMANCE SET STOCK_ITEM_PERFORMANCE.LEAD_TIME ='21' WHERE STOCK_ITEM_PERFORMANCE.ID  = '800T-A1A T_5200 '"
  UPDATE STOCK_ITEM_PERFORMANCE SET STOCK_ITEM_PERFORMANCE.LEAD_TIME ='19',STOCK_ITEM_PERFORMANCE.OH$$ ='19565.968',STOCK_ITEM_PERFORMANCE.MAX_INV ='137.005714285714',STOCK_ITEM_PERFORMANCE.TARGET_INV ='77.22',STOCK_ITEM_PERFORMANCE.Present_Week_Status ='2' WHERE STOCK_ITEM_PERFORMANCE.ID  = 'PN-92012_5040'
  SELECT * FROM STOCK_ITEM_PERFORMANCE WHERE ID = '889D-F4AC-5 B_5070';
--- Caculate Rank
CREATE TABLE STOCK_ITEM_STATUS_BY_BU_WEEK AS
  (SELECT 
      LAST_REVIEW_DATE||'_'||PLANTID||'_'||BU AS ID,
      LAST_REVIEW_DATE AS LAST_REVIEW_DATE,
      PLANTID              AS PLANTID,
      BU                   AS BU,
      --PRESENT_WEEK_STATUS  AS PRESENT_WEEK_STATUS,
      --RANK_BY_BU_PLANT     AS RANK_BY_BU_PLANT,
      0                    AS WEEK_STATUS_1,
      0                    AS WEEK_STATUS_2,
      0                    AS WEEK_STATUS_3,
      0                    AS WEEK_STATUS_4,
      0                    AS WEEK_STATUS_5
FROM
  (SELECT LAST_REVIEW_DATE,
    PLANTID,
    BU,
    PRESENT_WEEK_STATUS,
    SUM(COUNT_KEY) AS RANK_BY_BU_PLANT
  FROM STOCK_ITEM_PERFORMANCE
  WHERE BU IN
    ( SELECT DISTINCT BU FROM STOCK_ITEM_PERFORMANCE
    )
  AND PLANTID IN ('5040', '5070', '5100', '5110', '5140', '5200')
  GROUP BY LAST_REVIEW_DATE,
    PLANTID,
    BU,
    PRESENT_WEEK_STATUS
));

--NEW TABLE STOCK_ITEM_STATUS_BY_BU_WEEK
CREATE TABLE STOCK_ITEM_STATUS_BY_BU_WEEK AS
SELECT DISTINCT * FROM(
  (SELECT LAST_REVIEW_DATE
      ||'_'
      ||PLANTID
      ||'_'
      ||BU             AS ID,
      LAST_REVIEW_DATE AS LAST_REVIEW_DATE,
      PLANTID          AS PLANTID,
      BU               AS BU,
      0                AS WEEK_STATUS_1,
      0                AS WEEK_STATUS_2,
      0                AS WEEK_STATUS_3,
      0                AS WEEK_STATUS_4,
      0                AS WEEK_STATUS_5
    FROM STOCK_ITEM_PERFORMANCE
    WHERE PLANTID IN ('5040', '5070', '5100', '5110', '5140', '5200'))
    );
  
  DROP TABLE STOCK_ITEM_STATUS_BY_BU_WEEK
  SELECT * FROM STOCK_ITEM_STATUS_BY_BU_WEEK WHERE ID = '17-Feb-14_5040_CMX-COMPACTLOGIX';  
  
  
-- STATUS HISTORY
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
  VALUES
  (
    '12-ddd-14_5040_PLS-CSM PLANT SERVICES',
    '12-May-14',
    5040,
    'PLS-CSM PLANT SERVICES',
    NULL,
    1,1,
    NULL,null
  )  
---Clear Table Data
truncate TABLE STOCK_ITEM_STATUS_BY_BU_WEEK
SELECT * FROM STOCK_ITEM_STATUS_BY_BU_WEEK where id = '1-MAY-14_5140_SEN-SENSING & CONNECTIVITY'

SELECT COUNT(*) FROM STOCK_ITEM_STATUS_BY_BU_WEEK;

--Prepare Data in Stock_item_status
INSERT INTO STOCK_ITEM_STATUS_BY_BU_WEEK
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
SELECT DISTINCT * FROM(
  (SELECT LAST_REVIEW_DATE
      ||'_'
      ||PLANTID
      ||'_'
      ||BU             AS ID,
      LAST_REVIEW_DATE AS LAST_REVIEW_DATE,
      PLANTID          AS PLANTID,
      BU               AS BU,
      0                AS WEEK_STATUS_1,
      0                AS WEEK_STATUS_2,
      0                AS WEEK_STATUS_3,
      0                AS WEEK_STATUS_4,
      0                AS WEEK_STATUS_5
    FROM STOCK_ITEM_PERFORMANCE
    WHERE PLANTID IN ('5040', '5070', '5100', '5110', '5140', '5200'))
    );


----------------------------------------------------------------------------------
CREATE TABLE STOCK_ITEM_PERFORMANCE AS
  (SELECT 
      SYSDATE                              AS LAST_REVIEW_DATE,
      PP_FC_AVG.ID                     AS ID,
      PP_FC_AVG.MATERIALID                 AS MATERIALID,
      PP_FC_AVG.PLANTID                    AS PLANTID,
      PP_FC_AVG.Material_Description       AS Material_Description,
      PP_FC_AVG.BU                         AS BU,
      PP_FC_AVG.Procurement_Type           AS Procurement_Type,
      PP_FC_AVG.MRP_CONTROLLER_ID          AS MRP_CONTROLLER_ID,
      PP_FC_AVG.MRP_CONTROLLER             AS MRP_CONTROLLER,
      PP_FC_AVG.MATL_TYPE                  AS MATL_TYPE,
      PP_FC_AVG.MRP_TYPE                   AS MRP_TYPE,
      PP_FC_AVG.Stock_Strategy             AS Stock_Strategy,
      PP_FC_AVG.Unit_Price                 AS Unit_Price,
      PP_FC_AVG.Reorder_Point              AS Reorder_Point,
      PP_FC_AVG.Safety_stock_Qty           AS Safety_stock_Qty,
      PP_FC_AVG.LOT_SIZE                   AS LOT_SIZE,
      PP_FC_AVG.Min_LOT_SIZE               AS Min_LOT_SIZE,
      PP_FC_AVG.Rounding_val               AS Rounding_val,
      PP_FC_AVG.GRT                        AS GRT,
      PP_FC_AVG.PDT                        AS PDT,
      PP_FC_AVG.IPT                        AS IPT,
      PP_FC_AVG.OH_QTY                     AS OH_QTY,
      NVL(PP_FC_AVG.FC_AVG_WEEK,0)         AS FC_AVG_WEEK,
      NVL(BACKLOG_PASTDUE.BACKLOG_OPEN,0)  AS BACKLOG_OPEN,
      NVL(BACKLOG_PASTDUE.PAST_DUE_OPEN,0) AS PAST_DUE_OPEN,
      0                                 AS Lead_Time,
      0                                 AS OH$$,
      0                                 AS MAX_INV,
      0                                 AS TARGET_INV,
      0                                 AS Present_Week_Status,
      1          AS  COUNT_KEY
FROM
  (SELECT PP.ID                    AS ID,
    PP.MATERIALID                  AS MATERIALID,
    PP.PLANTID                     AS PLANTID,
    PP.Material_Description        AS Material_Description,
    PP.BU                          AS BU,
    PP.Procurement_Type            AS Procurement_Type,
    PP.MRP_CONTROLLER_ID           AS MRP_CONTROLLER_ID,
    PP.MRP_CONTROLLER              AS MRP_CONTROLLER,
    PP.MATL_TYPE                   AS MATL_TYPE,
    PP.MRP_TYPE                    AS MRP_TYPE,
    PP.Stock_Strategy              AS Stock_Strategy,
    PP.Unit_Price                  AS Unit_Price,
    PP.Reorder_Point               AS Reorder_Point,
    PP.Safety_stock_Qty            AS Safety_stock_Qty,
    PP.LOT_SIZE                    AS LOT_SIZE,
    PP.Min_LOT_SIZE                AS Min_LOT_SIZE,
    PP.Rounding_val                AS Rounding_val,
    PP.GRT                         AS GRT,
    PP.PDT                         AS PDT,
    PP.IPT                         AS IPT,
    PP.OH_QTY                      AS OH_QTY,
    FC_AVG_WEEK.FC_AVG_WEEK        AS FC_AVG_WEEK
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID            AS ID,
      MATERIALID           AS MATERIALID,
      PLANTID              AS PLANTID,
      MAT_DESC             AS Material_Description,
      PROD_BU              AS BU,
      PROC_TYPE            AS Procurement_Type,
      MRP_CONTROLLER_DISPO AS MRP_CONTROLLER_ID,
      MRP_CONTROLLER       AS MRP_CONTROLLER,
      MATL_TYPE_MTART      AS MATL_TYPE,
      MRP_TYPE             AS MRP_TYPE,
      STRATEGY_GRP         AS Stock_Strategy,
      UNIT_COST            AS Unit_Price,
      REORDER_PT           AS Reorder_Point,
      SAFETY_STK           AS Safety_stock_Qty,
      LOT_SIZE_DISLS       AS LOT_SIZE,
      LOT_MIN_BUY          AS Min_LOT_SIZE,
      LOT_ROUNDING_VALUE   AS Rounding_val,
      GRT                  AS GRT,
      PDT                  AS PDT,
      IPT                  AS IPT,
      OH_QTY               AS OH_QTY
    FROM INV_SAP_PP_OPTIMIZATION
    WHERE STRATEGY_GRP   = '40'
    AND MATL_TYPE_MTART IN ('ZFG','ZTG')
    AND PLANTID         IN ('5040', '5070', '5100', '5110', '5140', '5200')
    )PP
  LEFT JOIN
    (SELECT MATERIALID
      ||'_'
      ||PLANTID                           AS ID,
      MATERIALID                          AS MATERIALID,
      PLANTID                             AS PLANTID,
      CEIL(SUM(PLNMG_PLANNEDQUANTITY)/26) AS FC_AVG_WEEK
    FROM INV_SAP_PP_FRCST_PBIM_PBED
    WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
    AND PLANTID                                                                        IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND VERSBP_VERSION = '55'
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
    WHERE PLANT                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MAX_REQUEST_DATE < SYSDATE + 90 AND SALESDOCTYPE IN ('ZOR1','ZOR5')
    AND OPEN_QTY > 0
    GROUP BY MATERIAL, PLANT
    )BACKLOG_OPEN
  LEFT JOIN
    (SELECT MATERIAL
      ||'_'
      ||PLANT       AS ID,
      MATERIAL      AS MATERIALID,
      PLANT         AS PLANTID,
      SUM(OPEN_QTY) AS PAST_DUE_OPEN_QTY
    FROM INV_SAP_SALES_VBAK_VBAP_VBUP
    WHERE PLANT                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MAX_COMMIT_DATE < SYSDATE - 1 AND SALESDOCTYPE IN ('ZOR1','ZOR5')
    AND OPEN_QTY > 0
    GROUP BY MATERIAL, PLANT
    )PAST_DUE_OPEN
  ON PAST_DUE_OPEN.ID                    = BACKLOG_OPEN.ID
  )BACKLOG_PASTDUE ON BACKLOG_PASTDUE.ID = PP_FC_AVG.ID)

------------------------------------------------------------------------------------------------------------------------


CREATE TABLE STOCK_ITEM_PERFORMANCE AS
  (SELECT SYSDATE                         AS LAST_REVIEW_DATE,
  PP_FC_AVG.ID                         AS ID,
  PP_FC_AVG.MATERIAL                   AS MATERIAL,
  PP_FC_AVG.CATALOG_DASH               AS CATALOG_DASH,
  PP_FC_AVG.PLANT                      AS PLANT,
  PP_FC_AVG.MAT_DESC                   AS MAT_DESC,
  PP_FC_AVG.PROD_BU                    AS BU,
  PP_FC_AVG.PROC_TYPE                  AS PROC_TYPE,
  PP_FC_AVG.MRP_CONTROLLER_KEY         AS MRP_CONTROLLER_KEY,
  PP_FC_AVG.MRP_CONTROLLER             AS MRP_CONTROLLER,
  PP_FC_AVG.MATL_TYPE                  AS MATL_TYPE,
  PP_FC_AVG.MRP_TYPE                   AS MRP_TYPE,
  PP_FC_AVG.STRATEGY_GRP               AS STRATEGY_GRP,
  PP_FC_AVG.UNIT_COST                  AS UNIT_COST,
  PP_FC_AVG.RECORDER_POINT             AS RECORDER_POINT,
  PP_FC_AVG.SAFETY_STOCK               AS SAFETY_STOCK,
  PP_FC_AVG.LOT_SIZE_DISLS             AS LOT_SIZE,
  PP_FC_AVG.LOT_MIN_BUY                AS MIN_LOT_SIZE,
  PP_FC_AVG.LOT_ROUNDING_VALUE         AS LOT_ROUNDING_VALUE,
  PP_FC_AVG.GRT                        AS GRT,
  PP_FC_AVG.PDT                        AS PDT,
  PP_FC_AVG.OH_QTY                     AS OH_QTY,
  NVL(PP_FC_AVG.FC_AVG_WEEK,0)         AS FC_AVG_WEEK,
  NVL(BACKLOG_PASTDUE.BACKLOG_OPEN,0)  AS BACKLOG_OPEN,
  NVL(BACKLOG_PASTDUE.PAST_DUE_OPEN,0) AS PAST_DUE_OPEN,
  PP_FC_AVG.LEAD_TIME                  AS LEAD_TIME,
  (NVL(PP_FC_AVG.UNIT_COST,0)*NVL(PP_FC_AVG.OH_QTY,0)) AS OH$$,
  0                                    AS MAX_INV,
  0                                    AS TARGET_INV,
  0                                    AS PRESENT_WEEK_STATUS,
  1                                    AS COUNT_KEY
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
    AND PLANT         IN ('5040', '5070', '5100', '5110', '5140', '5200')
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
    AND PLANTID                                                   IN ('5040', '5070', '5100', '5110', '5140', '5200')
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
    WHERE PLANT                   IN ('5040', '5070', '5100', '5110', '5140', '5200')
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
    WHERE PLANT                  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MAX_COMMIT_DATE < SYSDATE - 1
    AND SALESDOCTYPE             IN ('ZOR1','ZOR5')
    AND OPEN_QTY        > 0
    GROUP BY MATERIAL,
      PLANT
    )PAST_DUE_OPEN
  ON PAST_DUE_OPEN.ID                    = BACKLOG_OPEN.ID
  )BACKLOG_PASTDUE ON BACKLOG_PASTDUE.ID = PP_FC_AVG.ID)
  
  
  
  
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
OH$$,
MAX_INV,
TARGET_INV,
PRESENT_WEEK_STATUS
FROM STOCK_ITEM_PERFORMANCE

select * from STOCK_ITEM_STATUS_BY_BU_WEEK where id = '23-JUL-14_5070_DIO'
INSERT
INTO STOCK_ITEM_STATUS_BY_BU_WEEK
  (
    ID,
    LAST_REVIEW_DATE,
    PLANT,
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
  
  
  
  
  
  
SELECT 
      LAST_REVIEW_DATE||'_'||PLANT||'_'||BU AS ID,
      LAST_REVIEW_DATE AS LAST_REVIEW_DATE,
      PLANT              AS PLANT,
      BU                   AS BU,
      PRESENT_WEEK_STATUS  AS PRESENT_WEEK_STATUS,
      RANK_BY_BU_PLANT     AS RANK_BY_BU_PLANT
FROM
  (SELECT LAST_REVIEW_DATE,
    PLANTID,
    BU,
    PRESENT_WEEK_STATUS,
    SUM(COUNT_KEY) AS RANK_BY_BU_PLANT
  FROM STOCK_ITEM_PERFORMANCE
  WHERE BU IN
    ( SELECT DISTINCT BU FROM STOCK_ITEM_PERFORMANCE
    )
  AND PLANTID IN ('5040', '5070', '5100', '5110', '5140', '5200')
  GROUP BY LAST_REVIEW_DATE,
    PLANTID,
    BU,
    PRESENT_WEEK_STATUS
  )





INSERT INTO STOCK_ITEM_STATUS_BY_BU_WEEK
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
SELECT DISTINCT * FROM(
  (SELECT LAST_REVIEW_DATE
      ||'_'
      ||PLANT
      ||'_'
      ||BU             AS ID,
      LAST_REVIEW_DATE AS LAST_REVIEW_DATE,
      PLANTID          AS PLANT,
      BU               AS BU,
      0                AS WEEK_STATUS_1,
      0                AS WEEK_STATUS_2,
      0                AS WEEK_STATUS_3,
      0                AS WEEK_STATUS_4,
      0                AS WEEK_STATUS_5
    FROM STOCK_ITEM_PERFORMANCE
    WHERE PLANT IN ('5040', '5070', '5100', '5110', '5140', '5200'))
    )
    
    
    
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
  VALUES
  (
    'ID_1',
    'LAST_REVIEW_DATE_1',
    PLANTID_2,
    'BU_1',
    'MATERIAL_1',
    STATUS_1
  )

    
    
    
    
    
    
    
    
INSERT
INTO STOCK_ITEM_STATUS_BY_BU_WEEK
  (
    ID,
    LAST_REVIEW_DATE,
    PLANT,
    BU,
    WEEK_STATUS_1,
    WEEK_STATUS_2,
    WEEK_STATUS_3,
    WEEK_STATUS_4,
    WEEK_STATUS_5
  )
  VALUES
  (
    'ID_1',
    'LAST_REVIEW_DATE_1',
    PLANTID_2,
    'BU_1',
    WEEK_STATUS_1_1,
    WEEK_STATUS_2_1,
    WEEK_STATUS_3_1,
    WEEK_STATUS_4_1,
    WEEK_STATUS_5_1
  )
  
  
  
  
  
  
  
"CREATE TABLE STOCK_ITEM_PERFORMANCE AS
  (SELECT SYSDATE                         AS LAST_REVIEW_DATE,
  PP_FC_AVG.ID                         AS ID,
  PP_FC_AVG.MATERIAL                   AS MATERIAL,
  PP_FC_AVG.CATALOG_DASH               AS CATALOG_DASH,
  PP_FC_AVG.PLANT                      AS PLANT,
  PP_FC_AVG.MAT_DESC                   AS MAT_DESC,
  PP_FC_AVG.PROD_BU                    AS BU,
  PP_FC_AVG.PROC_TYPE                  AS PROC_TYPE,
  PP_FC_AVG.MRP_CONTROLLER_KEY         AS MRP_CONTROLLER_KEY,
  PP_FC_AVG.MRP_CONTROLLER             AS MRP_CONTROLLER,
  PP_FC_AVG.MATL_TYPE                  AS MATL_TYPE,
  PP_FC_AVG.MRP_TYPE                   AS MRP_TYPE,
  PP_FC_AVG.STRATEGY_GRP               AS STRATEGY_GRP,
  PP_FC_AVG.UNIT_COST                  AS UNIT_COST,
  PP_FC_AVG.RECORDER_POINT             AS RECORDER_POINT,
  PP_FC_AVG.SAFETY_STOCK               AS SAFETY_STOCK,
  PP_FC_AVG.LOT_SIZE_DISLS             AS LOT_SIZE,
  PP_FC_AVG.LOT_MIN_BUY                AS MIN_LOT_SIZE,
  PP_FC_AVG.LOT_ROUNDING_VALUE         AS LOT_ROUNDING_VALUE,
  PP_FC_AVG.GRT                        AS GRT,
  PP_FC_AVG.PDT                        AS PDT,
  PP_FC_AVG.OH_QTY                     AS OH_QTY,
  NVL(PP_FC_AVG.FC_AVG_WEEK,0)         AS FC_AVG_WEEK,
  NVL(BACKLOG_PASTDUE.BACKLOG_OPEN,0)  AS BACKLOG_OPEN,
  NVL(BACKLOG_PASTDUE.PAST_DUE_OPEN,0) AS PAST_DUE_OPEN,
  PP_FC_AVG.LEAD_TIME                  AS LEAD_TIME,
  (NVL(PP_FC_AVG.UNIT_COST,0)*NVL(PP_FC_AVG.OH_QTY,0)) AS OH$$,
  0                                    AS MAX_INV,
  0                                    AS TARGET_INV,
  0                                    AS PRESENT_WEEK_STATUS,
  1                                    AS COUNT_KEY
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
  )BACKLOG_PASTDUE ON BACKLOG_PASTDUE.ID = PP_FC_AVG.ID)"

  
  
  
  
  
  
  
  