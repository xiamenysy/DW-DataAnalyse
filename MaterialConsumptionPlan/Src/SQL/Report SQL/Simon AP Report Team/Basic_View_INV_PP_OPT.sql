--Porject Name: Basic Function View
--Author: Huang Moyue 
--Mail: mhuang1@ra.rockwell.com
--Date:09/26/2014
--Summary: Automation Files Center Job Logs and set up process
--VIEW_INV_SAP_PP_OPT_X 

DROP VIEW VIEW_INV_SAP_PP_OPT_X;
DROP TABLE INV_SAP_PP_OPT_X;

CREATE TABLE INV_SAP_PP_OPT_X AS SELECT * FROM VIEW_INV_SAP_PP_OPT_X;
CREATE VIEW VIEW_INV_SAP_PP_OPT_X AS
SELECT PP_BSC_SOG.ID AS ID,
  ITEM_SOG_X.CATALOG_NO_DASH
  ||'_'
  ||PP_BSC_SOG.PLANT              AS TMP_ID,
  PP_BSC_SOG.LAST_REVIEW          AS LAST_REVIEW,
  PP_BSC_SOG.MATERIAL             AS MATERIAL,
  ITEM_SOG_X.CATALOG_DASH         AS CATALOG_DASH,
  ITEM_SOG_X.CATALOG_NO_DASH      AS CATALOG_NO_DASH,
  PP_BSC_SOG.PLANT                AS PLANT,
  PP_BSC_SOG.SALES_ORG            AS SALES_ORG,
  PP_BSC_SOG.PLANTID_DESC         AS PLANTID_DESC,
  PP_BSC_SOG.MAT_DESC             AS MAT_DESC,
  PP_BSC_SOG.SAFETY_STOCK         AS SAFETY_STOCK,
  PP_BSC_SOG.OH_QTY               AS OH_QTY,
  PP_BSC_SOG.UNIT                 AS UNIT,
  PP_BSC_SOG.UNIT_COST            AS UNIT_COST,
  PP_BSC_SOG.OH_QTY_INTRANSIT     AS OH_QTY_INTRANSIT,
  PP_BSC_SOG.PROD_BU              AS PROD_BU,
  PP_BSC_SOG.PROD_FAM             AS PROD_FAM,
  PP_BSC_SOG.PROD_HIERARCHY       AS PROD_HIERARCHY, --Add in 09262014
  PP_BSC_SOG.PROC_TYPE            AS PROC_TYPE,
  PP_BSC_SOG.STRATEGY_GRP         AS STRATEGY_GRP,
  PP_BSC_SOG.MRP_TYPE             AS MRP_TYPE,
  PP_BSC_SOG.PROD_SCHEDULER       AS PROD_SCHEDULER,
  PP_BSC_SOG.PLANT_SP_MATL_STA    AS PLANT_SP_MATL_STA,
  PP_BSC_SOG.VENDOR_KEY           AS VENDOR_KEY,
  PP_BSC_SOG.VENDOR_ITEM          AS VENDOR_ITEM,
  PP_BSC_SOG.MIN_INV              AS MIN_INV,
  PP_BSC_SOG.TARGET_INV           AS TARGET_INV,
  PP_BSC_SOG.MAX_INV              AS MAX_INV,
  PP_BSC_SOG.LOT_SIZE_QTY         AS LOT_SIZE_QTY,
  PP_BSC_SOG.LOT_ROUNDING_VALUE   AS LOT_ROUNDING_VALUE,
  PP_BSC_SOG.LOT_SIZE_DISLS       AS LOT_SIZE_DISLS,
  PP_BSC_SOG.LOT_MIN_BUY          AS LOT_MIN_BUY,
  PP_BSC_SOG.AVG52_USAGE_QTY      AS AVG52_USAGE_QTY,--changed
  PP_BSC_SOG.STDEV52_USAGE        AS STDEV52_USAGE,
  PP_BSC_SOG.AVG26_USAGE_QTY      AS AVG26_USAGE_QTY,
  PP_BSC_SOG.STDEV26_USAGE        AS STDEV26_USAGE,
  PP_BSC_SOG.AVG13_USAGE_QTY      AS AVG13_USAGE_QTY,
  PP_BSC_SOG.STDEV13_USAGE        AS STDEV13_USAGE,
  PP_BSC_SOG.Q1_LINES             AS Q1_LINES,
  PP_BSC_SOG.Q2_LINES             AS Q2_LINES,
  PP_BSC_SOG.Q3_LINES             AS Q3_LINES,
  PP_BSC_SOG.Q4_LINES             AS Q4_LINES,
  PP_BSC_SOG.Q1_FREQ_COUNT        AS Q1_FREQ_COUNT,
  PP_BSC_SOG.Q2_FREQ_COUNT        AS Q2_FREQ_COUNT,
  PP_BSC_SOG.Q3_FREQ_COUNT        AS Q3_FREQ_COUNT,
  PP_BSC_SOG.Q4_FREQ_COUNT        AS Q4_FREQ_COUNT,
  PP_BSC_SOG.EXCHANGE_RATE        AS EXCHANGE_RATE,
  PP_BSC_SOG.LEVEL_TYPE           AS LEVEL_TYPE,
  PP_BSC_SOG.OUT_QTY_W01          AS OUT_QTY_W01,
  PP_BSC_SOG.OUT_QTY_W02          AS OUT_QTY_W02,
  PP_BSC_SOG.OUT_QTY_W03          AS OUT_QTY_W03,
  PP_BSC_SOG.OUT_QTY_W04          AS OUT_QTY_W04,
  PP_BSC_SOG.OUT_QTY_W05          AS OUT_QTY_W05,
  PP_BSC_SOG.OUT_QTY_W06          AS OUT_QTY_W06,
  PP_BSC_SOG.OUT_QTY_W07          AS OUT_QTY_W07,
  PP_BSC_SOG.OUT_QTY_W08          AS OUT_QTY_W08,
  PP_BSC_SOG.OUT_QTY_W09          AS OUT_QTY_W09,
  PP_BSC_SOG.OUT_QTY_W10          AS OUT_QTY_W10,
  PP_BSC_SOG.OUT_QTY_W11          AS OUT_QTY_W11,
  PP_BSC_SOG.OUT_QTY_W12          AS OUT_QTY_W12,
  PP_BSC_SOG.OUT_QTY_W13          AS OUT_QTY_W13,
  PP_BSC_SOG.OUT_QTY_W14          AS OUT_QTY_W14,
  PP_BSC_SOG.OUT_QTY_W15          AS OUT_QTY_W15,
  PP_BSC_SOG.OUT_QTY_W16          AS OUT_QTY_W16,
  PP_BSC_SOG.OUT_QTY_W17          AS OUT_QTY_W17,
  PP_BSC_SOG.OUT_QTY_W18          AS OUT_QTY_W18,
  PP_BSC_SOG.OUT_QTY_W19          AS OUT_QTY_W19,
  PP_BSC_SOG.OUT_QTY_W20          AS OUT_QTY_W20,
  PP_BSC_SOG.OUT_QTY_W21          AS OUT_QTY_W21,
  PP_BSC_SOG.OUT_QTY_W22          AS OUT_QTY_W22,
  PP_BSC_SOG.OUT_QTY_W23          AS OUT_QTY_W23,
  PP_BSC_SOG.OUT_QTY_W24          AS OUT_QTY_W24,
  PP_BSC_SOG.OUT_QTY_W25          AS OUT_QTY_W25,
  PP_BSC_SOG.OUT_QTY_W26          AS OUT_QTY_W26,
  PP_BSC_SOG.IN_QTY_W01           AS IN_QTY_W01,
  PP_BSC_SOG.IN_QTY_W02           AS IN_QTY_W02,
  PP_BSC_SOG.IN_QTY_W03           AS IN_QTY_W03,
  PP_BSC_SOG.IN_QTY_W04           AS IN_QTY_W04,
  PP_BSC_SOG.IN_QTY_W05           AS IN_QTY_W05,
  PP_BSC_SOG.IN_QTY_W06           AS IN_QTY_W06,
  PP_BSC_SOG.IN_QTY_W07           AS IN_QTY_W07,
  PP_BSC_SOG.IN_QTY_W08           AS IN_QTY_W08,
  PP_BSC_SOG.IN_QTY_W09           AS IN_QTY_W09,
  PP_BSC_SOG.IN_QTY_W10           AS IN_QTY_W10,
  PP_BSC_SOG.IN_QTY_W11           AS IN_QTY_W11,
  PP_BSC_SOG.IN_QTY_W12           AS IN_QTY_W12,
  PP_BSC_SOG.IN_QTY_W13           AS IN_QTY_W13,
  PP_BSC_SOG.IN_QTY_W14           AS IN_QTY_W14,
  PP_BSC_SOG.IN_QTY_W15           AS IN_QTY_W15,
  PP_BSC_SOG.IN_QTY_W16           AS IN_QTY_W16,
  PP_BSC_SOG.IN_QTY_W17           AS IN_QTY_W17,
  PP_BSC_SOG.IN_QTY_W18           AS IN_QTY_W18,
  PP_BSC_SOG.IN_QTY_W19           AS IN_QTY_W19,
  PP_BSC_SOG.IN_QTY_W20           AS IN_QTY_W20,
  PP_BSC_SOG.IN_QTY_W21           AS IN_QTY_W21,
  PP_BSC_SOG.IN_QTY_W22           AS IN_QTY_W22,
  PP_BSC_SOG.IN_QTY_W23           AS IN_QTY_W23,
  PP_BSC_SOG.IN_QTY_W24           AS IN_QTY_W24,
  PP_BSC_SOG.IN_QTY_W25           AS IN_QTY_W25,
  PP_BSC_SOG.IN_QTY_W26           AS IN_QTY_W26,
  PP_BSC_SOG.MATERIAL_LEVEL_VALUE AS MATERIAL_LEVEL_VALUE,
  PP_BSC_SOG.MRP_CONTROLLER       AS MRP_CONTROLLER,
  PP_BSC_SOG.MRP_CONTROLLER_KEY   AS MRP_CONTROLLER_KEY,
  PP_BSC_SOG.PURCH_GROUP          AS PURCH_GROUP,
  PP_BSC_SOG.PURCH_GROUP_KEY      AS PURCH_GROUP_KEY,
  PP_BSC_SOG.PROD_SCHED_KEY       AS PROD_SCHED_KEY,
  PP_BSC_SOG.RECORDER_POINT       AS RECORDER_POINT,
  PP_BSC_SOG.LEAD_TIME            AS LEAD_TIME,
  PP_BSC_SOG.PDT                  AS PDT,
  PP_BSC_SOG.GRT                  AS GRT,
  PP_BSC_SOG.SALES_ORG_COUNT      AS SALES_ORG_COUNT,--added in 8/7
  PP_BSC_SOG.DIRECT_SHIP_PLANT    AS DIRECT_SHIP_PLANT,
  PP_BSC_SOG.DELIVERY_PLANT       AS DELIVERY_PLANT,
  PP_BSC_SOG.DMI_MANAGED          AS DMI_MANAGED,
  PP_BSC_SOG.CC_ABC               AS ABC,
  PP_BSC_SOG.AVG_MONTHLY_DEM      AS AVG_MONTHLY_DEM,
  PP_BSC_SOG.STDEV_MONTHLY_DEM    AS STDEV_MONTHLY_DEM,--added in 8/7
  ITEM_SOG_X.DIST_CHL             AS DIST_CHL,
  ITEM_SOG_X.D_CHAIN_BLK          AS D_CHAIN_BLK,
  PP_BSC_SOG.ISSUE_UOM_NUMERATOR  AS ISSUE_UOM_NUMERATOR,
  PP_BSC_SOG.PO_UOM_NUMERATOR     AS PO_UOM_NUMERATOR,
  PP_BSC_SOG.MATL_TYPE            AS MATL_TYPE,
  ITEM_SOG_X.CURRENT_SERIES       AS CURRENT_SERIES,
  PP_BSC_SOG.ULTIMATE_SOURCE      AS ULTIMATE_SOURCE
