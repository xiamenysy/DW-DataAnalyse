Select MATERIALID, SALES_ORG, CURRENT_SERIES, DIRECT_SHIP_PLANT from INV_SAP_PP_MVKE where MATERIALID = '1756-N2 B';



SELECT * FROM INV_SAP_VENDOR_PLANT_INFO WHERE MATERIALID = '100-C60DJ00 B';

SELECT * FROM INV_SAP_PP_FRCST_PBIM_PBED WHERE MATERIALID = '1756-N2 B';

SELECT MATERIALID,SALES_ORG,D_CHAIN_BLK,CURRENT_SERIES,DIRECT_SHIP_PLANT FROM INV_SAP_PP_MVKE WHERE DIRECT_SHIP_PLANT = '1180' and SALES_ORG = '5007';


SELECT * FROM INV_SAP_VENDOR_PLANT_INFO WHERE MATERIALID = '440T-MRPSE11DA/B';

------------------------------VIEW TEST-------------------------------
select * from view_ctmp_mvk where MATERIALID = '1756-N2 B';
select * from CATALOG_TMP where MATERIALID = '1756-N2 B';

select * from INV_SAP_PP_OPTIMIZATION where MATERIALID = '1756-N2 B';

Select MATERIALID, SALES_ORG, CURRENT_SERIES, DIRECT_SHIP_PLANT from INV_SAP_PP_MVKE where MATERIALID = '1756-N2 B';



  
-- How to use pl sql run all item fc number. And update by week? 
-- Try and use create table...
  SELECT FPP.MATERIALID
    ||'-'
    ||FPP.PLANTID                     AS ID,
    FPP.MATERIALID                    AS MATERIALID,
    FPP.PLANTID                       AS PLANTID,
	ROUND(SUM(FPP.PLNMG_PLANNEDQUANTITY)/13, 2) AS FORECAST_QTY,
    FPP.MEINS_BASEUNITOFMEASURE       AS UNIT,
    FPP.VERSBP_VERSION                AS VERSBP_VERSION
  FROM INV_SAP_PP_FRCST_PBIM_PBED FPP
  WHERE (FPP.PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 91))
  AND VERSBP_VERSION = '55'
  AND MATERIALID in (select CATALOG_TMP.MATERIALID from CATALOG_TMP) group by FPP.MATERIALID, FPP.MATERIALID, FPP.PLANTID, FPP.MEINS_BASEUNITOFMEASURE, FPP.VERSBP_VERSION;


SELECT POP.MATERIALID
    ||'-'
    ||POP.PLANTID                  AS ID,
    POP.MATERIALID                 AS ITEM,
    POP.PLANTID                    AS PLANT,
 POP.PDT                        AS LEAD_TIME,
    POP.SAFETY_STK                 AS SAFETY_STOCK,
    POP.STRATEGY_GRP               AS STRATEGY_GRP,
    POP.OH_QTY                     AS ON_HAND_STOCK,
    POP.ANNUAL52_PLANT_VOLUMNE_QTY AS ANNUAL52,
    POP.AVG52_USAGE_QTY            AS AVG52_USAGE_QTY,
    POP.AVG26_USAGE_QTY            AS AVG26_USAGE_QTY,
    POP.AVG13_USAGE_QTY            AS AVG13_USAGE_QTY
  FROM INV_SAP_PP_OPTIMIZATION POP;
  
SELECT MATERIALID AS MATERIALID,
PLANTID AS PLANT,
STRATEGY_GRP AS STRATEGY_GRP,
EXPECTED_SHIP_PLANT_1 AS VENDOR
FROM INV_SAP_VENDOR_PLANT_INFO WHERE MATERIALID  = '1756-N2 B';

SELECT *
FROM INV_SAP_VENDOR_PLANT_INFO WHERE MATERIALID  = '1756-N2 B';

---------------------------------------JOIN VENDOR AND CURRENT SERIAL------------------------------
SELECT * FROM VIEW_INV_CTMP_MVK WHERE MATERIAL = '1756-N2 B';

SELECT DISTINCT VI.ID, VI.CUSTOMER_PLANT,VM.MATERIAL,VM.CATALOGNODASH,VM.CATALOGBYDASH,VM.CURRENT_SERIES,VI.STRATEGY_GRP,VI.VENDOR
FROM VIEW_INV_CTMP_MVK VM,
  VIEW_INV_VENDOR_INFO VI
