DECLARE
    VDEPARTMENTS DEPARTMENTS%ROWTYPE;
    
BEGIN
    FOR I IN 1..9 LOOP
        SELECT * INTO VDEPARTMENTS FROM DEPARTMENTS WHERE DEPARTMENT_ID = I*10;
        DBMS_OUTPUT.PUT_LINE(VDEPARTMENTS.DEPARTMENT_ID || '/'|| VDEPARTMENTS.DEPARTMENT_NAME);
    END LOOP;
END;
/

DECLARE

BEGIN
    FOR I IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE(' ========== '|| I ||' ============= ');
        FOR J IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(I ||' * '|| J ||' = '||I*J);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/

DECLARE
    VDEPT DEPARTMENTS%ROWTYPE;
    CURSOR C1
    IS SELECT * FROM DEPARTMENTS;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호/    부서명    /지역번호');
    DBMS_OUTPUT.PUT_LINE('-------------------------');
    
    OPEN C1;
        LOOP
            FETCH C1 INTO VDEPT.DEPARTMENT_ID, VDEPT.DEPARTMENT_NAME, VDEPT.MANAGER_ID, VDEPT.LOCATION_ID;
            EXIT WHEN C1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(VDEPT.DEPARTMENT_ID ||'/'|| VDEPT.DEPARTMENT_NAME);
        END LOOP;
    CLOSE C1;
END;
/
--2번째 방법
--FOR VDEP IN CI LOOP
--    DBMS_OUTPUT.PUT_LINE(VDEPT.DEPARTMENT_ID ||'/'|| VDEPT.DEPARTMENT_NAME);
--END LOOP;
--3번째 방법
--커서도 지워도 됨