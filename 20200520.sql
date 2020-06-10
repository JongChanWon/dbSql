부서별 급여순위
실습 ana0

SELECT a.ename, a.sal, a.deptno, b.lv sal_rank
(SELECT ename, sal, deptno, ROWNUM rn
FROM
(SELECT ename, sal, deptno
 FROM emp
 ORDER BY deptno, sal desc))a;

쌤이푼거

SELECT
FROM
(SELECT lv, ROWNUM rn
FROM
(SELECT a.*, b.lv
 FROM
 (SELECT deptno, COUNT(*)cnt
  FROM emp
  GROUP BY deptno)a, (SELECT LEVEL lv
                      FROM dual
                      CONNECT BY LEVEL <= 6) b
 WHERE a.cnt >= lv
 ORDER BY a.deptno, b.lv))b;
 
 위의 복잡한 쿼리를 분석함수를 이요하여 간단히
 SELECT ename, sal, deptno, RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) sal_rank
 FROM emp;
 
 RANK 관련 함수 : RANK, DENSE_RANK, ROW_NUMBER
 RANK : 순위 구하기, 동일 값에 대해서는 동일한 순위를 부여하고 후순위는 +1 을 해준다
        1등이 3명이면 2등, 3등이 없고 그 후순위는 4등
 DENSE_RANK : 순위 구하기, 동일한 값에 대해서는 동일한 순위를 부여하고 후순위는 그대로유지
              1등이 3명이면 그다음 후순위는 2등
 ROW_NUMBER : 정렬순서대로 1부터 순차적인 값을 부여, 순위의 중복이 없다.
 
 SELECT ename, sal, deptno, 
        RANK() OVER(PARTITION BY deptno ORDER BY sal) sal_rank, 
        DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal) sal_dense_rank,
        ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal) sal_row_number
 FROM emp;
 
 실습 ana1]
 부서 별 랭크 ==> 전체 직원 대상 급여 랭크
 부서별 급여합 ==> GROUP BY deptno
 전체 직원의 급여 합 ==> X
 SELECT ename, sal, deptno,
        RANK() OVER( ORDER BY sal DESC, empno ASC) sal_rank, 
        DENSE_RANK() OVER( ORDER BY sal DESC, empno ASC) sal_dense_rank,
        ROW_NUMBER() OVER( ORDER BY sal DESC, empno ASC) sal_row_number
 FROM emp;
 
 실습 ana2]
 분석 함수를 사용하지 않고 기존 지식으로만 구현한 쿼리
 SELECT a.*, b.cnt
 FROM
 (SELECT empno, ename, deptno
 FROM emp) a,
  (SELECT deptno, COUNT(*) cnt
  FROM emp
  GROUP BY deptno) b
