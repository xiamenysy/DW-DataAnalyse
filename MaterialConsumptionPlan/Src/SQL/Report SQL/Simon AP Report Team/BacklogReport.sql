--DATE:6/22/2014
--AUTHOR:HUANG MOYUE
--BACKLOG REPORT FOR ALL PLANTS

--DASH BOARD



--SALES_ORDERS
--VIEW_INV_SAP_BACKLOG_SO
DROP VIEW VIEW_INV_SAP_BACKLOG_SO;
DROP TABLE INV_SAP_BACKLOG_SO;
SELECT * FROM INV_SAP_BACKLOG_SO;
CREATE TABLE INV_SAP_BACKLOG_SO AS 
SELECT * FROM VIEW_INV_SAP_BACKLOG_SO;
CREATE VIEW VIEW_INV_SAP_BACKLOG_SO AS
SELECT OPEN_SO_BASIC.ID                                       AS ID,
  OPEN_SO_BASIC.SO_ID                                         AS SO_ID,
  SALES_PP_X.PROC_TYPE                                        AS PROC_TYPE,
  OPEN_SO_BASIC.PLANT                                         AS PLANT,
  OPEN_SO_BASIC.SALES_ORG                                     AS SALES_ORG,
  OPEN_SO_BASIC.SHIPPING_POINT                                AS SHIPPING_POINT,
  OPEN_SO_BASIC.SALE_DOC_TYPE                                 AS SALE_DOC_TYPE,
  OPEN_SO_BASIC.SALES_DOC                                     AS SALES_DOC,
  OPEN_SO_BASIC.LINE_NUM                                      AS LINE_NUM,
  OPEN_SO_BASIC.MATERIAL                                      AS MATERIAL,
  SALES_PP_X.CATALOG_DASH                                     AS CATALOG_DASH,
  SALES_PP_X.MAT_DESC                                         AS MAT_DESC,
  SALES_PP_X.MATL_TYPE                                        AS MATL_TYPE,
  SALES_PP_X.SAFETY_STOCK                                     AS SAFETY_STOCK,
  SALES_PP_X.STRATEGY_GRP                                     AS STRATEGY_GRP,
  SALES_PP_X.LEAD_TIME                                        AS LEAD_TIME,
  OPEN_SO_BASIC.BU                                            AS BU,
  OPEN_SO_BASIC.LINE_CREATED_DATE                             AS LINE_CREATED_DATE,
  OPEN_SO_BASIC.REQUIRE_DATE                                  AS REQUIRE_DATE,
  OPEN_SO_BASIC.COMMITTED_DATE                                AS COMMITTED_DATE,
  OPEN_SO_BASIC.CONFIRM_DATE                                  AS CONFIRM_DATE,
  (OPEN_SO_BASIC.COMMITTED_DATE - OPEN_SO_BASIC.CONFIRM_DATE) AS GAP,
  OPEN_SO_BASIC.LST_ACT_GI_DATE                               AS LST_ACT_GI_DATE,
  OPEN_SO_BASIC.LST_DELIVERY_CREATE_DATE                      AS LST_DELIVERY_CREATE_DATE,
  OPEN_SO_BASIC.ORDER_QTY                                     AS ORDER_QTY,
  OPEN_SO_BASIC.OPEN_QTY                                      AS OPEN_QTY,
  (OPEN_SO_BASIC.ORDER_QTY - OPEN_SO_BASIC.OPEN_QTY)          AS SHIPPED_QTY,
  SALES_PP_X.UNIT                                             AS UNIT,
  OPEN_SO_BASIC.PROFIT_CENTER                                 AS PROFIT_CENTER,
  OPEN_SO_BASIC.SALES_PRICE                                   AS SALES_PRICE,
  OPEN_SO_BASIC.CURRENCY                                      AS CURRENCY,
  OPEN_SO_BASIC.SOLD_TO_PARTY                                 AS SOLD_TO_PARTY,
  OPEN_SO_BASIC.ROUTE                                         AS ROUTE,
  OPEN_SO_BASIC.DELIVERY_PRIORITY                             AS DELIVERY_PRIORITY,
  SALES_PP_X.MRP_CONTROLLER                                   AS MRP_CONTROLLER,
  SALES_PP_X.PURCH_GROUP                                      AS PURCH_GROUP,
  SALES_PP_X.MRP_TYPE                                         AS MRP_TYPE,
  OPEN_SO_BASIC.DELIVERY_STATUS                               AS DELIVERY_STATUS,
  OPEN_SO_BASIC.OVER_ALL_DELIVERY_STATUS                      AS OVER_ALL_DELIVERY_STATUS,
  SALES_PP_X.VENDOR_KEY                                       AS VENDOR_KEY,
  OPEN_SO_BASIC.STOCK_STATUS                                  AS STOCK_STATUS,
  OPEN_SO_BASIC.EXCHANGE_RATE_TO_USD                          AS EXCHANGE_RATE_TO_USD
