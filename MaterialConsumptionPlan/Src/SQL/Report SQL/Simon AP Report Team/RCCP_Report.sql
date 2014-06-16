--RCCP REPORT
--6/14/2014
--AUTHOR: HUANG MOYUE
--'5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140'
--OUTPUT, INPUT FOR TOTAL REQUIREMENT AND PO+PLAN ORDER
SELECT MATERIALID,
  PLANTID,
  OUT_QTY_W01,
  OUT_QTY_W02,
  OUT_QTY_W03,
  OUT_QTY_W04,
  OUT_QTY_W05,
  OUT_QTY_W06,
  OUT_QTY_W07,
  OUT_QTY_W08,
  OUT_QTY_W09,
  OUT_QTY_W10,
  OUT_QTY_W11,
  OUT_QTY_W12,
  OUT_QTY_W13,
  IN_QTY_W01,
  IN_QTY_W02,
  IN_QTY_W03,
  IN_QTY_W04,
  IN_QTY_W05,
  IN_QTY_W06,
  IN_QTY_W07,
  IN_QTY_W08,
  IN_QTY_W09,
  IN_QTY_W10,
  IN_QTY_W11,
  IN_QTY_W12,
  IN_QTY_W13
FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION
WHERE MATERIALID = '700-P400A2 E'
AND PLANTID      = '5050';

--Firm Customer Requirements
----SHOPPING CART

SELECT SHOPPOING_CART.ID                             AS ID,
  (SHOPPOING_CART.SHCART_OPEN + SALES_OPEN.OPEN_QTY) AS FIRM_REQ_QTY
FROM
  (SELECT ID,
    MATERIALID,
    SUM(WEEK_1)  AS WK_1,
    SUM(WEEK_2)  AS WK_2,
    SUM(WEEK_3)  AS WK_3,
    SUM(WEEK_4)  AS WK_4,
    SUM(WEEK_5)  AS WK_5,
    SUM(WEEK_6)  AS WK_6,
    SUM(WEEK_7)  AS WK_7,
    SUM(WEEK_8)  AS WK_8,
    SUM(WEEK_9)  AS WK_9,
    SUM(WEEK_10) AS WK_10,
    SUM(WEEK_11) AS WK_11,
    SUM(WEEK_12) AS WK_12,
    SUM(WEEK_13) AS WK_13
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID AS ID,
      MATERIALID,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw')
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_1,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 1
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_2,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 2
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_3,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 3
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_4,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 4
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_5,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 5
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_6,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 6
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_7,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 7
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_8,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 8
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_9,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 9
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_10,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 10
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_11,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 11
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_12,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 12
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_13,
      PLANTID
    FROM
      (SELECT MATERIALID
        ||'_'
        ||PLANTID AS ID,
        MATERIALID,
        PLANTID,
        TO_CHAR(COMMITTED_DATE,'iw') AS WEEK_NUMBER,
        COMMITTEDQTY                 AS PLNMG_PLANNEDQUANTITY
      FROM INV_SAP_PP_PO_HISTORY
      WHERE BSART_PURCHDOCTYPE       = 'ZUB'
      AND ELIKZDELIVERYCOMPLETEDIND IS NULL
      AND COMMITTED_DATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 91)
      )
    )
  GROUP BY ID,
    MATERIALID
  )SHOPPOING_CART