WHERE a.deptno = b.deptno
ORDER BY a.deptno, a.empno;
 
 분석함수 : 기존에 배운 집계함수(그룹함수) 5가지를 분석함수에서도 제공
 그룹함수 : SUM, MAX, MIN, AVG, COUNT
 
 SELECT empno, ename, deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
 FROM emp;
 
 ana2]
 SELECT empno, ename, sal, deptno, ROUND(AVG(sal) OVER (PARTITION BY deptno), 2) avg_sal
 FROM emp;
 
 ana3-4]
 SELECT empno, ename, sal, deptno, 
        MAX(sal) OVER (PARTITION BY deptno) max_sal,
        MIN(sal) OVER (PARTITION BY deptno) min_sal
 FROM emp;
 
 그룹내 행순서 : 
 LAG : 특정행의 이전 행을 가져옴
 LEAD : 특정행의 이후 행을 가져옴
 
 전체 직원 급여 랭킹에서 자신보다 급여 랭크가 한단계 낮은 사람의 급여 가져오기
 단, 급여가 같을 때는 입사일자가 빠른사람이 순위가 높은 것으로 계산
 SELECT empno, ename, hiredate, sal,
        LEAD(sal) OVER (ORDER BY sal DESC, hiredate ASC) lead_sal
 FROM emp
 ORDER BY sal DESC;
 
 SELECT empno, ename, hiredate, sal,
        LAG(sal) OVER(ORDER BY sal DESC, hiredate ASC) lag_sal
 FROM emp
 ORDER BY sal DESC;
 
 ana6]
 SELECT empno, ename, hiredate, job, sal,
        LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC, hiredate ASC) lag_sal
 FROM emp;
 
 no_ana3]
 SELECT a.empno, a.ename, a.sal, SUM(b.sal) c_sum
 FROM
 (SELECT a.*, ROWNUM rn 
  FROM
  (SELECT empno, ename, sal
   FROM emp
   ORDER BY sal) a) a,
 
 (SELECT a.*, ROWNUM rn 
  FROM
  (SELECT empno, ename, sal
   FROM emp
   ORDER BY sal) a) b
 WHERE a.rn >= b.rn
 GROUP BY a.empno, a.ename, a.sal
 ORDER BY a.sal ASC;
 
 그룹 내 행 순서 - WINDOWING
 SELECT empno, ename, deptno, sal, 
        SUM(sal) OVER(ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) C_SUM
 FROM emp;
 위아래는 같은 결과가 나오지만 위의 쿼리가 더 낫다(더 정확한 쿼리,,)
  SELECT empno, ename, deptno, sal, 
        SUM(sal) OVER(ORDER BY sal ROWS UNBOUNDED PRECEDING) C_SUM
 FROM emp;
 
 
 
 물리적 행 지정
 EX : ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
 현재 행 기준 앞뒤 한행씩
  SELECT empno, ename, deptno, sal, 
        SUM(sal) OVER(ORDER BY sal ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) C_SUM
 FROM emp;
 
 ana7]
 
 SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) C_SUM
 FROM emp;
 
 WINDOWING
 ROWS : 물리적 ROW 를 지칭
 RANGE : 논리적인 ROW 를 지칭
         같은 값을 같은 범위로 인식
 DEFAULT :
 SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) rows_sum,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal RANGE UNBOUNDED PRECEDING) C_SUM,
        SUM(sal) OVER (ORDER BY sal) default_1
 FROM emp;
 
 
 계층 누적합;
 SELECT sum(no_emp)
 FROM no_emp;
 
 SELECT LPAD(' ', (LEVEL-1)*4) || org_cd org_cd, total
 FROM
     (SELECT org_cd, parent_org_cd, lv, SUM(total) total
      FROM
        (SELECT a.*, SUM(no_emp_c) OVER (PARTITION BY gp ORDER BY rn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)total
          FROM
             (SELECT a.*, ROWNUM rn, lv + ROWNUM gp, 
                     COUNT(*) OVER (PARTITION BY org_cd)cnt,
                     no_emp / COUNT(*) OVER (PARTITION BY org_cd) no_emp_c
             FROM
                 (SELECT org_cd, parent_org_cd, no_emp,
                        CONNECT_BY_ISLEAF leaf, LEVEL lv
                  FROM no_emp
                  START WITH org_cd = 'XX회사'
                  CONNECT BY PRIOR org_cd = parent_org_cd) a
                 START WITH leaf = 1
             CONNECT BY PRIOR parent_org_cd = org_cd) a)
     GROUP BY org_cd, parent_org_cd, lv)    
 START WITH org_cd = 'XX회사'
 CONNECT BY PRIOR org_cd = parent_org_cd;
 
 
 DROP TABLE gis_dt;
CREATE TABLE gis_dt AS

5/20 -12 : 5/8~6/7
SELECT SYSDATE + ROUND(DBMS_RANDOM.value(-12, 18)) dt,
       '블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다 블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다' v1,
       '블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다 블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다' v2,
       '블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다 블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다' v3,
       '블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다 블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다' v4,
       '블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다 블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다' v5
FROM dual
CONNECT BY LEVEL <= 1000000;

CREATE INDEX idx_n_gis_dt_01 ON gis_dt (dt);
 
 dt 컬럼의 년월일 정보를 중복을 제거해서 조회하는 
 
 dt 컬럼에는 데이터가 5/8 ~ 6/7 에 해당하는 데이트 타입 자료가 저장되어 있는데
 5/1 ~ 5/31 에 해당하는 날짜(년월일) 를 중복없이 조회하고 싶다
 원하는 결과 : 5/8 ~ 5/31 최대 24개의 행을 조회하고 싶은 상황
 20200501~20200630 : 61개의 행만 나오게
 SELECT TO_CHAR(dt, 'YYYYMMDD'), COUNT(*)
 FROM gis_dt
 WHERE dt BETWEEN TO_DATE('20200508', 'YYYYMMDD') AND TO_DATE('20200531 23:59:59', 'YYYYMMDD HH24:MI:SS')
 GROUP BY TO_CHAR(dt, 'YYYYMMDD')
 ORDER BY dt desc;
 
 SELECT dt
 FROM gis_dt
 ORDER BY dt desc;
 
 
 1.EXISTS ==>
 
 우리가 원하는 답의 최대 행의 결과 : 24행 ==> 31개의 행이 최대 답
 SELECT TO_CHAR(d, 'YYYYMMDD')
 FROM
 (SELECT TO_DATE ('20200501', 'YYYYMMDD') + (LEVEL-1)d
  FROM dual
  CONNECT BY LEVEL <= 31)a
 WHERE EXISTS (SELECT 'X'
               FROM gis_dt
               WHERE dt BETWEEN TO_DATE(TO_CHAR(d, 'YYYYMMDD') || '00:00:00', 'YYYYMMDDHH24:MI:SS') AND
                                TO_DATE(TO_CHAR(d, 'YYYYMMDD') || '23:59:59', 'YYYYMMDDHH24:MI:SS'));
 
 
 