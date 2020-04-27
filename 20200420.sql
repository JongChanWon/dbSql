table 에는 조회/저장 순서가 없다.
==> ORDER BY 컬럼명 정렬방식, ....

참고*
ORDER BY 컬럼순서 index번호 로 정렬 가능
==> SELECT 컬럼의 순서가 바뀌거나, 컬럼 추가가 되면 원래 의도대로 동작하지 않을 가능성이 있음

SELECT의 3번째 컬럼을 기준으로 정렬
SELECT *
FROM emp
ORDER BY 3;

별칭으로 정렬
컬럼에다가 연산을 통해 새로운 컬럼을 만드는 경우
SAL * DEPTNO SAL_DEPT

SELECT empno, ename, sal, deptno, sal/deptno sal_dept
FROM emp
ORDER BY sal_dept;

orderby1]
SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc desc;

orderby2]

&& ==> AND
리터럴
    숫자: 숫자
    문자: '문자'
SELECT *
FROM emp
WHERE comm IS NOT NULL --NULL 비교는 결과값이 NULL 이기 때문에  굳이 안써도됨
  AND comm != 0
WHERE = empno > 7300 AND  sal > 2000
ORDER BY comm DESC, empno ASC ;

SELECT *
FROM emp
WHERE mgr IS NOT NULL -- =mgr !=0
ORDER BY job, empno DESC;

SELECT *
FROM emp
WHERE (deptno = 30
   OR deptno = 10) -- =deptno IN(10,30)
  AND sal > 1500
ORDER BY ename DESC;

페이징 처리를 하는 이유
1. 데이터가 너무 많아서
    . 한 화면에 담으면 사용성이 떨어진다
    . 성능면에서 느려진다

오라클에서 페이징 처리 방법 ==> ROWNUM


RONUM :SELECT 순서대로 1번부터 차례대로 번호를 부여해주는 특수 KEYWORD

EXPLAIN PLAN FOR
SELECT ROWNUM, empno, ename
FROM emp;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


SELECT 절에 *표기하고 콤마를 통해 
다른 표현(ex ROWNUM) 을 기술 할 경우
*(아스테리) 앞에 어떤 테이블에 대한건지 테이블 명칭/별칭을 기술해야한다.;
SELECT ROWNUM, emp.* --emp의 모든 컬럼을 조회
FROM emp e;  --이렇게 하면 오류가 나는데 그이유는 e로 이름을 부여 했기 때문에 SELECT에서도 e로 바꿔줘야한다.
같다
SELECT ROWNUM, e.* --emp의 모든 컬럼을 조회
FROM emp e;

페이징 처리를 위해 필요한 사항
1. 페이지 사이즈(10)
2. 데이터 정렬 기준 --중요

1-page: 1~10
2-page: 11~20 (11~14 까지 나온다 , 이유는 14까지 밖에 없어서)

1 페이지 페이징 쿼리
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

2 페이지 페이징 쿼리

SELECT ROWNUM, empno, ename
FROM emp
WHERE  ROWNUM BETWEEN 11 AND 20;

ROWNUM의 특징
1. ORACLE 에만 존재
    . 다른 DBMS의 경우 페이징 처리를 위한 별도의 키워드가 제공 (LIMIT)
2. 1번부터 순차적으로 읽는 경우만 가능
    RONUM BETWEEN 1 AND 10 ==> 1~10
    RONUM BETWEEN 11 AND 20 ==> 1~10을 SKIP 하고 11~20을 읽으려고 시도
    
WHERE 절에서 ROPWNUM을 사용할 경우 다음 형태
ROWNUM = 1;
ROWNUM BETWEEN 1 AND N;
ROWNUM <, <= N (1~N)

ROWNUM과 ORDER BY
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY empno;

SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

ROWNUM 은 ORDER BY 이전에 실행
SELECT -> ROWNUM -> ORDER BY;

SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;
ROWNUM의 실행순서에 의해 정렬이 된상태로 ROWNUM을 부여하려면 IN-LINE VIEW 를 사용해야 한다
** IN-LINE : 직접 기술을 했다

