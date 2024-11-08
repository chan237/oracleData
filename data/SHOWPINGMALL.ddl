-- 생성자 Oracle SQL Developer Data Modeler 24.3.0.275.2224
--   위치:        2024-11-08 14:45:22 KST
--   사이트:      Oracle Database 11g
--   유형:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE buytable (
    phone           CHAR(13 CHAR) NOT NULL,
    pdname          CHAR(3 CHAR) NOT NULL,
    price           NUMBER(7) NOT NULL,
    amount          NUMBER(5) NOT NULL,
    no              NUMBER(10) NOT NULL,
    usertable_phone CHAR(13) NOT NULL
);

ALTER TABLE buytable ADD CONSTRAINT buytable_pk PRIMARY KEY ( no );

CREATE TABLE usertable (
    name  CHAR(6 CHAR) NOT NULL,
    birth DATE NOT NULL,
    addr  VARCHAR2(40 CHAR) NOT NULL,
    phone CHAR(13) NOT NULL
);

ALTER TABLE usertable ADD CONSTRAINT usertable_pk PRIMARY KEY ( phone );

ALTER TABLE buytable
    ADD CONSTRAINT buytable_usertable_fk
        FOREIGN KEY ( usertable_phone )
            REFERENCES usertable ( phone )
                ON DELETE CASCADE;



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             2
-- CREATE INDEX                             0
-- ALTER TABLE                              3
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
