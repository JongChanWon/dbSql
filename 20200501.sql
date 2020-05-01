�Ѱ��� ��, �ϳ��� �÷��� �����ϴ� ��������
ex: ��ü ������ �޿� ���, smith ������ ���� �μ��� �μ���ȣ

WHERE�� ���� ��밡���� ������
WHERE deptno = 10
==>

�μ���ȣ�� 10 Ȥ�� 30���� ���
WHERE deptno IN(10,30)
WHERE deptno = 10 OR deptno = 30



*������ ������
 �������� ��ȸ�ϴ� ���������� ��� = �����ڸ� ���Ұ�
WHERE deptno = (10,30) �ϸ� ����
WHERE deptno IN (�������� ���� �����ϰ�, �ϳ��� �÷����� �̷���� ����)

SMITH - 20, ALLEN�� 30�� �μ��� ����
SMITH �Ǵ� ALLEN�� ���ϴ� �μ��� ������������ ��ȸ

���� ��������, �÷��� �ϳ��� 
==> ������������ ��밡���� ������ IN(���̾�, �߿�), (ANY,ALL(�󵵰� ����))
IN : ���������� ������� ������ ���� ���� �� TRUE
     WHERE �÷�|ǥ���� IN(��������)
    
ANY: �����ڸ� �����ϴ� ���� �ϳ��� ���� �� TRUE
     WHERE �÷�|ǥ���� ������ ANY(��������) 
    
ALL: ���������� ��� ���� �����ڸ� ���� �� �� TRUE
     WHERE �÷�|ǥ���� ������ ANY(��������)

SMITH�� ALLEN�� ���� �μ����� �ٹ��ϴ� ��� ������ ��ȸ
1. ���������� ������� ���� ��� : �ΰ��� ������ ����

1-1] SMITH, ALLEN�� ���� �μ��� �μ���ȣ�� Ȯ���ϴ� ����
SELECT deptno
FROM emp
WHERE ename IN ('SMITH', 'ALLEN');

1-2] 1-1]���� ���� �μ���ȣ�� IN������ ���� �ش� �μ��� ���ϴ� ���� ���� ��ȸ
SELECT deptno
FROM emp
WHERE deptno IN(20, 30);

==> ���������� �̿��ϸ� �ϳ��� SQL���� ���డ��
SELECT deptno
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'ALLEN'));
                 
sub 3]
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN('SMITH', 'WARD'));
                 
**ANY, ALL
SMITH(800)�� WARD(1250) �� ����� �޿��� �ƹ� ������ ���� �޿��� �޴� ���� ��ȸ
==> sal < 1250
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));

SMITH(800)�� WARD(1250) �� ����� �޿� ���� ���� �޿��� �޴� ���� ��ȸ
==> sal > 1250
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));

IN �������� ����
�ҼӺμ��� 20, Ȥ�� 30�� ���
WHERE deptno IN(20,30)

�ҼӺμ��� 20, Ȥ�� 30�� ������ �ʴ� ���
WHERE deptno NOT IN(20,30)

NOT IN �����ڸ� ����� ��� ���������� ���� NULL�� �ִ��� ���ΰ� �߿�
==> NULL�� ���� ��� ���������� �۵����� ����

�Ʒ� ������ ��ȸ�ϴ� ����� � �ǹ��ΰ�? �������� �޴����� �ƴ� ���
NULL ���� ���� ���� ����
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT NULL); 
    
NULLó�� �Լ��� ���� ������ ������ ���� �ʴ� ������ ġȯ
SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr, -1)
                    FROM emp);

���� �÷��� �����ϴ� ���������� ���� ���� ==> ���� �÷��� �����ϴ� ��������
**PAIRWISE ���� (������) ==> ���ÿ� ���� �ϴ� ��!!


SELECT ename, mgr, deptno
FROM emp
WHERE empno IN (7499, 7782); -- IN ������ �ȿ� �ϳ��� ���� �͵� ��ȸ��

7499, 7782 ����� ������ (���� �μ�, ���� �Ŵ���)�� ��� ���� ���� ��ȸ
�Ŵ����� 7698 �̸鼭 �ҼӺμ��� 30�� ���
�Ŵ����� 7839 �̸鼭 �ҼӺμ��� 10�� ���
�̰Ŵ� (7698, 10)
      (7839, 30)


mgr �÷��� deptno �÷��� �������� ����
(mgr, deptno)
(7698, 10)
(7698, 30)
(7839, 10)
(7839, 30);
SELECT *
FROM emp
WHERE mgr IN (7698, 7839)
  AND deptno IN (10, 30);

PAIRWISE ���� (���� �������� ����� �Ѱ� ����)
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN(7499, 7782));

�������� ����-�����ġ
SELECT - ��Į�� ���� ����
FROM - �ζ��� ��
WHERE - ��������

�������� ���� - ��ȯ�ϴ� ��, �÷��� ��
���� ��
    ���� �÷�(��Į�� �������������� ������ ���� �÷��� �����ϴ�)
    ���� �÷�
���� ��
    ���� �÷�(���� ���� ����)
    ���� �÷�

��Į�� ��������
SELCT ���� ǥ���Ǵ� ��������
������ ���� �÷��� �����ϴ� ���������� ��� ����
���������� �ϳ��� �÷�ó�� �ν�;

