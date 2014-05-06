-- Unable to render VIEW DDL for object DWQ$LIBRARIAN.INV_SAP_PP_PARAM_V with DBMS_METADATA attempting internal generator.
CREATE VIEW DWQ$LIBRARIAN.INV_SAP_PP_PARAM_V AS
SELECT dqd.*,
  cr.plantiddemand PLANTIDDEMAND
FROM
  (SELECT dqd.MATERIALID,
    PLANTID,
    MATL_DESC_MAKTX,
    MATL_TYPE_MTART,
    BASE_UOM_MEINS,
    MATL_GROUP_MATKL,
    PURCH_GROUP_EKGRP,
    PROD_HIERARCHY_PRDHA,
    ABC_CLASS_MAABC,
    SP_MATL_STAT_MMSTA,
    MRP_TYPE_DISMM,
    REORDER_PT_MINBE,
    PLN_CYL_LFRHY,
    PLN_TIME_FENCE_FXHOR,
    MRP_CONTROLLER_DISPO,
    LOT_SIZE_DISLS,
    FX_LOT_SIZE_BSTFE,
    MIN_LOT_SIZE_BSTMI,
    MAX_LOT_SIZE_BSTMA,
    MAX_STK_LVL_MABST,
    ASSY_SCRAP_PCT_AUSSS,
    ROUND_VALUE_BSTRF,
    PROC_TYPE_BESKZ,
    SPC_PROC_KEY_SOBSL,
    BACKFLUSH_RGEKZ,
    ISS_STOR_LOC_LGPRO,
    EP_STOR_LOC_LGFSB,
    BULK_MATL_SCHGT,
    LT_REC_WEBAZ,
    LT_DELV_PLIFZ,
    IH_PROD_TIME_DZEIT,
    SAFETY_STK_EISBE,
    SERVICE_LVL_LGRAD,
    MIN_SAFETY_STK_EISLO,
    SAFETY_TIME_IND_SHFLG,
    SAFETY_TIME_COV_SHZET,
    PERIOD_IND_PERKZ,
    FY_VARIANT_PERIV,
    STRATEGY_GRP_STRGR,
    CONSUMP_MD_VRMOD,
    CONSUMP_BK_VINT1,
    CONSUMP_FW_VINT2,
    AVAIL_IND_MTVFP,
    PROD_SCHED_FEVOR,
    PROD_SCHED_PROF_SFCPF,
    SETUP_TIME_RUEZT,
    INTER_OP_TRANZ,
    RUN_TIME_BEARZ,
    BASE_QTY_BASMG,
    CYCLE_CNT_IND_ABCIN,
    RECPT_SLIPS_WESCH,
    KANBAN_NBR_BEHAZ,
    MAX_EMPTY_SIGAZ,
    KANBAN_QTY_BEHMG,
    PHASE_OUT_IND_KZAUS,
    PHASE_OUT_DTE_AUSDT,
    PROFIT_CTR_PRCTR,
    UNIT_COST_STPRD,
    UNIT_PER_PEINH,
    UNIT_COST,
    SAP_ITEM_MATNR,
    PLANT_WERKS,
    COSTING_TYPE_BKLAS,
    INTRANSFER_STOCK_PLANT_UMLMC,
    STOCK_IN_TRANSIT_TRAME,
    STOCK_IN_TRANSIT_SV_VKUMC,
    STOCK_IN_TRANSIT_SP_VKTRW,
    TRLT_WZEIT,
    oh.SLOC_LGORT --- SLOC_LGORT                    VARCHAR2(100 BYTE),
    ,
    oh.LOC_LGORT_COUNT --- LOC_LGORT_COUNT               NUMBER,
    ,
    NVL (oh.UNRESTRICTED_LABST, 0) UNRESTRICTED_LABST --- UNRESTRICTED_LABST            NUMBER,
    ,
    NVL (oh.INTRANSFER_UMLME, 0) INTRANSFER_UMLME --- INTRANSFER_UMLME              NUMBER,
    ,
    NVL (oh.INQUALITY_INSME, 0) INQUALITY_INSME --- INQUALITY_INSME               NUMBER,
    ,
    NVL (oh.RESTRICTED_USE_EINME, 0) RESTRICTED_USE_EINME --- RESTRICTED_USE_EINME          NUMBER,
    ,
    NVL (oh.BLOCKED_SPEME, 0) BLOCKED_SPEME --- BLOCKED_SPEME                 NUMBER,
    ,
    NVL (oh.RETUNRS_RETME, 0) RETUNRS_RETME --- RETUNRS_RETME                 NUMBER,
    ,
    NULL DATE_OF_LAST_COUNT_DLINL --- DATE_OF_LAST_COUNT_DLINL      DATE, ---- remeved from extract no need for it
    ,
    NULL FIRST_SLOC_CREATED_DATE --- FIRST_SLOC_CREATED_DATE       DATE
    ,
    BRGEW_GROSS_WEIGHT,
    NTGEW_NET_WEIGHT,
    GEWEI_WEIGHT_UNIT,
    VOLUM_VOLUME,
    VOLEH_VOLUME_UNIT,
    LAENG_LENGTH,
    BREIT_WIDTH,
    HOEHE_HEIGHT,
    MEABM_UNITOFDIMENSION,
    mvke.SALES_ORG_COUNT,
    mvke.DIRECT_SHIP_PLANT,
    mvke.DELIVERY_PLANT,
    mvke.DMI_MANAGED,
    ERSDA_SAP_CREATED_DATE,
    KAUTB_AUTO_PO,
    DW_DATE,
    MEINS_ISSUE_UOM,
    CASE
      WHEN issmarm.BUM_DEN IS NULL
      OR issmarm.BUM_DEN    = 0
      THEN 1
      ELSE NVL (issmarm.BUM_DEN, 1)
    END ISSUE_UOM_DENOMINATOR,
    NVL (issmarm.BUM_NUM, 1) ISSUE_UOM_NUMERATOR,
    BSTME_PO_UOM,
    CASE
      WHEN pomarm.BUM_DEN IS NULL
      OR pomarm.BUM_DEN    = 0
      THEN 1
      ELSE NVL (pomarm.BUM_DEN, 1)
    END PO_UOM_DENOMINATOR,
    NVL (pomarm.BUM_NUM, 1) PO_UOM_NUMERATOR,
    mvke.DIST_CHNL_STATUS,
    SATNR_CROSSPLNTCM,
    MATL_CONFIG_KZKFG
  FROM
    (SELECT
      /*+ DRIVING_SITE(MARC) DRIVING_SITE(MARA) DRIVING_SITE(MBEW) DRIVING_SITE(MARD) DRIVING_SITE(MAKT) DRIVING_SITE(mvke) */
      CASE
        WHEN TRANSLATE ( marc.matnr, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~`@#$%^&*()_-+={[}]|\:;"<,>.?/', '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!') LIKE '%!%'
        THEN TRIM (marc.MATNR)
        WHEN TRIM (marc.MATNR) LIKE '00000000000___ ___'
        THEN SUBSTR (TRIM (marc.MATNR), 12, 50)
        WHEN TRIM (marc.MATNR) LIKE '0%'
        THEN TO_CHAR ( TO_NUMBER ( REPLACE (TRIM (marc.MATNR), ',', NULL)))
        ELSE TRIM (marc.MATNR)
      END MATERIALID,
      TO_NUMBER (TRIM (marc.WERKS)) PLANTID --- PLANTID                       NUMBER,
      ,
      dscr.MAKTX MATL_DESC_MAKTX --- MATL_DESC_MAKTX               VARCHAR2(100 BYTE),
      ,
      TRIM (MTART) MATL_TYPE_MTART --- MATL_TYPE_MTART               VARCHAR2(100 BYTE),
      ,
      TRIM (MEINS) BASE_UOM_MEINS --- BASE_UOM_MEINS                VARCHAR2(100 BYTE),
      ,
      TRIM (MATKL) MATL_GROUP_MATKL --- MATL_GROUP_MATKL              VARCHAR2(100 BYTE),
      ,
      TRIM (EKGRP) PURCH_GROUP_EKGRP --- PURCH_GROUP_EKGRP             VARCHAR2(100 BYTE),
      ,
      TRIM (mara.PRDHA) PROD_HIERARCHY_PRDHA --- PROD_HIERARCHY_PRDHA          VARCHAR2(100 BYTE),
      ,
      TRIM (MAABC) ABC_CLASS_MAABC --- ABC_CLASS_MAABC               VARCHAR2(100 BYTE),
      ,
      TRIM (MMSTA) SP_MATL_STAT_MMSTA --- SP_MATL_STAT_MMSTA            VARCHAR2(100 BYTE),
      ,
      DISMM MRP_TYPE_DISMM --- MRP_TYPE_DISMM                VARCHAR2(100 BYTE),
      ,
      TO_NUMBER (TRIM (MINBE)) REORDER_PT_MINBE --- REORDER_PT_MINBE              NUMBER,
      ,
      LFRHY PLN_CYL_LFRHY --- PLN_CYL_LFRHY                 VARCHAR2(100 BYTE),
      ,
      TO_NUMBER (TRIM (FXHOR)) PLN_TIME_FENCE_FXHOR --- PLN_TIME_FENCE_FXHOR          NUMBER,
      ,
      DISPO MRP_CONTROLLER_DISPO --- MRP_CONTROLLER_DISPO          VARCHAR2(100 BYTE),
      ,
      DISLS LOT_SIZE_DISLS --- LOT_SIZE_DISLS                VARCHAR2(100 BYTE),
      ,
      TO_NUMBER (TRIM (BSTFE)) FX_LOT_SIZE_BSTFE --- FX_LOT_SIZE_BSTFE             NUMBER,
      ,
      TO_NUMBER (TRIM (BSTMI)) MIN_LOT_SIZE_BSTMI --- MIN_LOT_SIZE_BSTMI            NUMBER,
      ,
      TO_NUMBER (TRIM (BSTMA)) MAX_LOT_SIZE_BSTMA --- MAX_LOT_SIZE_BSTMA            NUMBER,
      ,
      TO_NUMBER (TRIM (MABST)) MAX_STK_LVL_MABST --- MAX_STK_LVL_MABST             NUMBER,
      ,
      TO_NUMBER (TRIM (AUSSS)) ASSY_SCRAP_PCT_AUSSS --- ASSY_SCRAP_PCT_AUSSS          NUMBER,
      ,
      TO_NUMBER (TRIM (BSTRF)) ROUND_VALUE_BSTRF --- ROUND_VALUE_BSTRF             NUMBER,
      ,
      BESKZ PROC_TYPE_BESKZ --- PROC_TYPE_BESKZ               VARCHAR2(100 BYTE),
      ,
      SOBSL SPC_PROC_KEY_SOBSL --- SPC_PROC_KEY_SOBSL            VARCHAR2(100 BYTE),
      ,
      RGEKZ BACKFLUSH_RGEKZ --- BACKFLUSH_RGEKZ               VARCHAR2(100 BYTE),
      ,
      LGPRO ISS_STOR_LOC_LGPRO --- ISS_STOR_LOC_LGPRO            VARCHAR2(100 BYTE),
      ,
      LGFSB EP_STOR_LOC_LGFSB --- EP_STOR_LOC_LGFSB             VARCHAR2(100 BYTE),
      ,
      SCHGT BULK_MATL_SCHGT --- BULK_MATL_SCHGT               VARCHAR2(100 BYTE),
      ,
      TO_NUMBER (TRIM (WEBAZ)) LT_REC_WEBAZ --- LT_REC_WEBAZ                  NUMBER,
      ,
      TO_NUMBER (TRIM (PLIFZ)) LT_DELV_PLIFZ --- LT_DELV_PLIFZ                 NUMBER,
      ,
      TO_NUMBER (TRIM (DZEIT)) IH_PROD_TIME_DZEIT --- IH_PROD_TIME_DZEIT            NUMBER,
      ,
      TO_NUMBER (TRIM (EISBE)) SAFETY_STK_EISBE --- SAFETY_STK_EISBE              NUMBER,
      ,
      TO_NUMBER (TRIM (LGRAD)) SERVICE_LVL_LGRAD --- SERVICE_LVL_LGRAD             NUMBER,
      ,
      TO_NUMBER (TRIM (EISLO)) MIN_SAFETY_STK_EISLO --- MIN_SAFETY_STK_EISLO          NUMBER,
      ,
      TO_NUMBER (TRIM (SHFLG)) SAFETY_TIME_IND_SHFLG --- SAFETY_TIME_IND_SHFLG         NUMBER,
      ,
      TO_NUMBER (TRIM (SHZET)) SAFETY_TIME_COV_SHZET --- SAFETY_TIME_COV_SHZET         NUMBER,
      ,
      PERKZ PERIOD_IND_PERKZ --- PERIOD_IND_PERKZ              VARCHAR2(100 BYTE),
      ,
      PERIV FY_VARIANT_PERIV --- FY_VARIANT_PERIV              VARCHAR2(100 BYTE),
      ,
      STRGR STRATEGY_GRP_STRGR --- STRATEGY_GRP_STRGR            VARCHAR2(100 BYTE),
      ,
      VRMOD CONSUMP_MD_VRMOD --- CONSUMP_MD_VRMOD              VARCHAR2(100 BYTE),
      ,
      VINT1 CONSUMP_BK_VINT1 --- CONSUMP_BK_VINT1              VARCHAR2(100 BYTE),
      ,
      VINT2 CONSUMP_FW_VINT2 --- CONSUMP_FW_VINT2              VARCHAR2(100 BYTE),
      ,
      MTVFP AVAIL_IND_MTVFP --- AVAIL_IND_MTVFP               VARCHAR2(100 BYTE),
      ,
      TRIM (FEVOR) PROD_SCHED_FEVOR --- PROD_SCHED_FEVOR              VARCHAR2(100 BYTE),
      ,
      SFCPF PROD_SCHED_PROF_SFCPF --- PROD_SCHED_PROF_SFCPF         VARCHAR2(100 BYTE),
      ,
      TO_NUMBER ( (RUEZT)) SETUP_TIME_RUEZT --- SETUP_TIME_RUEZT              NUMBER,
      ,
      TO_NUMBER ( (TRANZ)) INTER_OP_TRANZ --- INTER_OP_TRANZ                NUMBER,
      ,
      TO_NUMBER ( (BEARZ)) RUN_TIME_BEARZ --- RUN_TIME_BEARZ                NUMBER,
      ,
      TO_NUMBER ( (BASMG)) BASE_QTY_BASMG --- BASE_QTY_BASMG                NUMBER,
      ,
      TRIM (ABCIN) CYCLE_CNT_IND_ABCIN --- CYCLE_CNT_IND_ABCIN           VARCHAR2(100 BYTE),
      ,
      WESCH RECPT_SLIPS_WESCH --- RECPT_SLIPS_WESCH              VARCHAR2(100 BYTE),,
      ,
      0 KANBAN_NBR_BEHAZ --- KANBAN_NBR_BEHAZ              NUMBER,
      ,
      0 MAX_EMPTY_SIGAZ --- MAX_EMPTY_SIGAZ               NUMBER,
      ,
      0 KANBAN_QTY_BEHMG --- KANBAN_QTY_BEHMG              NUMBER,
      ,
      KZAUS PHASE_OUT_IND_KZAUS --- PHASE_OUT_IND_KZAUS           VARCHAR2(100 BYTE),
      ,
      AUSDT PHASE_OUT_DTE_AUSDT --- PHASE_OUT_DTE_AUSDT           VARCHAR2(100 BYTE),
      ,
      PRCTR PROFIT_CTR_PRCTR --- PROFIT_CTR_PRCTR              VARCHAR2(100 BYTE),
      ,
      TO_NUMBER (TRIM (NVL (mbew.STPRS, 0))) UNIT_COST_STPRD --- UNIT_COST_STPRD               NUMBER,
      ,
      TO_NUMBER (TRIM (NVL (mbew.PEINH, 0))) UNIT_PER_PEINH --- UNIT_PER_PEINH                NUMBER,
      ,
      NVL (
      CASE
        WHEN TO_NUMBER ( TRIM (NVL (mbew.PEINH, 0))) <= 0
        THEN 0
        WHEN TO_NUMBER ( TRIM (NVL (mbew.STPRS, 0))) <= 0
        THEN 0
        ELSE TO_NUMBER (TRIM (NVL (mbew.STPRS, 0))) / TO_NUMBER ( TRIM (NVL (mbew.PEINH, 0)))
      END, 0) UNIT_COST --- unit cost
      ,
      marc.MATNR SAP_ITEM_MATNR --- SAP_ITEM_MATNR                VARCHAR2(100 BYTE),
      ,
      marc.WERKS PLANT_WERKS --- PLANT_WERKS                   VARCHAR2(100 BYTE),
      ,
      NVL (mbew.BKLAS, 0) COSTING_TYPE_BKLAS --- COSTING_TYPE_BKLAS            VARCHAR2(100 BYTE),
      ,
      TO_NUMBER (TRIM (UMLMC)) INTRANSFER_STOCK_PLANT_UMLMC --- INTRANSFER_STOCK_PLANT_UMLMC  NUMBER,
      ,
      TO_NUMBER (TRIM (TRAME)) STOCK_IN_TRANSIT_TRAME --- STOCK_IN_TRANSIT_TRAME        NUMBER,
      ,
      TO_NUMBER (TRIM (VKUMC)) STOCK_IN_TRANSIT_SV_VKUMC --- STOCK_IN_TRANSIT_SV_VKUMC     NUMBER,
      ,
      TO_NUMBER (TRIM (VKTRW)) STOCK_IN_TRANSIT_SP_VKTRW --- STOCK_IN_TRANSIT_SP_VKTRW     NUMBER,
      ,
      TO_NUMBER (TRIM (WZEIT)) TRLT_WZEIT --- TRLT_WZEIT                    NUMBER,
      ,
      TO_NUMBER (TRIM (BRGEW)) BRGEW_Gross_Weight,
      TO_NUMBER (TRIM (NTGEW)) NTGEW_Net_Weight,
      TRIM (GEWEI) GEWEI_Weight_Unit,
      TO_NUMBER (TRIM (VOLUM)) VOLUM_Volume,
      TRIM (VOLEH) VOLEH_Volume_Unit,
      TO_NUMBER (TRIM (LAENG)) LAENG_Length,
      TO_NUMBER (TRIM (BREIT)) BREIT_Width,
      TO_NUMBER (TRIM (HOEHE)) HOEHE_Height,
      TRIM (MEABM) MEABM_UnitOfDimension,
      CASE
        WHEN mara.ERSDA = '00000000'
        THEN NULL
        ELSE TO_DATE (mara.ERSDA, 'yyyymmdd')
      END ERSDA_SAP_CREATED_DATE,
      KAUTB KAUTB_AUTO_PO,
      SYSDATE dw_date,
      mara.MEINS MEINS_ISSUE_UOM,
      mara.BSTME BSTME_PO_UOM,
      mara.SATNR SATNR_CROSSPLNTCM,
      mara.KZKFG MATL_CONFIG_KZKFG
    FROM SAPECC_DLY_LIBRARIAN.MARC@dqd.mke.ra.rockwell.com marc,
      SAPECC_DLY_LIBRARIAN.MARA@DQD.mke.ra.rockwell.com mara,
      (SELECT MATNR,
        MAX (MAKTX) MAKTX
      FROM SAPECC_DLY_LIBRARIAN.MAKT@DQD.mke.ra.rockwell.com
      WHERE SPRAS = 'E'
      GROUP BY MATNR
      ) Dscr,
      (SELECT MATNR,
        BWKEY,
        MAX (PEINH) PEINH,
        MAX (BWTAR) BWTAR,
        MAX (STPRS) STPRS,
        MAX (BKLAS) BKLAS
      FROM SAPECC_DLY_LIBRARIAN.MBEW@DQD.mke.ra.rockwell.com
      GROUP BY MATNR,
        BWKEY
      ) mbew
    WHERE marc.MATNR = mara.MATNR
    AND marc.MATNR   = Dscr.MATNR(+)
    AND marc.MATNR   = mbew.MATNR(+)
    AND marc.WERKS   = mbew.BWKEY(+)
    ) dqd,
    (SELECT MATERIALID,
      COUNT (DISTINCT Sales_Org) SALES_ORG_COUNT,
      MIN (
      CASE
        WHEN Direct_Ship_Cust = 'Y'
        THEN Direct_SHIP_PLANT
        ELSE 'N'
      END) DIRECT_SHIP_PLANT,
      CASE
        WHEN MAX (Direct_SHIP_PLANT) = MIN (Direct_SHIP_PLANT)
        THEN MAX (Direct_SHIP_PLANT)
        ELSE MAX ( Direct_SHIP_PLANT
          || '-S'
          || Sales_Org)
          || '-'
          || MIN ( Direct_SHIP_PLANT
          || '-S'
          || Sales_Org)
      END DELIVERY_PLANT,
      CASE
        WHEN MAX (DMI_Managed) = MIN (DMI_Managed)
        THEN MIN (NVL (TRIM (DMI_Managed), 'N'))
        ELSE MAX ( NVL (TRIM (DMI_Managed), 'N')
          || '-S'
          || Sales_Org)
          || '-'
          || MIN ( NVL (TRIM (DMI_Managed), 'N')
          || '-S'
          || Sales_Org)
      END DMI_MANAGED,
      CASE
        WHEN MAX (D_Chain_Blk) = MIN (D_Chain_Blk)
        THEN MIN (NVL (TRIM (D_Chain_Blk), 'N'))
        ELSE MAX ( NVL (TRIM (D_Chain_Blk), 'N')
          || '-S'
          || Sales_Org)
          || '-'
          || MIN ( NVL (TRIM (D_Chain_Blk), 'N')
          || '-S'
          || Sales_Org)
      END DIST_CHNL_STATUS
    FROM INV_SAP_PP_MVKE
    GROUP BY MATERIALID
    ) mvke,
    INV_SAP_PP_MARM pomarm,
    INV_SAP_PP_MARM issmarm,
    INV_SAP_PP_INVENTORY_V oh ---- view in qdw extracted from MARD  independently
  WHERE dqd.MATERIALID    = mvke.MATERIALID(+)
  AND dqd.materialid      = pomarm.materialid(+)
  AND dqd.BSTME_PO_UOM    = pomarm.MEINH(+)
  AND dqd.materialid      = issmarm.materialid(+)
  AND dqd.MEINS_ISSUE_UOM = issmarm.MEINH(+)
  AND dqd.materialid      = oh.MATNR(+)
  AND dqd.plantid         = oh.WERKS(+)
  ) dqd
INNER JOIN DWQ$LIBRARIAN.INV_SAP_PLANT_CROSS cr
ON dqd.plantid    = cr.plantid
WHERE cr.include IN ('Y')