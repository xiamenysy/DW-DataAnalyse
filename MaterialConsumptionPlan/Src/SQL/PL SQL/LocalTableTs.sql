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

SELECT POP.MATERIALID
  ||'-'
  ||POP.PLANTID          AS ID,
  POP.MATERIALID         AS ITEM,
  POP.PLANTID            AS PLANT,
  POP.PDT                AS LEAD_TIME,
  pop.SP_MATL_STAT_MMSTA AS STATUS,
  POP.MATL_TYPE_MTART AS MATERIAL_TYPE
FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION pop
WHERE POP.PLANTID  = '5050'
AND POP.PDT        < 10
AND POP.MATL_TYPE_MTART in('ZFG','ZTG');



------------------------------------pp--------------------------
select * from DWQ$LIBRARIAN.INV_SAP_PP_DEPEND_DMD_FRCST where  PLWRK_PLANNINGPLANT = '5050';

select * from DWQ$LIBRARIAN.INV_SAP_PP_MARM where MATERIALID ='1756-N2 B';





select MATERIALID,PLANTID, STRATEGY_GRP from DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION where PLANTID ='5040' and STRATEGY_GRP = '40';


select * from DWQ$LIBRARIAN.INV_SAP_PP_PARAM where MATERIALID ='1756-N2 B';



drop table inv_sap_pp_optimization;
drop table TABLE_REPORT_ITEM_PLAN;



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

select * from DWQ$LIBRARIAN.inv_sap_po_ekpo where plantid = '5050';
select * from DWQ$LIBRARIAN.inv_sap_po_ekko where plantid = '5050';
select * from DWQ$LIBRARIAN.INV_SAP_PO_plaf  WHERE PLWRK_PLANPLANTID = '5050' AND MATERIALID = '1756-N2 B';
select * from DWQ$LIBRARIAN.INV_SAP_PO_eban;
select * from DWQ$LIBRARIAN.INV_SAP_PO_EKES WHERE EBELN_PURCHDOCNO = '6301288636';
select * from DWQ$LIBRARIAN.INV_SAP_PO_EKKO WHERE EBELN_PURCHDOCNO = '6301288636';
select * from DWQ$LIBRARIAN.INV_SAP_PO_EKPO WHERE PLANTID = '5040' and ELIKZDELIVERYCOMPLETE is null AND MATERIALID = '100S-C85KL14BC A';
select * from DWQ$LIBRARIAN.INV_SAP_PO_EKPV WHERE EBELNPURCHDOCNO = '6301288636';
select * from DWQ$LIBRARIAN.INV_SAP_PO_PVT WHERE PLANTID = '5050' AND MATERIAL = '1756-N2 B';
select * from DWQ$LIBRARIAN.INV_SAP_PO_STAT WHERE PLANTID = '5050' AND MATERIALID = '1756-N2 B';



-------------------------------------SO detail------------------------------------------


-- Below use to test sales orders table in dataware house...
-- Date: 4/12/2014
-- People: Marlon Huang


-------------------------------------------------------------------------------

Select * from DWQ$LIBRARIAN.INV_SAP_SALES_52_PVT where PLANTID = '5040' and materialid = '700-HC24Z1-3 D';

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
Select * from DWQ$LIBRARIAN.INV_SAP_SALES_HST  where plantid = '5050' and SALESDOC = '6501812863';  

Select * from DWQ$LIBRARIAN.INV_SAP_SALES_SAP where SALESDOC = '6501812863'; 


Select * from DWQ$LIBRARIAN.INV_SAP_SALES_STO_DTL where SALESDOC = '6501812863'; 
-- THE MOST VALUE TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Select * from DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP where plant = '5040' and MATERIAL = '700-HC24Z1-3 D'; 

-----------------------------PRODUCTION PARAMETERS-------------------------------------------------------------------
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PRODUCTION_PARAMETERS WHERE MATERIALID = '1756-N2 B' AND PLANTID = '5050';








-------------------------------------------------------------------------------------------------

select * from DWQ$LIBRARIAN.INV_SAP_PURCH_SOURCE where materialid = '1756-A10 B' and plantid = '5050';












-----------------------------------Inventory----------------------------------------------------

SELECT * FROM DWQ$LIBRARIAN.INV_SAP_INVENTORY_BY_PLANT WHERE PLANTID = '5050';


