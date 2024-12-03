CREATE SEQUENCE visit_seq  -- 시퀀스이름
   START WITH 1             -- 시작을 1로 설정
   INCREMENT BY 1          -- 증가 값을 1씩 증가
   NOMAXVALUE             -- 최대 값이 무한대
   NOCACHE
   NOCYCLE;

CREATE table VISIT (
    NO         NUMBER(5,0) NOT NULL,
    WRITER    VARCHAR2(20) NOT NULL,
    MEMO     VARCHAR2(4000) NOT NULL,
    REGDATE   DATE NOT NULL
);
ALTER table VISIT add constraint VISIT_NO_PK primary key(NO);
INSERT INTO VISIT VALUES(visit_seq.NEXTVAL, 'pch', '처음으로 메모장 입력',SYSDATE);
select * from visit;

CREATE SEQUENCE member_seq  -- 시퀀스이름
   START WITH 1             -- 시작을 1로 설정
   INCREMENT BY 1          -- 증가 값을 1씩 증가
   NOMAXVALUE             -- 최대 값이 무한대
   NOCACHE
   NOCYCLE;
   
CREATE table MEMBER (
    NO         NUMBER(5,0),
    ID    VARCHAR2(20) NOT NULL,
    PW    VARCHAR2(20) NOT NULL,
    NAME    VARCHAR2(20) NOT NULL,
    PHONE   VARCHAR2(20) NOT NULL,
    REGDATE   DATE NOT NULL
);
ALTER table MEMBER add constraint MEMBER_NO_PK primary key(NO);
INSERT INTO MEMBER VALUES(member_seq.NEXTVAL, 'pch', '123456','박찬희','010-1234-1234',SYSDATE);
commit;
select * from MEMBER order by no desc;
delete from MEMBER where no = 6;