LEFT JOIN
  (SELECT ID,
    MATERIALID,
    SUM(WEEK_1)  AS WK_1,
    SUM(WEEK_2)  AS WK_2,
    SUM(WEEK_3)  AS WK_3,
    SUM(WEEK_4)  AS WK_4,
    SUM(WEEK_5)  AS WK_5,
    SUM(WEEK_6)  AS WK_6,
    SUM(WEEK_7)  AS WK_7,
    SUM(WEEK_8)  AS WK_8,
    SUM(WEEK_9)  AS WK_9,
    SUM(WEEK_10) AS WK_10,
    SUM(WEEK_11) AS WK_11,
    SUM(WEEK_12) AS WK_12,
    SUM(WEEK_13) AS WK_13
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID AS ID,
      MATERIALID,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw')
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_1,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 1
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_2,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 2
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_3,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 3
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_4,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 4
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_5,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 5
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_6,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 6
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_7,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 7
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_8,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 8
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_9,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 9
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_10,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 10
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_11,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 11
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_12,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 12
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_13,
      PLANTID
    FROM
      (SELECT MATERIALID
        ||'_'
        ||PLANTID                          AS ID,
        MATERIALID                         AS MATERIALID,
        PLANTID                            AS PLANTID,
        TO_CHAR(REQUIREDDELIVERYDATE,'iw') AS WEEK_NUMBER,
        REQUIREDDELIVERYDATE,
        SALESDOC,
        OPENQTY AS PLNMG_PLANNEDQUANTITY
      FROM INV_SAP_SALES_HST
      WHERE REQUIREDDELIVERYDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 91)
      AND SALESDOCTYPE                                                       IN ('ZOR1','ZOR5')
      AND OPENQTY       > 0
      )
    )
  GROUP BY ID,
    MATERIALID
  )SALES_OPEN
ON SALES_OPEN.ID = SHOPPOING_CART.ID;


--IndReq
--vse/vsf
---How to calculate the week number.
---SELECT TO_CHAR(SYSDATE,'iw') AS weekn,
--  TO_CHAR(to_date('20050425','yyyymmdd'),'iw')      AS week1
--FROM dual; 
SELECT ID,
  MATERIALID,
  SUM(WEEK_1) AS WK_1,
  SUM(WEEK_2) AS WK_2,
  SUM(WEEK_3) AS WK_3,
  SUM(WEEK_4) AS WK_4,
  SUM(WEEK_5) AS WK_5,
  SUM(WEEK_6) AS WK_6,
  SUM(WEEK_7) AS WK_7,
  SUM(WEEK_8) AS WK_8,
  SUM(WEEK_9) AS WK_9,
  SUM(WEEK_10) AS WK_10,
  SUM(WEEK_11) AS WK_11,
  SUM(WEEK_12) AS WK_12,
  SUM(WEEK_13) AS WK_13
FROM
  (SELECT MATERIALID
    ||'_'
    ||PLANTID AS ID,
    MATERIALID,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw')
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_1,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 1
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_2,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 2
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_3,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 3
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_4,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 4
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_5,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 5
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_6,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 6
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_7,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 7
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_8,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 8
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_9,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 9
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_10,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 10
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_11,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 11
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_12,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 12
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_13,
    PLANTID
  FROM
    (SELECT MATERIALID,
      PLANTID,
      PDATU_DELIV_ORDFINISHDATE,
      TO_CHAR(PDATU_DELIV_ORDFINISHDATE,'iw') AS WEEK_NUMBER,
      MEINS_BASEUNITOFMEASURE,
      PLNMG_PLANNEDQUANTITY,
      BEDAEP_REQUIREMENTSTYPE,
      VERSBP_VERSION
    FROM INV_SAP_PP_FRCST_PBIM_PBED
    WHERE VERSBP_VERSION = '55'
    AND PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 91)
    )
  )group by ID, MATERIALID;
  
  

--Basic info

SELECT 
ID,
LAST_REVIEW,
MATERIAL,
CATALOG_DASH,
CATALOG_NO_DASH,
PLANT,
MAT_DESC,
SAFETY_STOCK,
OH_QTY,
UNIT,
UNIT_COST,
PROD_BU,
PLANT_SP_MATL_STA,
VENDOR_KEY,
MIN_INV,
TARGET_INV,
MAX_INV,
OUT_QTY_W01,
OUT_QTY_W02,
OUT_QTY_W03,
OUT_QTY_W04,
OUT_QTY_W05,
OUT_QTY_W06,
OUT_QTY_W07,
OUT_QTY_W08,
OUT_QTY_W09,
OUT_QTY_W10,
OUT_QTY_W11,
OUT_QTY_W12,
OUT_QTY_W13,
IN_QTY_W01,
IN_QTY_W02,
IN_QTY_W03,
IN_QTY_W04,
IN_QTY_W05,
IN_QTY_W06,
IN_QTY_W07,
IN_QTY_W08,
IN_QTY_W09,
IN_QTY_W10,
IN_QTY_W11,
IN_QTY_W12,
IN_QTY_W13
FROM VIEW_INV_SAP_PP_OPT_X;


