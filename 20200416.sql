SELECT lprod_id, lprod_gu, lprod_nm --모든데이터면 *로 써도됨
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT cart_member, cart_no, cart_prod, cart_qty --모든데이터면 *로 써도됨
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

--SQL 연산 : JAVA와 다르게 대입 X, 일반적 사칙연산
--int b = 2;  = 대입 연산자, == 비교;

--SQL 데이터 타입 : 문자, 숫자, 날짜(date)

--USERS 테이블이 (4/14 만들어 놓음) 존재
--USERS 테이블의 모든 데이터를 조회;

--날짜 타입에 대한 연산 : 날짜는 +, - 연산 가능
--date type + 정수 : date 에서 정수 날짜만큼 미래 날짜로 이동
--date type - 정수 : date 에서 정수 날짜만큼 과거 날짜로 이동

SELECT userid, reg_dt + 5, reg_dt + 5 after_5days, reg_dt -5 --컬럼명을 after 5days 처럼 변경 할 수 있다.
FROM users;

-- ;
-- 컬럼 별칭 : 기존 컬럼명을 변경 하고 싶을 때
-- syntax : 기존 컬럼명 [as] 별칭명칭 (알리야스)
-- 별칭 명칭에 공백이 표현되어야 할 경우 더블 쿼테이션으로 묶는다.
--또한 오라클에서는 객체명을 대문자 처리 하기 때문에 소문자로 별칭을 지정하기 위해서도
--더블 쿼테이션을 사용한다.

SELECT userid as id, userid id2
FROM users;

SELECT prod_id id, prod_name name
FROM prod;

SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

SELECT buyer_id 바이어아이디, buyer_name 이름
FROM buyer;


--문자열 연산(결합연산) : || (문자열 결합은 + 연산자가 아니다) /*문자열은 싱글쿼테이션으로 표현함*/
SELECT /*userid + 'test'*/ userid || 'test', reg_dt + 5, 'test', 15
FROM users;

--경 이름 축
SELECT '경 ' || userid || ' 축'
FROM users;

--userid 컬럼이랑 usernm 컬럼이랑 합쳐서 보여달라 (||)
--concat(결합)
SELECT userid, usernm, userid || usernm as id_name,
        CONCAT(userid, usernm) as concat_id_name
FROM users;

SELECT '아이디 : ' || userid,
        '아이디 : ' || userid as "id userid"
FROM users;

--user_tables : oracle 관리하는 테이블 정보를 담고 있는 테이블(view라는 객체) ==> 통틀어서 data dictionary 라고 함
SELECT *
FROM user_tables;

SELECT 'SELECT * FROM ' || table_name || ';' as "query"
FROM user_tables;

SELECT CONCAT('SELECT * FROM') as concat_table_name 
FROM user_tables;

테이블의 구성 컬럼을 확인
1. tool(SQL developer)을 통해 확인
   테이블- 확인하고자 하는 테이블
2. SELECT *
   FROM 테이블
   일단 전체 조회 --> 모든 컬럼이 표시
3. DESC 테이블명
4. data dictionary : user_tab_columns

DESC emp;

SELECT *
FROM user_tab_columns;

지금까지 배운 SELECT 구문
조회하고자 하는 컬럼 기술 : SELECT
조회할 테이블 기술 : FROM
조회할 행을 제한하는 조건을 기술 : WHERE
WHERE 절에 기술한 조건이 참(True) 일 때 결과를 조회
java의 비교 연산 : a변수와 b변수의 값이 같은지 비교 ==
sql의 비교 연산: =

--WHERE 절에 꼭 컬럼명이 올 필요 없음
SELECT *
FROM users
WHERE userid = 'cony';

emp테이블의 컬럼과 데이터 타입을 확인;
DESC emp;

'1234', 1234
문자열 리터럴, 숫자 리터럴

SELECT *
FROM emp;

emp : emplyee
empno : 사원번호
ename : 사원이름
job : 직책
MGR : 담당자(관리자)
hiredate : 입사일자
sal : 급여
comm : 성과급
deptno : 부서번호

SELECT *
FROM dept;

emp테이블에서 직원이 속한 부서번호가 30번 보다 큰(>) 부서에 속한 직원을 조회;

SELECT *
FROM emp
WHERE deptno > 10;

users 테이블에서 사용자 아이디가 (userid) brown이 아닌 사용자를 조회

SELECT *
FROM users
WHERE userid != 'brown'; --쿼테이션이 안붙으면 컬럼이라고 생각함

SQL 리터럴
숫자 : ....20, 30.5 ~~~
문자 : 싱글 쿼테이션 : 'hello world'
날짜 : TO_DATE ('날짜문자열', '날짜 문자열의 형식');

1982년 1월 1일 이후에 입사한 직원만 조회
직원의 입사일자 : hiredate 컬럼
emp테이블의 직원 : 14명
1982년 1월1일 이후 입사자가: 3명
1982년 1월1일 이전 입사자가: 11명
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD'); --('1982/01/01', '1982/01/01) 문자열 형식만 맞춰서 작성하면됨

hiredate에서 년도 표기 방식은 tool 때문에 2자리수로 표기됨
이건 환경설정에서 4자리수로 변경 가능하다.


   
   