한개의 행, 하나의 컬럼을 리턴하는 서브쿼리
ex: 전체 직원의 급여 평균, smith 직원이 속한 부서의 부서번호

WHERE절 에서 사용가능한 연산자
WHERE deptno = 10
==>

부서번호가 10 혹은 30번인 경우
WHERE deptno IN(10,30)
WHERE deptno = 10 OR deptno = 30



*다중행 연산자
 다중행을 조회하는 서브쿼리의 경우 = 연산자를 사용불가
WHERE deptno = (10,30) 하면 오류
WHERE deptno IN (여러개의 행을 리턴하고, 하나의 컬럼으로 이루어진 쿼리)

SMITH - 20, ALLEN은 30번 부서에 속함
SMITH 또는 ALLEN이 속하는 부서의 조직원정보를 조회

행이 여러개고, 컬럼은 하나다 
==> 서브쿼리에서 사용가능한 연산자 IN(많이씀, 중요), (ANY,ALL(빈도가 낮음))
IN : 서브쿼리의 결과값중 동일한 값이 있을 때 TRUE
     WHERE 컬럼|표현식 IN(서브쿼리)
    
ANY: 연산자를 만족하는 값이 하나라도 있을 때 TRUE
     WHERE 컬럼|표현식 연산자 ANY(서브쿼리) 
    
ALL: 서브쿼리의 모든 값이 연산자를 만족 할 때 TRUE
     WHERE 컬럼|표현식 연산자 ANY(서브쿼리)

SMITH와 ALLEN이 속한 부서에서 근무하는 모든 직원을 조회
1. 서브쿼리를 사용하지 않을 경우 : 두개의 쿼리를 실행

1-1] SMITH, ALLEN이 속한 부서의 부서번호를 확인하는 쿼리
SELECT deptno
FROM emp
WHERE ename IN ('SMITH', 'ALLEN');

1-2] 1-1]에서 얻은 부서번호로 IN연산을 통해 해당 부서에 속하는 직원 정보 조회
SELECT deptno
FROM emp
WHERE deptno IN(20, 30);

==> 서브쿼리를 이용하면 하나의 SQL에서 실행가능
SELECT deptno
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'ALLEN'));
                 
sub 3]
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN('SMITH', 'WARD'));
                 
**ANY, ALL
SMITH(800)나 WARD(1250) 두 사원의 급여중 아무 값보다 작은 급여를 받는 직원 조회
==> sal < 1250
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));

SMITH(800)나 WARD(1250) 두 사원의 급여 보다 많은 급여를 받는 직원 조회
==> sal > 1250
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));

IN 연산자의 부정
소속부서가 20, 혹은 30인 경우
WHERE deptno IN(20,30)

소속부서가 20, 혹은 30에 속하지 않는 경우
WHERE deptno NOT IN(20,30)

NOT IN 연산자를 사용할 경우 서브쿼리의 값에 NULL이 있는지 여부가 중요
==> NULL이 있을 경우 정상적으로 작동하지 않음

아래 쿼리가 조회하는 결과는 어떤 의미인가? 누군가의 메니저가 아닌 사람
NULL 값을 갖는 행을 제거
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT NULL); 
    
NULL처리 함수를 통해 쿼리에 영향이 가지 않는 값으로 치환
SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr, -1)
                    FROM emp);

단일 컬럼을 리턴하는 서브쿼리에 대한 연산 ==> 복수 컬럼을 리턴하는 서브쿼리
**PAIRWISE 연산 (순서쌍) ==> 동시에 만족 하는 거!!


SELECT ename, mgr, deptno
FROM emp
WHERE empno IN (7499, 7782); -- IN 연산자 안에 하나의 값만 와도 조회됨

7499, 7782 사번의 직원과 (같은 부서, 같은 매니저)인 모든 직원 정보 조회
매니저가 7698 이면서 소속부서가 30인 경우
매니저가 7839 이면서 소속부서가 10인 경우
이거는 (7698, 10)
      (7839, 30)


mgr 컬럼과 deptno 컬럼의 연관성이 없다
(mgr, deptno)
(7698, 10)
(7698, 30)
(7839, 10)
(7839, 30);
SELECT *
FROM emp
WHERE mgr IN (7698, 7839)
  AND deptno IN (10, 30);

PAIRWISE 적용 (위의 쿼리보다 결과가 한건 적다)
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN(7499, 7782));

서브쿼리 구분-사용위치
SELECT - 스칼라 서브 쿼리
FROM - 인라인 뷰
WHERE - 서브쿼리

서브쿼리 구분 - 반환하는 행, 컬럼의 수
단일 행
    단일 컬럼(스칼라 서브쿼리에서는 단일행 단일 컬럼만 가능하다)
    복수 컬럼
복수 행
    단일 컬럼(많이 쓰는 형태)
    복수 컬럼

스칼라 서브쿼리
SELCT 절에 표현되는 서브쿼리
단일행 단일 컬럼을 리턴하는 서브쿼리만 사용 가능
메인쿼리의 하나의 컬럼처럼 인식;

스칼라 서브쿼리에서 사용가능 하나의 쿼리와 하나의 컬럼
SELECT SYSDATE
FROM dual;

