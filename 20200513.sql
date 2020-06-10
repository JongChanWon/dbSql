CREATE TABLE dept_test2 AS
SELECT *
FROM DEPT
WHERE 1 = 1;
 deptno;
CREATE UNIQUE INDEX idx_U_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_u_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_u_dept_test2_03 ON dept_test2 (deptno, dname);

idx2]
DROP INDEX idx_U_dept_test2_01; 
DROP INDEX idx_u_dept_test2_02; 
DROP INDEX idx_u_dept_test2_03; 

idx3]
SELECT *
FROM emp
WHERE empno = :empno; --사번 번호가 (=) :empno 에는 상수가 들어감

empno || '%'

CREATE INDEX idx_emp_04 ON emp (empno);
CREATE INDEX idx_emp_05 ON emp (ename);
CREATE INDEX idx_emp_06 ON emp ()
(=)조건이 선행조건으로 오며 ㄴ유리

SELECT deptno, TO_CHAR(hiredate, 'yyyymm'),
        COUNT(*) cnt
FROM emp
GROUP BY deptno, TO_CHAR(hiredate, 'yyyymm')

select b.*
from emp a, emp b
where a.mgr = b.empno
and a.deptno = : deptno;

idx4]
dept 테이블도 같이 넣어서 

수업시간에 배운 조인
==> 논리적 조인 형태를 이야기 함, 기술적인 이야기가 아님
inner join : 조인에 성공하는 데이터만 조회하는 조인 기법
outer join : 조인에 실패해도 기준이 되는 테이블의 컬럼정보는 조회하는 조인기법
cross join : 묻지마 조인(카티션 프로덕트), 조인 조건을 기술하지 않아서 
             연결 가능한 모든 경우의 수로 조인되는 기법
self join : 같은 테이블끼리 조인하는 형태

개발자가 DBMS 에 SQL 을 실행 요청 하면 DBMS 는 SQL 을 분석해서
어떻게 두 테이블 연결할 지를 결정, 3가지 방식의 조인방식(물리적 조인방식, 기술적인 이야기)
1. Nested Loop Join (이중루프와 유사) , 소량의 데이터
2. Sort Merge Join
3. Hash Join

OLPT (OnLine Transaction Processing) : 실시간 처리 ==> 응답이 빨라야 하는 시스템(일반적인 웹 서비스)
OLAP (Online Analysis Processing) : 일괄 처리 ==> 전체 처리속도가 중요 한 경우
                                    (은행 이자 계산, 새벽 한번에 계산)
sort merge join 
정렬이 끝나야 연결이 가능
정렬이라는 자체가 부화가 크다


한쪽이 작을경우 해쉬테이블을 빠르게 만들 수 있다


index 를 활용하지 못하는 경우 : 컬럼가공( 좌변을 가공하지 마라 )


select *
from emp
where comm >0

idx 4] 
시스템에서 사용하는 쿼리가 다음과 같다고 할 때 적절한 emp, dept
테이블에 필요하다고 생각되는 인덱스를 생성 스크립트를 만들어 보세요

SELECT *
FROM emp
WHERE empno = :empno;

SELECT *
FROM dept
WHERE deptno = :deptno;

SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND e.deptno = :deptno
  AND e.empno LIKE :empno || '%';

SELECT *
FROM emp
WHERE sal BETWEEN :st_sal AND :ed_sal

SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND e.deptno = :deptno
  AND d.loc = :loc;


CREATE INDEX idx_emp_1 ON emp (empno, deptno, loc)
CREATE INDEX idx_emp_2 ON dept (deptno)
CREATE INDEX idx_emp_3 ON emp (sal)





