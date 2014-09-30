--Porject Name: Automation Files Center
--Author: Huang Moyue 
--Mail: mhuang1@ra.rockwell.com
--Date:07/08/2014
--Summary: Automation Files Center Job Logs and set up process
--Version: 0.5

--These view will be converted to table when all update basic table done every day
3. Oracle View Setup		
	3.1 Add Sales Org
		DROP VIEW VIEW_INV_SAP_ITEM_SOG_X;
		DROP TABLE INV_SAP_ITEM_SOG_X;
		SELECT * FROM INV_SAP_ITEM_SOG_X;
		CREATE TABLE INV_SAP_ITEM_SOG_X AS SELECT * FROM VIEW_INV_SAP_ITEM_SOG_X;
		CREATE VIEW VIEW_INV_SAP_ITEM_SOG_X AS
			SELECT 
			DISTINCT
			ISPM.ID           AS ID,
			ISPM.SOG_ID            AS SOG_ID,
			ISPM.SALES_ORG         AS SALES_ORG,
			ISPM.DIRECT_SHIP_PLANT AS PLANT,
			ISPM.MATERIALID        AS MATERIAL,
			ISMC.CATALOG_STRING1   AS CATALOG_DASH,
			ISMC.CATALOG_STRING2   AS CATALOG_NO_DASH,
			ISPM.DIST_CHL          AS DIST_CHL,
			ISPM.CURRENT_SERIES    AS CURRENT_SERIES,
			ISPM.D_CHAIN_BLK    AS D_CHAIN_BLK
			FROM
			(SELECT DISTINCT MATERIALID
			  ||'_'
			  ||SALES_ORG AS SOG_ID,
			  MATERIALID
			  ||'_'
			  ||DIRECT_SHIP_PLANT AS ID,
			  MATERIALID,
			  SALES_ORG,
			  D_CHAIN_BLK,
			  DIST_CHL,
			  DIRECT_SHIP_PLANT,
			  CURRENT_SERIES
			FROM INV_SAP_PP_MVKE
			WHERE CURRENT_SERIES = 'X'
			)ISPM
			LEFT JOIN
			(SELECT CATALOG_STRING1,
			  CATALOG_STRING2,
			  MATERIALID
			FROM INV_SAP_NODASH_MAT_CATA 
			)ISMC
			ON ISPM.MATERIALID = ISMC.MATERIALID;
		
	3.2 VIEW_INV_SAP_PP_OPT_X with x current series
  
    SELECT DISTINCT MATERIAL,CATALOG_DASH,MATL_TYPE  FROM INV_SAP_PP_OPT_X;
		DROP VIEW VIEW_INV_SAP_PP_OPT_X;
		DROP TABLE INV_SAP_PP_OPT_X;
		SELECT * FROM INV_SAP_PP_OPT_X;
		CREATE TABLE INV_SAP_PP_OPT_X AS SELECT * FROM VIEW_INV_SAP_PP_OPT_X WHERE PLANT = '5040' AND MATERIAL = '199-DR1 B';   
		CREATE VIEW VIEW_INV_SAP_PP_OPT_X AS
			SELECT PP_BSC_SOG.ID              AS ID,
        ITEM_SOG_X.CATALOG_NO_DASH||'_'||PP_BSC_SOG.PLANT     AS TMP_ID,
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
       			  PP_BSC_SOG.AVG52_USAGE_QTY AS AVG52_USAGE_QTY,--changed
		          PP_BSC_SOG.STDEV52_USAGE AS STDEV52_USAGE,
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
        PP_BSC_SOG.SALES_ORG_COUNT AS SALES_ORG_COUNT,--added in 8/7
        PP_BSC_SOG.DIRECT_SHIP_PLANT AS DIRECT_SHIP_PLANT,
        PP_BSC_SOG.DELIVERY_PLANT AS DELIVERY_PLANT,
        PP_BSC_SOG.DMI_MANAGED AS DMI_MANAGED,
        PP_BSC_SOG.CC_ABC AS ABC,
        PP_BSC_SOG.AVG_MONTHLY_DEM AS AVG_MONTHLY_DEM,
        PP_BSC_SOG.STDEV_MONTHLY_DEM AS STDEV_MONTHLY_DEM,--added in 8/7
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
						  STRATEGY_GRP,
						  MRP_TYPE,
						  PROD_SCHEDULER,
						  SP_MATL_STAT_MMSTA AS PLANT_SP_MATL_STA,
						  SPC_PROC_KEY_SOBSL AS VENDOR_KEY,
						  MATERIALID
						  ||'_'
						  ||SUBSTR(VENDOR_NAME,0,4)           AS VENDOR_ITEM,
              CASE WHEN NVL(SAFETY_STK,0) = 0 
              THEN 0
              ELSE NVL(SAFETY_STK,0)
              END MIN_INV,
              CASE WHEN NVL(SAFETY_STK,0) = 0 
              THEN 0
              ELSE CEIL(NVL(SAFETY_STK,0) + 0.5*LOT_SIZE_QTY)
              END TARGET_INV,
              CASE WHEN NVL(SAFETY_STK,0) = 0 
              THEN 0
              ELSE CEIL(NVL(SAFETY_STK,0) + 1.2*LOT_SIZE_QTY)
              END MAX_INV,           
						  --(SAFETY_STK)                        AS MIN_INV,
						  --CEIL(SAFETY_STK + 0.5*LOT_SIZE_QTY) AS TARGET_INV,
						  --CEIL(SAFETY_STK + 1.2*LOT_SIZE_QTY) AS MAX_INV,
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
						FROM INV_SAP_PP_OPTIMIZATION --WHERE MATERIALID = '100-C09KJ400 A' AND PLANTID = '5200'
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
          
          


	3.3 VIEW_INV_SAP_FC55_STATS VERSBP_VERSION = '55'
		DROP VIEW VIEW_INV_SAP_FC55_STATS;
		SELECT * FROM VIEW_INV_SAP_FC55_STATS;
		CREATE VIEW VIEW_INV_SAP_FC55_STATS AS
		SELECT ITEM_BASIC_PP_FC13.ID,
		  ITEM_BASIC_PP_FC13.MATERIAL,
		  ITEM_BASIC_PP_FC13.CATALOG_DASH,
		  ITEM_BASIC_PP_FC13.CATALOG_NO_DASH,
		  ITEM_BASIC_PP_FC13.PLANT,
		  ITEM_BASIC_PP_FC13.MAT_DESC,
		  ITEM_BASIC_PP_FC13.SAFETY_STOCK,
		  ITEM_BASIC_PP_FC13.OH_QTY,
		  ITEM_BASIC_PP_FC13.UNIT,
		  ITEM_BASIC_PP_FC13.PROC_TYPE,
		  ITEM_BASIC_PP_FC13.UNIT_COST,
		  ITEM_BASIC_PP_FC13.PROD_BU,
		  ITEM_BASIC_PP_FC13.STRATEGY_GRP,
		  ITEM_BASIC_PP_FC13.MRP_TYPE,
		  ITEM_BASIC_PP_FC13.MRP_CONTROLLER,
		  ITEM_BASIC_PP_FC13.PURCH_GROUP,
		  ITEM_BASIC_PP_FC13.VENDOR_ITEM,
		  ITEM_BASIC_PP_FC13.MATL_TYPE,
		  ITEM_BASIC_PP_FC13.MIN_INV,
		  ITEM_BASIC_PP_FC13.TARGET_INV,
		  ITEM_BASIC_PP_FC13.MAX_INV,
		  ITEM_BASIC_PP_FC13.LEAD_TIME,
		  ITEM_BASIC_PP_FC13.AVG26_USAGE_QTY,
		  ITEM_BASIC_PP_FC13.AVG13_USAGE_QTY,
		  ITEM_BASIC_PP_FC13.FC_AVG13_WEEK_QTY,
		  FC_AVG26_WEEK.FC_AVG26_WEEK_QTY
		FROM
		  (SELECT ITEM_BASIC_PP.ID,
			ITEM_BASIC_PP.MATERIAL,
			ITEM_BASIC_PP.CATALOG_DASH,
			ITEM_BASIC_PP.CATALOG_NO_DASH,
			ITEM_BASIC_PP.PLANT,
			ITEM_BASIC_PP.MAT_DESC,
			ITEM_BASIC_PP.SAFETY_STOCK,
			ITEM_BASIC_PP.UNIT,
			ITEM_BASIC_PP.OH_QTY,
			ITEM_BASIC_PP.PROC_TYPE,
			ITEM_BASIC_PP.UNIT_COST,
			ITEM_BASIC_PP.PROD_BU,
			ITEM_BASIC_PP.STRATEGY_GRP,
			ITEM_BASIC_PP.MRP_TYPE,
			ITEM_BASIC_PP.MRP_CONTROLLER,
			ITEM_BASIC_PP.PURCH_GROUP,
			ITEM_BASIC_PP.VENDOR_ITEM,
			ITEM_BASIC_PP.MATL_TYPE,
			ITEM_BASIC_PP.MIN_INV,
			ITEM_BASIC_PP.TARGET_INV,
			ITEM_BASIC_PP.MAX_INV,
			ITEM_BASIC_PP.LEAD_TIME,
			ITEM_BASIC_PP.AVG26_USAGE_QTY,
			ITEM_BASIC_PP.AVG13_USAGE_QTY,
			FC_AVG13_WEEK.FC_AVG13_WEEK_QTY
		  FROM
			(SELECT ID,
			  MATERIAL,
			  CATALOG_DASH,
			  CATALOG_NO_DASH,
			  PLANT,
			  MAT_DESC,
			  SAFETY_STOCK,
			  UNIT,
			  PROC_TYPE,
			  UNIT_COST,
			  PROD_BU,
			  STRATEGY_GRP,
			  MRP_TYPE,
			  MRP_CONTROLLER,
			  PURCH_GROUP,
			  VENDOR_ITEM,
			  OH_QTY,
			  MATL_TYPE,
			  MIN_INV,
			  TARGET_INV,
			  MAX_INV,
			  LEAD_TIME,
			  AVG26_USAGE_QTY,
			  AVG13_USAGE_QTY
			FROM INV_SAP_PP_OPT_X
			)ITEM_BASIC_PP
		  LEFT JOIN
			(SELECT MATERIALID
			  ||'_'
			  ||PLANTID                           AS ID,
			  MATERIALID                          AS MATERIALID,
			  PLANTID                             AS PLANTID,
			  CEIL(SUM(PLNMG_PLANNEDQUANTITY)/13) AS FC_AVG13_WEEK_QTY
			FROM INV_SAP_PP_FRCST_PBIM_PBED
			WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 91))
			AND VERSBP_VERSION = '55'
			GROUP BY MATERIALID,
			  PLANTID
			)FC_AVG13_WEEK
		  ON FC_AVG13_WEEK.ID = ITEM_BASIC_PP.ID
		  )ITEM_BASIC_PP_FC13
		LEFT JOIN
		  (SELECT MATERIALID
			||'_'
			||PLANTID                           AS ID,
			MATERIALID                          AS MATERIALID,
			PLANTID                             AS PLANTID,
			CEIL(SUM(PLNMG_PLANNEDQUANTITY)/26) AS FC_AVG26_WEEK_QTY
		  FROM INV_SAP_PP_FRCST_PBIM_PBED
		  WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
		  AND VERSBP_VERSION = '55'
		  GROUP BY MATERIALID,
			PLANTID
		  )FC_AVG26_WEEK
		ON ITEM_BASIC_PP_FC13.ID = FC_AVG26_WEEK.ID; 

    3.4 VIEW_INV_SAP_FC00_STATS VERSBP_VERSION = '00'
		DROP VIEW VIEW_INV_SAP_FC00_STATS;
		SELECT * FROM VIEW_INV_SAP_FC00_STATS;
		CREATE VIEW VIEW_INV_SAP_FC00_STATS AS
		SELECT ITEM_BASIC_PP_FC13.ID,
		  ITEM_BASIC_PP_FC13.MATERIAL,
		  ITEM_BASIC_PP_FC13.CATALOG_DASH,
		  ITEM_BASIC_PP_FC13.CATALOG_NO_DASH,
		  ITEM_BASIC_PP_FC13.PLANT,
		  ITEM_BASIC_PP_FC13.MAT_DESC,
		  ITEM_BASIC_PP_FC13.SAFETY_STOCK,
		  ITEM_BASIC_PP_FC13.OH_QTY,
		  ITEM_BASIC_PP_FC13.UNIT,
		  ITEM_BASIC_PP_FC13.PROC_TYPE,
		  ITEM_BASIC_PP_FC13.UNIT_COST,
		  ITEM_BASIC_PP_FC13.PROD_BU,
		  ITEM_BASIC_PP_FC13.STRATEGY_GRP,
		  ITEM_BASIC_PP_FC13.MRP_TYPE,
		  ITEM_BASIC_PP_FC13.MRP_CONTROLLER,
		  ITEM_BASIC_PP_FC13.PURCH_GROUP,
		  ITEM_BASIC_PP_FC13.VENDOR_ITEM,
		  ITEM_BASIC_PP_FC13.MATL_TYPE,
		  ITEM_BASIC_PP_FC13.MIN_INV,
		  ITEM_BASIC_PP_FC13.TARGET_INV,
		  ITEM_BASIC_PP_FC13.MAX_INV,
		  ITEM_BASIC_PP_FC13.LEAD_TIME,
		  ITEM_BASIC_PP_FC13.AVG26_USAGE_QTY,
		  ITEM_BASIC_PP_FC13.AVG13_USAGE_QTY,
		  ITEM_BASIC_PP_FC13.FC_AVG13_WEEK_QTY,
		  FC_AVG26_WEEK.FC_AVG26_WEEK_QTY
		FROM
		  (SELECT ITEM_BASIC_PP.ID,
			ITEM_BASIC_PP.MATERIAL,
			ITEM_BASIC_PP.CATALOG_DASH,
			ITEM_BASIC_PP.CATALOG_NO_DASH,
			ITEM_BASIC_PP.PLANT,
			ITEM_BASIC_PP.MAT_DESC,
			ITEM_BASIC_PP.SAFETY_STOCK,
			ITEM_BASIC_PP.UNIT,
			ITEM_BASIC_PP.OH_QTY,
			ITEM_BASIC_PP.PROC_TYPE,
			ITEM_BASIC_PP.UNIT_COST,
			ITEM_BASIC_PP.PROD_BU,
			ITEM_BASIC_PP.STRATEGY_GRP,
			ITEM_BASIC_PP.MRP_TYPE,
			ITEM_BASIC_PP.MRP_CONTROLLER,
			ITEM_BASIC_PP.PURCH_GROUP,
			ITEM_BASIC_PP.VENDOR_ITEM,
			ITEM_BASIC_PP.MATL_TYPE,
			ITEM_BASIC_PP.MIN_INV,
			ITEM_BASIC_PP.TARGET_INV,
			ITEM_BASIC_PP.MAX_INV,
			ITEM_BASIC_PP.LEAD_TIME,
			ITEM_BASIC_PP.AVG26_USAGE_QTY,
			ITEM_BASIC_PP.AVG13_USAGE_QTY,
			FC_AVG13_WEEK.FC_AVG13_WEEK_QTY
		  FROM
			(SELECT ID,
			  MATERIAL,
			  CATALOG_DASH,
			  CATALOG_NO_DASH,
			  PLANT,
			  MAT_DESC,
			  SAFETY_STOCK,
			  UNIT,
			  PROC_TYPE,
			  UNIT_COST,
			  PROD_BU,
			  STRATEGY_GRP,
			  MRP_TYPE,
			  MRP_CONTROLLER,
			  PURCH_GROUP,
			  VENDOR_ITEM,
			  OH_QTY,
			  MATL_TYPE,
			  MIN_INV,
			  TARGET_INV,
			  MAX_INV,
			  LEAD_TIME,
			  AVG26_USAGE_QTY,
			  AVG13_USAGE_QTY
			FROM INV_SAP_PP_OPT_X
			)ITEM_BASIC_PP
		  LEFT JOIN
			(SELECT MATERIALID
			  ||'_'
			  ||PLANTID                           AS ID,
			  MATERIALID                          AS MATERIALID,
			  PLANTID                             AS PLANTID,
			  CEIL(SUM(PLNMG_PLANNEDQUANTITY)/13) AS FC_AVG13_WEEK_QTY
			FROM INV_SAP_PP_FRCST_PBIM_PBED
			WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 91))
			AND VERSBP_VERSION = '00'
			GROUP BY MATERIALID,
			  PLANTID
			)FC_AVG13_WEEK
		  ON FC_AVG13_WEEK.ID = ITEM_BASIC_PP.ID
		  )ITEM_BASIC_PP_FC13
		LEFT JOIN
		  (SELECT MATERIALID
			||'_'
			||PLANTID                           AS ID,
			MATERIALID                          AS MATERIALID,
			PLANTID                             AS PLANTID,
			CEIL(SUM(PLNMG_PLANNEDQUANTITY)/26) AS FC_AVG26_WEEK_QTY
		  FROM INV_SAP_PP_FRCST_PBIM_PBED
		  WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
		  AND VERSBP_VERSION = '00'
		  GROUP BY MATERIALID,
			PLANTID
		  )FC_AVG26_WEEK
		ON ITEM_BASIC_PP_FC13.ID = FC_AVG26_WEEK.ID; 
    
