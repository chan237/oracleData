SELECT * FROM STUDENT1;
DROP TABLE STUDENT1;
CREATE TABLE STUDENT1(
    NO NUMBER(4),
    NAME VARCHAR2(20) NOT NULL,
    KOR NUMBER(4) NOT NULL,
    ENG NUMBER(4)NOT NULL,
    MAT NUMBER(4)NOT NULL,
    TOTAL NUMBER(4),
    AVE NUMBER(5,1),
    RANK NUMBER(4)
);

ALTER TABLE STUDENT1 ADD CONSTRAINT STUDENT1_NO_PK PRIMARY KEY(NO);

DROP SEQUENCE STUDENT1_STUNUM_SEQ;
CREATE SEQUENCE STUDENT1_NO_SEQ
START WITH 1
INCREMENT BY 1;

INSERT INTO STUDENT1 (NO,NAME,KOR,ENG,MAT) VALUES(STUDENT1_NO_SEQ.NEXTVAL, '홍길동', '90', '70', '70');
INSERT INTO STUDENT1 (NO,NAME,KOR,ENG,MAT) VALUES(STUDENT1_NO_SEQ.NEXTVAL, '김길동', '80', '25', '66');
INSERT INTO STUDENT1 (NO,NAME,KOR,ENG,MAT) VALUES(STUDENT1_NO_SEQ.NEXTVAL, '이길동', '100', '75', '89');
COMMIT;


SELECT * FROM STUDENT1;

-- 성적을 입력하면 총점과 평균이 자동 계산되어 입력되는 트리거
CREATE OR REPLACE TRIGGER STUDENT1_TRIGGER
BEFORE INSERT ON STUDENT1
FOR EACH ROW
BEGIN
    :NEW.TOTAL := :NEW.KOR + :NEW.ENG + :NEW.MAT;
    :NEW.AVE := ROUND(:NEW.TOTAL / 3, 1);
END;
/

-- 성적을 수정하면 총점과 평균이 같이 변하는 트리거
CREATE OR REPLACE TRIGGER STUDENT1_TRIGGER2
BEFORE UPDATE ON STUDENT1
FOR EACH ROW
BEGIN
    :NEW.TOTAL := :NEW.KOR + :NEW.ENG + :NEW.MAT;
    :NEW.AVE := ROUND(:NEW.TOTAL / 3, 1);
END;
/

-- 등수를 처리하는 저장 프로시저 생성
CREATE OR REPLACE PROCEDURE STUDENT1_RANK_PROC
IS 
    VSTUDENT_RT STUDENT1%ROWTYPE; 
    CURSOR C1 IS
    SELECT NO, RANK() OVER(ORDER BY TOTAL DESC) RANK FROM STUDENT1 ORDER BY TOTAL DESC; 
BEGIN
    FOR  VSTUDENT_RT IN C1 LOOP
        UPDATE STUDENT1 SET RANK = VSTUDENT_RT.RANK WHERE NO =  VSTUDENT_RT.NO; 
    END LOOP;
    COMMIT;
END;
/

EXECUTE STUDENT1_RANK_PROC;





--사용자 계정을 만들기 위해 일반 사용자 계정인 TEST계정으로 접속하여 계정이 SAMPLE 비밀번호가 1234인

--계정을 생성하기 위해 CREATE USER SAMPLE; 를 실행하니 정상적으로 실행이 되지 않았다.


--ALTER SESSION SET "_ORACLE_SCRIPT"=true;
--DROP USER STUDENT_DB CASCADE; -- 기존 사용자 삭제
--CREATE USER STUDENTDB IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
--    DEFAULT TABLESPACE USERS
--    TEMPORARY TABLESPACE TEMP;
--GRANT connect, resource, dba TO STUDENTDB; -- 권한 부여

SELECT First_NAME, employee_id, SALARY, email

FROM EMPLOYEEs

WHERE SALARY >= 3000 and EMAIL LIKE '__I%';

--아래의 SQL구문은 부서 별 평균 월급이 2800000을 초과하는 부서를 조회한 것이다.
SELECT department_id, 
       FLOOR(AVG(salary)) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 2800
ORDER BY avg_salary DESC;

SELECT DEPT, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMP

WHERE SALARY > 2800000

GROUP BY DEPT

ORDER BY DEPT ASC;

select * from employees;
SELECT DEPARTMENT_ID, FLOOR(AVG(SALARY)) 평균
FROM employees;

SELECT ROWNUM, SALARY

FROM (SELECT ROWNUM, SALARY FROM EMPLOYEES ORDER BY SALARY)

WHERE ROWNUM >= 3;

SELECT *
FROM (
    SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
    FROM EMPLOYEES
    ORDER BY SALARY DESC
) 
WHERE ROWNUM <= 3;








