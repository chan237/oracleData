--영화를 시청한 사람들만 리뷰를 작성할 수 있도록 설계하려면 영화, 사용자, 시청 기록, 리뷰의 테이블 관계를 설정해야 합니다. 아래는 이를 구현할 수 있는 DDL과 각 테이블의 기능 설명입니다.
--테이블 1: Users (사용자 테이블)
--설명: 사용자 정보를 저장하는 테이블입니다.

CREATE TABLE Users (
    user_id VARCHAR2(20),
    username VARCHAR2(50) NOT NULL,
    password VARCHAR2(255) NOT NULL,
    email VARCHAR2(100)
);
ALTER TABLE USERS ADD CONSTRAINT USERS_USER_ID_PK PRIMARY KEY(USER_ID);
ALTER TABLE USERS ADD CONSTRAINT USERS_EMAIL_UK UNIQUE(EMAIL);

--Create: 사용자 등록 (회원가입).
--Read: 사용자 정보 조회.
--Update: 사용자 정보 수정 (예: 비밀번호 변경).
--Delete: 사용자 계정 삭제.

--테이블 2: Movies (영화 테이블)
--설명: 영화 정보를 저장하는 테이블입니다.

CREATE TABLE Movies (
    movie_id NUMBER,
    title VARCHAR(255) NOT NULL,
    release_date DATE NOT NULL,
    duration NUMBER, -- 상영 시간(분)
    genre VARCHAR(50)
);
ALTER TABLE MOVIES ADD CONSTRAINT MOVIES_MOVIE_ID_PK PRIMARY KEY(MOVIE_ID);

--Movies 테이블 주요 기능
--Create: 새로운 영화 추가.
--Read: 영화 목록 및 상세 정보 조회.
--Update: 영화 정보 수정 (예: 제목, 상영 시간).
--Delete: 특정 영화 삭제.

CREATE SEQUENCE MOVIE_SEQ
    START WITH 1
    INCREMENT BY 1;


--테이블 3: WatchHistory (시청 기록 테이블)
--설명: 사용자가 시청한 영화 기록을 저장하는 테이블입니다.

CREATE TABLE Watch_History (
    watch_id NUMBER,
    user_id VARCHAR2(20) NOT NULL,
    movie_id NUMBER NOT NULL,
    watch_date DATE DEFAULT SYSDATE
);
ALTER TABLE WATCH_HISTORY ADD CONSTRAINT WATCH_HISTORY_WATCH_ID_PK PRIMARY KEY(WATCH_ID);
ALTER TABLE WATCH_HISTORY ADD CONSTRAINT WATCH_HISTORY_USER_ID_FK FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE;
ALTER TABLE WATCH_HISTORY ADD CONSTRAINT WATCH_HISTORY_MOVIE_ID_FK FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID) ON DELETE CASCADE;

--WatchHistory 테이블 주요 기능
--Create: 사용자가 영화를 시청하면 기록 추가.
--Read: 사용자가 시청한 영화 목록 조회.
--Update: 시청 날짜 수정 (필요 시).
--Delete: 특정 시청 기록 삭제.
CREATE SEQUENCE WATCH_HISTORY_SEQ
    START WITH 1
    INCREMENT BY 1;

drop table Watch_History;
CREATE TABLE Watch_History (
    watch_id NUMBER,
    user_id VARCHAR2(20) NOT NULL,
    movie_id NUMBER NOT NULL,
    watch_date DATE DEFAULT SYSDATE,
    watch_count NUMBER
);
select * from Watch_History where watch_count>=1;
CREATE OR REPLACE TRIGGER trg_update_watch_count
BEFORE INSERT ON Watch_History
FOR EACH ROW
BEGIN
    SELECT watch_count
    INTO :NEW.watch_count
    FROM Watch_History
    WHERE user_id = :NEW.user_id
      AND movie_id = :NEW.movie_id;
    :NEW.watch_count := :NEW.watch_count + 1;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- 기존 기록이 없으면 기본값 1로 설정
        :NEW.watch_count := 1;
END;
/

CREATE OR REPLACE TRIGGER trg_watch_id_count
AFTER INSERT ON Watch_History
FOR EACH ROW
BEGIN
    UPDATE Watch_History
    SET watch_count = watch_count + 1
    WHERE watch_id = :NEW.watch_id;
END;
/


--테이블 4: Reviews (리뷰 테이블)
--설명: 사용자가 시청한 영화에 한해 리뷰를 작성할 수 있도록 설정된 테이블입니다.

CREATE TABLE Reviews (
    review_id NUMBER,
    watch_id NUMBER,
    rating NUMBER , -- 평점 1~5
    description varchar2(255)
);
ALTER TABLE REVIEWS ADD CONSTRAINT REVIEWS_REVIEW_ID_PK PRIMARY KEY(REVIEW_ID);
ALTER TABLE REVIEWS ADD CONSTRAINT REVIEWS_RAITING_CK CHECK (rating BETWEEN 1 AND 5); -- 평점 1~5
ALTER TABLE REVIEWS ADD CONSTRAINT REVIEWS_WATCH_HISTORY_FK FOREIGN KEY (watch_id)
        REFERENCES Watch_History(watch_id) ON DELETE CASCADE;
        
--Reviews 테이블 주요 기능
--Create: 사용자가 시청한 영화에 대해 리뷰 작성.
--Read: 영화별 리뷰 목록 조회.
--Update: 리뷰 내용 수정 (예: 평점, 코멘트).
--Delete: 특정 리뷰 삭제.
--영화 본 시간 조인해서 넣을 것

