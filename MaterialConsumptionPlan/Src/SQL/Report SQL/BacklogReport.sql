---------------------------------------------------------------------------
--Backlog report sql file
---SO detail information
---PO detail information
---PR detail information
---INV detail information
---------------------------------------------------------------------------

----SO detail information
----Need to add ship-to information and Customer Name
----The data just two days ago... But CDC is one day before.
Select * from DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP where SALESDOC = '6501808127'; 
Select * from DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP where LINECREATEDATE = '15-APR-14' and plant = '1090'; 
Select * from DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP where MATERIAL = '1756-N2 B' and plant = '5050';

----Ship-To&Sold-To Info
-----Sold-To Party
select * from DWQ$LIBRARIAN.INV_SAP_SHIP_SOLD_TO_PARTYID where SHIP_SOLD_TOPARTY = '91312369';

-----Ship-To Party
select * from DWQ$LIBRARIAN.INV_SAP_SHIP_SOLD_TO_PARTYID where SHIP_SOLD_TOPARTY = '91316290';



----INV detail information
----Need to Supplier,	Supplier Stock, Safty Stock, Item Leadtime, Item Standard Cost, Item Description,ABC_Class
----STRATEGY_GRP
SELECT * FROM DWQ$LIBRARIAN.INV_SAP_INVENTORY_BY_PLANT WHERE PLANTID = '5050';



----PR detail information

SELECT *
FROM DWQ$LIBRARIAN.INV_SAP_PO_EKPO
WHERE PLANTID              = '5050'
AND MATERIALID             = '1756-N2 B'
AND ELIKZDELIVERYCOMPLETE IS NULL;

select * from DWQ$LIBRARIAN.INV_SAP_PO_EKPO WHERE PLANTID in('5050','5040') AND ELIKZDELIVERYCOMPLETE is null;








------------------------------------------------------------------
SELECT SALESDOC             AS Customer_Order ,
  SALESDOCITEM              AS Item ,
  MATERIAL                  AS Material ,
  PLANT                     AS Plant ,
  LINECREATEDATE            AS Line_Creation_Date ,
  PRODHIER                  AS ProdHier ,
  ORDERQTY                  AS Order_Qty ,
  CONFIRMQTY                AS Confirm_Qty ,
  DELIVPRIO                 AS Delivery_Prioriy ,
  SALESPRICE                AS Sales_Price ,
  MAX_COMMIT_DATE           AS Committed_Date ,
  MAX_CONFIRM_DATE          AS Confirm_Date ,
  SOLD_TO                   AS Sold_To_Party ,
  SALESDOCTYPE              AS Salues_Doc_Type ,
  REJECTREASON_ABGRU        AS Reject_Reason ,
  SALEDOCITEMCATEGORY_PSTYV AS Sale_Doc_Item_Catalog ,
  SHIPFROM_VSTEL            AS Shipping_Point ,
  SALES_ORG                 AS Sales_Org ,
  CURRENCY                  AS Currency ,
  OPEN_QTY                  AS Open_Qty ,
  LST_ACT_GI_DATE           AS Last_Act_GI_Date ,
  LST_DELV_CREATED_DATE     AS Last_Delv_Created_Date
FROM DWQ$LIBRARIAN.INV_SAP_SALES_VBAK_VBAP_VBUP
WHERE PLANT IN ('5040','5050');