-----REPORT------------------------
DROP VIEW VIEW_RCCP;
select * from view_rccp where plant = '5040' and material = '1756-IB16 A';
CREATE VIEW VIEW_INV_SAP_RCCP AS 
SELECT RCCP_BASIC.ID      AS ID,
  RCCP_BASIC.LAST_REVIEW  AS LAST_REVIEW,
  RCCP_BASIC.MATERIAL     AS MATERIAL,
  RCCP_BASIC.CATALOG_DASH AS CATALOG_DASH,
  RCCP_BASIC.PLANT        AS PLANT,
  RCCP_BASIC.MAT_DESC MATERIAL_DES,
  RCCP_BASIC.SAFETY_STOCK      AS SAFETY_STOCK,
  RCCP_BASIC.OH_QTY            AS OH_QTY,
  RCCP_BASIC.UNIT              AS UNIT,
  RCCP_BASIC.UNIT_COST         AS UNIT_COST,
  RCCP_BASIC.PROD_BU           AS PROD_BU,
  RCCP_BASIC.PLANT_SP_MATL_STA AS SP,
  RCCP_BASIC.VENDOR_KEY        AS VENDOR,
  RCCP_BASIC.MIN_INV           AS MIN_INV,
  RCCP_BASIC.TARGET_INV        AS TARGET_INV,
  RCCP_BASIC.MAX_INV           AS MAX_INV,
  0                            AS Ind_Req_AVG,
  0                            AS Ind_Req_AVG_50,
  0                            AS Ind_Req_AVG_25,
  IndReq.WK_1                  AS Ind_Req_Week_1,
  IndReq.WK_2                  AS Ind_Req_Week_2,
  IndReq.WK_3                  AS Ind_Req_Week_3,
  IndReq.WK_4                  AS Ind_Req_Week_4,
  IndReq.WK_5                  AS Ind_Req_Week_5,
  IndReq.WK_6                  AS Ind_Req_Week_6,
  IndReq.WK_7                  AS Ind_Req_Week_7,
  IndReq.WK_8                  AS Ind_Req_Week_8,
  IndReq.WK_9                  AS Ind_Req_Week_9,
  IndReq.WK_10                 AS Ind_Req_Week_10,
  IndReq.WK_11                 AS Ind_Req_Week_11,
  IndReq.WK_12                 AS Ind_Req_Week_12,
  IndReq.WK_13                 AS Ind_Req_Week_13,
  RCCP_BASIC.OUT_QTY_W01       AS TOT_Req_Week_1,
  RCCP_BASIC.OUT_QTY_W02       AS TOT_Req_Week_2,
  RCCP_BASIC.OUT_QTY_W03       AS TOT_Req_Week_3,
  RCCP_BASIC.OUT_QTY_W04       AS TOT_Req_Week_4,
  RCCP_BASIC.OUT_QTY_W05       AS TOT_Req_Week_5,
  RCCP_BASIC.OUT_QTY_W06       AS TOT_Req_Week_6,
  RCCP_BASIC.OUT_QTY_W07       AS TOT_Req_Week_7,
  RCCP_BASIC.OUT_QTY_W08       AS TOT_Req_Week_8,
  RCCP_BASIC.OUT_QTY_W08       AS TOT_Req_Week_8,
  RCCP_BASIC.OUT_QTY_W09       AS TOT_Req_Week_9,
  RCCP_BASIC.OUT_QTY_W10       AS TOT_Req_Week_10,
  RCCP_BASIC.OUT_QTY_W11       AS TOT_Req_Week_11,
  RCCP_BASIC.OUT_QTY_W12       AS TOT_Req_Week_12,
  RCCP_BASIC.OUT_QTY_W13       AS TOT_Req_Week_13,
  0 AS Three_Sigma,
  0 AS Three_Sigma_Load,
  RCCP_BASIC.IN_QTY_W01        AS TOT_PO_PLO_Week_1,
  RCCP_BASIC.IN_QTY_W02        AS TOT_PO_PLO_Week_2,
  RCCP_BASIC.IN_QTY_W03        AS TOT_PO_PLO_Week_3,
  RCCP_BASIC.IN_QTY_W04        AS TOT_PO_PLO_Week_4,
  RCCP_BASIC.IN_QTY_W05        AS TOT_PO_PLO_Week_5,
  RCCP_BASIC.IN_QTY_W06        AS TOT_PO_PLO_Week_6,
  RCCP_BASIC.IN_QTY_W07        AS TOT_PO_PLO_Week_7,
  RCCP_BASIC.IN_QTY_W08        AS TOT_PO_PLO_Week_8,
  RCCP_BASIC.IN_QTY_W09        AS TOT_PO_PLO_Week_9,
  RCCP_BASIC.IN_QTY_W10        AS TOT_PO_PLO_Week_10,
  RCCP_BASIC.IN_QTY_W11        AS TOT_PO_PLO_Week_11,
  RCCP_BASIC.IN_QTY_W12        AS TOT_PO_PLO_Week_12,
  RCCP_BASIC.IN_QTY_W13        AS TOT_PO_PLO_Week_13
