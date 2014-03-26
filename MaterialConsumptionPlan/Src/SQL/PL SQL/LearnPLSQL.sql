--The simplest PL&SQL script
BEGIN
  SYS.DBMS_OUTPUT.PUT_LINE('Hello PLSQL!');
END;

-- Add paramater in declare
DECLARE
  time_now VARCHAR2(20 CHAR);
BEGIN
  time_now := SYSDATE;
  SYS.DBMS_OUTPUT.PUT_LINE(time_now);
END;

--Add Parameter in procedure
create or replace procedure insert_name_date(name_in IN VARCHAR2)
IS
  date_in VARCHAR2(20 CHAR);
BEGIN
  date_in := SYSDATE;
  INSERT INTO EMPLOYEE_NAME_BIRTHDAY
  (NAME, BIRTHDAY)
  VALUES (name_in, date_in);
END;


------------------------------------------loop----------------------------------------
--File on web: loop_examples.sql
create or replace PROCEDURE display_multiple_years(
    start_year_in IN PLS_INTEGER ,
    end_year_in   IN PLS_INTEGER )
IS
  l_current_year PLS_INTEGER := start_year_in;
BEGIN
  LOOP
    EXIT
  WHEN l_current_year > end_year_in;
    display_total_sales (l_current_year);
    l_current_year := l_current_year + 1;
  END LOOP;
END display_multiple_years;


CREATE OR REPLACE PROCEDURE display_multiple_years(
    start_year_in IN PLS_INTEGER ,
    end_year_in   IN PLS_INTEGER )
IS
  l_current_year PLS_INTEGER := start_year_in;
BEGIN
  WHILE (l_current_year <= end_year_in)
  LOOP
    display_total_sales (l_current_year);
    l_current_year := l_current_year + 1;
  END LOOP;
END display_multiple_years;









----------------------------------------String Usage-----------------------------------

DECLARE
  names          VARCHAR2(60) := 'Anna,Matt,Joe,Nathan,Andrew,Aaron,Jeff';
  comma_location NUMBER       := 0;
BEGIN
  LOOP
    comma_location := INSTR(names,',',comma_location+1);  ---comma_location + 1 means jump to next char
    EXIT
  WHEN comma_location = 0;
    SYS.DBMS_OUTPUT.PUT_LINE(comma_location);
  END LOOP;
END;

--Another case for string
DECLARE
  names          VARCHAR2(60) := 'Anna,Matt,Joe,Nathan,Andrew,Aaron,Jeff';
  names_adjusted VARCHAR2(61);
  comma_location NUMBER := 0;
  prev_location  NUMBER := 0;
BEGIN
  --Stick a comma after the final name
  names_adjusted := names || ',';
  LOOP
    comma_location := INSTR(names_adjusted,',',comma_location+1);
    EXIT
  WHEN comma_location = 0;
    SYS.DBMS_OUTPUT.PUT_LINE( SUBSTR(names_adjusted,prev_location+1, comma_location-prev_location-1));
    prev_location := comma_location;
  END LOOP;
END;

--String replacement
DECLARE
  names VARCHAR2(60) := 'Anna,Matt,Joe,Nathan,Andrew,Aaron,Jeff';
BEGIN
  SYS.DBMS_OUTPUT.PUT_LINE( REPLACE(names, ',', chr(10)) );
END;


--String pedding
DECLARE
  a VARCHAR2(30) := 'Jeff';
  b VARCHAR2(30) := 'Eric';
  c VARCHAR2(30) := 'Andrew';
  d VARCHAR2(30) := 'Aaron';
  e VARCHAR2(30) := 'Matt';
  f VARCHAR2(30) := 'Joe';
BEGIN
  SYS.DBMS_OUTPUT.PUT_LINE( RPAD(a,10) || LPAD(b,10));
  SYS.DBMS_OUTPUT.PUT_LINE( RPAD(a,10,'.') || LPAD(b,10,'.') );
END;

---Trim
DECLARE
  a VARCHAR2(40) := 'This sentence has too many periods......';
  b VARCHAR2(40) := 'The number 1';
