-- Unable to render VIEW DDL for object DWQ$LIBRARIAN.MPT_STK_NONSTK_TEST_STD_SHG_V with DBMS_METADATA attempting internal generator.
CREATE VIEW DWQ$LIBRARIAN.MPT_STK_NONSTK_TEST_STD_SHG_V AS
SELECT Getservice.MATERIALID,
  Getservice.SHIP_QTY,
  Getservice.SALES_QTY,
  Getservice.GBBB_SALES_AMT_USD,
  Getservice.Q1_LINE_COUNT_SALES_ORG,
  Getservice.Q2_LINE_COUNT_SALES_ORG,
  Getservice.Q3_LINE_COUNT_SALES_ORG,
  Getservice.Q4_LINE_COUNT_SALES_ORG,
  Getservice.Q1_LINE_LIMIT,
  Getservice.Q2_LINE_LIMIT,
  Getservice.Q3_LINE_LIMIT,
  Getservice.Q4_LINE_LIMIT,
  Getservice.Q3_GROWTH_LINE_LIMIT,
  Getservice.Q4_GROWTH_LINE_LIMIT,
  Getservice.Q1_FREQ_LIMIT,
  Getservice.Q2_FREQ_LIMIT,
  Getservice.Q3_FREQ_LIMIT,
  Getservice.Q4_FREQ_LIMIT,
  Getservice.AVG_SALES_QTY,
  Getservice.STDEV_SALES_QTY,
  Getservice.CATALOG_STRING1,
  Getservice.CATALOG_STRING2,
  Getservice.CEDC_STRATEGY_GRP SHG_STRATEGY_GRP,
  Getservice.DIRECT_SHIP_CUST,
  Getservice.DIRECT_SHIP_PLANT,
  Getservice.Q1_SALES_ORG_FREQ,
  Getservice.Q2_SALES_ORG_FREQ,
  Getservice.Q3_SALES_ORG_FREQ,
  Getservice.Q4_SALES_ORG_FREQ,
  Getservice.STOCK_BASED_ON_LINES,
  Getservice.NONSTOCK_BASED_ON_LINES,
  Getservice.EXPECTED_SHIP_PLANT_4000 EXPECTED_SHIP_PLANT_5003,
  Getservice.CURR_STRATEGY_GRP,
  Getservice.MAT_DESC,
  Getservice.PROD_FAM,
  Getservice.MRP_CONTROLLER,
  Getservice.PROD_SCHEDULER,
  Getservice.PROC_TYPE,
  Getservice.INV_CLASS,
  Getservice.ANALYSIS_LINESPEED,
  Getservice.ANALYSIS_WKSPEED,
  Getservice.UNIT_COST,
  Getservice.ANALYSIS_COST,
  Getservice.LOT_SIZE,
  Getservice.LEADTIME_WEEKS,
  Getservice.OPTIMAL_SERVISE_LEVEL,
  Getservice.MRP_TYPE,
  Getservice.SP_MATL_STAT_MMSTA,
  Getservice.SAFETY_STK,
  Getservice.NEW_STOCK_NONSTOCK_FAC,
  NVL (Serve.Stock_Service_Level, .5) Stock_Service_Level,
  CASE
    WHEN Getservice.New_Stock_Nonstock_Fac = Getservice.Expected_Ship_Plant_4000
    THEN Getservice.Leadtime_Weeks
    WHEN NVL (Getservice.Stock_Based_On_Lines, 'b') NOT IN ('Stock')
    THEN 0
    WHEN NVL (Getservice.Stock_Based_On_Lines, 'b') IN ('Stock')
    THEN Getservice.Leadtime_Weeks                   + 0.8
    ELSE Getservice.Leadtime_Weeks
  END New_Calc_Leadtime_Weeks,
  CASE
    WHEN (Getservice.Avg_Sales_Qty                              * Getservice.Leadtime_Weeks) = 0
    OR Getservice.Nonstock_Based_On_Lines                      IN ('Non-stock')
    THEN 0.5
    WHEN (serve.Stock_Service_Level            - ( (getservice.Lot_Size / ( (getservice.Avg_Sales_Qty * getservice.Leadtime_Weeks))) * (1 - serve.Stock_Service_Level))) < serve.Stock_Service_Level - .2
    THEN GREATEST (serve.Stock_Service_Level   - .2, .5)
    ELSE GREATEST ( (serve.Stock_Service_Level - ( (getservice.Lot_Size / ( (getservice.Avg_Sales_Qty * getservice.Leadtime_Weeks))) * (1 - serve.Stock_Service_Level))), .5)
  END Service_Level_LS_Factor,
  SYSDATE DWQ_EXTRACT_DATE,
  NVL (Getservice.Exchange_Rate, 1) Exchange_Rate,                                                                                        --CPZ Added 03-26-2012
  getservice.Q1_COMPLIANCE,                                                                                                               --CPZ Added 03-26-2012
  getservice.Q2_COMPLIANCE,                                                                                                               --CPZ Added 03-26-2012
  getservice.Q3_COMPLIANCE,                                                                                                               --CPZ Added 03-26-2012
  getservice.Q4_COMPLIANCE,                                                                                                               --CPZ Added 03-26-2012
  Unit_Cost * (GREATEST (NVL (getservice.Avg_Sales_Qty, 0), LOT_SIZE * 0.5, NVL (AVG26_USAGE_QTY, 0)) + Safety_Stk) Planned_Inventory_$$, --CPZ Added 03-26-2012
  getservice.Preferred_Product                                                                                                            --CPZ Added 03-27-2012
  ,
  getservice.PROD_HIERARCHY --CPZ Added 05-09-2012
  ,
  getservice.PROFIT_CTR_PRCTR Profit_Center, --CPZ Added 05-09-2012
  getservice.Watch_List_Based_On_Lines,
  getservice.q3_q4_threshold