FROM
  (
	SELECT ID,
    LAST_REVIEW,
    MATERIAL,
    CATALOG_DASH,
    CATALOG_NO_DASH,
    PLANT,
    MAT_DESC,
    SAFETY_STOCK,
    OH_QTY,
    UNIT,
    UNIT_COST,
    PROD_BU,
    PLANT_SP_MATL_STA,
    VENDOR_KEY,
    MIN_INV,
    TARGET_INV,
    MAX_INV,
    OUT_QTY_W01,
    OUT_QTY_W02,
    OUT_QTY_W03,
    OUT_QTY_W04,
    OUT_QTY_W05,
    OUT_QTY_W06,
    OUT_QTY_W07,
    OUT_QTY_W08,
    OUT_QTY_W09,
    OUT_QTY_W10,
    OUT_QTY_W11,
    OUT_QTY_W12,
    OUT_QTY_W13,
    IN_QTY_W01,
    IN_QTY_W02,
    IN_QTY_W03,
    IN_QTY_W04,
    IN_QTY_W05,
    IN_QTY_W06,
    IN_QTY_W07,
    IN_QTY_W08,
    IN_QTY_W09,
    IN_QTY_W10,
    IN_QTY_W11,
    IN_QTY_W12,
    IN_QTY_W13
  FROM VIEW_INV_SAP_PP_OPT_X
  )RCCP_BASIC
LEFT JOIN
(
  SELECT ID,
    MATERIALID,
    SUM(WEEK_1)  AS WK_1,
    SUM(WEEK_2)  AS WK_2,
    SUM(WEEK_3)  AS WK_3,
    SUM(WEEK_4)  AS WK_4,
    SUM(WEEK_5)  AS WK_5,
    SUM(WEEK_6)  AS WK_6,
    SUM(WEEK_7)  AS WK_7,
    SUM(WEEK_8)  AS WK_8,
    SUM(WEEK_9)  AS WK_9,
    SUM(WEEK_10) AS WK_10,
    SUM(WEEK_11) AS WK_11,
    SUM(WEEK_12) AS WK_12,
    SUM(WEEK_13) AS WK_13
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID AS ID,
      MATERIALID,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw')
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_1,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 1
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_2,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 2
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_3,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 3
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_4,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 4
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_5,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 5
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_6,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 6
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_7,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 7
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_8,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 8
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_9,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 9
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_10,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 10
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_11,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 11
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_12,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 12
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_13,
      PLANTID
    FROM
      (SELECT MATERIALID,
        PLANTID,
        PDATU_DELIV_ORDFINISHDATE,
        TO_CHAR(PDATU_DELIV_ORDFINISHDATE,'iw') AS WEEK_NUMBER,
        MEINS_BASEUNITOFMEASURE,
        PLNMG_PLANNEDQUANTITY,
        BEDAEP_REQUIREMENTSTYPE,
        VERSBP_VERSION
      FROM INV_SAP_PP_FRCST_PBIM_PBED
      WHERE VERSBP_VERSION = '55'
      AND PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 91)
      )
    )
  GROUP BY ID,
    MATERIALID
  )IndReq
