--Author: Huang Moyue
--Date: 08192014
--Report: Schedule Return

--UPLOAD THE MATL SERISE
INV_SAP_MATLSE_SRCH

SELECT COUNT(*) FROM INV_SAP_MATLSE_SRCH

INSERT INTO INV_SAP_MATLSE_SRCH(
MATERIAL,
SERISES
) VALUES (MATL_1,
SER_1
)

TRUNCATE TABLE INV_SAP_MATLSE_SRCH
------------------------------------------------------------------------------------------------------------------------
--Testing
INSERT INTO INV_SAP_MATLSE_SRCH(
MATERIAL,
SERISES
) VALUES ('1103',
'#'
)
------------------------------------------------------------------------------------------------------------------------

----Upload Return Item Details
SELECT REPLACE(RETURN_MATL, '-') AS MATL_R FROM INV_SAP_SCHED_RE_UL;

TRUNCATE TABLE INV_SAP_SCHED_RE_UL;

INSERT INTO INV_SAP_SCHED_RE_UL(
PLANT,
RETURN_MATL,
RETURN_QTY,
RETURN_SER,
RETURN_PRICE,
RETURN_AMOUNT,
REMARK
) VALUES ('PLANT_1',
'RETURN_MATL_1',
'RETURN_QTY_1',
'RETURN_SER_1',
'RETURN_PRICE_1',
'RETURN_AMOUNT_1',
'REMARK_1'
)





--In AP, we need to create one table like the cross table. 
--------------------------------
-- Unable to render VIEW DDL for object DWQ$LIBRARIAN.INV_SAP_CROSS_PART_V with DBMS_METADATA attempting internal generator.
--'5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140'
DROP VIEW VIEW_INV_SAP_AP_SOLNSH_STAT;

CREATE VIEW VIEW_INV_SAP_AP_SOLNSH_STAT AS
SELECT ID,
  MATERIAL,
  CATALOG#,
  PLANT,
  SUM(Q1) AS Q1_SHIP_QTY,
  SUM(Q2) AS Q2_SHIP_QTY,
  SUM(Q3) AS Q3_SHIP_QTY,
  SUM(Q4) AS Q4_SHIP_QTY,
  SUM(LN_Q1) AS Q1_LN_QTY,
  SUM(LN_Q2) AS Q2_LN_QTY,
  SUM(LN_Q3) AS Q3_LN_QTY,
  SUM(LN_Q4) AS Q4_LN_QTY
FROM
(
SELECT ID,
  MATERIAL,
  CATALOG#,
  PLANT,
  CASE
    WHEN LAST_GI_DATE BETWEEN TO_CHAR(SYSDATE - 365 )
    AND TO_CHAR(SYSDATE                      - 273)
    THEN SHIP_QTY
    ELSE 0
  END Q1,
  CASE
    WHEN LAST_GI_DATE BETWEEN TO_CHAR(SYSDATE - 273)
    AND TO_CHAR(SYSDATE                      - 182)
    THEN SHIP_QTY
    ELSE 0
  END Q2,
  CASE
    WHEN LAST_GI_DATE BETWEEN TO_CHAR(SYSDATE- 182)
    AND TO_CHAR(SYSDATE                     - 91)
    THEN SHIP_QTY
    ELSE 0
  END Q3,
  CASE
    WHEN LAST_GI_DATE BETWEEN TO_CHAR(SYSDATE - 91) AND TO_CHAR(SYSDATE)
    THEN SHIP_QTY
    ELSE 0
  END Q4,
    CASE
    WHEN LAST_GI_DATE BETWEEN TO_CHAR(SYSDATE - 365 )
    AND TO_CHAR(SYSDATE                      - 273)
    THEN COUNT_LINE
    ELSE 0
  END LN_Q1,
  CASE
    WHEN LAST_GI_DATE BETWEEN TO_CHAR(SYSDATE - 273)
    AND TO_CHAR(SYSDATE                      - 182)
    THEN COUNT_LINE
    ELSE 0
  END LN_Q2,
  CASE
    WHEN LAST_GI_DATE BETWEEN TO_CHAR(SYSDATE- 182)
    AND TO_CHAR(SYSDATE                     - 91)
    THEN COUNT_LINE
    ELSE 0
  END LN_Q3,
  CASE
    WHEN LAST_GI_DATE BETWEEN TO_CHAR(SYSDATE - 91) AND TO_CHAR(SYSDATE)
    THEN COUNT_LINE
    ELSE 0
  END LN_Q4
FROM
  (
  SELECT ID,
    MATERIAL,
    CATALOG#,
    COMMITTED_DATE,
    LAST_GI_DATE,
    CREATION_DATE,
    REQUEST_DATE,
    PLANT,
    ORDER_QTY,
    (NVL(ORDER_QTY,0) - NVL(OPEN_QTY,0)) AS SHIP_QTY,
    1 AS COUNT_LINE
  FROM VIEW_INV_SAP_SALES_HST_LC WHERE (LAST_GI_DATE BETWEEN TO_CHAR(SYSDATE - 365) AND TO_CHAR(SYSDATE))
  )
)
GROUP BY
ID,
MATERIAL,
PLANT,
CATALOG#