FROM
  (SELECT Stock_Decision.*,
    optim.strategy_grp Curr_strategy_grp,
    optim.mat_desc,
    optim.prod_fam,
    optim.mrp_controller,
    OPTIM.PROD_HIERARCHY, --CPZ Added 05-09-2012
    optim.prod_scheduler,
    optim.proc_type,
    optim.inv_class,
    optim.analysis_linespeed,
    optim.analysis_wkspeed,
    Optim.Unit_Cost,
    optim.analysis_cost,
    optim.Lot_Size,
    Optim.Leadtime_Weeks,
    Optim.Optimal_Servise_Level,
    Optim.Mrp_Type,
    optim.sp_matl_stat_mmsta,
    --                     optim.Q1_FREQ_COUNT,
    --                     optim.Q2_FREQ_COUNT,
    --                     optim.Q3_FREQ_COUNT,
    --                     Optim.Q4_Freq_Count,
    optim.SAFETY_STK,
    CASE
      WHEN NVL (Optim.Strategy_Grp, 'Not') NOT                 IN ('40', 'ZB')
      AND Stock_Decision.Stock_Based_On_Lines                  IN ('Stock')
      AND TO_NUMBER ( Stock_Decision.Expected_Ship_Plant_4000) IN '5040'
      THEN 5040 --CPZ Added 02-03-2012
      WHEN NVL (Optim.Strategy_Grp, 'Not') NOT                     IN ('40', 'ZB')
      AND Stock_Decision.Stock_Based_On_Lines                      IN ('Stock')
      AND TO_NUMBER ( Stock_Decision.Expected_Ship_Plant_4000) NOT IN '5040'
      THEN 5040
      WHEN Optim.Strategy_Grp                    IN ('40', 'ZB')
      AND Stock_Decision.Nonstock_Based_On_Lines IN ('Non-stock')
      THEN TO_NUMBER ( Stock_Decision.Expected_Ship_Plant_4000)
      ELSE TO_NUMBER ( Stock_Decision.Expected_Ship_Plant_4000)
    END New_Stock_NonStock_Fac,
    optim.Exchange_Rate,  --CPZ Added 03-26-2012
    optim.Q1_COMPLIANCE,  --CPZ Added 03-26-2012
    optim.Q2_COMPLIANCE,  --CPZ Added 03-26-2012
    optim.Q3_COMPLIANCE,  --CPZ Added 03-26-2012
    optim.Q4_COMPLIANCE,  --CPZ Added 03-26-2012
    optim.AVG26_USAGE_QTY --CPZ Added 03-26-2012
    ,
    pp.PROFIT_CTR_PRCTR --CPZ Added 05-09-2012
  FROM
    (SELECT salessummary.*,
      CASE
        WHEN salessummary.Q3_Line_Count_Sales_Org                                                           + salessummary.Q3_Line_Count_Sales_Org >= Q3_Q4_THRESHOLD
        AND salessummary.Q3_Line_Count_Sales_Org                                         >= Q3_Q4_THRESHOLD * .25
        AND salessummary.Q4_Line_Count_Sales_Org                                         >= Q3_Q4_THRESHOLD * .25
        THEN 'Stock'
        ELSE NULL
      END Stock_Based_On_Lines,
      CASE
        WHEN (salessummary.Q3_Line_Count_Sales_Org                                                          + salessummary.Q4_Line_Count_Sales_Org < Q3_Q4_THRESHOLD
        AND (salessummary.Q4_Line_Count_Sales_Org                                         < Q3_Q4_THRESHOLD * .5
        OR salessummary.Q3_Line_Count_Sales_Org                                           < Q3_Q4_THRESHOLD * .5))
        THEN 'Watch List'
        ELSE NULL
      END Watch_List_Based_On_Lines,
      CASE
        WHEN (salessummary.Q3_Line_Count_Sales_Org                                                          + salessummary.Q4_Line_Count_Sales_Org < Q3_Q4_THRESHOLD
        AND salessummary.Q4_Line_Count_Sales_Org                                          < Q3_Q4_THRESHOLD * .5
        AND salessummary.Q3_Line_Count_Sales_Org                                          < Q3_Q4_THRESHOLD * .5)
        THEN 'Non-stock'
        ELSE NULL
      END Nonstock_Based_On_Lines,
      CASE
        WHEN Salessummary.Direct_Ship_Cust IN ('X')
        THEN Salessummary.Direct_Ship_Plant
        WHEN Salessummary.Cedc_Strategy_Grp IN ('40', 'ZB')
        THEN TO_CHAR (5040)
        WHEN NVL (Salessummary.Cedc_Strategy_Grp, 'Does not exist') IN ('Does not exist')
        THEN Salessummary.Direct_Ship_Plant
        ELSE TO_CHAR (5040)
      END Expected_Ship_Plant_4000
    FROM
      (
      /*,Case When (Decis.q1_freq_count <4 And Decis.q2_freq_count <4 And Decis.q3_freq_count <4 And Decis.q4_freq_count <4) Then
      'Non-stock'
      Else 'Further Review'
      End NonStock_based_on_Weeks */
      SELECT Salessummary1.Materialid,
        Salessummary1.Ship_Qty Ship_Qty,
        Salessummary1.Sales_Qty Sales_Qty,
        Salessummary1.Gbbb_Sales_Amt_USD Gbbb_Sales_Amt_USD,
        Salessummary1.Q1_Line_Count_Sales_Org Q1_Line_Count_Sales_Org,
        Salessummary1.Q2_Line_Count_Sales_Org Q2_Line_Count_Sales_Org,
        Salessummary1.Q3_Line_Count_Sales_Org Q3_Line_Count_Sales_Org,
        Salessummary1.Q4_Line_Count_Sales_Org Q4_Line_Count_Sales_Org,
        NSPARAM.Q1_LINE_COUNT_SALES_ORG Q1_LINE_LIMIT,
        NSPARAM.Q2_LINE_COUNT_SALES_ORG Q2_LINE_LIMIT,
        NSPARAM.Q3_LINE_COUNT_SALES_ORG Q3_LINE_LIMIT,
        NSPARAM.Q4_LINE_COUNT_SALES_ORG Q4_LINE_LIMIT,
        NSPARAM.Q3_LINE_COUNT_SALES_ORG_GROWTH Q3_GROWTH_LINE_LIMIT,
        NSPARAM.Q4_LINE_COUNT_SALES_ORG_GROWTH Q4_GROWTH_LINE_LIMIT,
        NSPARAM.Q1_SALES_ORG_FREQ Q1_FREQ_LIMIT,
        NSPARAM.Q2_SALES_ORG_FREQ Q2_FREQ_LIMIT,
        NSPARAM.Q3_SALES_ORG_FREQ Q3_FREQ_LIMIT,
        NSPARAM.Q4_SALES_ORG_FREQ Q4_FREQ_LIMIT,
        nsparam.Q3_Q4_THRESHOLD,
        Salessummary1.Avg_Sales_Qty Avg_Sales_Qty,
        ROUND ( SQRT ( (POWER ( W52_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W51_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W50_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W49_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W48_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W47_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W46_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W45_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W44_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W43_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W42_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W41_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W40_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W39_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W38_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W37_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W36_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W35_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W34_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W33_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER (
        W32_Sales_ORG_Qty                         - AVG_SALES_QTY, 2) + POWER ( W31_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W30_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W29_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W28_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W27_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W26_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W25_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W24_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W23_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W22_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W21_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W20_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W19_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W18_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W17_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W16_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W15_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W14_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W13_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER (
        W12_Sales_ORG_Qty                         - AVG_SALES_QTY, 2) + POWER ( W11_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W10_Sales_Org_Qty - Avg_Sales_Qty, 2) + POWER ( W09_Sales_Org_Qty - Avg_Sales_Qty, 2) + POWER ( W08_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W07_Sales_Org_Qty - Avg_Sales_Qty, 2) + POWER ( W06_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W05_Sales_Org_Qty - Avg_Sales_Qty, 2) + POWER ( W04_Sales_ORG_Qty - AVG_SALES_QTY, 2) + POWER ( W03_Sales_Org_Qty - Avg_Sales_Qty, 2) + POWER ( W02_Sales_Org_Qty - Avg_Sales_Qty, 2) + POWER ( W01_Sales_Org_Qty - Avg_Sales_Qty, 2)) / 51), 2) Stdev_Sales_Qty,
        Cat.Catalog_String1 Catalog_String1,
        Cat.Catalog_String2 Catalog_String2,
        Cedc.Strategy_Grp Cedc_Strategy_Grp,
        Mvke.Direct_Ship_Cust Direct_Ship_Cust,
        mvke.direct_ship_plant direct_ship_plant,
        mvke.Preferred_Product Preferred_Product, --CPZ Added 03-27-2011
        --                                        CASE WHEN Salessummary.Direct_Ship_Cust IN ('X') THEN   Salessummary.Direct_Ship_Plant
        --                                           WHEN Salessummary.Cdc_Strategy_Grp IN ('40', 'ZB')THEN TO_CHAR (1090)
        --                                           WHEN NVL (Salessummary.Cdc_Strategy_Grp, 'Does not exist') IN ('Does not exist')
        --                                           THEN Salessummary.Direct_Ship_Plant
        --                                           ELSE TO_CHAR (1090)
        --                                        END
        --                                           Expected_Ship_Plant_1000,
        ( LEAST (W52_SALES_ORG_QTY, 1) + LEAST (W51_SALES_ORG_QTY, 1) + LEAST (W50_SALES_ORG_QTY, 1) + LEAST (W49_SALES_ORG_QTY, 1) + LEAST (W48_SALES_ORG_QTY, 1) + LEAST (W47_SALES_ORG_QTY, 1) + LEAST (W46_SALES_ORG_QTY, 1) + LEAST (W45_SALES_ORG_QTY, 1) + LEAST (W44_SALES_ORG_QTY, 1) + LEAST (W43_SALES_ORG_QTY, 1) + LEAST (W42_SALES_ORG_QTY, 1) + LEAST (W41_SALES_ORG_QTY, 1) + LEAST (W40_SALES_ORG_QTY, 1)) Q1_SALES_ORG_FREQ,
        ( LEAST (W39_SALES_ORG_QTY, 1) + LEAST (W38_SALES_ORG_QTY, 1) + LEAST (W37_SALES_ORG_QTY, 1) + LEAST (W36_SALES_ORG_QTY, 1) + LEAST (W35_SALES_ORG_QTY, 1) + LEAST (W34_SALES_ORG_QTY, 1) + LEAST (W33_SALES_ORG_QTY, 1) + LEAST (W32_SALES_ORG_QTY, 1) + LEAST (W31_SALES_ORG_QTY, 1) + LEAST (W30_SALES_ORG_QTY, 1) + LEAST (W29_SALES_ORG_QTY, 1) + LEAST (W28_SALES_ORG_QTY, 1) + LEAST (W27_SALES_ORG_QTY, 1)) Q2_SALES_ORG_FREQ,
        ( LEAST (W26_SALES_ORG_QTY, 1) + LEAST (W25_SALES_ORG_QTY, 1) + LEAST (W24_SALES_ORG_QTY, 1) + LEAST (W23_SALES_ORG_QTY, 1) + LEAST (W22_SALES_ORG_QTY, 1) + LEAST (W21_SALES_ORG_QTY, 1) + LEAST (W20_SALES_ORG_QTY, 1) + LEAST (W19_SALES_ORG_QTY, 1) + LEAST (W18_SALES_ORG_QTY, 1) + LEAST (W17_SALES_ORG_QTY, 1) + LEAST (W16_SALES_ORG_QTY, 1) + LEAST (W15_SALES_ORG_QTY, 1) + LEAST (W14_SALES_ORG_QTY, 1)) Q3_SALES_ORG_FREQ,
        ( LEAST (W13_SALES_ORG_QTY, 1) + LEAST (W12_SALES_ORG_QTY, 1) + LEAST (W11_SALES_ORG_QTY, 1) + LEAST (W10_SALES_ORG_QTY, 1) + LEAST (W09_SALES_ORG_QTY, 1) + LEAST (W08_SALES_ORG_QTY, 1) + LEAST (W07_SALES_ORG_QTY, 1) + LEAST (W06_SALES_ORG_QTY, 1) + LEAST (W05_SALES_ORG_QTY, 1) + LEAST (W04_SALES_ORG_QTY, 1) + LEAST (W03_SALES_ORG_QTY, 1) + LEAST (W02_SALES_ORG_QTY, 1) + LEAST (W01_SALES_ORG_QTY, 1)) Q4_SALES_ORG_FREQ
        --,stddev(W52_Sales_ORG_Qty,W51_Sales_ORG_Qty)
      FROM
        (SELECT Salessto.Materialid Materialid
          /* Need to group by Sales Org as well*/
          ,
          ROUND ( SUM ( NVL ( Salessto.Shipqty, 0)), 0) Ship_Qty,
          ROUND ( SUM (
          CASE
            WHEN salessto.DEM_SOURCE = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END), 0) Sales_Qty,
          ROUND ( (SUM (
          CASE
            WHEN salessto.DEM_SOURCE = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) / 52), 0) Avg_Sales_Qty,
          COUNT ( DISTINCT (Line_count)) Total_Sales_LineCount,
          ROUND ( SUM (
          CASE
            WHEN salessto.DEM_SOURCE = 'SALES'
            THEN GBBB_SALES_AMT_USD
            ELSE 0
          END), 0) GBBB_SALES_AMT_USD,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 365
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 275
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN 1
            ELSE 0
          END) Q1_Line_Count_Sales_Org,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 274
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 184
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN 1
            ELSE 0
          END) Q2_Line_Count_Sales_Org,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 183
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 93
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN 1
            ELSE 0
          END) Q3_Line_Count_Sales_Org,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 92
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE)
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN 1
            ELSE 0
          END) Q4_Line_Count_Sales_Org,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 365
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 359
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W52_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 358
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 352
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W51_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 351
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 345
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W50_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 344
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 338
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W49_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 337
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 331
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W48_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 330
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 324
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W47_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 323
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 317
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W46_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 316
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 310
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W45_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 309
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 303
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W44_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 302
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 296
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W43_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 295
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 289
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W42_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 288
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 282
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W41_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 281
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 275
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W40_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 274
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 268
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W39_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 267
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 261
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W38_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 260
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 254
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W37_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 253
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 247
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W36_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 246
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 240
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W35_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 239
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 233
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W34_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 232
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 226
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W33_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 225
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 219
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W32_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 218
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 212
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W31_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 211
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 205
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W30_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 204
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 198
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W29_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 197
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 191
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W28_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 190
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 184
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W27_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 183
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 177
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W26_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 176
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 170
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W25_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 169
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 163
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W24_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 162
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 156
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W23_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 155
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 149
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W22_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 148
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 142
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W21_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 141
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 135
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W20_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 134
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 128
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W19_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 127
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 121
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W18_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 120
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 114
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W17_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 113
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 107
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W16_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 106
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 100
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W15_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 99
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 93
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W14_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 92
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 86
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W13_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 85
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 79
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W12_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 78
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 72
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W11_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 71
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 65
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W10_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 64
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 58
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W09_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 57
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 51
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W08_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 50
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 44
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W07_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 43
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 37
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W06_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 36
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 30
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W05_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 29
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 23
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W04_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 22
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 16
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W03_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 15
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 9
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W02_Sales_Org_Qty,
          SUM (
          CASE
            WHEN salessto.LINECREATIONDATE >= TRUNC ( SYSDATE) - 8
            AND salessto.LINECREATIONDATE  <= TRUNC ( SYSDATE) - 1
            AND NVL ( salessto.SHIPQTY, 0)  > 0
            AND salessto.DEM_SOURCE         = 'SALES'
            THEN NVL ( salessto.SHIPQTY, 0)
            ELSE 0
          END) W01_Sales_Org_Qty
        FROM
          (SELECT TRIM ('SALES') DEM_SOURCE,
            s1.materialid,
            SALESDOC
            || '-'
            || SALESDOCITEM Line_count,
            SHIPQTY * (NVL ( pp.PO_UOM_NUMERATOR, 1) / NVL ( pp.PO_UOM_DENOMINATOR, 1)) SHIPQTY, --CPZ Commented Out 12-2-2011
            -- SHIPQTY,
            0 Outlier_Override,
            NVL ( GBBB_SALES_AMT_USD, 0) GBBB_SALES_AMT_USD,
            LINECREATIONDATE,
            CASE
              WHEN COMMITTEDDATE                                                    < TRUNC ( SYSDATE)
              OR NVL ( LastActGIDate, NVL ( GBBB_SHIP_DATE, TRUNC ( SYSDATE) + 10)) < TRUNC ( SYSDATE)
              THEN 1
              ELSE 0
            END OrderLine_Counted,
            OnTimeTo_Confirmed,
            RequiredDeliveryDate Delivery_date,
            COMMITTEDDATE COMMIT_DATE,
            NVL ( LastActGIDate, GBBB_SHIP_DATE) SHIPPED_DATE,
            '0' MATL_FIRST_USED,
            TO_CHAR ( LINECREATIONDATE, 'yyyymm') yyyymm,
            s1.plantid plantid,
            PP.MATL_TYPE_MTART MATL_TYPE_MTART
            --,0 Source_list_plant --- Added 3/10/2011 for union with stos below
          FROM DWQ$LIBRARIAN.INV_SAP_SALES_HST s1,
            (SELECT * FROM DWQ$LIBRARIAN.Inv_Sap_Pp_Param
            ) pp
          WHERE s1.MATERIALID        = pp.MATERIALID(+)
          AND S1.Plantid             = Pp.Plantid(+)
          AND s1.REASONFORREJECTION IS NULL
          AND s1.shipqty             > 0
          AND s1.LINECREATIONDATE   <= SYSDATE
          AND S1.Linecreationdate   >= SYSDATE - 365
          AND NVL ( S1.SALES_ORG, 0000) LIKE ('5003%')
          ) salessto --CPZ 03-29-2012 changed from 4000 to like 4 10-29-2013 changed on request of Simon Yang to only include 5014
        WHERE salessto.MATL_TYPE_MTART IN ('ZFG', 'ZTG')
        GROUP BY salessto.materialid --order by sum(salessto.SHIPQTY ) desc
        ) Salessummary1
        --group by Salessummary1.Materialid
      LEFT OUTER JOIN
        (SELECT MAX (
          CASE
            WHEN cat.ICN_ATINN IN ('0000000157')
            THEN cat.CHARACTERISTIC_VALUE1
            ELSE ''
          END) CATALOG_STRING1,
          MAX (
          CASE
            WHEN cat.ICN_ATINN IN ('0000000158')
            THEN cat.CHARACTERISTIC_VALUE1
            ELSE ''
          END) CATALOG_STRING2,
          cat.Materialid Materialid
        FROM dwq$librarian.inv_sap_pp_char_pon cat
        WHERE (cat.ICN_ATINN     IN ('0000000157')
        OR cat.ICN_ATINN         IN ('0000000158'))
        AND cat.CLASS_TYPE_KLART IN ('Z90')
        GROUP BY cat.materialid --CPZ 03-29-2012
        ) Cat
      ON Salessummary1.Materialid = Cat.Materialid
      LEFT OUTER JOIN
        (SELECT cedc.materialid,
          cedc.plantid,
          cedc.strategy_grp
        FROM dwq$librarian.inv_sap_pp_optimization cedc
        WHERE cedc.plantid IN ('5040')
        ) cedc
      ON Salessummary1.materialid = cedc.materialid
      LEFT OUTER JOIN
        (SELECT mvke.materialid materialid,
          MAX (mvke.direct_ship_cust) direct_ship_cust,
          MAX (mvke.direct_ship_plant) direct_ship_plant,
          MAX (mvke.Preferred_Product) Preferred_Product --CPZ Added 03-27-2012
        FROM DWQ$LIBRARIAN.inv_sap_pp_mvke mvke
        WHERE mvke.sales_org IN ('5003')
        GROUP BY mvke.materialid
        ) Mvke
      ON Salessummary1.materialid = mvke.materialid,
        INVANALYST.MPT_STK_NONSTK_PARAM_STD_SHG NSPARAM
      ) salessummary
    ) stock_decision
  LEFT OUTER JOIN DWQ$LIBRARIAN.inv_sap_pp_optimization optim
  ON stock_decision.Materialid                                                                                            = Optim.Materialid
  AND TO_NUMBER ( DECODE ( stock_decision.Expected_Ship_Plant_4000, 5040, 5041, stock_decision.Expected_Ship_Plant_4000)) = Optim.Plantid
  LEFT OUTER JOIN DWQ$LIBRARIAN.inv_sap_pp_param pp
  ON stock_decision.Materialid                = pp.Materialid
  AND stock_decision.Expected_Ship_Plant_4000 = pp.plantid
  ) Getservice
