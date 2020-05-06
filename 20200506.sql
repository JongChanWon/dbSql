DML
�����͸� �Է�(INSERT), ����(UPDATE), ����(DELETE) �Ҷ� ����ϴ� SQL

INSERT

����
INSERT INTO ���̺��[(���̺��� �÷���, ....)] VALUES (�Է��� ��, ...);

ũ�� ���� �ΰ��� ���·� ���
1.���̺��� ��� �÷��� ���� �Է��ϴ� ���, �÷����� �������� �ʾƵ� �ȴ�
  �� �Է��� ���� ������ ���̺� ���ǵ� �÷� ������ �νĵȴ�
INSERT INTO ���̺�� VALUES (�Է��� ��, �Է��� ��2...);

DESC dept; --���̺��� �÷� ������� ����(insert �Ҷ�)

2.�Է��F���� �ϴ� �÷��� ����ϴ� ���
  ����ڰ� �Է��ϰ��� �ϴ� �÷��� �����Ͽ� �����͸� �Է��� ���.
  �� ���̺� NOT NULL ������ �Ǿ��ִ� �÷��� �����Ǹ� INSERT �� �����Ѵ�
INSERT INTO ���̺�� (�÷�1, �÷�2) VALUES (�Է��� ��, �Է��� ��2);

3. SELECT ����� INSERT
   SELECT ������ �̿��ؼ� ������ ���� ��ȸ�Ǵ� ����� ���̺� �Է� ����
   ==> �������� �����͸� �ϳ��� ������ �Է��ϴ°� �����ϴ�(ONE-QUERY) ==> ���� ������ ������ ��ħ
   
   ����ڷ� ���� �����͸� ���� �Է� �޴� ��� (ex ȸ������) �� ������ �Ұ�
    db �� �����ϴ� �����͸� ���� �����ϴ� ��� Ȱ�� ����(�̷���찡 ����)
   
   INSERT INTO ���̺�� [(�÷���1, �÷���2...)]
   SELECT .... -- VALUES �� ��ſ� ����Ʈ ���� �ۼ�
   FROM ....
dept ���̺� deptno 99, dname DDIT, loc daejeon ���� �Է��ϴ� INSERT ���� �ۼ�

SELECT *
FROM dept;

INSERT INTO dept VALUES (99,'DDIT', 'daejeon');
INSERT INTO dept (loc, deptno, dname) VALUES ('daejeon', 99, 'DDIT');
�����͸� Ȯ�� �������� : commit - Ʈ����� �Ϸ�
������ �Է��� ��� �Ϸ���: rollback - Ʈ����� ���
rollback;

���� INSERT ������ ������ ���ڿ�, ����� �Է��� ���
INSERT �������� ��Į�� ��������, �Լ��� ��� ����
EX: ���̺� �����Ͱ� �� ����� �Ͻ����� ��� �ϴ� ��찡 ���� ==> SYSDATE

SELECT *
FROM emp;

emp ���̺��� ��� �÷� �� ������ 8��, NOT NULL �� 1��(EMPNO)

empno �� 9999�̰� ename�� ���� �̸�, hiredate�� ���� �Ͻø� �����ϴ� INSERT ������ �ۼ�
INSERT INTO emp (empno, ename, hiredate) VALUES (9999, 'jc', SYSDATE);

9998�� ������� jw ����� �Է�, �Ի����ڴ� 2020�� 4�� 13�Ϸ� �����Ͽ� ������ �Է�
INSERT INTO emp (empno, ename, hiredate, comm) VALUES (9998, 'JW', TO_DATE('2020/04/13', 'YYYY/MM/DD'), 300);

INSERT ���� ������� ���� �÷����� ���� NULL �� �Էµȴ�.

empno �÷��� NOT NULL (DESC emp)
INSERT INTO emp(ename, hiredate) VALUES ('JW', TO_DATE('2020/04/13', 'YYYY/MM/DD'));

