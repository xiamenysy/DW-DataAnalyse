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

---Cursor Usage
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


