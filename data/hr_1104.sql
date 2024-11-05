--hr resource 있는 테이블정보(프로젝트 클래스 종류)
SELECT * from tab;
--employees 테이블 구조
desc employees; 
--employees 속에 들어있는 레코드(객체들)를 보여주세요.
select * from employees;
--departments 테이블 객체(레코ㄷ=인스턴스)를 확인
SELECT * FROM departments;
--departments 구조
desc departments;
--department_id, department_name 보임
SELECT department_id, department_name from departments;
--필드명에 별칭 사용하기
select department_id as "부서번호", department_name as "부서명" from departments;
select department_id as DEPT_NO, department_name as DEPT_NAME from departments;
select department_id as "DEPT_NO", department_name as "DEPT_NAME" from departments;
-- + ||
SELECT '5' + 5 from dual;
desc dual;
SELECT * FROM dual;
SELECT '5' || 5 from dual;

--문자열 기능을 이용해서 필드명을 보여주기
SELECT first_name, job_id from employees;
SELECT first_name || '의 직급은' || job_id ||'입니다' from employees;
SELECT first_name || '의 직급은' || job_id ||'입니다' as data from employees;

--중복되지 않게 보여주기
select DISTINCT job_id from employees;







--문제 1번
SELECT FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE from employees;
--문제 2번
SELECT DISTINCT DEPARTMENT_ID from employees;

--<예>급여를 3000 미만 받는 직원을 대상
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY 
FROM EMPLOYEES 
WHERE SALARY < 3000; 

--<예> 이름(FIRST_NAME)이 'Lex'인 직원 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY 
FROM EMPLOYEES 
WHERE FIRST_NAME='Lex';


--날짜 데이터 조회 <예> 2008년 이후에 입사한 직원 
SELECT FIRST_NAME, HIRE_DATE 
FROM EMPLOYEES 
WHERE HIRE_DATE >= '2008/01/01';

desc employees;
--2008년 이후에 입사한 직원조사
SELECT * FROM employees where hire_date >= '2008/01/01';
SELECT * FROM employees where to_char(hire_date, 'YYYY/MM/DD') >= '2008/01/01';
SELECT * FROM employees where hire_date >= to_date('2008/01/01', 'YYYY/MM/DD HH24:MI:SS');

-- AND, BETWEEN A AND B
SELECT * FROM employees WHERE salary >= 2000 and salary <=3000;
SELECT * FROM employees WHERE salary BETWEEN 2000 and 3000;

-- OR, IN(,)
SELECT * FROM employees WHERE employee_id = 177 or employee_id = 101 or employee_id = 184;
SELECT * FROM employees WHERE employee_id in(177,101,184);

--null 연산, 비교, 할당 안된다.
SELECT 100+null from dual;
desc employees;
SELECT * FROM employees WHERE commission_pct = null;
SELECT * FROM employees;
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is not null;

--정렬을 위한 ORDER BY 절(오름차순 asc, 내림차순 desc)
select employee_id, first_name from employees order by EMPLOYEE_ID ASC;

--group by
SELECT * FROM employees;
SELECT * FROM employees where department_ID >= 70;
SELECT department_ID, salary from employees where department_ID >= 70;
SELECT department_ID, salary from employees where department_ID >= 70 group by department_ID;
SELECT department_ID, max(salary), min(salary), sum(salary), round(avg(salary),1), count(salary) from employees 
    where department_ID >= 70 group by department_ID having sum(salary) >= 30000;

--전체를 기준으로 group by는 생략된다
SELECT sum(salary) from employees;

--기준점 두개도 가능
SELECT department_ID, salary from employees where department_ID >= 70 group by department_ID, salary;
SELECT department_ID, salary, max(salary), min(salary), sum(salary), round(avg(salary),1), count(salary) from employees where department_ID >= 70 group by department_ID, salary;

--substr
select substr('DataBase', 1,3) from dual;