SELECT * FROM DWQ$LIBRARIAN.INV_SAP_SPA_CDC_MEM_COST WHERE MATERIALID = '1756-N2 B';





----------------------------------Usage---------------------------------------------------------
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_IO_INPUTS WHERE PLANTID = '5050' and MATERIALID ='1756-N2 B';








--------------------------------------------------------------------------------------------------
---Special procurement type
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_CODE_LOOKUP WHERE PLANT = '5040';





--------------------------------------------------------------------------------------------------
---Delivery information history
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_LIKP_LIPS_DAILY where plantid = '5050' and DELIVERY = '8013545908';

SELECT * FROM DWQ$LIBRARIAN.INV_SAP_LOH3 WHERE MATERIALID ='1756-N2 B';





----------------------------LIKP_LIPS------------------------------------------------------------
select * from DWQ$LIBRARIAN.INV_SAP_LIKP_LIPS_DAILY WHERE MATERIALID ='1756-N2 B' and plantid = '5050';




----------------------------Planning Param--------------------------------------------------------------------------
select * from DWQ$LIBRARIAN.INV_SAP_PLAN_PARAM_REVIEW where PLANTID = '5200' and MATERIALID ='1756-CN2R B';









--------------------------------PP------------------------------------------------------------------------------------
--inv_sap_pp_optimization
---CV Data Report
SELECT MATERIALID,
  PLANTID,
  AVGXX_USAGE_QTY,
  STDEVXX_USAGE,
  CVXX_USAGE
FROM DWQ$LIBRARIAN.inv_sap_pp_optimization
WHERE Plantid = '5040';

CREATE TABLE inv_sap_pp_optimization_5041
Select * from DWQ$LIBRARIAN.inv_sap_pp_optimization;









---INV_SAP_PP_SERVICE_LEVELS
--- Service Level Report in RISO
SELECT SERVISE_LEVEL_TYPE,
  PLANTID,
  LEVEL_TYPE ,
  LEVEL_VALUE ,
  ANALYSIS_COST_X ,
  ANALYSIS_WKSPEED_X ,
  ANALYSIS_LINESPEED_X ,
  ANALYSIS_ABCWI_X ,
  ANALYSIS_TICPOF_X ,
  SERVICE_LEVEL,
  SERVICE_LEVEL_ALTERNATE
FROM DWQ$LIBRARIAN.INV_SAP_PP_SERVICE_LEVELS
WHERE SERVISE_LEVEL_TYPE = 'CSM';

---INV_SAP_PP_CS_LEVELS
--- C&S Growth Report in RISO
SELECT SERVISE_LEVEL_TYPE,
  PLANTID,
  LEVEL_TYPE,
  LEVEL_VALUE,
  GROWTH,
  FIX_COST,
  HOLDING_COST,
  ADDPCTTOMAX,
  EXCHANGE_RATE,
  AUTO_SL_TOLERANCE_MIN,
  AUTO_SL_TOLERANCE_MAX,
  AUTO_$$_THREASHOLD_MIN,
  AUTO_$$_THREASHOLD_MAX,
  COST_MIN,
  COST_MAX,
  VOLUMNE_MIN,
  VOLUMNE_MAX,
  HIGHSPEEDWK_MIN,
  LOWSPEEDWK_MAX,
  DOUBLEWAMMYWK_MAX,
  INACTIVEWK_MAX,
  HIGHSPEEDLN_MIN,
  LOWSPEEDLN_MAX,
  DOUBLEWAMMYLN_MAX,
  INACTIVELN_MAX,
  USESTATISTICS,
  CAPONLOTSIZEFACTOR,
  PLAN_BY_WOS,
  ASSUMPTIONS_NOTES,
  CHANGE_AUTORIZATION
FROM DWQ$LIBRARIAN.INV_SAP_PP_CS_LEVELS
WHERE SERVISE_LEVEL_TYPE = 'CSM';



SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_FRCST_PBIM_PBED WHERE MATERIALID = '1489-A1C150 A
' and PLANTID = '5200';










-------------------------------------------CROSS-------------------------------------------------------
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_CROSS_PART WHERE MATERIALID = '1756-N2 B';

