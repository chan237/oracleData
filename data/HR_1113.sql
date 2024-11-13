--view 생성(테이블 생성해서 복사하기와 같음)
create VIEW view_emp01 as select employees_id, first_name, salary, department_id
from employees;

--select
select * from view_emp01;
select * from emp_copy where employee_id = 200;
--view 수정하기
update view_emp01 set salary = 4500 where employee_id = 200;

--data dictionary(user_tabs, user_constraints, user_cons_columns,user_views,user_indexs)
SELECT * FROM user_tables;
SELECT * FROM user_constraints;
SELECT * FROM user_cons_columns;
SELECT * FROM user_views;
SELECT * FROM user_indexs;

--가상뷰에 입력하기 (가상 테이블에 컬럼 4개 입력, 원본 10개인데 그중에 not null 인데 가상테이블에 포함되지 않으면)
INSERT INTO view_emp01 VALUES(1000,'jdk',20000);




-- Transaction
DROP TABLE DEP02;

-- 테이블복사 (구조만복사)
CREATE TABLE DEP02
AS
SELECT * FROM DEPARTMENTS WHERE 1=0;

-- 내용복사
INSERT INTO DEP02  SELECT * FROM DEPARTMENTS;

SELECT * FROM DEP02;

SAVEPOINT C1; 

DELETE FROM DEP02 WHERE DEPARTMENT_ID = 90;

SELECT * FROM DEP02;

ROLLBACK TO C1; 



-- EMPLOYEES 복사해서 EMP_COPY
CREATE TABLE EMP_COPY
AS
SELECT * FROM EMPLOYEES;

SELECT * FROM EMP_COPY;

-- VIEW 제거하기
DROP VIEW VIEW_EMP01;

-- VIEW 생성하기 (테이블생성 복사하기 똑같음)
CREATE VIEW VIEW_EMP01 
AS
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID FROM EMP_COPY WHERE DEPARTMENT_ID = 10;

-- SELECT
SELECT * FROM VIEW_EMP01;
SELECT * FROM EMP_COPY WHERE EMPLOYEE_ID = 200;
-- VIEW 수정하기
UPDATE VIEW_EMP01 SET SALARY = 4500 WHERE EMPLOYEE_ID = 200; 

-- DATA DICTIONARY(USER_TABLES, USER_CONSTRAINTS, USER_CONS_COLUMNS, USER_VIEWS, USER_INDEXES)
SELECT * FROM USER_TABLES;
SELECT * FROM user_constraints;
SELECT * FROM user_cons_columns WHERE TABLE_NAME='EMPLOYEES';
SELECT * FROM user_views;
SELECT * FROM user_indexes;

-- 가상뷰에 입력하기 (가상테이블에 컬럼 4개 입력, 원본 10개인데 그중에 NOT NULL 인테 가상테이블에 포함되어 있지 않으면)
INSERT INTO VIEW_EMP01 VALUES(1000,'JDK',2000,50); 
SELECT * FROM VIEW_EMP01;

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP_COPY';

-- VIEW 생성하기 (테이블생성 복사하기 똑같음)
CREATE VIEW VIEW_EMP02 
AS
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID FROM EMP_COPY WHERE DEPARTMENT_ID = 10;
INSERT INTO VIEW_EMP02 VALUES(1000,'JDK','KIM','RLAEOGUS@NATE.COM',TO_DATE('24/11/13'));

DELETE FROM VIEW_EMP02 WHERE EMPLOYEE_ID = 2000;

