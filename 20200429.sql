 OUTER JOIN
 테이블 연결 조건이 실패해도, 기준으로 삼은 테이블의 컬럼은 조회가 되도록 하는 조인 방식
 <-->
 INNER JOIN(우리가 지금까지 배운 방식)

 LEFT OUTER JOIN   : 기준이 되는 테이블이 JOIN 키워드 왼쪽에 위치
 RIGHT OUTER JOIN  : 기준이 되는 테이블이 JOIN 키워드 오른쪽에 위치
 FULL OUTER JOIN   : LEFT OUTER JOIN + RIGHT OUTER JOIN -(중복되는 데이터가 한건만 남도록 처리)
 
 emp테이블의 컬럼중 mgr컬럼을 통해 해당 직원의 관리자 정보를 찾아갈 수 있다.
 하지만 KING 직원의 경우 상급자가 없기 때문에 일반적인 inner 조인 처리시
 조인에 실패하기 때문에 KING을 제외한 13건의 데이터만 조회가 됨.
 
 INNER 조인 복습
 상급자 사번, 상급자 이름, 직원 사번, 직원 이름
 
 조인이 성공해야지만 데이터가 조회된다
 ==> KING의 상급자 정보(mgr)는 NULL 이기 때문에 조인에 실패하고 
     KING
 SELECT m.empno,m.ename, e.empno, e.ename 
 FROM emp e, emp m
 WHERE e.mgr = m.empno;
 
 ANSI
 SELECT m.empno,m.ename, e.empno, e.ename 
 FROM emp e JOIN emp m ON(e.mgr = m.empno);
 
 **위의 쿼리를 OUTER 조인으로 변경
 (KING 직원이 조인에 실패해도 본인 정보에 대해서는 나오도록, 하지만 상급자 정보는 없기 때문에 나오지 않는다.)
 ;
 
 *ANSI-SQL : OUTER
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno );
 
 테이블 조인키워드 테이블
 
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp m RIGHT OUTER JOIN emp e ON ( e.mgr = m.empno ); emp e 가 기준이 되라(RIGHT 니까 오른쪽이 기준) 
 
 *ORACLE-SQL : OUTER
 oracle join
 1. FROM절에 조인할 테이블 기술(콤마로 구분)
 2. WHERE절에 조인 조건을 기술
 3. 조인 컬럼(연결고리)중 조인이 실패하여 데이터가 없는 쪽의 컬럼에 (+)을 붙여준다
   ==> 마스터 테이블 반대편쪽 테이블의 컬럼
   
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e,emp m --emp e 가 마스터 테이블이니까 반대편쪽에 (+)를 붙임
 WHERE e.mgr = m.empno(+);
 
 OUTER 조인의 조건 기술 위치에 따른 결과 변화
 
 *직원의 상급자 이름, 아이디를 포함해서 조회
 단, 직원의 소속부서가 10번에 속하는 직원들만 한정해서;
 
 조건을 ON절에 기술했을때
 
 조인에 대한 조건을 
 SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
 FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno AND e.deptno = 10 );
 
 조건을 WHERE절에 기술했을때
 SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
 FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno )
 WHERE e.deptno = 10;
 
 **OUTER 조인을 하고 싶은 것이라면 조건을 ON절에 기술하는게 맞다
   WHERE 절에 기술해도되는데 OUTER조인의 효과가 없어진다 (INNER 조인으로 변환됨)
 
 ORACLE -SQL
 SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
 FROM emp e, emp m 
 WHERE e.mgr = m.empno(+)
   AND e.deptno = 10;
   
 @연습문제@
 
 SELECT *
 FROM buyprod
 WHERE buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');
 
 --어떤게 기준이 되는것은 요구사항에따라 달라진다
 --기준이되는 컬럼(master) 반대편에 (+)붙여줘야함 where절에 and로 줄이 계속 됬을때 해당되는 모든(마스터반대편) 컬럼에 ,,,
 SELECT b.buy_date, b.buy_prod, p.prod_id, P.prod_name, b.buy_qty
 FROM buyprod b, prod p
 WHERE b.buy_prod(+) = p.prod_id
   AND b.buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD'); 
   
 SELECT b.buy_date, b.buy_prod, p.prod_id, P.prod_name, b.buy_qty
 FROM buyprod b RIGHT OUTER JOIN prod p ON ( b.buy_prod = p.prod_id AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));  
 
 SELECT b.buy_date, b.buy_prod, p.prod_id, P.prod_name, b.buy_qty
 FROM prod p LEFT OUTER JOIN buyprod b ON ( b.buy_prod = p.prod_id AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));  