3. SELECT ����� ���̺� �Է��ϱ� (�뷮 �Է�)

DESC dept;
dept ���̺��� 4���� �����Ͱ� ����(10~40)
�Ʒ������� �����ϸ� ���� ���� 4�� + SELECT �� �ԷµǴ� 4�� �� 8���� �����Ͱ� dept ���̺� �Էµ�
INSERT INTO dept
SELECT *
FROM dept;




UPDATE : ������ ����
UPDATE ���̺�� SET ������ �÷�1 = ������ ��1,
                   [������ �÷�1 = ������ ��1, ...]
[WHERE condition-SELECT ������ ��� WHERE ���� ����
        ������ ���� �ν��ϴ� ������ ���]
        
DEPT ���̺� 99, DDIT, daejeon;

INSERT INTO dept VALUES (99, 'DDIT', 'daejeon');

������ �Է� Ȯ��
SELECT *
FROM dept;

99�� �μ��� �μ����� ��� IT��, ��ġ�� ���κ������� ����

UPDATE dept SET dname = '���IT',
                loc = '���κ���'
WHERE deptno = 99;

�Ʒ� ������ dept ���̺��� ��� ���� �μ���� ��ġ�� �����ϴ� ����
UPDATE dept SET dname = '���IT',
                loc = '���κ���'   --������ ����!!

INSERT : ���� �� ���� ����
UPDATE, DELETE : ������ �ִ°� ����, ����
    ==> ������ �ۼ��� ��� ����
        1. WHERE ���� �������� �ʾҴ���
        2. UPDATE, DELETE ���� �����ϱ� ���� WHERE ���� �����ؼ� SELECT �� �Ͽ� 
            ������ ���� ���� ������ Ȯ��
**ORACLE ����ڿ��Դ� UPDATE, DELETE �� �Ǽ� ���� ��� �ѹ��� ��ȸ�� ����
ROLLBACK;
COMMIT �ϱ� �������� �����Ͱ� �ѹ��
EX) SELECT *
    FROM dept
    WHERE deptno = 99;


���������� �̿��� ������ ����
INSERT INTO emp (empno, ename, job) VALUES (9999, 'brown', NULL);

