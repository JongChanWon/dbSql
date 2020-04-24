NULL 처리 하는 방법 (4가지 중에 본인 편한걸로 하나 이상은 기억)
 NVL, NVL2...
 
 SELECT NVL(empno,0), ename, NVL(sal, 0), NVL(comm, 0) --이렇게 할 필요 없음
 FROM emp; 
 
 cnodition : CASE, DECODE
 
 실행계획 : 실행계획이 뭔지 보는 순서;
 
 SELECT empno, ename, job, deptno,
    DECODE(job,
           'SALESMAN', sal * 1.05
           'MANAGER', DECODE(deptno, 10, sal * 1.30, sal * 1.10),
           'PRESIDENT', sal * 1.20,
           sal) bo
           
 FROM emp;
 
 집합 A = {10, 15, 18, 23, 24, 25, 29, 30, 35, 37}
 소수 : {23, 29, 37}
 비소수: {10, 15, 18, 24, 25, 30, 35}
 
 
 GROUP FUNCTION
 여러행의 데이터를 이용하여 같은 그룹끼리 묶어 연산하는 함수
 여러행을 입력받아 하나의 행으로 결과가 묶인다
 EX: 부서별 급여 평균
     emp 테이블에는 14명의 직원이 있고, 14명의 직원은 3개의 부서(10, 20, 30) 에 속해 있다.
     부서별 급여 평균은 3개의 행으로 결과가 반환된다
     
 GROUP BY 적용시 주의사항: SELECT 기술할 수 있는 컬럼이 제한됨    
 SELECT 그룹핑 기준 컬럼, 그룹함수
 FROM 테이블
 GROUP BY 그룹핑 기준 컬럼
 [ORDER BY ];
 
 부서별로 가장 높은 급여 값
 
 SELECT deptno, MAX(sal)
 FROM emp
 GROUP BY deptno;
 
 group by 기준에 어긋나는 컬럼이 오면 실행이 안된다
 and 그룹함수가 쓰여지지 않으면 오류남
 SELECT deptno, sal
 FROM emp
 ORDER BY deptno, sal;
 
 
 emp 테이블의 그룹 기준을 부서번호가 아닌 전체 직원으로 설정 하는 방법
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
 
 * 그룹 함수를 통해 부서번호 별 가장 높은 급여를 구할 수는 있지만
   가장 높은 급여를 받는 사람의 이름을 알 수는 없다
     ==> 추후 WINDOW/분석 FUNCTION을 통해 해결 가능
     
 전체직원중 가장높은 급여값, 전체직원중 가장낮은 급여값, 전체직원의 급여평균, 전체 직원의 급여 합, 전체 직원의 급여 평균
 전체직원의 급여합, 전체 직원의 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
 전체 행의 수, mgr컬럼이 null이 아닌 건수 --PT에 나와있음
 
 2020.04.27 발표때 정답 확인
 GROUP BY 절에 기술된 컬럼이
    SELECT 절에 나오지 않으면 출력 된다(????)
    
 GROUP BY 절에 기술되지 않은 컬럼이(????)
    SELECT 절에 나오면 오류;
 
 --그룹화와 관련없는 임의의 문자열이나 상수등은 SELECT 절에 표현 될 수 있다(에러 아님)
 
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
 
 그룹함수에서 NULL 컬럼은 제외
 
 SELECT deptno
 FROM emp;
 
 GROUP 함수 연산시 NULL 값은 제외가 된다.
 30번 부서에는 NULL 값을 갖는 행이 있지만 SUM(comm) 의 값이 정상적으로 계산된 걸 확인 할 수 있다.
 SELECT deptno, SUM(comm)
 FROM emp
 GROUP BY deptno;
 
 10번, 20번 부서의 SUM(comm) 컬럼이 NULL이 아니라 0이 나오도록 NULL처리
 *특별한 사유가 아니면 그룹함수 계산결과에 NULL 처리를 하는 것이 성능상 유리
 
 NVL(SUM(comm), 0) : comm컬럼에 sum 그룹함수를 적용하고 최종 결과에 NVL을 적용(1회 호출) --이 표현이 더 나음
 SUM(NVL(comm, 0)) : 모든 comm 컬럼에 nvl 함수를 적용후(해당 그룹의 row수 만큼 호출) sum 그룹함수 적용
 
 SELECT deptno, SUM(NVL(comm, 0)), NVL(SUM(comm), 0)
 FROM emp
 GROUP BY deptno;
 
 single row 함수는 where 절에 기술 할 수 있지만
 multi row 함수(그룹함수) 는 where 절에 기술 할 수 없고
 GROUP BY 절 이후 HAVING 절에 별도로 기술
 
 SELECT *
 FROM emp
 WHERE LOWER(ename) = 'smith';
 
 부서급여가 9000이 넘는 부서
 SELECT deptno, SUM(sal)
 FROM emp
 WHERE SUM(sal) > 9000
 GROUP BY deptno;
 
 SELECT deptno, SUM(sal)
 FROM emp
 GROUP BY deptno
 HAVING SUM(sal) > 9000;
 
 GRP1]
 
 SELECT MAX(sal),
        MIN(sal),
        ROUND(AVG(sal), 2),
        SUM(sal),
        COUNT(sal),
        COUNT(mgr),
        COUNT(*)        
 FROM emp;

 
 grp2]
 
SELECT deptno,
        MAX(sal)max_sal,
        MIN(sal)min_sal,
        ROUND(AVG(sal), 2)avg_sal,
        SUM(sal)sum_sal,
        COUNT(sal)count_sal,
        COUNT(mgr)count_mgr,
        COUNT(*)count_all
 FROM emp
 GROUP BY deptno;
 
 grp3]
 
SELECT deptno,  DECODE(deptno, 10, 'ACCOUNTING',
                       20, 'RESEARCH',
                       30, 'SALES',
                       40, 'OPERATIONS')job,             
        MAX(sal)max_sal,
        MIN(sal)min_sal,
        ROUND(AVG(sal), 1)avg_sal,
        SUM(sal)sum_sal,
        COUNT(sal)count_sal,
        COUNT(mgr)count_mgr,
        COUNT(*)count_all
 FROM emp
 GROUP BY deptno;
 
 
 SELECT TO_CHAR(hiredate,'YYYYMM')HIRE_YYYYMM, COUNT(hiredate)cnt
 FROM emp
 GROUP BY TO_CHAR(hiredate,'YYYYMM')
 ORDER BY TO_CHAR(hiredate,'YYYYMM'); --하이어데이트 순으로 정렬
 
 
 
 SELECT TO_CHAR(hiredate,'YYYY')HIRE_YYYY, COUNT(hiredate)cnt
 FROM emp
 GROUP BY TO_CHAR(hiredate,'YYYY')
 ORDER BY TO_CHAR(hiredate,'YYYY');
 
 grp6]
 SELECT SUM(COUNT(deptno))cnt
 FROM dept
 GROUP BY deptno;
 
 SELECT COUNT(*)
 FROM dept;
 
 SELECT TO_CHAR(hiredate,'yyyy')cnt
 FROM emp
 GROUP BY deptno,hiredate;
 
 
 
 
 
 
 
 
 
 
 
 