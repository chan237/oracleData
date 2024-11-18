-- susan 부서 아이디 보기
select department_id from employees where first_name = 'Susan';

--부서 테이블에서 40번 부서명을 조회
select department_name from departments where department_id = 40;

-- susam 소속되어 있는 부서명을 검색하시오.
SELECT * FROM employees where first_name = 'Susan';
SELECT * FROM departments where department_id = 40;

SELECT first_name, department_name FROM departments d inner join employees e on D.department_id = e.department_id
where first_name = 'Susan';

select department_id from employees where first_name = 'Susan';--행 하나는 단일행

SELECT * FROM EMPLOYEES 
WHERE MANAGER_ID = (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE MANAGER_ID is null);

SELECT * FROM EMPLOYEES where salary in (17000,6500) and first_name <>'Susan' and first_name <> 'Lex';
SELECT * FROM EMPLOYEES where salary in (17000,6500) and first_name not in('Lex','Susan');

--한명 이상으로부터 보고를 받을 수 있는 직원의 직원번호, 이름, 업무, 부서번호를 출력
select distinct manager_id as "상사" from employees;
SELECT * FROM EMPLOYEES where manager_id in (select distinct manager_id from employees);
-- EMPLOYEES 테이블에서 Accounting 부서에서 근무하는 직원과 같은 업무를 하는 직원의 이름, 업무명를 출력하는 SELECT문을 작성하시오.
SELECT first_name, job_id, department_id FROM EMPLOYEES where department_id in (select distinct department_id from employees where job_id = upper('AC_Account'));
SELECT first_name, job_id, department_id FROM EMPLOYEES where department_id = (select distinct department_id from departments where department_name = 'Accounting');


--ANY 연산자(연산자 > ANY 는 찾아진  값에 대해서  하나라도  크면 참이 되는  셈이 된다.)
SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE SALARY
> ANY ( SELECT SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID=110);

--EXISTS 연산자 
SELECT * FROM DEPARTMENTS WHERE
EXISTS ( SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 10); 

DROP TABLE EMP01; 
DROP TABLE EMP03; 

--서브 쿼리로 테이블 복사하기 
CREATE TABLE EMP01 AS SELECT * FROM EMPLOYEES; 
--테이블의 구조만 복사하기
CREATE TABLE EMP03 AS SELECT * FROM EMPLOYEES WHERE 1=0;
SELECT * FROM EMP03; 
DESC EMP03;
--테이블에 내용추가
INSERT INTO EMP03 SELECT * FROM EMPLOYEES;

--위의 내용 반복
DROP TABLE DEPT01; 
CREATE TABLE DEPT01 AS SELECT * FROM DEPARTMENTS WHERE 1=0;
SELECT * FROM DEPT01;
INSERT INTO DEPT01 (SELECT * FROM DEPARTMENTS);
SELECT * FROM DEPT01;
--10번 부서의 지역번호을 40번 부서의 지역번호으로 변경하기
UPDATE DEPT01 SET LOCATION_ID = 
(SELECT LOCATION_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID=40) 
WHERE DEPARTMENT_ID=10; 
SELECT * FROM DEPT01;

UPDATE DEPT01 SET DEPARTMENT_NAME = 
( SELECT DEPARTMENT_NAME FROM DEPT01 WHERE DEPARTMENT_ID = 30), 
LOCATION_ID = ( SELECT LOCATION_ID FROM DEPT01 WHERE DEPARTMENT_ID = 30) 
WHERE DEPARTMENT_ID = 20; 
SELECT * FROM DEPT01;


DROP TABLE EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMPLOYEES;
DELETE FROM EMP01 
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID 
FROM DEPARTMENTS 
WHERE DEPARTMENT_NAME='Sales'); 


--문제 3 직급이 'ST_MAN'인 직원이 받는 급여들의 최소 급여보다 많이 받는 직원들의 이름과 급여를 출력하되 부서번호가 20번인 직원은 제외한다.
SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE SALARY > ANY 
( SELECT SALARY FROM EMPLOYEES WHERE JOB_ID='ST_MAN') and department_id <> 20; 

