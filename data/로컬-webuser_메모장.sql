CREATE SEQUENCE visit_seq  -- 시퀀스이름
   START WITH 1             -- 시작을 1로 설정
   INCREMENT BY 1          -- 증가 값을 1씩 증가
   NOMAXVALUE             -- 최대 값이 무한대
   NOCACHE
   NOCYCLE;

drop table "VISIT";
CREATE table VISIT (
    NO         NUMBER(5,0) NOT NULL,
    WRITER    VARCHAR2(20) NOT NULL,
    MEMO     VARCHAR2(4000) NOT NULL,
    REGDATE   DATE NOT NULL
);
ALTER table VISIT add constraint VISIT_NO_PK primary key(NO);