WHERE VM.ID = VI.ID AND VM.MATERIAL = '1756-N2 B';


SELECT * FROM VIEW_REPORT_ITEM_PLAN WHERE MATERIAL = '440T-MRPSE11DA/B';

SELECT * FROM VIEW_INV_FRCST_PBIM_CACL WHERE MATERIAL = '440T-MRPSE11DA/B';



SELECT VIO.ID AS ID,
VIO.ITEM AS MATERIAL,
VIO.PLANT AS PLANT,
VIO.LEAD_TIME AS LEAD_TIME,
ROUND(VIO.LEAD_TIME/7, 2) AS LEAD_TIME_BYWEEK,
VIO.ON_HAND_STOCK AS ON_HAND_STOCK,
VIO.SAFETY_STOCK AS SAFETY_STOCK,
VIO.STRATEGY_GRP AS STRATEGY_GRP,
VIO.ANNUAL52 AS ANNUAL52,
VIO.AVG52_USAGE_QTY            AS AVG52_USAGE_QTY,
VIO.AVG26_USAGE_QTY            AS AVG26_USAGE_QTY,
VIO.AVG13_USAGE_QTY            AS AVG13_USAGE_QTY,
VIFPC.FORECAST_QTY AS FORECAST_QTY,
VIFPC.UNIT AS UNIT,
VIFPC.VERSBP_VERSION AS VERSBP_VERSION
FROM VIEW_INV_OPTIMIZATION VIO,VIEW_INV_FRCST_PBIM_CACL VIFPC WHERE VIO.ID = VIFPC.ID;

--------------------------------------------Report------------------------------
SELECT VIOF.ID AS ID,
VIOF.MATERIAL AS MATERIAL,
VIVC.CATALOGNODASH AS CATALOG_NODASH,
    VIVC.CATALOGBYDASH AS CATALOG_BYDASH,
    VIVC.CURRENT_SERIES AS CURRENT_SERIES,
    VIVC.STRATEGY_GRP AS STRATEGY_GRP,
    VIOF.PLANT AS CUSTOMER_PLANT,
    VIVC.VENDOR AS VENDOR,
VIOF.LEAD_TIME AS LEAD_TIME,
ROUND(VIOF.LEAD_TIME/7, 2) AS LEAD_TIME_BYWEEK,
VIOF.ON_HAND_STOCK AS ON_HAND_STOCK,
VIOF.SAFETY_STOCK AS SAFETY_STOCK,
VIOF.STRATEGY_GRP AS STRATEGY_GRP,
VIOF.ANNUAL52 AS ANNUAL52,
VIOF.AVG52_USAGE_QTY            AS AVG52_USAGE_QTY,
VIOF.AVG26_USAGE_QTY            AS AVG26_USAGE_QTY,
VIOF.AVG13_USAGE_QTY            AS AVG13_USAGE_QTY,
VIOF.FORECAST_QTY AS FORECAST_QTY,
VIOF.UNIT AS UNIT,
VIOF.VERSBP_VERSION AS VERSBP_VERSION
FROM VIEW_INV_OP_FCST VIOF, VIEW_INV_VEN_CM VIVC WHERE VIOF.ID = VIVC.ID and VIOF.MATERIAL = '1756-N2 B';


CREATE TABLE TABLE_REPORT_ITEM_PLAN
AS SELECT VIOF.ID AS ID,
VIOF.MATERIAL AS MATERIAL,
VIVC.CATALOGNODASH AS CATALOG_NODASH,
    VIVC.CATALOGBYDASH AS CATALOG_BYDASH,
    VIVC.CURRENT_SERIES AS CURRENT_SERIES,
    VIVC.STRATEGY_GRP AS STRATEGY_GRP,
    VIOF.PLANT AS CUSTOMER_PLANT,
    VIVC.VENDOR AS VENDOR,