��Į�� ������������ ��밡�� �ϳ��� ������ �ϳ��� �÷�
SELECT SYSDATE
FROM dual;

SELECT 'X', (SELECT SYSDATE FROM dual)
FROM dual;

��Į�� ���������� �ϳ��� ��, �ϳ��� �÷��� ��ȯ �ؾ� �Ѵ�

*���� �ϳ����� �÷��� 2������ ����
SELECT 'X', (SELECT empno, ename FROM emp WHERE ename = 'SMITH')
FROM dual;

*������ �ϳ��� �÷��� �����ϴ� ��Į�� �������� ==> ����
SELECT 'X', (SELECT empno, ename FROM emp)
FROM dual;

emp ���̺� ����� ��� �ش� ������ �Ҽ� �μ� �̸��� �� ���� ���� ==> �׷��� ���� Ȱ��
Ư�� �μ��� �μ� �̸��� ��ȸ�ϴ� ����
SELECT dname
FROM dept
WHERE deptno = 10;

���� ������ ��Į�� ���������� ����

�������� ����
SELECT empno, ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

���� ������ ��Į�� ���������� ����
SELECT empno, ename, emp.deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno) --, �μ��̸�
FROM emp; --��ȣ���� ����������|---------------------------------------------|

�������� ����- ���������� �÷��� ������������ ����ϴ��� ���ο� ���� ����
��ȣ���� �������� (corelated sub query) 
    .���� ������ ���� �Ǿ�� ���������� ������ �����ϴ�
    
���ȣ���� �������� (non-corelated sub query)
    .main ������ ���̺��� ���� ��ȸ �� ���� �ְ�
     sub ������ ���̺��� ���� ��ȸ �� ���� �ִ�
     ==> ����Ŭ�� �Ǵ� ���� �� ���ɻ� ������ �������� ���� ������ ����

��� ������ �޿���� ���� ���� �޿��� �޴� ���� ���� ��ȸ�ϴ� ������ �ۼ��ϼ��� ( �������� �̿�)
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
�����غ� ����, ���� ������ ��ȣ ���� ���� �����ΰ�? ���ȣ ���� ���������ΰ�?
 ���ȣ ���� �����̴� �ֳĸ� ���������� ������ ������� �ʾƼ�
 
 ������ ���� �μ��� �޿� ��պ��� ���� �޿��� �޴�����
 ��ü ������ �޿� ��� ==> ������ ���� �μ��� �޿� ���
 Ư���μ�(10) �� �޿� ����� ���ϴ� SQL
 
 SELECT AVG(sal)
 FROM emp
 WHERE deptno = 10;
 
 SELECT *
 FROM emp e
 WHERE sal > (SELECT AVG(sal)
              FROM emp
              WHERE deptno = e.deptno); 

SELECT *
FROM dept;

INSERT INTO dept VALUES (99, 'ddit', 'daejeon'); �� �ִ°�

emp ���̺� ��ϵ� �������� 10, 20, 30 �� �μ����� �Ҽ��� �Ǿ�����
���� �Ҽӵ��� ���� �μ�: 40,99

SELECT *
FROM dept
WHERE deptno NOT IN (10,20,30);

SELECT *
FROM dept
WHERE deptno IN (40,99);

SELECT *
FROM dept
WHERE deptno NOT IN(SELECT deptno 
                    FROM emp
                    WHERE emp.);
                    
���������� �̿��Ͽ� IN�����ڸ� ���� ��ġ�ϴ� ���� �ִ��� ������ �� 
���� ������ �־ ��� ����(����)
WHERE deptno IN (10,10,10);
WHERE deptno = 10,
   OR deptno = 10, 
   OR deptno = 10;

������ �μ���ȣ�� 

sub 5]
SELECT *
FROM cycle c, product p
WHERE c.pid = p.pid NOT IN (SELECT *
                            FROM cycle c, product p);

SELECT *
FROM product
WHERE pid NOT IN 
        (SELECT pid
         FROM cycle
         WHERE cid = 1); 

SELECT p.pid, pnm
FROM product p
WHERE cid = 1 NOT IN (SELECT p.pid, pnm
                      FROM cycle, product);
              
 
sub 6]
SELECT *
FROM cycle
WHERE cid = 1 
  AND pid IN (SELECT pid
              FROM cycle
              WHERE cid = 2);
              
sub 7]          
***������ �̿��� ��������
!!!�÷��� �տ� ��Ī �ߺٿ�!!!
 SELECT c.cid, cnm, cy.pid, pnm, day, cnt
 FROM customer c, cycle cy, product p
 WHERE c.cid = cy.cid
   AND cy.pid = p.pid
   AND c.cid = 1
   AND cy.pid IN (SELECT pid
                  FROM cycle
                  WHERE cid = 2);
                  
***��Į�� ���������� �̿��� ��� - ���������� 6�� ������ �ȴ� (����Ʈ���� ��ȣ) --������ �̿��ϴ°� �� ��ȣ�ϴ� ����̴�.
 SELECT cid, (SELECT cnm FROM customer WHERE cid = cycle.cid) cnm,
        pid, (SELECT pnm FROM product  WHERE pid = cycle.pid) pnm, day, cnt
 FROM cycle
 WHERE cid = 1
   AND pid IN (SELECT pid
               FROM cycle
               WHERE cid = 2);
 
 
 
 
 
























