--현재 시간표현
SELECT sysdate from dual;
select to_char(sysdate,'yyy/mm/dd hh24:mi:ss') from dual;
select FLOOR(sysdate - TO_DATE('2024/11/05', 'yyyy/mm/dd')) from dual;

--숫자를 우리가 원하는 형식으로 출력하기 1234567023->$1,234,567.23
select trim(to_char(1234567.23, 'L999,999,999,999.99')) as money from dual;
select first_name, trim(to_char(salary, 'L999,999,999,999.99')) as salary from employees;

--문자+문자=숫자
select to_number('10,000', '999,999')+to_number('20,000', '999,999') from dual;

--NVL
select first_name, salary, commission_pct, job_id from employees order by job_id;
select first_name, salary, NVL(commission_pct,0), job_id from employees order by job_id;

--NULL에 값 더하기
select first_name, salary*NVL(commission_pct,0) as commission, salary+salary*NVL(commission_pct,0) as total, job_id from employees order by job_id;

--NVL2
select first_name, salary, commission_pct, salary+salary*NVL(commission_pct,0) as total from employees order by job_id;
select first_name, salary, commission_pct, NVL2(commission_pct,salary+salary*commission_pct,salary) as total from employees;

--문제
SELECT * FROM employees;
select nvl2(manager_id,manager_id,nvl(manager_id, 0)) from employees where manager_id is null;
select nvl2(manager_id,'','ceo') from employees where manager_id is null;

--문제2
select employee_id, salary, department_id,
    case    when department_id=10 then 'Administration'
            when department_id=20 then 'Marketing'
            when department_id=30 then 'Purchasing'
            when department_id=40 then 'Human Resources'
            when department_id=50 then 'Shipping'
            when department_id=60 then 'IT'
            end department_name
from employees;

select department_name from employees;

select employee_id, first_name, salary, job_id, case
        when DEPARTMENT_id=20 then salary*1.05
        when DEPARTMENT_id=30 then salary*1.10
        when DEPARTMENT_id=40 then salary*1.15
        when DEPARTMENT_id=60 then salary*1.20
end NEWSALARY
from employees WHERE DEPARTMENT_id IN(20,30,40,60);

select employee_id, salary, salary*1.05 from employees order by salary;


select count(*) from employees;
create table emple02 as SELECT * FROM employees;
desc emple02;
select count(*) from emple02;

--제약조건 걸기
alter table emple02 add constraint emple02_id_pk PRIMARY KEY(employee_id);
alter table emple02 add constraint emple02_EMAIL_uk UNIQUE(EMAIL);

--제약조건 삭제
alter table emple02 drop constraint emple02_EMAIL_uk;

--제약조건 정보 검색
SELECT * FROM user_constraints where table_name = upper('emple02');

--컬럼주기
alter table emp01 add job varchar2(10) not null;
desc emp01;

--컬럼제거
alter table emp01 drop column job;

--컬럼변경(기존값이 존재할때, 타입변경불가)
alter table emp01 modify job number(10) DEFAULT 0;

--컬럼이름변경
alter table emp01 rename column job to job2;
alter table emp01 rename column job2 to job;





create table TB_CUSTOMER(
    CUSTOMER_CODE CHAR(7), CUSTOMER_NM VARCHAR2(20), GENDER CHAR(1),
    BIRTH_DAY CHAR(8), PHONE_NUMBER VARCHAR2(16), EMAIL VARCHAR2(30),
    TOTAL_POINT NUMBER(10) DEFAULT 0
);
ALTER TABLE TB_CUSTOMER ADD CONSTRAINT TB_CUSTOMER_CUSTOMER_CODE_PK PRIMARY KEY(CUSTOMER_CODE);
ALTER TABLE TB_CUSTOMER ADD CONSTRAINT TB_CUSTOMER_CUSTOMER_NM_UK UNIQUE(CUSTOMER_NM);
ALTER TABLE TB_CUSTOMER ADD CONSTRAINT TB_CUSTOMER_GENDER_CK CHECK(GENDER IN('M','W'));
SELECT * FROM user_constraints where table_name = 'TB_CUSTOMER';
DROP TABLE TB_CUSTOMER;

CREATE TABLE IT(
    NO1 NUMBER,
    NO2 NUMBER,
    NO3 NUMBER
);
DESC IT;
INSERT INTO IT VALUES(1,2,3);
INSERT INTO IT VALUES(1,2,NULL);
INSERT INTO IT(NO1,NO2) VALUES(11,22);
INSERT INTO IT(NO1,NO2) VALUES(11,'문자');
INSERT INTO IT(NO1,NO2) VALUES(111);
INSERT INTO IT(NO1,NO2) VALUES(111,222,333);
SELECT * FROM IT;
ALTER TABLE IT MODIFY NO3 NUMBER NOT NULL;
DELETE FROM IT WHERE NO3 IS NULL;
SELECT * FROM user_constraints where table_name = 'IT';

CREATE TABLE DEPT AS SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID FROM departments;
SELECT * FROM DEPT;
DELETE FROM DEPT;
TRUNCATE TABLE DEPT;
ROLLBACK;
DROP TABLE DEPT;



--학생 성적 테이블 만들기

--학과테이블
CREATE TABLE SUBJECT(
    CODE NUMBER,
    SUBNAME VARCHAR2(10) NOT NULL
);
--학과 PK,값 입력
ALTER TABLE SUBJECT ADD CONSTRAINT SUBJECT_CODE_PK PRIMARY KEY(CODE);
INSERT INTO SUBJECT VALUES(1004,'경제학');
SELECT * FROM SUBJECT;

--학생테이블
CREATE TABLE STUDENT(
    STUNUM NUMBER,
    STUNAME VARCHAR2(20) NOT NULL,
    KOR NUMBER DEFAULT 0,
    ENG NUMBER DEFAULT 0,
    MATH NUMBER DEFAULT 0,
    CODE NUMBER
);
--학생 무결성 제약조건
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_STUNUM_PK PRIMARY KEY(STUNUM);
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_CODE_FK FOREIGN KEY(CODE) 
REFERENCES SUBJECT(CODE);
ALTER TABLE STUDENT MODIFY KOR NUMBER NOT NULL;
ALTER TABLE STUDENT MODIFY ENG NUMBER NOT NULL;
ALTER TABLE STUDENT MODIFY MATH NUMBER NOT NULL;
--학생 컬럼 추가(합계,평균)
ALTER TABLE STUDENT ADD TOTAL AS (KOR+ENG+MATH);
ALTER TABLE STUDENT ADD AVR AS ((KOR+ENG+MATH)/3);
--제약조건 확인
SELECT * FROM user_constraints where table_name = 'STUDENT';
--샘플데이터 입력
INSERT INTO STUDENT(STUNUM,STUNAME,KOR,ENG,MATH,CODE) VALUES(7,'김삿갓',100,100,100,1004);
--출력
SELECT * FROM STUDENT;
--테이블 삭제
DROP TABLE STUDENT;
DROP TABLE SUBJECT;