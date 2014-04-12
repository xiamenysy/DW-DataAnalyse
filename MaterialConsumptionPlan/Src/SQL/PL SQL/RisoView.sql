-- Unable to render VIEW DDL for object DWQ$LIBRARIAN.INV_SAP_PP_MATERIAL_GROWTH_V with DBMS_METADATA attempting internal generator.
CREATE VIEW DWQ$LIBRARIAN.INV_SAP_PP_MATERIAL_GROWTH_V AS
SELECT par.*,
  ROUND (
  CASE
    WHEN AVGXX_USAGE_QTY IS NULL
    OR AVGXX_USAGE_QTY   <= 1
    THEN 1
    ELSE STDEVXX_USAGE / AVGXX_USAGE_QTY
  END, 4) AS CVxx_USAGE,
  CASE
    WHEN ABC_CLASS_MAABC = 'A'
    AND INV_CLASS LIKE 'ACTIVE%'
    AND INV_CLASS NOT LIKE '%WAMMY%'
    THEN (AVGXX_USAGE_QTY)
    WHEN ABC_CLASS_MAABC = 'B'
    AND INV_CLASS LIKE 'ACTIVE%'
    AND INV_CLASS NOT LIKE '%WAMMY%'
    THEN 2 * (AVGXX_USAGE_QTY)
    WHEN ABC_CLASS_MAABC = 'C'
    AND INV_CLASS LIKE 'ACTIVE%'
    AND INV_CLASS NOT LIKE '%WAMMY%'
    THEN 12 * (AVGXX_USAGE_QTY)
    WHEN ABC_CLASS_MAABC = 'D'
    AND INV_CLASS LIKE 'ACTIVE%'
    AND INV_CLASS NOT LIKE '%WAMMY%'
    THEN 16 * AVGXX_USAGE_QTY
    ELSE 1
  END AS PowerOf2,
  CASE
    WHEN UNIT_COST <= 0
    THEN '4-NoCost'
    WHEN UNIT_COST <= COST_MIN
    THEN '3-Inexpensive'
    WHEN UNIT_COST >= COST_Max
    THEN '1-Expensive'
    ELSE '2-Medium'
  END Analysis_Cost,
  CASE
    WHEN SUBSTR (STATISTICSTYPE, -2, 2) = '26'
    THEN
      CASE
        WHEN NVL (Q1_FREQ_COUNT, 0) <= InactiveWk_Max
        AND NVL (Q2_FREQ_COUNT, 0)  <= InactiveWk_Max
        AND NVL (Q3_FREQ_COUNT, 0)  <= 0
        AND NVL (Q4_FREQ_COUNT, 0)  <= 0
        THEN '5-Inactive'
        WHEN NVL (Q3_FREQ_COUNT, 0) <= DoubleWammyWk_Max
        AND NVL (Q4_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
        THEN '4-DblWammy'
        WHEN NVL (Q3_FREQ_COUNT, 0) <= LowSpeedWk_Max
        AND NVL (Q4_FREQ_COUNT, 0)  <= LowSpeedWk_Max
        THEN '3-Slow'
        WHEN NVL (Q3_FREQ_COUNT, 0) >= HighSpeedWk_Min
        AND NVL (Q4_FREQ_COUNT, 0)  >= HighSpeedWk_Min
        THEN '1-Fast'
        ELSE '2-Medium'
      END
    WHEN SUBSTR (STATISTICSTYPE, -2, 2) = '13'
    THEN
      CASE
        WHEN NVL (Q1_FREQ_COUNT, 0) <= InactiveWk_Max
        AND NVL (Q2_FREQ_COUNT, 0)  <= InactiveWk_Max
        AND NVL (Q3_FREQ_COUNT, 0)  <= 0
        AND NVL (Q4_FREQ_COUNT, 0)  <= 0
        THEN '5-Inactive'
        WHEN NVL (Q4_FREQ_COUNT, 0) <= DoubleWammyWk_Max
        THEN '4-DblWammy'
        WHEN NVL (Q4_FREQ_COUNT, 0) <= LowSpeedWk_Max
        THEN '3-Slow'
        WHEN NVL (Q4_FREQ_COUNT, 0) >= HighSpeedWk_Min
        THEN '1-Fast'
        ELSE '2-Medium'
      END
    ELSE
      CASE
        WHEN NVL (Q1_FREQ_COUNT, 0) <= InactiveWk_Max
        AND NVL (Q2_FREQ_COUNT, 0)  <= InactiveWk_Max
        AND NVL (Q3_FREQ_COUNT, 0)  <= 0
        AND NVL (Q4_FREQ_COUNT, 0)  <= 0
        THEN '5-Inactive'
        WHEN NVL (Q1_FREQ_COUNT, 0) <= DoubleWammyWk_Max
        AND NVL (Q2_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
        AND NVL (Q3_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
        AND NVL (Q4_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
        THEN '4-DblWammy'
        WHEN NVL (Q1_FREQ_COUNT, 0) <= LowSpeedWk_Max
        AND NVL (Q2_FREQ_COUNT, 0)  <= LowSpeedWk_Max
        AND NVL (Q3_FREQ_COUNT, 0)  <= LowSpeedWk_Max
        AND NVL (Q4_FREQ_COUNT, 0)  <= LowSpeedWk_Max
        THEN '3-Slow'
        WHEN NVL (Q1_FREQ_COUNT, 0) >= HighSpeedWk_Min
        AND NVL (Q2_FREQ_COUNT, 0)  >= HighSpeedWk_Min
        AND NVL (Q3_FREQ_COUNT, 0)  >= HighSpeedWk_Min
        AND NVL (Q4_FREQ_COUNT, 0)  >= HighSpeedWk_Min
        THEN '1-Fast'
        ELSE '2-Medium'
      END
  END AS Analysis_WkSpeed,
  CASE
    WHEN Q1_NumOfLines                                                                                    + Q2_NumOfLines + Q3_NumOfLines + Q4_NumOfLines                            = 0
    AND NVL (Q1_FREQ_COUNT, 0)                                                                            + NVL (Q2_FREQ_COUNT, 0) + NVL (Q3_FREQ_COUNT, 0) + NVL (Q4_FREQ_COUNT, 0) > 0
    AND SERVISE_LEVEL_TYPE NOT                                                                           IN ('TICPOF', 'CLM', 'CSLM')
    THEN 'X'
    WHEN Q1_NumOfLines <= InactiveLn_Max
    AND Q2_NumOfLines  <= InactiveLn_Max
    AND Q3_NumOfLines  <= 0
    AND Q4_NumOfLines  <= 0
    THEN '5-Inactive'
    WHEN Q1_NumOfLines <= DoubleWammyLn_Max
    AND Q2_NumOfLines  <= DoubleWammyLn_Max
    AND Q3_NumOfLines  <= DoubleWammyLn_Max
    AND Q4_NumOfLines  <= DoubleWammyLn_Max
    THEN '4-DblWammy'
    WHEN Q1_NumOfLines <= LowSpeedLn_Max
    AND Q2_NumOfLines  <= LowSpeedLn_Max
    AND Q3_NumOfLines  <= LowSpeedLn_Max
    AND Q4_NumOfLines  <= LowSpeedLn_Max
    THEN '3-Slow'
    WHEN Q1_NumOfLines >= HighSpeedLn_Min
    AND Q2_NumOfLines  >= HighSpeedLn_Min
    AND Q3_NumOfLines  >= HighSpeedLn_Min
    AND Q4_NumOfLines  >= HighSpeedLn_Min
    THEN '1-High'
    ELSE '2-Medium'
  END AS Analysis_LineSpeed,
  CASE
    WHEN SERVISE_LEVEL_TYPE IN ('CLM', 'TICPOF')
    THEN MATERIALID
    ELSE MATERIALID
  END AS Analysis_TICPOF,
  CASE
    WHEN NVL (Q1_FREQ_COUNT, 0) <= InactiveWk_Max
    AND NVL (Q2_FREQ_COUNT, 0)  <= InactiveWk_Max
    AND NVL (Q3_FREQ_COUNT, 0)  <= 0
    AND NVL (Q4_FREQ_COUNT, 0)  <= 0
    THEN 'I' --- inactive parts
    WHEN UNIT_COST <= 0
    THEN 'G' ---- no costing
    WHEN NVL (Q1_FREQ_COUNT, 0) <= DoubleWammyWk_Max
    AND NVL (Q2_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
    AND NVL (Q3_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
    AND NVL (Q4_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
    THEN 'W' ---   ' DblWammy'
    WHEN CUMSUMpct < .80
    THEN 'A'
    WHEN CUMSUMpct < .95
    THEN 'B'
    ELSE 'C'
  END AS Analysis_ABCWI ------
  ------
  ------   Used for the join tot he service levels
  ------
  ,
  CASE
    WHEN LEVEL_TYPE = '0-PLANT'
    THEN TO_CHAR (PLANTID)
    WHEN LEVEL_TYPE = '1-BU'
    THEN BU
    WHEN LEVEL_TYPE = '2-PRODLINE'
    THEN PRODLINE
    WHEN LEVEL_TYPE = '2B-SUPPLIER'
    THEN VENDOR_NO
    WHEN LEVEL_TYPE = '3-PROD_SCHEDULER'
    THEN PROD_SCHED_FEVOR
    WHEN LEVEL_TYPE = '4-MRPCONTROLLER'
    THEN MRP_CONTROLLER_DISPO
    WHEN LEVEL_TYPE = '5-PART_FLAG'
    THEN UPPER (PART_FLAG)
    WHEN LEVEL_TYPE = '6-MATERIAL'
    THEN MATERIALID
  END AS MATERIAL_LEVEL_VALUE,
  CASE
    WHEN SERVISE_LEVEL_TYPE IN ('ABC')
    OR LEVEL_TYPE            = '6-MATERIAL'
    THEN 'X'
    WHEN UNIT_COST <= 0
    THEN '4-NoCost'
    WHEN UNIT_COST <= COST_MIN
    THEN '3-Inexpensive'
    WHEN UNIT_COST >= COST_Max
    THEN '1-Expensive'
    ELSE '2-Medium'
  END Analysis_Cost_X,
  CASE
    WHEN SERVISE_LEVEL_TYPE IN ('TICPOF', 'CLM', 'ABC')
    OR LEVEL_TYPE            = '6-MATERIAL' --Added CPZ 08-09-2013 to add SL
    THEN 'X'
    WHEN SUBSTR (STATISTICSTYPE, -2, 2) = '26'
    THEN
      CASE
        WHEN NVL (Q1_FREQ_COUNT, 0) <= InactiveWk_Max
        AND NVL (Q2_FREQ_COUNT, 0)  <= InactiveWk_Max
        AND NVL (Q3_FREQ_COUNT, 0)  <= 0
        AND NVL (Q4_FREQ_COUNT, 0)  <= 0
        THEN '5-Inactive'
        WHEN NVL (Q3_FREQ_COUNT, 0) <= DoubleWammyWk_Max
        AND NVL (Q4_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
        THEN '4-DblWammy'
        WHEN NVL (Q3_FREQ_COUNT, 0) <= LowSpeedWk_Max
        AND NVL (Q4_FREQ_COUNT, 0)  <= LowSpeedWk_Max
        THEN '3-Slow'
        WHEN NVL (Q3_FREQ_COUNT, 0) >= HighSpeedWk_Min
        AND NVL (Q4_FREQ_COUNT, 0)  >= HighSpeedWk_Min
        THEN '1-Fast'
        ELSE '2-Medium'
      END
    WHEN SUBSTR (STATISTICSTYPE, -2, 2) = '13'
    THEN
      CASE
        WHEN NVL (Q1_FREQ_COUNT, 0) <= InactiveWk_Max
        AND NVL (Q2_FREQ_COUNT, 0)  <= InactiveWk_Max
        AND NVL (Q3_FREQ_COUNT, 0)  <= 0
        AND NVL (Q4_FREQ_COUNT, 0)  <= 0
        THEN '5-Inactive'
        WHEN NVL (Q4_FREQ_COUNT, 0) <= DoubleWammyWk_Max
        THEN '4-DblWammy'
        WHEN NVL (Q4_FREQ_COUNT, 0) <= LowSpeedWk_Max
        THEN '3-Slow'
        WHEN NVL (Q4_FREQ_COUNT, 0) >= HighSpeedWk_Min
        THEN '1-Fast'
        ELSE '2-Medium'
      END
    ELSE
      CASE
        WHEN NVL (Q1_FREQ_COUNT, 0) <= InactiveWk_Max
        AND NVL (Q2_FREQ_COUNT, 0)  <= InactiveWk_Max
        AND NVL (Q3_FREQ_COUNT, 0)  <= 0
        AND NVL (Q4_FREQ_COUNT, 0)  <= 0
        THEN '5-Inactive'
        WHEN NVL (Q1_FREQ_COUNT, 0) <= DoubleWammyWk_Max
        AND NVL (Q2_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
        AND NVL (Q3_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
        AND NVL (Q4_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
        THEN '4-DblWammy'
        WHEN NVL (Q1_FREQ_COUNT, 0) <= LowSpeedWk_Max
        AND NVL (Q2_FREQ_COUNT, 0)  <= LowSpeedWk_Max
        AND NVL (Q3_FREQ_COUNT, 0)  <= LowSpeedWk_Max
        AND NVL (Q4_FREQ_COUNT, 0)  <= LowSpeedWk_Max
        THEN '3-Slow'
        WHEN NVL (Q1_FREQ_COUNT, 0) >= HighSpeedWk_Min
        AND NVL (Q2_FREQ_COUNT, 0)  >= HighSpeedWk_Min
        AND NVL (Q3_FREQ_COUNT, 0)  >= HighSpeedWk_Min
        AND NVL (Q4_FREQ_COUNT, 0)  >= HighSpeedWk_Min
        THEN '1-Fast'
        ELSE '2-Medium'
      END
  END AS Analysis_WkSpeed_X,
  CASE
    WHEN SERVISE_LEVEL_TYPE IN ('CSM', 'ABC')
    OR LEVEL_TYPE            = '6-MATERIAL'
    THEN 'X'
    WHEN Q1_NumOfLines <= InactiveLn_Max
    AND Q2_NumOfLines  <= InactiveLn_Max
    AND Q3_NumOfLines  <= 0
    AND Q4_NumOfLines  <= 0
    THEN '5-Inactive'
    WHEN Q1_NumOfLines <= DoubleWammyLn_Max
    AND Q2_NumOfLines  <= DoubleWammyLn_Max
    AND Q3_NumOfLines  <= DoubleWammyLn_Max
    AND Q4_NumOfLines  <= DoubleWammyLn_Max
    THEN '4-DblWammy'
    WHEN Q1_NumOfLines <= LowSpeedLn_Max
    AND Q2_NumOfLines  <= LowSpeedLn_Max
    AND Q3_NumOfLines  <= LowSpeedLn_Max
    AND Q4_NumOfLines  <= LowSpeedLn_Max
    THEN '3-Slow'
    WHEN Q1_NumOfLines >= HighSpeedLn_Min
    AND Q2_NumOfLines  >= HighSpeedLn_Min
    AND Q3_NumOfLines  >= HighSpeedLn_Min
    AND Q4_NumOfLines  >= HighSpeedLn_Min
    THEN '1-High'
    ELSE '2-Medium'
  END AS Analysis_LineSpeed_X,
  CASE
    WHEN SERVISE_LEVEL_TYPE <> 'ABC'
    OR LEVEL_TYPE            = '6-MATERIAL'
    THEN 'X'
    WHEN NVL (Q1_FREQ_COUNT, 0) <= InactiveWk_Max
    AND NVL (Q2_FREQ_COUNT, 0)  <= InactiveWk_Max
    AND NVL (Q3_FREQ_COUNT, 0)  <= 0
    AND NVL (Q4_FREQ_COUNT, 0)  <= 0
    THEN 'I' --- inactive parts
    WHEN UNIT_COST <= 0
    THEN 'G' ---- no costing
    WHEN NVL (Q1_FREQ_COUNT, 0) <= DoubleWammyWk_Max
    AND NVL (Q2_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
    AND NVL (Q3_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
    AND NVL (Q4_FREQ_COUNT, 0)  <= DoubleWammyWk_Max
    THEN 'W' ---   ' DblWammy'
    ELSE ABC_CLASS_MAABC
  END AS Analysis_ABCWI_X,
  CASE
    WHEN SERVISE_LEVEL_TYPE IN ('TICPOF', 'CLM')
    OR LEVEL_TYPE            = '6-MATERIAL'
    THEN MATERIALID
    ELSE 'X'
  END AS Analysis_TICPOF_X,
  SYSDATE dw_date,
  GREATEST (OH_WEEK09, OH_WEEK08, OH_WEEK07, OH_WEEK06, OH_WEEK05, OH_WEEK04, OH_WEEK03, OH_WEEK02, OH_WEEK01) MAX_OH_IN_09WEEKS
FROM
  (SELECT PARAM.*,
    ( (SAFETY_STK_EISBE + LOT_SIZE * (1 + AddPctTomax))) INV_MAX,
    (SAFETY_STK_EISBE   + GREATEST (1, LOT_SIZE / 2)) CURR_PLAN_INV_QTY,
    0 TICPOF_COST_FACTOR,
    CASE
      WHEN (holding_cost * Unit_Cost) IS NULL
      OR (holding_cost   * UNIT_COST) <= 0 --CPZ 07-12-2012
      THEN 0.000001
      WHEN ( (2 * ANNUAL52_PLANT_VOLUMNE_QTY * fix_cost) / (holding_cost * UNIT_COST)) < 0
      THEN 1
      ELSE SQRT ( (2 * ANNUAL52_PLANT_VOLUMNE_QTY * fix_cost) / (holding_cost * UNIT_COST))
    END EOQ,
    CASE
      WHEN PROC_TYPE_BESKZ IN 'E'
      AND NVL (trlt, 0)     > 0
      THEN TRLT             / 5 + GRT / 5
      WHEN PROC_TYPE_BESKZ IN 'E'
      AND NVL (trlt, 0)     = 0
      THEN IPT              / 5 + GRT / 5
      WHEN PROC_TYPE_BESKZ IN 'F'
      THEN PDT              / 7 + GRT / 5
      ELSE GREATEST (PDT    / 7, IPT / 5) + GRT / 5
    END LeadTime_Weeks,
    MRP_AVG12_DEMAND AVG09_MRPREQUIREMENTS_QTY,
    NVL (
    CASE
      WHEN INV_CLASS NOT LIKE '%ACTIVE%'
      THEN 0 --- LTB and or PON , do not get a recomendation
      WHEN STRATEGY_GRP_STRGR NOT IN ('ZB', '40')
      THEN 0 --- no stock item do not get a recomendation
      WHEN INV_CLASS LIKE '%NO PLANNING%'
      THEN 0 -- NO PLANNING DO NOT GET A RECOMMENDATION
      WHEN MRP_TYPE_DISMM IN 'ND'
      THEN 0
      WHEN StatisticsType = 'FCST'
      THEN NVL (MRP_AVG12_DEMAND, 0)
      WHEN StatisticsType = '26'
      THEN NVL (AVG26_USAGE_QTY, 0)
      WHEN StatisticsType = '13'
      THEN NVL (AVG13_USAGE_QTY, 0)
      WHEN StatisticsType = '09'
      THEN NVL (AVG09_USAGE_QTY, 0)
      ELSE NVL (AVG52_USAGE_QTY, 0)
    END, 0) AVGXX_USAGE_QTY,
    NVL (
    CASE
      WHEN INV_CLASS NOT LIKE '%ACTIVE%'
      THEN 0 --- LTB and or PON , do not get a recomendation
      WHEN STRATEGY_GRP_STRGR NOT IN ('ZB', '40')
      THEN 0 --- no stock item do not get a recomendation
      WHEN INV_CLASS LIKE '%NO PLANNING%'
      THEN 0 -- NO PLANNING DO NOT GET A RECOMMENDATION
      WHEN MRP_TYPE_DISMM IN 'ND'
      THEN 0
      WHEN StatisticsType = 'FCST'
      THEN NVL (MRP_AVG12_DEMAND, 0) ----   change to
      WHEN StatisticsType = '26'
      THEN NVL (STDEV26_USAGE, 0)
      WHEN StatisticsType = '13'
      THEN NVL (STDEV13_USAGE, 0)
      WHEN StatisticsType = '09'
      THEN NVL (STDEV09_USAGE, 0)
      ELSE NVL (STDEV52_USAGE, 0)
    END, 0) STDEVXX_USAGE
  FROM
    (SELECT p.MATERIALID,
      p.PLANTID,
      unit_cost * NVL (Gwthplt.EXCHANGE_RATE, 1) UNIT_COST ---
      ,
      NVL ( Gwthmtl.SERVISE_LEVEL_TYPE, NVL ( Gwthprtflg.SERVISE_LEVEL_TYPE, NVL ( Gwthmrp.SERVISE_LEVEL_TYPE, NVL ( Gwthpsch.SERVISE_LEVEL_TYPE, NVL ( Gwthsup.SERVISE_LEVEL_TYPE, NVL ( Gwthpl.SERVISE_LEVEL_TYPE, NVL ( Gwthbu.SERVISE_LEVEL_TYPE, NVL ( Gwthplt.SERVISE_LEVEL_TYPE, 'ABC')))))))) SERVISE_LEVEL_TYPE,
      NVL ( Gwthmtl.useStatistics, NVL ( Gwthprtflg.useStatistics, NVL ( Gwthmrp.useStatistics, NVL ( Gwthpsch.useStatistics, NVL ( Gwthsup.useStatistics, NVL ( Gwthpl.useStatistics, NVL ( Gwthbu.useStatistics, NVL (Gwthplt.useStatistics, '52')))))))) StatisticsType ---                                                                                                                                                      Gwthsup
      ,
      NVL ( Gwthmtl.LEVEL_TYPE, NVL ( Gwthprtflg.LEVEL_TYPE, NVL ( Gwthmrp.LEVEL_TYPE, NVL ( Gwthpsch.LEVEL_TYPE, NVL ( Gwthsup.LEVEL_TYPE, NVL ( Gwthpl.LEVEL_TYPE, NVL ( Gwthbu.LEVEL_TYPE, NVL (Gwthplt.LEVEL_TYPE, '0-PLANT')))))))) LEVEL_TYPE,
      NVL ( Gwthmtl.LEVEL_VALUE, NVL ( Gwthprtflg.LEVEL_VALUE, NVL ( Gwthmrp.LEVEL_VALUE, NVL ( Gwthpsch.LEVEL_VALUE, NVL ( Gwthsup.LEVEL_VALUE, NVL ( Gwthpl.LEVEL_VALUE, NVL ( Gwthbu.LEVEL_VALUE, NVL (Gwthplt.LEVEL_VALUE, TO_CHAR (P.PLaNTID))))))))) LEVEL_VALUE,
      NVL ( Gwthmtl.GROWTH, NVL ( Gwthprtflg.GROWTH, NVL ( Gwthmrp.GROWTH, NVL ( Gwthpsch.GROWTH, NVL ( Gwthsup.GROWTH, NVL ( Gwthpl.GROWTH, NVL (Gwthbu.GROWTH, NVL (Gwthplt.GROWTH, 0)))))))) GROWTH,
      NVL ( Gwthmtl.fix_cost, NVL ( Gwthprtflg.fix_cost, NVL ( Gwthmrp.fix_cost, NVL ( Gwthpsch.fix_cost, NVL ( Gwthsup.fix_cost, NVL ( Gwthpl.fix_cost, NVL (Gwthbu.fix_cost, NVL (Gwthplt.fix_cost, 0)))))))) fix_cost,
      NVL ( Gwthmtl.holding_cost, NVL ( Gwthprtflg.holding_cost, NVL ( Gwthmrp.holding_cost, NVL ( Gwthpsch.holding_cost, NVL ( Gwthsup.holding_cost, NVL ( Gwthpl.holding_cost, NVL ( Gwthbu.holding_cost, NVL (Gwthplt.holding_cost, 0)))))))) holding_cost,
      NVL ( Gwthmtl.AddPctTomax, NVL ( Gwthprtflg.AddPctTomax, NVL ( Gwthmrp.AddPctTomax, NVL ( Gwthpsch.AddPctTomax, NVL ( Gwthsup.AddPctTomax, NVL ( Gwthpl.AddPctTomax, NVL ( Gwthbu.AddPctTomax, NVL (Gwthplt.AddPctTomax, 0)))))))) AddPctTomax,
      NVL ( Gwthmtl.EXCHANGE_RATE, NVL ( Gwthprtflg.EXCHANGE_RATE, NVL ( Gwthmrp.EXCHANGE_RATE, NVL ( Gwthpsch.EXCHANGE_RATE, NVL ( Gwthsup.EXCHANGE_RATE, NVL ( Gwthpl.EXCHANGE_RATE, NVL ( Gwthbu.EXCHANGE_RATE, NVL (Gwthplt.EXCHANGE_RATE, 1)))))))) EXCHANGE_RATE,
      NVL ( Gwthmtl.Auto_SL_tolerance_min, NVL ( Gwthprtflg.Auto_SL_tolerance_min, NVL ( Gwthmrp.Auto_SL_tolerance_min, NVL ( Gwthpsch.Auto_SL_tolerance_min, NVL ( Gwthsup.Auto_SL_tolerance_min, NVL ( Gwthpl.Auto_SL_tolerance_min, NVL ( Gwthbu.Auto_SL_tolerance_min, NVL ( Gwthplt.Auto_SL_tolerance_min, 0)))))))) Auto_SL_tolerance_min,
      NVL ( Gwthmtl.Auto_SL_tolerance_max, NVL ( Gwthprtflg.Auto_SL_tolerance_max, NVL ( Gwthmrp.Auto_SL_tolerance_max, NVL ( Gwthpsch.Auto_SL_tolerance_max, NVL ( Gwthsup.Auto_SL_tolerance_max, NVL ( Gwthpl.Auto_SL_tolerance_max, NVL ( Gwthbu.Auto_SL_tolerance_max, NVL ( Gwthplt.Auto_SL_tolerance_max, 100)))))))) Auto_SL_tolerance_max,
      NVL ( Gwthmtl.Auto_$$_threashold_min, NVL ( Gwthprtflg.Auto_$$_threashold_min, NVL ( Gwthmrp.Auto_$$_threashold_min, NVL ( Gwthpsch.Auto_$$_threashold_min, NVL ( Gwthsup.Auto_$$_threashold_min, NVL ( Gwthpl.Auto_$$_threashold_min, NVL ( Gwthbu.Auto_$$_threashold_min, NVL ( Gwthplt.Auto_$$_threashold_min, 0)))))))) Auto_$$_threashold_min,
      NVL ( Gwthmtl.Auto_$$_threashold_max, NVL ( Gwthprtflg.Auto_$$_threashold_max, NVL ( Gwthmrp.Auto_$$_threashold_max, NVL ( Gwthpsch.Auto_$$_threashold_max, NVL ( Gwthsup.Auto_$$_threashold_max, NVL ( Gwthpl.Auto_$$_threashold_max, NVL ( Gwthbu.Auto_$$_threashold_max, NVL ( Gwthplt.Auto_$$_threashold_max, 100000)))))))) Auto_$$_threashold_max --                                             Gwthprtflg                             Gwthmrp                            Gwthpsch                             Gwthsup                            Gwthpl                             Gwthbu                             Gwthplt                                           )
      ,
      NVL ( Gwthmtl.COST_MIN, NVL ( Gwthprtflg.COST_MIN, NVL ( Gwthmrp.COST_MIN, NVL ( Gwthpsch.COST_MIN, NVL ( Gwthsup.COST_MIN, NVL ( Gwthpl.COST_MIN, NVL (Gwthbu.COST_MIN, NVL (Gwthplt.COST_MIN, 1)))))))) COST_MIN,
      NVL ( Gwthmtl.COST_MAX, NVL ( Gwthprtflg.COST_MAX, NVL ( Gwthmrp.COST_MAX, NVL ( Gwthpsch.COST_MAX, NVL ( Gwthsup.COST_MAX, NVL ( Gwthpl.COST_MAX, NVL (Gwthbu.COST_MAX, NVL (Gwthplt.COST_MAX, 1)))))))) COST_MAX,
      NVL ( Gwthmtl.Volumne_MIN, NVL ( Gwthprtflg.Volumne_MIN, NVL ( Gwthmrp.Volumne_MIN, NVL ( Gwthpsch.Volumne_MIN, NVL ( Gwthsup.Volumne_MIN, NVL ( Gwthpl.Volumne_MIN, NVL ( Gwthbu.Volumne_MIN, NVL (Gwthplt.Volumne_MIN, NULL)))))))) Volumne_MIN,
      NVL ( Gwthmtl.Volumne_Max, NVL ( Gwthprtflg.Volumne_Max, NVL ( Gwthmrp.Volumne_Max, NVL ( Gwthpsch.Volumne_Max, NVL ( Gwthsup.Volumne_Max, NVL ( Gwthpl.Volumne_Max, NVL ( Gwthbu.Volumne_Max, NVL (Gwthplt.Volumne_Max, NULL)))))))) Volumne_Max,
      NVL ( Gwthmtl.HighSpeedWk_Min, NVL ( Gwthprtflg.HighSpeedWk_Min, NVL ( Gwthmrp.HighSpeedWk_Min, NVL ( Gwthpsch.HighSpeedWk_Min, NVL ( Gwthsup.HighSpeedWk_Min, NVL ( Gwthpl.HighSpeedWk_Min, NVL ( Gwthbu.HighSpeedWk_Min, NVL (Gwthplt.HighSpeedWk_Min, 1)))))))) HighSpeedWk_Min,
      NVL ( Gwthmtl.LowSpeedWk_Max, NVL ( Gwthprtflg.LowSpeedWk_Max, NVL ( Gwthmrp.LowSpeedWk_Max, NVL ( Gwthpsch.LowSpeedWk_Max, NVL ( Gwthsup.LowSpeedWk_Max, NVL ( Gwthpl.LowSpeedWk_Max, NVL ( Gwthbu.LowSpeedWk_Max, NVL (Gwthplt.LowSpeedWk_Max, 1)))))))) LowSpeedWk_Max,
      NVL ( Gwthmtl.DoubleWammyWk_Max, NVL ( Gwthprtflg.DoubleWammyWk_Max, NVL ( Gwthmrp.DoubleWammyWk_Max, NVL ( Gwthpsch.DoubleWammyWk_Max, NVL ( Gwthsup.DoubleWammyWk_Max, NVL ( Gwthpl.DoubleWammyWk_Max, NVL ( Gwthbu.DoubleWammyWk_Max, NVL ( Gwthplt.DoubleWammyWk_Max, 1)))))))) DoubleWammyWk_Max,
      NVL ( Gwthmtl.InactiveWk_Max, NVL ( Gwthprtflg.InactiveWk_Max, NVL ( Gwthmrp.InactiveWk_Max, NVL ( Gwthpsch.InactiveWk_Max, NVL ( Gwthsup.InactiveWk_Max, NVL ( Gwthpl.InactiveWk_Max, NVL ( Gwthbu.InactiveWk_Max, NVL (Gwthplt.InactiveWk_Max, 1)))))))) InactiveWk_Max,
      NVL ( Gwthmtl.HighSpeedLn_Min, NVL ( Gwthprtflg.HighSpeedLn_Min, NVL ( Gwthmrp.HighSpeedLn_Min, NVL ( Gwthpsch.HighSpeedLn_Min, NVL ( Gwthsup.HighSpeedLn_Min, NVL ( Gwthpl.HighSpeedLn_Min, NVL ( Gwthbu.HighSpeedLn_Min, NVL (Gwthplt.HighSpeedLn_Min, 1)))))))) HighSpeedLn_Min,
      NVL ( Gwthmtl.LowSpeedLn_Max, NVL ( Gwthprtflg.LowSpeedLn_Max, NVL ( Gwthmrp.LowSpeedLn_Max, NVL ( Gwthpsch.LowSpeedLn_Max, NVL ( Gwthsup.LowSpeedLn_Max, NVL ( Gwthpl.LowSpeedLn_Max, NVL ( Gwthbu.LowSpeedLn_Max, NVL (Gwthplt.LowSpeedLn_Max, 1)))))))) LowSpeedLn_Max,
      NVL ( Gwthmtl.DoubleWammyLn_Max, NVL ( Gwthprtflg.DoubleWammyLn_Max, NVL ( Gwthmrp.DoubleWammyLn_Max, NVL ( Gwthpsch.DoubleWammyLn_Max, NVL ( Gwthsup.DoubleWammyLn_Max, NVL ( Gwthpl.DoubleWammyLn_Max, NVL ( Gwthbu.DoubleWammyLn_Max, NVL ( Gwthplt.DoubleWammyLn_Max, 1)))))))) DoubleWammyLn_Max,
      NVL ( Gwthmtl.InactiveLn_Max, NVL ( Gwthprtflg.InactiveLn_Max, NVL ( Gwthmrp.InactiveLn_Max, NVL ( Gwthpsch.InactiveLn_Max, NVL ( Gwthsup.InactiveLn_Max, NVL ( Gwthpl.InactiveLn_Max, NVL ( Gwthbu.InactiveLn_Max, NVL (Gwthplt.InactiveLn_Max, 1)))))))) InactiveLn_Max ----                                           Gwthprtflg                             Gwthmrp                            Gwthpsch                             Gwthsup                            Gwthpl                             Gwthbu                             Gwthplt                                           )
      ,
      NVL ( Gwthmtl.PLAN_BY_WOS, NVL ( Gwthprtflg.PLAN_BY_WOS, NVL ( Gwthmrp.PLAN_BY_WOS, NVL ( Gwthpsch.PLAN_BY_WOS, NVL ( Gwthsup.PLAN_BY_WOS, NVL ( Gwthpl.PLAN_BY_WOS, NVL ( Gwthbu.PLAN_BY_WOS, NVL (Gwthplt.PLAN_BY_WOS, 0)))))))) PLAN_BY_WOS,
      NVL ( Gwthmtl.CAPONLOTSIZEFACTOR, NVL ( Gwthprtflg.CAPONLOTSIZEFACTOR, NVL ( Gwthmrp.CAPONLOTSIZEFACTOR, NVL ( Gwthpsch.CAPONLOTSIZEFACTOR, NVL ( Gwthsup.CAPONLOTSIZEFACTOR, NVL ( Gwthpl.CAPONLOTSIZEFACTOR, NVL ( Gwthbu.CAPONLOTSIZEFACTOR, NVL ( Gwthplt.CAPONLOTSIZEFACTOR, 1)))))))) CAPONLOTSIZEFACTOR -----                                            Gwthprtflg                           Gwthmrp                              Gwthpsch                           Gwthsuppl                            Gwthpl                             Gwthbu                             Gwthplt                                           )
      ,
      CASE
        WHEN NVL ( Gwthmtl.Volumne_MIN, NVL ( Gwthprtflg.Volumne_MIN, NVL ( Gwthmrp.Volumne_MIN, NVL ( Gwthpsch.Volumne_MIN, NVL ( Gwthsup.Volumne_MIN, NVL ( Gwthpl.Volumne_MIN, NVL ( Gwthbu.Volumne_MIN, NVL ( Gwthplt.Volumne_MIN, NULL)))))))) IS NOT NULL
        OR NVL ( Gwthmtl.Volumne_Max, NVL ( Gwthprtflg.Volumne_Max, NVL ( Gwthmrp.Volumne_Max, NVL ( Gwthpsch.Volumne_Max, NVL ( Gwthsup.Volumne_Max, NVL ( Gwthpl.Volumne_Max, NVL ( Gwthbu.Volumne_Max, NVL ( Gwthplt.Volumne_Max, NULL))))))))   IS NOT NULL
        THEN NVL ( Gwthmtl.LEVEL_TYPE, NVL ( Gwthprtflg.LEVEL_TYPE, NVL ( Gwthmrp.LEVEL_TYPE, NVL ( Gwthpsch.LEVEL_TYPE, NVL ( Gwthsup.LEVEL_TYPE, NVL ( Gwthpl.LEVEL_TYPE, NVL ( Gwthbu.LEVEL_TYPE, NVL (Gwthplt.LEVEL_TYPE, '0-PLANT'))))))))
        ELSE 'PLANT'
      END AS CUM_LEVEL ---- ---- statistcis
      ,
      stat.ANNUAL52_PLANT_VOLUMNE_QTY,
      stat.ANNUAL26_PLANT_VOLUMNE_QTY,
      stat.ANNUAL52_PLANT_VOLUMNE_AMT,
      stat.PLANT_USAGE52_FREQUENCY,
      stat.AVG52_USAGE_QTY,
      stat.STDEV52_USAGE,
      stat.CV52_USAGE,
      stat.PLANT_USAGE26_FREQUENCY,
      stat.AVG26_USAGE_QTY,
      stat.STDEV26_USAGE,
      stat.CV26_USAGE,
      stat.PLANT_USAGE13_FREQUENCY,
      stat.AVG13_USAGE_QTY,
      stat.STDEV13_USAGE,
      stat.CV13_USAGE,
      stat.PLANT_USAGE09_FREQUENCY,
      stat.AVG09_USAGE_QTY,
      stat.STDEV09_USAGE,
      stat.CV09_USAGE,
      stat.FREQUENCY_WK52_TO_WK26,
      stat.MATERIAL,
      stat.PLANT,
      stat.MAX_WEEK_DATE,
      stat.USE_WEEK52,
      stat.USE_WEEK51,
      stat.USE_WEEK50,
      stat.USE_WEEK49,
      stat.USE_WEEK48,
      stat.USE_WEEK47,
      stat.USE_WEEK46,
      stat.USE_WEEK45,
      stat.USE_WEEK44,
      stat.USE_WEEK43,
      stat.USE_WEEK42,
      stat.USE_WEEK41,
      stat.USE_WEEK40,
      stat.USE_WEEK39,
      stat.USE_WEEK38,
      stat.USE_WEEK37,
      stat.USE_WEEK36,
      stat.USE_WEEK35,
      stat.USE_WEEK34,
      stat.USE_WEEK33,
      stat.USE_WEEK32,
      stat.USE_WEEK31,
      stat.USE_WEEK30,
      stat.USE_WEEK29,
      stat.USE_WEEK28,
      stat.USE_WEEK27,
      stat.USE_WEEK26,
      stat.USE_WEEK25,
      stat.USE_WEEK24,
      stat.USE_WEEK23,
      stat.USE_WEEK22,
      stat.USE_WEEK21,
      stat.USE_WEEK20,
      stat.USE_WEEK19,
      stat.USE_WEEK18,
      stat.USE_WEEK17,
      stat.USE_WEEK16,
      stat.USE_WEEK15,
      stat.USE_WEEK14,
      stat.USE_WEEK13,
      stat.USE_WEEK12,
      stat.USE_WEEK11,
      stat.USE_WEEK10,
      stat.USE_WEEK09,
      stat.USE_WEEK08,
      stat.USE_WEEK07,
      stat.USE_WEEK06,
      stat.USE_WEEK05,
      stat.USE_WEEK04,
      stat.USE_WEEK03,
      stat.USE_WEEK02,
      stat.USE_WEEK01,
      stat.PO_WEEK52,
      stat.PO_WEEK51,
      stat.PO_WEEK50,
      stat.PO_WEEK49,
      stat.PO_WEEK48,
      stat.PO_WEEK47,
      stat.PO_WEEK46,
      stat.PO_WEEK45,
      stat.PO_WEEK44,
      stat.PO_WEEK43,
      stat.PO_WEEK42,
      stat.PO_WEEK41,
      stat.PO_WEEK40,
      stat.PO_WEEK39,
      stat.PO_WEEK38,
      stat.PO_WEEK37,
      stat.PO_WEEK36,
      stat.PO_WEEK35,
      stat.PO_WEEK34,
      stat.PO_WEEK33,
      stat.PO_WEEK32,
      stat.PO_WEEK31,
      stat.PO_WEEK30,
      stat.PO_WEEK29,
      stat.PO_WEEK28,
      stat.PO_WEEK27,
      stat.PO_WEEK26,
      stat.PO_WEEK25,
      stat.PO_WEEK24,
      stat.PO_WEEK23,
      stat.PO_WEEK22,
      stat.PO_WEEK21,
      stat.PO_WEEK20,
      stat.PO_WEEK19,
      stat.PO_WEEK18,
      stat.PO_WEEK17,
      stat.PO_WEEK16,
      stat.PO_WEEK15,
      stat.PO_WEEK14,
      stat.PO_WEEK13,
      stat.PO_WEEK12,
      stat.PO_WEEK11,
      stat.PO_WEEK10,
      stat.PO_WEEK09,
      stat.PO_WEEK08,
      stat.PO_WEEK07,
      stat.PO_WEEK06,
      stat.PO_WEEK05,
      stat.PO_WEEK04,
      stat.PO_WEEK03,
      stat.PO_WEEK02,
      stat.PO_WEEK01,
      stat.OH_WEEK52,
      stat.OH_WEEK51,
      stat.OH_WEEK50,
      stat.OH_WEEK49,
      stat.OH_WEEK48,
      stat.OH_WEEK47,
      stat.OH_WEEK46,
      stat.OH_WEEK45,
      stat.OH_WEEK44,
      stat.OH_WEEK43,
      stat.OH_WEEK42,
      stat.OH_WEEK41,
      stat.OH_WEEK40,
      stat.OH_WEEK39,
      stat.OH_WEEK38,
      stat.OH_WEEK37,
      stat.OH_WEEK36,
      stat.OH_WEEK35,
      stat.OH_WEEK34,
      stat.OH_WEEK33,
      stat.OH_WEEK32,
      stat.OH_WEEK31,
      stat.OH_WEEK30,
      stat.OH_WEEK29,
      stat.OH_WEEK28,
      stat.OH_WEEK27,
      stat.OH_WEEK26,
      stat.OH_WEEK25,
      stat.OH_WEEK24,
      stat.OH_WEEK23,
      stat.OH_WEEK22,
      stat.OH_WEEK21,
      stat.OH_WEEK20,
      stat.OH_WEEK19,
      stat.OH_WEEK18,
      stat.OH_WEEK17,
      stat.OH_WEEK16,
      stat.OH_WEEK15,
      stat.OH_WEEK14,
      stat.OH_WEEK13,
      stat.OH_WEEK12,
      stat.OH_WEEK11,
      stat.OH_WEEK10,
      stat.OH_WEEK09,
      stat.OH_WEEK08,
      stat.OH_WEEK07,
      stat.OH_WEEK06,
      stat.OH_WEEK05,
      stat.OH_WEEK04,
      stat.OH_WEEK03,
      stat.OH_WEEK02,
      stat.OH_WEEK01,
      stat.MIN_WEEK_DAY,
      stat.OUT_QTY_W01,
      stat.OUT_QTY_W02,
      stat.OUT_QTY_W03,
      stat.OUT_QTY_W04,
      stat.OUT_QTY_W05,
      stat.OUT_QTY_W06,
      stat.OUT_QTY_W07,
      stat.OUT_QTY_W08,
      stat.OUT_QTY_W09,
      stat.OUT_QTY_W10,
      stat.OUT_QTY_W11,
      stat.OUT_QTY_W12,
      stat.OUT_QTY_W13,
      stat.OUT_QTY_W14,
      stat.OUT_QTY_W15,
      stat.OUT_QTY_W16,
      stat.OUT_QTY_W17,
      stat.OUT_QTY_W18,
      stat.OUT_QTY_W19,
      stat.OUT_QTY_W20,
      stat.OUT_QTY_W21,
      stat.OUT_QTY_W22,
      stat.OUT_QTY_W23,
      stat.OUT_QTY_W24,
      stat.OUT_QTY_W25,
      stat.OUT_QTY_W26,
      stat.FIRM_INPUT_PD,
      stat.FIRM_INPUT_IN,
      stat.FIRM_OUT_PD,
      stat.FIRM_OUT,
      stat.MRP_MAX12_DEMAND,
      stat.MATL_FIRST_USED,
      stat.IN_QTY_W01,
      stat.IN_QTY_W02,
      stat.IN_QTY_W03,
      stat.IN_QTY_W04,
      stat.IN_QTY_W05,
      stat.IN_QTY_W06,
      stat.IN_QTY_W07,
      stat.IN_QTY_W08,
      stat.IN_QTY_W09,
      stat.IN_QTY_W10,
      stat.IN_QTY_W11,
      stat.IN_QTY_W12,
      stat.IN_QTY_W13,
      stat.IN_QTY_W14,
      stat.IN_QTY_W15,
      stat.IN_QTY_W16,
      stat.IN_QTY_W17,
      stat.IN_QTY_W18,
      stat.IN_QTY_W19,
      stat.IN_QTY_W20,
      stat.IN_QTY_W21,
      stat.IN_QTY_W22,
      stat.IN_QTY_W23,
      stat.IN_QTY_W24,
      stat.IN_QTY_W25,
      stat.IN_QTY_W26 --------------------
      ,
      stat.MRP_AVG12_DEMAND,
      stat.MRP_SUM12_DEMAND,
      NVL (stat.Q1_FREQ_COUNT, 0) Q1_FREQ_COUNT,
      NVL (stat.Q2_FREQ_COUNT, 0) Q2_FREQ_COUNT,
      NVL (stat.Q3_FREQ_COUNT, 0) Q3_FREQ_COUNT,
      NVL (stat.Q4_FREQ_COUNT, 0) Q4_FREQ_COUNT,
      stat.OH_PVT_LASTBUILD_DATE,
      stat.USE_PVT_LASTBUILD_DATE,
      stat.IO_MIN_WEEK_DAY,
      stat.RUN_TIME_HRS,
      stat.SETUP_TIME_HRS,
      stat.SMT_RUN_TIME_HRS,
      stat.SMT_SETUP_TIME_HRS,
      stat.PLACEMENTS_PER_BOARD,
      stat.PANNELS_PER_BOARDS,
      stat.SMT_PANNELS_PER_BOARDS,
      stat.SMT_PLACEMENTS_PER_BOARD,
      statSls.Q4_LINES,
      statSls.Q3_LINES,
      statSls.Q2_LINES,
      statSls.Q1_LINES,
      statSls.Q4_COMPLIANCE,
      statSls.Q3_COMPLIANCE,
      statSls.Q2_COMPLIANCE,
      statSls.Q1_COMPLIANCE,
      0 LINE_COUNT_12MONTH,
      0 AVG_MONTHLY_DEM,
      0 STDEV_MONTHLY_DEM,
      stat.ANNUAL52_PLANT_VOLUMNE_AMT ORDERAMT_12MONTH,
      NVL (statSls.COMPLIANCE_WK13, stat.COMPLIANCE_WK13) AS COMPLIANCE_WK13,
      NVL (statSls.COMPLIANCE_WK12, stat.COMPLIANCE_WK12) AS COMPLIANCE_WK12,
      NVL (statSls.COMPLIANCE_WK11, stat.COMPLIANCE_WK11) AS COMPLIANCE_WK11,
      NVL (statSls.COMPLIANCE_WK10, stat.COMPLIANCE_WK10) AS COMPLIANCE_WK10,
      NVL (statSls.COMPLIANCE_WK09, stat.COMPLIANCE_WK09) AS COMPLIANCE_WK09,
      NVL (statSls.COMPLIANCE_WK08, stat.COMPLIANCE_WK08) AS COMPLIANCE_WK08,
      NVL (statSls.COMPLIANCE_WK07, stat.COMPLIANCE_WK07) AS COMPLIANCE_WK07,
      NVL (statSls.COMPLIANCE_WK06, stat.COMPLIANCE_WK06) AS COMPLIANCE_WK06,
      NVL (statSls.COMPLIANCE_WK05, stat.COMPLIANCE_WK05) AS COMPLIANCE_WK05,
      NVL (statSls.COMPLIANCE_WK04, stat.COMPLIANCE_WK04) AS COMPLIANCE_WK04,
      NVL (statSls.COMPLIANCE_WK03, stat.COMPLIANCE_WK03) AS COMPLIANCE_WK03,
      NVL (statSls.COMPLIANCE_WK02, stat.COMPLIANCE_WK02) AS COMPLIANCE_WK02,
      NVL (statSls.COMPLIANCE_WK01, stat.COMPLIANCE_WK01) AS COMPLIANCE_WK01 ---, STAT.*
      ,
      CASE
        WHEN P.LOT_SIZE_DISLS                                                                                                                     IN ('WB', 'EX', 'PK')
        THEN GREATEST ( DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF), (CEIL ( DECODE (P.MIN_LOT_SIZE_BSTMI, 0, 1, P.MIN_LOT_SIZE_BSTMI) / DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)) * DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)), (CEIL ( GREATEST ( DECODE ( NVL (stat.MRP_AVG12_DEMAND, 0), 0, 1, NVL (stat.MRP_AVG12_DEMAND, 0)), DECODE ( NVL (stat.AVG26_USAGE_QTY, 0), 0, 1, NVL (stat.AVG26_USAGE_QTY, 0))) / DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)) * DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)))
        WHEN P.LOT_SIZE_DISLS = 'W2'
        THEN GREATEST ( DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF), (CEIL ( DECODE (P.MIN_LOT_SIZE_BSTMI, 0, 1, P.MIN_LOT_SIZE_BSTMI) / DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)) * DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)), (CEIL ( GREATEST ( DECODE ( NVL (2 * stat.MRP_AVG12_DEMAND, 0), 0, 1, NVL (2 * stat.MRP_AVG12_DEMAND, 0)), DECODE ( NVL (2 * stat.AVG26_USAGE_QTY, 0), 0, 1, NVL (2 * stat.AVG26_USAGE_QTY, 0))) / DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)) * DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)))
        WHEN P.LOT_SIZE_DISLS = 'FX'
        THEN P.FX_LOT_SIZE_BSTFE
        WHEN P.LOT_SIZE_DISLS = 'Z2'
        THEN GREATEST ( DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF), (CEIL ( DECODE (P.MIN_LOT_SIZE_BSTMI, 0, 1, P.MIN_LOT_SIZE_BSTMI) / DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)) * DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)), (CEIL ( GREATEST ( DECODE ( NVL (2 * stat.MRP_AVG12_DEMAND, 0), 0, 1, NVL (2 * stat.MRP_AVG12_DEMAND, 0)), DECODE ( NVL (2 * stat.AVG26_USAGE_QTY, 0), 0, 1, NVL (2 * stat.AVG26_USAGE_QTY, 0))) / DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)) * DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)))
        WHEN P.LOT_SIZE_DISLS = 'MB'
        THEN GREATEST ( DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF), (CEIL ( DECODE (P.MIN_LOT_SIZE_BSTMI, 0, 1, P.MIN_LOT_SIZE_BSTMI) / DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)) * DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)), (CEIL ( GREATEST ( DECODE ( NVL (4 * stat.MRP_AVG12_DEMAND, 0), 0, 1, NVL (4 * stat.MRP_AVG12_DEMAND, 0)), DECODE ( NVL (4 * stat.AVG26_USAGE_QTY, 0), 0, 1, NVL (4 * stat.AVG26_USAGE_QTY, 0))) / DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)) * DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)))
        WHEN P.LOT_SIZE_DISLS = 'Z3'
        THEN GREATEST ( DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF), (CEIL ( DECODE (P.MIN_LOT_SIZE_BSTMI, 0, 1, P.MIN_LOT_SIZE_BSTMI) / DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)) * DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)), (CEIL ( GREATEST ( DECODE ( NVL (13 * stat.MRP_AVG12_DEMAND, 0), 0, 1, NVL (13 * stat.MRP_AVG12_DEMAND, 0)), DECODE ( NVL (13 * stat.AVG26_USAGE_QTY, 0), 0, 1, NVL (13 * stat.AVG26_USAGE_QTY, 0))) / DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)) * DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)))
        ELSE GREATEST ( DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF), (CEIL ( DECODE (P.MIN_LOT_SIZE_BSTMI, 0, 1, P.MIN_LOT_SIZE_BSTMI) / DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)) * DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)), (CEIL ( GREATEST ( DECODE ( NVL (stat.MRP_AVG12_DEMAND, 0), 0, 1, NVL (stat.MRP_AVG12_DEMAND, 0)), DECODE ( NVL (stat.AVG26_USAGE_QTY, 0), 0, 1, NVL (stat.AVG26_USAGE_QTY, 0))) / DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)) * DECODE (P.ROUND_VALUE_BSTRF, 0, 1, P.ROUND_VALUE_BSTRF)))
      END LOT_SIZE,
      P.IH_PROD_TIME_DZEIT IPT,
      P.LT_DELV_PLIFZ PDT,
      P.LT_REC_WEBAZ GRT,
      SAFETY_STK_EISBE,
      REORDER_PT_MINBE,
      ABC_CLASS_MAABC -----
      ---- this is applicable to the Finish goods comming from the Sales Statistic Weekly
      ---- missing the performance from supplier
      ,
      NVL (statSls.Q1_LINES, 0) Q1_NumOfLines,
      NVL (statSls.Q2_LINES, 0) Q2_NumOfLines,
      NVL (statSls.Q3_LINES, 0) Q3_NumOfLines,
      NVL (statSls.Q4_LINES, 0) Q4_NumOfLines,
      NVL (statSls.Q1_COMPLIANCE, 0) CompliancePctQ1,
      NVL (statSls.Q2_COMPLIANCE, 0) CompliancePctQ2,
      NVL (statSls.Q3_COMPLIANCE, 0) CompliancePctQ3,
      NVL (statSls.Q4_COMPLIANCE, 0) CompliancePctQ4,
      NVL (stat.Q1_FREQ_COUNT, 0) Number_of_HitsQ1,
      NVL (stat.Q2_FREQ_COUNT, 0) Number_of_HitsQ2,
      NVL (stat.Q3_FREQ_COUNT, 0) Number_of_HitsQ3,
      NVL (stat.Q4_FREQ_COUNT, 0) Number_of_HitsQ4,
      SUBSTR (p.PROD_HIERARCHY_PRDHA, 1, 3) BU,
      SUBSTR (p.PROD_HIERARCHY_PRDHA, 1, 7) PRODLINE,
      PROD_HIERARCHY_PRDHA,
      MRP_CONTROLLER_DISPO,
      TRIM (SPC_PROC_KEY_SOBSL) SPC_PROC_KEY_SOBSL,
      PROD_SCHED_FEVOR,
      PROC_TYPE_BESKZ,
      PURCH_GROUP_EKGRP,
      TRLT_WZEIT TRLT,
      MRP_TYPE_DISMM,
      STRATEGY_GRP_STRGR,
      SP_MATL_STAT_MMSTA,
      pff.VENDOR_NO,
      pff.VENDOR_NAME,
      MATL_DESC_MAKTX --------
      ,
      NVL (UNRESTRICTED_LABST, 0) OH_QTY,
      NVL (INTRANSFER_STOCK_PLANT_UMLMC, 0) + NVL (STOCK_IN_TRANSIT_TRAME, 0) + NVL (STOCK_IN_TRANSIT_SV_VKUMC, 0) + NVL (STOCK_IN_TRANSIT_SP_VKTRW, 0) + NVL (INTRANSFER_UMLME, 0) OH_QTY_INTRANSIT,
      NVL (INQUALITY_INSME, 0)              + NVL (RESTRICTED_USE_EINME, 0) + NVL (BLOCKED_SPEME, 0) + NVL (RETUNRS_RETME, 0) OH_BLOCKED ----------
      ,
      NVL (stat.ANNUAL52_PLANT_VOLUMNE_QTY * UNIT_COST, 0) --CPZ Added 02-09-2012
      AS ANNUAL52_PLANT_VOLUMNE_DOLLARS,
      rw.AVG REVIEW_LAST_AVG,
      rw.STDEV REVIEW_LAST_STDEV,
      rw.GROWTH REVIEW_LAST_GROWTH,
      rw.LS REVIEW_LAST_LS,
      rw.LT REVIEW_LAST_LT,
      rw.SL REVIEW_LAST_SL,
      rw.SS REVIEW_LAST_SS,
      rw.REVIEW_FLAG,
      rw.PART_FLAG --, rw.PART_FLAG  removed to add the Reviwed
      ,
      rw.REVIEW_COMMENT REVIEW_LAST_COMMENT,
      rw.STAT_TYPE REVIEW_LAST_STAT_TYPE,
      rw.CHANGED_BY REVIEW_LAST_BY,
      rw.CHANGED_DATE REVIEW_LAST_DATE,
      CASE
        WHEN PLANT_WERKS NOT IN (2000, 1090)
        AND (NVL (SPC_PROC_KEY_SOBSL, 'X') LIKE '%E9%'
        OR NVL (SPC_PROC_KEY_SOBSL, 'X') LIKE '%EJ%' --CPZ 01-21-2012
        OR pff.VENDOR_NAME LIKE 'V1090%')
        AND NVL (PROC_TYPE_BESKZ, 'X') = 'F'
        THEN 'RARAWCDC' --- inv in non-CDC plants sourced from CDC
        WHEN PLANT_WERKS NOT IN (1180)
        AND (NVL (SPC_PROC_KEY_SOBSL, 'X') LIKE '%EM%'
        OR pff.VENDOR_NAME LIKE 'V1180%') --CPZ 01-20-2012
        AND NVL (PROC_TYPE_BESKZ, 'X') = 'F'
        THEN 'RARAWMEM' --- inv in non-CDC plants sourced from CDC --CPZ 01-20-2012
        WHEN plant_Werks NOT          IN ('4000')
        AND NVL (PROC_TYPE_BESKZ, 'X') = 'F'
        AND ( (plant_werks            IN ('4010')
        AND (NVL (SPC_PROC_KEY_SOBSL, 'X') LIKE '%E9%'))
        OR (plant_werks IN ('1040', '1080', '1020', '1130', '1190', '1200', '3000', '3500', '3510', '3520', '3530', '3540', '3550', '3560', '3570', '3580', '3590', '3600', '3610', '3620', '3630', '3640', '3650', '3660', '5170')
        AND (NVL (SPC_PROC_KEY_SOBSL, 'X') LIKE '%ED%'))
        OR (plant_werks IN ('1100', '1120')
        AND (NVL (SPC_PROC_KEY_SOBSL, 'X') LIKE '%EE%'))
        OR (plant_werks IN ('1170')
        AND (NVL (SPC_PROC_KEY_SOBSL, 'X') LIKE '%EF%'))
        OR (plant_werks IN ('1090', '1150', '1160', '2010', '4020')
        AND (NVL (SPC_PROC_KEY_SOBSL, 'X') LIKE '%EG%'))
        OR (plant_werks IN ('1180', '4060', '4080', '4100')
        AND (NVL (SPC_PROC_KEY_SOBSL, 'X') LIKE '%EH%'))
        OR (plant_werks IN ('1050')
        AND (NVL (SPC_PROC_KEY_SOBSL, 'X') LIKE '%EP%'))
        OR pff.VENDOR_NAME LIKE 'V4000%')
        THEN 'RARAWCEDC'                              --CPZ 02-06-2012 CEDC Add
        WHEN (PLANT_WERKS IN (2000, 1090, 1180, 4000) --CPZ 01-20-2012
        AND NVL (SPC_PROC_KEY_SOBSL, 'X') NOT LIKE '%E%'
        AND UPPER (pff.VENDOR_NAME) NOT LIKE '%ROCKWELL AUTO%'
        AND PROC_TYPE_BESKZ = 'F')
        OR MATL_TYPE_MTART IN ('ZTG')
        THEN 'FACTORED' --- CDC inv that is not source from other SAP plant cassificed as ZTG
        WHEN (SPC_PROC_KEY_SOBSL LIKE '%E%'
        OR UPPER (pff.VENDOR_NAME) LIKE '%ROCKWELL AUTO%')
        AND NVL (PROC_TYPE_BESKZ, 'X') = 'F'
        THEN 'RARAWPLNT' --- inv source from other plants , not source from CDC
          --- make at the plant
        WHEN (MATL_TYPE_MTART IN ('ZRAW')
        AND NVL (SPC_PROC_KEY_SOBSL, 'X') NOT LIKE '%E%')
        AND NVL (PROC_TYPE_BESKZ, 'X') = 'F'
        THEN 'COMPONENT'
        WHEN MATL_TYPE_MTART          IN ('ZSFG')
        AND NVL (PROC_TYPE_BESKZ, 'X') = 'F'
        THEN 'COMPONENT'
        WHEN MATL_TYPE_MTART IN ('ZRAW', 'ZPKG', 'ZNV', 'ZABF')
        THEN 'COMPONENT'
        WHEN ( (MATL_TYPE_MTART       IN ('ZFG')
        AND NVL (PROC_TYPE_BESKZ, 'X') = 'E'))
        OR (PLANT_WERKS               IN ('1090', '1180', '4000')) --CPZ 01-20-2012
        THEN 'RAFG'                                               --- made in SAP plant  or OH in CDC
        WHEN MATL_TYPE_MTART IN ('ZFG', 'ZNFG', 'ZED', 'ZSPL', 'ZCFG', 'ZCNV', 'PROD', 'ZSVC')
        THEN 'RAFG'
        WHEN (MATL_TYPE_MTART         IN ('ZSFG')
        AND NVL (PROC_TYPE_BESKZ, 'X') = 'E')
        OR (MATL_TYPE_MTART           IN ('ZRAW')
        AND NVL (PROC_TYPE_BESKZ, 'X') = 'E')
        THEN 'SUBASSY'
        WHEN MATL_TYPE_MTART IN ('ZSFG')
        THEN 'SUBASSY'
        WHEN STRATEGY_GRP_STRGR IN ('ZB', '40')
        THEN 'COMPONENT'
        ELSE 'UNKNOWN'
      END MATL_TYPE,
      NVL (TRIM (CYCLE_CNT_IND_ABCIN), 'X') CC_ABC ----
      ,
      ROUND ( SUM ( stat.ANNUAL52_PLANT_VOLUMNE_QTY * UNIT_COST) OVER ( PARTITION BY p.plantid, MRP_CONTROLLER_DISPO, PROC_TYPE_BESKZ ORDER BY stat.ANNUAL52_PLANT_VOLUMNE_QTY * UNIT_COST DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) / GREATEST ( 1, SUM ( stat.ANNUAL52_PLANT_VOLUMNE_QTY * UNIT_COST) OVER ( PARTITION BY p.plantid, MRP_CONTROLLER_DISPO, PROC_TYPE_BESKZ)), 3) CUMSUMpct ---------
      ,
      CASE
        WHEN (SP_MATL_STAT_MMSTA IN ('ZG', 'ZJ', 'ZN', 'ZQ')
        OR (rw.PART_FLAG LIKE '%PON%'
        AND NVL (rw.review_flag, 'Ignore') NOT LIKE ('%JAPAN%'))
        OR (rw.PART_FLAG LIKE '%PON%'
        AND NVL (rw.review_flag, 'Ignore') NOT LIKE ('SC_%')))
        AND ( NVL (NVL (stat.Q3_FREQ_COUNT, 0), 0) + NVL (NVL (Stat.Q4_Freq_Count, 0), 0) + NVL (stat.MRP_SUM12_DEMAND, 0)) > 0 --CPZ 02-07-2013 to let PON's get a recommendation
        THEN 'ACTIVE PON'
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END)
        WHEN (SP_MATL_STAT_MMSTA IN ('ZG', 'ZJ', 'ZN', 'ZQ')
        OR (rw.PART_FLAG LIKE '%PON%'
        AND NVL (rw.review_flag, 'Ignore') NOT LIKE ('%JAPAN%'))
        OR (rw.PART_FLAG LIKE '%PON%'
        AND NVL (rw.review_flag, 'Ignore') NOT LIKE ('SC_%')))
        THEN 'INACTIVE PON'
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END)
        WHEN MRP_CONTROLLER_DISPO LIKE '%F%'
        AND NVL (NVL (stat.Q3_FREQ_COUNT, 0), 0) + NVL (NVL (Stat.Q4_Freq_Count, 0), 0) + NVL (stat.MRP_SUM12_DEMAND, 0) > 0
        THEN 'ACTIVE F MRP CONTROLLER '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN MRP_CONTROLLER_DISPO LIKE '%F%'
        THEN 'INACTIVE F MRP CONTROLLER '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END)
        WHEN NVL (UNIT_COST, 0) = 0
        OR MATL_TYPE_MTART      = 'ZNV'
        THEN 'NO COSTING '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN TRIM (BULK_MATL_SCHGT)                                                                                     IS NOT NULL
        AND NVL (NVL (stat.Q3_FREQ_COUNT, 0), 0) + NVL (NVL (stat.Q4_FREQ_COUNT, 0), 0) + NVL (stat.MRP_SUM12_DEMAND, 0) > 0
        THEN 'ACTIVE BULK ITEM '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN TRIM (BULK_MATL_SCHGT)                                                                                      IS NOT NULL
        AND NVL (NVL (stat.Q3_FREQ_COUNT, 0), 0) + NVL (NVL (stat.Q4_FREQ_COUNT, 0), 0) + NVL (stat.MRP_SUM12_DEMAND, 0) <= 0
        THEN 'BULK ITEM '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN SP_MATL_STAT_MMSTA IN ('ZA')
        OR rw.PART_FLAG LIKE '%LTB%'
        THEN 'LTB '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN STRATEGY_GRP_STRGR NOT                                                                                     IN ('ZB', '40')
        AND NVL (PROC_TYPE_BESKZ, 'X')                                                                                   = 'E'
        AND NVL (NVL (stat.Q3_FREQ_COUNT, 0), 0) + NVL (NVL (stat.Q4_FREQ_COUNT, 0), 0) + NVL (stat.MRP_SUM12_DEMAND, 0) > 0
        THEN 'ACTIVE NON_STOCK MAKE '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN STRATEGY_GRP_STRGR NOT   IN ('ZB', '40')
        AND NVL (PROC_TYPE_BESKZ, 'X') = 'E'
        THEN 'INACTIVE NON_STOCK MAKE '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN STRATEGY_GRP_STRGR NOT                                                                                     IN ('ZB', '40')
        AND NVL (PROC_TYPE_BESKZ, 'X')                                                                                  != 'E'
        AND NVL (NVL (stat.Q3_FREQ_COUNT, 0), 0) + NVL (NVL (stat.Q4_FREQ_COUNT, 0), 0) + NVL (stat.MRP_SUM12_DEMAND, 0) > 0
        THEN 'ACTIVE NON_STOCK BUY '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN STRATEGY_GRP_STRGR NOT    IN ('ZB', '40')
        AND NVL (PROC_TYPE_BESKZ, 'X') != 'E'
        THEN 'INACTIVE NON_STOCK BUY '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN MRP_TYPE_DISMM LIKE '%ND%'
        THEN 'NO PLANNING '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN TRIM (SP_MATL_STAT_MMSTA) IS NOT NULL
        THEN 'BLOCKED BY MTL STATUS '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN stat.MATL_FIRST_USED                                                                    >= SYSDATE - 120
        AND (NVL (ABC_CLASS_MAABC, 'X')                                                               = 'M'
        OR ( NVL (stat.Q1_FREQ_COUNT, 0) + NVL (stat.Q2_FREQ_COUNT, 0) + NVL (stat.Q3_FREQ_COUNT, 0) <= 0
        AND ( (NVL (stat.Q4_FREQ_COUNT, 0)                                                            > 0)
        OR NVL ( stat.MRP_SUM12_DEMAND, 0)                                                            > 0)))
        THEN 'ACTIVE NEW PARTS '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END)                                     --|| rw.PART_FLAG
        WHEN stat.MATL_FIRST_USED <= SYSDATE - 120 --CPZ 12-16-13 from 365 to 120
        AND NVL (stat.AVG26_USAGE_QTY, 0)    * 100 --CPZ 12-16-13 from 52 to 26
                                             + NVL (stat.MRP_SUM12_DEMAND, 0) < (UNRESTRICTED_LABST + NVL ( INTRANSFER_STOCK_PLANT_UMLMC, 0) + NVL (STOCK_IN_TRANSIT_TRAME, 0) + NVL (STOCK_IN_TRANSIT_SV_VKUMC, 0) + NVL (STOCK_IN_TRANSIT_SP_VKTRW, 0) + NVL (INTRANSFER_UMLME, 0) + NVL (INQUALITY_INSME, 0) + NVL (RESTRICTED_USE_EINME, 0) + NVL (BLOCKED_SPEME, 0) + NVL (RETUNRS_RETME, 0))
        AND NVL (stat.AVG52_USAGE_QTY, 0)    + NVL (stat.MRP_SUM12_DEMAND, 0) > 0
        THEN 'ACTIVE EXCESS 2Y '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END)                                     --|| rw.PART_FLAG
        WHEN stat.MATL_FIRST_USED <= SYSDATE - 120 --CPZ 12-16-13 from 365 to 120
        AND NVL (stat.AVG26_USAGE_QTY, 0)    * 40  --CPZ 12-16-13 from 52 to 26
                                             + stat.MRP_SUM12_DEMAND          < (UNRESTRICTED_LABST + NVL ( INTRANSFER_STOCK_PLANT_UMLMC, 0) + NVL (STOCK_IN_TRANSIT_TRAME, 0) + NVL (STOCK_IN_TRANSIT_SV_VKUMC, 0) + NVL (STOCK_IN_TRANSIT_SP_VKTRW, 0) + NVL (INTRANSFER_UMLME, 0) + NVL (INQUALITY_INSME, 0) + NVL (RESTRICTED_USE_EINME, 0) + NVL (BLOCKED_SPEME, 0) + NVL (RETUNRS_RETME, 0))
        AND stat.AVG52_USAGE_QTY             + NVL (stat.MRP_SUM12_DEMAND, 0) > 0
        THEN 'ACTIVE EXCESS 1Y '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN rw.PART_FLAG IS NOT NULL
        AND UPPER (rw.PART_FLAG) LIKE 'TOP10K%'
        AND NVL (NVL (stat.Q3_FREQ_COUNT, 0), 0) + NVL (NVL (stat.Q4_FREQ_COUNT, 0), 0) + NVL (stat.MRP_SUM12_DEMAND, 0) >= 1
        THEN 'ACTIVE '
          || rw.PART_FLAG
          || '-'
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
        WHEN rw.PART_FLAG IS NOT NULL
        AND UPPER (rw.PART_FLAG) LIKE 'TOP10K%'
        AND NVL (stat.Q3_FREQ_COUNT, 0) + NVL (stat.Q4_FREQ_COUNT, 0) + NVL (stat.MRP_SUM12_DEMAND, 0) < 1
        THEN 'INACTIVE '
          || rw.PART_FLAG
          || '-'
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
        WHEN rw.PART_FLAG                                                                             IS NOT NULL
        AND NVL (stat.Q3_FREQ_COUNT, 0) + NVL (stat.Q4_FREQ_COUNT, 0) + NVL (stat.MRP_SUM12_DEMAND, 0) < 1
        THEN 'INACTIVE '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN rw.PART_FLAG IS NOT NULL
        THEN 'ACTIVE '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN stat.FREQUENCY_WK52_TO_WK26    > 0
        AND PLANT_USAGE26_FREQUENCY        <= 0
        AND NVL (stat.MRP_SUM12_DEMAND, 0) <= 0
        THEN 'INACTIVE '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        WHEN NVL (stat.MATL_FIRST_USED, SYSDATE - 400)                            <= SYSDATE - 360
        AND (NVL (stat.AVG52_USAGE_QTY, 0)      + NVL (stat.MRP_SUM12_DEMAND, 0)) <= 0
        AND NVL (stat.PLANT_USAGE52_FREQUENCY, 0)                                 <= 0 --CPZ 02-19-2013 added to account for parts with return but used
        THEN 'OBSOLETE NO USAGE '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
        ELSE 'ACTIVE '
          || (
          CASE
            WHEN NVL (rw.review_flag, 'k') LIKE 'SC_%'
            THEN rw.review_flag
            ELSE ''
          END)
          || '-'
          || (
          CASE
            WHEN UPPER (NVL (rw.part_flag, 'k')) LIKE UPPER ('%ATRISK%')
            THEN rw.part_flag
            ELSE ''
          END) --|| rw.PART_FLAG
      END INV_CLASS,
      OPEN_QTY OPEN_QTY, --CPZ 06-26-2012
      PO_OPEN_COUNT,
      PO_AVG_LS PO_AVG_LS, --CPZ 06-26-2012
      PO_NEXT_DELIVERY_DATE,
      PO_AVG_LT_TO_PROMISE,
      PO_AVG_LT_TO_RECIEVE,
      PO_STDEV_LT_TO_RECIEVE,
      PO_AVG_LT_TO_STAT,
      PERFORMANCEQ1ONTIME,
      PERFORMANCEQ2ONTIME,
      PERFORMANCEQ3ONTIME,
      PERFORMANCEQ4ONTIME,
      POPASTDUE_QTY POPASTDUE_QTY, --CPZ 01-31-2012
      SALES_ORG_COUNT,
      DIRECT_SHIP_PLANT,
      DELIVERY_PLANT,
      DMI_MANAGED,
      LOT_SIZE_DISLS,
      NVL (P.ROUND_VALUE_BSTRF, 0) LOT_ROUNDING_VALUE,
      NVL (P.MIN_LOT_SIZE_BSTMI, 0) LOT_MIN_BUY,
      MEINS_ISSUE_UOM,
      ISSUE_UOM_DENOMINATOR,
      ISSUE_UOM_NUMERATOR,
      BSTME_PO_UOM,
      PO_UOM_DENOMINATOR,
      PO_UOM_NUMERATOR,
      DIST_CHNL_STATUS,
      SATNR_CROSSPLNTCM,
      MATL_CONFIG_KZKFG,
      MATL_TYPE_MTART,
      rw.REVIEWED_BY_SS_ROP,
      rw.REVIEWED_BY_SS_ROP_DATE,
      p.plantid PLANTIDORIG
    FROM INV_SAP_PP_PARAM p --- (select * from  INV_SAP_PP_PARAM where  materialid ='PN-20116') p
      ,
      INV_SAP_PURCH_SOURCE_UNQ pff,
      INV_SAP_PLAN_PARAM_REVIEW rw,
      DWQ$LIBRARIAN.INV_SAP_USAGE_STAT2 stat,
      INV_SAP_SALES_STAT2 statSls ---
      ,
      INV_SAP_PO_STAT postat,
      (SELECT a.*,
        TO_NUMBER (LEVEL_VALUE) LEVEL_VALUE_PLANT
      FROM INV_SAP_PP_CS_LEVELS a
      WHERE LEVEL_TYPE = '0-PLANT'
      ) Gwthplt,
      (SELECT * FROM INV_SAP_PP_CS_LEVELS WHERE LEVEL_TYPE = '1-BU'
      ) Gwthbu,
      (SELECT * FROM INV_SAP_PP_CS_LEVELS WHERE LEVEL_TYPE = '2-PRODLINE'
      ) Gwthpl,
      (SELECT * FROM INV_SAP_PP_CS_LEVELS WHERE LEVEL_TYPE = '2B-SUPPLIER'
      ) Gwthsup,
      (SELECT * FROM INV_SAP_PP_CS_LEVELS WHERE LEVEL_TYPE = '3-PROD_SCHEDULER'
      ) Gwthpsch,
      (SELECT * FROM INV_SAP_PP_CS_LEVELS WHERE LEVEL_TYPE = '4-MRPCONTROLLER'
      ) Gwthmrp,
      (SELECT * FROM INV_SAP_PP_CS_LEVELS WHERE LEVEL_TYPE = '5-PART_FLAG'
      ) Gwthprtflg,
      (SELECT * FROM INV_SAP_PP_CS_LEVELS WHERE LEVEL_TYPE = '6-MATERIAL'
      ) Gwthmtl
    WHERE p.PLANTID  = stat.PLANT(+)
    AND p.MATERIALID = stat.MATERIAL(+)
      ------ Sales
    AND p.MATERIALID = statSls.MATERIAL(+)
    AND p.plantid    = statsls.plant(+)
      --- review
    AND p.MATERIALID = RW.MATERIALID(+)
    AND p.PLANTID    = RW.PLANTID(+)
      --- supplier
    AND p.PLANTID    = pff.PLANTID(+)
    AND p.MATERIALID = pff.MATERIALID(+)
      --   postats
    AND p.PLANTID    = postat.PLANTID(+)
    AND p.MATERIALID = postat.MATERIALID(+)
      --- 0-PLANTLEVEL
    AND p.PLANTID = Gwthplt.PLANTID(+)
    AND p.PLANTID = Gwthplt.LEVEL_VALUE_PLANT(+)
      --- '1-BU'
    AND p.PLANTID                             = Gwthbu.PLANTID(+)
    AND SUBSTR (p.PROD_HIERARCHY_PRDHA, 1, 3) = Gwthbu.LEVEL_VALUE(+)
      ---'2-PRODLINE'
    AND pff.PLANTID   = Gwthsup.PLANTID(+)
    AND pff.VENDOR_NO = Gwthsup.LEVEL_VALUE(+)
      ---'2-PRODLINE'
    AND p.PLANTID                             = Gwthpl.PLANTID(+)
    AND SUBSTR (p.PROD_HIERARCHY_PRDHA, 1, 7) = Gwthpl.LEVEL_VALUE(+)
      ---'3-PROD_SCHEDULER'
    AND p.PLANTID          = Gwthpsch.PLANTID(+)
    AND p.PROD_SCHED_FEVOR = Gwthpsch.LEVEL_VALUE(+)
      --- '4-MRPCONTROLLER'
    AND p.PLANTID              = Gwthmrp.PLANTID(+)
    AND p.MRP_CONTROLLER_DISPO = Gwthmrp.LEVEL_VALUE(+)
      ----'5-REVIEW_FLAG' ----
    AND rw.PLANTID     = Gwthprtflg.PLANTID(+)
    AND rw.REVIEW_FLAG = Gwthprtflg.LEVEL_VALUE(+)
      --'6-MATERIAL'
    AND p.PLANTID    = Gwthmtl.PLANTID(+)
    AND p.MATERIALID = Gwthmtl.LEVEL_VALUE(+)
    ) PARAM
  ) par;