SELECT * FROM DWQ$LIBRARIAN.INV_SAP_CROSS_PART_WITH WHERE MATERIALID = '1756-N2 B';



















------------------------------Delivery History Record--------------------------
select * from DWQ$LIBRARIAN.INV_SAP_LIKP_LIPS_DAILY where PLANTID = '5040' and CREATED_ON_DATE = '13-JAN-14';

SELECT MATERIALID,
  CATALOGID,
  SALESDOC,
  SALESDOCITEM,
  SOLDTOPARTY,
  PLANTID,
  ORDERQTY,
  LINECREATIONDATE,
  REQUIREDDELIVERYDATE
FROM DWQ$LIBRARIAN.INV_SAP_SALES_HST
WHERE SOLDTOPARTY = '91312369'
AND MATERIALID    = '74106-869-51';

--Data Report For gloria
SELECT MATERIALID,
  CATALOGID,
  SALESDOC,
  SALESDOCITEM,
  SOLDTOPARTY,
  PLANTID,
  ORDERQTY,
  LINECREATIONDATE,
  REQUIREDDELIVERYDATE
FROM DWQ$LIBRARIAN.INV_SAP_SALES_HST
WHERE PLANTID = '5040'
AND LINECREATIONDATE BETWEEN TO_CHAR(sysdate - 183) AND TO_CHAR(sysdate);


SELECT SSTP.SHIP_SOLD_TOPARTY AS SOLD_PARTY,
  SSTP.SHIP_TO_PARTY_NAME AS CUSTOMER_NAME
FROM DWQ$LIBRARIAN.INV_SAP_SHIP_SOLD_TO_PARTYID SSTP
WHERE SHIP_TO_COUNTRY = 'CN' and SHIP_SOLD_TOPARTY = '91312759';

--LEFT JOIN
SELECT SSHJ.PLANT_ID  AS PLANT_ID,
  SSHJ.SALE_ORDER     AS SALE_ORDER,
  SSHJ.ITEM           AS ITEM,
  SSHJ.MATERIAL_ID    AS MATERIAL_ID,
  SSHJ.CATALOG_ID     AS CATALOG_ID,
  SSHJ.SOLD_TO_PARTY  AS SOLD_TO_PARTY,
  SSTPJ.CUSTOMER_NAME AS CUSTOMER_NAME,
  SSHJ.QTY            AS QTY,
  SSHJ.CREATION_DATE  AS CREATION_DATE,
  SSHJ.REQUIRE_DATE   AS REQUIRE_DATE
FROM
  (SELECT SSH.MATERIALID     AS MATERIAL_ID,
    SSH.CATALOGID            AS CATALOG_ID,
    SSH.SALESDOC             AS SALE_ORDER,
    SSH.SALESDOCITEM         AS ITEM,
    SSH.SOLDTOPARTY          AS SOLD_TO_PARTY,
    SSH.PLANTID              AS PLANT_ID,
    SSH.ORDERQTY             AS QTY,
    SSH.LINECREATIONDATE     AS CREATION_DATE,
    SSH.REQUIREDDELIVERYDATE AS REQUIRE_DATE
  FROM DWQ$LIBRARIAN.INV_SAP_SALES_HST SSH
  WHERE PLANTID = '5040'
  AND LINECREATIONDATE BETWEEN '21-04-14' AND '25-04-14'
  )SSHJ
LEFT JOIN
  (SELECT SSTP.SHIP_SOLD_TOPARTY AS SOLD_TO_PARTY,
    SSTP.SHIP_TO_PARTY_NAME      AS CUSTOMER_NAME
  FROM DWQ$LIBRARIAN.INV_SAP_SHIP_SOLD_TO_PARTYID SSTP
  WHERE SHIP_TO_COUNTRY = 'CN'
  ) SSTPJ
ON SSTPJ.SOLD_TO_PARTY = SSHJ.SOLD_TO_PARTY;





-------------simon report------------------------
Drop table SIMON_REPORT;
CREATE TABLE SIMON_REPORT AS
SELECT MATERIALID,
  MAT_DESC,
  PLANTID,
  PROD_BU,
  SAFETY_STK,
  CVXX_USAGE,
  UNIT_COST,
  CURRENT_PLAN_INV$$,
  MAX_INV_$$,
  STRATEGY_GRP,
  LOT_MIN_BUY,
  AVG26_USAGE_QTY,
  STDEV26_USAGE,
  Q1_LINES,
  Q2_LINES,
  Q3_LINES,
  Q4_LINES,
  Q1_FREQ_COUNT,
  Q2_FREQ_COUNT,
  Q3_FREQ_COUNT,
  Q4_FREQ_COUNT,
  PDT
FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION@ROCKWELL_DBLINK
WHERE PROD_BU = 'KNX-KINETIX'
AND PLANTID  IN ('5041', '5051', '5071', '5101', '5111', '5121', '5141', '5161', '5191', '5201');



-----------------------------RISO--------------------------------------------
--Planning Param
SELECT DISTINCT *
FROM dwq$librarian.INV_SAP_PP_OPTIMIZATION
WHERE PLANTID            IN (0, upper(trim('5201')) )
AND MRP_CONTROLLER_DISPO IN ('', upper(trim('003')) )
AND ( MAX_OH_IN_09WEEKS   > 0
OR AVG52_USAGE_QTY        > 0)
ORDER BY OH_DOLLARS DESC;









--------------------------------Stock Item review report------------------------

--Total Sales Order Backlog
SELECT *
FROM
  (SELECT Material,
    plant,
    SUM(OPEN_QTY) AS TOTAL_OPEN
  FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
  WHERE MATERIAL IN
    (SELECT material
    FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
    WHERE plant IN ('5040', '5070', '5100', '5110', '5140', '5200')
    )
  GROUP BY material,
    plant
  )
WHERE material = 'PN-184723';

--PAST DUE 
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP WHERE Material = 'PN-184723' AND MAX_COMMIT_DATE < SYSDATE and plant = '5040';

SELECT *
FROM
  (SELECT Material,
    plant,
    SUM(OPEN_QTY) AS TOTAL_PASS_DUE
  FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
  WHERE MATERIAL IN
    (SELECT material
    FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
    WHERE plant IN ('5040', '5070', '5100', '5110', '5140', '5200')
    ) AND MAX_COMMIT_DATE < SYSDATE
  GROUP BY material,
    plant
  )
WHERE material = 'PN-184723';


