SELECT lprod_id, lprod_gu, lprod_nm --��絥���͸� *�� �ᵵ��
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT cart_member, cart_no, cart_prod, cart_qty --��絥���͸� *�� �ᵵ��
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

--SQL ���� : JAVA�� �ٸ��� ���� X, �Ϲ��� ��Ģ����
--int b = 2;  = ���� ������, == ��;

--SQL ������ Ÿ�� : ����, ����, ��¥(date)

--USERS ���̺��� (4/14 ����� ����) ����
--USERS ���̺��� ��� �����͸� ��ȸ;

--��¥ Ÿ�Կ� ���� ���� : ��¥�� +, - ���� ����
--date type + ���� : date ���� ���� ��¥��ŭ �̷� ��¥�� �̵�
--date type - ���� : date ���� ���� ��¥��ŭ ���� ��¥�� �̵�

SELECT userid, reg_dt + 5, reg_dt + 5 after_5days, reg_dt -5 --�÷����� after 5days ó�� ���� �� �� �ִ�.
FROM users;

-- ;
-- �÷� ��Ī : ���� �÷����� ���� �ϰ� ���� ��
-- syntax : ���� �÷��� [as] ��Ī��Ī (�˸��߽�)
-- ��Ī ��Ī�� ������ ǥ���Ǿ�� �� ��� ���� �����̼����� ���´�.
--���� ����Ŭ������ ��ü���� �빮�� ó�� �ϱ� ������ �ҹ��ڷ� ��Ī�� �����ϱ� ���ؼ���
--���� �����̼��� ����Ѵ�.

SELECT userid as id, userid id2
FROM users;

SELECT prod_id id, prod_name name
FROM prod;

SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

SELECT buyer_id ���̾���̵�, buyer_name �̸�
FROM buyer;


--���ڿ� ����(���տ���) : || (���ڿ� ������ + �����ڰ� �ƴϴ�) /*���ڿ��� �̱������̼����� ǥ����*/
SELECT /*userid + 'test'*/ userid || 'test', reg_dt + 5, 'test', 15
FROM users;

--�� �̸� ��
SELECT '�� ' || userid || ' ��'
FROM users;

--userid �÷��̶� usernm �÷��̶� ���ļ� �����޶� (||)
--concat(����)
SELECT userid, usernm, userid || usernm as id_name,
        CONCAT(userid, usernm) as concat_id_name
FROM users;

SELECT '���̵� : ' || userid,
        '���̵� : ' || userid as "id userid"
FROM users;

--user_tables : oracle �����ϴ� ���̺� ������ ��� �ִ� ���̺�(view��� ��ü) ==> ��Ʋ� data dictionary ��� ��
SELECT *
FROM user_tables;

SELECT 'SELECT * FROM ' || table_name || ';' as "query"
FROM user_tables;

SELECT CONCAT('SELECT * FROM') as concat_table_name 
FROM user_tables;

���̺��� ���� �÷��� Ȯ��
1. tool(SQL developer)�� ���� Ȯ��
   ���̺�- Ȯ���ϰ��� �ϴ� ���̺�
2. SELECT *
   FROM ���̺�
   �ϴ� ��ü ��ȸ --> ��� �÷��� ǥ��
3. DESC ���̺��
4. data dictionary : user_tab_columns

DESC emp;

SELECT *
FROM user_tab_columns;

���ݱ��� ��� SELECT ����
��ȸ�ϰ��� �ϴ� �÷� ��� : SELECT
��ȸ�� ���̺� ��� : FROM
��ȸ�� ���� �����ϴ� ������ ��� : WHERE
WHERE ���� ����� ������ ��(True) �� �� ����� ��ȸ
java�� �� ���� : a������ b������ ���� ������ �� ==
sql�� �� ����: =

--WHERE ���� �� �÷����� �� �ʿ� ����
SELECT *
FROM users
WHERE userid = 'cony';

emp���̺��� �÷��� ������ Ÿ���� Ȯ��;
DESC emp;

'1234', 1234
���ڿ� ���ͷ�, ���� ���ͷ�

SELECT *
FROM emp;

emp : emplyee
empno : �����ȣ
ename : ����̸�
job : ��å
MGR : �����(������)
hiredate : �Ի�����
sal : �޿�
comm : ������
deptno : �μ���ȣ

SELECT *
FROM dept;

emp���̺��� ������ ���� �μ���ȣ�� 30�� ���� ū(>) �μ��� ���� ������ ��ȸ;

SELECT *
FROM emp
WHERE deptno > 10;

users ���̺��� ����� ���̵� (userid) brown�� �ƴ� ����ڸ� ��ȸ

SELECT *
FROM users
WHERE userid != 'brown'; --�����̼��� �Ⱥ����� �÷��̶�� ������

SQL ���ͷ�
���� : ....20, 30.5 ~~~
���� : �̱� �����̼� : 'hello world'
��¥ : TO_DATE ('��¥���ڿ�', '��¥ ���ڿ��� ����');

1982�� 1�� 1�� ���Ŀ� �Ի��� ������ ��ȸ
������ �Ի����� : hiredate �÷�
emp���̺��� ���� : 14��
1982�� 1��1�� ���� �Ի��ڰ�: 3��
1982�� 1��1�� ���� �Ի��ڰ�: 11��
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD'); --('1982/01/01', '1982/01/01) ���ڿ� ���ĸ� ���缭 �ۼ��ϸ��

hiredate���� �⵵ ǥ�� ����� tool ������ 2�ڸ����� ǥ���
�̰� ȯ�漳������ 4�ڸ����� ���� �����ϴ�.


   
   