3.5 Sale

CREATE VIEW VIEW_INV_SAP_SALES_HST_LC AS
SELECT SOH_SOSH.ID,
  SOH_SOSH.MATERIAL,
  SOH_SOSH.CATALOG#,
  SOH_SOSH.SALES_DOC,
  SOH_SOSH.ITEM,
  ITEM_BSC.SAFETY_STOCK,
  ITEM_BSC.OH_QTY,
  ITEM_BSC.STRATEGY_GRP,
  ITEM_BSC.MRP_TYPE,
  ITEM_BSC.VENDOR,
  ITEM_BSC.BU,
  ITEM_BSC.LEAD_TIME,
  ITEM_BSC.PDT,
  ITEM_BSC.UNIT_COST,
  ITEM_BSC.MRP_CONTROLLER,
  SOH_SOSH.SOLD_TO_PARTY,
  SOH_SOSH.SOLD_TO_NAME,
  SOH_SOSH.SHIP_TO_PARTY,
  SOH_SOSH.SHIP_TO_NAME,
  SOH_SOSH.COMMITTED_DATE,
  SOH_SOSH.LAST_GI_DATE,
  SOH_SOSH.CREATION_DATE,
  SOH_SOSH.REQUEST_DATE,
  SOH_SOSH.PLANT,
  SOH_SOSH.SO_TYPE,
  SOH_SOSH.ORDER_QTY,
  SOH_SOSH.OPEN_QTY,
  SOH_SOSH.SALES_ORG,
  SOH_SOSH.CURRENCY,
  SOH_SOSH.SHIPPING_POINT,
  ITEM_BSC.ULTIMATE_SOURCE
