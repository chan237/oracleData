DECLARE
    A NUMBER;
    I NUMBER := 1;
    J NUMBER := 0;
BEGIN
    FOR A IN 1..9 LOOP
    J := J+1;
    DBMS_OUTPUT.PUT_LINE(I || '*' || J ||'='|| I*J);
    END LOOP;
END;
/

DECLARE
    VNUM NUMBER :=0;
    VCOUNT NUMBER := 1;
    VDAN NUMBER := 0;
BEGIN
    LOOP
        VDAN := VDAN+1;
        VCOUNT :=1;
        DBMS_OUTPUT.PUT_LINE('============'||VDAN||'==============');
            LOOP
                DBMS_OUTPUT.PUT_LINE(VDAN || '*' || VCOUNT ||'='|| VDAN*VCOUNT);
                VCOUNT := VCOUNT+1;
                IF VCOUNT>9 THEN
                    EXIT;
                END IF;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        IF VDAN>9 THEN
            EXIT;
        END IF;
    END LOOP;
END;
/