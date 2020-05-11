부모-자식 테이블 관계

1. 테이블 생성시 순서
 1]부모 (dept)
 2]자식 (emp)
 
2. 데이터 생성시(insert) 순서
 1]부모 (dept)
 2]자식 (emp)
 
3. 데이터 삭제(delete) 순서
 1]자식 (emp)
 2]부모 (dept)



테이블 변경시(테이블이 이미 생성되어 있는 경우) 제약조건 추가 삭제

DROP TABLE emp_test;

CREATE TABLE emp_test(
 empno NUMBER(4),
 ename VARCHAR2(10),
 deptno NUMBER(2)
);

테이블 생성시 제약조건을 특별히 생성하지 않음

*테이블 변경을 통한 PRIMARY KEY 추가

문법 : ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건 타입 (적용할 컬럼[,](대괄호 안에 컬럼 여러개 올 수 있음));
제약조건 타입 : PRIMARY KEY, UNIQUE, FOREIGN KEY, CHECK


ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno); -- PRIMARY KEY 중복을 없애려고 씀(데이터 무결성)


*테이블 변경시 제약조건 삭제
문법 : ALTER TABLE 테이블 이름 DROP CONSTRAINT 제약조건명;

위에서 추가한 제약조건 pk_emp_test 삭제
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;


테이블 생성이후 외래키 제약조건 추가 실습
emp_test.deptno ==> dept_test.deptno

dept_test 테이블의 deptno에 인덱스 생성 되어있는지 확인

ALTER TABLE emp_test ADD CONSTRAINT 제약조건명 제약조건 타입 (컬럼) REFERENCES 참조테이블명 (참조테이블 컬럼명)

ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno);

삭제는 동일
ALTER TABLE emp_test DROP CONSTRAINT fk_emp_test_dept_test;


제약조건 활성화 비활성화
테이블에 설정된 제약조건을 삭제 하는 것이 아니라 잠시 기능을 끄고, 키는 설정
문법 : ALTER TABLE 테이블명 ENABLE | DISABLE CONSTRAINT 제약조건 명;


위에서 설정한 fk_emp_test_dept_test FOREIGN KEY 제약조건을 비활성화

ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test; -- 제약조건을 비활성화 시키는거!!


dept(부모) 테이블에는 99번 부서만 존재하는 상황
SELECT *
FROM emp_test;

fk_emp_test_dept_test 제약조건이 비활성화 되어 있기(위에서 비활성화 시킴) 때문에 emp_test 테이블에는 99번 부서 이외의
값이 입력 가능한 상황

dept_test 테이블에 88번 부서가 없지만 아래 쿼리는 정상적으로 실행
INSERT INTO emp_test VALUES (9999, 'brown', 88);


현재상황 : emp_test 테이블에 dept_test 테이블에 존재하지 않는 88번 부서를 사용하고 있는 상황
          fk_emp_test_dept_test 제약조건은 비활성화 된 상태
          
데이터의 무결성이 깨진 상태에서 fk_emp_test_dept_test 를 활성화 시키면???
ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;

실습)
emp, dept 테이블에는 현재 PRIMARY KEY, FOREIGN KEY 제약이 걸려 있지 않은 상황
emp 테이블은 empno 를 key 로
dept 테이블은 deptno 를 key 로 하는 PRIMARY KEY 제약을 추가하고

emp.deptno ==> dept.deptno 를 참조하도록 FOREIGN KEY 를 추가

제약조건 명은 수업시간에 안내한 방법으로 명명.

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);


제약조건 확인
툴에서 제공해주는 메뉴(테이블 선택 ==> 제약조건 tab)
USER_CONSTRAINTS : 제약조건 정보(MASTER);

USER_CONS_COLUMNS : 제약조건 컬럼 정보(상세);

SELECT *
FROM USER_CONSTRAINTS; (제약조건 검색)

컬럼확인
툴
SELECT *
DESC
USER_TAB_COLUMNS; (data dictionary, 오라클에서 내부적으로 관리하는 view);

SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'EMP';


