DDL : ���̺��̳� ������ ������ �����ϴµ� ���
CREATE - ���ο� �����ͺ��̽� ����(���̺�) VIEW, �ε���, �������ν��� �����
DROP - �̹� �����ϴ� ���̺�VIEW, �ε��� �������ν��� ����
ALTER - �̹� �����ϴ� �����ͺ��̽� ��ü�� ���� ����, RENAME�� ������ �Ѵ�.
TRUNCATE - ����(���̺�)���� �����͸� �����Ѵ�. (�ѹ� ������ ����ų�� ����)

DML : ���̺� ������ �˻�, ����, ����, �����ϴµ� ���
SELECT - �˻�(����)
INSERT - ����(���)
UPDATE - ������Ʈ(����)

SELECT *
FROM ranger;

DROP TABLE ranger;

CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    ranger_ph NUMBER,
    reg_dt DATE );

INSERT INTO ranger(ranger_no, ranger_ph) VALUES (99, 01085775214);
    -- �������� ���� �÷����� null�� �ȴ�
    
drop table dept_test_co;
select *
from dept_test_co;

CREATE TABLE dept_test_co(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
    );
    
INSERT INTO dept_test_co VALUES (99, '������', '��������');
INSERT INTO dept_test_co VALUES (98, '������', '��������'); 
deptno�� primary key ������ �ɷ� �����Ƿ� deptno���� �Ȱ��� ���ڰ� �� �� ����
�ֳĸ� primary key �� �ߺ��� ������� �ʱ� ������
    
CREATE TABLE dept_test_co(
    deptno NUMBER(2) CONSTRAINT pk_dept_test_co PRIMARY KEY,
    dname VARCHAR2(14) ,
    loc VARCHAR2(13)
    );    
INSERT INTO dept_test_co VALUES (99, '������', '��������');
INSERT INTO dept_test_co VALUES (99, '����', '��������'); 
dname�� pk ������ �ɷ� �����ϱ� dname �� �ߺ� �Ұ�

(�����÷� �������� ��� �ҽ�)
CREATE TABLE dept_test_co(
    deptno NUMBER(2),
    dname VARCHAR2(14) ,
    loc VARCHAR2(13),
    
    CONSTRAINT pk_dept_test_co PRIMARY KEY (deptno, dname)
);  
INSERT INTO dept_test_co VALUES (99, '����', '������');
INSERT INTO dept_test_co VALUES (99, '����', '������');     
 ������ �ɾ���� �ΰ��� �÷��� ������ �ߺ����� �ν��ϰ� �ߺ��� �� ����� ���� �Ѵ�  
   
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
primary key �� ����


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
    
    
    
    
    
    
    
    