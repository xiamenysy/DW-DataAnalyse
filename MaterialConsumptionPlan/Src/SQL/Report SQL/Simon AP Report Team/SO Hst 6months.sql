--Author: Huang Moyue
--Date:08272014
--Sales Order Hst in last 6 months AP.

SELECT PLANTID                                AS PLANT,
  SALES_ORG                                   AS SALES_ORG,
  MATERIALID                                  AS MATERIAL,
  CATALOGID                                   AS CATALOG#,
  SALESDOC                                    AS SALES_DOC,
  SALESDOCITEM                                AS ITEM,
  LPAD(SOLDTOPARTY,10,'0')                    AS SOLD_TO_PARTY,
  LPAD(SHIPTOPARTY,10,'0')                    AS SHIP_TO_PARTY,
  TO_CHAR(COMMITTEDDATE,'MM/DD/YYYY')         AS COMMITTED_DATE,
  TO_CHAR(CONFIRMEDDELIVERYDATE,'MM/DD/YYYY') AS CONFIRM_DELI_DATE,
  TO_CHAR(LASTACTGIDATE,'MM/DD/YYYY')         AS LAST_GI_DATE,
  TO_CHAR(LINECREATIONDATE,'MM/DD/YYYY')      AS CREATION_DATE,
  TO_CHAR(REQUIREDDELIVERYDATE,'MM/DD/YYYY')  AS REQUIRE_DELI_DATE,
  SALESDOCTYPE                                AS SO_TYPE,
  ORDERQTY                                    AS ORDER_QTY,
  OPENQTY                                     AS OPEN_QTY,
  CONFIRMEDQTY                                AS CONFIRM_QTY,
  SHIPQTY                                     AS SHIP_QTY,
  CURRENCY                                    AS CURRENCY,
  SHIPPING_POINT                              AS SHIPPING_POINT,
  ON_TIMETO_CONFIRMED                         AS ON_TIME
FROM INV_SAP_SALES_HST
WHERE PLANTID IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
AND OPENQTY    = 0
AND LINECREATIONDATE BETWEEN TO_CHAR(SYSDATE - 184) AND TO_CHAR(SYSDATE);


SELECT PLANTID                                AS PLANT,
  SALES_ORG                                   AS SALES_ORG,
  MATERIALID                                  AS MATERIAL,
  CATALOGID                                   AS CATALOG#,
  SALESDOC                                    AS SALES_DOC,
  SALESDOCITEM                                AS ITEM,
  LPAD(SOLDTOPARTY,10,'0')                    AS SOLD_TO_PARTY,
  LPAD(SHIPTOPARTY,10,'0')                    AS SHIP_TO_PARTY,
  TO_CHAR(COMMITTEDDATE,'MM/DD/YYYY')         AS COMMITTED_DATE,
  TO_CHAR(CONFIRMEDDELIVERYDATE,'MM/DD/YYYY') AS CONFIRM_DELI_DATE,
  TO_CHAR(LASTACTGIDATE,'MM/DD/YYYY')         AS LAST_GI_DATE,
  TO_CHAR(LINECREATIONDATE,'MM/DD/YYYY')      AS CREATION_DATE,
  TO_CHAR(REQUIREDDELIVERYDATE,'MM/DD/YYYY')  AS REQUIRE_DELI_DATE,
  SALESDOCTYPE                                AS SO_TYPE,
  ORDERQTY                                    AS ORDER_QTY,
  OPENQTY                                     AS OPEN_QTY,
  CONFIRMEDQTY                                AS CONFIRM_QTY,
  SHIPQTY                                     AS SHIP_QTY,
  CURRENCY                                    AS CURRENCY,
  SHIPPING_POINT                              AS SHIPPING_POINT
FROM INV_SAP_SALES_HST
WHERE CURRENCY IN ('VND')
AND OPENQTY    = 0
AND LASTACTGIDATE BETWEEN TO_CHAR(SYSDATE - 184) AND TO_CHAR(SYSDATE);

SELECT DELIVERY,
  DELIVERY_ITEM,
  MATERIALID,
  PLANTID,
  DELIVERY_QTY_SUOM,
  MATERIAL_AVAIL_DATE,
  CHANGED_ON_DATE,
  ACT_GI_DATE,
  CREATED_ON_DATE         AS DELIVERY_DATE,
  REFERENCE_DOC_TRIM      AS SO,
  REFERENCE_DOC_ITEM_TRIM AS SO_ITEM,
  REFERENCE_DOC_TRIM
  ||'_'
  ||REFERENCE_DOC_ITEM_TRIM AS ID
FROM DWQ$LIBRARIAN.INV_SAP_LIKP_LIPS_DAILY@ROCKWELL_DW_DBLINK
WHERE PLANTID                              IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140');




