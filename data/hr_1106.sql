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
