CREATE TABLE dept_test2 AS
SELECT *
FROM DEPT
WHERE 1 = 1;
 deptno;
CREATE UNIQUE INDEX idx_U_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_u_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_u_dept_test2_03 ON dept_test2 (deptno, dname);

idx2]
DROP INDEX idx_U_dept_test2_01; 
DROP INDEX idx_u_dept_test2_02; 
DROP INDEX idx_u_dept_test2_03; 

idx3]
SELECT *
FROM emp
WHERE empno = :empno; --��� ��ȣ�� (=) :empno ���� ����� ��

empno || '%'

CREATE INDEX idx_emp_04 ON emp (empno);
CREATE INDEX idx_emp_05 ON emp (ename);
CREATE INDEX idx_emp_06 ON emp ()
(=)������ ������������ ���� ������

SELECT deptno, TO_CHAR(hiredate, 'yyyymm'),
        COUNT(*) cnt
FROM emp
GROUP BY deptno, TO_CHAR(hiredate, 'yyyymm')

select b.*
from emp a, emp b
where a.mgr = b.empno
and a.deptno = : deptno;

idx4]
dept ���̺� ���� �־ 

�����ð��� ��� ����
==> ���� ���� ���¸� �̾߱� ��, ������� �̾߱Ⱑ �ƴ�
inner join : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���� ���
outer join : ���ο� �����ص� ������ �Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���α��
cross join : ������ ����(īƼ�� ���δ�Ʈ), ���� ������ ������� �ʾƼ� 
             ���� ������ ��� ����� ���� ���εǴ� ���
self join : ���� ���̺��� �����ϴ� ����

�����ڰ� DBMS �� SQL �� ���� ��û �ϸ� DBMS �� SQL �� �м��ؼ�
��� �� ���̺� ������ ���� ����, 3���� ����� ���ι��(������ ���ι��, ������� �̾߱�)
1. Nested Loop Join (���߷����� ����) , �ҷ��� ������
2. Sort Merge Join
3. Hash Join

OLPT (OnLine Transaction Processing) : �ǽð� ó�� ==> ������ ����� �ϴ� �ý���(�Ϲ����� �� ����)
OLAP (Online Analysis Processing) : �ϰ� ó�� ==> ��ü ó���ӵ��� �߿� �� ���
                                    (���� ���� ���, ���� �ѹ��� ���)
sort merge join 
������ ������ ������ ����
�����̶�� ��ü�� ��ȭ�� ũ��


������ ������� �ؽ����̺��� ������ ���� �� �ִ�


index �� Ȱ������ ���ϴ� ��� : �÷�����( �º��� �������� ���� )


select *
from emp
where comm >0

idx 4] 
�ý��ۿ��� ����ϴ� ������ ������ ���ٰ� �� �� ������ emp, dept
���̺� �ʿ��ϴٰ� �����Ǵ� �ε����� ���� ��ũ��Ʈ�� ����� ������

SELECT *
FROM emp
WHERE empno = :empno;

SELECT *
FROM dept
WHERE deptno = :deptno;

SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND e.deptno = :deptno
  AND e.empno LIKE :empno || '%';

SELECT *
FROM emp
WHERE sal BETWEEN :st_sal AND :ed_sal

SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND e.deptno = :deptno
  AND d.loc = :loc;


CREATE INDEX idx_emp_1 ON emp (empno, deptno, loc)
CREATE INDEX idx_emp_2 ON dept (deptno)
CREATE INDEX idx_emp_3 ON emp (sal)