--Other AP Plant Stock Status
VIEW_INV_SAP_SGC_5140
VIEW_INV_SAP_SGC_5200
VIEW_INV_SAP_SGC_5040
VIEW_INV_SAP_SGC_5050
VIEW_INV_SAP_SGC_5070
VIEW_INV_SAP_SGC_5110
VIEW_INV_SAP_SGC_5100
VIEW_INV_SAP_SGC_5120
VIEW_INV_SAP_SGC_5190
VIEW_INV_SAP_SGC_5160

CREATE VIEW VIEW_INV_SAP_SGC_5160 AS
SELECT DISTINCT BS.ID AS ID,
  BS.MATERIAL         AS MATERIAL,
  CASE
    WHEN SG_CHECK.STRATEGY_GRP_CHECK IS NULL
    THEN 'NO'
    ELSE 'YES'
  END SG_CHECK
FROM
  (SELECT ID,
    MATERIAL
  FROM INV_SAP_PP_OPT_X
  WHERE PLANT       = '5160'
  )BS
LEFT JOIN
  (SELECT ID,
    CASE
      WHEN STRATEGY_GRP = '40'
      THEN 'YES'
      ELSE 'NO'
    END STRATEGY_GRP_CHECK,
    MATERIAL
  FROM
    (SELECT ID,
      PLANT,
      STRATEGY_GRP,
      MATERIAL
    FROM INV_SAP_PP_OPT_X
    WHERE PLANT IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140')
    AND MATERIAL = '150-C25NBD B'
    )
  WHERE PLANT NOT IN '5160'
  AND STRATEGY_GRP = '40'
  )SG_CHECK
ON BS.MATERIAL = SG_CHECK.MATERIAL;

SELECT COUNT(*) FROM INV_SAP_SR_SGCHECK WHERE SG_CHECK = 'NO';

DECLARE
  TRUNCATE_SGCHECK_TABLE  VARCHAR2(1000);
  INSERT_SGCHECK_5140  VARCHAR2(1000);
  INSERT_SGCHECK_5040  VARCHAR2(1000);
  INSERT_SGCHECK_5050  VARCHAR2(1000);
  INSERT_SGCHECK_5100  VARCHAR2(1000);
  INSERT_SGCHECK_5110  VARCHAR2(1000);
  INSERT_SGCHECK_5120  VARCHAR2(1000);
  INSERT_SGCHECK_5160  VARCHAR2(1000);
  INSERT_SGCHECK_5190  VARCHAR2(1000);
  INSERT_SGCHECK_5070  VARCHAR2(1000);
  INSERT_SGCHECK_5200  VARCHAR2(1000);