FROM
  (SELECT SALESDOC
    ||'_'
    || SALESDOCITEM AS SO_ID,
    MATERIAL
    ||'_'
    || PLANT              AS ID,
    SALESDOC              AS SALES_DOC,
    SALESDOCITEM          AS LINE_NUM,
    MATERIAL              AS MATERIAL,
    PLANT                 AS PLANT,
    SALES_ORG             AS SALES_ORG,
    LINECREATEDATE        AS LINE_CREATED_DATE,
    SUBSTR(PRODHIER,0,3)  AS BU,
    ORDERQTY              AS ORDER_QTY,
    OPEN_QTY              AS OPEN_QTY,
    PROFITCENTER          AS PROFIT_CENTER,
    SALESPRICE            AS SALES_PRICE,
    CURRENCY              AS CURRENCY,
    MAX_COMMIT_DATE       AS COMMITTED_DATE,
    MAX_CONFIRM_DATE      AS CONFIRM_DATE,
    SOLD_TO               AS SOLD_TO_PARTY,
    DELIVSTATUS           AS DELIVERY_STATUS,
    OVERALLDELIVSTATSU    AS OVER_ALL_DELIVERY_STATUS,
    SALESDOCTYPE          AS SALE_DOC_TYPE,
    SHIPFROM_VSTEL        AS SHIPPING_POINT,
    STOCKSTATUS           AS STOCK_STATUS,
    DELIVPRIO             AS DELIVERY_PRIORITY,
    LST_ACT_GI_DATE       AS LST_ACT_GI_DATE,
    LST_DELV_CREATED_DATE AS LST_DELIVERY_CREATE_DATE,
    EXCHANGE_RATE_TO_USD  AS EXCHANGE_RATE_TO_USD,
    MAX_REQUEST_DATE      AS REQUIRE_DATE,
    ROUTE                 AS ROUTE
  FROM INV_SAP_SALES_VBAK_VBAP_VBUP
  )OPEN_SO_BASIC
LEFT JOIN
  (SELECT ID,
    CATALOG_DASH,
    MAT_DESC,
    SAFETY_STOCK,
    PROC_TYPE,
    UNIT,
    STRATEGY_GRP,
    MRP_TYPE,
    VENDOR_KEY,
    MRP_CONTROLLER,
    PURCH_GROUP,
    LEAD_TIME,
    MATL_TYPE
  FROM VIEW_INV_SAP_PP_OPT_X
  )SALES_PP_X
ON SALES_PP_X.ID = OPEN_SO_BASIC.ID;




