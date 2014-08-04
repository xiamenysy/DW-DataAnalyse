--Porject Name: Automation Files Center
--Author: Huang Moyue 
--Mail: mhuang1@ra.rockwell.com
--Date:07/08/2014
--Summary: Automation Files Center Job Logs and set up process
--Version: 0.5


4. Automate Reports
	4.1 AUS REPORTS
	4.1.1 
		--5140 INV CLS REPORT
		--AUTHOR: HUANG MO YUE
		--DATE:7/2/2014
		DROP VIEW VIEW_SAP_INV_CLS_AUSRE;
		SELECT * FROM VIEW_SAP_INV_CLS_AUSRE;
		CREATE VIEW VIEW_SAP_INV_CLS_AUSRE AS
		SELECT PLANT AS PLANT,
		  MATERIAL AS MATERIAL,
		  CATALOG_DASH AS CATALOG,
		  MAT_DESC AS MAT_DESC,
		  PROD_BU AS PRODUCT_GRP,
		  STRATEGY_GRP AS STRATEGY_GRP,
		  SAFETY_STOCK AS SAFETY_STOCK,
		  UNIT AS UNIT,
		  LEAD_TIME AS LEAD_TIME,
		  PROC_TYPE AS PROC_TYPE,
		  PLANT_SP_MATL_STA AS Material_Status,
		  ISSUE_UOM_NUMERATOR AS Delivery_Unit
		FROM VIEW_INV_SAP_PP_OPT_X
		WHERE PLANT IN ('5140','5150');
		
		
  4.2 
    --Stock Item Performance
    --Author: Huang Moyue
    --Date:5/28/2014
    4.2.1.Setup data
    ---Upload History Data
      truncate TABLE STOCK_ITEM_STATUS_BY_BU_WEEK;
      SELECT * FROM STOCK_ITEM_STATUS_BY_BU_WEEK where id = '09-JUN-14_5140_ICM-INTGR COND MONITOR';
      SELECT count(*) FROM STOCK_ITEM_STATUS_BY_BU_WEEK;
      
      truncate TABLE STOCK_ITEM_STATUS_BY_ITEM;
      SELECT * FROM STOCK_ITEM_STATUS_BY_ITEM where id = '07-JUL-14_5140_LGC-IEC LOGIC COMPONENTS_700-HLT12Z24 A';
      SELECT count(*) FROM STOCK_ITEM_STATUS_BY_ITEM;
		
		

  4.3 
      --Backlog Report
      --Author: Huang Moyue
      --Date: 7/15/2014
      4.3.1 Open Sales Order
      --SO BASIC     
      --VIEW_INV_SAP_BACKLOG_SO
      DROP TABLE INV_SAP_BACKLOG_SO;
      CREATE TABLE INV_SAP_BACKLOG_SO AS SELECT * FROM VIEW_INV_SAP_BACKLOG_SO;
      DROP VIEW VIEW_INV_SAP_BACKLOG_SO;
      CREATE VIEW VIEW_INV_SAP_BACKLOG_SO AS 
      SELECT SOPH_TO.SO_ID               AS SO_ID,
        SOPH_TO.ID                       AS ID,
        SOPH_TO.PROC_TYPE                AS PROC_TYPE,
        SOPH_TO.PLANT                    AS PLANT,
        SOPH_TO.SALES_ORG                AS SALES_ORG,
        SOPH_TO.SHIPPING_POINT           AS SHIPPING_POINT,
        SOPH_TO.SALE_DOC_TYPE            AS SALE_DOC_TYPE,
        SOPH_TO.SALES_DOC                AS SALES_DOC,
        SOPH_TO.DOC_ITEM                 AS DOC_ITEM,
        SOPH_TO.MATERIAL                 AS MATERIAL,
        SOPH_TO.CATALOG_DASH             AS CATALOG_DASH,
        SOPH_TO.MAT_DESC                 AS MAT_DESC,
        SOPH_TO.MATL_TYPE                AS MATL_TYPE,
        SOPH_TO.SAFETY_STOCK             AS SAFETY_STOCK,
        SOPH_TO.STRATEGY_GRP             AS STRATEGY_GRP,
        SOPH_TO.LEAD_TIME                AS LEAD_TIME,
        SOPH_TO.BU                       AS BU,
        SOPH_TO.LINE_CREATED_DATE        AS LINE_CREATED_DATE,
        SOPH_TO.REQUIRE_DATE             AS REQUIRE_DATE,
        SOPH_TO.COMMITTED_DATE           AS COMMITTED_DATE,
        SOPH_TO.CONFIRM_DATE             AS CONFIRM_DATE,
        0                                AS GAP,
        SOPH_TO.LST_ACT_GI_DATE          AS LST_ACT_GI_DATE,
        SOPH_TO.LST_DELIVERY_CREATE_DATE AS LST_DELIVERY_CREATE_DATE,
        SOPH_TO.ORDER_QTY                AS ORDER_QTY,
        SOPH_TO.OPEN_QTY                 AS OPEN_QTY,
        SOPH_TO.SHIPPED_QTY              AS SHIPPED_QTY,
        SOPH_TO.UNIT                     AS UNIT,
        SOPH_TO.PROFIT_CENTER            AS PROFIT_CENTER,
        (SOPH_TO.SALES_PRICE/SOPH_TO.ORDER_QTY) AS NET_PRICE,
        SOPH_TO.SALES_PRICE              AS SALES_PRICE,
        (SOPH_TO.SALES_PRICE/SOPH_TO.ORDER_QTY)*(SOPH_TO.OPEN_QTY) AS OPEN_VALUE,
        SOPH_TO.UNIT_COST                AS UNIT_COST,
        SOPH_TO.CURRENCY                 AS CURRENCY,
        SOPH_TO.SOLD_TO_PARTY            AS SOLD_TO_PARTY,
        SOPH_TO.SHIP_SOLD_TO_PARTY_NAME  AS SHIP_SOLD_TO_PARTY_NAME,
        SOPH_TO.SHIP_TO_PARTY            AS SHIP_TO_PARTY,
        SO_SHIP.SHIP_TO_NAME             AS SHIP_TO_NAME,
        SOPH_TO.ROUTE                    AS ROUTE,
        SOPH_TO.DELIVERY_PRIORITY        AS DELIVERY_PRIORITY,
        SOPH_TO.MRP_CONTROLLER           AS MRP_CONTROLLER,
        SOPH_TO.PURCH_GROUP              AS PURCH_GROUP,
        SOPH_TO.MRP_TYPE                 AS MRP_TYPE,
        SOPH_TO.DELIVERY_STATUS          AS DELIVERY_STATUS,
        SOPH_TO.OVER_ALL_DELIVERY_STATUS AS OVER_ALL_DELIVERY_STATUS,
        SOPH_TO.VENDOR_KEY               AS VENDOR_KEY,
        SOPH_TO.STOCK_STATUS             AS STOCK_STATUS,
        SOPH_TO.REQTYPE                  AS REQTYPE,
        SOPH_TO.EXCHANGE_RATE_TO_USD     AS EXCHANGE_RATE_TO_USD
      FROM
        (SELECT SO_PH.SO_ID              AS SO_ID,
          SO_PH.ID                       AS ID,
          SO_PH.PROC_TYPE                AS PROC_TYPE,
          SO_PH.PLANT                    AS PLANT,
          SO_PH.SALES_ORG                AS SALES_ORG,
          SO_PH.SHIPPING_POINT           AS SHIPPING_POINT,
          SO_PH.SALE_DOC_TYPE            AS SALE_DOC_TYPE,
          SO_PH.SALES_DOC                AS SALES_DOC,
          SO_PH.DOC_ITEM                 AS DOC_ITEM,
          SO_PH.MATERIAL                 AS MATERIAL,
          SO_PH.CATALOG_DASH             AS CATALOG_DASH,
          SO_PH.MAT_DESC                 AS MAT_DESC,
          SO_PH.MATL_TYPE                AS MATL_TYPE,
          SO_PH.SAFETY_STOCK             AS SAFETY_STOCK,
          SO_PH.STRATEGY_GRP             AS STRATEGY_GRP,
          SO_PH.LEAD_TIME                AS LEAD_TIME,
          SO_PH.BU                       AS BU,
          SO_PH.LINE_CREATED_DATE        AS LINE_CREATED_DATE,
          SO_PH.REQUIRE_DATE             AS REQUIRE_DATE,
          SO_PH.COMMITTED_DATE           AS COMMITTED_DATE,
          SO_PH.CONFIRM_DATE             AS CONFIRM_DATE,
          SO_PH.LST_ACT_GI_DATE          AS LST_ACT_GI_DATE,
          SO_PH.LST_DELIVERY_CREATE_DATE AS LST_DELIVERY_CREATE_DATE,
          SO_PH.ORDER_QTY                AS ORDER_QTY,
          SO_PH.OPEN_QTY                 AS OPEN_QTY,
          SO_PH.SHIPPED_QTY              AS SHIPPED_QTY,
          SO_PH.UNIT                     AS UNIT,
          SO_PH.PROFIT_CENTER            AS PROFIT_CENTER,
          SO_PH.SALES_PRICE              AS SALES_PRICE,
          SO_PH.UNIT_COST                AS UNIT_COST,
          SO_PH.CURRENCY                 AS CURRENCY,
          SO_PH.SOLD_TO_PARTY            AS SOLD_TO_PARTY,
          SO_PH.SHIP_SOLD_TO_PARTY_NAME  AS SHIP_SOLD_TO_PARTY_NAME,
          SHIP_TO.SHIP_TO_PARTY          AS SHIP_TO_PARTY,
          SO_PH.ROUTE                    AS ROUTE,
          SO_PH.DELIVERY_PRIORITY        AS DELIVERY_PRIORITY,
          SO_PH.MRP_CONTROLLER           AS MRP_CONTROLLER,
          SO_PH.PURCH_GROUP              AS PURCH_GROUP,
          SO_PH.MRP_TYPE                 AS MRP_TYPE,
          SO_PH.DELIVERY_STATUS          AS DELIVERY_STATUS,
          SO_PH.OVER_ALL_DELIVERY_STATUS AS OVER_ALL_DELIVERY_STATUS,
          SO_PH.VENDOR_KEY               AS VENDOR_KEY,
          SO_PH.STOCK_STATUS             AS STOCK_STATUS,
          SO_PH.REQTYPE                  AS REQTYPE,
          SO_PH.EXCHANGE_RATE_TO_USD     AS EXCHANGE_RATE_TO_USD
        FROM
          (SELECT SO_PP_BS.SO_ID              AS SO_ID,
            SO_PP_BS.ID                       AS ID,
            SO_PP_BS.PROC_TYPE                AS PROC_TYPE,
            SO_PP_BS.PLANT                    AS PLANT,
            SO_PP_BS.SALES_ORG                AS SALES_ORG,
            SO_PP_BS.SHIPPING_POINT           AS SHIPPING_POINT,
            SO_PP_BS.SALE_DOC_TYPE            AS SALE_DOC_TYPE,
            SO_PP_BS.SALES_DOC                AS SALES_DOC,
            SO_PP_BS.DOC_ITEM                 AS DOC_ITEM,
            SO_PP_BS.MATERIAL                 AS MATERIAL,
            SO_PP_BS.CATALOG_DASH             AS CATALOG_DASH,
            SO_PP_BS.MAT_DESC                 AS MAT_DESC,
            SO_PP_BS.MATL_TYPE                AS MATL_TYPE,
            SO_PP_BS.SAFETY_STOCK             AS SAFETY_STOCK,
            SO_PP_BS.STRATEGY_GRP             AS STRATEGY_GRP,
            SO_PP_BS.LEAD_TIME                AS LEAD_TIME,
            SO_PP_BS.BU                       AS BU,
            SO_PP_BS.LINE_CREATED_DATE        AS LINE_CREATED_DATE,
            SO_PP_BS.REQUIRE_DATE             AS REQUIRE_DATE,
            SO_PP_BS.COMMITTED_DATE           AS COMMITTED_DATE,
            SO_PP_BS.CONFIRM_DATE             AS CONFIRM_DATE,
            SO_PP_BS.LST_ACT_GI_DATE          AS LST_ACT_GI_DATE,
            SO_PP_BS.LST_DELIVERY_CREATE_DATE AS LST_DELIVERY_CREATE_DATE,
            SO_PP_BS.ORDER_QTY                AS ORDER_QTY,
            SO_PP_BS.OPEN_QTY                 AS OPEN_QTY,
            SO_PP_BS.SHIPPED_QTY              AS SHIPPED_QTY,
            SO_PP_BS.UNIT                     AS UNIT,
            SO_PP_BS.PROFIT_CENTER            AS PROFIT_CENTER,
            SO_PP_BS.SALES_PRICE              AS SALES_PRICE,
            SO_PP_BS.UNIT_COST                AS UNIT_COST,
            SO_PP_BS.CURRENCY                 AS CURRENCY,
            SO_PP_BS.SOLD_TO_PARTY            AS SOLD_TO_PARTY,
            SOLD_SHIP.SHIP_SOLD_TO_PARTY_NAME AS SHIP_SOLD_TO_PARTY_NAME,
            SO_PP_BS.ROUTE                    AS ROUTE,
            SO_PP_BS.DELIVERY_PRIORITY        AS DELIVERY_PRIORITY,
            SO_PP_BS.MRP_CONTROLLER           AS MRP_CONTROLLER,
            SO_PP_BS.PURCH_GROUP              AS PURCH_GROUP,
            SO_PP_BS.MRP_TYPE                 AS MRP_TYPE,
            SO_PP_BS.DELIVERY_STATUS          AS DELIVERY_STATUS,
            SO_PP_BS.OVER_ALL_DELIVERY_STATUS AS OVER_ALL_DELIVERY_STATUS,
            SO_PP_BS.VENDOR_KEY               AS VENDOR_KEY,
            SO_PP_BS.STOCK_STATUS             AS STOCK_STATUS,
            SO_PP_BS.REQTYPE                  AS REQTYPE,
            SO_PP_BS.EXCHANGE_RATE_TO_USD     AS EXCHANGE_RATE_TO_USD
          FROM
            (SELECT OPEN_SO_BASIC.SO_ID                          AS SO_ID,
              OPEN_SO_BASIC.ID                                   AS ID,
              SALES_PP_X.PROC_TYPE                               AS PROC_TYPE,
              OPEN_SO_BASIC.PLANT                                AS PLANT,
              OPEN_SO_BASIC.SALES_ORG                            AS SALES_ORG,
              OPEN_SO_BASIC.SHIPPING_POINT                       AS SHIPPING_POINT,
              OPEN_SO_BASIC.SALE_DOC_TYPE                        AS SALE_DOC_TYPE,
              OPEN_SO_BASIC.SALES_DOC                            AS SALES_DOC,
              OPEN_SO_BASIC.DOC_ITEM                             AS DOC_ITEM,
              OPEN_SO_BASIC.MATERIAL                             AS MATERIAL,
              SALES_PP_X.CATALOG_DASH                            AS CATALOG_DASH,
              SALES_PP_X.MAT_DESC                                AS MAT_DESC,
              SALES_PP_X.MATL_TYPE                               AS MATL_TYPE,
              SALES_PP_X.SAFETY_STOCK                            AS SAFETY_STOCK,
              SALES_PP_X.STRATEGY_GRP                            AS STRATEGY_GRP,
              SALES_PP_X.LEAD_TIME                               AS LEAD_TIME,
              OPEN_SO_BASIC.BU                                   AS BU,
              OPEN_SO_BASIC.LINE_CREATED_DATE                    AS LINE_CREATED_DATE,
              OPEN_SO_BASIC.REQUIRE_DATE                         AS REQUIRE_DATE,
              OPEN_SO_BASIC.COMMITTED_DATE                       AS COMMITTED_DATE,
              OPEN_SO_BASIC.CONFIRM_DATE                         AS CONFIRM_DATE,
              OPEN_SO_BASIC.LST_ACT_GI_DATE                      AS LST_ACT_GI_DATE,
              OPEN_SO_BASIC.LST_DELIVERY_CREATE_DATE             AS LST_DELIVERY_CREATE_DATE,
              OPEN_SO_BASIC.ORDER_QTY                            AS ORDER_QTY,
              OPEN_SO_BASIC.OPEN_QTY                             AS OPEN_QTY,
              (OPEN_SO_BASIC.ORDER_QTY - OPEN_SO_BASIC.OPEN_QTY) AS SHIPPED_QTY,
              SALES_PP_X.UNIT                                    AS UNIT,
              OPEN_SO_BASIC.PROFIT_CENTER                        AS PROFIT_CENTER,
              OPEN_SO_BASIC.SALES_PRICE                          AS SALES_PRICE,
              SALES_PP_X.UNIT_COST                               AS UNIT_COST,
              OPEN_SO_BASIC.CURRENCY                             AS CURRENCY,
              LPAD(OPEN_SO_BASIC.SOLD_TO_PARTY,10,'0')           AS SOLD_TO_PARTY,
              OPEN_SO_BASIC.ROUTE                                AS ROUTE,
              OPEN_SO_BASIC.DELIVERY_PRIORITY                    AS DELIVERY_PRIORITY,
              SALES_PP_X.MRP_CONTROLLER                          AS MRP_CONTROLLER,
              SALES_PP_X.PURCH_GROUP                             AS PURCH_GROUP,
              SALES_PP_X.MRP_TYPE                                AS MRP_TYPE,
              OPEN_SO_BASIC.DELIVERY_STATUS                      AS DELIVERY_STATUS,
              OPEN_SO_BASIC.OVER_ALL_DELIVERY_STATUS             AS OVER_ALL_DELIVERY_STATUS,
              SALES_PP_X.VENDOR_KEY                              AS VENDOR_KEY,
              OPEN_SO_BASIC.STOCK_STATUS                         AS STOCK_STATUS,
              OPEN_SO_BASIC.REQTYPE                              AS REQTYPE,
              OPEN_SO_BASIC.EXCHANGE_RATE_TO_USD                 AS EXCHANGE_RATE_TO_USD
            FROM
              (SELECT SALESDOC
                ||'_'
                || SALESDOCITEM AS SO_ID,
                MATERIAL
                ||'_'
                || PLANT              AS ID,
                SALESDOC              AS SALES_DOC,
                SALESDOCITEM          AS DOC_ITEM,
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
                REQTYPE               AS REQTYPE,
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
                UNIT_COST,
                MRP_CONTROLLER,
                PURCH_GROUP,
                LEAD_TIME,
                MATL_TYPE
              FROM INV_SAP_PP_OPT_X --WHERE ID = 'ESB-SIRC-JQD_5040'
              )SALES_PP_X
            ON SALES_PP_X.ID = OPEN_SO_BASIC.ID
            )SO_PP_BS
          LEFT JOIN
            (SELECT LPAD(SHIP_SOLD_TO_PARTY,10,'0') AS SHIP_SOLD_TO_PARTY,
              SHIP_SOLD_TO_PARTY_NAME
            FROM INV_SAP_SHIP_SOLD_TO
            )SOLD_SHIP
          ON SOLD_SHIP.SHIP_SOLD_TO_PARTY = SO_PP_BS.SOLD_TO_PARTY
          )SO_PH
        LEFT JOIN
          ( SELECT DISTINCT SALESDOC,
            LPAD(SHIPTOPARTY,10,'0') AS SHIP_TO_PARTY
          FROM INV_SAP_SALES_HST
          )SHIP_TO
        ON SHIP_TO.SALESDOC = SO_PH.SALES_DOC
        )SOPH_TO
      LEFT JOIN
        (SELECT DISTINCT LPAD(SHIP_SOLD_TO_PARTY,10,'0') AS SHIP_SOLD_TO_PARTY,
          SHIP_SOLD_TO_PARTY_NAME                        AS SHIP_TO_NAME
        FROM INV_SAP_SHIP_SOLD_TO
        )SO_SHIP
      ON SO_SHIP.SHIP_SOLD_TO_PARTY = SOPH_TO.SHIP_TO_PARTY;
      --Testing
      
      SELECT ID,
        PROC_TYPE,
        PLANT,
        SALES_ORG,
        SHIPPING_POINT,
        SALE_DOC_TYPE,
        SALES_DOC,
        DOC_ITEM,
        MATERIAL,
        CATALOG_DASH,
        MAT_DESC,
        MATL_TYPE,
        SAFETY_STOCK,
        STRATEGY_GRP,
        LEAD_TIME,
        BU,
        LINE_CREATED_DATE,
        REQUIRE_DATE,
        COMMITTED_DATE,
        CONFIRM_DATE,
        GAP,
        LST_ACT_GI_DATE,
        LST_DELIVERY_CREATE_DATE,
        ORDER_QTY,
        OPEN_QTY,
        SHIPPED_QTY,
        UNIT,
        NET_PRICE,
        SALES_PRICE,
        OPEN_VALUE,
        CURRENCY,
        UNIT_COST,
        ROUTE,
        DELIVERY_PRIORITY,
        SOLD_TO_PARTY,
        SHIP_SOLD_TO_PARTY_NAME,
        SHIP_TO_PARTY,
        SHIP_TO_NAME,
        MRP_CONTROLLER,
        PURCH_GROUP,
        MRP_TYPE,
        DELIVERY_STATUS,
        OVER_ALL_DELIVERY_STATUS,
        VENDOR_KEY,
        STOCK_STATUS,
        REQTYPE,
        PROFIT_CENTER,
        EXCHANGE_RATE_TO_USD
      FROM VIEW_INV_SAP_BACKLOG_SO
      WHERE SALES_ORG IN ('5003','5007','5000');
    

      4.3.2 Stock status
      --VIEW_INV_SAP_BACKLOG_INV
      DROP VIEW VIEW_INV_SAP_BACKLOG_INV;
      DROP TABLE INV_SAP_BACKLOG_INV;
      CREATE TABLE INV_SAP_BACKLOG_INV AS SELECT * FROM VIEW_INV_SAP_BACKLOG_INV;
      CREATE VIEW VIEW_INV_SAP_BACKLOG_INV AS
      SELECT INV_BASIC.ID                                        AS ID,
        INV_BASIC.PLANT                                          AS PLANT,
        INV_BASIC.MATERIAL                                       AS MATERIAL,
        ITEM_BASIC.CATALOG_DASH                                  AS CATALOG_DASH,
        ITEM_BASIC.PROD_BU                                       AS PROD_BU,
        ITEM_BASIC.MATL_TYPE                                     AS MATL_TYPE,
        ITEM_BASIC.STRATEGY_GRP                                  AS STRATEGY_GRP,
        ITEM_BASIC.SAFETY_STOCK                                  AS SAFETY_STOCK,
        NVL(ITEM_BASIC.UNIT_COST,0)                              AS UNIT_COST,
        NVL(ITEM_BASIC.MIN_INV,0)                                AS MIN_INV,
        NVL(ITEM_BASIC.TARGET_INV,0)                             AS TARGET_INV,
        NVL(ITEM_BASIC.MAX_INV,0)                                AS MAX_INV,
        NVL(INV_BASIC.TOTAL_QTY,0)                               AS TOTAL_QTY,
        (NVL(ITEM_BASIC.MIN_INV,0)   *NVL(ITEM_BASIC.UNIT_COST,0)) AS MIN_INV_V,
        (NVL(ITEM_BASIC.TARGET_INV,0)*NVL(ITEM_BASIC.UNIT_COST,0)) AS TARGET_INV_V,
        (NVL(ITEM_BASIC.MAX_INV,0)   *NVL(ITEM_BASIC.UNIT_COST,0)) AS MAX_INV_V,
        (NVL(INV_BASIC.TOTAL_QTY,0)  *NVL(ITEM_BASIC.UNIT_COST,0)) AS TOTAL_V,
        (NVL(INV_BASIC.TOTAL_QTY,0)  *NVL(ITEM_BASIC.UNIT_COST,0) - NVL(ITEM_BASIC.MAX_INV,0)   *NVL(ITEM_BASIC.UNIT_COST,0)) AS OVER_MAX_V,
        INV_BASIC.LOCATIONID                                       AS LOCATION
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
          CEIL(NVL(UNIT_COST,0)) AS UNIT_COST,
          MIN_INV,
          TARGET_INV,
          MAX_INV,
          MATL_TYPE
        FROM INV_SAP_PP_OPT_X
        )ITEM_BASIC
      ON ITEM_BASIC.ID = INV_BASIC.ID;
      
      4.3.3 Open PO
      --VIEW_INV_SAP_OPEN_PO
      DROP VIEW VIEW_INV_SAP_BACKLOG_PO;
      SELECT * FROM VIEW_INV_SAP_BACKLOG_PO WHERE PLANT IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140') AND ID = 'PN-C75741_5200';
     
      CREATE VIEW VIEW_INV_SAP_BACKLOG_PO AS
      SELECT PO_HIS_LN_OP_ST.ID                     AS ID,
        PO_HIS_LN_OP_ST.PURCHDOCCAT                 AS PROCUREMENT_TYPE,
        PO_HIS_LN_OP_ST.PLANT                       AS PLANT,
        PO_HIS_LN_OP_ST.PO                          AS PO,
        PO_HIS_LN_OP_ST.ITEM                        AS ITEM,
        PO_HIS_LN_OP_ST.MATERIAL                    AS MATERIAL,
        ITEM_BASIC.CATALOG_DASH                     AS CATALOG_DASH,
        ITEM_BASIC.MAT_DESC                         AS MAT_DESC,
        ITEM_BASIC.PROD_BU                          AS PROD_BU,
        PO_HIS_LN_OP_ST.STRATEGY_GRP                AS STRATEGY_GRP,
        ITEM_BASIC.MATL_TYPE                        AS MATL_TYPE,
        ITEM_BASIC.MRP_TYPE                         AS MRP_TYPE,
        PO_HIS_LN_OP_ST.MRP_CONTROLLER              AS MRP_CONTROLLER,
        PO_HIS_LN_OP_ST.PURCH_GROUP                 AS PURCH_GROUP,
        PO_HIS_LN_OP_ST.PURCHDOC_TYPE               AS PURCHDOC_TYPE,
        PO_HIS_LN_OP_ST.VENDOR                      AS VENDOR,
        PO_HIS_LN_OP_ST.PO_SO_SA_FLAG               AS FLAG,
        PO_HIS_LN_OP_ST.CREATED_DATE                AS CREATED_DATE,
        PO_HIS_LN_OP_ST.COMMITTED_DATE              AS MAX_COMMITTED_DATE,
        NVL(PO_HIS_LN_OP_ST.PURHCASE_QTY,0)         AS PURHCASE_QTY,
        NVL(PO_HIS_LN_OP_ST.PO_OPEN_QTY,0)          AS PO_OPEN_QTY,
        NVL(PO_HIS_LN_OP_ST.PO_OPEN_LINE_QTY,0)     AS PO_OPEN_LINE_COUNT,
        NVL(PO_HIS_LN_OP_ST.TRANSIT_DAYS,0)         AS TRANSIT_DAYS,
        NVL(PO_HIS_LN_OP_ST.STOCK_IN_TRANSIT_QTY,0) AS STOCK_IN_TRANSIT_QTY,
        NVL(PO_HIS_LN_OP_ST.UNIT_COST,0)            AS UNIT_COST,
        NVL(PO_HIS_LN_OP_ST.ORDER_VALUE,0)          AS ORDER_VALUE,
        PO_HIS_LN_OP_ST.CURRENCY                    AS CURRENCY,
        NVL(PO_HIS_LN_OP_ST.LEAD_TIME,0)            AS LEAD_TIME,
        NVL(PO_HIS_LN_OP_ST.GRT,0)                  AS GRT,
        PO_HIS_LN_OP_ST.PROC_KEY                    AS PROC_KEY,
        PO_HIS_LN_OP_ST.SHIPPING_POINT              AS SHIPPING_POINT,
        NVL(PO_HIS_LN_OP_ST.DELIVERY_PRIORITY,0)    AS DELIVERY_PRIORITY,
        PO_HIS_LN_OP_ST.ROUTE                       AS ROUTE,
        NVL(PO_HIS_LN_OP_ST.PR,0)                   AS PR
      FROM
        (SELECT PO_HIS_LN_OP.PO_ID              AS PO_ID,
          PO_HIS_LN_OP.ID                       AS ID,
          PO_HIS_LN_OP.PO                       AS PO,
          PO_HIS_LN_OP.ITEM                     AS ITEM,
          PO_HIS_LN_OP.MATERIAL                 AS MATERIAL,
          PO_HIS_LN_OP.PLANT                    AS PLANT,
          PO_HIS_LN_OP.PURCHDOCCAT              AS PURCHDOCCAT,
          PO_HIS_LN_OP.PURCHDOC_TYPE            AS PURCHDOC_TYPE,
          PO_HIS_LN_OP.VENDOR                   AS VENDOR,
          PO_HIS_LN_OP.PURHCASE_QTY             AS PURHCASE_QTY,
          PO_HIS_LN_OP.COMMITTED_DATE           AS COMMITTED_DATE,
          PO_HIS_LN_OP.PO_SO_SA_FLAG            AS PO_SO_SA_FLAG,
          PO_HIS_LN_OP.CREATED_DATE             AS CREATED_DATE,
          PO_HIS_LN_OP.CURRENCY                 AS CURRENCY,
          PO_HIS_LN_OP.ORDER_VALUE              AS ORDER_VALUE,
          PO_HIS_LN_OP.LEAD_TIME                AS LEAD_TIME,
          PO_HIS_LN_OP.GRT                      AS GRT,
          PO_HIS_LN_OP.MRP_CONTROLLER           AS MRP_CONTROLLER,
          PO_HIS_LN_OP.PROC_KEY                 AS PROC_KEY,
          PO_HIS_LN_OP.PURCH_GROUP              AS PURCH_GROUP,
          PO_HIS_LN_OP.STRATEGY_GRP             AS STRATEGY_GRP,
          PO_HIS_LN_OP.UNIT_COST                AS UNIT_COST,
          PO_HIS_LN_OP.PR                       AS PR,
          PO_HIS_LN_OP.SHIPPING_POINT           AS SHIPPING_POINT,
          PO_HIS_LN_OP.DELIVERY_PRIORITY        AS DELIVERY_PRIORITY,
          PO_HIS_LN_OP.ROUTE                    AS ROUTE,
          PO_HIS_LN_OP.TRANSIT_DAYS             AS TRANSIT_DAYS,
          PO_HIS_LN_OP.PO_OPEN_LINE_QTY         AS PO_OPEN_LINE_QTY,
          PO_HIS_LN_OP.PO_OPEN_QTY              AS PO_OPEN_QTY,
          STOCK_IN_TRAINST.STOCK_IN_TRANSIT_QTY AS STOCK_IN_TRANSIT_QTY
        FROM
          (SELECT PO_HIS_LN.PO_ID       AS PO_ID,
            PO_HIS_LN.ID                AS ID,
            PO_HIS_LN.PO                AS PO,
            PO_HIS_LN.ITEM              AS ITEM,
            PO_HIS_LN.MATERIAL          AS MATERIAL,
            PO_HIS_LN.PLANT             AS PLANT,
            PO_HIS_LN.PURCHDOCCAT       AS PURCHDOCCAT,
            PO_HIS_LN.PURCHDOC_TYPE     AS PURCHDOC_TYPE,
            PO_HIS_LN.VENDOR            AS VENDOR,
            PO_HIS_LN.PURHCASE_QTY      AS PURHCASE_QTY,
            PO_HIS_LN.COMMITTED_DATE    AS COMMITTED_DATE,
            PO_HIS_LN.PO_SO_SA_FLAG     AS PO_SO_SA_FLAG,
            PO_HIS_LN.CREATED_DATE      AS CREATED_DATE,
            PO_HIS_LN.CURRENCY          AS CURRENCY,
            PO_HIS_LN.ORDER_VALUE       AS ORDER_VALUE,
            PO_HIS_LN.LEAD_TIME         AS LEAD_TIME,
            PO_HIS_LN.GRT               AS GRT,
            PO_HIS_LN.MRP_CONTROLLER    AS MRP_CONTROLLER,
            PO_HIS_LN.PROC_KEY          AS PROC_KEY,
            PO_HIS_LN.PURCH_GROUP       AS PURCH_GROUP,
            PO_HIS_LN.STRATEGY_GRP      AS STRATEGY_GRP,
            PO_HIS_LN.UNIT_COST         AS UNIT_COST,
            PO_HIS_LN.PR                AS PR,
            PO_HIS_LN.SHIPPING_POINT    AS SHIPPING_POINT,
            PO_HIS_LN.DELIVERY_PRIORITY AS DELIVERY_PRIORITY,
            PO_HIS_LN.ROUTE             AS ROUTE,
            PO_HIS_LN.TRANSIT_DAYS      AS TRANSIT_DAYS,
            PO_HIS_LN.PO_OPEN_LINE_QTY  AS PO_OPEN_LINE_QTY,
            PO_OPEN_Q.OPEN_QTY          AS PO_OPEN_QTY
          FROM
            (SELECT PO_HIS.PO_ID       AS PO_ID,
              PO_HIS.ID                AS ID,
              PO_HIS.PO                AS PO,
              PO_HIS.ITEM              AS ITEM,
              PO_HIS.MATERIAL          AS MATERIAL,
              PO_HIS.PLANT             AS PLANT,
              PO_HIS.PURCHDOCCAT       AS PURCHDOCCAT,
              PO_HIS.PURCHDOC_TYPE     AS PURCHDOC_TYPE,
              PO_HIS.VENDOR            AS VENDOR,
              PO_HIS.PURHCASE_QTY      AS PURHCASE_QTY,
              PO_HIS.COMMITTED_DATE    AS COMMITTED_DATE,
              PO_HIS.PO_SO_SA_FLAG     AS PO_SO_SA_FLAG,
              PO_HIS.CREATED_DATE      AS CREATED_DATE,
              PO_HIS.CURRENCY          AS CURRENCY,
              PO_HIS.ORDER_VALUE       AS ORDER_VALUE,
              PO_HIS.LEAD_TIME         AS LEAD_TIME,
              PO_HIS.GRT               AS GRT,
              PO_HIS.MRP_CONTROLLER    AS MRP_CONTROLLER,
              PO_HIS.PROC_KEY          AS PROC_KEY,
              PO_HIS.PURCH_GROUP       AS PURCH_GROUP,
              PO_HIS.STRATEGY_GRP      AS STRATEGY_GRP,
              PO_HIS.UNIT_COST         AS UNIT_COST,
              PO_HIS.PR                AS PR,
              PO_HIS.SHIPPING_POINT    AS SHIPPING_POINT,
              PO_HIS.DELIVERY_PRIORITY AS DELIVERY_PRIORITY,
              PO_HIS.ROUTE             AS ROUTE,
              PO_HIS.TRANSIT_DAYS      AS TRANSIT_DAYS,
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
                ||PLANTID                  AS ID,
                MATERIALID                 AS MATERIAL,
                PLANTID                    AS PLANT,
                BSTYP_PURCHDOCCAT          AS PURCHDOCCAT,
                BSART_PURCHDOCTYPE         AS PURCHDOC_TYPE,
                LIFNR_VENDORNO             AS VENDOR,
                EBELNPURCHDOCNO            AS PO,
                EBELPPURCHITEMNO           AS ITEM,
                MENGESCHEDULEDQTY          AS PURHCASE_QTY,
                WEMNGRECEIVEDQTY           AS RECEIVED_QTY,
                DELIVERYCOMPLETE           AS DELIVERY_COMPLETE_FLAG,
                COMMITTED_DATE             AS COMMITTED_DATE,
                COMMITTEDQTY               AS COMMITTED_QTY,
                PO_SO_SA_FLAG              AS PO_SO_SA_FLAG,
                BEDATSCHEDULELINEORDERDATE AS CREATED_DATE,
                WAERS_CURRENCYKEY          AS CURRENCY,
                NETWRNETORDERVALUE         AS ORDER_VALUE,
                LT                         AS LEAD_TIME,
                GRT                        AS GRT,
                MRP_CONTROLLER             AS MRP_CONTROLLER,
                SUBSTR(SPC_PROC_KEY,-2)    AS PROC_KEY,
                PURCH_GROUP                AS PURCH_GROUP,
                STRATEGY_GRP               AS STRATEGY_GRP,
                UNIT_COST                  AS UNIT_COST,
                PURCH_REQ                  AS PR,
                SHIPPING_POINT             AS SHIPPING_POINT,
                DELIVERY_PRIORITY          AS DELIVERY_PRIORITY,
                ROUTE                      AS ROUTE,
                TRANSIT_DAYS               AS TRANSIT_DAYS
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
            )PO_OPEN_Q
          ON PO_OPEN_Q.PO_ID = PO_HIS_LN.PO_ID
          )PO_HIS_LN_OP
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
        ON STOCK_IN_TRAINST.ID = PO_HIS_LN_OP.ID
        )PO_HIS_LN_OP_ST
      LEFT JOIN
        (SELECT ID,
          CATALOG_DASH,
          MAT_DESC,
          MRP_TYPE,
          PROD_BU,
          MATL_TYPE
        FROM INV_SAP_PP_OPT_X
        )ITEM_BASIC
      ON ITEM_BASIC.ID = PO_HIS_LN_OP_ST.ID;
      
      4.3.4 Summary
      ----VIEW_INV_SAP_ITEM_SO_STAT_U
      CREATE VIEW VIEW_INV_SAP_ITEM_SO_STAT_U AS
       SELECT TOT_OPEN_NOCM.ID,
        TOT_OPEN_NOCM.MATERIAL,
        TOT_OPEN_NOCM.PLANT,
        TOT_OPEN_NOCM.TOT_OPEN_QTY,
        TOT_OPEN_NOCM.TOT_NO_COMMITTED_DATE_QTY,
        SO_STAT.LEAD_TIME,
        SO_STAT.PASS_DUE_QTY,
        SO_STAT.LT_OPEN_QTY,
        SO_STAT.LT_WEEKS13_OPEN_QTY,
        SO_STAT.OUT_WEEKS13_OPEN_QTY
      FROM
        (SELECT TOT_OPEN.ID AS ID,
          TOT_OPEN.MATERIAL,
          TOT_OPEN.PLANT,
          TOT_OPEN.TOT_OPEN_QTY,
          NO_COMMITTED_DATE.TOT_NO_COMMITTED_DATE_QTY
        FROM
          (SELECT MATERIAL
            ||'_'
            || PLANT AS ID,
            MATERIAL,
            PLANT,
            NVL(SUM(OPEN_QTY),0) AS TOT_OPEN_QTY
          FROM INV_SAP_SALES_VBAK_VBAP_VBUP
          GROUP BY MATERIAL,
            PLANT
          )TOT_OPEN
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
          GROUP BY MATERIAL,
            PLANT
          )NO_COMMITTED_DATE
        ON NO_COMMITTED_DATE.ID = TOT_OPEN.ID
        )TOT_OPEN_NOCM
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
      ON TOT_OPEN_NOCM.ID = SO_STAT.ID;

      DROP VIEW VIEW_INV_SAP_BALOG_SUM;
      SELECT ID,
        PROC_TYPE,
        PLANT,
        MATERIAL,
        CATALOG_DASH,
        MAT_DESC,
        BU,
        UNIT_COST,
        STRATEGY_GRP,
        SAFETY_STOCK,
        LEAD_TIME,
        MRP_CONTROLLER,
        PURCH_GROUP,
        MATL_TYPE,
        MRP_TYPE,
        AVG13_USAGE_QTY,
        FC_AVG13_WEEK_QTY,
        VENDOR,
        VENDOR_SAFETY_STOCK,
        VENDOR_STRATEGY_GRP,
        VENDOR_LEAD_TIME,
        VENDOR_FC_AVG13_WEEK_QTY,
        TOT_OPEN_QTY,
        PASS_DUE_QTY,
        LT_OPEN_QTY,
        LT_WEEKS13_OPEN_QTY,
        OUT_WEEKS13_OPEN_QTY,
        TOT_NO_COMMITTED_DATE_QTY,
        TOTSO_VALUE,
        PO_OPEN_QTY_ALL,
        STOCK_IN_TRANSIT_QTY,
        STOCK_IN_TRN_VAULE,
        TOT_STOCK_QTY,
        STOCK_VALUE
      FROM VIEW_INV_SAP_BALOG_SUM
      WHERE PLANT   IN ('5040', '5050')
      AND CHECK_KEY <> 0;
      
      DROP VIEW VIEW_INV_SAP_BALOG_SUM;
      CREATE VIEW VIEW_INV_SAP_BALOG_SUM AS
      SELECT CUST_VEN_SO_PO.ID                                                                                    AS ID,
        CUST_VEN_SO_PO.PROC_TYPE                                                                                  AS PROC_TYPE,
        CUST_VEN_SO_PO.PLANT                                                                                      AS PLANT,
        CUST_VEN_SO_PO.MATERIAL                                                                                   AS MATERIAL,
        CUST_VEN_SO_PO.CATALOG_DASH                                                                               AS CATALOG_DASH,
        CUST_VEN_SO_PO.MAT_DESC                                                                                   AS MAT_DESC,
        CUST_VEN_SO_PO.BU                                                                                         AS BU,
        CEIL(CUST_VEN_SO_PO.UNIT_COST)                                                                            AS UNIT_COST,
        CUST_VEN_SO_PO.STRATEGY_GRP                                                                               AS STRATEGY_GRP,
        NVL(CUST_VEN_SO_PO.SAFETY_STOCK,0)                                                                        AS SAFETY_STOCK,
        CUST_VEN_SO_PO.LEAD_TIME                                                                                  AS LEAD_TIME,
        CUST_VEN_SO_PO.MRP_CONTROLLER                                                                             AS MRP_CONTROLLER,
        CUST_VEN_SO_PO.PURCH_GROUP                                                                                AS PURCH_GROUP,
        CUST_VEN_SO_PO.MATL_TYPE                                                                                  AS MATL_TYPE,
        CUST_VEN_SO_PO.MRP_TYPE                                                                                   AS MRP_TYPE,
        CEIL(CUST_VEN_SO_PO.AVG13_USAGE_QTY)                                                                      AS AVG13_USAGE_QTY,
        NVL(CUST_VEN_SO_PO.FC_AVG13_WEEK_QTY,0)                                                                   AS FC_AVG13_WEEK_QTY,
        NVL(CUST_VEN_SO_PO.VENDOR,0)                                                                              AS VENDOR,
        NVL(CUST_VEN_SO_PO.VENDOR_SAFETY_STOCK,0)                                                                 AS VENDOR_SAFETY_STOCK,
        NVL(CUST_VEN_SO_PO.VENDOR_STRATEGY_GRP,0)                                                                 AS VENDOR_STRATEGY_GRP,
        NVL(CUST_VEN_SO_PO.VENDOR_LEAD_TIME,0)                                                                    AS VENDOR_LEAD_TIME,
        NVL(CUST_VEN_SO_PO.VENDOR_FC_AVG13_WEEK_QTY,0)                                                            AS VENDOR_FC_AVG13_WEEK_QTY,
        NVL(CUST_VEN_SO_PO.TOT_OPEN_QTY,0)                                                                        AS TOT_OPEN_QTY,
        NVL(CUST_VEN_SO_PO.PASS_DUE_QTY,0)                                                                        AS PASS_DUE_QTY,
        NVL(CUST_VEN_SO_PO.LT_OPEN_QTY,0)                                                                         AS LT_OPEN_QTY,
        NVL(CUST_VEN_SO_PO.LT_WEEKS13_OPEN_QTY,0)                                                                 AS LT_WEEKS13_OPEN_QTY,
        NVL(CUST_VEN_SO_PO.OUT_WEEKS13_OPEN_QTY,0)                                                                AS OUT_WEEKS13_OPEN_QTY,
        NVL(CUST_VEN_SO_PO.TOT_NO_COMMITTED_DATE_QTY,0)                                                           AS TOT_NO_COMMITTED_DATE_QTY,
        (NVL(CUST_VEN_SO_PO.TOT_OPEN_QTY,0)*NVL(CUST_VEN_SO_PO.UNIT_COST,0))                                      AS TOTSO_VALUE,
        NVL(CUST_VEN_SO_PO.PO_OPEN_QTY_ALL,0)                                                                     AS PO_OPEN_QTY_ALL,
        NVL(CUST_VEN_SO_PO.STOCK_IN_TRANSIT_QTY,0)                                                                AS STOCK_IN_TRANSIT_QTY,
        (NVL(CUST_VEN_SO_PO.STOCK_IN_TRANSIT_QTY,0)*CEIL(CUST_VEN_SO_PO.UNIT_COST))                               AS STOCK_IN_TRN_VAULE,
        NVL(INV_STATS.TOTAL_QTY,0)                                                                                AS TOT_STOCK_QTY,
        (NVL(INV_STATS.TOTAL_QTY,0)         *NVL(CUST_VEN_SO_PO.UNIT_COST,0))                                     AS STOCK_VALUE,
        (NVL(CUST_VEN_SO_PO.TOT_OPEN_QTY,0) + NVL(CUST_VEN_SO_PO.PO_OPEN_QTY_ALL,0) + NVL(INV_STATS.TOTAL_QTY,0)) AS CHECK_KEY
      FROM
        (SELECT CUSTOMER_VENDOR_SO.ID                  AS ID,
          CUSTOMER_VENDOR_SO.PROC_TYPE                 AS PROC_TYPE,
          CUSTOMER_VENDOR_SO.PLANT                     AS PLANT,
          CUSTOMER_VENDOR_SO.MATERIAL                  AS MATERIAL,
          CUSTOMER_VENDOR_SO.CATALOG_DASH              AS CATALOG_DASH,
          CUSTOMER_VENDOR_SO.MAT_DESC                  AS MAT_DESC,
          CUSTOMER_VENDOR_SO.BU                        AS BU,
          CUSTOMER_VENDOR_SO.UNIT_COST                 AS UNIT_COST,
          CUSTOMER_VENDOR_SO.STRATEGY_GRP              AS STRATEGY_GRP,
          CUSTOMER_VENDOR_SO.SAFETY_STOCK              AS SAFETY_STOCK,
          CUSTOMER_VENDOR_SO.LEAD_TIME                 AS LEAD_TIME,
          CUSTOMER_VENDOR_SO.MRP_CONTROLLER            AS MRP_CONTROLLER,
          CUSTOMER_VENDOR_SO.PURCH_GROUP               AS PURCH_GROUP,
          CUSTOMER_VENDOR_SO.MATL_TYPE                 AS MATL_TYPE ,
          CUSTOMER_VENDOR_SO.MRP_TYPE                  AS MRP_TYPE,
          CUSTOMER_VENDOR_SO.AVG13_USAGE_QTY           AS AVG13_USAGE_QTY,
          CUSTOMER_VENDOR_SO.FC_AVG13_WEEK_QTY         AS FC_AVG13_WEEK_QTY,
          CUSTOMER_VENDOR_SO.VENDOR                    AS VENDOR,
          CUSTOMER_VENDOR_SO.VENDOR_SAFETY_STOCK       AS VENDOR_SAFETY_STOCK,
          CUSTOMER_VENDOR_SO.VENDOR_STRATEGY_GRP       AS VENDOR_STRATEGY_GRP,
          CUSTOMER_VENDOR_SO.VENDOR_LEAD_TIME          AS VENDOR_LEAD_TIME,
          CUSTOMER_VENDOR_SO.VENDOR_FC_AVG13_WEEK_QTY  AS VENDOR_FC_AVG13_WEEK_QTY,
          CUSTOMER_VENDOR_SO.TOT_OPEN_QTY              AS TOT_OPEN_QTY,
          CUSTOMER_VENDOR_SO.PASS_DUE_QTY              AS PASS_DUE_QTY,
          CUSTOMER_VENDOR_SO.LT_OPEN_QTY               AS LT_OPEN_QTY,
          CUSTOMER_VENDOR_SO.LT_WEEKS13_OPEN_QTY       AS LT_WEEKS13_OPEN_QTY,
          CUSTOMER_VENDOR_SO.OUT_WEEKS13_OPEN_QTY      AS OUT_WEEKS13_OPEN_QTY,
          CUSTOMER_VENDOR_SO.TOT_NO_COMMITTED_DATE_QTY AS TOT_NO_COMMITTED_DATE_QTY,
          PO_STATS.PO_OPEN_QTY_ALL                     AS PO_OPEN_QTY_ALL,
          PO_STATS.STOCK_IN_TRANSIT_QTY                AS STOCK_IN_TRANSIT_QTY
        FROM
          (SELECT CUSTOMER_VENDOR.ID                 AS ID,
            CUSTOMER_VENDOR.PROC_TYPE                AS PROC_TYPE,
            CUSTOMER_VENDOR.PLANT                    AS PLANT,
            CUSTOMER_VENDOR.MATERIAL                 AS MATERIAL,
            CUSTOMER_VENDOR.CATALOG_DASH             AS CATALOG_DASH,
            CUSTOMER_VENDOR.MAT_DESC                 AS MAT_DESC,
            CUSTOMER_VENDOR.PROD_BU                  AS BU,
            CUSTOMER_VENDOR.UNIT_COST                AS UNIT_COST,
            CUSTOMER_VENDOR.STRATEGY_GRP             AS STRATEGY_GRP,
            CUSTOMER_VENDOR.SAFETY_STOCK             AS SAFETY_STOCK,
            CUSTOMER_VENDOR.LEAD_TIME                AS LEAD_TIME,
            CUSTOMER_VENDOR.MRP_CONTROLLER           AS MRP_CONTROLLER,
            CUSTOMER_VENDOR.PURCH_GROUP              AS PURCH_GROUP,
            CUSTOMER_VENDOR.MATL_TYPE                AS MATL_TYPE ,
            CUSTOMER_VENDOR.MRP_TYPE                 AS MRP_TYPE,
            CUSTOMER_VENDOR.AVG13_USAGE_QTY          AS AVG13_USAGE_QTY,
            CUSTOMER_VENDOR.FC_AVG13_WEEK_QTY        AS FC_AVG13_WEEK_QTY,
            CUSTOMER_VENDOR.VENDOR                   AS VENDOR,
            CUSTOMER_VENDOR.VENDOR_SAFETY_STOCK      AS VENDOR_SAFETY_STOCK,
            CUSTOMER_VENDOR.VENDOR_STRATEGY_GRP      AS VENDOR_STRATEGY_GRP,
            CUSTOMER_VENDOR.VENDOR_LEAD_TIME         AS VENDOR_LEAD_TIME,
            CUSTOMER_VENDOR.VENDOR_FC_AVG13_WEEK_QTY AS VENDOR_FC_AVG13_WEEK_QTY,
            SO_STATS.TOT_OPEN_QTY                    AS TOT_OPEN_QTY,
            SO_STATS.PASS_DUE_QTY                    AS PASS_DUE_QTY,
            SO_STATS.LT_OPEN_QTY                     AS LT_OPEN_QTY,
            SO_STATS.LT_WEEKS13_OPEN_QTY             AS LT_WEEKS13_OPEN_QTY,
            SO_STATS.OUT_WEEKS13_OPEN_QTY            AS OUT_WEEKS13_OPEN_QTY,
            SO_STATS.TOT_NO_COMMITTED_DATE_QTY       AS TOT_NO_COMMITTED_DATE_QTY
          FROM
            (SELECT CUSTOMER.ID     AS ID,
              CUSTOMER.PROC_TYPE    AS PROC_TYPE,
              CUSTOMER.PLANT        AS PLANT,
              CUSTOMER.MATERIAL     AS MATERIAL,
              CUSTOMER.CATALOG_DASH AS CATALOG_DASH,
              CUSTOMER.MAT_DESC,
              CUSTOMER.PROD_BU,
              CUSTOMER.UNIT_COST,
              CUSTOMER.STRATEGY_GRP,
              CUSTOMER.SAFETY_STOCK,
              CUSTOMER.LEAD_TIME,
              CUSTOMER.MRP_CONTROLLER,
              CUSTOMER.PURCH_GROUP,
              CUSTOMER.MATL_TYPE,
              CUSTOMER.MRP_TYPE,
              CUSTOMER.AVG13_USAGE_QTY,
              CUSTOMER.FC_AVG13_WEEK_QTY,
              VENDOR.PLANT             AS VENDOR,
              VENDOR.SAFETY_STOCK      AS VENDOR_SAFETY_STOCK,
              VENDOR.STRATEGY_GRP      AS VENDOR_STRATEGY_GRP,
              VENDOR.LEAD_TIME         AS VENDOR_LEAD_TIME,
              VENDOR.FC_AVG13_WEEK_QTY AS VENDOR_FC_AVG13_WEEK_QTY
            FROM
              (SELECT ID,
                MATERIAL,
                CATALOG_DASH,
                PLANT,
                MAT_DESC,
                SAFETY_STOCK,
                UNIT,
                PROC_TYPE,
                UNIT_COST,
                PROD_BU,
                STRATEGY_GRP,
                MRP_TYPE,
                MRP_CONTROLLER,
                PURCH_GROUP,
                VENDOR_ITEM,
                MATL_TYPE,
                LEAD_TIME,
                AVG26_USAGE_QTY,
                AVG13_USAGE_QTY,
                FC_AVG13_WEEK_QTY,
                FC_AVG26_WEEK_QTY
              FROM VIEW_INV_SAP_FC00_STATS
              )CUSTOMER
            LEFT JOIN
              (SELECT ID,
                PLANT,
                SAFETY_STOCK,
                STRATEGY_GRP,
                LEAD_TIME,
                FC_AVG13_WEEK_QTY
              FROM VIEW_INV_SAP_FC00_STATS
              )VENDOR
            ON VENDOR.ID = CUSTOMER.VENDOR_ITEM
            )CUSTOMER_VENDOR
          LEFT JOIN
            (SELECT ID,
              TOT_OPEN_QTY,
              PASS_DUE_QTY,
              LT_OPEN_QTY,
              LT_WEEKS13_OPEN_QTY,
              OUT_WEEKS13_OPEN_QTY,
              TOT_NO_COMMITTED_DATE_QTY
            FROM VIEW_INV_SAP_ITEM_SO_STAT_U --Changed here! Becasue use svd report, we miss many items from the other types.
            )SO_STATS
          ON CUSTOMER_VENDOR.ID = SO_STATS.ID
          )CUSTOMER_VENDOR_SO
        LEFT JOIN
          (SELECT ID,
            SUM(PO_OPEN_QTY) AS PO_OPEN_QTY_ALL,
            STOCK_IN_TRANSIT_QTY --Add Here
          FROM VIEW_INV_SAP_BACKLOG_PO
          GROUP BY ID,
            STOCK_IN_TRANSIT_QTY
          )PO_STATS
        ON PO_STATS.ID = CUSTOMER_VENDOR_SO.ID
        )CUST_VEN_SO_PO
      LEFT JOIN
        (SELECT ID,TOTAL_QTY,LOCATION FROM VIEW_INV_SAP_BACKLOG_INV
        )INV_STATS
      ON INV_STATS.ID = CUST_VEN_SO_PO.ID;
 
  4.4 
      --SVD Report
      --Author: Huang Moyue
      --Date: 7/15/2014    
      4.4.1
      --Sales Order Statistics
      --LT in 13 weeks
      DROP VIEW VIEW_INV_SAP_IMSO_LTIN13TMP;
      CREATE VIEW VIEW_INV_SAP_IMSO_LTIN13TMP AS
      SELECT ID,
        MATERIAL,
        PLANT,
        LEAD_TIME,
        PASS_DUE             AS PASS_DUE_QTY,
        (LT_OPEN         - PASS_DUE) AS LT_OPEN_QTY,
        (LT_WEEKS13_OPEN - LT_OPEN)  AS LT_WEEKS13_OPEN_QTY,
        OUT_WEEKS13_OPEN             AS OUT_WEEKS13_OPEN_QTY
      FROM
        (SELECT ID,
          MATERIAL,
          PLANT,
          LEAD_TIME,
          SUM(PASS_DUE)         AS PASS_DUE,
          SUM(LT_OPEN)          AS LT_OPEN,
          SUM(LT_WEEKS13_OPEN)  AS LT_WEEKS13_OPEN,
          SUM(OUT_WEEKS13_OPEN) AS OUT_WEEKS13_OPEN
        FROM
          (
          SELECT ID,
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
        FROM INV_SAP_BACKLOG_SO WHERE LEAD_TIME < 91
          )
        GROUP BY ID,
          MATERIAL,
          PLANT,
          LEAD_TIME
        );
      
      4.4.2
      --CREATE CALCULATE TABLE FOR SALES ORDER STATISTICS
      --Statics of Sales Order
      DROP VIEW VIEW_INV_SAP_IMSO_LTOUT13TMP;
      CREATE VIEW VIEW_INV_SAP_IMSO_LTOUT13TMP AS
      SELECT ID,
        MATERIAL,
        PLANT,
        LEAD_TIME,
        PASS_DUE             AS PASS_DUE_QTY,
        (LT_OPEN - PASS_DUE) AS LT_OPEN_QTY,
        0                    AS LT_WEEKS13_OPEN_QTY,
        OUT_WEEKS13_OPEN     AS OUT_WEEKS13_OPEN_QTY
      FROM
        (SELECT ID,
          MATERIAL,
          PLANT,
          LEAD_TIME,
          SUM(PASS_DUE)         AS PASS_DUE,
          SUM(LT_OPEN)          AS LT_OPEN,
          SUM(OUT_WEEKS13_OPEN) AS OUT_WEEKS13_OPEN
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
              WHEN COMMITTED_DATE > SYSDATE + LEAD_TIME
              THEN OPEN_QTY
              ELSE 0
            END OUT_WEEKS13_OPEN
          FROM INV_SAP_BACKLOG_SO
          WHERE LEAD_TIME > 91
          )
        GROUP BY ID,
          MATERIAL,
          PLANT,
          LEAD_TIME
        );

      4.4.3
      --INV_SAP_ITEM_SO_STAT 
      --Just join the LT out and in together
      --ini
      DROP TABLE INV_SAP_ITEM_SO_STAT
      CREATE TABLE INV_SAP_ITEM_SO_STAT AS
      SELECT count(*) FROM VIEW_INV_SAP_IMSO_LTOUT13TMP;
      
      TRUNCATE TABLE INV_SAP_ITEM_SO_STAT;
      INSERT INTO INV_SAP_ITEM_SO_STAT SELECT * FROM VIEW_INV_SAP_IMSO_LTIN13TMP;
      INSERT INTO INV_SAP_ITEM_SO_STAT SELECT * FROM VIEW_INV_SAP_IMSO_LTOUT13TMP;
      
      4.4.4
      --Comments
      --Clear the TMP
      TRUNCATE TABLE INV_SAP_SVD_COMMENTS_TMP;
      --Insert the comments to TMP
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
      --Merge Data
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
       --Delete the Data
       DELETE FROM INV_SAP_SVD_COMMENTS WHERE ID = 'ID_1';
       
      4.4.5
      --VIEW_INV_SAP_SVD_REPORT 
      --Svd report not contain the commments
      DROP VIEW VIEW_INV_SAP_SVD_REPORT;
      CREATE VIEW VIEW_INV_SAP_SVD_REPORT AS
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
      
      4.4.6
      --Generate Report
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