***위의 3가지 쿼리는 동일한 결과가 나온다***   
 
 OUTER JOIN 2]
 SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD')buy_date, b.buy_prod, p.prod_id, P.prod_name, b.buy_qty --select절에 그냥 상수로 놓을 수 있다
 FROM buyprod b, prod p
 WHERE b.buy_prod(+) = p.prod_id
   AND b.buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
   
 OUTER JOIN 3]
 
 SELECT NVL(b.buy_date,'05/01/25'), b.buy_prod, p.prod_id, P.prod_name, NVL(buy_qty, 0)
 FROM buyprod b, prod p
 WHERE b.buy_prod(+) = p.prod_id
   AND b.buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
   
 OUTER JOIN 4]
 
 SELECT p.pid, pnm, NVL(cid,1), NVL(day,0), NVL(cnt,0)
 FROM cycle c, product p
 WHERE c.pid(+) = p.pid
   AND cid(+) = 1; 
   
 --1을 널처리 안해도 밑에 쿼리처럼 표현하는게 더 나음
 SELECT p.pid, pnm, 1 cid, NVL(day,0), NVL(cnt,0)
 FROM cycle c, product p
 WHERE c.pid(+) = p.pid
   AND cid(+) = 1; 
   
 SELECT *
 FROM product p LEFT OUTER JOIN cycle c ON ( p.pid = c.pid
 WHERE;
 
 아우터 조인 오라클버전
 SELECT p.pid, pnm, 1 cid, NVL(day,0)day, NVL(cnt,0)cnt
 FROM cycle c, product p
 WHERE c.pid(+) = p.pid
 AND cid(+) = 1; 
 
 SELECT p.pid, pnm, 1 cid, NVL(day,0)day, NVL(cnt,0)cnt
 FROM 
    (SELECT p.pid, pnm, 1 cid, NVL(day,0)day, NVL(cnt,0)cnt
     FROM cycle c, product p
     WHERE c.pid(+) = p.pid
     AND cid(+) = 1),customer
 WHERE c.pid(+) = p.pid;
 
 SELECT product.pid, product.pnm, 1 cid, NVL(cycle.day, 0), NVL(cycle.cnt,0)cnt
 FROM product LEFT OUTER JOIN cycle ON (product.pid = cycle.pid AND cycle.cid=1)
                         JOIN customer ON (customer name = 'brown');
                         
 JOIN 5]
 
 SELECT *
 FROM cycle, product, customer
 WHERE 
                         
 SELECT m.empno,m.ename, e.empno, e.ename 
 FROM emp e, emp m
 WHERE e.mgr(+) = m.empno --아우터조인은 기준이되는 컬럼 반대편컬럼에(+)
 ORDER BY mgr;
 
 customer테이블을 추가하면
 45개
 앞에 두개만 하면 15개
 15 -> 45
 
 SELECT *
 FROM product, cycle, customer
 WHERE product.pid = cycle.pid;
 
 CROSS JOIN
 조인 조건을 기술하지 않은 경우
 모든 가능한 행의 조합으로 결과가 조회된다
 
 emp 14 * dept 4 = 56
 ANSI-SQL
 SELECT *
 FROM emp CROSS JOIN dept;
 
 ORACLE-SQL(조인테이블만 기술하고 where절에 조건을 기술하지 않는다.
 SELECT *
 FROM emp, dept;  
 
 crossjoin 1]
 SELECT cid, cnm, pid, pnm
 FROM customer, product;
      
 'TEST' 문자열 중요 "" 쌍따음표 아님
 
 서브쿼리(중요) -- 유지보수 하기에 용이
 WHERE : 조건을 만족하는 행만 조회 되도록 제한
 SELECT *
 FROM emp
 WHERE 1 = 1
    OR 1 != 1;
 
 서브 <==> 메인
 서브쿼리는 다른 쿼리 안에서 작성된 쿼리
 서브쿼리 가능한 위치 (3개의 절에)
 1.SELECT 절
    SCALAR SUB QUERY
    * 스칼라 서브쿼리는 조회되는 행이 1행이고, 컬럼이 한개의 컬럼이어야 한다
     EX) DUAL테이블
    
 2.FROM 절
    INLINE-VIEW
    SELECT 쿼리를 괄호로 묶은 것
    
 3.WHERE절
    SUB QUERY
    WHERE 절에 사용된 쿼리가 서브쿼리
    
    
SMITH가 속한 부서에 속한 직원들은 누가 있을까?

 1. SMITH가 속한 부서가 몇번이지??
 2. 1번에서 알아낸 부서번호에 속하는 직원을 조회
 
 ==> 독립적인 2개의 쿼리를 각각 실행
     두번째 쿼리는 첫번째의 쿼리의 결과에 따라 값을 다르게 가져와야 한다.
     (SMITH(20) => WARD(30) ==> 두번째 쿼리 작성시 20번에서 30번으로 조건을 변경 
      ==> 유지보수 측면에서 좋지)
 
 첫번째 쿼리;     
 SELECT deptno     --20
 FROM emp
 WHERE ename = 'SMITH'
 
 두번째 쿼리;
 SELECT *
 FROM emp
 WHERE deptno = 20;
 
 서브쿼리를 통한 쿼리 통합 
 SELECT *
 FROM emp
 WHERE deptno = (SELECT deptno     --20
                FROM emp
                WHERE ename = 'SMITH'); --WHERE 절 서브쿼리를 괄호로 묶어줘야함
 
 SELECT *
 FROM emp
 WHERE deptno = (SELECT deptno     --20
                FROM emp
                WHERE ename = :ename); -- :ename 을 해서 인라인뷰 화 할 수 있다,, 자바와 연결할때 
   
 
 
 SELECT ROUND(AVG(sal), 2)
 FROM emp;
 
 SUB 1]
 SELECT COUNT(*)
 FROM emp
 WHERE sal > (SELECT AVG(sal)
              FROM emp);

 SUB 2]
 SELECT *
 FROM emp
 WHERE sal > (SELECT AVG(sal)
              FROM emp);


 
 
 


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 