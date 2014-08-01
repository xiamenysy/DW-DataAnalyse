 SELECT count(*) FROM(
         SELECT OPEN_SHIP.ID,
          OPEN_SHIP.PROC_TYPE,
          OPEN_SHIP.PLANT,
          OPEN_SHIP.SALES_ORG,
          OPEN_SHIP.SHIPPING_POINT,
          OPEN_SHIP.SALE_DOC_TYPE,
          OPEN_SHIP.SALES_DOC,
          OPEN_SHIP.DOC_ITEM,
          OPEN_SHIP.MATERIAL,
          OPEN_SHIP.CATALOG_DASH,
          OPEN_SHIP.MAT_DESC,
          OPEN_SHIP.MATL_TYPE,
          OPEN_SHIP.SAFETY_STOCK,
          OPEN_SHIP.STRATEGY_GRP,
          OPEN_SHIP.LEAD_TIME,
          OPEN_SHIP.BU,
          OPEN_SHIP.LINE_CREATED_DATE,
          OPEN_SHIP.REQUIRE_DATE,
          OPEN_SHIP.COMMITTED_DATE,
          OPEN_SHIP.CONFIRM_DATE,
          OPEN_SHIP.GAP,
          OPEN_SHIP.LST_ACT_GI_DATE,
          OPEN_SHIP.LST_DELIVERY_CREATE_DATE,
          OPEN_SHIP.ORDER_QTY,
          OPEN_SHIP.OPEN_QTY,
          OPEN_SHIP.SHIPPED_QTY,
          OPEN_SHIP.UNIT,
          OPEN_SHIP.PROFIT_CENTER,
          OPEN_SHIP.SALES_PRICE,
          OPEN_SHIP.UNIT_COST,
          OPEN_SHIP.CURRENCY,
          OPEN_SHIP.SOLD_TO_PARTY,
          OPEN_SHIP.SHIP_SOLD_TO_PARTY_NAME,
          OPEN_SHIP.SHIPTOPARTY,
          SOLD_SHIP.SHIP_TO_NAME,
          OPEN_SHIP.ROUTE,
          OPEN_SHIP.DELIVERY_PRIORITY,
          OPEN_SHIP.MRP_CONTROLLER,
          OPEN_SHIP.PURCH_GROUP,
          OPEN_SHIP.MRP_TYPE,
          OPEN_SHIP.DELIVERY_STATUS,
          OPEN_SHIP.OVER_ALL_DELIVERY_STATUS,
          OPEN_SHIP.VENDOR_KEY,
          OPEN_SHIP.STOCK_STATUS,
          OPEN_SHIP.REQTYPE,
          OPEN_SHIP.EXCHANGE_RATE_TO_USD
        FROM
          (
          )OPEN_SHIP
        LEFT JOIN
          (SELECT LPAD(SHIP_SOLD_TO_PARTY,10,'0') AS SHIP_SOLD_TO_PARTY,
            SHIP_SOLD_TO_PARTY_NAME               AS SHIP_TO_NAME
          FROM INV_SAP_SHIP_SOLD_TO
          )SOLD_SHIP
        ON SOLD_SHIP.SHIP_SOLD_TO_PARTY = OPEN_SHIP.SOLD_TO_PARTY
        )WHERE PLANT IN ('5040','5050');
        
        
        
        
        
        
        
        
        
        
        
        
        select count(*) from
        (SELECT OPEN_SO.ID,
            OPEN_SO.PROC_TYPE,
            OPEN_SO.PLANT,
            OPEN_SO.SALES_ORG,
            OPEN_SO.SHIPPING_POINT,
            OPEN_SO.SALE_DOC_TYPE,
            OPEN_SO.SALES_DOC,
            OPEN_SO.DOC_ITEM,
            OPEN_SO.MATERIAL,
            OPEN_SO.CATALOG_DASH,
            OPEN_SO.MAT_DESC,
            OPEN_SO.MATL_TYPE,
            OPEN_SO.SAFETY_STOCK,
            OPEN_SO.STRATEGY_GRP,
            OPEN_SO.LEAD_TIME,
            OPEN_SO.BU,
            OPEN_SO.LINE_CREATED_DATE,
            OPEN_SO.REQUIRE_DATE,
            OPEN_SO.COMMITTED_DATE,
            OPEN_SO.CONFIRM_DATE,
            OPEN_SO.GAP,
            OPEN_SO.LST_ACT_GI_DATE,
            OPEN_SO.LST_DELIVERY_CREATE_DATE,
            OPEN_SO.ORDER_QTY,
            OPEN_SO.OPEN_QTY,
            OPEN_SO.SHIPPED_QTY,
            OPEN_SO.UNIT,
            OPEN_SO.PROFIT_CENTER,
            OPEN_SO.SALES_PRICE,
            OPEN_SO.UNIT_COST,
            OPEN_SO.CURRENCY,
            OPEN_SO.SOLD_TO_PARTY,
            OPEN_SO.SHIP_SOLD_TO_PARTY_NAME,
            SHIP_TO.SHIPTOPARTY,
            OPEN_SO.ROUTE,
            OPEN_SO.DELIVERY_PRIORITY,
            OPEN_SO.MRP_CONTROLLER,
            OPEN_SO.PURCH_GROUP,
            OPEN_SO.MRP_TYPE,
            OPEN_SO.DELIVERY_STATUS,
            OPEN_SO.OVER_ALL_DELIVERY_STATUS,
            OPEN_SO.VENDOR_KEY,
            OPEN_SO.STOCK_STATUS,
            OPEN_SO.REQTYPE,
            OPEN_SO.EXCHANGE_RATE_TO_USD
          FROM
            (SELECT ID,
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
              PROFIT_CENTER,
              SALES_PRICE,
              UNIT_COST,
              CURRENCY,
              SOLD_TO_PARTY,
              SHIP_SOLD_TO_PARTY_NAME,
              ROUTE,
              DELIVERY_PRIORITY,
              MRP_CONTROLLER,
              PURCH_GROUP,
              MRP_TYPE,
              DELIVERY_STATUS,
              OVER_ALL_DELIVERY_STATUS,
              VENDOR_KEY,
              STOCK_STATUS,
              REQTYPE,
              EXCHANGE_RATE_TO_USD
            FROM VIEW_INV_SAP_BACKLOG_SO
            )OPEN_SO
          LEFT JOIN
            (SELECT distinct SALESDOC,LPAD(SHIPTOPARTY,10,'0') AS SHIPTOPARTY FROM INV_SAP_SALES_HST
            )SHIP_TO
          ON SHIP_TO.SALESDOC = OPEN_SO.SALES_DOC)where plant in('5050','5040')