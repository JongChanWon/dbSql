실행계획 : SQL 을 내부적으로 어떤 절차를 거쳐서 실행할지 로직을 작성
         *계산하는데 비싼 연산 비용이 필요(시간)
         
         
2개의 테이블을 조인하는 SQL
2개의 테이블에 각각 인덱스가 5개가 있다면 
가능한 실행계획 조합 몇개?? 굉장히 많다 ==> 짧은 시간안에 해내야 한다 (응답을 빨리 해야하므로)

만약 동일한 SQL이 실행될 경우 기존에 작성된 실행계획이 존재할 경우
새롭게 만들지 않고 재활용을 한다 (리소스 절약)

테이블 접근 방법 : 테이블 전체(1개), 각각의 인덱스(5개)
a => b 로 접근 할 경우,
b => a 로 접근 할 경우 를 생각해보면 곱하기 2
경우의 수 : 36개 *2개 = 72개


동일한 SQL 이란 : SQL 문장의 대소문자 공백까지 일치하는 SQL
DBMS 입장에서는 아래 두개의 sql 을 서로다른 SQL로 인식한다
SELECT * FROM emp;
select * FROM emp;  

특정직원의 정보를 조회하고 싶은데 : 사번을 이용해서
select /* 202004_B */ *
FROM emp
WHERE empno = 7499;

select /* 202004_B */ *
FROM emp
WHERE empno = :empno;
*바인드 변수를 사용하면 SQL에 무리를 주지 않는다(바인드를 쓰지않으면 기록이 다 남기 때문에 무리를 줄 수 있음)


운반단위를 빠르게 채울수 있으면
부분범위
아니면
전체범위

읽는데로 빠르게 채우면 부분범위 아니면 전체범위

NESTED LOOP > HASH > SORT 순으로 빠르다
운반단위를 빠르게 채울 수 있다

운반박스에 채워넣는걸 버퍼링이라고함

Data Dictionary : 시스템 정보를 볼 수 있는 view, 오라클이 자체적으로 관리
category (접두어)
user : 해당 사용자가 소유하고 있는 객체 목록
ALL : 해당 사용자 소유 + 권한을 부여받은 객체 목록
DBA : 모든 객체 목록
V$ : 성능, 시스템관련 (시스템에서만 가능)

SELECT *
FROM user_tables;

SELECT *
FROM ALL_tables;

SELECT *
FROM DBA_tables; --볼수 있는 권한이 없음(SYSTEM 계정에서만 가능)

SELECT *
FROM dictionary;


Multiple insert : 여러건의데이터를 동시에 입력하는 insert의 확장구문

1. unconditional insert : 동일한 값을 여러 테이블에 입력하는 경우
문법 : 
    INSERT ALL
        INTO 테이블명
        [,INTO 테이블명] --여러개 올수 있음
    VALUES (...) | SELECT QUERY;
    
SELECT *
FROM emp_test2;

emp_test 테이블을 이용하여 emp_test2 테이블 생성
CREATE TABLE emp_test2 AS
SELECT *
FROM emp_test
WHERE 1 = 2;
    
EMPNO, ENAME, DEPTNO

emp_test, emp_test2 테이블에 동시에 입력
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 9998, 'brown', 88 FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;
    
SELECT *
FROM emp_test

SELECT *
FROM emp_test2
2. conditional insert : 조건에 따라 입력할 테이블을 결정

INSERT ALL INTO 
    WHEN 조건....THEN
        INTO 입력 테이블 VALUES
    WHEN 조건....THEN
        INTO 입력 테이블2 VALUES
    ELSE
        INTO 입력 테이블3 VALUES
SELECT 결과의 행의 값이 EMPNO = 9998이면 EMP_TEST 에만 데이트를 입력
                      그 외에는 EMP_TEST2에 데이터를 입력
