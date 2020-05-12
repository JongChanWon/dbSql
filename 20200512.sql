EXPLAIN PLAN FOR

SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM TABLE (dbms_xplan.display);
2-1-0 순으로 읽음


ROWID : 테이블 행이 저장된 물리주소
        (java - 인스턴스 변수
            c - 포인터 )
            
SELECT ROWID, emp.*
FROM emp;

사용자에 의한 ROWID 사용 --rowid를 알면 그 행에 접근할 수 있다.(rowid : 그 행에 대한 주소)
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE ROWID ='AAAE5xAAFAAAAEUAAF';

SELECT *
FROM TABLE (dbms_xplan.display);
Plan hash value: 1116584662
 
-----------------------------------------------------------------------------------
| Id  | Operation                  | Name | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------
|   0 | SELECT STATEMENT           |      |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY USER ROWID| EMP  |     1 |    38 |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------


INDEX 실습
emp 테이블에 어제 생성한 pk_emp PRIMARY KEY 제약조건을 삭제
ALTER TABLE emp DROP CONSTRAINT pk_emp; (index 도 삭제)

1. 인덱스 없이 empno 값을 이용하여 데이터 조회
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE (dbms_xplan.display);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7782)


2. emp 테이블에 empno 컬럼으로 PRIMARY KEY 제약조건 생성 한 경우
    (empno 컬럼으로 생성된 unique 인덱스가 존재)
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE (dbms_xplan.display);

Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)


3. 2번 SQL 을 변형 (SELECT 컬럼을 변형)

2번
SELECT *
FROM emp
WHERE empno = 7782;

3번
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE (dbms_xplan.display);

Plan hash value: 56244932
 
----------------------------------------------------------------------------
| Id  | Operation         | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |        |     1 |     4 |     0   (0)| 00:00:01 |
|*  1 |  INDEX UNIQUE SCAN| PK_EMP |     1 |     4 |     0   (0)| 00:00:01 |
----------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("EMPNO"=7782)


4. empno컬럼에 non-unique 인덱스가 생성되어 있는 경우
ALTER TABLE emp DROP CONSTRAINT pk_emp; --제약조건삭제
--CREATE UNIQUE INDEX idx_emp_01 ON emp (empno) 중복이 불가능한 인덱스
CREATE INDEX idx_emp_01 ON emp (empno); 중복이 가능한 인덱스

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE (dbms_xplan.display);

Plan hash value: 4208888661
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_01 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 -- 7782가 더 있나 확인 하기 위해 테이블로 넘어가지 않고 empno 를 한번 더 찾아본다(2번 확인)
 --7782가 하나 더있으면 그밑에꺼까지 확인 (3번확인)
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)


5. emp 테이블의 job 값이 일치하는 데이터를 찾고 싶을 때

보유 인덱스
idx_emp_01 : empno --job 컬럼이랑 무관 
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE (dbms_xplan.display);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     3 |   114 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     3 |   114 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("JOB"='MANAGER')


idx_emp_01 의 경우 정렬이 empno 컬럼 기준으로 되어 있기 때문에 job 컬럼을 제한하는
SQL 에서는 효과적으로 사용할 수가 없기 때문에 TABLE 전체 접근하는 형태의 실행계획이 세워짐
고로 job 컬럼을 생성

==> idx_emp_02 (job) 생성을 한 후 실행계획 비교
CREATE INDEX idx_emp_02 ON emp (job);
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE (dbms_xplan.display);
Plan hash value: 4079571388
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     3 |   114 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     3 |   114 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER')


6. emp테이블에서 job = 'MANAGER' 이면서 ename 이 C로 시작하는 사원만 조회
인덱스 현황
idx_emp_01 : empno 컬럼으로 되어있음
idx_emp_02 : job 컬럼으로 되어있음

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';

SELECT *
FROM TABLE (dbms_xplan.display);
Plan hash value: 4079571388
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    38 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ENAME" LIKE 'C%')
   2 - access("JOB"='MANAGER')


7. emp테이블에서 job = 'MANAGER' 이면서 ename 이 C로 시작하는 사원만 조회 (전체컬럼 조회)
단, 새로운 인덱스 추가: idx_emp_03 : job, ename

CREATE INDEX idx_emp_03 ON emp (job, ename);
인덱스 현황
idx_emp_01 : empno 컬럼으로 되어있음
idx_emp_02 : job 컬럼으로 되어있음
idx_emp_03 : job, ename 복합

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';

SELECT *
FROM TABLE (dbms_xplan.display);

Plan hash value: 2549950125
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
------------ ---------------------------------------
 
   2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
       filter("ENAME" LIKE 'C%')



