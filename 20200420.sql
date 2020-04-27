table ���� ��ȸ/���� ������ ����.
==> ORDER BY �÷��� ���Ĺ��, ....

����*
ORDER BY �÷����� index��ȣ �� ���� ����
==> SELECT �÷��� ������ �ٲ�ų�, �÷� �߰��� �Ǹ� ���� �ǵ���� �������� ���� ���ɼ��� ����

SELECT�� 3��° �÷��� �������� ����
SELECT *
FROM emp
ORDER BY 3;

��Ī���� ����
�÷����ٰ� ������ ���� ���ο� �÷��� ����� ���
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
���ͷ�
    ����: ����
    ����: '����'
SELECT *
FROM emp
WHERE comm IS NOT NULL --NULL �񱳴� ������� NULL �̱� ������  ���� �Ƚᵵ��
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

����¡ ó���� �ϴ� ����
1. �����Ͱ� �ʹ� ���Ƽ�
    . �� ȭ�鿡 ������ ��뼺�� ��������
    . ���ɸ鿡�� ��������

����Ŭ���� ����¡ ó�� ��� ==> ROWNUM


RONUM :SELECT ������� 1������ ���ʴ�� ��ȣ�� �ο����ִ� Ư�� KEYWORD

EXPLAIN PLAN FOR
SELECT ROWNUM, empno, ename
FROM emp;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


SELECT ���� *ǥ���ϰ� �޸��� ���� 
�ٸ� ǥ��(ex ROWNUM) �� ��� �� ���
*(�ƽ��׸�) �տ� � ���̺� ���Ѱ��� ���̺� ��Ī/��Ī�� ����ؾ��Ѵ�.;
SELECT ROWNUM, emp.* --emp�� ��� �÷��� ��ȸ
FROM emp e;  --�̷��� �ϸ� ������ ���µ� �������� e�� �̸��� �ο� �߱� ������ SELECT������ e�� �ٲ�����Ѵ�.
����
SELECT ROWNUM, e.* --emp�� ��� �÷��� ��ȸ
FROM emp e;

����¡ ó���� ���� �ʿ��� ����
1. ������ ������(10)
2. ������ ���� ���� --�߿�

1-page: 1~10
2-page: 11~20 (11~14 ���� ���´� , ������ 14���� �ۿ� ���)

1 ������ ����¡ ����
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

2 ������ ����¡ ����

SELECT ROWNUM, empno, ename
FROM emp
WHERE  ROWNUM BETWEEN 11 AND 20;

ROWNUM�� Ư¡
1. ORACLE ���� ����
    . �ٸ� DBMS�� ��� ����¡ ó���� ���� ������ Ű���尡 ���� (LIMIT)
2. 1������ ���������� �д� ��츸 ����
    RONUM BETWEEN 1 AND 10 ==> 1~10
    RONUM BETWEEN 11 AND 20 ==> 1~10�� SKIP �ϰ� 11~20�� �������� �õ�
    
WHERE ������ ROPWNUM�� ����� ��� ���� ����
ROWNUM = 1;
ROWNUM BETWEEN 1 AND N;
ROWNUM <, <= N (1~N)

ROWNUM�� ORDER BY
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY empno;

SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

ROWNUM �� ORDER BY ������ ����
SELECT -> ROWNUM -> ORDER BY;

SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;
ROWNUM�� ��������� ���� ������ �Ȼ��·� ROWNUM�� �ο��Ϸ��� IN-LINE VIEW �� ����ؾ� �Ѵ�
** IN-LINE : ���� ����� �ߴ�

SELECT ROWNUM, a.*
FROM
(SELECT ROWNUM, a.*
FROM 
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a ) a)  -- �˸��߽� ��� ��Ī�� ������ �� �ִ�.
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

sql ���� ������ ǥ���Ҷ� : ���

SELECT ROWNUM, a.*
FROM
(SELECT ROWNUM rn, a.*
FROM 
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a ) a  -- �˸��߽� ��� ��Ī�� ������ �� �ִ�.
WHERE rn BETWEEN 1 + (:page -1) * :pageSize AND  :page * :pageSize;

����
SELECT *
FROM
(SELECT empno, ename
 FROM emp
 ORDER BY ename);
 
 INLINE-VIEW �� �񱳸� ���� VIEW�� ���� ����(�����н�, ���߿� ���´�)
 VIEW - ���� (view ���̺�-X)
 
 DML - Data Manipulation Language  : SELECT, INSERT, UPDATE, DELETE
 DDL - Data Definition Language  : CREATE , DROP, MODIFY, RENAME
 
 
 CREATE OR REPLACE VIEW emp_ord_by_ename AS
    SELECT empno, ename
    FROM emp
    ORDER BY ename;
 
 IN-LINE VIEW �� �ۼ��� ����
 SELECT *
 FROM (SELECT EMPNO, ENAME
       FROM emp
       ORDER BY ename);
       
VIEW�� �ۼ��� ����
SELECT *
FROM emp_ord_by_ename;

emp ���̺� �����͸� �߰��ϸ�
in-line view, view �� ����� ������ ����� ��� ������ ������???

���� �ۼ��� ������ ã�ư���

BUG ??? : ����
���� ��ǻ�� : ������
������ ������ ���̿� ���� ������ �߻� ==> ������ ���ִ� ����(�����)

java :�����
sql : ����� ���� ���� (������ ���� ������)
       
����¡ ó�� ==> ����, ROWNUM
����, ROWNUM�� �ϳ��� �������� ������ ��� ROWNUM  ���� ������ �Ͽ�
���ڰ� ���̴� ���� �߻� ==> INLINE-VIEW ���
  ���Ŀ� ���� INLINE-VIEW
  ROWNUM�� ���� INLINE-VIEW
  
SELECT *
FROM
 (SELECT ROWNUM rn, b.*
 FROM
  (SELECT empno, ename --�ΰ��� �÷��� ������ �ִ� ���̺�
   FROM emp
   ORDER BY ename) b )
WHERE rn BETWEEN 11 AND 20; 
--WHERE ROWNUM BETWEEN 11 AND 20; --1~10������ ������ �Ǽ� ���� �ȵ� ���������� �о����
--�׷��� �������� �ѹ��� �����ش�

SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM 
 (SELECT empno, ename
  FROM emp
  ORDER BY ename) a )
WHERE rn BETWEEN 11 AND 20;   

**�űԹ���
PROD ���̺��� PROD_LGU (��������), PROD_COST(��������) ���� �����Ͽ�
����¡ ó�� ������ �ۼ� �ϼ���
�� ������ ������� 5
���ε� ���� ����� ��

SELECT *
FROM
 (SELECT ROWNUM rn, a.*
  FROM
   (SELECT *
   FROM PROD
   ORDER BY PROD_LGU DESC, PROD_COST) a )
WHERE rn BETWEEN (:page-1 )* :pageSize + 1 AND :page * :pageSize;

       WHERE rn BETWEEN 1 + (:page -1) * :pageSize AND  :page * :pageSize;
       
       
       
       



