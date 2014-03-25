--Create DBLink
select * from user_sys_privs where privilege like upper('%DATABASE LINK%');  
grant create public database link to system;  
select * from global_name; 
create public database link ORCL_HMY_DLINK connect to system identified by abc using 'hmy';
SELECT * FROM  help@ORCL_HMY_DLINK;

////////////////////////////////////////////////////////////////////////////////////////////////////////
--Copy table from ra to local

CREATE TABLE INV_SAP_MATERIAL_CATALOG AS
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_MATERIAL_CATALOG@ROCKWELL_DBLINK; 

CREATE TABLE INV_SAP_PP_OPTIMIZATION AS
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_OPTIMIZATION@ROCKWELL_DBLINK; 

CREATE TABLE INV_SAP_PP_MVKE AS
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_MVKE@ROCKWELL_DBLINK; 

CREATE TABLE INV_SAP_VENDOR_PLANT_INFO AS
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_VENDOR_PLANT_INFO@ROCKWELL_DBLINK;

CREATE TABLE INV_SAP_PP_FRCST_PBIM_PBED AS
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_PP_FRCST_PBIM_PBED@ROCKWELL_DBLINK;