8. emp테이블에서 job = 'MANAGER' 이면서 ename 이 C로 끝나는 사원만 조회 (전체컬럼 조회)
인덱스현황
idx_emp_01 : empno 컬럼으로 되어있음
idx_emp_02 : job 컬럼으로 되어있음
idx_emp_03 : job, ename 복합

/*+ INDEX( emp IDX_EMP_03 ) */ 힌트를 주는 주석
EXPLAIN PLAN FOR
SELECT * 
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE '%C';

SELECT *
FROM TABLE (dbms_xplan.display);
Plan hash value: 2549950125
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER')
       filter("ENAME" LIKE '%C' AND "ENAME" IS NOT NULL)

앞에꺼는 C로 시작하기때문에 정렬 된 상태에서 시작하지만
C로 '끝나는' 거니까 앞에 무슨문자가 올지 모르기 때문에

원하는 데이터가 없기 때문에 조회를 하지는 않음

RULE BASED OPTIMIZER : 규칙기반 최적화기(9i) ==> 수동 카메라
COST BASED OPTIMIZER : 비용기반 최적화기 (10g) ==> 자동 카메라


9. 복합 컬럼 인덱스의 컬럼 순서의 중요성
인덱스 구성 컬럼 : (job, ename) VS (ename, job)
*** 실행해야 하는 sql 에 따라서 인덱스 컬럼 순서를 조정해야한다

실행 sql : job = manager, ename 이 C로 시작하는 사원 정보를 조회(전체 컬럼)
기존 인덱스 삭제 : idx_emp_03;
DROP INDEX idx_emp_03;

인덱스 신규 생성
idx_emp_04 : ename, job
인덱스현황
idx_emp_01 : empno 컬럼으로 되어있음
idx_emp_02 : job 컬럼으로 되어있음
idx_emp_04 : ename, job 복합

CREATE INDEX idx_emp_04 ON emp (ename, job);

EXPLAIN PLAN FOR
SELECT * 
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';

SELECT *
FROM TABLE (dbms_xplan.display);
Plan hash value: 4077983371
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_04 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 ename 을 먼저 읽고 그다음 메니저로 접근하고 빠져나감
   2 - access("ENAME" LIKE 'C%' AND "JOB"='MANAGER')
       filter("JOB"='MANAGER' AND "ENAME" LIKE 'C%')



**조인에서의 인덱스**
idx_emp_01 삭제 (pk_emp 인덱스와 중복)
DROP INDEX idx_emp_01;
emp 테이블에 empno 컬럼을 PRIMARY KEY 로 제약조건 생성
인덱스 생성
pk_emp : empno
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);


인덱스현황
pk_emp : empno
idx_emp_01 : empno 컬럼으로 되어있음
idx_emp_02 : job 컬럼으로 되어있음
idx_emp_04 : ename, job 복합

모든 직원 조회시 (SORT JOIN) 
EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM TABLE (dbms_xplan.display);

Plan hash value: 844388907
 
----------------------------------------------------------------------------------------
| Id  | Operation                    | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |         |    14 |   812 |     6  (17)| 00:00:01 |
|   1 |  MERGE JOIN                  |         |    14 |   812 |     6  (17)| 00:00:01 |
|   2 |   TABLE ACCESS BY INDEX ROWID| DEPT    |     4 |    80 |     2   (0)| 00:00:01 |
|   3 |    INDEX FULL SCAN           | PK_DEPT |     4 |       |     1   (0)| 00:00:01 |
|*  4 |   SORT JOIN                  |         |    14 |   532 |     4  (25)| 00:00:01 |
|   5 |    TABLE ACCESS FULL         | EMP     |    14 |   532 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
       filter("EMP"."DEPTNO"="DEPT"."DEPTNO")


특정 직원 조회
EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.empno = 7788;

SELECT *
FROM TABLE (dbms_xplan.display);
Plan hash value: 2385808155
 
----------------------------------------------------------------------------------------
| Id  | Operation                    | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |         |     1 |    58 |     2   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                |         |     1 |    58 |     2   (0)| 00:00:01 |
|   2 |   TABLE ACCESS BY INDEX ROWID| EMP     |     1 |    38 |     1   (0)| 00:00:01 |
|*  3 |    INDEX UNIQUE SCAN         | PK_EMP  |     1 |       |     0   (0)| 00:00:01 |
|   4 |   TABLE ACCESS BY INDEX ROWID| DEPT    |     4 |    80 |     1   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN         | PK_DEPT |     1 |       |     0   (0)| 00:00:01 |
----------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("EMP"."EMPNO"=7788)
   5 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")

테이블에 인덱스가 많으면
데이터를 검색할때는 좋은데 입력할 때는 안좋음