LEFT OUTER JOIN
  (SELECT Serve.Analysis_Cost_X,
    Serve.ANALYSIS_LINESPEED_X,
    serve.level_type,
    serve.level_value,
    serve.SERVICE_LEVEL Stock_Service_Level
  FROM Dwq$librarian.Inv_Sap_Pp_Service_Levels Serve
  WHERE Serve.Servise_Level_Type IN ('TICPOF')
  AND Serve.Plantid              IN ('5041')
  AND Serve.Level_Type           IN ('2-PRODLINE')
  ) Serve
ON Getservice.Analysis_Cost            = Serve.Analysis_Cost_X
AND Getservice.analysis_linespeed      = serve.ANALYSIS_LINESPEED_X
AND SUBSTR (getservice.prod_fam, 1, 7) = SERVE.LEVEL_Value
WHERE NVL (Getservice.Inv_Class, 'b') NOT LIKE ('%SC_SS%')
AND NVL (Getservice.Inv_Class, 'b') NOT LIKE ('%PON%')
AND NVL (Getservice.Inv_Class, 'b') NOT LIKE ('%LTB%')
AND NVL (Getservice.Inv_Class, 'b') NOT LIKE ('%ACTIVE NEW PARTS%')
AND NVL (Getservice.mrp_controller, 'b') NOT LIKE ('%INDZ%') --CPZ 10-18-2011 Added
AND NVL (Getservice.Mrp_Type, 'b') NOT         IN ('ND')
AND TRIM (Getservice.Sp_Matl_Stat_Mmsta)       IS NULL
AND (NVL (getservice.CATALOG_STRING1, 'b') NOT IN ('b')
OR NVL (getservice.CATALOG_STRING2, 'b') NOT   IN ('b'))