**DBMS �� RDBMS �� ���� �����ϴ�
DBMS : DataBase Management System
-> DB
RDBMS : Relational DataBase Management System
-> ������ �����ͺ��̽� ���� �ý���

JOIN ������ ����
ANSI - ǥ��
�������� ����(ORACLE) --�����縶�� ������ ���ݾ� �ٸ���

JOIN�� ��� �ٸ� ���̺��� �÷��� ����� �� �ֱ� ������
SELECT �� �� �ִ� �÷��� ������ ��������(����Ȯ��)

���տ��� -> ����Ȯ�� (���� ��������);


select *
from emp;

select *
from dept;

NATURAL JOIN 
    . �����Ϸ��� �� ���̺��� ����� �÷��� �̸��� ���� ���
     -> emp, dept ���̺��� detpno ��� �����(������ �̸�, Ÿ�Ե� ����) ����� �÷��� ���� --�̷��� ����ϴ°� ��������
    . �ٸ�  ANSI-SQL ������ ���ؼ� ��ü�� �����ϰ�, ���� ���̺���� �÷����� �������� ������
      ����� �Ұ����ϱ� ������ ��� �󵵴� �ټ� ����
.emp ���̺�: 14��
.dept ���̺�: 4��
FROM ���� ���̺���� ������ �� �� �ִ�.
���� �Ϸ��� �ϴ� �÷��� ���� ������� ����
 SELECT *  --�����̺��� �̸��� ������ �÷����� ����
 FROM emp NATURAL JOIN dept; --���������� ���ؼ� ������, �÷��� ���η� Ȯ��
 
 ORACLE ���� ������ ANSI ����ó�� ����ȭ ���� ����
 ����Ŭ ���� ����
  1. ������ ���̺� ����� FROM ���� ����ϸ� �����ڴ� �ݷ�(,)
  2. ����� ������ WHERE ���� ����ϸ� �ȴ�. EX) WHERE emp.deptno = dept.deptno --where���� ������ ������ ���
  
  SELECT *
  FROM emp, dept
  WHERE deptno = deptno;
  --�̷��� �ϸ� ������ ���µ� deptno�� ��� ���� �μ����� ����
  
  SELECT *
  FROM emp, dept
  WHERE emp.deptno = dept.deptno;
  --�׷��� Ư�� �÷����� �տ� ����Ѵ�.
  
  deptno�� 10���� �����鸸 dept ���̺�� ���� �Ͽ� ��ȸ
  
  SELECT *
  FROM emp, dept
  WHERE emp.deptno = dept.deptno
    AND emp.deptno = 10
    AND dept.deptno = 10;  -- AND �ڿ� ������ �������� �Ѵ� �Ȱ��� ����� �����´�
  
  ANSI-SQL : JOIN with USING(����)
  . join �Ϸ��� ���̺� �̸��� ���� �÷��� 2�� �̻��� ��
  . �����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷����� ���
  
  --���� �����̶� ����
 SELECT *
 FROM emp JOIN dept USING(deptno);
  
 ANSI-SQL : JOIN with ON (���̾�) 
 . ���� �Ϸ��� �� ���̺� �÷����� �ٸ� ��
 .ON ���� ����� ������ ���
 
 SELECT *
 FROM emp JOIN dept ON (emp.deptno = dept.deptno);
 
 
 ORACLE �������� �� SQL�� �ۼ�
 SELECT *
 FROM emp, dept
 WHERE emp.deptno = dept.deptno ; --����Ŭ �������� �ϸ� ���� ANSI �������� �� �� �������� ��� �� �� ����
 
 
 JOIN�� ������ ����
 SELF JOIN : �����Ϸ��� ���̺��� ���� ���� ��
 EMP ���̺��� ������ ������ ������ ��Ÿ���� ������ ������ mgr �÷��� �ش� ������ ������ ����� �����Ҷ�
 �ش� ������ �������� �̸��� �˰������ 
 
 ANSI-SQL�� SQL ����: 
 �����Ϸ��� �ϴ� ���̺� EMP(����), EMP(������ ������)
               ����� �÷�: ����.MGR = ������.EMPNO �� ������ �ϸ��
               -> ���� �÷� �̸��� �ٸ���(MGR, EMPNO)
                 -> NATURAL JOIN, JOIN WITH USING(�����Ϸ��� �÷����� ������ ���) �� ����� �Ұ����� ����
                    -> JOIN with ON ���� �ۼ��� �� �ڿ� ���� (�����Ϸ��� �÷����� �޶�)
 
 ANSI-SQL�� �ۼ�
 
 ���̺���� ��Ī�� ���� ���� �� �ִ�.
 SELECT * 
 FROM emp e JOIN emp m ON (e.mgr = m.empno); --ŷ�� ���� ������ 13��(ŷ ���� ���)
 �Ȱ��� �÷��̶� �˸��߽��� ���
 

 NONEQUI JOIN : ����� ������ =�� �ƴҶ�
            
 
 WHERE ������ ����� ������ : =, !=, <>, <=,<,>, >=
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
 
 
  oracle ���� �������� ����
  
  SELECT *
  FROM emp, salgrade
  WHERE emp.sal <= salgrade.losal and salgrade.hisal<= emp.sal;
  
join 0]

emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� �����ۼ�

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
 
 join1] ����;
 SELECT prod_id, 
 FROM prod;
 WHERE  
 
 
 
 
 join 3~4 ��, ������ ���� join1�� Ǯ��
 
 
 