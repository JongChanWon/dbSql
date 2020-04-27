
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
WHERE deptno IN (10,30);
==> deptno 가 10이거나 30번인 직원
deptno = 10 OR deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
   OR deptno = 30;
   
SELECT *
FROM emp
WHERE deptno = 10
<<<<<<< Updated upstream
  AND deptno = 30; --두개를 만족
  AND deptno = 30; --두개를 만족하는게 없어서 아무것도 나오지 않는다.
  
SELECT userid  "아이디", usernm as "이름", alias as "별명"
FROM users
WHERE userid IN ('brown', 'cony', 'sally');
    -- alias, where절 문자열 등 사용
   
*문자열 매칭 연산 : LIKE 연산 / JAVA 에서는 : .startsWith(prefix), .endsWith(suffix)
마스킹 문자열 % - 모든 문자열(공백 포함)
            _ - 어떤 문자열이든지 딱 하나의 문자 
문자열의 일부가 맞으면 TRUE

컬럼|특정값 LIKE 패턴 문자열;

'cony' : cony인 문자열
'co%'  : 문자열이 co 로 시작하고 뒤에는 어떤 문자열이든 올 수 있는 문자열
         ex) 'cony', 'con', 'co'
'co_'  : co를 포함하는 문자열
         ex) 'cony', 'sally cony'
'co__' : co로 시작하고 뒤에 두개의 문자가 오는 문자열 --언더바 두개
'_on_' : 가운데 두글자가 on이고 앞뒤로 어떤 문자열 이든지 하나의 문자가 올 수 있는 문자열

SELECT *
FROM emp
WHERE ename LIKE '_MI%';

웨어절에 컬럼명 쓰고 LIKE '_%문자열%_'; 이온다

직원 이름(ename) 이 대문자 S로 시작하는 직원만 조회
SELECT ename
FROM emp
WHERE ename LIKE 'S%';

SELECT *
FROM users
WHERE userid LIKE 'b%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

'이'라고하는 글자가 다 들어가 있는 사람 조회
SELECT mem_id,  mem_name
FROM member
WHERE mem_name LIKE '%이%';

NULL 비교
SQL 비교연산자 : =
  WHERE usernm = 'brown'
  
*MGR컬럼 값이 없는 모든 직원을 조회
SELECT * 
FROM emp
WHERE mgr IS NULL;

SELECT *
FROM emp
WHERE comm IS NOT NULL;

값이 있는 상황에서 등가비교 : =, (!=, <>)
NULL : IS NULL, IS NOT NULL -- 키워드

*emp 테이블에서 mgr 컬럼 값이 NULL 이 아닌 직원을 조회
SELECT * 
FROM emp
WHERE mgr IS NOT NULL;

SQL 에서 NULL 값을 비교할 경우 일반적인 비교연산자(=)를 사용 못하고 IS 연산자를 사용
 
*커미션이 있는 사람들 조회
SELECT *
FROM emp
WHERE comm IS NOT NULL;

SELECT * 
FROM emp
WHERE mgr = 7698
  AND sal > 1000;
  
SELECT * 
FROM emp
WHERE mgr = 7698
  OR sal > 1000;
  
  IN 연산자를 비교 연산자로 변경
SELECT * 
FROM emp
WHERE mgr IN (7698, 7839);
==> WHERE mgr = 7698 OR mgr = 7839

SELECT * 
FROM emp
WHERE mgr NOT IN (7698, 7839);     
==> WHERE mgr != 7698 AND mgr != 7839 --7698 7839가 아닌것

SELECT * 
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL);  --NULL은 equal 로 비교가 안됨

SELECT *
FROM emp
WHERE mgr NOT IN(7698, NULL); --NULL은 IN, NOT IN 구문에서 비교가 안됨

SELECT * 
FROM emp
WHERE mgr NOT IN (7698, 7839)
   OR mgr IS NULL; --NULL 값을 비교 할 때 따로 빼줘야함

