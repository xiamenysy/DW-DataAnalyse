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
    DBMS_OUTPUT.PUT_LINE( SUBSTR(names_adjusted,prev_location+1, comma_location-prev_location-1));
    prev_location := comma_location;
  END LOOP;
END;

--String replacement
DECLARE
  names VARCHAR2(60) := 'Anna,Matt,Joe,Nathan,Andrew,Aaron,Jeff';
BEGIN
  DBMS_OUTPUT.PUT_LINE( REPLACE(names, ',', chr(10)) );
END;