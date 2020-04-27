**DBMS 와 RDBMS 는 거의 유사하다
DBMS : DataBase Management System
-> DB
RDBMS : Relational DataBase Management System
-> 관계형 데이터베이스 관리 시스템

JOIN 문법의 종류
ANSI - 표준
벤더사의 문법(ORACLE) --벤더사마다 문법이 조금씩 다르다

JOIN의 경우 다른 테이블의 컬럼을 사용할 수 있기 때문에
SELECT 할 수 있는 컬럼의 개수가 많아진다(가로확장)

집합연산 -> 세로확장 (행이 많아진다);


select *
from emp;

select *
from dept;

NATURAL JOIN 
    . 조인하려는 두 테이블의 연결고리 컬럼의 이름이 같을 경우
     -> emp, dept 테이블에는 detpno 라는 공통된(동일한 이름, 타입도 동일) 연결고리 컬럼이 존재 --이럴때 사용하는게 네츄럴조인
    . 다른  ANSI-SQL 문법을 통해서 대체가 가능하고, 조인 테이블들의 컬럼명이 동일하지 않으면
      사용이 불가능하기 때문에 사용 빈도는 다소 낮다
.emp 테이블: 14건
.dept 테이블: 4건
FROM 절에 테이블명이 여러개 올 수 있다.
조인 하려고 하는 컬럼을 별도 기술하지 않음
 SELECT *  --두테이블의 이름이 동일한 컬럼으로 연결
 FROM emp NATURAL JOIN dept; --네츄럴조인을 통해서 연결고뤼, 컬럼이 가로로 확장
 
 ORACLE 조인 문법을 ANSI 문법처럼 세분화 하지 않음
 오라클 조인 문법
  1. 조인할 테이블 목록을 FROM 절에 기술하며 구분자는 콜론(,)
  2. 연결고리 조건을 WHERE 절에 기술하면 된다. EX) WHERE emp.deptno = dept.deptno --where절에 연결할 조건을 기술
  
  SELECT *
  FROM emp, dept
  WHERE deptno = deptno;
  --이렇게 하면 오류가 나는데 deptno가 어디에 속한 부서인지 몰라서
  
  SELECT *
  FROM emp, dept
  WHERE emp.deptno = dept.deptno;
  --그래서 특정 컬럼명을 앞에 기술한다.
  
  deptno가 10번인 직원들만 dept 테이블과 조인 하여 조회
  
  SELECT *
  FROM emp, dept
  WHERE emp.deptno = dept.deptno
    AND emp.deptno = 10
    AND dept.deptno = 10;  -- AND 뒤에 나오는 조건절은 둘다 똑같은 결과를 가져온다
  
  ANSI-SQL : JOIN with USING(덜씀)
  . join 하려는 테이블간 이름이 같은 컬럼이 2개 이상일 때
  . 개발자가 하나의 컬럼으로만 조인하고 싶을 때 조인 컬럼명을 기술
  
  --네츄럴 조인이랑 동일
 SELECT *
 FROM emp JOIN dept USING(deptno);
  
 ANSI-SQL : JOIN with ON (많이씀) 
 . 조인 하려는 두 테이블간 컬럼명이 다를 때
 .ON 절에 연결고리 조건을 기술
 
 SELECT *
 FROM emp JOIN dept ON (emp.deptno = dept.deptno);
 
 
 ORACLE 문법으로 위 SQL을 작성
 SELECT *
 FROM emp, dept
 WHERE emp.deptno = dept.deptno ; --오라클 문법으로 하면 위의 ANSI 문법들을 이 한 문법으로 기술 할 수 있음
 
 
 JOIN의 논리적인 구분
 SELF JOIN : 조인하려는 테이블이 서로 같을 때
 EMP 테이블의 한행은 직원의 정보를 나타내고 직원의 정보중 mgr 컬럼은 해당 직원의 관리자 사번을 관리할때
 해당 직원의 관리자의 이름을 알고싶으면 
 
 ANSI-SQL로 SQL 조인: 
 조인하려고 하는 테이블 EMP(직원), EMP(직원의 관리자)
               연결고리 컬럼: 직원.MGR = 관리자.EMPNO 로 조인을 하면됨
               -> 조인 컬럼 이름이 다르다(MGR, EMPNO)
                 -> NATURAL JOIN, JOIN WITH USING(조인하려는 컬럼명이 같을때 사용) 은 사용이 불가능한 형태
                    -> JOIN with ON 으로 작성할 수 박에 없다 (조인하려는 컬럼명이 달라서)
 
 ANSI-SQL로 작성
 
 테이블명에도 별칭을 지정 해줄 수 있다.
 SELECT * 
 FROM emp e JOIN emp m ON (e.mgr = m.empno); --킹이 없기 때문에 13건(킹 위로 없어서)
 똑같은 컬럼이라서 알리야스로 명명
 

 NONEQUI JOIN : 연결고리 조건이 =이 아닐때
            
 
 WHERE 절에서 사용한 연산자 : =, !=, <>, <=,<,>, >=
                           AND, OR, NOT
                           LIKE %, _
                           OR - IN
                           BETWEEN AND -> >=,<=
 
 SELECT *
 FROM emp;
 
 SELECT *
 FROM salgrade;
 
 SELECT emp.empno,emp.ename, emp.sal, salgrade.grade
 FROM emp JOIN salgrade ON ( emp.sal BETWEEN salgrade.losal AND salgrade.hisal );
 
 
  oracle 조인 문법으로 변경
  
  SELECT *
  FROM emp, salgrade
  WHERE emp.sal <= salgrade.losal and salgrade.hisal<= emp.sal;
  
join 0]

emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리작성

SELECT empno, ename, a.deptno, dname
FROM emp a, dept b
WHERE a.deptno = b.deptno
  AND a.deptno NOT IN(20);


  
SELECT empno, ename, b.deptno
FROM emp a JOIN deptno b ON (emp.;

SELECT * 
 FROM emp e JOIN emp m ON (e.mgr = m.empno);

SELECT empno, ename, a.deptno, dname
FROM emp a, dept b
WHERE a.deptno = b.deptno
  AND a.deptno IN (10,30);  
 
 join0_2]
 SELECT empno, ename, sal, a.deptno,dname
 FROM emp a, deptno b
 WHERE a.deptno = b.deptno
   AND sal>2500
 ORDER BY sal desc;
 
 SELECT empno, ename, emp.deptno, dname 
 FROM emp, dept
 WHERE emp.deptno != dept.deptno;
 
 join1] 과제;
 SELECT prod_id, 
 FROM prod;
 WHERE  
 
 
 
 
 join 3~4 번, 데이터 결합 join1번 풀기
 
 
 