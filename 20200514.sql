�����ȹ : SQL �� ���������� � ������ ���ļ� �������� ������ �ۼ�
         *����ϴµ� ��� ���� ����� �ʿ�(�ð�)
         
         
2���� ���̺��� �����ϴ� SQL
2���� ���̺� ���� �ε����� 5���� �ִٸ� 
������ �����ȹ ���� �?? ������ ���� ==> ª�� �ð��ȿ� �س��� �Ѵ� (������ ���� �ؾ��ϹǷ�)

���� ������ SQL�� ����� ��� ������ �ۼ��� �����ȹ�� ������ ���
���Ӱ� ������ �ʰ� ��Ȱ���� �Ѵ� (���ҽ� ����)

���̺� ���� ��� : ���̺� ��ü(1��), ������ �ε���(5��)
a => b �� ���� �� ���,
b => a �� ���� �� ��� �� �����غ��� ���ϱ� 2
����� �� : 36�� *2�� = 72��


������ SQL �̶� : SQL ������ ��ҹ��� ������� ��ġ�ϴ� SQL
DBMS ���忡���� �Ʒ� �ΰ��� sql �� ���δٸ� SQL�� �ν��Ѵ�
SELECT * FROM emp;
select * FROM emp;  

Ư�������� ������ ��ȸ�ϰ� ������ : ����� �̿��ؼ�
select /* 202004_B */ *
FROM emp
WHERE empno = 7499;

select /* 202004_B */ *
FROM emp
WHERE empno = :empno;
*���ε� ������ ����ϸ� SQL�� ������ ���� �ʴ´�(���ε带 ���������� ����� �� ���� ������ ������ �� �� ����)


��ݴ����� ������ ä��� ������
�κй���
�ƴϸ�
��ü����

�дµ��� ������ ä��� �κй��� �ƴϸ� ��ü����

NESTED LOOP > HASH > SORT ������ ������
��ݴ����� ������ ä�� �� �ִ�

��ݹڽ��� ä���ִ°� ���۸��̶����

Data Dictionary : �ý��� ������ �� �� �ִ� view, ����Ŭ�� ��ü������ ����
category (���ξ�)
user : �ش� ����ڰ� �����ϰ� �ִ� ��ü ���
ALL : �ش� ����� ���� + ������ �ο����� ��ü ���
DBA : ��� ��ü ���
V$ : ����, �ý��۰��� (�ý��ۿ����� ����)

SELECT *
FROM user_tables;

SELECT *
FROM ALL_tables;

SELECT *
FROM DBA_tables; --���� �ִ� ������ ����(SYSTEM ���������� ����)

SELECT *
FROM dictionary;


Multiple insert : �������ǵ����͸� ���ÿ� �Է��ϴ� insert�� Ȯ�屸��

1. unconditional insert : ������ ���� ���� ���̺� �Է��ϴ� ���
���� : 
    INSERT ALL
        INTO ���̺��
        [,INTO ���̺��] --������ �ü� ����
    VALUES (...) | SELECT QUERY;
    
SELECT *
FROM emp_test2;

emp_test ���̺��� �̿��Ͽ� emp_test2 ���̺� ����
CREATE TABLE emp_test2 AS
SELECT *
FROM emp_test
WHERE 1 = 2;
    
EMPNO, ENAME, DEPTNO

emp_test, emp_test2 ���̺� ���ÿ� �Է�
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 9998, 'brown', 88 FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;
    
SELECT *
FROM emp_test

SELECT *
FROM emp_test2
2. conditional insert : ���ǿ� ���� �Է��� ���̺��� ����

INSERT ALL INTO 
    WHEN ����....THEN
        INTO �Է� ���̺� VALUES
    WHEN ����....THEN
        INTO �Է� ���̺�2 VALUES
    ELSE
        INTO �Է� ���̺�3 VALUES
SELECT ����� ���� ���� EMPNO = 9998�̸� EMP_TEST ���� ����Ʈ�� �Է�
                      �� �ܿ��� EMP_TEST2�� �����͸� �Է�
