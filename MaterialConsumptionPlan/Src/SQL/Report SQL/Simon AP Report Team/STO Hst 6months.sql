--Porject Name: Basic Function View
--Author: Huang Moyue 
--Mail: mhuang1@ra.rockwell.com
--Date:09/26/2014
--Summary: Automation Files Center Job Logs and set up process
--STO Hst 6 Months
--VIEW_INV_SAP_STO_HST

CREATE VIEW VIEW_INV_SAP_STO_HST_6MM AS
SELECT STO_HST_CV.ID,
  STO_HST_CV.STO_ID,
  STO_HST_CV.STO,
  STO_HST_CV.STO_TYPE,
  STO_HST_CV.ITEM,
  STO_HST_CV.MATERIAL,
  STO_HST_CV.CATALOG_DASH,
  STO_HST_CV.PROC_TYPE,
  STO_HST_CV.SPC_PROC_KEY,
  STO_HST_CV.STRATEGY_GRP,
  STO_HST_CV.PLANT,
  STO_HST_CV.ORDER_QTY,
  STO_HST_CV.SHIP_QTY,
  STO_HST_CV.ORDER_CREATE_DATE,
  STO_HST_CV.COMMITTED_DATE,
  STO_HST_CV.ORDER_DATE,
  STO_HST_CV.DELIVERY_DATE,
  STO_HST_CV.START_DELIVERY_DATE,
  STO_HST_CV.LAST_GI_DATE,
  STO_REDATE.RECEIVE_DATE,
  STO_HST_CV.PDT,
  STO_HST_CV.GRT,
  STO_HST_CV.BU,
  STO_HST_CV.MATL_TYPE,
  STO_HST_CV.UNIT_COST,
  STO_HST_CV.ORDER_VALUE,
  STO_HST_CV.CURRENCY,
  STO_HST_CV.VENDOR_ITEM,
  STO_HST_CV.VENDOR,
  STO_HST_CV.V_STRATEGY_GRP
FROM
  (SELECT STO_HST_C.ID,
    STO_HST_C.STO_ID,
    STO_HST_C.STO,
    STO_HST_C.STO_TYPE,
    STO_HST_C.ITEM,
    STO_HST_C.MATERIAL,
    STO_HST_C.CATALOG_DASH,
    STO_HST_C.PROC_TYPE,
    STO_HST_C.SPC_PROC_KEY,
    STO_HST_C.STRATEGY_GRP,
    STO_HST_C.PLANT,
    STO_HST_C.ORDER_QTY,
    STO_HST_C.SHIP_QTY,
    STO_HST_C.ORDER_CREATE_DATE,
    STO_HST_C.COMMITTED_DATE,
    STO_HST_C.ORDER_DATE,
    STO_HST_C.DELIVERY_DATE,
    STO_HST_C.START_DELIVERY_DATE,
    STO_HST_C.LAST_GI_DATE,
    STO_HST_C.PDT,
    STO_HST_C.GRT,
    STO_HST_C.BU,
    STO_HST_C.MATL_TYPE,
    STO_HST_C.UNIT_COST,
    STO_HST_C.ORDER_VALUE,
    STO_HST_C.CURRENCY,
    STO_HST_C.VENDOR_ITEM,
    STO_HST_C.VENDOR,
    VENDOR_X.STRATEGY_GRP AS V_STRATEGY_GRP
  FROM
    (SELECT STO_HST.ID,
      STO_HST.STO_ID,
      STO_HST.STO,
      STO_HST.STO_TYPE,
      STO_HST.ITEM,
      STO_HST.MATERIAL,
      CUS_X.CATALOG_DASH,
      CUS_X.PROC_TYPE,
      STO_HST.SPC_PROC_KEY,
      CUS_X.STRATEGY_GRP,
      STO_HST.PLANT,
      STO_HST.ORDER_QTY,
      STO_HST.SHIP_QTY,
      STO_HST.ORDER_CREATE_DATE,
      STO_HST.COMMITTED_DATE,
      STO_HST.ORDER_DATE,
      STO_HST.DELIVERY_DATE,
      STO_HST.START_DELIVERY_DATE,
      STO_HST.LAST_GI_DATE,
      CUS_X.PDT,
      CUS_X.GRT,
      CUS_X.BU,
      CUS_X.MATL_TYPE,
      STO_HST.UNIT_COST,
      STO_HST.ORDER_VALUE,
      STO_HST.CURRENCY,
      CUS_X.VENDOR_ITEM,
      CUS_X.VENDOR
    FROM
      (SELECT EBELNPURCHDOCNO
        ||'_'
        ||MATERIALID AS STO_ID,
        MATERIALID
        ||'_'
        ||PLANTID                  AS ID,
        EBELNPURCHDOCNO            AS STO,
        BSART_PURCHDOCTYPE         AS STO_TYPE,
        EBELPPURCHITEMNO           AS ITEM,
        MATERIALID                 AS MATERIAL,
        PLANTID                    AS PLANT,
        MENGESCHEDULEDQTY          AS ORDER_QTY,
        TOTALRECIEVEDYQTY          AS SHIP_QTY,
        CREATED_DATE               AS ORDER_CREATE_DATE,
        COMMITTED_DATE             AS COMMITTED_DATE,
        BEDATSCHEDULELINEORDERDATE AS ORDER_DATE,
        EINDTPURCHITEMDELIVDATE    AS DELIVERY_DATE,
        SLFDTSTATDELIVERYDATE      AS START_DELIVERY_DATE,
        LAST_SHIP_DATE             AS LAST_GI_DATE,
        SPC_PROC_KEY               AS SPC_PROC_KEY,
        UNIT_COST                  AS UNIT_COST,
        NETWRNETORDERVALUE         AS ORDER_VALUE,
        WAERS_CURRENCYKEY          AS CURRENCY
      FROM INV_SAP_PP_PO_HISTORY
      WHERE PLANTID             IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
      AND ETENRPURCHDELIVSCHLINE = '1'
      AND CREATED_DATE BETWEEN TO_CHAR(SYSDATE - 184) AND TO_CHAR(SYSDATE) --ORDER ENTRY DATE
      AND BSART_PURCHDOCTYPE = 'ZST'
      AND DELIVERYCOMPLETE  IS NOT NULL
      )STO_HST
    LEFT JOIN
      (SELECT ID,
        CATALOG_DASH,
        PROC_TYPE,
        STRATEGY_GRP,
        PDT,
        GRT,
        MATL_TYPE,
        VENDOR_ITEM,
        SUBSTR(VENDOR_KEY,0,4) AS VENDOR,
        SUBSTR(PROD_BU,0,3)    AS BU
      FROM INV_SAP_PP_OPT_X
      )CUS_X
    ON CUS_X.ID = STO_HST.ID
    )STO_HST_C
  LEFT JOIN
    (SELECT ID, STRATEGY_GRP FROM INV_SAP_PP_OPT_X
    )VENDOR_X
  ON VENDOR_X.ID = STO_HST_C.ID
  )STO_HST_CV