CREATE SEQUENCE Reviews_SEQ
    START WITH 1
    INCREMENT BY 1;


--테이블 간 관계
--
--Movies는 WatchHistory와 Reviews에서 참조됩니다.
--Users는 WatchHistory와 Reviews에서 참조됩니다.
--
--WatchHistory는 사용자가 영화를 시청한 기록을 저장하며, Reviews에서 이를 참조하여 시청한 사용자만 리뷰를 작성하도록 보장합니다.
--
--리뷰 작성 제한 규칙
--
--Reviews 테이블의 CONSTRAINT FK_Review_Watch를 통해 사용자가 시청 기록이 없으면 리뷰를 작성할 수 없게 설정합니다.
--리뷰 작성 시 user_id와 movie_id가 WatchHistory 테이블에 존재해야만 데이터 삽입이 가능합니다.
--CRUD 시나리오
--1. Users (사용자 테이블)
--사용자 등록, 정보 조회 및 수정.
--2. Movies (영화 테이블)
--영화 등록, 조회 및 관리.
--3. WatchHistory (시청 기록 테이블)
--사용자가 영화를 시청한 후 기록 추가.
--4. Reviews (리뷰 테이블)
--Create: 시청한 영화에 한해 리뷰 작성.
--Read: 리뷰 조회 (영화별 또는 사용자별).
--Update: 리뷰 수정 (평점, 코멘트).
--Delete: 리뷰 삭제.

-- 총 시청 횟수 카운트 트리거 (카운팅 안됨)
CREATE OR REPLACE PACKAGE WatchHistoryPkg IS
    total_views NUMBER := 0;
END WatchHistoryPkg;
/
CREATE OR REPLACE TRIGGER WATCH_HISTORY_TOTALVIEW_TRG
AFTER INSERT OR DELETE OR UPDATE OF watch_count
ON WATCH_HISTORY
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        WatchHistoryPkg.total_views := WatchHistoryPkg.total_views + :NEW.watch_count;
    ELSIF DELETING THEN
        WatchHistoryPkg.total_views := WatchHistoryPkg.total_views - :OLD.watch_count;
    ELSIF UPDATING THEN
        WatchHistoryPkg.total_views := WatchHistoryPkg.total_views - :OLD.watch_count + :NEW.watch_count;
    END IF;
END;
/
CREATE OR REPLACE PROCEDURE MOVIES_GENRE_SELECT_PROCEDURE(
    p_genre IN VARCHAR2
) IS
    CURSOR movie_cursor IS
        SELECT title, release_date, duration
        FROM Movies
        WHERE genre = p_genre;
BEGIN
    FOR movie IN movie_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Title: ' || movie.title ||
                             ', Release Date: ' ||  TO_CHAR(movie.release_date, 'YYYY-MM-DD') 
                            || ', Duration: ' || movie.duration || ' mins');
    END LOOP;
END;
/

exec MOVIES_GENRE_SELECT_PROCEDURE('tttt');

select * from movies;

insert into Movies values (MOVIE_SEQ.nextval, '빨강망토', sysdate , 240 ,'romance');
insert into Movies values (MOVIE_SEQ.nextval, '콰직 플레이스', '24/06/26' , 99 ,'thriller');
insert into Movies values (MOVIE_SEQ.nextval, '그가 죽었다', '24/05/15' , 103 ,'thriller');
insert into Movies values (MOVIE_SEQ.nextval, '아바타:물의 길', '22/12/14' , 192 ,'SF');
insert into Movies values (MOVIE_SEQ.nextval, '큐어', '22/07/06' , 111 ,'thriller');
insert into Movies values (MOVIE_SEQ.nextval, '살인예고장', '99/11/20' , 117 ,'romance');
insert into Movies values (MOVIE_SEQ.nextval, '어택커즈 오브 갤럭시', '23/05/03' , 150 ,'SF');
insert into Movies values (MOVIE_SEQ.nextval, '혹성탈출', '24/05/08' , 145 ,'SF');
insert into Movies values (MOVIE_SEQ.nextval, '너의 췌장을 뜯고싶어', '18/11/15' , 109 ,'romance');

CREATE TABLE WATCH_HISTORY_TOTAL (
    total_views NUMBER
);

-- 초기값 0으로 설정
INSERT INTO WATCH_HISTORY_TOTAL (total_views) VALUES (0);
COMMIT;
CREATE OR REPLACE TRIGGER WATCH_HISTORY_TOTALVIEW_TRG
AFTER INSERT OR DELETE OR UPDATE OF watch_count
ON WATCH_HISTORY
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE WATCH_HISTORY_TOTAL
        SET total_views = total_views + :NEW.watch_count;
    ELSIF DELETING THEN
        UPDATE WATCH_HISTORY_TOTAL
        SET total_views = total_views - :OLD.watch_count;
    ELSIF UPDATING THEN
        UPDATE WATCH_HISTORY_TOTAL
        SET total_views = total_views - :OLD.watch_count + :NEW.watch_count;
    END IF;
END;
/
CREATE OR REPLACE PROCEDURE list_movies_by_genre (
    p_genre IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_cursor FOR
        SELECT title, release_date, duration
        FROM Movies
        WHERE genre = p_genre;
END;
/

select watch_id, user_id, movie_id, (select count(*) from Watch_History) as count_watch from Watch_History;
select watch_id, user_id, movie_id, (select count(*) from Watch_History group by movie_id) as count_watch from Watch_History;