--Avg Weekly Forecast
SELECT
    FPP.MATERIALID                    AS MATERIALID,
    FPP.PLANTID                       AS PLANTID,
    SUM(FPP.PLNMG_PLANNEDQUANTITY)/26 AS PLANNED_QUANTITY
  FROM DWQ$LIBRARIAN.INV_SAP_PP_FRCST_PBIM_PBED FPP
  WHERE (FPP.PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
  AND PLANTID IN ('5040', '5070', '5100', '5110', '5140', '5200') and MATERIALID IN
    (SELECT material
    FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
    WHERE plant IN ('5040', '5070', '5100', '5110', '5140', '5200')
    ) group by FPP.MATERIALID, FPP.PLANTID;


--Main Body
SELECT MATERIALID as Material,
PLANTID as Plant,
MATERIALID||''||PLANTID as Key,
MAT_DESC as Material_Description,
PROD_BU as BU,
PROC_TYPE as Procurement_Type,
MRP_CONTROLLER_DISPO as MRP_CONTROLLER_ID,
MRP_CONTROLLER as MRP_CONTROLLER,
MATL_TYPE_MTART as MATL_TYPE,
MRP_TYPE as MRP_TYPE,
STRATEGY_GRP as Stock_Strategy,
UNIT_COST as Unit_Price,
REORDER_PT as Reorder_Point,
SAFETY_STK as Safety_stock_Qty,
LOT_SIZE_DISLS as LOT_SIZE,
LOT_MIN_BUY as Min_LOT_SIZE,
LOT_ROUNDING_VALUE as Rounding_val,
GRT	as GRT,
PDT	 as PDT,
IPT	as IPT,
OH_QTY as	OH_QTY,
OH_$$	as OH_$$,
INV_MAX	as INV_MAX,
CURR_PLAN_INV_QTY as Target_Inv
FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION
WHERE STRATEGY_GRP = '40' AND MATL_TYPE_MTART IN ('ZFG','ZTG')
AND PLANTID  IN ('5040', '5070', '5100', '5110',  '5140', '5200');



---JOIN TOGETHER

SELECT *
FROM
  (SELECT MATERIALID
    ||'_'
    ||PLANTID  AS ID,
    MATERIALID AS Material,
    PLANTID    AS Plant,
    MATERIALID
    ||''
    ||PLANTID            AS KEY,
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
    OH_QTY               AS OH_QTY,
    OH_$$                AS OH_$$,
    INV_MAX              AS INV_MAX,
    CURR_PLAN_INV_QTY    AS Target_Inv
  FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION
  WHERE STRATEGY_GRP   = '40'
  AND MATL_TYPE_MTART IN ('ZFG','ZTG')
  AND PLANTID         IN ('5040', '5070', '5100', '5110', '5140', '5200')
  )pp
LEFT JOIN
  (SELECT fc_avg.id         AS ID,
    fc_avg.PLANNED_QUANTITY AS PLANNED_QUANTITY,
    backlog.TOTAL_OPEN
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID                     AS ID,
      MATERIALID                    AS MATERIALID,
      PLANTID                       AS PLANTID,
      ROUND(SUM(PLNMG_PLANNEDQUANTITY)/26 + 1,0) AS PLANNED_QUANTITY
    FROM DWQ$LIBRARIAN.INV_SAP_PP_FRCST_PBIM_PBED
    WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
    AND PLANTID                                                                     IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND VERSBP_VERSION = '55'
    AND MATERIALID                                                                  IN
      (SELECT material
      FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
      WHERE plant IN ('5040', '5070', '5100', '5110', '5140', '5200')
      )
    GROUP BY MATERIALID,
      MATERIALID
      ||'_'
      ||PLANTID,
      PLANTID
    )fc_avg
  LEFT JOIN
    (SELECT Material
      ||'_'
      ||PLANT AS ID,
      Material,
      plant,
      SUM(OPEN_QTY) AS TOTAL_OPEN
    FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
    WHERE plant  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MATERIAL IN
      (SELECT material
      FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
      WHERE plant IN ('5040', '5070', '5100', '5110', '5140', '5200')
      )
    GROUP BY Material
      ||'_'
      ||PLANT,
      Material,
      plant
    )backlog
  ON fc_avg.ID                 = backlog.ID
  )fc_avg_sum ON fc_avg_sum.ID = PP.ID ;

-------------------------------------------------------------------------------







CREATE TABLE INV_SAP_PP_FRCST_PBIM_PBED AS
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_FRCST_PBIM_PBED@ROCKWELL_DBLINK;

CREATE TABLE INV_SAP_SALES_VBAK_VBAP_VBUP AS
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP@ROCKWELL_DBLINK WHERE plant IN ('5040', '5070', '5100', '5110', '5140', '5200');

CREATE TABLE INV_SAP_PP_test_data AS
SELECT MATERIALID
    ||'_'
    ||PLANTID  AS ID,
    MATERIALID AS Material,
    PLANTID    AS Plant,
    MATERIALID
    ||''
    ||PLANTID               AS KEY,
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
  FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION@ROCKWELL_DBLINK
  WHERE STRATEGY_GRP   = '40'
  AND MATL_TYPE_MTART IN ('ZFG','ZTG')
  AND PLANTID         IN ('5040', '5070', '5100', '5110', '5140', '5200');
-------------------------------------------------------------------------------
  
SELECT * FROM STOCK_ITEM_PERFORMANCE;

--Fecth back to local
DROP TABLE STOCK_ITEM_PERFORMANCE;
CREATE TABLE STOCK_ITEM_PERFORMANCE AS
SELECT PP.ID              AS ID,
  PP.Material             AS Material,
  PP.Plant                AS Plant,
  PP.KEY                  AS KEY,
  PP.Material_Description AS Material_Description,
  PP.BU                   AS BU,
  PP.Procurement_Type     AS Procurement_Type,
  PP.MRP_CONTROLLER_ID    AS MRP_CONTROLLER_ID,
  PP.MRP_CONTROLLER       AS MRP_CONTROLLER,
  PP.MATL_TYPE            AS MATL_TYPE,
  PP.MRP_TYPE             AS MRP_TYPE,
  PP.Stock_Strategy       AS Stock_Strategy,
  PP.Unit_Price           AS Unit_Price,
  PP.Reorder_Point        AS Reorder_Point,
  PP.Safety_stock_Qty     AS Safety_stock_Qty,
  PP.LOT_SIZE             AS LOT_SIZE,
  PP.Min_LOT_SIZE         AS Min_LOT_SIZE,
  PP.Rounding_val         AS Rounding_val,
  PP.GRT                  AS GRT,
  PP.PDT                  AS PDT,
  PP.IPT                  AS IPT,
  PP.OH_QTY               AS OH_QTY,
  PP.OH_$$                AS OH_$$,
  FC_AVG_SUM.PLANNED_QUANTITY AS FC_AVG_WEEKLY,
  FC_AVG_SUM.TOTAL_OPEN      AS BACKLOG_SUM,
  FC_AVG_SUM.TOTAL_PASSDUE AS PASSDUE_SUM
