--Function show
SELECT ID,
  MATERIALID,
  SUM(WEEK_1) AS WK_1,
  SUM(WEEK_2) AS WK_2,
  SUM(WEEK_3) AS WK_3,
  SUM(WEEK_4) AS WK_4,
  SUM(WEEK_5) AS WK_5,
  SUM(WEEK_6) AS WK_6,
  SUM(WEEK_7) AS WK_7,
  SUM(WEEK_8) AS WK_8,
  SUM(WEEK_9) AS WK_9,
  SUM(WEEK_10) AS WK_10,
  SUM(WEEK_11) AS WK_11,
  SUM(WEEK_12) AS WK_12,
  SUM(WEEK_13) AS WK_13
FROM
  (SELECT MATERIALID
    ||'_'
    ||PLANTID AS ID,
    MATERIALID,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw')
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_1,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 1
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_2,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 2
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_3,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 3
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_4,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 4
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_5,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 5
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_6,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 6
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_7,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 7
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_8,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 8
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_9,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 9
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_10,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 10
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_11,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 11
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_12,
    CASE
      WHEN WEEK_NUMBER = TO_CHAR(SYSDATE,'iw') + 12
      THEN PLNMG_PLANNEDQUANTITY
      ELSE 0
    END WEEK_13,
    PLANTID
  FROM
    (SELECT MATERIALID,
      PLANTID,
      PDATU_DELIV_ORDFINISHDATE,
      TO_CHAR(PDATU_DELIV_ORDFINISHDATE,'iw') AS WEEK_NUMBER,
      MEINS_BASEUNITOFMEASURE,
      PLNMG_PLANNEDQUANTITY,
      BEDAEP_REQUIREMENTSTYPE,
      VERSBP_VERSION
    FROM INV_SAP_PP_FRCST_PBIM_PBED
    WHERE VERSBP_VERSION = '55'
    AND PDATU_DELIV_ORDFINISHDATE BETWEEN TO_CHAR(sysdate) AND TO_CHAR(sysdate + 91)
    )
  )group by ID, MATERIALID;
  
  
 -- SELECT ACCURATE DATE IN DB
 -- IF SYSDATE IN 8.27, SO UNDER SELECT CODE JUST SELCT 8.26 DATA
 SELECT * FROM INV_SAP_INV_REC WHERE REC_DATE BETWEEN TO_CHAR(SYSDATE - 1) AND TO_CHAR(SYSDATE) AND ID = 'PN-C76223_5200'
 
 
 -- Find Mon,Tue...
 SELECT to_char(to_date('20041009','yyyymmdd'),'D') FROM DUAL

to_char(some_date,'D') returns a number indicating the weekday.
 
 
 
 
 
 
 
 