테이블, 컬럼 주석: USER_TAB_COMMENTS, USER_COL_COMMENTS;

SELECT *
FROM user_tab_comments;

실제 서비스에서 사용되는 테이블의 수는 수십개로 끝나지 않는 경우가 많다.
테이블 명명 : 카테고리 + 일련번호

테이블에 주석 생성하기
문법 : COMMENT ON TABLE 테이블명 IS '주석';

emp테이블에 주석 생성하기
COMMENT ON TABLE emp IS '노예';

SELECT *
FROM USER_TAB_COMMENTS; 테이블 주석 확인

컬럼주석 확인
SELECT *
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';

컬럼주석 생성
COMMENT ON COLUMN 테이블명.컬럼명 IS '주석';

empno : 사번, ename : 이름, hiredate 입사일자 생성후 user_col_comments 를 통해 확인

COMMENT ON COLUMN emp.empno IS '사번';
COMMENT ON COLUMN emp.ename IS '이름';
COMMENT ON COLUMN emp.hiredate IS '입사일자';

SELECT *
FROM user_col_comments
WHERE table_name = 'EMP'; 내부적으로 대문자로 씀 ''안에 문자

COMMENT 1]

SELECT *
FROM USER_TAB_COMMENTS;

SELECT *
FROM USER_COL_COMMENTS;


SELECT t.*, C.column_name, C.comments col_comment
FROM user_tab_comments t, user_col_comments c
WHERE t.table_name = c.table_name
  AND t.table_name IN ('CUSTOMER', 'PRODUCT', 'CYCLE', 'DAILY');


View 는 쿼리다
논리적인 데이터 집합 = SQL
물리적인 데이터 집합이 아니다
view 가 참조하는 테이블을 수정하면 view에도 영향을 미친다

*일회성일때 인라인뷰
자주쓰는건 뷰

view 사용 용도
. 데이터 보안 (불필요한 컬럼 공개를 제한)
. 자주 사용하는 복잡한 쿼리 재사용
  . IN-LINE VIEW를 사용해도 동일한 결과를 만들어 낼 수 있으나
    MAIN 쿼리가 길어지는 단점이 있다.

view를 생성하기 위해서는 CREATE VIEW 권한을 갖고 있어야 한다 (DBA 설정)
SYSTEM 계정을 통해
GRANT CREATE VIEW TO 뷰생성권한을 부여할 계정명;

문법: CREATE [OR REPLACE] VIEW 뷰이름 [컬럼별칭1, 컬럼별칭2....] AS
        SELECT 쿼리;
        
  emp 테이블에서 sal, comm 컬럼을 제외한 6가지 컬럼만 조회가 가능한 v_emp view 를 생성
CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

view(v_emp 를 통한 데이터 조회)
SELECT *
FROM v_emp; -- sal, comm 빼고 조회

v_emp view 는 sem 계정 소유
HR 계정에게 인사 시스템 개발을 위해서 emp 테이블이 아닌 sal, comm 조회가 제한된
v_emp view 를 조회할 수 있도록 권한을 부여

[hr 계정에서 실행] 권한 부여전 hr 계정에서 v_emp 조회
SELECT *
FROM won.v_emp; --앞에 한정자 안붙이면 에러 ,,, 지금은 hr 계정이기 때문에

[won 계정에서 실행] won 계정에서 hr 계정으로 v_emp view 를 조회 할 수 있는 권한 부여
GRANT SELECT ON v_emp TO hr;

[hr 계정에서 실행]v_emp view  권한을 hr 계정에 부여한 이후 조회 테스트 --hr로 접속
SELECT *
FROM WON.v_emp;  

SELECT *
FROM WON.emp; -- emp는 없으니까 안나옴
  

실습]
v_emp_dept 뷰를 생성
emp, dept 테이블을 deptno컬럼으로 조인하고
emp.empno, ename, dept.deptno, dname 4개의 컬럼으로 구성

CREATE OR REPLACE VIEW v_emp_dept AS
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

SELECT *
FROM v_emp_dept;

조인된 쿼리도 view로 할 수 있다