select salary from employees where job_id = 'ST_MAN';

--문제 4  EMPLOYEES 테이블에서 Valli라는 이름을 가진 직원과 업무명 및 월급이 같은 사원의 모든 정보 를 출력하는 SELECT문을 작성하시오. (결과에서 Valli는 제외) 
SELECT * FROM EMPLOYEES WHERE EXISTS 
(SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Valli') 
and salary = (SELECT salary FROM EMPLOYEES WHERE FIRST_NAME = 'Valli'));

SELECT * FROM EMPLOYEES WHERE (job_id, salary) = (SELECT job_id, salary FROM EMPLOYEES WHERE FIRST_NAME = 'Valli')
AND FIRST_NAME != 'Valli';

select * from employees where 
job_id=(select job_id from employees where first_name='Valli') 
and salary=(select salary from employees where first_name='Valli') 
and not first_name in('Valli');


--문제 5 EMPLOYEES 테이블에서 월급이 자신이(‘Valli’) 속한 부서의 평균 월급보다 높은 사원의 부서번호, 이름, 급여를 출력하는 SELECT문을 작성하시오.
SELECT DEPARTMENT_ID, FIRST_NAME, SALARY FROM EMPLOYEES WHERE SALARY > ANY
( SELECT SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Valli'));
--평균 월급
SELECT round(avg(salary)) FROM employees where department_id = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Valli');
--해답
SELECT DEPARTMENT_ID, FIRST_NAME, SALARY FROM EMPLOYEES WHERE SALARY > ANY
(SELECT round(avg(salary)) FROM employees where department_id = 
    (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Valli'));

select department_id, first_name, salary from employees 
where salary > (select avg(salary) from employees where department_id=(select department_id from employees where first_name='Valli') group by department_id);






--문제1
--Tucker 사원보다 급여를 많이 받고 있는 사원의 이름과 업무, 급여를 출력하시오.
--해답
select first_name, last_name, job_id, salary from employees where salary > 
any(select salary from employees where last_name = 'Tucker');


--문제2
--사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 이름과 업무, 급여, 입사일을 출력하시오.
--해답
select first_name, last_name, job_id, salary, hire_date from employees
where (job_id, salary) IN 
    (SELECT job_id, MIN(salary) FROM EMPLOYEES GROUP BY job_id);
    
--풀이  
--업무가 같은사람들끼리 묶기
SELECT job_id FROM employees GROUP BY job_id;
--최소 급여 찾기
SELECT MIN(salary) FROM employees;


--문제3
--소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 사원의 이름, 급여, 부서번호, 업무 출력
--해답
select first_name, last_name, salary, department_id, job_id from employees 
where salary > any
    (SELECT avg(salary) FROM employees GROUP BY department_id);
    
--풀이
--소속 부서끼리 묶기
SELECT * FROM employees GROUP BY department_id;
--평균 급여 찾기
SELECT avg(salary) FROM employees;
--부서가 같은데 평균급여?
SELECT avg(salary) FROM employees GROUP BY department_id;


--문제4
--모든 사원의 소속부서 평균급여를 계산하여 사원별로 이름, 업무, 급여, 부서번호, 부서 평균급여를 출력

--사원별로 이름, 업무, 급여, 부서번호, 부서 평균급여를 출력
select first_name, last_name, job_id, salary, department_id, Department_Avg_Salary from employees;
--부서별 평균급여
SELECT avg(salary) as Department_Avg_Salary FROM employees GROUP BY department_id;
--조인해줘야 함
SELECT e.first_name,
       e.last_name,
       e.job_id,
       e.salary,
       e.department_id,
       round(Department_Avg_Salary)
FROM EMPLOYEES e
    JOIN (
        SELECT department_id, AVG(salary) AS Department_Avg_Salary
        FROM EMPLOYEES
        GROUP BY department_id
    ) G_depat_avg ON e.department_id = G_depat_avg.department_id;


--더 좋은 방법  
select first_name, last_name, job_id, salary, department_id,
(select avg(salary) from employees where department_id = E.department_id) 
from employees E;