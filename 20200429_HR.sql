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
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno );
 
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp m RIGHT OUTER JOIN emp e ON ( e.mgr = m.empno ); emp e 가 기준이 되라(RIGHT 니까 오른쪽이 기준) 
 
 
 
 
 
 