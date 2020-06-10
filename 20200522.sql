프로시져의 구조

변수
하나의 단일 값을 저장할 수 있는 변수(String)
행 전체를 저장할 수 있는 변수(Map, Class)
여러 행을 저장할 수 있는 변수(List<Map>, List<Class>) --맵을 제네릭으로 하는 리스트, 클래스를 제네릭으로 하는 리스트

SET SERVEROUTPUT ON; --이걸 해야 실행이됨

DECLARE
    TYPE dept_tab IS TABLE OF DEPT%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;
BEGIN
    SELECT * BULK COLLECT INTO v_dept
    FROM dept;
    
    FOR i IN 1..v_dept.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_dept(i).deptno || ' - ' || v_dept(i).dname || ' - ' || v_dept(i).loc);
    END LOOP;
END;
/
**FOR 구문
java : for
for(int i = 0; i < max; i++{
}
SQL
FOR i IN 1..v_dept.COUNT LOOP
    반복구문
END LOOP;

**IF 구문 (조건제어)
IF condition(비교구문) THEN
    statement;
ELSEIF condition(비교구문) THEN
       statement;
ELSE 
       statement;
END IF;

NUMBER 타입의 P 변수를 선언하고 2를 대입
IF 구문을 통해 P 값을 체크하여 출력하는 예제

DECLARE 
    --int a = 2;(자바)
    P NUMBER := 2;
BEGIN
    --p가1이면 1을 출력
    --p가2이면 2를 출력
    --그밖의 값일 때는 else를 출력
    
    IF p = 1 THEN
        DBMS_OUTPUT.PUT_LINE('1');
    ELSEIF p = 2 THEN
        DBMS_OUTPUT.PUT_LINE('2');
    ELSE
        DBMS_OUTPUT.PUT_LINE('else');
    END IF;
END;
/

CASE 구문
검색 케이스(java switch)
문법
    CASE 표현식
        WHEN VALUE THEN
            statement;
        WHEN VALUE2 THEN
            statement;
        ELSE
            statement;
    END CASE;
            
일반 케이스 : 일반언어의 IF 구문, SQL에서 배웠던 CASE 구문과 동일, CASE - END CASE;
    CASE
        WHEN expression THEN
            statement; -- /returnvalue
        WHEN expression2 THEN
            statement;
        ELSE
            statement;
    END CASE;
    
    
케이스 표현식
    CASE
        WHEN expression THEN
            반환할값
        WHEN expression2 THEN
            반환할값
        ELSE
            반환할값
    END;

검색 케이스
DECLARE 

    P NUMBER := 2;
    
BEGIN
    --java switch
    CASE p
        WHEN 1 THEN
            DBMS_OUTPUT.PUT_LINE('1');
        WHEN 2 THEN
            DBMS_OUTPUT.PUT_LINE('2');
        ELSE
            DBMS_OUTPUT.PUT_LINE('else');
    END CASE;
END;
/

일반 케이스
DECLARE 

    P NUMBER := 2;
    
BEGIN
    
    CASE 
        WHEN P = 1 THEN
            DBMS_OUTPUT.PUT_LINE('1');
        WHEN P = 2 THEN
            DBMS_OUTPUT.PUT_LINE('2');
        ELSE
            DBMS_OUTPUT.PUT_LINE('else');
    END CASE;
END;
/

케이스 표현식
DECLARE 

    P NUMBER := 2;
    ret NUMBER := 0;
BEGIN
    
    RET := CASE 
        WHEN P = 1 THEN
            4
        WHEN P = 2 THEN
            5
        ELSE
            6
    END;
    DBMS_OUTPUT.PUT_LINE(ret);
END;
/

**반복문**
인덱스 변수는 개발자가 별도로 선언하지 않는다
REVERSE 옵션을 사용하면 종료값부터 값을 1씩 줄여 나가며 인덱스 변수가 시작값이 될때 까지 실행
FOR(int = 10; i > 0; i--) java에서 포문 역방향

FOR 인덱스변수 IN [REVERSE] 시작값..종료값 LOOP
END LOOP;

1~5 숫자 출력
DECLARE 
   
    i NUMBER := 1;
    
BEGIN
    FOR i IN 1..5 LOOP
    DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(i);
END;
/

2~9단 구구단 출력하기
DECLARE 
BEGIN
    FOR i IN 2..9 LOOP
        FOR j IN 1..9 LOOP
    DBMS_OUTPUT.PUT_LINE(i || ' * ' || j || ' = ' || i*j);
    
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(' ');
END LOOP;    
END;
/

JAVA 반복문 종료 : for(향상된for), while, do-while

while
문법
WHILE condition LOOP
    statement;
END LOOP;


DECLARE
    i NUMBER := 1;
BEGIN
   WHILE i <= 5 LOOP
   DBMS_OUTPUT.PUT_LINE(i);
        i := i +1;
    END LOOP;
END;
/
------------------------
**LOOP**
문법
LOOP
    statement;
    EXIT WHEN condition;
    statement;
END LOOP;
-----------------------
LOOP
java : while(true){
            if(true){
            }
        }


DECLARE
    i NUMBER := 1;
BEGIN
    LOOP
        EXIT WHEN i > 5;
        DBMS_OUTPUT.PUT_LINE(i);
        i := i +1;
    END LOOP;
END;
/

어렵지만 중요한것
CURSOR : SELECT 문에 의해 추출된 데이터를 가리키는 포인터(메모리)
SQL을 사용자가 DBMS로 요청을 보냈을 때 처리 순서
1. 동일한 SQL이 실행된 적이 있는지 확인(실행 계획을 공유하기 위해서)
2. 바인드 변수적용(바인드 변수가 사용되었을 경우)
3. 실행(EXECUTION)
4. 인출(fetch)

cursor를 사용하게 되면 인출 단계를 제어 가능
==> SELECT 쿼리의 결과를 변수에 담지 않고 CURSOR 를 통해 직접 메모리에 접근 할 수 있다

PL/SQL 의 대부분의 로직은 SELECT 결과에 특정 로직을 적용하여 처리 하는 것이기 때문에
별도의 변수에 SELECT 결과를 담는 것이 비합리적일 수 있다.

CURSOR 의 종류
묵시적 : 별도의 이름을 부여하지 않고 실행한 DML 구문
명시적 : 개발자가 이름을 부여한 CURSOR

CURSOR 는 변수처럼 선언 ==> DECLARE

CURSOR 사용단계
1.선언
2.열기(OPEN)
3.인출(FETCH)
4.닫기(close)

문법
1. 선언 (DECLARE 절)
    CURSOR 커서이름 IS
        QUERY;
2. 열기 ( BEGIN)
    OPEN 커서이름;
3. 인출(BEGIN)
    FETCH 커서이름 INTO variable;
4. 닫기 (BEGIN)
    CLOSE 커서이름;
    
dept 테이블의 모든 행을 조회하고, DEPTNO, DNAME 컬럼만 커서를 통해서
스칼라 변수 (v_deptno, v_dname)

여러행을 조회하는 SELECT 쿼리의 결과값을 저장하기 위해서 TABLE


DECLARE
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;

    CURSOR deptcursor IS
        SELECT deptno, dname
        FROM dept;
        
BEGIN
    OPEN deptcursor;
    LOOP
        FETCH deptcursor INTO v_deptno, v_dname;
        
        EXIT WHEN deptcursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(v_deptno || ' / ' || v_dname);
    END LOOP;
    CLOSE deptcursor;
    
END;


명시적 커서와 FOR LOOP 결합 ==> 보다 사용하기 쉬운 형태
OPEN, CLOSE, FETCH 하는 과정을 FOR 


문법
FOR 레코드 이름(행 정보를 저장) IN 커서이름 LOOP
    레코드 이름





DECLARE
    CURSOR deptcursor IS
        SELECT deptno, dname
        FROM dept;
        
BEGIN
    FOR rec IN deptcursor LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ' / ' || rec.dname);
    END LOOP;
    