FROM
  (SELECT PP_BASIC.ID,
    PP_BASIC.MATERIAL
    ||'_'
    ||PLANT_SOG.SALES_ORG AS SG_ID,
    PP_BASIC.LAST_REVIEW,
    PP_BASIC.MATERIAL,
    PP_BASIC.PLANT,
    PLANT_SOG.SALES_ORG,
    PLANT_SOG.PLANTID_DESC,
    PP_BASIC.MAT_DESC,
    PP_BASIC.SAFETY_STOCK,
    PP_BASIC.OH_QTY,
    PP_BASIC.UNIT,
    PP_BASIC.UNIT_COST,
    PP_BASIC.OH_QTY_INTRANSIT,
    PP_BASIC.PROD_BU,
    PP_BASIC.PROD_FAM,
    PP_BASIC.PROD_HIERARCHY, --Add in 09262014
    PP_BASIC.PROC_TYPE,
    PP_BASIC.STRATEGY_GRP,
    PP_BASIC.MRP_TYPE,
    PP_BASIC.PROD_SCHEDULER,
    PP_BASIC.PLANT_SP_MATL_STA,
    PP_BASIC.VENDOR_KEY,
    PP_BASIC.VENDOR_ITEM,
    PP_BASIC.MIN_INV,
    PP_BASIC.TARGET_INV,
    PP_BASIC.MAX_INV,
    PP_BASIC.LOT_SIZE_QTY,
    PP_BASIC.LOT_ROUNDING_VALUE,
    PP_BASIC.LOT_SIZE_DISLS,
    PP_BASIC.LOT_MIN_BUY,
    PP_BASIC.AVG52_USAGE_QTY,--changed
    PP_BASIC.STDEV52_USAGE,
    PP_BASIC.AVG26_USAGE_QTY,
    PP_BASIC.STDEV26_USAGE,
    PP_BASIC.AVG13_USAGE_QTY,
    PP_BASIC.STDEV13_USAGE,
    PP_BASIC.Q1_LINES,
    PP_BASIC.Q2_LINES,
    PP_BASIC.Q3_LINES,
    PP_BASIC.Q4_LINES,
    PP_BASIC.Q1_FREQ_COUNT,
    PP_BASIC.Q2_FREQ_COUNT,
    PP_BASIC.Q3_FREQ_COUNT,
    PP_BASIC.Q4_FREQ_COUNT,
    PP_BASIC.EXCHANGE_RATE,
    PP_BASIC.LEVEL_TYPE,
    PP_BASIC.OUT_QTY_W01,
    PP_BASIC.OUT_QTY_W02,
    PP_BASIC.OUT_QTY_W03,
    PP_BASIC.OUT_QTY_W04,
    PP_BASIC.OUT_QTY_W05,
    PP_BASIC.OUT_QTY_W06,
    PP_BASIC.OUT_QTY_W07,
    PP_BASIC.OUT_QTY_W08,
    PP_BASIC.OUT_QTY_W09,
    PP_BASIC.OUT_QTY_W10,
    PP_BASIC.OUT_QTY_W11,
    PP_BASIC.OUT_QTY_W12,
    PP_BASIC.OUT_QTY_W13,
    PP_BASIC.OUT_QTY_W14,
    PP_BASIC.OUT_QTY_W15,
    PP_BASIC.OUT_QTY_W16,
    PP_BASIC.OUT_QTY_W17,
    PP_BASIC.OUT_QTY_W18,
    PP_BASIC.OUT_QTY_W19,
    PP_BASIC.OUT_QTY_W20,
    PP_BASIC.OUT_QTY_W21,
    PP_BASIC.OUT_QTY_W22,
    PP_BASIC.OUT_QTY_W23,
    PP_BASIC.OUT_QTY_W24,
    PP_BASIC.OUT_QTY_W25,
    PP_BASIC.OUT_QTY_W26,
    PP_BASIC.IN_QTY_W01,
    PP_BASIC.IN_QTY_W02,
    PP_BASIC.IN_QTY_W03,
    PP_BASIC.IN_QTY_W04,
    PP_BASIC.IN_QTY_W05,
    PP_BASIC.IN_QTY_W06,
    PP_BASIC.IN_QTY_W07,
    PP_BASIC.IN_QTY_W08,
    PP_BASIC.IN_QTY_W09,
    PP_BASIC.IN_QTY_W10,
    PP_BASIC.IN_QTY_W11,
    PP_BASIC.IN_QTY_W12,
    PP_BASIC.IN_QTY_W13,
    PP_BASIC.IN_QTY_W14,
    PP_BASIC.IN_QTY_W15,
    PP_BASIC.IN_QTY_W16,
    PP_BASIC.IN_QTY_W17,
    PP_BASIC.IN_QTY_W18,
    PP_BASIC.IN_QTY_W19,
    PP_BASIC.IN_QTY_W20,
    PP_BASIC.IN_QTY_W21,
    PP_BASIC.IN_QTY_W22,
    PP_BASIC.IN_QTY_W23,
    PP_BASIC.IN_QTY_W24,
    PP_BASIC.IN_QTY_W25,
    PP_BASIC.IN_QTY_W26,
    PP_BASIC.MATERIAL_LEVEL_VALUE,
    PP_BASIC.MRP_CONTROLLER,
    PP_BASIC.MRP_CONTROLLER_KEY,
    PP_BASIC.PURCH_GROUP,
    PP_BASIC.PURCH_GROUP_KEY,
    PP_BASIC.PROD_SCHED_KEY,
    PP_BASIC.RECORDER_POINT,
    PP_BASIC.LEAD_TIME,
    PP_BASIC.PDT,
    PP_BASIC.GRT,
    PP_BASIC.SALES_ORG_COUNT,--added in 8/7
    PP_BASIC.DIRECT_SHIP_PLANT,
    PP_BASIC.DELIVERY_PLANT,
    PP_BASIC.DMI_MANAGED,
    PP_BASIC.CC_ABC,
    PP_BASIC.AVG_MONTHLY_DEM,
    PP_BASIC.STDEV_MONTHLY_DEM,--added in 8/7
    PP_BASIC.ISSUE_UOM_NUMERATOR,
    PP_BASIC.PO_UOM_NUMERATOR,
    PP_BASIC.MATL_TYPE,
    PP_BASIC.ULTIMATE_SOURCE
  FROM
    (SELECT PP_BAS.ID,
      PP_BAS.LAST_REVIEW,
      PP_BAS.MATERIAL,
      PP_BAS.PLANT,
      PP_BAS.MAT_DESC,
      PP_BAS.SAFETY_STOCK,
      PP_BAS.OH_QTY,
      PP_BAS.UNIT,
      PP_BAS.UNIT_COST,
      PP_BAS.OH_QTY_INTRANSIT,
      PP_BAS.PROD_BU,
      PP_BAS.PROD_FAM,
      PP_BAS.PROD_HIERARCHY, --Add in 09262014
      PP_BAS.PROC_TYPE,
      PP_BAS.STRATEGY_GRP,
      PP_BAS.MRP_TYPE,
      PP_BAS.PROD_SCHEDULER,
      PP_BAS.PLANT_SP_MATL_STA,
      PP_BAS.VENDOR_KEY,
      PP_BAS.VENDOR_ITEM,
      --Method changed in 09262014      
      GREATEST(CEIL(PP_BAS.SAFETY_STOCK))                                                                     AS MIN_INV,
      CEIL(1.08*CEIL(PP_BAS.SAFETY_STOCK) + 0.5*GREATEST(CEIL(NVL(FC_AVG_WK.FC_AVG_WEEK,0)),CEIL(PP_BAS.LOT_ROUNDING_VALUE),CEIL(PP_BAS.LOT_MIN_BUY)))                            AS TARGET_INV,
      CEIL(1.08*CEIL(PP_BAS.SAFETY_STOCK) + GREATEST(CEIL(PP_BAS.LEAD_TIME)*(CEIL(NVL(FC_AVG_WK.FC_AVG_WEEK,0))/7),CEIL(PP_BAS.LOT_ROUNDING_VALUE),CEIL(PP_BAS.LOT_MIN_BUY))) AS MAX_INV,
      PP_BAS.LOT_SIZE_QTY,
      PP_BAS.LOT_ROUNDING_VALUE,
      PP_BAS.LOT_SIZE_DISLS,
      PP_BAS.LOT_MIN_BUY,
      PP_BAS.AVG52_USAGE_QTY,--changed
      PP_BAS.STDEV52_USAGE,
      PP_BAS.AVG26_USAGE_QTY,
      PP_BAS.STDEV26_USAGE,
      PP_BAS.AVG13_USAGE_QTY,
      PP_BAS.STDEV13_USAGE,
      PP_BAS.Q1_LINES,
      PP_BAS.Q2_LINES,
      PP_BAS.Q3_LINES,
      PP_BAS.Q4_LINES,
      PP_BAS.Q1_FREQ_COUNT,
      PP_BAS.Q2_FREQ_COUNT,
      PP_BAS.Q3_FREQ_COUNT,
      PP_BAS.Q4_FREQ_COUNT,
      PP_BAS.EXCHANGE_RATE,
      PP_BAS.LEVEL_TYPE,
      PP_BAS.OUT_QTY_W01,
      PP_BAS.OUT_QTY_W02,
      PP_BAS.OUT_QTY_W03,
      PP_BAS.OUT_QTY_W04,
      PP_BAS.OUT_QTY_W05,
      PP_BAS.OUT_QTY_W06,
      PP_BAS.OUT_QTY_W07,
      PP_BAS.OUT_QTY_W08,
      PP_BAS.OUT_QTY_W09,
      PP_BAS.OUT_QTY_W10,
      PP_BAS.OUT_QTY_W11,
      PP_BAS.OUT_QTY_W12,
      PP_BAS.OUT_QTY_W13,
      PP_BAS.OUT_QTY_W14,
      PP_BAS.OUT_QTY_W15,
      PP_BAS.OUT_QTY_W16,
      PP_BAS.OUT_QTY_W17,
      PP_BAS.OUT_QTY_W18,
      PP_BAS.OUT_QTY_W19,
      PP_BAS.OUT_QTY_W20,
      PP_BAS.OUT_QTY_W21,
      PP_BAS.OUT_QTY_W22,
      PP_BAS.OUT_QTY_W23,
      PP_BAS.OUT_QTY_W24,
      PP_BAS.OUT_QTY_W25,
      PP_BAS.OUT_QTY_W26,
      PP_BAS.IN_QTY_W01,
      PP_BAS.IN_QTY_W02,
      PP_BAS.IN_QTY_W03,
      PP_BAS.IN_QTY_W04,
      PP_BAS.IN_QTY_W05,
      PP_BAS.IN_QTY_W06,
      PP_BAS.IN_QTY_W07,
      PP_BAS.IN_QTY_W08,
      PP_BAS.IN_QTY_W09,
      PP_BAS.IN_QTY_W10,
      PP_BAS.IN_QTY_W11,
      PP_BAS.IN_QTY_W12,
      PP_BAS.IN_QTY_W13,
      PP_BAS.IN_QTY_W14,
      PP_BAS.IN_QTY_W15,
      PP_BAS.IN_QTY_W16,
      PP_BAS.IN_QTY_W17,
      PP_BAS.IN_QTY_W18,
      PP_BAS.IN_QTY_W19,
      PP_BAS.IN_QTY_W20,
      PP_BAS.IN_QTY_W21,
      PP_BAS.IN_QTY_W22,
      PP_BAS.IN_QTY_W23,
      PP_BAS.IN_QTY_W24,
      PP_BAS.IN_QTY_W25,
      PP_BAS.IN_QTY_W26,
      PP_BAS.MATERIAL_LEVEL_VALUE,
      PP_BAS.MRP_CONTROLLER,
      PP_BAS.MRP_CONTROLLER_KEY,
      PP_BAS.PURCH_GROUP,
      PP_BAS.PURCH_GROUP_KEY,
      PP_BAS.PROD_SCHED_KEY,
      PP_BAS.RECORDER_POINT,
      PP_BAS.LEAD_TIME,
      PP_BAS.PDT,
      PP_BAS.GRT,
      PP_BAS.SALES_ORG_COUNT,--added in 8/7
      PP_BAS.DIRECT_SHIP_PLANT,
      PP_BAS.DELIVERY_PLANT,
      PP_BAS.DMI_MANAGED,
      PP_BAS.CC_ABC,
      PP_BAS.AVG_MONTHLY_DEM,
      PP_BAS.STDEV_MONTHLY_DEM,--added in 8/7
      PP_BAS.ISSUE_UOM_NUMERATOR,
      PP_BAS.PO_UOM_NUMERATOR,
      PP_BAS.MATL_TYPE,
      PP_BAS.ULTIMATE_SOURCE
    FROM
      (SELECT MATERIALID
        ||'_'
        ||(PLANTID - 1) AS ID,
        LAST_REVIEW,
        MATERIALID    AS MATERIAL,
        (PLANTID - 1) AS PLANT,
        MAT_DESC,
        SAFETY_STK AS SAFETY_STOCK,
        OH_QTY,
        UNIT_COST,
        OH_QTY_INTRANSIT,
        SUBSTR(PROD_BU,0,3) AS PROD_BU,
        PROD_FAM,
        PROC_TYPE,
        PROD_HIERARCHY, --Add in 09262014
        STRATEGY_GRP,
        MRP_TYPE,
        PROD_SCHEDULER,
        SP_MATL_STAT_MMSTA AS PLANT_SP_MATL_STA,
        SPC_PROC_KEY_SOBSL AS VENDOR_KEY,
        MATERIALID
        ||'_'
        ||SUBSTR(VENDOR_NAME,0,4) AS VENDOR_ITEM,
        LOT_SIZE_QTY,
        LOT_ROUNDING_VALUE,
        LOT_SIZE_DISLS,
        LOT_MIN_BUY,
        AVG52_USAGE_QTY,--changed
        STDEV52_USAGE,
        AVG26_USAGE_QTY,
        STDEV26_USAGE,
        AVG13_USAGE_QTY,
        STDEV13_USAGE,
        Q1_LINES,
        Q2_LINES,
        Q3_LINES,
        Q4_LINES,
        Q1_FREQ_COUNT,
        Q2_FREQ_COUNT,
        Q3_FREQ_COUNT,
        Q4_FREQ_COUNT,
        EXCHANGE_RATE,
        LEVEL_TYPE,
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
        OUT_QTY_W14,
        OUT_QTY_W15,
        OUT_QTY_W16,
        OUT_QTY_W17,
        OUT_QTY_W18,
        OUT_QTY_W19,
        OUT_QTY_W20,
        OUT_QTY_W21,
        OUT_QTY_W22,
        OUT_QTY_W23,
        OUT_QTY_W24,
        OUT_QTY_W25,
        OUT_QTY_W26,
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
        IN_QTY_W13,
        IN_QTY_W14,
        IN_QTY_W15,
        IN_QTY_W16,
        IN_QTY_W17,
        IN_QTY_W18,
        IN_QTY_W19,
        IN_QTY_W20,
        IN_QTY_W21,
        IN_QTY_W22,
        IN_QTY_W23,
        IN_QTY_W24,
        IN_QTY_W25,
        IN_QTY_W26,
        MATERIAL_LEVEL_VALUE,
        MRP_CONTROLLER,
        MRP_CONTROLLER_DISPO AS MRP_CONTROLLER_KEY,
        PURCH_GROUP,
        PURCH_GROUP_EKGRP   AS PURCH_GROUP_KEY,
        PROD_SCHED_FEVOR    AS PROD_SCHED_KEY,
        REORDER_PT          AS RECORDER_POINT,
        CEIL(1.4*GRT + PDT) AS LEAD_TIME, --Lead Time Change!!
        PDT                 AS PDT,
        GRT                 AS GRT,
        MEINS_ISSUE_UOM     AS UNIT,
        SALES_ORG_COUNT,--added in 8/7
        DIRECT_SHIP_PLANT,
        DELIVERY_PLANT,
        DMI_MANAGED,
        CC_ABC,
        AVG_MONTHLY_DEM,
        STDEV_MONTHLY_DEM,--added in 8/7
        ISSUE_UOM_NUMERATOR,
        PO_UOM_NUMERATOR,
        MATL_TYPE_MTART AS MATL_TYPE,
        ULTIMATE_SOURCE
      FROM INV_SAP_PP_OPTIMIZATION
      )PP_BAS
    LEFT JOIN
      (SELECT MATERIALID
        ||'_'
        ||PLANTID                           AS ID,
        CEIL(SUM(PLNMG_PLANNEDQUANTITY)/18) AS FC_AVG_WEEK
      FROM INV_SAP_PP_FRCST_PBIM_PBED
      WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate + 56) AND TO_CHAR(sysdate + 182))
      AND VERSBP_VERSION = '00'
      GROUP BY PLANTID,
        MATERIALID
      )FC_AVG_WK
    ON FC_AVG_WK.ID = PP_BAS.ID
    )PP_BASIC
  LEFT JOIN
    ( SELECT PLANTID, PLANTID_DESC, SALES_ORG FROM INV_SAP_PP_PLANT_SAOG
    )PLANT_SOG
  ON PLANT_SOG.PLANTID = PP_BASIC.PLANT
  )PP_BSC_SOG
LEFT JOIN
  (SELECT ID,
    SOG_ID,
    SALES_ORG,
    PLANT,
    MATERIAL,
    CATALOG_DASH,
    CATALOG_NO_DASH,
    DIST_CHL,
    D_CHAIN_BLK,
    CURRENT_SERIES
  FROM INV_SAP_ITEM_SOG_X
  )ITEM_SOG_X
ON ITEM_SOG_X.SOG_ID = PP_BSC_SOG.SG_ID;


