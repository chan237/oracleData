select * from books;
create or replace NONEDITIONABLE PROCEDURE BOOKS_PROCE(
    VID IN BOOKS.ID%TYPE, VPRICE IN BOOKS.PRICE%TYPE, VMESSAGE OUT VARCHAR2)
IS
    VBOOKS_RT BOOKS%ROWTYPE;
BEGIN
    UPDATE BOOKS
    SET PRICE = PRICE + VPRICE
    WHERE ID = VID;
    COMMIT;
    SELECT * INTO VBOOKS_RT FROM BOOKS WHERE ID = VID;
    VMESSAGE := VBOOKS_RT.ID || ' 번호의 인상금액은 ' || VPRICE || ' 이고 총 금액은 ' || VBOOKS_RT.PRICE || '입니다.';
    DBMS_OUTPUT.PUT_LINE(VMESSAGE);
END;
/

EXECUTE BOOKS_PROCE(3,5000,'dsad');



CREATE OR REPLACE NONEDITIONABLE PROCEDURE BOOKS_PROCE2(
    VID IN BOOKS.ID%TYPE, 
    VPRICE IN BOOKS.PRICE%TYPE, 
    VMESSAGE OUT VARCHAR2
) IS
    VBOOKS_RT BOOKS%ROWTYPE;
BEGIN
    -- 책 가격 업데이트
    UPDATE BOOKS
    SET PRICE = PRICE + VPRICE
    WHERE ID = VID;

    -- 커밋
    COMMIT;

    -- 단일 행 조회
    SELECT ID, PRICE INTO VBOOKS_RT.ID, VBOOKS_RT.PRICE
    FROM BOOKS 
    WHERE ID = VID;

    -- 메시지 생성
    VMESSAGE := VBOOKS_RT.ID || ' 번호의 인상금액은 ' || VPRICE || ' 이고 총 금액은 ' || VBOOKS_RT.PRICE || '입니다.';
    
    -- 메시지 출력
    DBMS_OUTPUT.PUT_LINE(VMESSAGE);
END;
/

DECLARE
    VMESSAGE VARCHAR2(4000); -- OUT 매개변수를 받을 변수 선언
BEGIN
    BOOKS_PROCE(3, 5000, VMESSAGE);
    DBMS_OUTPUT.PUT_LINE('결과 메시지: ' || VMESSAGE);
END;
/
drop table LANDPRICE;
create table LANDPRICE (
	NODENO number, --pk
	GPSLATI number,
	GPSLONG number,
	NODEID varchar2(20) not null, --uk
	NODENM varchar2(100)
);
Alter table LANDPRICE add CONSTRAINT LANDPRICE_NODENO_PK PRIMARY KEY(NODENO);
Alter table LANDPRICE add CONSTRAINT LANDPRICE_NODEID_UK UNIQUE(NODEID);