END;
/


파라미터가 있는 명시적 커서
부서 번호를 입력받아 where 절에서 사용하는 커서를 선언

DECLARE
    CURSOR deptcursor (p_deptno dept.deptno%TYPE) IS
        SELECT deptno, dname
        FROM dept
        WHERE deptno <= p_deptno;
        
BEGIN
    FOR rec IN deptcursor(30) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ' / ' || rec.dname);
    END LOOP;
    
END;
/


FOR LOOP와 인라인(직접기술) 커서
DECLARE 절에 커서를 명시적으로 선언하지 않고
FOR LOOP에서 SQL을 직접 기술.


DECLARE
 
BEGIN
    FOR rec IN (SELECT deptno, dname FROM dept) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ' / ' || rec.dname);
    END LOOP;
    
END;
/

for루프를 적용한 형태를 추천


 CREATE TABLE DT
(	DT DATE);

insert into dt
select trunc(sysdate + 10) from dual union all
select trunc(sysdate + 5) from dual union all
select trunc(sysdate) from dual union all
select trunc(sysdate - 5) from dual union all
select trunc(sysdate - 10) from dual union all
select trunc(sysdate - 15) from dual union all
select trunc(sysdate - 20) from dual union all
select trunc(sysdate - 25) from dual;

commit;


pro_3]

SELECT *
FROM dt;

CREATE TABLE dt2 AS
SELECT 40 n FROM dual UNION ALL
SELECT 35 FROM dual UNION ALL
SELECT 30 FROM dual UNION ALL
SELECT 25 FROM dual UNION ALL
SELECT 20 FROM dual UNION ALL
SELECT 15 FROM dual UNION ALL
SELECT 10 FROM dual UNION ALL
SELECT 5 FROM dual;


DECLARE
BEGIN
    FOR rec IN (SELECT  FROM ) Loop
        DBMS_OUTPUT.PUT_LINE(rec.trunc(sysdate+10));
    END LOOP;
END;
/



DECLARE
 
BEGIN
    FOR rec IN (SELECT deptno, dname FROM dept) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ' / ' || rec.dname);
    END LOOP;
    
END;
/






SELECT empno, ename, mgr,
NVL(mgr,9999) mgr_n,
NVL2(mgr,mgr,9999) mgr_n_1,
coalesce(mgr,9999) mgr_n_2
FROM emp;


SELECT TO_CHAR(TO_DATE('201912','YYYYMM')) param,
TO_CHAR(LAST_DAY(TO_DATE('201912','YYYYMM')),'DD') dt
FROM dual;

SELECT empno, ename, mgr, NVL(mgr, '9999') mgr_1
FROM emp;


SELECT TO_DATE(:yyyymm, 'YYYYMM'),
       TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'YYYYMM')param,
       TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'dd') dt
FROM dual;