BEGIN
  TRUNCATE_SGCHECK_TABLE   := 'TRUNCATE TABLE INV_SAP_SR_SGCHECK';
  INSERT_SGCHECK_5140 := 'INSERT INTO INV_SAP_SR_SGCHECK SELECT * FROM VIEW_INV_SAP_SGC_5140';
  INSERT_SGCHECK_5040 := 'INSERT INTO INV_SAP_SR_SGCHECK SELECT * FROM VIEW_INV_SAP_SGC_5040';
  INSERT_SGCHECK_5050 := 'INSERT INTO INV_SAP_SR_SGCHECK SELECT * FROM VIEW_INV_SAP_SGC_5050';
  INSERT_SGCHECK_5100 := 'INSERT INTO INV_SAP_SR_SGCHECK SELECT * FROM VIEW_INV_SAP_SGC_5100';
  INSERT_SGCHECK_5110 := 'INSERT INTO INV_SAP_SR_SGCHECK SELECT * FROM VIEW_INV_SAP_SGC_5110';
  INSERT_SGCHECK_5120 := 'INSERT INTO INV_SAP_SR_SGCHECK SELECT * FROM VIEW_INV_SAP_SGC_5120';
  INSERT_SGCHECK_5160 := 'INSERT INTO INV_SAP_SR_SGCHECK SELECT * FROM VIEW_INV_SAP_SGC_5160';
  INSERT_SGCHECK_5190 := 'INSERT INTO INV_SAP_SR_SGCHECK SELECT * FROM VIEW_INV_SAP_SGC_5190';
  INSERT_SGCHECK_5070 := 'INSERT INTO INV_SAP_SR_SGCHECK SELECT * FROM VIEW_INV_SAP_SGC_5070';
  INSERT_SGCHECK_5200 := 'INSERT INTO INV_SAP_SR_SGCHECK SELECT * FROM VIEW_INV_SAP_SGC_5200';
  EXECUTE IMMEDIATE TRUNCATE_SGCHECK_TABLE;
  EXECUTE IMMEDIATE INSERT_SGCHECK_5140;
  EXECUTE IMMEDIATE INSERT_SGCHECK_5040;
  EXECUTE IMMEDIATE INSERT_SGCHECK_5050;
  EXECUTE IMMEDIATE INSERT_SGCHECK_5100;
  EXECUTE IMMEDIATE INSERT_SGCHECK_5110;
  EXECUTE IMMEDIATE INSERT_SGCHECK_5120;
  EXECUTE IMMEDIATE INSERT_SGCHECK_5160;
  EXECUTE IMMEDIATE INSERT_SGCHECK_5190;
  EXECUTE IMMEDIATE INSERT_SGCHECK_5070;
  EXECUTE IMMEDIATE INSERT_SGCHECK_5200;
END;   		

SELECT * FROM VIEW_INV_SAP_SCH_RE WHERE CUST_RE_MATL = '20F1AND125AA0NNNNN' AND CUST_RE_PLANT = '5100'