FROM
  (SELECT SO_HST_SOLD.ID,
    SO_HST_SOLD.MATERIAL,
    SO_HST_SOLD.CATALOG#,
    SO_HST_SOLD.SALES_DOC,
    SO_HST_SOLD.ITEM,
    SO_HST_SOLD.SOLD_TO_PARTY,
    SO_HST_SOLD.SOLD_TO_NAME,
    SO_HST_SOLD.SHIP_TO_PARTY,
    ADDRESS_SHIP.SHIP_SOLD_TO_PARTY_NAME AS SHIP_TO_NAME,
    SO_HST_SOLD.COMMITTED_DATE,
    SO_HST_SOLD.LAST_GI_DATE,
    SO_HST_SOLD.CREATION_DATE,
    SO_HST_SOLD.REQUEST_DATE,
    SO_HST_SOLD.PLANT,
    SO_HST_SOLD.SO_TYPE,
    SO_HST_SOLD.ORDER_QTY,
    SO_HST_SOLD.OPEN_QTY,
    SO_HST_SOLD.SALES_ORG,
    SO_HST_SOLD.CURRENCY,
    SO_HST_SOLD.SHIPPING_POINT
  FROM
    (SELECT SO_HST.ID,
      SO_HST.MATERIAL,
      SO_HST.CATALOG#,
      SO_HST.SALES_DOC,
      SO_HST.ITEM,
      SO_HST.SOLD_TO_PARTY,
      ADDRESS.SHIP_SOLD_TO_PARTY_NAME AS SOLD_TO_NAME,
      SO_HST.SHIP_TO_PARTY,
      SO_HST.COMMITTED_DATE,
      SO_HST.LAST_GI_DATE,
      SO_HST.CREATION_DATE,
      SO_HST.REQUEST_DATE,
      SO_HST.PLANT,
      SO_HST.SO_TYPE,
      SO_HST.ORDER_QTY,
      SO_HST.OPEN_QTY,
      SO_HST.SALES_ORG,
      SO_HST.CURRENCY,
      SO_HST.SHIPPING_POINT
    FROM
      (SELECT MATERIALID
        ||'_'
        ||PLANTID            AS ID,
        MATERIALID           AS MATERIAL,
        CATALOGID            AS CATALOG#,
        SALESDOC             AS SALES_DOC,
        SALESDOCITEM         AS ITEM,
        SOLDTOPARTY          AS SOLD_TO_PARTY,
        SHIPTOPARTY          AS SHIP_TO_PARTY,
        COMMITTEDDATE        AS COMMITTED_DATE,
        LASTACTGIDATE        AS LAST_GI_DATE,
        LINECREATIONDATE     AS CREATION_DATE,
        REQUIREDDELIVERYDATE AS REQUEST_DATE,
        PLANTID              AS PLANT,
        SALESDOCTYPE         AS SO_TYPE,
        ORDERQTY             AS ORDER_QTY,
        OPENQTY              AS OPEN_QTY,
        SALES_ORG            AS SALES_ORG,
        CURRENCY             AS CURRENCY,
        SHIPPING_POINT       AS SHIPPING_POINT
      FROM INV_SAP_SALES_HST
      )SO_HST
    LEFT JOIN
      (SELECT SHIP_SOLD_TO_PARTY,
        SHIP_SOLD_TO_PARTY_NAME
      FROM INV_SAP_SHIP_SOLD_TO
      )ADDRESS
    ON ADDRESS.SHIP_SOLD_TO_PARTY = SO_HST.SOLD_TO_PARTY
    )SO_HST_SOLD
  LEFT JOIN
    (SELECT SHIP_SOLD_TO_PARTY,
      SHIP_SOLD_TO_PARTY_NAME
    FROM INV_SAP_SHIP_SOLD_TO
    )ADDRESS_SHIP
  ON ADDRESS_SHIP.SHIP_SOLD_TO_PARTY = SO_HST_SOLD.SHIP_TO_PARTY
  )SOH_SOSH
LEFT JOIN
  (SELECT ID,
    MATERIAL,
    PLANT,
    CATALOG_DASH,
    SAFETY_STOCK,
    OH_QTY,
    STRATEGY_GRP,
    MRP_TYPE,
    SUBSTR(VENDOR_KEY,0,4) AS VENDOR,
    SUBSTR(PROD_BU,0,3)    AS BU,
    LEAD_TIME,
    PDT,
    UNIT_COST,
    MRP_CONTROLLER,
    ULTIMATE_SOURCE
  FROM INV_SAP_PP_OPT_X
  )ITEM_BSC
ON ITEM_BSC.ID = SOH_SOSH.ID;

