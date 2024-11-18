--사용자가 정의한 테이블 스페이스 만들기
create TABLESPACE firstdata
datafile 'C:\oraclexe\oradata\XE\first01.dbf' size 1M;
--용량이 부족시 테이블 스페이스 확장하기(테이블 추가)
alter TABLESPACE firstdate
add datafile 'C:\oraclexe\oradata\XE\first01.dbf' size 1M;
--용량이 부족시 테이블 스페이스 확장하기(용량 변경)
alter database 
datafile 'C:\oraclexe\oradata\XE\first01.dbf' resize 1M;
--용량이 부족시 자동으로 1m확장하고 최대 20m 확장하도록 설정
alter database 
datafile 'C:\oraclexe\oradata\XE\first01.dbf'
AUTOEXTEND on 
next 1m
MAXSIZE 10m;

--자바프로젝트를 위한 사용자 계정 및 테이블스페이스(javadata), 파일명(app_data.dbf) 생성하기
create TABLESPACE javadata
datafile 'C:\oraclexe\oradata\XE\app_data.dbf' size 20M
AUTOEXTEND on 
next 3M
MAXSIZE 500M;

--자바 프로젝트 사용자 계정 생성하기
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER javauser CASCADE; -- 기존 사용자 삭제
CREATE USER javauser IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
GRANT connect, resource, dba TO javauser; -- 권한 부여

--접속기능 진행