----Report
CREATE VIEW VIEW_INV_SAP_SCH_RE AS
SELECT RE_BSVSTGS.ID            AS ID,
  RE_BSVSTGS.CUST_RE_PLANT      AS CUST_RE_PLANT,
  RE_BSVSTGS.CUST_RE_MATL       AS CUST_RE_MATL,
  RE_BSVSTGS.CUST_RE_QTY        AS CUST_RE_QTY,
  RE_BSVSTGS.CUST_RE_SER        AS CUST_RE_SER,
  RE_BSVSTGS.CUST_RE_PRICE      AS CUST_RE_PRICE,
  RE_BSVSTGS.CUST_RE_AMOUNT     AS CUST_RE_AMOUNT,
  RE_BSVSTGS.CUST_REMARK        AS CUST_REMARK,
  RE_BSVSTGS.RE_MATERIAL        AS RE_MATERIAL,
  RE_BSVSTGS.RE_PLANT           AS RE_PLANT,
  RE_BSVSTGS.RE_D_CHAIN_BLK     AS RE_D_CHAIN_BLK,
  RE_BSVSTGS.RE_UNIT_COST       AS RE_UNIT_COST,
  RE_BSVSTGS.RE_DELIVERY_UNIT   AS RE_DELIVERY_UNIT,
  RE_BSVSTGS.RE_STRATEGY_GRP    AS RE_STRATEGY_GRP,
  RE_BSVSTGS.RE_OH_QTY          AS RE_OH_QTY,
  RE_BSVSTGS.RE_VENDOR          AS RE_VENDOR,
  RE_BSVSTGS.RE_MATL_TYPE       AS RE_MATL_TYPE,
  RE_BSVSTGS.RE_VENDOR_ITEM     AS RE_VENDOR_ITEM,
  RE_BSVSTGS.VP_STRATEGY_GRP       AS VP_STRATEGY_GRP,
  RE_BSVSTGS.VP_OH_QTY             AS VP_OH_QTY,
  RE_BSVSTGS.VP_Q4_SUM          AS VP_Q4_SUM,
  RE_BSVSTGS.Q1_SHIP_QTY        AS Q1_SHIP_QTY,
  RE_BSVSTGS.Q2_SHIP_QTY        AS Q2_SHIP_QTY,
  RE_BSVSTGS.Q3_SHIP_QTY        AS Q3_SHIP_QTY,
  RE_BSVSTGS.Q4_SHIP_QTY        AS Q4_SHIP_QTY,
  RE_BSVSTGS.Q1_LN_QTY          AS Q1_LN_QTY,
  RE_BSVSTGS.Q2_LN_QTY          AS Q2_LN_QTY,
  RE_BSVSTGS.Q3_LN_QTY          AS Q3_LN_QTY,
  RE_BSVSTGS.Q4_LN_QTY          AS Q4_LN_QTY,
  RE_BSVSTGS.ALLOW_RETURN_FLG AS ALLOW_RETURN_FLG,
  RE_BSVSTGS.SG_CHECK           AS SG_CHECK,
  RE_BSVSTGS.SERISES            AS SERISES,
  EX_RATE.CUR_USD               AS EX_TO_USD
