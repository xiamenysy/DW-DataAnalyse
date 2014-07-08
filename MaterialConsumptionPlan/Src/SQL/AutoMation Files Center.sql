--Porject Name: Automation Files Center
--Author: Huang Moyue 
--Mail: mhuang1@ra.rockwell.com
--Date:07/08/2014
--Summary: Automation Files Center Job Logs and set up process
--Version: 0.5

1. Oracle Client Setup
	1.1 Net Service Name: data_analysis
		SERVICE_NAME: APAFC
		HOST: APCNXMNGYKG422
		PORT: 1523
		
2. Oracle Job Setup
	2.1 Job Name: Job_Daily_INV_PP_OPT
		Job Time: 4:00 AM
		Job Repeat Frequency: Daily
		Job Procedure:
		DECLARE
		  DROP_TABLE_PP_OPTIMIZATION   VARCHAR2(1000);
		  CREATE_TABLE_PP_OPTIMIZATION VARCHAR2(1000);
		BEGIN
		  DROP_TABLE_PP_OPTIMIZATION   := 'DROP TABLE INV_SAP_PP_OPTIMIZATION';
		  CREATE_TABLE_PP_OPTIMIZATION := 'CREATE TABLE INV_SAP_PP_OPTIMIZATION AS
			SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION@ROCKWELL_DW_DBLINK';
		  EXECUTE IMMEDIATE DROP_TABLE_PP_OPTIMIZATION;
		  EXECUTE IMMEDIATE CREATE_TABLE_PP_OPTIMIZATION;
		END;
		
		Job Initialization:
		Drop table INV_SAP_PP_OPTIMIZATION;
		CREATE TABLE INV_SAP_PP_OPTIMIZATION AS
		SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION@ROCKWELL_DW_DBLINK;
		
		
	2.2 Job Name: Job_Daily_INV_SO_OPEN
		Job Time: 5:00 AM
		Job Repeat Frequency: Daily
		Job Procedure:
		DECLARE
		  DROP_TABLE_OPEN_SALES   VARCHAR2(1000);
		  CREATE_TABLE_OPEN_SALES  VARCHAR2(1000);
		BEGIN
		  DROP_TABLE_OPEN_SALES   := 'Drop table INV_SAP_SALES_VBAK_VBAP_VBUP';
		  CREATE_TABLE_OPEN_SALES := 'CREATE TABLE INV_SAP_SALES_VBAK_VBAP_VBUP AS
			SELECT * FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP@ROCKWELL_DW_DBLINK WHERE PLANT IN ('||5040||', '||5050||', '||5100||', '||5110||', '||5120||', '||5160||', '||5190||', '||5200||','||5070||','||5140||')';
		  EXECUTE IMMEDIATE DROP_TABLE_OPEN_SALES;
		  EXECUTE IMMEDIATE CREATE_TABLE_OPEN_SALES;
		END;
		
		Job Initialization: 
		Drop table INV_SAP_SALES_VBAK_VBAP_VBUP;
		CREATE TABLE INV_SAP_SALES_VBAK_VBAP_VBUP AS
		SELECT * FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP@ROCKWELL_DW_DBLINK WHERE PLANT IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140');

	2.3 Job Name: Job_Daily_INV_PP_FCST
		Job Time: 5:40 AM
		Job Repeat Frequency: Daily
		Job Procedure:
		DECLARE
		  DROP_TABLE_OPEN_FC   VARCHAR2(1000);
		  CREATE_TABLE_OPEN_FC  VARCHAR2(1000);
		BEGIN
		  DROP_TABLE_OPEN_FC   := 'Drop table INV_SAP_PP_FRCST_PBIM_PBED';
		  CREATE_TABLE_OPEN_FC := 'CREATE TABLE INV_SAP_PP_FRCST_PBIM_PBED AS
			SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_FRCST_PBIM_PBED@ROCKWELL_DW_DBLINK WHERE PLANTID IN ('||5040||', '||5050||', '||5100||', '||5110||', '||5120||', '||5160||', '||5190||', '||5200||','||5070||','||5140||')';
		  EXECUTE IMMEDIATE DROP_TABLE_OPEN_FC;
		  EXECUTE IMMEDIATE CREATE_TABLE_OPEN_FC;
		END;
		
		Job Initialization: 
		DROP TABLE INV_SAP_PP_FRCST_PBIM_PBED;
		CREATE TABLE INV_SAP_PP_FRCST_PBIM_PBED AS
		SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_FRCST_PBIM_PBED@ROCKWELL_DW_DBLINK WHERE PLANTID IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140');

		
	2.4 Job Name: Job_Daily_INV_DELY
		Job Time: 6:00 AM
		Job Repeat Frequency: Daily
		Job Procedure:
		DECLARE
		  DROP_TABLE_DELIVERY_REC  VARCHAR2(1000);
		  CREATE_TABLE_DELIVERY_REC  VARCHAR2(1000);
		BEGIN
		  DROP_TABLE_DELIVERY_REC   := 'Drop table INV_SAP_LIKP_LIPS_DAILY';
		  CREATE_TABLE_DELIVERY_REC := 'CREATE TABLE INV_SAP_LIKP_LIPS_DAILY AS
			SELECT * FROM DWQ$LIBRARIAN.INV_SAP_LIKP_LIPS_DAILY@ROCKWELL_DW_DBLINK WHERE CREATED_ON_DATE > SYSDATE - 91';
		  EXECUTE IMMEDIATE DROP_TABLE_DELIVERY_REC;
		  EXECUTE IMMEDIATE CREATE_TABLE_DELIVERY_REC;
		END;
		
		Job Initialization: 
		DROP TABLE INV_SAP_LIKP_LIPS_DAILY; 
		CREATE TABLE INV_SAP_LIKP_LIPS_DAILY AS
		SELECT * FROM DWQ$LIBRARIAN.INV_SAP_LIKP_LIPS_DAILY@ROCKWELL_DW_DBLINK WHERE CREATED_ON_DATE > SYSDATE - 91;

	2.5 Job Name: Job_Daily_INV_PLANT
		Job Time: 6:20 AM
		Job Repeat Frequency: Daily
		Job Procedure:
		DECLARE
		  DROP_TABLE_INVENTORY_REC  VARCHAR2(1000);
		  CREATE_TABLE_INVENTORY_REC  VARCHAR2(1000);
		BEGIN
		  DROP_TABLE_INVENTORY_REC   := 'Drop table INV_SAP_INVENTORY_BY_PLANT';
		  CREATE_TABLE_INVENTORY_REC := 'CREATE TABLE INV_SAP_INVENTORY_BY_PLANT AS
			SELECT * FROM DWQ$LIBRARIAN.INV_SAP_INVENTORY_BY_PLANT@ROCKWELL_DW_DBLINK';
		  EXECUTE IMMEDIATE DROP_TABLE_INVENTORY_REC;
		  EXECUTE IMMEDIATE CREATE_TABLE_INVENTORY_REC;
		END;
		
		Job Initialization: 
		DROP TABLE INV_SAP_INVENTORY_BY_PLANT;
		CREATE TABLE INV_SAP_INVENTORY_BY_PLANT AS
		SELECT * FROM DWQ$LIBRARIAN.INV_SAP_INVENTORY_BY_PLANT@ROCKWELL_DW_DBLINK;

			
	2.6 Job Name: Job_Daily_INV_PP_PO
		Job Time: 6:40 AM
		Job Repeat Frequency: Daily
		Job Procedure:
		DECLARE
		  DROP_TABLE_PP_PO_HISTORY  VARCHAR2(1000);
		  CREATE_TABLE_PP_PO_HISTORY  VARCHAR2(1000);
		BEGIN
		  DROP_TABLE_PP_PO_HISTORY   := 'Drop table INV_SAP_PP_PO_HISTORY';
		  CREATE_TABLE_PP_PO_HISTORY := 'CREATE TABLE INV_SAP_PP_PO_HISTORY AS
		SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_PO_HISTORY@ROCKWELL_DW_DBLINK WHERE PLANTID IN ('||5040||', '||5050||', '||5100||', '||5110||', '||5120||', '||5160||', '||5190||', '||5200||','||5070||','||5140||')';
		  EXECUTE IMMEDIATE DROP_TABLE_PP_PO_HISTORY;
		  EXECUTE IMMEDIATE CREATE_TABLE_PP_PO_HISTORY;
		END;
		
		Job Initialization: 
		DROP TABLE INV_SAP_PP_PO_HISTORY;
		CREATE TABLE INV_SAP_PP_PO_HISTORY AS
		SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_PO_HISTORY@ROCKWELL_DW_DBLINK WHERE PLANTID IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140');

	2.7 Job Name: Job_Daily_INV_IO
		Job Time: 7:00 AM
		Job Repeat Frequency: Daily
		Job Procedure:
		DECLARE
		  DROP_TABLE_IO_REC  VARCHAR2(1000);
		  CREATE_TABLE_IO_REC  VARCHAR2(1000);
		BEGIN
		  DROP_TABLE_IO_REC   := 'Drop table INV_SAP_IO_INPUTS_DAILY';
		  CREATE_TABLE_IO_REC := 'CREATE TABLE INV_SAP_IO_INPUTS_DAILY AS
		SELECT * FROM DWQ$LIBRARIAN.INV_SAP_IO_INPUTS_DAILY@ROCKWELL_DW_DBLINK';
		  EXECUTE IMMEDIATE DROP_TABLE_IO_REC;
		  EXECUTE IMMEDIATE CREATE_TABLE_IO_REC;
		END;
		
		Job Initialization: 
		DROP TABLE INV_SAP_IO_INPUTS_DAILY;
		CREATE TABLE INV_SAP_IO_INPUTS_DAILY AS
		SELECT * FROM DWQ$LIBRARIAN.INV_SAP_IO_INPUTS_DAILY@ROCKWELL_DW_DBLINK;
				
	2.8 Job Name: Job_Weekly_INV_SO_HST
		Job Time: 3:00 AM
		Job Repeat Frequency: Weekly
		Job Procedure:
		DECLARE
		  DROP_TABLE_SALES_HST  VARCHAR2(1000);
		  CREATE_TABLE_SALES_HST  VARCHAR2(1000);
		BEGIN
		  DROP_TABLE_SALES_HST   := 'Drop table INV_SAP_SALES_HST';
		  CREATE_TABLE_SALES_HST := 'CREATE TABLE INV_SAP_SALES_HST AS
		SELECT * FROM DWQ$LIBRARIAN.INV_SAP_SALES_HST@ROCKWELL_DW_DBLINK WHERE PLANTID IN ('||5040||', '||5050||', '||5100||', '||5110||', '||5120||', '||5160||', '||5190||', '||5200||','||5070||','||5140||')';
		  EXECUTE IMMEDIATE DROP_TABLE_SALES_HST;
		  EXECUTE IMMEDIATE CREATE_TABLE_SALES_HST;
		END;
		
		Job Initialization: 
		DROP TABLE INV_SAP_SALES_HST;
		CREATE TABLE INV_SAP_SALES_HST AS
		SELECT * FROM DWQ$LIBRARIAN.INV_SAP_SALES_HST@ROCKWELL_DW_DBLINK WHERE PLANTID IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140');

	2.9 Job Name: Job_Weekly_INV_PP_MVKE
		Job Time: 18:00 AM SUNDAY
		Job Repeat Frequency: Weekly
		Job Procedure:
		DECLARE
		  DROP_TABLE_INV_SAP_PP_MVKE   VARCHAR2(1000);
		  CREATE_TABLE_INV_SAP_PP_MVKE VARCHAR2(1000);
		BEGIN
		  DROP_TABLE_INV_SAP_PP_MVKE   := 'DROP TABLE INV_SAP_PP_MVKE';
		  CREATE_TABLE_INV_SAP_PP_MVKE := 'CREATE TABLE INV_SAP_PP_MVKE AS SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_MVKE@ROCKWELL_DW_DBLINK';
		  EXECUTE IMMEDIATE DROP_TABLE_INV_SAP_PP_MVKE;
		  EXECUTE IMMEDIATE CREATE_TABLE_INV_SAP_PP_MVKE;
		END;
		
		Job Initialization: 
		DROP TABLE INV_SAP_PP_MVKE;
		CREATE TABLE INV_SAP_PP_MVKE AS
		SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_MVKE@ROCKWELL_DW_DBLINK;

	2.10 Job Name: Job_Weekly_INV_PP_CATA
		Job Time: 20:00 AM SUNDAY
		Job Repeat Frequency: Weekly
		Job Procedure:
		DECLARE
		  CREATE_TABLE_INV_SAP_MATERIAL_CATALOG        VARCHAR2(1000);
		  DROP_TABLE_INV_SAP_MATERIAL_CATALOG              VARCHAR2(1000);
		BEGIN
		  DROP_TABLE_INV_SAP_MATERIAL_CATALOG:= 'DROP TABLE INV_SAP_MATERIAL_CATALOG';
		  CREATE_TABLE_INV_SAP_MATERIAL_CATALOG:= 'CREATE TABLE INV_SAP_MATERIAL_CATALOG AS SELECT * FROM DWQ$LIBRARIAN.INV_SAP_MATERIAL_CATALOG@ROCKWELL_DW_DBLINK';
		  EXECUTE IMMEDIATE DROP_TABLE;
		  EXECUTE IMMEDIATE STR_CREATE_TABLE;
		END;
		
		Job Initialization: 
		DROP TABLE INV_SAP_MATERIAL_CATALOG;
		CREATE TABLE INV_SAP_MATERIAL_CATALOG AS SELECT * FROM DWQ$LIBRARIAN.INV_SAP_MATERIAL_CATALOG@ROCKWELL_DW_DBLINK;

		DROP TABLE INV_SAP_NODASH_MAT_CATA
		CREATE TABLE INV_SAP_NODASH_MAT_CATA AS SELECT * FROM INV_SAP_MATERIAL_CATALOG
		DECLARE
		  CURSOR cur
		  IS
			SELECT a.CATALOG_STRING1,
			  b.ROWID ROW_ID
			FROM INV_SAP_MATERIAL_CATALOG a,
			  INV_SAP_NODASH_MAT_CATA b
			WHERE a.MATERIALID = b.MATERIALID
			ORDER BY b.ROWID; ---order by rowid
		  V_COUNTER NUMBER;
		BEGIN
		  V_COUNTER := 0;
		  FOR row IN cur
		  LOOP
			UPDATE INV_SAP_NODASH_MAT_CATA SET CATALOG_STRING2 = REPLACE(row.CATALOG_STRING1, '-') WHERE ROWID = row.ROW_ID;
			V_COUNTER     := V_COUNTER + 1;
			IF (V_COUNTER >= 1000) THEN
			  COMMIT;
			  V_COUNTER := 0;
			END IF;
		  END LOOP;
		  COMMIT;
		END;
		
		
		
		
		
		
