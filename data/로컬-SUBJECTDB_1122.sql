--table 작성

-- 학과
drop table subject;
create table subject( 
    no number,                  -- pk, seq
    num varchar2(2) not null,   -- 학과번호 01,02,03~
    name varchar2(24) not null -- 학과이름
);
alter table subject add CONSTRAINT subject_no_pk PRIMARY key(no);
alter table subject add CONSTRAINT subject_num_uk UNIQUE(num);

--학생
drop table student;
create table student( 
    no number,                      --pk, seq
    num varchar2(8) not null,       --학번(년도/학과/번호)
    name varchar2(12) not null,     --이름
    id varchar2(12) not null,       --아이디
    passwd varchar2(12) not null,   --패스워드
    s_num varchar2(2),     --학과번호(fk)
    birthday varchar2(8) not null,  --생년월일
    phone varchar2(15) not null,    --전화번호
    address varchar2(80) not null,  --주소
    email varchar2(40) not null,    --이메일
    sdate date default sysdate      --등록일
);

alter table student add CONSTRAINT student_no_pk PRIMARY key(no);
alter table student add CONSTRAINT student_id_uk UNIQUE(id);
alter table student add CONSTRAINT student_num_uk UNIQUE(num);
alter table student add CONSTRAINT student_subject_num_fk 
    FOREIGN key(s_num) REFERENCES subject(num) on delete set null;
alter table student drop constraint student_subject_num_fk; --제약조건 이름으로 제약조건 삭제하기

--과목
create table lesson( 
    no number,                      --pk, seq
    abbre varchar2(2) not null,     --과목 약어
    name varchar2(40) not null      --과목 이름
);
alter table lesson add CONSTRAINT lesson_no_pk PRIMARY key(no);
alter table lesson add CONSTRAINT lesson_abbre_uk UNIQUE(abbre);

drop table trainee;
drop table lesson;

--수강신청
create table trainee( 
    no number ,                         --pk seq
    s_num varchar2(8) not null,          --fk(student) 학생번호
    abbre varchar2(2) not null,         --fk(lesson) 과목약어
    section varchar2(20) not null,      --전공
    registdate date default sysdate         --수강신청일
);
alter table trainee add CONSTRAINT trainee_no_pk PRIMARY key(no);
alter table trainee add CONSTRAINT trainee_student_num_fk 
    FOREIGN key(s_num) REFERENCES student(num) on delete set null;
alter table trainee add CONSTRAINT student_lesson_addre_fk 
    FOREIGN key(abbre) REFERENCES lesson(abbre) on delete set null;

--시퀸스 만들기
create SEQUENCE subject_seq
start with 1
INCREMENT by 1;

create SEQUENCE student_seq
start with 1
INCREMENT by 1;

create sequence lesson_seq 
start with 1
increment by 1;

create sequence trainee_seq 
start with 1
increment by 1;

insert into subject(no, num, name) values (subject_seq.nextval, ?, ?);

select * from lesson;
delete from lesson where no = 4;
UPDATE LESSON SET ABBRE = '', NAME ='' WHERE NO=10;
insert into lesson VALUES(lesson_seq.nextval,'A','어셈블');
insert into lesson VALUES(lesson_seq.nextval,'B','비만');
commit;



SELECT SEQUENCE_NAME 
FROM ALL_SEQUENCES 
WHERE SEQUENCE_NAME = upper('lesson_seq');

GRANT SELECT ON lesson_seq TO SUBJECTDB;

UPDATE TRAINEE SET S_NUM = '', ABBRE = '', SECTION = '' WHERE no = 10;

select t.no, t.section, t.registdate, s.num, s.name, l.abbre, l.name as abbreName from 
trainee T 
inner join student S on t.s_num = s.num 
inner join lesson L on t.abbre = l.abbre 
order by T.no;

SELECT NUM, NAME, EMAIL FROM STUDENT WHERE NAME = 'kdj0';

alter table trainee drop constraint trainee_lesson_abbre_fk;
select * from subject;
select * from lesson;
select * from trainee;