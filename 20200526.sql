Ʈ���� : ��Ƽ�
Ư�� �̺�Ʈ�� �߻� ���� �� � ������ �߰������� ����
(�� �������� ǥ���� �ִ� ���������� ���콺 (��)Ŭ�� ==> Ŭ�� �̺�Ʈ �߻�
�����ڵ��� �ۼ��� ���� �̺�Ʈ �ڵ鷯(����)�� ����)

EX : Ư�� ���̺� �����Ͱ� �űԷ� �Էµɶ� �߰����� ������ ����
    USERS ���̺� ��й�ȣ�� ������ �Ǹ� users_history ���̺� ���� ��й�ȣ�� ����ϴ�
    ������ �߰�
    
    users ���̺� update�� �ϴ��� Ʈ���ſ� ���Ͽ� users_history���̺� �����Ͱ� �Է�
    ==> ���� users ���̺�� users_ history ���̺� �����ڰ� �۾��� �ص� �ȴ�
    
Ʈ���Ű� ���� ����
������ ���Ἲ�� �����ָ鼭 ���� ������ �����͸� �Է�, ������ �� �ִ�.

Ʈ���Ű� ���� ����
��������
�ٸ� �������� �ۼ��� �ڵ带 Ȯ�� ���� �� users ���̺��� �����͸� �ű� �Է��ϴ� ���� �ۿ� ���µ�
�̻��ϰԵ� users_history ���̺��� �����Ͱ� �����Ǵ� ���

�ڵ�� ����� �ٸ���

SI �����ڰ� Ʈ���Ÿ� ��ȣ�Ѵ� ==> �ڱⰡ ���� �س��� �ҽ��� ������ �������� ������ ���ξ���
                               �ű� ������ ������ ���� �ٸ� ������ ��
                               
Ʈ���Ÿ� ��ȣ : ��������, �ý����� ��ü�������� ���� �����

users ���̺� ��й�ȣ�� �÷����� ����Ǿ��� �� users_history ���̺� ����
��й�ȣ�� ����ϴ� Ʈ���� �ǽ�

1. users_history ���̺� ����
2. Ʈ���� ����
3. users ���̺� ��й�ȣ�� ����
4. Ʈ���ſ� ���� users_history ���̺� �����Ͱ� ���̴��� Ȯ��

1. users_history ���̺� ����
CREATE TABLE users_history(
    userid VARCHAR2(20), --ID
    pass VARCHAR2(100), --PASSWORD
    mod_dt DATE
);

select *
from users_history

2. trigger ����
CREATE OR REPLACE TRIGGER make_history
    --���, Ÿ�̹�
    BEFORE UPDATE ON users
    
    --�� �ึ�� �̺�Ʈ�� ����
    FOR EACH ROW
    
    --�����ۼ�(PL/SQL ���)
    BEGIN
       -- �ű� �ԷµǴ� ������ : NEW.�÷�, ���������� : OLD.�÷���
       -- users ���̺��� ��й�ȣ�÷��� ����Ǿ��� �� ==> users_history ���̺� ���� ��й�ȣ�� ����
        
        IF :NEW.pass != :OLD.pass THEN
        INSERT INTO users_history VALUES (:NEW.userid, :OLD.pass, SYSDATE);
        END IF;
    END;
/

3. users ���̺� ��й�ȣ�� ����
user





brown�� ��й�ȣ�� ����

UPDATE USERS SET PASS = 'brownpass'
WHERE userid = 'brown';

select name, value
from users;


**�𵨸� ���� **
���� -> �� -> ����
���� : �뷫������ �׸���
       �λ�ý���
       1.�޿�, ����, ����, ��
            ==> ����������, �����߷�, ��������, �����̷�
       2.����Ƽ�� �ĺ��� ������ �̸� �׷� ���°�(�ϹݼӼ��� �߰� �Ǹ� �� ��)
         �������� �ý����� ������ ��µ� ����
         �ʹ� ���� �ý����̸� �����ϴ� ��쵵 ����
�� ��: �������� �Ӽ��� ���� �ϰ� �ý��ۿ��� �ʿ�� �ϴ� �䱸������ �𵨸� ǥ����� �̿��Ͽ�
          ������ ��
          (dbms �� Ư���� ������� ���� ��Ȳ���� ����
           dbms ������� �ʰ� ���� �ý������ε� Ȱ�� �� ���� �ִ�)
           
���� ��: �� ���� �ý��ۿ��� ����� db �ý������� �����ϴ� �۾�

���𵨸��� ���� �𵨷� 1:1 ��Ī�� �ȴٰ� �����ϴ� ��찡 ������
�ݵ�� �׷� ���� �ƴ�

��)
�� ��: �ش� �ý��۰� ���õ� ����� ==> ���� ������ ����ϴ� ����Ƽ�� ����
���� ��: ������ ����ؼ� ȸ��, ����, �ܺ����� ������ �������� ���̺�� ������ ���� ����
����        ������
 ����Ƽ          table
 �Ӽ�            column
 ����            ��������(fk)

�Խ��� �䱸���� �м�
����Ƽ, ����Ƽ �Ӽ� �м� ==> �䱸����, ���ͺ�, ���� ���� ���� ���� �ϴ� ��縦 �ľ�

�Խ���, �Խñ�, ���, ���, �ۼ���, ��ȣ, ����, ����, ÷������, �����, �ۼ���(����)
��������

����Ƽ
�Խ��� - �̸�, ��뿩��
�Խñ� - ��ȣ, ����, ����, �ۼ���, �ۼ��Ͻ�


SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);
1.
SELECT e.empno, e.ename, e.sal, s.grade
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

2.
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

ANSI
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno;

3.
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND d.deptno IN(10,30);

ANSI 
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno AND d.deptno IN(10,30);
  
4.
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND e.sal > 2500;

ANSI  
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno AND e.sal > 2500
  
  
5.
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND e.sal>2500
  AND e.empno > 7600;
  
ANSI  
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno AND e.sal>2500 AND e.empno>7600;
 
 
  
6.
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND e.sal>2500
  AND e.empno > 7600
  AND d.dname = 'RESEARCH';
  
ANSI  
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e JOIN dept d ON (e.deptno = d.deptno AND e.sal>2500 AND e.empno > 7600 AND d.dname = 'RESEARCH');