3. Oracle View Setup		
	3.1 X CURRENT ITEM VIEW
		DROP VIEW VIEW_INV_SAP_ITEM_X;
		SELECT * FROM VIEW_INV_SAP_ITEM_X;
		CREATE VIEW VIEW_INV_SAP_ITEM_X AS 
		SELECT DISTINCT * FROM
		(SELECT ISPM.ID           AS ID,
		  ISPM.DIRECT_SHIP_PLANT AS PLANT,
		  ISPM.MATERIALID        AS MATERIAL,
		  ISMC.CATALOG_STRING1   AS CATALOG_DASH,
		  ISMC.CATALOG_STRING2   AS CATALOG_NO_DASH,
		  ISPM.DIST_CHL          AS DIST_CHL,
		  ISPM.CURRENT_SERIES    AS CURRENT_SERIES
		FROM
		  (SELECT MATERIALID
			||'_'
			||DIRECT_SHIP_PLANT AS ID,
			MATERIALID,
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
		ON ISPM.MATERIALID = ISMC.MATERIALID)	
		
	3.2 ITEM_ALL
		DROP VIEW VIEW_INV_SAP_ITEM_ALL;
		SELECT * FROM VIEW_INV_SAP_ITEM_ALL;
		CREATE VIEW VIEW_INV_SAP_ITEM_ALL AS 
		SELECT ISPM.ID           AS ID,
		  ISPM.DIRECT_SHIP_PLANT AS PLANT,
		  ISPM.MATERIALID        AS MATERIAL,
		  ISMC.CATALOG_STRING1   AS CATALOG_DASH,
		  ISMC.CATALOG_STRING2   AS CATALOG_NO_DASH,
		  ISPM.SALES_ORG         AS SALES_ORG,
		  ISPM.DIST_CHL          AS DIST_CHL,
		  ISPM.D_CHAIN_BLK       AS D_CHAIN_BLK,
		  ISPM.VALID_FROM_DATE   AS VALID_FROM_DATE,
		  ISPM.STOCK_STATUS      AS STOCK_STATUS,
		  ISPM.CURRENT_SERIES    AS CURRENT_SERIES
		FROM
		  (SELECT MATERIALID
			||'_'
			||DIRECT_SHIP_PLANT AS ID,
			MATERIALID,
			SALES_ORG,
			DIST_CHL,
			D_CHAIN_BLK,
			VALID_FROM_DATE,
			DIRECT_SHIP_PLANT,
			STOCK_STATUS,
			CURRENT_SERIES
		  FROM INV_SAP_PP_MVKE
		  )ISPM
		LEFT JOIN
		  (SELECT CATALOG_STRING1,
			CATALOG_STRING2,
			MATERIALID
		  FROM INV_SAP_NODASH_MAT_CATA
		  )ISMC
		ON ISPM.MATERIALID = ISMC.MATERIALID;
		
	3.3 VIEW_INV_SAP_PP_OPT_X with x current series
		DROP VIEW VIEW_INV_SAP_PP_OPT_X;
		SELECT * FROM VIEW_INV_SAP_PP_OPT_X WHERE PLANT IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140');
		CREATE VIEW VIEW_INV_SAP_PP_OPT_X AS
		SELECT *
		FROM
		  (SELECT PP_BASIC.ID,
			PP_BASIC.LAST_REVIEW,
			PP_BASIC.MATERIAL,
			ITEM_X.CATALOG_DASH,
			ITEM_X.CATALOG_NO_DASH,
			PP_BASIC.PLANT,
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
			ITEM_X.DIST_CHL,
			PP_BASIC.ISSUE_UOM_NUMERATOR,
			PP_BASIC.PO_UOM_NUMERATOR,
			PP_BASIC.MATL_TYPE,
			ITEM_X.CURRENT_SERIES,
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
			  (SAFETY_STK)                        AS MIN_INV,
			  CEIL(SAFETY_STK + 0.5*LOT_SIZE_QTY) AS TARGET_INV,
			  CEIL(SAFETY_STK + 1.2*LOT_SIZE_QTY) AS MAX_INV,
			  LOT_SIZE_QTY,
			  LOT_ROUNDING_VALUE,
			  LOT_SIZE_DISLS,
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
			  PURCH_GROUP_EKGRP AS PURCH_GROUP_KEY,
			  PROD_SCHED_FEVOR  AS PROD_SCHED_KEY,
			  REORDER_PT        AS RECORDER_POINT,
			  CEIL(1.4*GRT + PDT)   AS LEAD_TIME,  --Lead Time Change!!
			  PDT AS PDT,
			  GRT AS GRT,
			  MEINS_ISSUE_UOM   AS UNIT,
			  ISSUE_UOM_NUMERATOR,
			  PO_UOM_NUMERATOR,
			  MATL_TYPE_MTART AS MATL_TYPE,
			  ULTIMATE_SOURCE
			FROM INV_SAP_PP_OPTIMIZATION --WHERE MATERIALID = '100-C09KJ400 A' AND PLANTID = '5200'
			)PP_BASIC
		  LEFT JOIN
			(SELECT ID,
			  MATERIAL,
			  CATALOG_DASH,
			  CATALOG_NO_DASH,
			  DIST_CHL,
			  CURRENT_SERIES
			FROM VIEW_INV_SAP_ITEM_X --WHERE MATERIAL = '100-C09KJ400 A' AND PLANTID = '5200'
			)ITEM_X
		  ON ITEM_X.ID = PP_BASIC.ID
		  )
		WHERE CURRENT_SERIES = 'X';
	3.3 VIEW_INV_SAP_PP_OPT_ALL 
		DROP VIEW VIEW_INV_SAP_PP_OPT_ALL;
		SELECT * FROM VIEW_INV_SAP_PP_OPT_ALL WHERE PLANT IN ('5040', '5050', '5100', '5110', '5120', '5160', '5190', '5200','5070','5140');
		CREATE VIEW VIEW_INV_SAP_PP_OPT_ALL AS
		SELECT *
		FROM
		  (SELECT PP_BASIC.ID,
			PP_BASIC.LAST_REVIEW,
			PP_BASIC.MATERIAL,
			ITEM_X.CATALOG_DASH,
			ITEM_X.CATALOG_NO_DASH,
			PP_BASIC.PLANT,
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
			ITEM_X.DIST_CHL,
			PP_BASIC.ISSUE_UOM_NUMERATOR,
			PP_BASIC.PO_UOM_NUMERATOR,
			PP_BASIC.MATL_TYPE,
			ITEM_X.CURRENT_SERIES,
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
			  (SAFETY_STK)                        AS MIN_INV,
			  CEIL(SAFETY_STK + 0.5*LOT_SIZE_QTY) AS TARGET_INV,
			  CEIL(SAFETY_STK + 1.2*LOT_SIZE_QTY) AS MAX_INV,
			  LOT_SIZE_QTY,
			  LOT_ROUNDING_VALUE,
			  LOT_SIZE_DISLS,
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
			  PURCH_GROUP_EKGRP AS PURCH_GROUP_KEY,
			  PROD_SCHED_FEVOR  AS PROD_SCHED_KEY,
			  REORDER_PT        AS RECORDER_POINT,
			  CEIL(1.4*GRT + PDT)   AS LEAD_TIME,  --Lead Time Change!!
			  PDT AS PDT,
			  GRT AS GRT,
			  MEINS_ISSUE_UOM   AS UNIT,
			  ISSUE_UOM_NUMERATOR,
			  PO_UOM_NUMERATOR,
			  MATL_TYPE_MTART AS MATL_TYPE,
			  ULTIMATE_SOURCE
			FROM INV_SAP_PP_OPTIMIZATION --WHERE MATERIALID = '100-C09KJ400 A' AND PLANTID = '5200'
			)PP_BASIC
		  LEFT JOIN
			(SELECT ID,
			  MATERIAL,
			  CATALOG_DASH,
			  CATALOG_NO_DASH,
			  DIST_CHL,
			  CURRENT_SERIES
			FROM VIEW_INV_SAP_ITEM_X --WHERE MATERIAL = '100-C09KJ400 A' AND PLANTID = '5200'
			)ITEM_X
		  ON ITEM_X.ID = PP_BASIC.ID
		  );
		  












4. Automate Reports
	4.1 AUS REPORTS
	4.1.1 
		--5140 INV CLS REPORT
		--AUTHOR: HUANG MO YUE
		--DATE:7/2/2014
		DROP VIEW VIEW_SAP_INV_CLS_AUSRE;
		SELECT * FROM VIEW_SAP_INV_CLS_AUSRE;
		CREATE VIEW VIEW_SAP_INV_CLS_AUSRE AS
		SELECT PLANT AS PLANT,
		  MATERIAL AS MATERIAL,
		  CATALOG_DASH AS CATALOG,
		  MAT_DESC AS MAT_DESC,
		  PROD_BU AS PRODUCT_GRP,
		  STRATEGY_GRP AS STRATEGY_GRP,
		  SAFETY_STOCK AS SAFETY_STOCK,
		  UNIT AS UNIT,
		  LEAD_TIME AS LEAD_TIME,
		  PROC_TYPE AS PROC_TYPE,
		  PLANT_SP_MATL_STA AS Material_Status,
		  ISSUE_UOM_NUMERATOR AS Delivery_Unit
		FROM VIEW_INV_SAP_PP_OPT_X
		WHERE PLANT IN ('5140','5150');
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		