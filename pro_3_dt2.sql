CREATE OR REPLACE PROCEDURE pro_3_dt2 IS
    CURSOR dt2_cursor IS
        SELECT *
        FROM dt2
        ORDER BY n DESC;
    
    sumValue NUMBER := 0;
    countValue NUMBER := 0;
    lastValue NUMBER := 0;
    

BEGIN
    FOR dt2Row IN dt2_cursor LOOP
        IF countValue = 0 THEN
            lastValue := dt2Row.n;
        ELSE
            sumValue := sumValue + lastValue - dt2Row.n;
            lastValue := dt2Row.n;
        END IF;
        
        countValue := countValue + 1;
        
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE( sumValue / (countValue-1));
END;
/
SET SERVEROUTPUT ON;



