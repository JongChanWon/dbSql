GROUP FUNCTION(그룹함수)
 -여러행의 데이터를 이용하여 같은 그룹끼리 묶어 연산하는 함수
 여러행을 입력받아 하나의 행으로 결과가 묶인다
 
 desc emp; 컬럼정보를 조회
  EX: 부서별 급여 평균
     emp 테이블에는 14명의 직원이 있고, 14명의 직원은 3개의 부서(10, 20, 30) 에 속해 있다.
     부서별 급여 평균은 3개의 행으로 결과가 반환된다
     
     그룹함수에는 MAX(),MIN() SUM() COUNT() COUNT(*) 함수가 있다.
EX)
 그룹화 되지 않은 컬럼이 셀렉트 절에는 올수 없지만 그룹함수로 묶으면 셀렉트 절에 올 수 있따.
   SELECT deptno, MIN(sal), --select절에서 deptno 를 빼는 것은 괜찮음 다만 group by 에 묶이지 않은 컬럼이 오면 안됨
        MAX(sal), --부서별로 가장 높은 급여 값
        MIN(sal), --부서별로 가장 낮은 급여 값
        ROUND(AVG(sal), 2), --부서별 급여 평균
        SUM(sal), --부서별 급여 합계
        COUNT(sal), --부서별 급여 건수(sal 컬럼의 값이 null 이 아닌 row의 수)
        COUNT(*),    --부서별 행의 수
        COUNT(mgr)
 FROM emp
 GROUP BY deptno;
 
 근데 여기서 그룹화가 되어있지 않은 컬럼이 SELECT 절에 올순 없지만 그룹화와 관련없는 문자열이나 상수등은 올 수 있따.
 SELECT deptno, MIN(sal), 'TEST', 1, --select절에서 deptno 를 빼는 것은 괜찮음 다만 group by 에 묶이지 않은 컬럼이 오면 안됨
        MAX(sal), --부서별로 가장 높은 급여 값
        MIN(sal), --부서별로 가장 낮은 급여 값
        ROUND(AVG(sal), 2), --부서별 급여 평균
        SUM(sal), --부서별 급여 합계
        COUNT(sal), --부서별 급여 건수(sal 컬럼의 값이 null 이 아닌 row의 수)
        COUNT(*),    --부서별 행의 수
        COUNT(mgr)
 FROM emp
 GROUP BY deptno;
 
 **그룹함수가 계산된후에 nvl적용 하는게 성능적으로 좋다
 *GROUP 함수 연산시 NULL 값은 제외가 된다.
 30번 부서에는 NULL 값을 갖는 행이 있지만 SUM(comm) 의 값이 정상적으로 계산된 걸 확인 할 수 있다.
 
예) SELECT deptno, SUM(comm)
    FROM emp
    GROUP BY deptno;
 
 **HAVING 절
 single row 함수는 where 절에 기술 할 수 있지만
 multi row 함수(그룹함수) 는 where 절에 기술 할 수 없고
 GROUP BY 절 이후 HAVING 절에 조건을 별도로 기술
 
 셀러리가 9000이상인 것을 조회할때
 SELECT deptno, SUM(sal)
 FROM emp
 GROUP BY deptno
 HAVING SUM(sal) > 9000;
 
 
 