--PURCHASE_ORDER
--VIEW_INV_SAP_OPEN_PO
DROP VIEW VIEW_INV_SAP_BACKLOG_PO;
DROP TABLE INV_SAP_BACKLOG_PO;
SELECT * FROM INV_SAP_BACKLOG_PO;
CREATE TABLE INV_SAP_BACKLOG_PO AS
SELECT * FROM VIEW_INV_SAP_BACKLOG_PO where PO_ID = '6301433321_0041-5076';
CREATE VIEW VIEW_INV_SAP_BACKLOG_PO AS
SELECT PO_HIS_LN_OP.PO_ID         AS PO_ID,
  PO_HIS_LN_OP.ID                 AS ID,
  PO_HIS_LN_OP.PURCHDOCCAT        AS PROCUREMENT_TYPE,
  PO_HIS_LN_OP.SHIPPING_POINT     AS SHIPPING_POINT,
  PO_HIS_LN_OP.DELIVERY_PRIORITY  AS DELIVERY_PRIORITY,
  PO_HIS_LN_OP.PLANT              AS PLANT,
  PO_HIS_LN_OP.PO                 AS PO,
  PO_HIS_LN_OP.ITEM               AS ITEM,
  PO_HIS_LN_OP.MATERIAL           AS MATERIAL,
  ITEM_BASIC.CATALOG_DASH         AS CATALOG_DASH,
  ITEM_BASIC.MAT_DESC             AS MAT_DESC,
  ITEM_BASIC.PROD_BU              AS PROD_BU,
  PO_HIS_LN_OP.STRATEGY_GRP       AS STRATEGY_GRP,
  ITEM_BASIC.MATL_TYPE            AS MATL_TYPE,
  PO_HIS_LN_OP.PURCHDOC_TYPE      AS PURCHDOC_TYPE,
  PO_HIS_LN_OP.VENDOR             AS VENDOR,
  PO_HIS_LN_OP.PO_SO_SA_FLAG      AS PO_SO_SA_FLAG,
  PO_HIS_LN_OP.CREATED_DATE       AS CREATED_DATE,
  PO_HIS_LN_OP.START_DELIVER_DATE AS START_DELIVER_DATE,
  PO_HIS_LN_OP.COMMITTED_DATE     AS MAX_COMMITTED_DATE,
  PO_HIS_LN_OP.PURCHDELIVSCH_LINE AS PURCHDELIVSCH_LINE,
  PO_HIS_LN_OP.PURHCASE_QTY       AS PURHCASE_QTY,
  PO_HIS_LN_OP.PO_OPEN_QTY        AS PO_OPEN_QTY,
  PO_HIS_LN_OP.PO_OPEN_LINE_QTY   AS PO_SPLIT_LINE_QTY,
  PO_HIS_LN_OP.TRANSIT_DAYS       AS TRANSIT_DAYS,
  PO_HIS_LN_OP.UNIT_COST          AS UNIT_COST,
  PO_HIS_LN_OP.ORDER_VALUE        AS ORDER_VALUE,
  PO_HIS_LN_OP.CURRENCY           AS CURRENCY,
  PO_HIS_LN_OP.LEAD_TIME          AS LEAD_TIME,
  PO_HIS_LN_OP.GRT                AS GRT,
  ITEM_BASIC.MRP_TYPE             AS MRP_TYPE,
  PO_HIS_LN_OP.MRP_CONTROLLER     AS MRP_CONTROLLER,
  PO_HIS_LN_OP.PROC_KEY           AS PROC_KEY,
  PO_HIS_LN_OP.PURCH_GROUP        AS PURCH_GROUP,
  PO_HIS_LN_OP.ROUTE              AS ROUTE,
  PO_HIS_LN_OP.PR                 AS PR
