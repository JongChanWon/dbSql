DDL : 테이블이나 관계의 구조를 생성하는데 사용
CREATE - 새로운 데이터베이스 관계(테이블) VIEW, 인덱스, 저장프로시저 만들기
DROP - 이미 존재하는 테이블VIEW, 인덱스 저장프로시저 삭제
ALTER - 이미 존재하는 데이터베이스 개체에 대한 변경, RENAME의 역할을 한다.
TRUNCATE - 관계(테이블)에서 데이터를 제거한다. (한번 삭제시 돌이킬수 없음)

DML : 테이블에 데이터 검색, 삽입, 수정, 삭제하는데 사용
SELECT - 검색(질의)
INSERT - 삽입(등록)
UPDATE - 업데이트(수정)

SELECT *
FROM ranger;

DROP TABLE ranger;

CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    ranger_ph NUMBER,
    reg_dt DATE );

INSERT INTO ranger(ranger_no, ranger_ph) VALUES (99, 01085775214);
    -- 기입하지 않은 컬럼값은 null로 된다
    
drop table dept_test_co;
select *
from dept_test_co;

CREATE TABLE dept_test_co(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
    );
    
INSERT INTO dept_test_co VALUES (99, '원종찬', '대전광역');
INSERT INTO dept_test_co VALUES (98, '원종찬', '대전광역'); 
deptno에 primary key 제약이 걸려 있으므로 deptno에는 똑같은 숫자가 올 수 없다
왜냐면 primary key 는 중복을 허용하지 않기 때문에
    
CREATE TABLE dept_test_co(
    deptno NUMBER(2) CONSTRAINT pk_dept_test_co PRIMARY KEY,
    dname VARCHAR2(14) ,
    loc VARCHAR2(13)
    );    
INSERT INTO dept_test_co VALUES (99, '원종찬', '대전광역');
INSERT INTO dept_test_co VALUES (99, '원종', '대전광역'); 
dname에 pk 제약이 걸려 있으니까 dname 은 중복 불가

(복합컬럼 제약조건 기술 할시)
CREATE TABLE dept_test_co(
    deptno NUMBER(2),
    dname VARCHAR2(14) ,
    loc VARCHAR2(13),
    
    CONSTRAINT pk_dept_test_co PRIMARY KEY (deptno, dname)
);  
INSERT INTO dept_test_co VALUES (99, '원종', '대전광');
INSERT INTO dept_test_co VALUES (99, '원종', '대전광');     
 제약을 걸어놓은 두개의 컬럼이 같으면 중복으로 인식하고 중복된 걸 만들수 없게 한다  
   
   select *
from dept_test_co;
drop table dept_test_co; 
    
CREATE TABLE dept_test_co(
    deptno NUMBER(2),
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13) 
    );
INSERT INTO dept_test_co VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test_co VALUES (99, 'ddit3', 'daejeon');
primary key 랑 동일


 CREATE TABLE dept_test_co (
	deptno NUMBER(2,0) PRIMARY KEY,
	dname VARCHAR2(14),
	loc VARCHAR2(13)
);
    
INSERT INTO dept_test_co VALUES (99, 'ddit', 'daejeon');
    
    select *
    from dept_test_co;
    drop table dept_test_copy;
    
    drop table emp_test_co;
    drop table dept_test_co;
select *
from emp_test_co;







create table emp_test_co (
    empno number(4,0) primary key,
    ename varchar2(14),
    deptno number (2,0) references dept_test (deptno)
);
INSERT INTO emp_test_co VALUES (1234, 'ddit', 99);



CREATE TABLE dept_test_co (
	deptno NUMBER(2,0) primary key, 
	dname VARCHAR2(14),
	loc VARCHAR2(13)
);
INSERT INTO dept_test_co VALUES (98, 'ddit', 'dae');
commit;


create table emp_test_co (
    empno number(4,0) primary key,
    ename varchar2(14),
    deptno number (2,0) references dept_test_co (deptno)
);

CREATE TABLE emp_test (
    empno NUMBER(4,0) PRIMARY KEY,
    ename VARCHAR2(10),
    sal 
    
    
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);
    
    
    
    
    
    
    
    