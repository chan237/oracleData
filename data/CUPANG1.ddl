-- 생성자 Oracle SQL Developer Data Modeler 24.3.0.275.2224
--   위치:        2024-11-08 16:51:38 KST
--   사이트:      Oracle Database 11g
--   유형:      Oracle Database 11g


-- predefined type, no DDL - MDSYS.SDO_GEOMETRY
-- predefined type, no DDL - XMLTYPE

CREATE TABLE c_user (
    no    NUMBER(4) NOT NULL,
    addr  VARCHAR2(50) NOT NULL,
    name  VARCHAR2(10) NOT NULL,
    phone CHAR(13) NOT NULL
);
ALTER TABLE c_user ADD CONSTRAINT c_user_pk PRIMARY KEY ( no );
ALTER TABLE c_user ADD CONSTRAINT c_user_uk UNIQUE ( addr );

CREATE TABLE delivery (
    no        NUMBER(4) NOT NULL,
    delidate  DATE NOT NULL,
    oder_no   NUMBER(4) NOT NULL,
    c_user_addr VARCHAR2(50) NOT NULL
);
ALTER TABLE delivery ADD CONSTRAINT delivery_pk PRIMARY KEY ( no );
ALTER TABLE delivery ADD CONSTRAINT delivery_c_user_fk
        FOREIGN KEY ( c_user_addr ) REFERENCES c_user ( addr ) ON DELETE CASCADE;
ALTER TABLE delivery ADD CONSTRAINT delivery_oder_fk
        FOREIGN KEY ( oder_no ) REFERENCES oder ( no ) ON DELETE CASCADE;

CREATE TABLE goods (
    no    NUMBER(4) NOT NULL,
    price NUMBER(10) NOT NULL,
    name  VARCHAR2(20) NOT NULL,
    stock NUMBER(4) DEFAULT 0
);
ALTER TABLE goods ADD CONSTRAINT goods_pk PRIMARY KEY ( no );

CREATE TABLE oder (
    no         NUMBER(4) NOT NULL,
    stock      NUMBER(4) DEFAULT 1,
    totalprice NUMBER(10) NOT NULL,
    c_user_no  NUMBER(4) NOT NULL,
    goods_no   NUMBER(4) NOT NULL
);
ALTER TABLE oder ADD CONSTRAINT oder_pk PRIMARY KEY ( no );
ALTER TABLE oder ADD CONSTRAINT oder_c_user_fk
        FOREIGN KEY ( c_user_no )REFERENCES c_user ( no )ON DELETE CASCADE;
ALTER TABLE oder ADD CONSTRAINT oder_goods_fk 
        FOREIGN KEY ( goods_no ) REFERENCES goods ( no )ON DELETE CASCADE;

drop table delivery;
drop table c_user;
drop table oder;
drop table goods;

SELECT * FROM user_cons_columns where table_name = upper('c_user');
SELECT * FROM user_cons_columns where table_name = upper('oder');
SELECT * FROM user_cons_columns where table_name = upper('goods');
SELECT * FROM user_cons_columns where table_name = upper('delivery');



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              8
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