FROM
  (SELECT PO_HIS_LN.PO_ID        AS PO_ID,
    PO_HIS_LN.ID                 AS ID,
    PO_HIS_LN.PO                 AS PO,
    PO_HIS_LN.ITEM               AS ITEM,
    PO_HIS_LN.MATERIAL           AS MATERIAL,
    PO_HIS_LN.PLANT              AS PLANT,
    PO_HIS_LN.PURCHDOCCAT        AS PURCHDOCCAT,
    PO_HIS_LN.PURCHDOC_TYPE      AS PURCHDOC_TYPE,
    PO_HIS_LN.VENDOR             AS VENDOR,
    PO_HIS_LN.PURCHDELIVSCH_LINE AS PURCHDELIVSCH_LINE,
    PO_HIS_LN.PURHCASE_QTY       AS PURHCASE_QTY,
    PO_HIS_LN.START_DELIVER_DATE AS START_DELIVER_DATE,
    PO_HIS_LN.COMMITTED_DATE     AS COMMITTED_DATE,
    PO_HIS_LN.PO_SO_SA_FLAG      AS PO_SO_SA_FLAG,
    PO_HIS_LN.CREATED_DATE       AS CREATED_DATE,
    PO_HIS_LN.CURRENCY           AS CURRENCY,
    PO_HIS_LN.ORDER_VALUE        AS ORDER_VALUE,
    PO_HIS_LN.LEAD_TIME          AS LEAD_TIME,
    PO_HIS_LN.GRT                AS GRT,
    PO_HIS_LN.MRP_CONTROLLER     AS MRP_CONTROLLER,
    PO_HIS_LN.PROC_KEY           AS PROC_KEY,
    PO_HIS_LN.PURCH_GROUP        AS PURCH_GROUP,
    PO_HIS_LN.STRATEGY_GRP       AS STRATEGY_GRP,
    PO_HIS_LN.UNIT_COST          AS UNIT_COST,
    PO_HIS_LN.PR                 AS PR,
    PO_HIS_LN.SHIPPING_POINT     AS SHIPPING_POINT,
    PO_HIS_LN.DELIVERY_PRIORITY  AS DELIVERY_PRIORITY,
    PO_HIS_LN.ROUTE              AS ROUTE,
    PO_HIS_LN.TRANSIT_DAYS       AS TRANSIT_DAYS,
    PO_HIS_LN.PO_OPEN_LINE_QTY   AS PO_OPEN_LINE_QTY,
    PO_OPEN_QTY.OPEN_QTY         AS PO_OPEN_QTY
  FROM
    (SELECT PO_HIS.PO_ID        AS PO_ID,
      PO_HIS.ID                 AS ID,
      PO_HIS.PO                 AS PO,
      PO_HIS.ITEM               AS ITEM,
      PO_HIS.MATERIAL           AS MATERIAL,
      PO_HIS.PLANT              AS PLANT,
      PO_HIS.PURCHDOCCAT        AS PURCHDOCCAT,
      PO_HIS.PURCHDOC_TYPE      AS PURCHDOC_TYPE,
      PO_HIS.VENDOR             AS VENDOR,
      PO_HIS.PURCHDELIVSCH_LINE AS PURCHDELIVSCH_LINE,
      PO_HIS.PURHCASE_QTY       AS PURHCASE_QTY,
      PO_HIS.START_DELIVER_DATE AS START_DELIVER_DATE,
      PO_HIS.COMMITTED_DATE     AS COMMITTED_DATE,
      PO_HIS.PO_SO_SA_FLAG      AS PO_SO_SA_FLAG,
      PO_HIS.CREATED_DATE       AS CREATED_DATE,
      PO_HIS.CURRENCY           AS CURRENCY,
      PO_HIS.ORDER_VALUE        AS ORDER_VALUE,
      PO_HIS.LEAD_TIME          AS LEAD_TIME,
      PO_HIS.GRT                AS GRT,
      PO_HIS.MRP_CONTROLLER     AS MRP_CONTROLLER,
      PO_HIS.PROC_KEY           AS PROC_KEY,
      PO_HIS.PURCH_GROUP        AS PURCH_GROUP,
      PO_HIS.STRATEGY_GRP       AS STRATEGY_GRP,
      PO_HIS.UNIT_COST          AS UNIT_COST,
      PO_HIS.PR                 AS PR,
      PO_HIS.SHIPPING_POINT     AS SHIPPING_POINT,
      PO_HIS.DELIVERY_PRIORITY  AS DELIVERY_PRIORITY,
      PO_HIS.ROUTE              AS ROUTE,
      PO_HIS.TRANSIT_DAYS       AS TRANSIT_DAYS,
      CASE
        WHEN PO_OPEN_LINE.LINECOUNT = '1'
        THEN 1
        ELSE (PO_OPEN_LINE.LINECOUNT - 1)
      END PO_OPEN_LINE_QTY
    FROM
      (SELECT EBELNPURCHDOCNO
        ||'_'
        ||MATERIALID AS PO_ID,
        MATERIALID
        ||'_'
        ||PLANTID                AS ID,
        MATERIALID               AS MATERIAL,
        PLANTID                  AS PLANT,
        BSTYP_PURCHDOCCAT        AS PURCHDOCCAT,
        BSART_PURCHDOCTYPE       AS PURCHDOC_TYPE,
        LIFNR_VENDORNO           AS VENDOR,
        EBELNPURCHDOCNO          AS PO,
        EBELPPURCHITEMNO         AS ITEM,
        ETENRPURCHDELIVSCHLINESA AS PURCHDELIVSCH_LINE,
        MENGESCHEDULEDQTY        AS PURHCASE_QTY,
        WEMNGRECEIVEDQTY         AS RECEIVED_QTY,
        SLFDTSTATDELIVERYDATE    AS START_DELIVER_DATE,
        DELIVERYCOMPLETE         AS DELIVERY_COMPLETE_FLAG,
        COMMITTED_DATE           AS COMMITTED_DATE,
        COMMITTEDQTY             AS COMMITTED_QTY,
        PO_SO_SA_FLAG            AS PO_SO_SA_FLAG,
        CREATED_DATE             AS CREATED_DATE,
        WAERS_CURRENCYKEY        AS CURRENCY,
        NETWRNETORDERVALUE       AS ORDER_VALUE,
        LT                       AS LEAD_TIME,
        GRT                      AS GRT,
        MRP_CONTROLLER           AS MRP_CONTROLLER,
        SPC_PROC_KEY             AS PROC_KEY,
        PURCH_GROUP              AS PURCH_GROUP,
        STRATEGY_GRP             AS STRATEGY_GRP,
        UNIT_COST                AS UNIT_COST,
        PURCH_REQ                AS PR,
        SHIPPING_POINT           AS SHIPPING_POINT,
        DELIVERY_PRIORITY        AS DELIVERY_PRIORITY,
        ROUTE                    AS ROUTE,
        TRANSIT_DAYS             AS TRANSIT_DAYS
      FROM INV_SAP_PP_PO_HISTORY
      WHERE DELIVERYCOMPLETE      IS NULL
      AND ETENRPURCHDELIVSCHLINESA = '1'
      )PO_HIS
    LEFT JOIN
      (
      --PO_OPEN_LINE_QTY
      SELECT EBELNPURCHDOCNO
        ||'_'
        ||MATERIALID AS PO_ID,
        MATERIALID,
        PLANTID,
        SUM(PLANTID)/PLANTID AS LINECOUNT
      FROM INV_SAP_PP_PO_HISTORY
      GROUP BY EBELNPURCHDOCNO
        ||'_'
        ||MATERIALID,
        MATERIALID,
        PLANTID
      )PO_OPEN_LINE
    ON PO_OPEN_LINE.PO_ID = PO_HIS.PO_ID
    )PO_HIS_LN
  LEFT JOIN
    --PO_OPEN_QTY
    (
    SELECT EBELNPURCHDOCNO
      ||'_'
      ||MATERIALID AS PO_ID,
      MATERIALID,
      PLANTID,
      SUM(COMMITTEDQTY) AS OPEN_QTY
    FROM INV_SAP_PP_PO_HISTORY
    WHERE DELIVERYCOMPLETE IS NULL
    GROUP BY EBELNPURCHDOCNO
      ||'_'
      ||MATERIALID,
      MATERIALID,
      PLANTID
    )PO_OPEN_QTY
  ON PO_OPEN_QTY.PO_ID = PO_HIS_LN.PO_ID
  )PO_HIS_LN_OP
