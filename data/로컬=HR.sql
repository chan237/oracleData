--table 설계하기(사원번호, 사원명, 급여)
--class EMP01{
--    private int no;
--    private String name; //게터스/세터스->update toString -> select
--    private int salary;   //drap 다 없애버림
--}DDL에서 다함 new~ -> DML에서 다함

//CONSTRAINT EMP01_PK priPRIMARY KEY(no, name) 
//제약조건 쓰기 -두가지 이상이나 밖에서 조건 넣을때 씀
//CONSTRAINT EMP01_salary_uk UNIQUE(salary)
create table EMP01(
    no NUMBER(4) PRIMARY KEY,
    name VARCHAR2(20) not null,
    salary NUMBER(10,2) DEFAULT 1000.0
);