FROM
  (SELECT MATERIALID
    ||'_'
    ||PLANTID  AS ID,
    MATERIALID AS Material,
    PLANTID    AS Plant,
    MATERIALID
    ||''
    ||PLANTID               AS KEY,
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
  FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION@ROCKWELL_DBLINK
  WHERE STRATEGY_GRP   = '40'
  AND MATL_TYPE_MTART IN ('ZFG','ZTG')
  AND PLANTID         IN ('5040', '5070', '5100', '5110', '5140', '5200')
  )PP
LEFT JOIN
  (SELECT FC_AVG.ID         AS ID,
    FC_AVG.PLANNED_QUANTITY AS PLANNED_QUANTITY,
    BACKLOG.TOTAL_OPEN AS TOTAL_OPEN,
    BACKLOG.TOTAL_PASSDUE AS TOTAL_PASSDUE
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID                     AS ID,
      MATERIALID                    AS MATERIALID,
      PLANTID                       AS PLANTID,
      ROUND(SUM(PLNMG_PLANNEDQUANTITY)/26 + 1, 0) AS PLANNED_QUANTITY
    FROM DWQ$LIBRARIAN.INV_SAP_PP_FRCST_PBIM_PBED@ROCKWELL_DBLINK
    WHERE (PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 182))
    AND PLANTID                                                                     IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND VERSBP_VERSION = '55'
    AND MATERIALID                                                                  IN
      (SELECT material
      FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP@ROCKWELL_DBLINK
      WHERE plant IN ('5040', '5070', '5100', '5110', '5140', '5200')
      )
    GROUP BY MATERIALID,
      MATERIALID
      ||'_'
      ||PLANTID,
      PLANTID
    )FC_AVG
  LEFT JOIN
    (
    SELECT TOTAL_OPEN.ID AS ID,
    TOTAL_OPEN.TOTAL_OPEN AS TOTAL_OPEN,
    total_passdue.passdue as TOTAL_PASSDUE
    FROM
    (SELECT Material
      ||'_'
      ||PLANT AS ID,
      Material,
      PLANT,
      SUM(OPEN_QTY) AS TOTAL_OPEN
    FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP@ROCKWELL_DBLINK
    WHERE PLANT  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MATERIAL IN
      (SELECT material
      FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP@ROCKWELL_DBLINK
      WHERE plant IN ('5040', '5070', '5100', '5110', '5140', '5200')
      )
    GROUP BY Material
      ||'_'
      ||PLANT,
      Material,
      plant)TOTAL_OPEN 
      left join
      (SELECT Material
      ||'_'
      ||PLANT AS ID,
      Material,
      PLANT,
      SUM(OPEN_QTY) AS passdue
    FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP@ROCKWELL_DBLINK
    WHERE PLANT  IN ('5040', '5070', '5100', '5110', '5140', '5200')
    AND MATERIAL IN
      (SELECT material
      FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP@ROCKWELL_DBLINK
      WHERE plant IN ('5040', '5070', '5100', '5110', '5140', '5200')
      )
    AND MAX_COMMIT_DATE < SYSDATE - 1
    GROUP BY Material
      ||'_'
      ||PLANT,
      Material,
      plant)total_passdue 
      ON total_passdue.ID = TOTAL_OPEN.ID
    )BACKLOG
  ON FC_AVG.ID                 = BACKLOG.ID
  )FC_AVG_SUM ON FC_AVG_SUM.ID = PP.ID ;
  