VIOF.LEAD_TIME AS LEAD_TIME,
ROUND(VIOF.LEAD_TIME/7, 2) AS LEAD_TIME_BYWEEK,
VIOF.ON_HAND_STOCK AS ON_HAND_STOCK,
VIOF.SAFETY_STOCK AS SAFETY_STOCK,
VIOF.ANNUAL52 AS ANNUAL52,
VIOF.AVG52_USAGE_QTY            AS AVG52_USAGE_QTY,
VIOF.AVG26_USAGE_QTY            AS AVG26_USAGE_QTY,
VIOF.AVG13_USAGE_QTY            AS AVG13_USAGE_QTY,
VIOF.FORECAST_QTY AS FORECAST_QTY,
VIOF.UNIT AS UNIT,
VIOF.VERSBP_VERSION AS VERSBP_VERSION
FROM VIEW_INV_OP_FCST VIOF, VIEW_INV_VEN_CM VIVC WHERE VIOF.ID = VIVC.ID;


SELECt * FROM TABLE_REPORT_ITEM_PLAN where MATERIAL = 'PN-171276';






select * from DWQ$LIBRARIAN.INV_SAP_BOM_EXPLODE_PREF_B where COMPONENT_BOM_PLANTID = '1080';


select * from DWQ$LIBRARIAN.DWQ_SHIP_GBBB_BILLING_ALL where PROD_ID_NO = '1756-N2' and BUSI_DTE > '1-jan-2013';







------------------------------------pp--------------------------
select * from DWQ$LIBRARIAN.INV_SAP_PP_DEPEND_DMD_FRCST where  PLWRK_PLANNINGPLANT = '5050';

select * from DWQ$LIBRARIAN.INV_SAP_PP_MARM where MATERIALID ='1756-N2';
















--------------------------------------PO---------------------------------

SELECT BANFN_PURCHREQNUMBER,
MATERIALID,
PLANTID,
RESWK_SUPPLYISSNGPLNTINSTO,
MENGE_PURCHREQQUANTITY,
BADAT_REQREQUESTDATE,
LPEIN_CATOFDELIVERYDATE,
LFDAT_ITEMDELIVERYDATE,
FRGDT_PURCHREQRELEASEDATE,
WEBAZ_GRT,
PEINH_PRICEUNIT,
WEPOS_GOODSRECEIPTINDICATOR,
REPOS_INVOICERECEIPTINDICATOR,
LIFNR_DESIREDVENDOR,
FLIEF_FIXEDVENDOR,
EBELN_PONUMBER,
EBELP_POITEMNUMBER,
BEDAT_PODATE,
EBAKZ_PURCHREQCLOSED,
PLIFZ_PDT,
BERID_MRPAREA,
DW_DATE FROM DWQ$LIBRARIAN.INV_SAP_PO_EBAN WHERE PLANTID = '5050' AND MATERIALID = '1756-N2 B' and EBELN_PONUMBER = '6301052528';

SELECT MATERIALID,
PLANTID,
EBELNPURCHDOCNO,
EBELPPURCHITEMNO,
BELNRMATERIALDOC,
BUZEIMATERIALDOCITEM,
BWARTMOVEMENTTYPE,
BUDATPOSTINGDATE,
MENGEQTY,
XBLNRREFERENCEDOCUMENTNUM,
BLDAT,
MATNRMATERIAL,
WERKSPLANT,
CUMDELIVERYQTY,
LASTDELIVERYDATE,
TOTALRECIEVEDYQTY,
POITEMRECIEVEDCUM,
DW_DATE,
POITEMRECIEVEDCUM_CHGE,
ENTRY_DATE,
ENTRY_TIME
FROM DWQ$LIBRARIAN.INV_SAP_PO_EKBE WHERE PLANTID = '5050' AND MATERIALID = '1756-N2 B';


select * from DWQ$LIBRARIAN.INV_SAP_INVENTORY_BY_PLANT where PLANTID = '5050' and MATERIALID = '140U-G-RMX B';

select * from DWQ$LIBRARIAN.INV_SAP_SALES_SAP where MATERIALID = '140U-G-RMX B' and PLANTID = '5050';

select * from DWQ$LIBRARIAN.inv_sap_po_ekpo where plantid = '5050';
select * from DWQ$LIBRARIAN.inv_sap_po_ekko where plantid = '5050';

select * from DWQ$LIBRARIAN.INV_SAP_PO_plaf  WHERE PLWRK_PLANPLANTID = '5050' AND MATERIALID = '1756-N2 B';
select * from DWQ$LIBRARIAN.INV_SAP_PO_eban;