FROM
  (SELECT RE_BSVSTG.ID           AS ID,
    RE_BSVSTG.CUST_RE_PLANT      AS CUST_RE_PLANT,
    RE_BSVSTG.CUST_RE_MATL       AS CUST_RE_MATL,
    RE_BSVSTG.CUST_RE_QTY        AS CUST_RE_QTY,
    RE_BSVSTG.CUST_RE_SER        AS CUST_RE_SER,
    RE_BSVSTG.CUST_RE_PRICE      AS CUST_RE_PRICE,
    RE_BSVSTG.CUST_RE_AMOUNT     AS CUST_RE_AMOUNT,
    RE_BSVSTG.CUST_REMARK        AS CUST_REMARK,
    RE_BSVSTG.RE_MATERIAL        AS RE_MATERIAL,
    RE_BSVSTG.RE_PLANT           AS RE_PLANT,
    RE_BSVSTG.RE_D_CHAIN_BLK     AS RE_D_CHAIN_BLK,
    RE_BSVSTG.RE_UNIT_COST       AS RE_UNIT_COST,
    RE_BSVSTG.RE_DELIVERY_UNIT   AS RE_DELIVERY_UNIT,
    RE_BSVSTG.RE_STRATEGY_GRP    AS RE_STRATEGY_GRP,
    RE_BSVSTG.RE_OH_QTY          AS RE_OH_QTY,
    RE_BSVSTG.RE_VENDOR          AS RE_VENDOR,
    RE_BSVSTG.RE_MATL_TYPE       AS RE_MATL_TYPE,
    RE_BSVSTG.RE_VENDOR_ITEM     AS RE_VENDOR_ITEM,
    RE_BSVSTG.VP_STRATEGY_GRP       AS VP_STRATEGY_GRP,
    RE_BSVSTG.VP_OH_QTY             AS VP_OH_QTY,
    RE_BSVSTG.VP_Q4_SUM          AS VP_Q4_SUM,
    RE_BSVSTG.Q1_SHIP_QTY        AS Q1_SHIP_QTY,
    RE_BSVSTG.Q2_SHIP_QTY        AS Q2_SHIP_QTY,
    RE_BSVSTG.Q3_SHIP_QTY        AS Q3_SHIP_QTY,
    RE_BSVSTG.Q4_SHIP_QTY        AS Q4_SHIP_QTY,
    RE_BSVSTG.Q1_LN_QTY          AS Q1_LN_QTY,
    RE_BSVSTG.Q2_LN_QTY          AS Q2_LN_QTY,
    RE_BSVSTG.Q3_LN_QTY          AS Q3_LN_QTY,
    RE_BSVSTG.Q4_LN_QTY          AS Q4_LN_QTY,
    RE_BSVSTG.ALLOW_RETURN_FLG AS ALLOW_RETURN_FLG,
    RE_BSVSTG.SG_CHECK           AS SG_CHECK,
    MATL_S.SERISES               AS SERISES
  FROM
    (SELECT RE_BSVST.ID           AS ID,
      RE_BSVST.CUST_RE_PLANT      AS CUST_RE_PLANT,
      RE_BSVST.CUST_RE_MATL       AS CUST_RE_MATL,
      RE_BSVST.CUST_RE_QTY        AS CUST_RE_QTY,
      RE_BSVST.CUST_RE_SER        AS CUST_RE_SER,
      RE_BSVST.CUST_RE_PRICE      AS CUST_RE_PRICE,
      RE_BSVST.CUST_RE_AMOUNT     AS CUST_RE_AMOUNT,
      RE_BSVST.CUST_REMARK        AS CUST_REMARK,
      RE_BSVST.RE_MATERIAL        AS RE_MATERIAL,
      RE_BSVST.RE_PLANT           AS RE_PLANT,
      RE_BSVST.RE_D_CHAIN_BLK     AS RE_D_CHAIN_BLK,
      RE_BSVST.RE_UNIT_COST       AS RE_UNIT_COST,
      RE_BSVST.RE_DELIVERY_UNIT   AS RE_DELIVERY_UNIT,
      RE_BSVST.RE_STRATEGY_GRP    AS RE_STRATEGY_GRP,
      RE_BSVST.RE_OH_QTY          AS RE_OH_QTY,
      RE_BSVST.RE_VENDOR          AS RE_VENDOR,
      RE_BSVST.RE_MATL_TYPE       AS RE_MATL_TYPE,
      RE_BSVST.RE_VENDOR_ITEM     AS RE_VENDOR_ITEM,
      RE_BSVST.VP_STRATEGY_GRP       AS VP_STRATEGY_GRP,
      RE_BSVST.VP_OH_QTY             AS VP_OH_QTY,
      RE_BSVST.VP_Q4_SUM          AS VP_Q4_SUM,
      RE_BSVST.Q1_SHIP_QTY        AS Q1_SHIP_QTY,
      RE_BSVST.Q2_SHIP_QTY        AS Q2_SHIP_QTY,
      RE_BSVST.Q3_SHIP_QTY        AS Q3_SHIP_QTY,
      RE_BSVST.Q4_SHIP_QTY        AS Q4_SHIP_QTY,
      RE_BSVST.Q1_LN_QTY          AS Q1_LN_QTY,
      RE_BSVST.Q2_LN_QTY          AS Q2_LN_QTY,
      RE_BSVST.Q3_LN_QTY          AS Q3_LN_QTY,
      RE_BSVST.Q4_LN_QTY          AS Q4_LN_QTY,
      RE_BSVST.ALLOW_RETURN_FLG AS ALLOW_RETURN_FLG,
      SG_CH.SG_CHECK              AS SG_CHECK
    FROM
      (SELECT RE_BSVS.ID         AS ID,
        RE_BSVS.CUST_RE_PLANT    AS CUST_RE_PLANT,
        RE_BSVS.CUST_RE_MATL     AS CUST_RE_MATL,
        RE_BSVS.CUST_RE_QTY      AS CUST_RE_QTY,
        RE_BSVS.CUST_RE_SER      AS CUST_RE_SER,
        RE_BSVS.CUST_RE_PRICE    AS CUST_RE_PRICE,
        RE_BSVS.CUST_RE_AMOUNT   AS CUST_RE_AMOUNT,
        RE_BSVS.CUST_REMARK      AS CUST_REMARK,
        RE_BSVS.RE_MATERIAL      AS RE_MATERIAL,
        RE_BSVS.RE_PLANT         AS RE_PLANT,
        RE_BSVS.RE_D_CHAIN_BLK   AS RE_D_CHAIN_BLK,
        RE_BSVS.RE_UNIT_COST     AS RE_UNIT_COST,
        RE_BSVS.RE_DELIVERY_UNIT AS RE_DELIVERY_UNIT,
        RE_BSVS.RE_STRATEGY_GRP  AS RE_STRATEGY_GRP,
        RE_BSVS.RE_OH_QTY        AS RE_OH_QTY,
        RE_BSVS.RE_VENDOR        AS RE_VENDOR,
        RE_BSVS.RE_MATL_TYPE     AS RE_MATL_TYPE,
        RE_BSVS.RE_VENDOR_ITEM   AS RE_VENDOR_ITEM,
        RE_BSVS.VP_STRATEGY_GRP     AS VP_STRATEGY_GRP,
        RE_BSVS.VP_OH_QTY           AS VP_OH_QTY,
        RE_BSVS.VP_Q4_SUM        AS VP_Q4_SUM,
        RE_BSVS.Q1_SHIP_QTY      AS Q1_SHIP_QTY,
        RE_BSVS.Q2_SHIP_QTY      AS Q2_SHIP_QTY,
        RE_BSVS.Q3_SHIP_QTY      AS Q3_SHIP_QTY,
        RE_BSVS.Q4_SHIP_QTY      AS Q4_SHIP_QTY,
        RE_BSVS.Q1_LN_QTY        AS Q1_LN_QTY,
        RE_BSVS.Q2_LN_QTY        AS Q2_LN_QTY,
        RE_BSVS.Q3_LN_QTY        AS Q3_LN_QTY,
        RE_BSVS.Q4_LN_QTY        AS Q4_LN_QTY,
        ST.ALLOWED_SCHED_RTRN    AS ALLOW_RETURN_FLG
      FROM
        (SELECT RE_BSV.ID         AS ID,
          RE_BSV.CUST_RE_PLANT    AS CUST_RE_PLANT,
          RE_BSV.CUST_RE_MATL     AS CUST_RE_MATL,
          RE_BSV.CUST_RE_QTY      AS CUST_RE_QTY,
          RE_BSV.CUST_RE_SER      AS CUST_RE_SER,
          RE_BSV.CUST_RE_PRICE    AS CUST_RE_PRICE,
          RE_BSV.CUST_RE_AMOUNT   AS CUST_RE_AMOUNT,
          RE_BSV.CUST_REMARK      AS CUST_REMARK,
          RE_BSV.RE_MATERIAL      AS RE_MATERIAL,
          RE_BSV.RE_PLANT         AS RE_PLANT,
          RE_BSV.RE_D_CHAIN_BLK   AS RE_D_CHAIN_BLK,
          RE_BSV.RE_UNIT_COST     AS RE_UNIT_COST,
          RE_BSV.RE_DELIVERY_UNIT AS RE_DELIVERY_UNIT,
          RE_BSV.RE_STRATEGY_GRP  AS RE_STRATEGY_GRP,
          RE_BSV.RE_OH_QTY        AS RE_OH_QTY,
          RE_BSV.RE_VENDOR        AS RE_VENDOR,
          RE_BSV.RE_MATL_TYPE     AS RE_MATL_TYPE,
          RE_BSV.RE_VENDOR_ITEM   AS RE_VENDOR_ITEM,
          RE_BSV.VP_STRATEGY_GRP     AS VP_STRATEGY_GRP,
          RE_BSV.VP_OH_QTY           AS VP_OH_QTY,
          RE_BSV.VP_Q4_SUM        AS VP_Q4_SUM,
          SOLNSH.Q1_SHIP_QTY      AS Q1_SHIP_QTY,
          SOLNSH.Q2_SHIP_QTY      AS Q2_SHIP_QTY,
          SOLNSH.Q3_SHIP_QTY      AS Q3_SHIP_QTY,
          SOLNSH.Q4_SHIP_QTY      AS Q4_SHIP_QTY,
          SOLNSH.Q1_LN_QTY        AS Q1_LN_QTY,
          SOLNSH.Q2_LN_QTY        AS Q2_LN_QTY,
          SOLNSH.Q3_LN_QTY        AS Q3_LN_QTY,
          SOLNSH.Q4_LN_QTY        AS Q4_LN_QTY
        FROM
          (SELECT RE_BS.ID                                 AS ID,
            RE_BS.CUST_RE_PLANT                            AS CUST_RE_PLANT,
            RE_BS.CUST_RE_MATL                             AS CUST_RE_MATL,
            RE_BS.CUST_RE_QTY                              AS CUST_RE_QTY,
            RE_BS.CUST_RE_SER                              AS CUST_RE_SER,
            RE_BS.CUST_RE_PRICE                            AS CUST_RE_PRICE,
            RE_BS.CUST_RE_AMOUNT                           AS CUST_RE_AMOUNT,
            RE_BS.CUST_REMARK                              AS CUST_REMARK,
            RE_BS.RE_MATERIAL                              AS RE_MATERIAL,
            RE_BS.RE_PLANT                                 AS RE_PLANT,
            RE_BS.RE_D_CHAIN_BLK                           AS RE_D_CHAIN_BLK,
            RE_BS.RE_UNIT_COST                             AS RE_UNIT_COST,
            RE_BS.RE_DELIVERY_UNIT                         AS RE_DELIVERY_UNIT,
            RE_BS.RE_STRATEGY_GRP                          AS RE_STRATEGY_GRP,
            RE_BS.RE_OH_QTY                                AS RE_OH_QTY,
            RE_BS.RE_VENDOR                                AS RE_VENDOR,
            RE_BS.RE_MATL_TYPE                             AS RE_MATL_TYPE,
            RE_BS.RE_VENDOR_ITEM                           AS RE_VENDOR_ITEM,
            VENDOR_PLANT.STRATEGY_GRP                      AS VP_STRATEGY_GRP,
            VENDOR_PLANT.OH_QTY                            AS VP_OH_QTY,
            CEIL(NVL(VENDOR_PLANT.AVG13_USAGE_QTY,0) * 13) AS VP_Q4_SUM
          FROM
            (SELECT RETURN_PLANT.ID               AS ID,
              SCHED_RE.PLANT                      AS CUST_RE_PLANT,
              SCHED_RE.RETURN_MATL                AS CUST_RE_MATL,
              SCHED_RE.RETURN_QTY                 AS CUST_RE_QTY,
              SCHED_RE.RETURN_SER                 AS CUST_RE_SER,
              SCHED_RE.RETURN_PRICE               AS CUST_RE_PRICE,
              SCHED_RE.RETURN_AMOUNT              AS CUST_RE_AMOUNT,
              SCHED_RE.REMARK                     AS CUST_REMARK,
              RETURN_PLANT.MATERIAL               AS RE_MATERIAL,
              RETURN_PLANT.PLANT                  AS RE_PLANT,
              RETURN_PLANT.D_CHAIN_BLK            AS RE_D_CHAIN_BLK,
              RETURN_PLANT.UNIT_COST              AS RE_UNIT_COST,
              RETURN_PLANT.ISSUE_UOM_NUMERATOR    AS RE_DELIVERY_UNIT,
              RETURN_PLANT.STRATEGY_GRP           AS RE_STRATEGY_GRP,
              RETURN_PLANT.OH_QTY                 AS RE_OH_QTY,
              SUBSTR(RETURN_PLANT.VENDOR_KEY,0,4) AS RE_VENDOR,
              RETURN_PLANT.MATL_TYPE              AS RE_MATL_TYPE,
              RETURN_PLANT.VENDOR_ITEM            AS RE_VENDOR_ITEM
            FROM
              (SELECT TRIM(REPLACE(RETURN_MATL, '-'))
                ||'_'
                ||PLANT AS TMP_ID,
                PLANT,
                RETURN_MATL,
                RETURN_QTY,
                RETURN_SER,
                RETURN_PRICE,
                RETURN_AMOUNT,
                REMARK
              FROM INV_SAP_SCHED_RE_UL
              WHERE PLANT NOT     IN ('#')
              AND RETURN_MATL NOT IN ('#')
              )SCHED_RE
            LEFT JOIN
              (SELECT ID,
                TMP_ID,
                MATERIAL,
                CATALOG_DASH,
                CATALOG_NO_DASH,
                PLANT,
                D_CHAIN_BLK,
                UNIT_COST,
                ISSUE_UOM_NUMERATOR,
                STRATEGY_GRP,
                OH_QTY,
                VENDOR_KEY,
                MATL_TYPE,
                VENDOR_ITEM
                FROM INV_SAP_PP_OPT_X
              )RETURN_PLANT
            ON RETURN_PLANT.TMP_ID = SCHED_RE.TMP_ID
            )RE_BS
          LEFT JOIN
            (SELECT ID, STRATEGY_GRP, OH_QTY, AVG13_USAGE_QTY FROM INV_SAP_PP_OPT_X
            )VENDOR_PLANT
          ON VENDOR_PLANT.ID = RE_BS.RE_VENDOR_ITEM
          )RE_BSV
        LEFT JOIN
          (SELECT ID,
            MATERIAL,
            PLANT,
            Q1_SHIP_QTY,
            Q2_SHIP_QTY,
            Q3_SHIP_QTY,
            Q4_SHIP_QTY,
            Q1_LN_QTY,
            Q2_LN_QTY,
            Q3_LN_QTY,
            Q4_LN_QTY
          FROM VIEW_INV_SAP_AP_SOLNSH_STAT
          )SOLNSH
        ON SOLNSH.ID = RE_BSV.ID
        )RE_BSVS
      LEFT JOIN
        (SELECT MATERIALID
          ||'_'
          ||DIRECT_SHIP_PLANT AS ID,
          ALLOWED_SCHED_RTRN
        FROM INV_SAP_PP_MVKE
        )ST
      ON ST.ID = RE_BSVS.ID
      )RE_BSVST
    LEFT JOIN
      (SELECT ID, SG_CHECK FROM INV_SAP_SR_SGCHECK
      )SG_CH
    ON SG_CH.ID = RE_BSVST.ID
    )RE_BSVSTG
  LEFT JOIN
    (SELECT MATERIAL, SERISES FROM INV_SAP_MATLSE_SRCH
    )MATL_S
  ON MATL_S.MATERIAL = RE_BSVSTG.RE_MATERIAL
  )RE_BSVSTGS
