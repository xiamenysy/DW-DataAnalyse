--in out report
--date#:07172014
--Author#:Huang Moyue

SELECT ID,
  MATERIALID,
  SUM(MONTH_1)  AS MONTH_1,
  SUM(MONTH_2)  AS MONTH_2,
  SUM(MONTH_3)  AS MONTH_3,
  SUM(MONTH_4)  AS MONTH_4,
  SUM(MONTH_5)  AS MONTH_5,
  SUM(MONTH_6)  AS MONTH_6,
  SUM(MONTH_7)  AS MONTH_7,
  SUM(MONTH_8)  AS MONTH_8,
  SUM(MONTH_9)  AS MONTH_9,
  SUM(MONTH_10) AS MONTH_10,
  SUM(MONTH_11) AS MONTH_11,
  SUM(MONTH_12) AS MONTH_12,
  SUM(MONTH_13) AS MONTH_13,
  SUM(MONTH_14) AS MONTH_14,
  SUM(MONTH_15) AS MONTH_15,
  SUM(MONTH_16) AS MONTH_16,
  SUM(MONTH_17) AS MONTH_17,
  SUM(MONTH_18) AS MONTH_18
FROM
  (SELECT ID,
    MATERIALID,
    PLANTID,
    CASE
      WHEN MONTH_NUMBER <= TO_CHAR(SYSDATE,'mm')
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_1,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 1
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_2,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 2
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_3,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 3
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_4,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 4
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_5,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 5
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_6,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 6
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_7,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 7
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_8,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 8
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_9,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 9
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_10,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 10
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_11,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 11
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_12,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 12
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_13,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 13
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_14,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 14
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_15,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 15
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_16,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 16
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_17,
    CASE
      WHEN MONTH_NUMBER = TO_CHAR(SYSDATE,'mm') + 17
      THEN OPEN_PLAN_QTY
      ELSE 0
    END MONTH_18
  FROM
    (SELECT MATERIALID
      ||'_'
      ||PLANTID AS ID,
      MATERIALID,
      PLANTID,
      TO_CHAR(DATEDELIVERY,'mm') AS MONTH_NUMBER,
      PONUMBER,
      PO_OPENQTY AS OPEN_PLAN_QTY
    FROM INV_SAP_IO_INPUTS_DAILY
    WHERE INPUT_TYPE = 'PLAN_PD_PO'
    AND DATEDELIVERY < TO_CHAR(sysdate + 532)
      --SELECT * FROM  INV_SAP_IO_INPUTS_DAILY WHERE MATERIALID = '1769-OW16 A' AND PLANTID = '5040' AND PONUMBER = '1554930410'
    )
  )
GROUP BY ID,
  MATERIALID;
  
  
  
  
  SELECT * FROM INV_SAP_BACKLOG_SO WHERE SALES_DOC = '6501929301'