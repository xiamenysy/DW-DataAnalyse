
SELECT PO_HST_C.ID,
  PO_HST_C.PO,
  PO_HST_C.PO_TYPE,
  PO_HST_C.ITEM,
  PO_HST_C.MATERIAL,
  PO_HST_C.PLANT,
  PO_HST_C.STRATEGY_GRP,
  PO_HST_C.PURHCASE_QTY,
  PO_HST_C.COMMITTED_DATE,
  PO_HST_C.ORDER_DATE,
  PO_HST_C.DELIVERY_DATE,
  PO_HST_C.START_DELIVERY_DATE,
  PO_HST_C.LAST_GR_Date,
  PO_HST_C.LAST_GI_Date,
  PO_HST_C.PDT,
  PO_HST_C.GRT,
  PO_HST_C.MATL_TYPE,
  PO_HST_C.VENDOR_KEY,
  VENDOR_X.STRATEGY_GRP AS VENDOR_STRATEGY_GRP
FROM
  (SELECT PO_HST.ID,
    PO_HST.PO,
    PO_HST.PO_TYPE,
    PO_HST.ITEM,
    PO_HST.MATERIAL,
    PO_HST.PLANT,
    PO_HST.STRATEGY_GRP,
    PO_HST.PURHCASE_QTY,
    PO_HST.COMMITTED_DATE,
    PO_HST.ORDER_DATE,
    PO_HST.DELIVERY_DATE,
    PO_HST.START_DELIVERY_DATE,
    PO_HST.LAST_GR_Date,
    PO_HST.LAST_GI_Date,
    CUS_X.PDT,
    CUS_X.GRT,
    CUS_X.MATL_TYPE,
    CUS_X.VENDOR_ITEM,
    CUS_X.VENDOR_KEY
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID                  AS ID,
      EBELNPURCHDOCNO            AS PO,
      BSART_PURCHDOCTYPE         AS PO_TYPE,
      EBELPPURCHITEMNO           AS ITEM,
      MATERIALID                 AS MATERIAL,
      PLANTID                    AS PLANT,
      STRATEGY_GRP               AS STRATEGY_GRP,
      MENGESCHEDULEDQTY          AS PURHCASE_QTY,
      COMMITTED_DATE             AS COMMITTED_DATE,
      BEDATSCHEDULELINEORDERDATE AS ORDER_DATE,
      EINDTPURCHITEMDELIVDATE    AS DELIVERY_DATE,
      SLFDTSTATDELIVERYDATE      AS START_DELIVERY_DATE,
      BUDATPOSTINGDATE           AS LAST_GR_Date,
      LAST_SHIP_DATE             AS LAST_GI_Date
    FROM INV_SAP_PP_PO_HISTORY
    WHERE PLANTID             IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
    AND ETENRPURCHDELIVSCHLINE = '1'
    AND BUDATPOSTINGDATE BETWEEN TO_CHAR(SYSDATE - 184) AND TO_CHAR(SYSDATE)
    AND BSART_PURCHDOCTYPE = 'ZST'
    )PO_HST
  LEFT JOIN
    (SELECT ID, PDT, GRT, MATL_TYPE,VENDOR_ITEM,VENDOR_KEY FROM INV_SAP_PP_OPT_X
    )CUS_X
  ON CUS_X.ID = PO_HST.ID
  )PO_HST_C
LEFT JOIN
  (SELECT ID, STRATEGY_GRP FROM INV_SAP_PP_OPT_X
  )VENDOR_X
ON VENDOR_X.ID = PO_HST_C.ID;

