--TEMP FILE


SELECT * FROM INV_SAP_PP_PO_HISTORY WHERE PLANTID = '5040' AND BSART_PURCHDOCTYPE = 'ZST' AND 

SELECT *
FROM VIEW_INV_SAP_BACKLOG_PO_TMP
WHERE PLANT       = '5040'
AND PURCHDOC_TYPE = 'ZST';

CREATE TABLE VIEW_INV_SAP_BACKLOG_PO_TMP AS 
SELECT * FROM VIEW_INV_SAP_BACKLOG_PO


SELECT * FROM INV_SAP_LIKP_LIPS_DAILY WHERE INCOTERMS2 = 'Shanghai' AND ACT_GI_DATE > SYSDATE - 39 

SELECT 
  DELIVERY.MATERIALID,
  DELIVERY.DELIVERY_QTY_SUOM,
  DELIVERY.CREATED_ON_DATE,
  DELIVERY.REFERENCE_DOC_TRIM,
  DELIVERY.REFERENCE_DOC_ITEM_TRIM,
  DELIVERY.CHANGED_ON_DATE,
  DELIVERY.ACT_GI_DATE,
  PRICE.UNIT_COST, 
  (DELIVERY.DELIVERY_QTY_SUOM*PRICE.UNIT_COST) AS ord_VALUE
FROM
(SELECT MATERIALID,
  DELIVERY_QTY_SUOM,
  CREATED_ON_DATE,
  REFERENCE_DOC_TRIM,
  REFERENCE_DOC_ITEM_TRIM,
  CHANGED_ON_DATE,
  ACT_GI_DATE
FROM INV_SAP_LIKP_LIPS_DAILY
WHERE INCOTERMS2 = 'Shanghai'
AND ACT_GI_DATE  > SYSDATE - 40
)DELIVERY
LEFT JOIN
(
SELECT MATERIALID,
UNIT_COST
FROM INV_SAP_PP_OPTIMIZATION WHERE PLANTID = '5040'
)PRICE
ON DELIVERY.MATERIALID = PRICE.MATERIALID;



SELECT PO,
  MATERIAL,
  STRATEGY_GRP,
  PO_OPEN_QTY,
  UNIT_COST,
  CURRENCY,
  CREATED_DATE,
  START_DELIVER_DATE,
  MAX_COMMITTED_DATE
FROM VIEW_INV_SAP_BACKLOG_PO_TMP
WHERE PLANT       = '5040'
AND PURCHDOC_TYPE = 'ZST';



SELECT MATERIAL,
  STRATEGY_GRP,
  SUM(PO_OPEN_QTY) AS SUM_OPEN,
  UNIT_COST,
  CURRENCY
FROM VIEW_INV_SAP_BACKLOG_PO_TMP
WHERE PLANT       = '5040'
AND PURCHDOC_TYPE = 'ZST'
GROUP BY
MATERIAL,
STRATEGY_GRP,
UNIT_COST,
CURRENCY
;

SELECT PLANTID,
  SALES_ORG,
  SALESDOC,
  SALESDOCITEM,
  MATERIALID,
  CATALOGID,
  LASTACTGIDATE,
  REQUIREDDELIVERYDATE,
  SALESDOCTYPE,
  ORDERQTY,
  SHIPQTY,
  OPENQTY
FROM INV_SAP_SALES_HST
WHERE LASTACTGIDATE > SYSDATE - 90
AND PLANTID                  IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140');


ALTER SESSION SET NLS_DATE_LANGUAGE='AMERICAN';
SELECT * FROM v$parameter WHERE name = 'nls_date_language';