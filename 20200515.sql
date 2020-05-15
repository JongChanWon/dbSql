REPORT GROUP FUNCTION ==> 확장된 GROUP BY
REPORT GROUP FUNCTION 을 사용을 안하면
여러개의 SQL 작성, UNION ALL 을 통해서 하나의.10 
결과로 합치는 과정
==> 좀더 편하게 하는게 REPORT GROUP FUNCTION

ROLLUP : 서브그룹 생성 - 기술된 컬럼을 오른쪽에서부터 지워나가며 GROUP BY 를 실행

아래 쿼리의 서브그룹
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY ==> 전체

ROLLUP 사용시 생성되는 서브그룹의 수는 : ROLLUP 에 기술한 컬럼수 + 1;

GROUP_AD2] --부정확한 방법
SELECT NVL(job, '총계'), deptno, SUM(sal)sal
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT NVL(job, '총계'), deptno, 
       GROUPING(job), GROUPING(deptno), SUM(sal)sal
FROM emp
GROUP BY ROLLUP (job, deptno);
rollup에 의해서 생성된 소계 데이터

GROUP_AD3]
SELECT  CASE
        WHEN GROUPING(job) = 1 THEN '총계'
        ELSE job
        END job, deptno, SUM(sal)sal
       
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD2-1]

SELECT CASE
        WHEN GROUPING(job) = 1 THEN '총'
            ELSE job
            END job,
        CASE
        WHEN GROUPING(job) = 1 AND GROUPING(deptno) = 1 THEN '계'
        WHEN GROUPING(deptno) = 1 THEN '소계'
            ELSE TO_CHAR(deptno)
            END deptno,
            deptno, SUM(sal)sal
FROM emp
GROUP BY ROLLUP(job,deptno);


SELECT DECODE(GROUPING(job), 1, '총', job)job,
       DECODE(GROUPING(job) || GROUPING(deptno), '11', '계', '01', '소계', TO_CHAR(deptno))deptno,
       DECODE(GROUPING(job) + GROUPING(deptno), 2, '계', 1, '소계', TO_CHAR(deptno))deptno, --둘중에 어떻게 해도 상관x
        SUM(sal)sal
FROM emp
GROUP BY ROLLUP(job, deptno);

GROUP_AD3]
SELECT deptno, job, SUM(sal)sal
FROM emp
GROUP BY ROLLUP(deptno,job);

ROLLUP 절에 기술 되는 컬럼의 순서는 조회 결과에 영향을 미친다
(****서브그룹을 기술된 컬럼의 오른쪽 부터 제거해 나가면서 생성)
GROUP BY ROLLUP(deptno,job);
GROUP BY ROLLUP(job,deptno);

GROUP_AD4]
SELECT d.dname, e.job, SUM(e.sal)sal
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY ROLLUP(d.dname, e.job);


SELECT d.dname, a.job,
FROM
(SELECT deptno, job, SUM(sal) sum_sal
 FROM emp
 GROUP BY ROLLUP(d;

GROUP_AD5]
SELECT NVL(d.dname, '총계')dname, e.job, SUM(e.sal)sal
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY ROLLUP(d.dname, e.job);


2. GROUPING SETS
ROLLUP 의 단점 : 관심없는 서브그룹도 생성해야한다
                ROLLUP 절에 기술한 컬럼을 오른쪽에서 지워나가기 때문에
                만약 중간과정에 있는 서브그룹이 불필요 할 경우 낭비.
GROUPING SETS : 개발자가 직접 생성할 서브그룹을 명시
                ROLLUP 과는 다르게 방향성이 없다.
                (콤마기준으로 서브그룹을 만든다)
사용법 : GROUP BY GROUPING SETS (col1, col2)
GROUP BY col1
UNION ALL
GROUP BY col2
위아래는 똑같다
GROUP BY GROUPING SETS (col1, col2)
GROUP BY GROUPING SETS (col2, col1)


SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, deptno);

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(deptno, job); --컬럼순서가 바뀌어도 상관없다.


그룹기준을 
1. job, deptno
2. mgr


GROUP BY GROUPING SETS ((job, deptno), mgr) --괄호를 치면 괄호안에 있는걸 하나의 그룹으로 본다.

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);

3.CUBE
사용법: GROUP BY CUBE (col1, col2...)
기술된 컬럼의 가능한 모든 조합(순서는 지킨다)

GROUP BY CUBE(job, deptno);
1컬럼       2번컬럼
job,        deptno
job,        x
 x,         deptno
 x,         x

GROUP BY CUBE(job, deptno, mgr);
1컬럼       2번컬럼          3번컬럼
job,        deptno          mgr
job,        deptno           x
job,        deptno          mgr
job,         x               x
 x          deptno
 x          
 x
 x

SELECT job, deptno,SUM(sal)
FROM emp
GROUP BY CUBE (job, deptno);


여러개의 REPORT GROUP 사용하기
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**발생 가능한 조합을 계산
1          2         3
job     deptno      mgr  ==> GROUP BY job ,deptno, mgr
job     x           mgr  ==> GROUP BY job ,mgr
job     deptno      x    ==> GROUP BY job, deptno
job     x           x    ==> GROUP BY job 



SELECT job, deptno, mgr, SUM(sal+NVL(comm,0))sal
FROM emp
GROUP BY job, rollup(job, deptno), cube(mgr);

1           2           3

--select 서브쿼리는 중요!
상호연관 서브쿼리 업데이트
1. emp테이블을 이용하여 emp_test 테이블 생성
2. emp_test 테이블에 dname컬럼 추가(dept 테이블 참고)

drop table emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));
desc emp_test;

SELECT *
FROM emp_test;

3. subquery 를 이용하여 emp_test 테이블에 추가된 dname 컬럼을 업데이트 해주는 쿼리 작성
emp_test 의 dname 컬럼의 값을 dept 테이블의 dname 컬럼으로 update
emp_test 테이블의 deptno 값을 확인해서 dept테이블의 deptno 값이랑 일치하는 dname 컬럼값을 가져와서 update

emp_test 테이블의 dname 컬럼을 dept 테이블을 용해서 dname 값 조회하여 업데이터
update 대상이 되는 행 : 14 ==> WHERE 절을 기술하지 않음

모든 직원을 대상으로 DNAME 컬럼을 DEPT 테이블에서 조회하여 업데이트
UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE emp_test.deptno = dept_test.deptno);
                             
DROP TABLE dept_test2;
SELECT *
FROM dept_test2;

sub_a1]
CREATE TABLE dept_test2 AS
ALTER TABLE dept_test2 ADD (empcnt NUMBER);

*group by 안한거
UPDATE dept_test2 SET empcnt = (SELECT count(*)
                                FROM emp
                                WHERE emp.deptno = dept_test2.deptno); --상호 연관 커리

*group by 한거
UPDATE dept_test2 SET empcnt = (SELECT count(*)
                                FROM emp
                                WHERE emp.deptno = dept_test2.deptno
                                GROUP BY deptno);
                                
SELECT 결과 전체를 대상으로 그룹 함수를 적용한 경우
대상되는 행이 없더라도 0값이 리턴
SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY 절을 기술할 경우 대상이 되는 행이 없을 경우 조회되는 행이 없다
SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;



SELECT *
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_TYPE='R';