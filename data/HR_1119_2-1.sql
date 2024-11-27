CREATE TABLE books ( 
    id number(4), 
    title varchar2(50), 
    publisher varchar2(30), 
    year varchar2(10), 
    price number(6)
); 
alter table books add CONSTRAINT books_id_pk PRIMARY KEY(id);
drop table books;

desc books;
select * from user_cons_columns where table_name = 'BOOKS';

CREATE SEQUENCE book_id_seq 
START WITH 1 
INCREMENT BY 1 ; 
 
INSERT INTO books VALUES (book_id_seq.nextval, 'Operating System Concepts', 'Wiley', '2003',30700); 
INSERT INTO books VALUES (book_id_seq.nextval, 'Head First PHP and MYSQL', 'OReilly', '2009', 58000); 
INSERT INTO books VALUES (book_id_seq.nextval, 'C Programming Language', 'Prentice-Hall', '1989', 35000); 
INSERT INTO books VALUES (book_id_seq.nextval, 'Head First SQL', 'OReilly', '2007', 43000); 

commit; 

select * from books;

DELETE from books where ID = 5;
ROLLBACK;
update books set title = 'kkk', publisher = 'javajava', year = '2024', price = 50000 where id = 3;