-----------------------------------------------------
select * from DWQ$LIBRARIAN.INV_SAP_PP_STO1090DEMAND_V WHERE MATERIALID = 'PN-25226'   ORDER BY STATISTICALDATE DESC 


select * from DWQ$LIBRARIAN.INV_SAP_PO_EKES WHERE EBELN_PURCHDOCNO = '6301288636';


select * from DWQ$LIBRARIAN.INV_SAP_PO_EKKO WHERE EBELN_PURCHDOCNO = '6301288636';

select * from DWQ$LIBRARIAN.INV_SAP_PO_EKPO WHERE PLANTID = '5050' AND MATERIALID = '1756-N2 B';

select * from DWQ$LIBRARIAN.INV_SAP_PO_EKPV WHERE EBELNPURCHDOCNO = '6301288636';


select * from DWQ$LIBRARIAN.INV_SAP_PO_PVT WHERE PLANTID = '5050' AND MATERIAL = '1756-N2 B';


select * from DWQ$LIBRARIAN.INV_SAP_PO_STAT WHERE PLANTID = '5050' AND MATERIALID = '1756-N2 B';
-------------------------------------------------------------------------------


-- Below use to test sales orders table in dataware house...
-- Date: 4/12/2014
-- People: Marlon Huang


-------------------------------------------------------------------------------

Select * from DWQ$LIBRARIAN.INV_SAP_SALES_52_PVT where PLANTID = '5050' and materialid = '800FP-F1PX10 A';

-------------------------------------
--DWQ$LIBRARIAN.INV_SAP_SALES_CROSS
--Table Describtion
    MATERIAL           ,
    DEM_QTY            NUMBER ,
    ORDERAMT           NUMBER ,
    LINE_COUNT         NUMBER ,
    ORDERLINE_COUNTED  NUMBER ,
    ONTIMETO_CONFIRMED NUMBER ,
    DEM_AMT            NUMBER ,
    WEEK               NUMBER ,
    WEEK_DATE          DATE ,
    RANK_WEEK          NUMBER ,
    MAX_WEEK_DAY       DATE ,
    MATL_FIRST_USED    DATE ,
    PLANT              NUMBER ,
    OUTLIER_CURRECTED  NUMBER
-------------------------------------
Select * from DWQ$LIBRARIAN.INV_SAP_SALES_CROSS where MATERIAL = '800FP-F1PX10 A' and plant = '5050';

Select * from DWQ$LIBRARIAN.INV_SAP_SALES_CROSS where MATERIAL = '1756-A10 B' and plant = '5050' and WEEK_DATE > '01-jan-14';


-------------------------------------
--DWQ$LIBRARIAN.INV_SAP_SALES_CROSS
--Table Describtion
    MATERIAL           VARCHAR2(4000 BYTE) ,
    DEM_QTY            Monthly Demand from real orders
    MAX_MONTH_DAY      DATE ,
    RANK_MONTH         NUMBER ,
    YYYYMM             VARCHAR2(6 BYTE) ,
    MAX_MONTH_DATE     DATE ,
    MATL_FIRST_USED    DATE ,
    PLANTID            NUMBER 
-------------------------------------
Select * from DWQ$LIBRARIAN.INV_SAP_SALES_CROSS_MONTH where MATERIAL = '1756-A10 B' and PLANTID = '5050';


Select * from DWQ$LIBRARIAN.INV_SAP_SALES_STAT2 where PLANT = '5050' and MATERIAL = '1756-A10 B';

-- 4.1 Creation Date OK!
-- look up 1 week before.
Select * from DWQ$LIBRARIAN.INV_SAP_SALES_HST where SALESDOC = '6000863061';  

Select * from DWQ$LIBRARIAN.INV_SAP_SALES_HST_CURR2 where SALESDOC = '6000863061'; 

-- THE MOST VALUE TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Select * from DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP where SALESDOC = '6501710017'; 

------------------------------------------------------------------------------------------------









-------------------------------------------------------------------------------------------------

select * from DWQ$LIBRARIAN.INV_SAP_PURCH_SOURCE where materialid = '1756-A10 B' and plantid = '5050';












-----------------------------------Inventory----------------------------------------------------
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_INVENTORY_BY_PLANT WHERE PLANTID = '5050';








----------------------------------Usage---------------------------------------------------------
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_IO_INPUTS WHERE PLANTID = '5050' and MATERIALID ='1756-N2 B';










