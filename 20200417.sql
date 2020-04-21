
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
<<<<<<< Updated upstream
  AND deptno = 30; --�ΰ��� ����
   








  AND deptno = 30; --�ΰ��� �����ϴ°� ��� �ƹ��͵� ������ �ʴ´�.
  
SELECT userid  "���̵�", usernm as "�̸�", alias as "����"
FROM users
WHERE userid IN ('brown', 'cony', 'sally');
    -- alias, where�� ���ڿ� �� ���
   
*���ڿ� ��Ī ���� : LIKE ���� / JAVA ������ : .startsWith(prefix), .endsWith(suffix)
����ŷ ���ڿ� % - ��� ���ڿ�(���� ����)
            _ - � ���ڿ��̵��� �� �ϳ��� ���� 
���ڿ��� �Ϻΰ� ������ TRUE

�÷�|Ư���� LIKE ���� ���ڿ�;

'cony' : cony�� ���ڿ�
'co%'  : ���ڿ��� co �� �����ϰ� �ڿ��� � ���ڿ��̵� �� �� �ִ� ���ڿ�
         ex) 'cony', 'con', 'co'
'co_'  : co�� �����ϴ� ���ڿ�
         ex) 'cony', 'sally cony'
'co__' : co�� �����ϰ� �ڿ� �ΰ��� ���ڰ� ���� ���ڿ� --����� �ΰ�
'_on_' : ��� �α��ڰ� on�̰� �յڷ� � ���ڿ� �̵��� �ϳ��� ���ڰ� �� �� �ִ� ���ڿ�


���� �̸�(ename) �� �빮�� S�� �����ϴ� ������ ��ȸ
SELECT ename
FROM emp
WHERE ename LIKE 'S%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

'��'����ϴ� ���ڰ� �� �� �ִ� ��� ��ȸ
SELECT mem_id,  mem_name
FROM member
WHERE mem_name LIKE '%��%';

NULL ��
SQL �񱳿����� : =
  WHERE usernm = 'brown'
  
*MGR�÷� ���� ���� ��� ������ ��ȸ
SELECT * 
FROM emp
WHERE mgr IS NULL;

���� �ִ� ��Ȳ���� ��� : =, (!=, <>)
NULL : IS NULL, IS NOT NULL -- Ű����

*emp ���̺��� mgr �÷� ���� NULL �� �ƴ� ������ ��ȸ
SELECT * 
FROM emp
WHERE mgr IS NOT NULL;

SQL ���� NULL ���� ���� ��� �Ϲ����� �񱳿�����(=)�� ��� ���ϰ� IS �����ڸ� ���
 
*Ŀ�̼��� �ִ� ����� ��ȸ
SELECT *
FROM emp
WHERE comm IS NOT NULL;

SELECT * 
FROM emp
WHERE mgr = 7698
  AND sal > 1000;
  
SELECT * 
FROM emp
WHERE mgr = 7698
  OR sal > 1000;
  
  IN �����ڸ� �� �����ڷ� ����
SELECT * 
FROM emp
WHERE mgr IN (7698, 7839);
==> WHERE mgr = 7698 OR mgr = 7839

SELECT * 
FROM emp
WHERE mgr NOT IN (7698, 7839);     
==> WHERE mgr != 7698 AND mgr != 7839 --7698 7839�� �ƴѰ�

SELECT * 
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL);  --NULL�� equal �� �񱳰� �ȵ�

SELECT * 
FROM emp
WHERE mgr NOT IN (7698, 7839)
   OR mgr IS NULL; --NULL ���� �� �� �� ���� �������

SELECT *
FROM emp
WHERE job = 'SALESMAN'
  AND hiredate >= TO_DATE(19810601) -- �����Ϳ����� ��ҹ��ڸ� ������.
  AND sal > 1300;
  
SELECT *
FROM emp
WHERE job IN ('SALESMAN') == job = 'SALESMAN';
where 8]
*�μ��� 10�� �ƴϰ� 81�� 6�� 1�� ���� �Ի��� (not in ��������)
SELECT *
FROM emp
WHERE deptNo != 10
  AND hiredate >= TO_DATE(19810601);

where 9]
*�μ��� 10�� �ƴϰ� 81�� 6�� 1�� ���� �Ի��� (not in ����)  
SELECT *
FROM emp
WHERE job NOT IN(10)
  AND hiredate >= TO_DATE(19810601);
  
SELECT *
FROM emp
WHERE deptNo IN (10,20,30)
  AND deptNo !=10
  AND hiredate >= TO_DATE(19810601);
  
where 10]
SELECT *
FROM emp
WHERE deptNo IN (20,30)
  AND hiredate >= TO_DATE(19810601);

where 11]
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR hiredate >= TO_DATE(19810601);
   
where 12]

SELECT *
FROM emp
WHERE job = 'SALESMAN' 
   OR EMPNO LIKE '78__';  --Ÿ���� numberŸ���ε� ���ڷ� ǥ���ߴ�,, �ڵ�����ȯ�� �̷����
   
where 13] -- DESC ��s��ũ���̺���
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
   OR EMPNO >= 7800 AND empno < 7900;

-- AND, OR �켱���� ����!! AND�� ����
where 14]
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
   OR (EMPNO >= 7800 AND empno < 7900)
  AND hiredate >= TO_DATE(19810601);

where 15]
SELECT *
FROM emp
WHERE job = 'SALESMAN';


����: {a,b,c} == {a,c,b}
table ���� ��ȸ, ����� ������ ����(�������� ����)
==> ���нð��� ���հ� ������ ����

SQL ������ �����͸� �����Ϸ��� ������ ������ �ʿ��ϴ�.
ORDER BY �÷���[��������], �÷���2[��������], ... --�������� ���� ����
������ ���� : ��������(DEFAULT)- ASC(���������� �⺻�̶� ���ص���), �������� - DESC

���� �̸����� �������� ����
SELECT *
FROM emp
ORDER BY ename ASC;

���� �̸����� �������� ����
SELECT *
FROM emp
ORDER BY ename DESC;

*job�� �������� �������� �����ϰ� job�� ���� ��� �Ի����ڷ� �������� ����
��� ������ ��ȸ
SELECT *
FROM emp
ORDER BY job ASC, hiredate desc;
>>>>>>> Stashed changes
  
  
