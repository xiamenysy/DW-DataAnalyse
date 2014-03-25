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


create or replace procedure insert_name_date(name_in IN VARCHAR2)
IS
  date_in VARCHAR2(20 CHAR);
BEGIN
  date_in := SYSDATE;
  INSERT INTO EMPLOYEE_NAME_BIRTHDAY
  (NAME, BIRTHDAY)
  VALUES (name_in, date_in);
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
    END LOOP;
    CLOSE c_cursor;
END;

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