SELECT * --잡이 세일즈맨이고 하이어데이트가 1981/06/01 보다 크고 셀러리가 1300보다 큰 사람들
FROM emp
WHERE job = 'SALESMAN'  -- 데이터에서는 대소문자를 따진다.
  AND hiredate >= TO_DATE(19810601) 
  AND sal > 1300;
  
SELECT *
FROM emp
WHERE job IN ('SALESMAN') == job = 'SALESMAN';
where 8]
*부서가 10이 아니고 81년 6월 1일 이후 입사자 (not in 쓰지말고)
SELECT *
FROM emp
WHERE deptNo != 10
  AND hiredate >= TO_DATE(19810601);

where 9]
*부서가 10이 아니고 81년 6월 1일 이후 입사자 (not in 쓰고)  
SELECT *
FROM emp
WHERE deptno NOT IN(10)
  AND hiredate >= TO_DATE(19810601);
  
SELECT *
FROM emp
WHERE deptNo IN (10,20,30)
  AND deptNo !=10
  AND hiredate >= TO_DATE(19810601);
  
where 10]
SELECT *
FROM emp
WHERE deptNo IN (20,30)
  AND hiredate >= TO_DATE(19810601);

where 11]
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR hiredate >= TO_DATE(19810601)
   AND job LIKE 'C%'
ORDER BY job DESC, sal;
   
 세일즈맨이면서 6월1일 이상이고  c로 시작하는 데이터 순으로 내림차순
where 12]

EXPLAIN PLAN FOR;
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
   OR EMPNO LIKE '78__';  --타입이 number타입인데 문자로 표현했다,, 자동형변환이 이루어짐
 SELECT *
 FROM TABLE(DBMS_XPLAN.DISPLAY);
   
where 13] -- DESC 디s스크라이브명령
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
   OR EMPNO >= 7800 AND empno < 7900;

-- AND, OR 우선순위 주의!! AND가 먼저
where 14]
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
   OR (EMPNO >= 7800 AND empno < 7900)
  AND hiredate >= TO_DATE(19810601);

where 15]
SELECT *
FROM emp
WHERE job = 'SALESMAN';


집합: {a,b,c} == {a,c,b}
table 에는 조회, 저장시 순서가 없어(보장하지 않음)
==> 수학시간의 집합과 유사한 개념

SQL 에서는 데이터를 정렬하려면 별도의 구문이 필요하다.
ORDER BY 컬럼명[정렬형태], 컬럼명2[정렬형태], ... --정렬형태 생략 가능
정렬의 형태 : 오름차순(DEFAULT)- ASC(오름차순은 기본이라 안해도됨), 내림차순 - DESC

ORDER BY 를 쓸 때 주의할점은 정렬시키는 열의 기입 순서에 따라서 결과가 다르게 나올 수 있다.
이는 각 열을 정렬 할 때, 어떤 열을 먼저 정렬하느냐로 결정된다.

여기서 Tip으로 한가지 더 소개 할 수 있는데 위에서 계속 반복되는 열 이름이 귀찮을 것이다. 
이때 ORDER BY 뒤에 숫자로 표시해도 된다.
이 숫자는 SELECT 뒤에 기입된 열 위치이다

직원 이름으로 오름차순 정렬
SELECT ename, job, mgr
FROM emp
ORDER BY 3,1;

select절에서 기입한 순서대로 order by 에서 숫자로 쓸 수 있다
ex) ename이 첫번째 이므로 order by 에 숫자로 1을 쓸 수 있다
    job 이 첫번째면 1은 job이 된다



직원 이름으로 내림차순 정렬
SELECT *
FROM emp
ORDER BY ename DESC;

*job을 기준으로 오름차순 정렬하고 job이 같을 경우 입사일자로 내림차순 정렬
모든 데이터 조회
SELECT *
FROM emp
ORDER BY job ASC, hiredate desc;
>>>>>>> Stashed changes
  
  
