--DATE:6/26/2014
--AUTHOR: HUANG MO YUE
--DMT_FRD_REPORT

CREATE TABLE INV_SAP_DMT_FRD 
(
  ASOFDATE DATE 
, TYPE VARCHAR2(200) 
, MATERIAL VARCHAR2(200) 
, PLANT VARCHAR2(200) 
, UNIT VARCHAR2(20) 
, MONTH_1 NUMBER 
, MONTH_2 NUMBER 
, MONTH_3 NUMBER 
, MONTH_4 NUMBER 
, MONTH_5 NUMBER 
, MONTH_6 NUMBER 
, MONTH_7 NUMBER 
, MONTH_8 NUMBER 
, MONTH_9 NUMBER 
, MONTH_10 NUMBER 
, MONTH_11 NUMBER 
, MONTH_12 NUMBER 
, MONTH_13 NUMBER 
, MONTH_14 NUMBER 
, MONTH_15 NUMBER 
, MONTH_16 NUMBER 
, MONTH_17 NUMBER 
, MONTH_18 NUMBER 
, MONTH_19 NUMBER 
, MONTH_20 NUMBER 
, MONTH_21 NUMBER 
, MONTH_22 NUMBER 
, MONTH_23 NUMBER 
, MONTH_24 NUMBER 
, MONTH_25 NUMBER 
, MONTH_26 NUMBER 
, MONTH_27 NUMBER 
, MONTH_28 NUMBER 
, MONTH_29 NUMBER
, MONTH_30 NUMBER 
, MONTH_31 NUMBER 
, MONTH_32 NUMBER 
, MONTH_33 NUMBER 
, MONTH_34 NUMBER 
, MONTH_35 NUMBER 
, MONTH_36 NUMBER 
, MONTH_37 NUMBER 
, MONTH_38 NUMBER 
, MONTH_39 NUMBER
, MONTH_40 NUMBER 
, MONTH_41 NUMBER 
, MONTH_42 NUMBER 
, MONTH_43 NUMBER 
, MONTH_44 NUMBER 
, MONTH_45 NUMBER 
, MONTH_46 NUMBER 
, MONTH_47 NUMBER 
, MONTH_48 NUMBER 
, MONTH_49 NUMBER
, MONTH_50 NUMBER 
, MONTH_51 NUMBER 
, MONTH_52 NUMBER 
, MONTH_53 NUMBER 
, MONTH_54 NUMBER 
);



SELECT COUNT(*) FROM INV_SAP_DMT_FRD; 
TRUNCATE TABLE INV_SAP_DMT_FRD;