view 삭제
문법: DROP VIEW 삭제할 뷰 이름;
EX) DROP VIEW v_emp;
  

view 를 통한 DML 처리
SIMPLE VIEW 일 때만 가능

SIMPLE VIEW : 조인되지 않고, 함수, GROUP BY, ROWNUM 을 사용하지 않은 간단한 형태의 VIEW
COMPLEX VIEW: SIMPLE VIEW가 아닌형태

v_emp : simple view

SELECT *
FROM v_emp;

v_emp를 통해 7369 SMITH 사원의 이름을 brown 으로 변경
UPDATE v_emp SET ename = 'Brown'
WHERE empno = 7369;

SELECT *
FROM emp;

v_emp 컬럼에는 sal 컬럼이 존재하지 않기 때문에 에러
UPDATE v_emp SET sal = 1000
WHERE empno = 7369;

ROLLBACK;


SEQUENCE
유일한 정수값을 생성해주는 오라클 객체
인조식별자 값을 생성할 대 주로 사용

식별자 ==> 해당 행을 유일하게 구별할 수 있는 값
 본질 <==> 인조 식별자

본질: 원래 그러한것.
인조: 꾸며낸것

일반적으로 어떤 테이블(엔터티) 의 식별자를 정하는 방법은
[누가], [언제], [무엇을]

게시판의 게시글 : 게시글 작성자가 언제 어떤글을 작성 했는지
게시글의 식별자 : 작성자id, 작성일지, 글제목
    ==> 본질 식별자가 너무 복잡하기 때문에 개발의 용이성을 위해 
        본질 식별자를 대체할 수 있는
        
    
    
    
개발을 하다보면 유일한 값을 생성해야할 때가 생김
ex : 사번, 학번, 게시글 번호 ...
     사번, 학번 : 체계가 있다
     사번 : 15101001 - 회사 설립년차 15년, 10월 10일, 해당 날짜에 첫번째 입사한 사람 01
     학번 : 
     
     체계가 있는 경우는 자동화 되기 보다는 사람의 손을 타는 경우가 많음
     
     게시글 번호 : 체계가...읍써, 겹치지 않는 순번을 가져다 씀
     체계가 없는 경우는 자동화가 가능 ==> 이럴때 SEQUENCE 객체를 활용해서 손쉽게 구현 가능
                                        ==> 중복되지 않는 정수 값을 반환
     
중복되지 않는 값을 생성하는 방법
1. KEY table을 생성
   ==> SELECT FOR UPDATE 를 통해 다른사람이 동시에 사용하지 못하도록 막는게 가능
   ==> 손이 많이 가는 편, 하지만 값을 이쁘게 유지하는게 가능(SEQUENCE 에서는 불가능)
   
2. JAVA 의 UUID 클래스를 활용, 별도의 라이브러리 활용(유료) ==> 금융권, 보험, 카드사...
    ==> jsp 게시판 개발
    
3. ORACLE DB - SEQUENCE
     
     
     
SEQUENCE 생성
문법 : CREATE SEQUENCE 시퀀스 명;
   
seq_emp라는 시쿼스를 생성
CREATE SEQUENCE seq_emp;

사용법: 객체에서 제공해주는 함수를 통해서 값을 받아온다
NEXTVAL ( NEXT VALUE ) : 시퀀스를 통해 새로운 값을 받아온다
CURRVAL : 시퀀스 객체의 NEXTVAL 를 통해 얻어온 값을 다시 확인할 때 사용
          (트랜잭션에서  NEXTVAL 실행하고 나서 사용이 가능)
          
SELECT seq_emp.NEXTVAL
FROM dual; --순차적으로 증가하는 정수값을 추출
     
SELECT seq_emp.CURRVAL
FROM dual;     
     
SEQUENCE 를 통한 중복되지 않는  empno 값 생성 하여 insert 하기

INSERT INTO emp_test VALUES (seq_emp.CURRVAL, 'MAMA', 88);

SELECT *
FROM emp_test;

SEQUENCE 수정 / 삭제
ALTER SEQUENCE sequence_name
DROP SEQUENCE











