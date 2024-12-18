--STORED PROCEDURE
--EMPLOYEES에서 사용자 이름을 패턴으로 겁색한 뒤 해당되는 사용자정보(사원번호, 이름, 급여)를 보여주시오.
SELECT * FROM EMPLOYEES WHERE UPPER(FIRST_NAME) LIKE '%K%';
CREATE OR REPLACE PROCEDURE EMP_PROC
IS
    VWORD VARCHAR2(1);
    VEMP_ROWTYPE EMPLOYEES%ROWTYPE;
    CURSOR CNAME(VNAME VARCHAR2)
    IS SELECT * FROM EMPLOYEES WHERE UPPER(FIRST_NAME) LIKE UPPER('%'||VNAME||'%');
BEGIN
    --임의의 문자를 생성시킨다.
    VWORD := DBMS_RANDOM.STRING('U',1);
    FOR VEMP_ROWTYPE IN CNAME(VWORD) LOOP
        DBMS_OUTPUT.PUT_LINE(VEMP_ROWTYPE.FIRST_NAME || ' / ' || VEMP_ROWTYPE.SALARY);
    END LOOP;
END;
/

EXECUTE EMP_PROC;
SELECT * FROM USER_SOURCE;
SELECT * FROM USER_TABLES;
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONS_COLUMNS;
SELECT * FROM user_ind_columns;
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_SEQUENCES;
SELECT * FROM USER_VIEWS;
SELECT * FROM USER_SOURCE;

SHOW ERROR;
