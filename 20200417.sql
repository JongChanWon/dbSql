
-- sal ���� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ������ ��ȸ ==> BETWEEN AND ���
-- �񱳴�� �÷� / �� BETWEEN ���۰� AND ���ᰪ
-- ���۰��� ���ᰪ�� ��ġ�� �ٲٸ� ���� �������� ����

sal >= 1000 AND sal <= 2000

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

exclusive or (��Ÿ�� or)
a or b           :  a = true, b = true ==> true
a exclusive or b :  a = true, b = true ==> false

SELECT *
FROM emp
WHERE sal >= 1000 
  AND sal <= 2000;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101') AND TO_DATE('19830101');
-- �� �Ʒ� �Ȱ��� ����� ���´�.
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101') 
  AND hiredate <= TO_DATE('19830101');
  
IN ������
�÷�|Ư���� IN (��1, ��2, ....)
�÷��̳� Ư������ ��ȣ�ȿ� ���߿� �ϳ��� ��ġ�� �ϸ� TRUE

SELECT *
FROM emp
WHERE deptno IN (10, 30);
==> deptno �� 10�̰ų� 30���� ����
deptno = 10 OR deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
   OR deptno = 30;
   
SELECT *
FROM emp
WHERE deptno = 10
  AND deptno = 30; --�ΰ��� ����
   







  
  