9999�� ������ deptno, job �ΰ��� �÷��� smith ����� ������ �����ϰ� ����

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH') ,
               job = (SELECT job FROM emp WHERE ename = 'SMITH'),
               sal = (SELECT sal FROM emp WHERE ename = 'SMITH'),
               comm = (SELECT comm FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

�Ϲ����� UPDATE ���������� �÷����� ���������� �ۼ��Ͽ� ��ȿ���� ����
 ==> MERGE ������ ���� ��ȿ���� ���� �� �� �ִ�.
 
 [] -- ���ȣ �κ��� �ɼ�
DELETE : ���̺� �����ϴ� �����͸� ����
����
DELETE [FROM] ���̺��
[WHERE codition]  

������
1. Ư�� �÷��� ���� ���� ==> �ش� �÷��� NULL�� UPDATE
   DELETE���� �� ��ü�� ����
   
2. UPDATE �� ���������� DELETE ������ �����ϱ� ���� SELECT �� ���� ���� ����̵Ǵ� ���� ��ȸ, Ȯ������

���� �׽�Ʈ ������ �Է�
INSERT INTO emp (empno, ename, job) VALUES (9999, 'brown', NULL);
����� 9999���� ���� �����ϴ� ����

DELETE emp
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno = 9999;

rollback;

�Ʒ� ������ �ǹ�: emp ���̺��� ��� ���� ����
DELETE emp;

UPDATE, DELETE ���� ��� ���̺� �����ϴ� �����Ϳ� ����, ������ �ϴ� ���̱� ������
��� ���� �����ϱ� ���� WHERE ���� ��� �� �� �ְ�
WHERE ���� SELECT ������ ����� ������ ���� �� �� �ִ�.
���� ��� ���������� ���� ���� ������ ����


�Ŵ����� 7698�� �������� ��� ���� �ϰ� ���� ��


DELETE emp
WHERE empno
        (SELECT *
         FROM emp
         WHERE mgr = 7698);

--�������� �����ʹ� 8���̰� empno �÷��� �Ѱ��̴ϱ� �����߻� �׷��� ����Ʈ���� �ٲٰ���� �÷��� ���������� �������ش�

DELETE emp
WHERE empno
        (SELECT empno
         FROM emp
         WHERE mgr = 7698);


DML : SELECT, INSERT, UPDATE, DELETE
WHERE ���� ��� ������ DML: SELECT, UPDATE, DELETE
    3���� ������ �����͸� �ĺ��ϴ� WHERE ���� ��� �� �� �ִ�.
    �����͸� �ĺ��ϴ� �ӵ��� ���� ������ ���� ������ �¿��.
    ==> INDEX ��ü�� ���� �ӵ� ����� ����
    
    
INSERT : ������� �ű� �����͸� �Է��ϴ� ��
         ������� �ĺ��ϴ°� �߿�
         ==> �����ڰ� �� �� �ִ� Ʃ�� ����Ʈ�� ���� ����

���̺��� �����͸� ����� ��� (��� ������ �����)
1. DELETE : WHERE ���� ������� ������ ��
2. TRUNCATE 
    ����: TRUNCATE TABLE ���̺��
    Ư¡ : 1) ������ �α׸� ������ ����
            ==> ���� �Ұ���
          2) �α׸� ������ �ʱ� ������ ���� �ӵ��� ������
            ==> �ȯ�濡���� �� ������� ���� (������ �ȵǱ� ������)
                �׽�Ʈ ȯ�濡�� �ַ� ���
                
�����͸� �����Ͽ� ���̺� ����(���� �غ���)

CREATE TABLE emp_copy AS
SELECT *
FROM emp;
                
SELECT *
FROM emp_copy;


emp_copy ���̺��� truncate ����� ���� ��� ������ ����
 TRUNCATE TABLE emp_copy;
rollback;

Ʈ�����: ������ ���� ����
ex: ATM - ��ݰ� �Ա��� �Ѵ� ���������� �̷������ ������ �߻����� ����
          ����� ���� ó�� �Ǿ����� �Ա��� ������ ó�� �Ǿ��ٸ�
          ���� ó���� ��ݵ� ��Ҹ� ����� �Ѵ�.

���
�Ա�(����) �ϸ� ROLLBACK �������

����Ŭ������ ù��° DML�� ������ �Ǹ� Ʈ���� �������� �ν�
Ʈ������� ROLLBACK, COMMIT �� ���� ���ᰡ �ȴ�

Ʈ����� ���� �� ���ο�  DML�� ����Ǹ� ���ο� Ʈ������� ����

��� ����ϴ� �Խ����� ������ ����
�Խñ� �Է� �� �� �Է� �ϴ°�: ����(����1��), ����(1��), ÷������(��������)
RDBMS ������ �Ӽ��� �ߺ��� ��� ������ ����Ƽ(���̺�) �� �и��� �Ѵ�
�Խñ� ���̺�(����, ����) / �Խñ� ÷������ ���̺�(÷�����Ͽ� ���� ����)

�Խñ� �ϳ� ����� �ϴ���
�Խñ� ���̺��, �Խñ� ÷������ ���̺� �����͸� �űԷ� ��� �Ѵ�.
INSERT INTO �Խñ� ���̺� (����, ����, �����, ����Ͻ�) values (......);
INSERT INTO �Խñ� ÷������ ���̺� (÷�����ϸ�, ÷������ ������) values (......);

�ΰ��� INSERT ������ �Խñ� ����� Ʈ����� ����
�� �ΰ��߿� �ϳ��� ������ ����� �Ϲ������� ROLLBACK�� ���� �ΰ��� INNER ������ ���.




