SELECT ROWNUM, a.*
FROM
(SELECT ROWNUM, a.*
FROM 
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a ) a)  -- 알리야스 라고 별칭을 지어줄 수 있다.
WHERE rn BETWEEN 1 + (:page -1) * :pageSize AND 20;

WHERE rn BETWEEN 11 AND 20;

1+(n-1)*10
WHERE rn BETWEEN 11 AND 20; 1PAGE
WHERE rn BETWEEN 21 AND 30; 2PAGE
WHERE rn BETWEEN 31 AND 40; 3PAGE
.
.
.
WHERE rn BETWEEN 1+(n-1)*10 AND pageSize * n ; n PAGE

sql 에서 변수를 표현할때 : 사용

SELECT ROWNUM, a.*
FROM
(SELECT ROWNUM rn, a.*
FROM 
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a ) a  -- 알리야스 라고 별칭을 지어줄 수 있다.
WHERE rn BETWEEN 1 + (:page -1) * :pageSize AND  :page * :pageSize;

복습
SELECT *
FROM
(SELECT empno, ename
 FROM emp
 ORDER BY ename);
 
 INLINE-VIEW 와 비교를 위해 VIEW를 직접 생성(선행학습, 나중에 나온다)
 VIEW - 쿼리 (view 테이블-X)
 
 DML - Data Manipulation Language  : SELECT, INSERT, UPDATE, DELETE
 DDL - Data Definition Language  : CREATE , DROP, MODIFY, RENAME
 
 
 CREATE OR REPLACE VIEW emp_ord_by_ename AS
    SELECT empno, ename
    FROM emp
    ORDER BY ename;
 
 IN-LINE VIEW 로 작성한 쿼리
 SELECT *
 FROM (SELECT EMPNO, ENAME
       FROM emp
       ORDER BY ename);
       
VIEW로 작성한 쿼리
SELECT *
FROM emp_ord_by_ename;

emp 테이블에 데이터를 추가하면
in-line view, view 를 사용한 쿼리의 결과는 어떻게 영향을 받을까???

쿼리 작성시 문제점 찾아가기

BUG ??? : 벌레
예전 컴퓨터 : 진공관
벌레가 진공관 사이에 끼어 오류를 발생 ==> 벌래를 없애는 과정(디버그)

java :디버깅
sql : 디버깅 툴이 없다 (절차가 없기 때문에)
       
페이징 처리 ==> 정렬, ROWNUM
정렬, ROWNUM을 하나의 쿼리에서 실행할 경우 ROWNUM  이후 정렬을 하여
숫자가 섞이는 현상 발생 ==> INLINE-VIEW 사용
  정렬에 대한 INLINE-VIEW
  ROWNUM에 대한 INLINE-VIEW
  
SELECT *
FROM
 (SELECT ROWNUM rn, b.*
 FROM
  (SELECT empno, ename --두가지 컬럼을 가지고 있는 테이블
   FROM emp
   ORDER BY ename) b )
WHERE rn BETWEEN 11 AND 20; 
--WHERE ROWNUM BETWEEN 11 AND 20; --1~10까지가 누락이 되서 실행 안됨 순차적으로 읽어야함
--그래서 프럼절을 한번더 감싸준다

SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM 
 (SELECT empno, ename
  FROM emp
  ORDER BY ename) a )
WHERE rn BETWEEN 11 AND 20;   

**신규문제
PROD 테이블을 PROD_LGU (내림차순), PROD_COST(오름차순) 으로 정렬하여
페이징 처리 쿼리를 작성 하세요
단 페이지 사이즈는 5
바인드 변수 사용할 것

SELECT *
FROM
 (SELECT ROWNUM rn, a.*
  FROM
   (SELECT *
   FROM PROD
   ORDER BY PROD_LGU DESC, PROD_COST) a )
WHERE rn BETWEEN (:page-1 )* :pageSize + 1 AND :page * :pageSize;

       WHERE rn BETWEEN 1 + (:page -1) * :pageSize AND  :page * :pageSize;
       
       
       
       