INSERT ALL
    WHEN empno = 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    ELSE
        INTO emp_test2 (empno, deptno) VALUES (empno, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL --���ʿ��� �˸��ƽ��� �ָ��
SELECT 9997, 'cony', 88 FROM dual;

SELECT *
FROM emp_test

SELECT *
FROM emp_test2

ROLLBACK;

conditional insert (all) ==> first
INSERT ALL 
    WHEN empno <= 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    WHEN empno <= 9997 THEN
        INTO emp_test2 VALUES (empno, ename, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

ROLLBACK;

INSERT FIRST
    WHEN empno <= 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    WHEN empno <= 9997 THEN
        INTO emp_test2 VALUES (empno, ename, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

*Merge (DML)
-�ϳ��� ������ ���� �ٸ� ���̺�� �����͸� �ű� �Է�, �Ǵ� ������Ʈ �ϴ� ����
����:
MERGE INTO �������(emp_test)
USING (�ٸ����̺� | VIEW | subquery)
ON (�������� USING ���� ���� ���� ���)
WHEN NOT MATCHED THEN
    INSERT (col1, col2(�÷�)...) VALUES (value1, value2....)
WHEN MATCHED THEN
    UPDATE SET col1 = value1, col2 = value2

1. �ٸ� �����ͷ� ���� Ư�� ���̺�� �����͸� MERGE �ϴ°��
2. KEY �� ���� ��� INSERT
   KEY �� ���� ��� UPDATE


emp ���̺��� �����͸� emp_test ���̺�� ����
emp ���̺��� �����ϰ� emp_test ���̺��� �������� �ʴ� ������ �ű��Է�
emp ���̺��� �����ϰ� emp_test ���̺��� �����ϴ� ������ �̸� ����

INSERT INTO emp_test VALUES (7369, 'cony', 88);
MERGE INTO emp_test

emp ���̺��� 14���� �����͸� emp_test ���̺� ������ empno�� ���� �ϴ��� �˻��ؼ�
������ empno�� ������ insert - empno, ename , ������ empno�� ������ update - ename
MERGE INTO emp_test
USING emp
ON (emp_test.empno = emp.empno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (emp.empno, emp.ename)
WHEN MATCHED THEN
    UPDATE SET ename = emp.ename;
-------------------
merge �� ������
12  	brown	999
7369	cony	88
-------------------
merge �� ������
12  	brown	999
7369	SMITH	88
7844	TURNER	
7839	KING	
7782	CLARK	
7521	WARD	
7654	MARTIN	
7788	SCOTT	
7698	BLAKE	
7566	JONES	
7499	ALLEN	
7934	MILLER	
7902	FORD	
7876	ADAMS	
7900	JAMES
-------------------
SELECT *
FROM emp

SELECT *
FROM emp_test

9999�� ������� �ű� �Է��ϰų�, ������Ʈ�� �ϰ� ���� ��
(����ڰ�9999��, james ����� ����ϰų�, ������Ʈ �ϰ� ������)
���� ���� ���̺� ==> �ٸ����̺�� ����

�̹��� �ϴ� �ó����� : �����͸� ==> Ư�� ���̺�� ����
(9999, james)

MERGE ������ ������� ������

������ ���� ������ ���� SELECT ����
SELECT *
FROM emp_test
WHERE empno = 9999;

�����Ͱ� ������ ==> UPDATE
�����Ͱ� ������ ==> INSERT

MERGE INTO emp_test
USING dual
    ON (emp_test.empno = 9999)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999, 'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';
    
�� �Ʒ� ������ �Ȱ��� ����� ���� (���� ������ �� ����)

MERGE INTO emp_test
USING (SELECT 9999 eno, 'james' enm
       FROM dual) a
    ON (emp_test.empno = a.eno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999, 'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';

SELECT *
FROM emp_test;

REPORT GROUP FUNCTION
emp ���̺��� �̿��Ͽ� �μ���ȣ�� ������ �޿� �հ�, ��ü������ �޿����� ��ȸ�ϱ� ����
GROUP BY �� ����ϴ� �ΰ��� SQL�� ������ �ϳ��� ��ġ��(UNION ==> UNION ALL) �۾��� ����

�ؿ� �ΰ� ������ ���� -- union �Ҷ��� �÷� ������ ���������
SELECT deptno, SUM(sal) 
FROM emp
GROUP BY deptno

UNION ALL

SELECT NULL, SUM(sal) 
FROM emp;


Ȯ��� GROUP BY 3����
1. GROUP BY ROLLUP
���� : GROUP BY ROLLUP (�÷�, �÷�2...)
���� : ����׷��� ����� �ִ� �뵵
����׷� ���� ��� : ROLLUP ���� ����� �÷��� �����ʿ��� ���� �ϳ��� �����ϸ鼭 ���걸���� ����
������ ����׷��� UNION �� ����� ��ȯ

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);
*SAME*
����׷�: 1. GROUP BY job, deptno
            UNION
         2. GROUP BY job
            UNION
         3. ��ü�� GROUP BY

���� GROUP BY �� ���� GROUP BY ROLLUP �̶� �Ȱ���
SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY job, deptno

UNION

SELECT job, NULL, SUM(sal) sal
FROM emp
GROUP BY job

UNION

SELECT NULL, NULL, SUM(sal) sal
FROM emp

����] �ؿ� �� ������ GROUP BY ROLLUP ���� �����Ͻÿ�
SELECT deptno, SUM(sal) 
FROM emp
GROUP BY deptno

UNION ALL

SELECT NULL, SUM(sal) 
FROM emp;

-> GROUP BY ROLLUP ���� ���� �� 
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP(deptno);




