LEFT JOIN
  (SELECT ID,
    CATALOG_DASH,
    MAT_DESC,
    MRP_TYPE,
    PROD_BU,
    MATL_TYPE
  FROM VIEW_INV_SAP_PP_OPT_X
  )ITEM_BASIC
ON ITEM_BASIC.ID = PO_HIS_LN_OP.ID;


--INVENTORY STATUS
--VIEW_INV_SAP_BACKLOG_INV
DROP VIEW VIEW_INV_SAP_BACKLOG_INV;
SELECT * FROM VIEW_INV_SAP_BACKLOG_INV WHERE ID = '0041-5081_5070';
CREATE VIEW VIEW_INV_SAP_BACKLOG_INV AS
SELECT INV_BASIC.LAST_REVIEW_DATE AS LAST_REVIEW_DATE,
  INV_BASIC.ID                    AS ID,
  INV_BASIC.PLANT                 AS PLANT,
  INV_BASIC.MATERIAL              AS MATERIAL,
  ITEM_BASIC.CATALOG_DASH         AS CATALOG_DASH,
  ITEM_BASIC.MAT_DESC             AS MAT_DESC,
  ITEM_BASIC.PROD_BU              AS PROD_BU,
  ITEM_BASIC.MATL_TYPE            AS MATL_TYPE,
  ITEM_BASIC.STRATEGY_GRP         AS STRATEGY_GRP,
  ITEM_BASIC.SAFETY_STOCK         AS SAFETY_STOCK,
  INV_BASIC.TOTAL_QTY             AS TOTAL_QTY,
  INV_BASIC.LOCATIONID              AS LOCATION
