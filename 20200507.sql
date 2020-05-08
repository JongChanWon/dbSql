I-
4건조회
SELECT *
FROM dept;

5건 조회
INSERT INTO dept VALUES (99,'ddit','daejeon');

view는 쿼리다
ddl- > drop- data 삭제 (rollback 안됨)

SELECT *
FROM ranger;

DDL : DATA Definition Language
데이터를 정의하는 언어
CREATE, DROP, ALTER
DELETE 나 INSERT 같은거는 ROLLBACK 의 기회가 한번 있지만
****DDL의 경우는 자동 커밋(ROLLBACK 불가)****

name CHAR(10)
'test' 이면 'test     ' 가 된다

name CHAR(10)
테이블 삭제
구문: DROP TABLE 삭제할 테이블 명;

ranger 테이블 삭제
DROP TABLE ranger;

ROLLBACK;

SELECT *
FROM ranger;
drop
TABLE 생성
문법
CREATE TABLE [계정명].테이블명(
    컬럼명1 컬럼타입 DEFAULT 설정할 기본값,
    컬럼명2 컬럼타입,....
    
    컬럼명3 컬럽타입 마지막은 콤마 뺌
);
CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE);
ROLLBACK;
ranger 테이블을 다음과 같은 컬럼으로 생성
ranger_no 컬럼은 NUMBER 타입으로
ranger_nm 컬럼은 VARCHAR2(50) 타입으로
reg_dt 컬럼은 DATE 타입으로 (단 기본값은 입력 당시의 서버의 현재 시간)

CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE DEFAULT SYSDATE);
DROP TABLE ranger;

INSERT INTO ranger (ranger_no, ranger_nm) VALUES (1, 'brown');
ROLLBACK;
    
SELECT *
FROM ranger;

ranger_no 1
ranger_nm 'brown'

INSERT INTO ranger (ranger_no, ranger_nm, reg_dt) VALUES (1, 'brown', '20/05/01');
reg_dt 컬럼은 값을 별도로 입력하지 않았지만 테이블 설정에 의해 
기본값 SYSDATE 가 입력된다.

check
member 테이블 성별이라는 컬럼이 있을때
성별 컬럼에 들어 갈 수 있는 값: 남성, 여성, 남여 --여기서 숫자가 들어가면 안됨
그래서 check 가 제한해준다


제약조건: 데이터의 무결성을 지키기 위한 설정
총 4가지 제약조건이 존재
    UNIQUE: 설정한 컬럼의 값이 다른행의 값과 중복되지 않도록 제약
            ex) 사번, 학번
    PRIMARY KEY: UNIQUE 제약 + NOT NULL CHECK 제약
            값이 유일해야 하며, 값이 반드시 들어와야 하는 컬럼
            ex) 사번, 학번
    FOREIGN KEY: 해당 컬럼이 참조하는 테이블의 값이 존재하는지 확인하는 제약
            ex) emp테이블에 신규사원을 등록시 deptno 값은 dept 테이블에 반드시
                존재하는 값만 등록이 가능하다
    CHECK: 컬럼에 입력되는 값을 개발자가 정한 로직에 의해 체크, 검증 하는 제약
            ex) 성별 컬럼에 값은 F, M 두개의 값만 들어갈 수 있도록 설정
            
제약조건을 생성하는 방법
1. 테이블 생성시 컬럼 옆에다가 해당 컬럼에 적용될 제약조건을 기술
    ==> 복합컬럼 설정이 불가
2. 테이블 생성시 컬럼 기술과 별도로 해당 테이블에 적용될 제약조건을 기술
    ==> 복합컬럼 설정 가능
3. 테이블 생성 이후, 별도로 제약조건만 해당 테이블에 적용
    ==> 테이블 변경, 복합컬럼 설정 가능
    
1.테이블 생성시 컬럼 옆에 제약조건을 기술
DESC dept;

부서번호는 중복이 되면 안되고, 값이 비어 있어서도 안된다 (일반적으로)
==> dbms  에서 설정 가능한 PRIMARY KEY 제약조건을 컬럼 레벨로 설정

DROP TABLE dept_test;

제약조건 이름을 기술하지 않을 경우 오라클 DBMS 가 자동으로
제약조건 이름을 붙여준다
CREATE TABLE dept_test(
    dept NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
    
);

SELECT *
FROM dept_test;

INSERT INTO dept_test VALUES ( 99, 'ddit', 'daejeon');
위 쿼리는 정상적으로 실행

INSERT INTO dept_test VALUES ( 99, 'ddit2', 'daejeon');
위 쿼리는 첫번째 쿼리에서 입력한 부서번호와 중복 되기 때문에
PRIMARY KEY(UNIQUE) 제약 조건에 위배되어 정상적으로 데이터가 입력되지 않는다
  ==> 우리가 설정한 데이터 무결성이 지켜졌다
    
    
DROP TABLE dept_test;

제약조건 이름을 기술할 수도 있다
해당 조직의 제약조건 명명 규칙을 따라야 한다
PRIMARY KEY : pk_테이블명
UNIQUE : u_테이블명
FOREIGN KEY : fk_테이블명_참조테이블명
NOT NULL, CHECK : 별도의 이름을 기술하지 않는다

CREATE TABLE dept_test(
    dept NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
    
);

2. 테이블 생성시 컬럼 기술과 별도로 해당 테이블에 적용될 제약조건을 기술
DROP TABLE dept_test;
    
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno, dname) --복합컬럼이면 콤마로 구분
                                                        --
);      
dept_test 테이블에 deptno, dname으로 PRIMARY KEY 제약조건을 생성
두개 컬럼이 모두 같아야하지만 중복되는 행으로 인식

INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (99, 'ddit2', 'daejeon');

deptno, dname 컬럼이 모두 같을때는 에러
INSERT INTO dept_test VALUES (99, 'ddit2', 'daejeon');

SELECT *
FROM dept_test;