INSERT ALL
    WHEN empno = 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    ELSE
        INTO emp_test2 (empno, deptno) VALUES (empno, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL --위쪽에만 알리아스를 주면됨
SELECT 9997, 'cony', 88 FROM dual;

SELECT *
FROM emp_test

SELECT *
FROM emp_test2

ROLLBACK;

conditional insert (all) ==> first
INSERT ALL 
    WHEN empno <= 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    WHEN empno <= 9997 THEN
        INTO emp_test2 VALUES (empno, ename, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

ROLLBACK;

INSERT FIRST
    WHEN empno <= 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    WHEN empno <= 9997 THEN
        INTO emp_test2 VALUES (empno, ename, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

*Merge (DML)
-하나의 데이터 셋을 다른 테이블로 데이터를 신규 입력, 또는 업데이트 하는 쿼리
문법:
MERGE INTO 머지대상(emp_test)
USING (다른테이블 | VIEW | subquery)
ON (머지대상과 USING 절의 연결 조건 기술)
WHEN NOT MATCHED THEN
    INSERT (col1, col2(컬럼)...) VALUES (value1, value2....)
WHEN MATCHED THEN
    UPDATE SET col1 = value1, col2 = value2

1. 다른 데이터로 부터 특정 테이블로 데이터를 MERGE 하는경우
2. KEY 가 없을 경우 INSERT
   KEY 가 있을 경우 UPDATE


emp 테이블의 데이터를 emp_test 테이블로 통합
emp 테이블에는 존재하고 emp_test 테이블에는 존재하지 않는 직원을 신규입력
emp 테이블에는 존재하고 emp_test 테이블에도 존재하는 직원의 이름 변경

INSERT INTO emp_test VALUES (7369, 'cony', 88);
MERGE INTO emp_test

emp 테이블의 14건의 데이터를 emp_test 테이블에 동일한 empno가 존재 하는지 검사해서
동일한 empno가 없으면 insert - empno, ename , 동일한 empno가 있으면 update - ename
MERGE INTO emp_test
USING emp
ON (emp_test.empno = emp.empno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (emp.empno, emp.ename)
WHEN MATCHED THEN
    UPDATE SET ename = emp.ename;
-------------------
merge 전 데이터
12  	brown	999
7369	cony	88
-------------------
merge 후 데이터
12  	brown	999
7369	SMITH	88
7844	TURNER	
7839	KING	
7782	CLARK	
7521	WARD	
7654	MARTIN	
7788	SCOTT	
7698	BLAKE	
7566	JONES	
7499	ALLEN	
7934	MILLER	
7902	FORD	
7876	ADAMS	
7900	JAMES
-------------------
SELECT *
FROM emp

SELECT *
FROM emp_test

9999번 사번으로 신규 입력하거나, 업데이트를 하고 싶을 때
(사용자가9999번, james 사원을 등록하거나, 업데이트 하고 싶을때)
위의 경우는 테이블 ==> 다른테이블로 머지

이번에 하는 시나리오 : 데이터를 ==> 특정 테이블로 머지
(9999, james)

MERGE 구문을 사용하지 않으면

데이터 존재 유무를 위해 SELECT 실행
SELECT *
FROM emp_test
WHERE empno = 9999;

데이터가 있으면 ==> UPDATE
데이터가 없으면 ==> INSERT

MERGE INTO emp_test
USING dual
    ON (emp_test.empno = 9999)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999, 'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';
    
위 아래 구문은 똑같은 결과를 도출 (위에 문장이 더 낫다)

MERGE INTO emp_test
USING (SELECT 9999 eno, 'james' enm
       FROM dual) a
    ON (emp_test.empno = a.eno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999, 'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';

SELECT *
FROM emp_test;

REPORT GROUP FUNCTION
emp 테이블을 이용하여 부서번호별 직원의 급여 합과, 전체직원의 급여합을 조회하기 위해
GROUP BY 를 사용하는 두개의 SQL로 나눠서 하나로 합치는(UNION ==> UNION ALL) 작업을 진행

밑에 두개 쿼리를 합쳐 -- union 할때는 컬럼 갯수를 맞춰줘야함
SELECT deptno, SUM(sal) 
FROM emp
GROUP BY deptno

UNION ALL

SELECT NULL, SUM(sal) 
FROM emp;


확장된 GROUP BY 3가지
1. GROUP BY ROLLUP
문법 : GROUP BY ROLLUP (컬럼, 컬럼2...)
목적 : 서브그룹을 만들어 주는 용도
서브그룹 생성 방식 : ROLLUP 절에 기술한 컬럼을 오른쪽에서 부터 하나씩 제거하면서 서브구룹을 생성
생성된 서브그룹을 UNION 한 결과를 반환

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);
*SAME*
서브그룹: 1. GROUP BY job, deptno
            UNION
         2. GROUP BY job
            UNION
         3. 전체행 GROUP BY

밑의 GROUP BY 와 위의 GROUP BY ROLLUP 이랑 똑같다
SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY job, deptno

UNION

SELECT job, NULL, SUM(sal) sal
FROM emp
GROUP BY job

UNION

SELECT NULL, NULL, SUM(sal) sal
FROM emp

문제] 밑에 두 쿼리를 GROUP BY ROLLUP 으로 변경하시오
SELECT deptno, SUM(sal) 
FROM emp
GROUP BY deptno

UNION ALL

SELECT NULL, SUM(sal) 
FROM emp;

-> GROUP BY ROLLUP 으로 변경 후 
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP(deptno);




















