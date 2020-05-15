REPORT GROUP FUNCTION ==> Ȯ��� GROUP BY
REPORT GROUP FUNCTION �� ����� ���ϸ�
�������� SQL �ۼ�, UNION ALL �� ���ؼ� �ϳ���.10 
����� ��ġ�� ����
==> ���� ���ϰ� �ϴ°� REPORT GROUP FUNCTION

ROLLUP : ����׷� ���� - ����� �÷��� �����ʿ������� ���������� GROUP BY �� ����

�Ʒ� ������ ����׷�
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY ==> ��ü

ROLLUP ���� �����Ǵ� ����׷��� ���� : ROLLUP �� ����� �÷��� + 1;

GROUP_AD2] --����Ȯ�� ���
SELECT NVL(job, '�Ѱ�'), deptno, SUM(sal)sal
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT NVL(job, '�Ѱ�'), deptno, 
       GROUPING(job), GROUPING(deptno), SUM(sal)sal
FROM emp
GROUP BY ROLLUP (job, deptno);
rollup�� ���ؼ� ������ �Ұ� ������

GROUP_AD3]
SELECT  CASE
        WHEN GROUPING(job) = 1 THEN '�Ѱ�'
        ELSE job
        END job, deptno, SUM(sal)sal
       
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD2-1]

SELECT CASE
        WHEN GROUPING(job) = 1 THEN '��'
            ELSE job
            END job,
        CASE
        WHEN GROUPING(job) = 1 AND GROUPING(deptno) = 1 THEN '��'
        WHEN GROUPING(deptno) = 1 THEN '�Ұ�'
            ELSE TO_CHAR(deptno)
            END deptno,
            deptno, SUM(sal)sal
FROM emp
GROUP BY ROLLUP(job,deptno);


SELECT DECODE(GROUPING(job), 1, '��', job)job,
       DECODE(GROUPING(job) || GROUPING(deptno), '11', '��', '01', '�Ұ�', TO_CHAR(deptno))deptno,
       DECODE(GROUPING(job) + GROUPING(deptno), 2, '��', 1, '�Ұ�', TO_CHAR(deptno))deptno, --���߿� ��� �ص� ���x
        SUM(sal)sal
FROM emp
GROUP BY ROLLUP(job, deptno);

GROUP_AD3]
SELECT deptno, job, SUM(sal)sal
FROM emp
GROUP BY ROLLUP(deptno,job);

ROLLUP ���� ��� �Ǵ� �÷��� ������ ��ȸ ����� ������ ��ģ��
(****����׷��� ����� �÷��� ������ ���� ������ �����鼭 ����)
GROUP BY ROLLUP(deptno,job);
GROUP BY ROLLUP(job,deptno);

GROUP_AD4]
SELECT d.dname, e.job, SUM(e.sal)sal
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY ROLLUP(d.dname, e.job);


SELECT d.dname, a.job,
FROM
(SELECT deptno, job, SUM(sal) sum_sal
 FROM emp
 GROUP BY ROLLUP(d;

GROUP_AD5]
SELECT NVL(d.dname, '�Ѱ�')dname, e.job, SUM(e.sal)sal
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY ROLLUP(d.dname, e.job);


2. GROUPING SETS
ROLLUP �� ���� : ���ɾ��� ����׷쵵 �����ؾ��Ѵ�
                ROLLUP ���� ����� �÷��� �����ʿ��� ���������� ������
                ���� �߰������� �ִ� ����׷��� ���ʿ� �� ��� ����.
GROUPING SETS : �����ڰ� ���� ������ ����׷��� ���
                ROLLUP ���� �ٸ��� ���⼺�� ����.
                (�޸��������� ����׷��� �����)
���� : GROUP BY GROUPING SETS (col1, col2)
GROUP BY col1
UNION ALL
GROUP BY col2
���Ʒ��� �Ȱ���
GROUP BY GROUPING SETS (col1, col2)
GROUP BY GROUPING SETS (col2, col1)


SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, deptno);

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(deptno, job); --�÷������� �ٲ� �������.


�׷������ 
1. job, deptno
2. mgr


GROUP BY GROUPING SETS ((job, deptno), mgr) --��ȣ�� ġ�� ��ȣ�ȿ� �ִ°� �ϳ��� �׷����� ����.

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);

3.CUBE
����: GROUP BY CUBE (col1, col2...)
����� �÷��� ������ ��� ����(������ ��Ų��)

GROUP BY CUBE(job, deptno);
1�÷�       2���÷�
job,        deptno
job,        x
 x,         deptno
 x,         x

GROUP BY CUBE(job, deptno, mgr);
1�÷�       2���÷�          3���÷�
job,        deptno          mgr
job,        deptno           x
job,        deptno          mgr
job,         x               x
 x          deptno
 x          
 x
 x

SELECT job, deptno,SUM(sal)
FROM emp
GROUP BY CUBE (job, deptno);


�������� REPORT GROUP ����ϱ�
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**�߻� ������ ������ ���
1          2         3
job     deptno      mgr  ==> GROUP BY job ,deptno, mgr
job     x           mgr  ==> GROUP BY job ,mgr
job     deptno      x    ==> GROUP BY job, deptno
job     x           x    ==> GROUP BY job 



SELECT job, deptno, mgr, SUM(sal+NVL(comm,0))sal
FROM emp
GROUP BY job, rollup(job, deptno), cube(mgr);

1           2           3

--select ���������� �߿�!
��ȣ���� �������� ������Ʈ
1. emp���̺��� �̿��Ͽ� emp_test ���̺� ����
2. emp_test ���̺� dname�÷� �߰�(dept ���̺� ����)

drop table emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));
desc emp_test;

SELECT *
FROM emp_test;

3. subquery �� �̿��Ͽ� emp_test ���̺� �߰��� dname �÷��� ������Ʈ ���ִ� ���� �ۼ�
emp_test �� dname �÷��� ���� dept ���̺��� dname �÷����� update
emp_test ���̺��� deptno ���� Ȯ���ؼ� dept���̺��� deptno ���̶� ��ġ�ϴ� dname �÷����� �����ͼ� update

emp_test ���̺��� dname �÷��� dept ���̺��� ���ؼ� dname �� ��ȸ�Ͽ� ��������
update ����� �Ǵ� �� : 14 ==> WHERE ���� ������� ����

��� ������ ������� DNAME �÷��� DEPT ���̺��� ��ȸ�Ͽ� ������Ʈ
UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE emp_test.deptno = dept_test.deptno);
                             
DROP TABLE dept_test2;
SELECT *
FROM dept_test2;

sub_a1]
CREATE TABLE dept_test2 AS
ALTER TABLE dept_test2 ADD (empcnt NUMBER);

*group by ���Ѱ�
UPDATE dept_test2 SET empcnt = (SELECT count(*)
                                FROM emp
                                WHERE emp.deptno = dept_test2.deptno); --��ȣ ���� Ŀ��

*group by �Ѱ�
UPDATE dept_test2 SET empcnt = (SELECT count(*)
                                FROM emp
                                WHERE emp.deptno = dept_test2.deptno
                                GROUP BY deptno);
                                
SELECT ��� ��ü�� ������� �׷� �Լ��� ������ ���
���Ǵ� ���� ������ 0���� ����
SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ���� ��� ��ȸ�Ǵ� ���� ����
SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;



SELECT *
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_TYPE='R';