SELECT 'X', (SELECT SYSDATE FROM dual)
FROM dual;

스칼라 서브쿼리는 하나의 행, 하나의 컬럼을 반환 해야 한다

*행은 하나지만 컬럼이 2개여서 에러
SELECT 'X', (SELECT empno, ename FROM emp WHERE ename = 'SMITH')
FROM dual;

*다중행 하나의 컬럼을 리턴하는 스칼라 서브쿼리 ==> 에러
SELECT 'X', (SELECT empno, ename FROM emp)
FROM dual;

emp 테이블만 사용할 경우 해당 직원의 소속 부서 이름을 알 수가 없다 ==> 그래서 조인 활용
특정 부서의 부서 이름을 조회하는 쿼리
SELECT dname
FROM dept
WHERE deptno = 10;

위의 쿼리를 스칼라 서브쿼리로 변경

조인으로 구현
SELECT empno, ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

위의 쿼리를 스칼라 서브쿼리로 변경
SELECT empno, ename, emp.deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno) --, 부서이름
FROM emp; --상호연관 서브쿼리다|---------------------------------------------|

서브쿼리 구분- 메인쿼리의 컬럼을 서브쿼리에서 사용하는지 여부에 따른 구분
상호연관 서브쿼리 (corelated sub query) 
    .메인 쿼리가 실행 되어야 서브쿼리가 실행이 가능하다
    
비상호연관 서브쿼리 (non-corelated sub query)
    .main 쿼리의 테이블을 먼저 조회 할 수도 있고
     sub 쿼리의 테이블을 먼저 조회 할 수도 있다
     ==> 오라클이 판단 했을 때 성능상 유리한 방향으로 실행 방향을 결정

모든 직원의 급여평균 보다 많은 급여를 받는 직원 정보 조회하는 쿼리를 작성하세요 ( 서브쿼리 이용)
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
생각해볼 문제, 위의 쿼리는 상호 연관 서브 쿼리인가? 비상호 연관 서브쿼리인가?
 비상호 연관 쿼리이다 왜냐면 메인쿼리의 쿼리를 사용하지 않아서
 
 직원이 속한 부서의 급여 평균보다 많은 급여를 받는직원
 전체 직원의 급여 평균 ==> 직원이 속한 부서의 급여 평균
 특정부서(10) 의 급여 평균을 구하는 SQL
 
 SELECT AVG(sal)
 FROM emp
 WHERE deptno = 10;
 
 SELECT *
 FROM emp e
 WHERE sal > (SELECT AVG(sal)
              FROM emp
              WHERE deptno = e.deptno); 

SELECT *
FROM dept;

INSERT INTO dept VALUES (99, 'ddit', 'daejeon'); 행 넣는거

emp 테이블에 등록된 직원들은 10, 20, 30 번 부서에만 소속이 되어있음
직원 소속되지 않은 부서: 40,99

SELECT *
FROM dept
WHERE deptno NOT IN (10,20,30);

SELECT *
FROM dept
WHERE deptno IN (40,99);

SELECT *
FROM dept
WHERE deptno NOT IN(SELECT deptno 
                    FROM emp
                    WHERE emp.);
                    
서브쿼리를 이용하여 IN연산자를 통해 일치하는 값이 있는지 조사할 때 
값이 여러개 있어도 상관 없다(집합)
WHERE deptno IN (10,10,10);
WHERE deptno = 10,
   OR deptno = 10, 
   OR deptno = 10;

동일한 부서번호가 

sub 5]
SELECT *
FROM cycle c, product p
WHERE c.pid = p.pid NOT IN (SELECT *
                            FROM cycle c, product p);

SELECT *
FROM product
WHERE pid NOT IN 
        (SELECT pid
         FROM cycle
         WHERE cid = 1); 

SELECT p.pid, pnm
FROM product p
WHERE cid = 1 NOT IN (SELECT p.pid, pnm
                      FROM cycle, product);
              
 
sub 6]
SELECT *
FROM cycle
WHERE cid = 1 
  AND pid IN (SELECT pid
              FROM cycle
              WHERE cid = 2);
              
sub 7]          
***조인을 이용한 서브쿼리
!!!컬럼명 앞에 별칭 잘붙여!!!
 SELECT c.cid, cnm, cy.pid, pnm, day, cnt
 FROM customer c, cycle cy, product p
 WHERE c.cid = cy.cid
   AND cy.pid = p.pid
   AND c.cid = 1
   AND cy.pid IN (SELECT pid
                  FROM cycle
                  WHERE cid = 2);
                  
***스칼라 서브쿼리르 이용한 방법 - 서브쿼리만 6번 실행이 된다 (셀렉트절에 괄호) --조인을 이용하는게 더 선호하는 방법이다.
 SELECT cid, (SELECT cnm FROM customer WHERE cid = cycle.cid) cnm,
        pid, (SELECT pnm FROM product  WHERE pid = cycle.pid) pnm, day, cnt
 FROM cycle
 WHERE cid = 1
   AND pid IN (SELECT pid
               FROM cycle
               WHERE cid = 2);
 
 
 
 
 
