LEFT JOIN
  ( SELECT CUR_USD,PLANT FROM INV_SAP_EXCHANGE_RATE WHERE PLANT = '5100'
  )EX_RATE
ON EX_RATE.PLANT = RE_BSVSTGS.RE_PLANT;



--
SELECT CUST_RE_PLANT,
  CUST_RE_MATL,
  CUST_RE_QTY,
  CUST_RE_SER,
  CUST_RE_PRICE,
  CUST_RE_AMOUNT,
  CUST_REMARK,
  RE_MATERIAL,
  SERISES,
  RE_MATL_TYPE,
  RE_D_CHAIN_BLK,
  RE_UNIT_COST,
  NVL(CUST_RE_QTY,0)*NVL(RE_UNIT_COST,0) AS Extend_Cost,
  RE_STRATEGY_GRP,
  SG_CHECK,
  RE_OH_QTY,
  RE_DELIVERY_UNIT,
  Q1_SHIP_QTY,
  Q2_SHIP_QTY,
  Q3_SHIP_QTY,
  Q4_SHIP_QTY,
  Q1_LN_QTY,
  Q2_LN_QTY,
  Q3_LN_QTY,
  Q4_LN_QTY,
  ALLOW_RETURN_FLG,
  RE_VENDOR,
  VP_STRATEGY_GRP,
  VP_OH_QTY,
  VP_Q4_SUM,
  EX_TO_USD,
  CASE
    WHEN CUST_RE_AMOUNT = '#'
    THEN 0
    ELSE NVL(CUST_RE_AMOUNT,0)*NVL(EX_TO_USD,0)
  END INV_VALUE
FROM VIEW_INV_SAP_SCH_RE
WHERE CUST_RE_MATL = '20F1AND125AA0NNNNN'
AND CUST_RE_PLANT  = '5100';