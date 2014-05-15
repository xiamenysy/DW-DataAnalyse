------PN-111384 pass due null, 


---Caculate Avg_FC_By_Week
SELECT *
FROM INV_SAP_PP_FRCST_PBIM_PBED
WHERE MATERIALID   = '199-DR1 B'
AND PLANTID        = '5040'
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
    AND MATERIALID = '800F-ALM A'
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
AND MATERIAL = '800F-ALM A' AND PLANT = '5040'
GROUP BY MATERIAL
  ||'_'
  ||PLANT,
  MATERIAL,
  PLANT;

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
) WHERE ID = 'PN-111384_5040';
  
  
  
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
  )BACKLOG_PASTDUE ON FC_AVG_WEEK.ID = BACKLOG_PASTDUE.ID) WHERE ID = 'PN-111384_5040';


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
  FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION
  WHERE STRATEGY_GRP   = '40'
  AND MATL_TYPE_MTART IN ('ZFG','ZTG')
  AND PLANTID         IN ('5040', '5070', '5100', '5110', '5140', '5200')
  


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

---LOCAL VERSION--------------------------------------------------------------
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