LEFT JOIN
  (SELECT STO_ID,
    RECEIVE_DATE
  FROM
    (SELECT STO_STATDATE.STO_ID,
      CASE
        WHEN STO_STATDATE.ETENRPURCHDELIVSCHLINESA = SPLIT_LINE.LINECOUNT
        THEN STO_STATDATE.SLFDTSTATDELIVERYDATE
      END RECEIVE_DATE
    FROM
      (SELECT EBELNPURCHDOCNO
        ||'_'
        ||MATERIALID AS STO_ID,
        SLFDTSTATDELIVERYDATE,
        ETENRPURCHDELIVSCHLINESA
      FROM INV_SAP_PP_PO_HISTORY
      )STO_STATDATE
    LEFT JOIN
      (SELECT EBELNPURCHDOCNO
        ||'_'
        ||MATERIALID AS STO_ID,
        MATERIALID,
        PLANTID,
        SUM(PLANTID)/PLANTID AS LINECOUNT
      FROM INV_SAP_PP_PO_HISTORY
      GROUP BY EBELNPURCHDOCNO,
        MATERIALID,
        PLANTID
      )SPLIT_LINE
    ON SPLIT_LINE.STO_ID = STO_STATDATE.STO_ID
    )
  WHERE RECEIVE_DATE              IS NOT NULL
  )STO_REDATE ON STO_REDATE.STO_ID = STO_HST_CV.STO_ID;

---STO 6 months for stock metric
SELECT STO,
  STO_TYPE,
  ITEM,
  MATERIAL,
  CATALOG_DASH,
  PROC_TYPE,
  SPC_PROC_KEY,
  STRATEGY_GRP,
  PLANT,
  ORDER_QTY,
  SHIP_QTY,
  ORDER_CREATE_DATE,
  COMMITTED_DATE,
  ORDER_DATE,
  DELIVERY_DATE,
  START_DELIVERY_DATE,
  LAST_GI_DATE,
  RECEIVE_DATE,
  PDT,
  GRT,
  BU,
  MATL_TYPE,
  UNIT_COST,
  ORDER_VALUE,
  CURRENCY
FROM VIEW_INV_SAP_STO_HST_6MM;