BEGIN
  DBMS_OUTPUT.PUT_LINE( RTRIM(a,'.') );
  DBMS_OUTPUT.PUT_LINE( LTRIM(b, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz') );
END;
























---------------------------------------Cursor Usage------------------------------------
DECLARE
    v_name EMPLOYEE_NAME_BIRTHDAY.NAME%TYPE;
    CURSOR c_cursor IS SELECT NAME FROM EMPLOYEE_NAME_BIRTHDAY;
    v_date VARCHAR2(20 CHAR);
  BEGIN
    v_date := SYSDATE;
    OPEN c_cursor;
    FETCH c_cursor INTO v_name;
    SYS.DBMS_OUTPUT.PUT_LINE(v_name);
    UPDATE EMPLOYEE_NAME_BIRTHDAY SET BIRTHDAY = v_date WHERE NAME = v_name;
    CLOSE c_cursor;
END;

---Use string replacement internal function

DECLARE
    v_name EMPLOYEE_NAME_BIRTHDAY.NAME%TYPE;
    CURSOR c_cursor IS SELECT NAME FROM EMPLOYEE_NAME_BIRTHDAY;
    v_name_no_dash VARCHAR2(20 CHAR);
  BEGIN
    OPEN c_cursor;
    LOOP
    FETCH c_cursor INTO v_name;
    EXIT WHEN c_cursor%NOTFOUND; 
    v_name_no_dash := REPLACE(v_name, '-');
    SYS.DBMS_OUTPUT.PUT_LINE(v_name);
    UPDATE EMPLOYEE_NAME_BIRTHDAY SET BIRTHDAY = v_name_no_dash WHERE NAME = v_name;
    SYS.DBMS_OUTPUT.PUT_LINE(v_name_no_dash);
    END LOOP;
    CLOSE c_cursor;
END;


--Remove dash  This method is tooooooo slow..... 
DECLARE
    v_material_catalog_dash INV_SAP_MATERIAL_CATALOG.CATALOG_STRING1%TYPE;
    CURSOR c_cursor IS SELECT CATALOG_STRING1 FROM INV_SAP_MATERIAL_CATALOG;
    v_name_no_dash VARCHAR2(50 CHAR);
  BEGIN
    
    OPEN c_cursor;
    LOOP
    FETCH c_cursor INTO v_material_catalog_dash;
    --EXIT WHEN c_cursor%NOTFOUND; 
    v_name_no_dash := REPLACE(v_material_catalog_dash, '-');
    UPDATE INV_SAP_MATERIAL_CATALOG SET CATALOG_STRING2 = v_name_no_dash WHERE CATALOG_STRING2 = v_material_catalog_dash;
    END LOOP;
    CLOSE c_cursor;
END;

--Count table row number
select count(*) from INV_SAP_MATERIAL_CATALOG;

select a.ROWID from INV_SAP_MATERIAL_CATALOG a;

--Use rowid to update, Great! 37seconds!!! It use rowid..

CREATE TABLE CATALOG_TMP AS SELECT * FROM INV_SAP_MATERIAL_CATALOG;

DECLARE
  CURSOR cur
  IS
    SELECT a.CATALOG_STRING1,
      b.ROWID ROW_ID
    FROM INV_SAP_MATERIAL_CATALOG a,
      CATALOG_TMP b
    WHERE a.MATERIALID = b.MATERIALID
    ORDER BY b.ROWID; ---order by rowid
  V_COUNTER NUMBER;
BEGIN
  V_COUNTER := 0;
  FOR row IN cur
  LOOP
    UPDATE CATALOG_TMP SET CATALOG_STRING2 = REPLACE(row.CATALOG_STRING1, '-') WHERE ROWID = row.ROW_ID;
    V_COUNTER     := V_COUNTER + 1;
    IF (V_COUNTER >= 1000) THEN
      COMMIT;
      V_COUNTER := 0;
    END IF;
  END LOOP;
  COMMIT;
END;


---Add Current Serial
ALTER TABLE CATALOG_TMP 
ADD (CURRENT_SERIES VARCHAR2(20) );

DECLARE
  CURSOR cur
  IS
    SELECT a.CURRENT_SERIES,
      b.ROWID ROW_ID
    FROM INV_SAP_PP_MVKE a,
      CATALOG_TMP b
    WHERE a.MATERIALID = b.MATERIALID
    ORDER BY b.ROWID; ---order by rowid
  V_COUNTER NUMBER;
BEGIN
  V_COUNTER := 0; --- Use to cumulate results and commit to data base.
  FOR row IN cur
  LOOP
    UPDATE CATALOG_TMP SET CURRENT_SERIES = row.CURRENT_SERIES WHERE ROWID = row.ROW_ID;
    ---1000 commit!
    V_COUNTER     := V_COUNTER + 1;
    IF (V_COUNTER >= 1000) THEN
      COMMIT;
      V_COUNTER := 0;
    END IF;
    
  END LOOP;
  COMMIT;
END;

select * from INV_SAP_PP_MVKE where MATERIALID = '42EF-C2KBA-F4 A';

--maybe, it will quicker than the pl sql 
SELECT b.CATALOG_STRING1,
  b.CATALOG_STRING2,
  b.MATERIALID,
  a.DIRECT_SHIP_PLANT,
  a.CURRENT_SERIES,
  b.ROWID ROW_ID
FROM INV_SAP_PP_MVKE a,
  CATALOG_TMP b
WHERE a.MATERIALID = b.MATERIALID;

--Join with vendor info
SELECT a.MATERIALID,a.PLANTID,a.STRATEGY_GRP,b.CURRENT_SERIES
FROM INV_SAP_VENDOR_PLANT_INFO a,
  VIEW_CTMP_MVK b
WHERE a.MATERIALID = b.MATERIALID AND a.PLANTID = b.DIRECT_SHIP_PLANT;

SELECT * FROM INV_SAP_VENDOR_PLANT_INFO where MATERIALID = 'PN-82272';

select * from VIEW_VENDOR where MATERIALID = 'PN-82272';