 1.파일 시스템에 비해 데이터베이스 관리 시스템이 갖는 장점은~?
->사용자에게 보다 나은 서비스와 다양한 도구를 제공한다.
  표준화를 시행하기가 용이하다.
  다양한 요구 사항에 대해 우선순위를 매기고, 순서를 조절할 수 있다.
  
 2. 트렌젝션이란?
->  여러단계의 과정을 하나의 작업 행위로 묶는 단위
 *원자성: 트랜잭션 내의 작업이 실행되거나/ 안되거나 하는 데이터베이스 운용의 집합(All or Nothing)
 *일관성: 트랜잭션이 수행된 이후에는 데이터베이스에 일관성 있게 보존 되어야함(무결성 제약이 지켜져야한다)
 *격리성(독립성): 여러 트랜잭션이 동시에 실행 되도 각각의 트랜잭션은 서로 영향을 받지 않는다
 *지속성: 트랜잭션이 커밋된 이후에는, 해당 트랜잭션으로 변경된 모든 사항이 보존되어야한다.
 
 3. SQL을 배우는 이유
-> DBMS와 통신하기 위한 유일한 수단이기 때문에 DB와 통신을 하려면 SQL을 배워야한다.
 
 4. 다음 쿼리의 실행결과는?
 -> alias(별칭) 에는 싱글쿼테이션이 올 수 없으므로 밑의 쿼리는 오류가 발생한다
 SELECT 'TEST1' alias1,
        'TEST2' as alias2,
        'TEST3' as 'alias3'
 FROM dual;
 
 
 
 5. 밑에 예시의 실행결과는  TEST1X 이다,  
 SELECT 'TEST1' || dummy
    FROM dual;
 
 6. 다음 SQL은 정상동작하지만 문제가 있는 SQL이다. 문제점을 서술하고 수정해라.
  SELECT *
  FROM emp
  WHERE TO_CHAR(hiredate, 'YYYYMMDD')
        BETWEEN '19800101' AND '19821231';
  
  -> 개발자들이 하지 말아야 할 칠거지악중에 하나로, 좌변을 가공하면 안되는데
     좌변을 가공하였다. > WHERE hiredate >= TO_DATE('19800101','YYYYMMDD') 
                              hiredate <= TO_DATE('19821231','YYYYMMDD') 이렇게 고쳐야함.
 
 7. 다음 SQL을 실행했을 때 조회되는 행의 개수를 각각 구하고 3개의 값을 곱한 결과값을 기술
 첫번째 쿼리는 14행, 두번째 쿼리는 1행(X 1개 인행), 세번째 쿼리는 14행(참이거나 거짓이거나)
 모두 곱한값은 196 이다
 SELECT *
 FROM emp;
 
 SELECT *
 FROM dual;
 
 SELECT *
 FROM emp
 WHERE 1 = 1
    OR 1 != 1
        
 8. emp테이블의 모든컬럼을 기술하시오
 empno, ename, mgr, deptno, sal, job, hiredate, comm
 
 9. 다음  SQL을 IN연산자를 사용하지 않는 형태로 변경하시오.
 SELECT *
 FROM emp
 WHERE deptno IN (10, 20);
 -> 변경 후
 SELECT *
 FROM emp
 WHERE deptno 10
    OR deptno 20;
    
 10. emp 테이블에서 ename 컬럼의 값이 S로 시작하고, 중간에 T가 반드시 존재하며 
     H로 끝나는 이름을 갖거나 소속 부서번호(deptno)가 15번이 아닌 부서에 속하는 직원을 찾는
     SELECT 쿼리를 작성하시오
 SELECT *
 FROM emp
 WHERE ename LIKE 'S%T%H';
 
 11. 담당업무가 PRESIDENT 인 직원 KING 의 mgr 값은 NULL이다.
     14번에서 작성한 SQL을 실행할 경우 직원 직원KING은 몇번째 행에 위치하는지 적으시오
 SELECT *
 FROM emp
 ORDER BY mgr DESC
 -> 8행에 위치한다.
 
 12. 다음SQL이 의미하는 바는?
 SELECT *
 FROM emp
 ORDER BY name DESC, mgr;
 -> ename컬럼 기준으로 내림차순하고 mgr은 오름차순
 
 13. ROWNUM 이란? (특징 및 유의점) 서술
 -> SELECT QUERY에 의해 조회된 순서대로 부여된 가상 숫자 컬럼
    특징: 각 행에 순번을 적용할 수 있다.
   유의점: ROWNUM 이 있는절에는 WHERE절과, ORDER BY 절이 붙으면 안된다.
 
 14. emp 테이블에서 입사일자를 기준으로 페이징 처리를 하려고 한다. 페이지 사이즈가 7일때
     2페이지에 해당하는 SELECT 쿼리를 바인드 변수를 사용하여 작성하시오.
     (단, 입사일자가 같을 경우 직원의 이름을 오름차순 정렬한 순서로 우선순위를 부여)
 SELECT D
 FROM emp
 WHERE 
 
 15. 현재 일자가 속한 달의 마지막 일자에서 55일 뒤(미래)의 일자를 날짜 타입으로 구하는 
     쿼리를 작성하시오.
 SELECT LAST_DAY(SYSDATE) + 55
 FROM dual;   

    
      
      
      
      
      
      
      
      
      
      
      
      
      
        
 
 
 
 
 
 