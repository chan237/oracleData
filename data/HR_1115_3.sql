--부서별로 SALARY 인상. 부서코드가 10이면 10% 인상, 20이면 20% 인상, 나머지는 동결하는 쿼리
--문을 작성하여 보자. 그 전에 변경 전 데이터를 확인한다

DROP TABLE EMP01; 
CREATE TABLE EMP01 
AS 
SELECT * FROM employees WHERE 1 =1;
SELECT * FROM EMP01;
DESC EMPLOYEES;

CREATE OR REPLACE PROCEDURE EMP01_PROC(VDEPTNO IN EMP01.DEPARTMENT_ID%TYPE) 
IS 
BEGIN
    IF VDEPTNO = 10 THEN
        UPDATE EMP01 SET SALARY = SALARY *1.1 WHERE DEPARTMENT_ID = VDEPTNO;
        DBMS_OUTPUT.PUT_LINE(VDEPTNO||'부서는 전원 10% 인상했습니다');
    ELSIF VDEPTNO = 20 THEN
        UPDATE EMP01 SET SALARY = SALARY *1.2 WHERE DEPARTMENT_ID = VDEPTNO;
        DBMS_OUTPUT.PUT_LINE(VDEPTNO||'부서는 전원 20% 인상했습니다');
    ELSE
        DBMS_OUTPUT.PUT_LINE(VDEPTNO||'부서는 전원 급여 동결입니다.');
    END IF;
END;
/

SELECT * FROM EMP01 WHERE DEPARTMENT_ID = 10;

EXECUTE EMP01_PROC(10);