--DMT_FRD_REPORT
DROP VIEW VIEW_INV_SAP_DMT_FRD;
SELECT * FROM VIEW_INV_SAP_DMT_FRD;
CREATE VIEW VIEW_INV_SAP_DMT_FRD AS 
SELECT DMT_PRD.TYPE,
  DMT_PRD.MATERIAL,
  DMT_PRD.PLANT,
  PP_BASIC.CATALOG_DASH,
  PP_BASIC.MAT_DESC,
  PP_BASIC.SAFETY_STOCK,
  PP_BASIC.PROD_BU,
  PP_BASIC.PROD_FAM,
  PP_BASIC.PROD_HIERARCHY,
  PP_BASIC.PROC_TYPE,
  PP_BASIC.STRATEGY_GRP,
  PP_BASIC.MATL_TYPE,
  PP_BASIC.VENDOR_KEY,
  CASE WHEN DMT_PRD.TYPE = 'RA Historical Demand'
  THEN CEIL((DMT_PRD.MONTH_34+DMT_PRD.MONTH_35+DMT_PRD.MONTH_36)/3)
  ELSE 0
  END AVG_3MONTHS,
  DMT_PRD.UNIT,
  DMT_PRD.MONTH_1,
  DMT_PRD.MONTH_2,
  DMT_PRD.MONTH_3,
  DMT_PRD.MONTH_4,
  DMT_PRD.MONTH_5,
  DMT_PRD.MONTH_6,
  DMT_PRD.MONTH_7,
  DMT_PRD.MONTH_8,
  DMT_PRD.MONTH_9,
  DMT_PRD.MONTH_10,
  DMT_PRD.MONTH_11,
  DMT_PRD.MONTH_12,
  DMT_PRD.MONTH_13,
  DMT_PRD.MONTH_14,
  DMT_PRD.MONTH_15,
  DMT_PRD.MONTH_16,
  DMT_PRD.MONTH_17,
  DMT_PRD.MONTH_18,
  DMT_PRD.MONTH_19,
  DMT_PRD.MONTH_20,
  DMT_PRD.MONTH_21,
  DMT_PRD.MONTH_22,
  DMT_PRD.MONTH_23,
  DMT_PRD.MONTH_24,
  DMT_PRD.MONTH_25,
  DMT_PRD.MONTH_26,
  DMT_PRD.MONTH_27,
  DMT_PRD.MONTH_28,
  DMT_PRD.MONTH_29,
  DMT_PRD.MONTH_30,
  DMT_PRD.MONTH_31,
  DMT_PRD.MONTH_32,
  DMT_PRD.MONTH_33,
  DMT_PRD.MONTH_34,
  DMT_PRD.MONTH_35,
  DMT_PRD.MONTH_36,
  DMT_PRD.MONTH_37,
  DMT_PRD.MONTH_38,
  DMT_PRD.MONTH_39,
  DMT_PRD.MONTH_40,
  DMT_PRD.MONTH_41,
  DMT_PRD.MONTH_42,
  DMT_PRD.MONTH_43,
  DMT_PRD.MONTH_44,
  DMT_PRD.MONTH_45,
  DMT_PRD.MONTH_46,
  DMT_PRD.MONTH_47,
  DMT_PRD.MONTH_48,
  DMT_PRD.MONTH_49,
  DMT_PRD.MONTH_50,
  DMT_PRD.MONTH_51,
  DMT_PRD.MONTH_52,
  DMT_PRD.MONTH_53,
  DMT_PRD.MONTH_54
FROM
  (SELECT MATERIAL
    ||'_'
    ||PLANT AS ID,
    TYPE,
    MATERIAL,
    PLANT,
    UNIT,
    MONTH_1,
    MONTH_2,
    MONTH_3,
    MONTH_4,
    MONTH_5,
    MONTH_6,
    MONTH_7,
    MONTH_8,
    MONTH_9,
    MONTH_10,
    MONTH_11,
    MONTH_12,
    MONTH_13,
    MONTH_14,
    MONTH_15,
    MONTH_16,
    MONTH_17,
    MONTH_18,
    MONTH_19,
    MONTH_20,
    MONTH_21,
    MONTH_22,
    MONTH_23,
    MONTH_24,
    MONTH_25,
    MONTH_26,
    MONTH_27,
    MONTH_28,
    MONTH_29,
    MONTH_30,
    MONTH_31,
    MONTH_32,
    MONTH_33,
    MONTH_34,
    MONTH_35,
    MONTH_36,
    MONTH_37,
    MONTH_38,
    MONTH_39,
    MONTH_40,
    MONTH_41,
    MONTH_42,
    MONTH_43,
    MONTH_44,
    MONTH_45,
    MONTH_46,
    MONTH_47,
    MONTH_48,
    MONTH_49,
    MONTH_50,
    MONTH_51,
    MONTH_52,
    MONTH_53,
    MONTH_54
  FROM INV_SAP_DMT_FRD
  )DMT_PRD
LEFT JOIN
  (SELECT ID,
    CATALOG_DASH,
    MAT_DESC,
    SAFETY_STOCK,
    PROD_BU,
    PROD_FAM,
    PROD_HIERARCHY,
    PROC_TYPE,
    STRATEGY_GRP,
    MATL_TYPE,
    VENDOR_KEY
  FROM VIEW_INV_SAP_PP_OPT_X
  )PP_BASIC
ON DMT_PRD.ID = PP_BASIC.ID;