FROM
  (SELECT MATERIALID
    ||'_'
    ||PLANTID     AS ID,
    MATERIALID    AS MATERIAL,
    PLANTID       AS PLANT,
    LOCATIONID    AS LOCATIONID,
    NVL(OH_QTY,0) AS TOTAL_QTY,
    ASOFDATE      AS LAST_REVIEW_DATE
  FROM INV_SAP_INVENTORY_BY_PLANT
  )INV_BASIC
LEFT JOIN
  (SELECT ID,
    CATALOG_DASH,
    MAT_DESC,
    SAFETY_STOCK,
    UNIT,
    STRATEGY_GRP,
    PROD_BU,
    MATL_TYPE
  FROM VIEW_INV_SAP_PP_OPT_X
  )ITEM_BASIC
ON ITEM_BASIC.ID = INV_BASIC.ID;











---------------------------------------------------------------------------
--Backlog report sql file
---SO detail information
---PO detail information
---PR detail information
---INV detail information
---------------------------------------------------------------------------

----SO detail information
----Need to add ship-to information and Customer Name
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_SHIP_SOLD_TO_PARTYID ;

Select * from DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP where SALESDOC = '6501808127'; 
Select * from DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP where LINECREATEDATE = '15-APR-14' and plant = '1090'; 
Select * from DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP where MATERIAL = '1756-N2 B' and plant = '5050';


SELECT * FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP WHERE SALES_ORG = '5003'AND PLANT NOT IN ('5040');
----Ship-To&Sold-To Info
-----Sold-To Party
select * from DWQ$LIBRARIAN.INV_SAP_SHIP_SOLD_TO_PARTYID where SHIP_SOLD_TOPARTY = '91312213';

-----Ship-To Party
select * from DWQ$LIBRARIAN.INV_SAP_SHIP_SOLD_TO_PARTYID where SHIP_SOLD_TOPARTY = '91316290';

---------------------------------------------
---ADD GAP COL COMMITTED DATE - COMFIRM DATE
SELECT
  (MAX_COMMIT_DATE-MAX_CONFIRM_DATE) AS GAP
FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP;

--LINE BLOCK
SELECT
  CASE
    WHEN MAX_COMMIT_DATE IS NULL OR MAX_CONFIRM_DATE IS NULL
    THEN 'OVERALL BLOCKED/CREDIT BLOCK'
    ELSE
    'NO_BLOCK'
  END LINE_BLOCK
FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP;

---SOLD TO PATY INFORMAITON
SELECT STPT_S.ID,
STPT_S.SOLD_TO_PARTY,
STPT_P.CUSTOMER_NAME
FROM
  (SELECT SALESDOC
    ||'_'
    || SALESDOCITEM AS ID,
    SOLD_TO         AS SOLD_TO_PARTY
  FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
  )STPT_S
LEFT JOIN
  (SELECT SHIP_SOLD_TOPARTY AS SOLD_TO_PARTY,
    SHIP_TO_PARTY_NAME      AS CUSTOMER_NAME
  FROM DWQ$LIBRARIAN.INV_SAP_SHIP_SOLD_TO_PARTYID
  ) STPT_P
ON STPT_P.SOLD_TO_PARTY = STPT_S.SOLD_TO_PARTY;

--DEFAULT Delivery Block
SELECT 
  SALE_BK.ID AS ID,
  SALE_BK.MATERIAL AS MATERIAL,
  MVKE_BK.D_CHAIN_BLK AS D_CHAIN_BLK
FROM 
(
  SELECT 
    SALESDOC
    ||'_'
    || SALESDOCITEM AS ID,
    MATERIAL
    ||'_'
    || PLANT AS ID1,
    MATERIAL,
    PLANT
  FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
)SALE_BK
LEFT JOIN
(
SELECT MATERIALID
  ||'_'
  ||DIRECT_SHIP_PLANT AS ID,
  MATERIALID,
  D_CHAIN_BLK,
  DIRECT_SHIP_PLANT
FROM DWQ$LIBRARIAN.INV_SAP_PP_MVKE
)MVKE_BK
ON MVKE_BK.ID = SALE_BK.ID1;