ON IndReq.ID = RCCP_BASIC.ID;

---VIEW_INV_SAP_INDQER
DROP  VIEW VIEW_INV_SAP_INDQER;
CREATE VIEW VIEW_INV_SAP_INDQER AS
SELECT ID,
    MATERIALID,
    SUM(WEEK_1)  AS WK_1,
    SUM(WEEK_2)  AS WK_2,
    SUM(WEEK_3)  AS WK_3,
    SUM(WEEK_4)  AS WK_4,
    SUM(WEEK_5)  AS WK_5,
    SUM(WEEK_6)  AS WK_6,
    SUM(WEEK_7)  AS WK_7,
    SUM(WEEK_8)  AS WK_8,
    SUM(WEEK_9)  AS WK_9,
    SUM(WEEK_10) AS WK_10,
    SUM(WEEK_11) AS WK_11,
    SUM(WEEK_12) AS WK_12,
    SUM(WEEK_13) AS WK_13
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID AS ID,
      MATERIALID,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw')
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_1,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 1
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_2,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 2
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_3,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 3
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_4,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 4
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_5,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 5
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_6,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 6
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_7,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 7
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_8,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 8
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_9,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 9
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_10,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 10
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_11,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 11
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_12,
      CASE
        WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 12
        THEN PLNMG_PLANNEDQUANTITY
        ELSE 0
      END WEEK_13,
      PLANTID
    FROM
      (SELECT MATERIALID,
        PLANTID,
        PDATU_DELIV_ORDFINISHDATE,
        TO_CHAR(PDATU_DELIV_ORDFINISHDATE,'iw') AS WEEK_NUMBER,
        MEINS_BASEUNITOFMEASURE,
        PLNMG_PLANNEDQUANTITY,
        BEDAEP_REQUIREMENTSTYPE,
        VERSBP_VERSION
      FROM INV_SAP_PP_FRCST_PBIM_PBED
      WHERE VERSBP_VERSION = '55'
      AND PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 91)
      )
    )
  GROUP BY ID,
    MATERIALID;
	
--VIEW_INV_SAP_RCCP_BASIC
DROP VIEW VIEW_INV_SAP_RCCP_BASIC;
CREATE VIEW VIEW_INV_SAP_RCCP_BASIC AS
SELECT ID,
    LAST_REVIEW,
    MATERIAL,
    CATALOG_DASH,
    CATALOG_NO_DASH,
    PLANT,
    MAT_DESC,
    SAFETY_STOCK,
    OH_QTY,
    UNIT,
    UNIT_COST,
    PROD_BU,
    PLANT_SP_MATL_STA,
    VENDOR_KEY,
    MIN_INV,
    TARGET_INV,
    MAX_INV,
    OUT_QTY_W01,
    OUT_QTY_W02,
    OUT_QTY_W03,
    OUT_QTY_W04,
    OUT_QTY_W05,
    OUT_QTY_W06,
    OUT_QTY_W07,
    OUT_QTY_W08,
    OUT_QTY_W09,
    OUT_QTY_W10,
    OUT_QTY_W11,
    OUT_QTY_W12,
    OUT_QTY_W13,
    IN_QTY_W01,
    IN_QTY_W02,
    IN_QTY_W03,
    IN_QTY_W04,
    IN_QTY_W05,
    IN_QTY_W06,
    IN_QTY_W07,
    IN_QTY_W08,
    IN_QTY_W09,
    IN_QTY_W10,
    IN_QTY_W11,
    IN_QTY_W12,
    IN_QTY_W13
  FROM VIEW_INV_SAP_PP_OPT_X;