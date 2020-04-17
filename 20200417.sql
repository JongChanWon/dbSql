
-- sal 값이 1000보다 크거나 같고, 2000보다 작거나 같은 직원만 조회 ==> BETWEEN AND 사용
-- 비교대상 컬럼 / 값 BETWEEN 시작값 AND 종료값
-- 시작값과 종료값의 위치를 바꾸면 정상 동작하지 않음

sal >= 1000 AND sal <= 2000

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

exclusive or (배타적 or)
a or b           :  a = true, b = true ==> true
a exclusive or b :  a = true, b = true ==> false

SELECT *
FROM emp
WHERE sal >= 1000 
  AND sal <= 2000;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101') AND TO_DATE('19830101');
-- 위 아래 똑같은 결과가 나온다.
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101') 
  AND hiredate <= TO_DATE('19830101');
  
IN 연산자
컬럼|특정값 IN (값1, 값2, ....)
컬럼이나 특정값이 괄호안에 값중에 하나라도 일치를 하면 TRUE

SELECT *
FROM emp
WHERE deptno IN (10, 30);
==> deptno 가 10이거나 30번인 직원
deptno = 10 OR deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
   OR deptno = 30;
   
SELECT *
FROM emp
WHERE deptno = 10
  AND deptno = 30; --두개를 만족
   







  
  
