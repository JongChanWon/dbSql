 �־����� : ����� ����ִ� ���ڿ� '201912' ==> 31
 SELECT TO_DATE(:yyyymm, 'YYYYMM'))param, '31' DT
        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), --���ε庯���� ġȯ�Ϸ��� �տ� :(�ݷ�) �� ���̸� �ȴ�
        TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')
 FROM dual;
 
 
 *LAST_DAY(DATE1) DATE1 �� ���� ���� ������ ��¥�� ��ȯ
 ++������ ��¥�� ���ϴ°�++ �߿�!
 SYSDATE: 2020/04/21 ==> 2020/04/30
 SELECT LAST_DAY(SYSDATE)
 FROM dual;
 LAST_DAY(TO_DATE('201602', 'YYYYMM')) param
 NULL���� ���� ū������ �Ѵ�
 
 EXPLAIN PLAN FOR
 SELECT *
 FROM emp
 WHERE empno='7369';
 
 SELECT *
 FROM TABLE(DBMS_XPLAN.DISPLAY);
 
 �����ȹ�� ���� ����(id)
 * �鿩���� �Ǿ������� �ڽ� ���۷��̼�
 1. ������ �Ʒ���
    *�� �ڽ� ���۷��̼��� ������ �ڽĺ��� �д´�
    
    1 ==> 0�� ������ �д´�
 Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |-- �״��� �θ�
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |-- �鿩���� �������ϱ� �ڽĺ���
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)
 
Note
-----
   - dynamic sampling used for this statement (level=2)
 
 
--------------------------------------------------------
 
 EXPLAIN PLAN FOR
 SELECT *
 FROM emp
 WHERE TO_CHAR(empno) = '7369';
 
 SELECT *
 FROM TABLE(DBMS_XPLAN.DISPLAY);
 
 Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_CHAR("EMPNO")='7369')
 
Note
-----
   - dynamic sampling used for this statement (level=2)
 
 EXPLAIN PLAN FOR
 SELECT *
 FROM emp
 WHERE empno = 7300+ '69'; --���ڿ������� ���ϱ� �����ڸ� �����µ� SQL������ ���ڷ� �ν��Ѵ�.
 
 SELECT *
 FROM TABLE(DBMS_XPLAN.DISPLAY);
 
 Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_CHAR("EMPNO")='7369')
 
Note
-----
   - dynamic sampling used for this statement (level=2)
   
   
i18n

000900
0001000
SELECT ename, sal, TO_CHAR(sal, 'L009,999.00')
FROM emp;
 
 NULL�� ���õ� �Լ�
 NVL
 NVL2
 NULLIF
 COALESCE;
 
 
 �� NULL ó���� �ؾ��ұ�?
 NULL�� ���� �������� NULL�̴�.
 ���� �� emp���̺� �����ϴ� sal, comm �ΰ��� �÷� ���� ���� ���� �˰� �;
 ������ ���� SQL�� �ۼ�.
 
 SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
 FROM emp;
 
 
 NVL(expr1,expr2) 
 expr1�� null�̸� expr2���� �����ϰ�
 expr1�� null�ƴϸ� expr1���� ����
 
 SELECT empno, ename, sal, comm, sal+ NVL(comm, 0) sal_plus_comm --comm �϶� 0 �� ���� �ϰڴ�.
 FROM emp;
 
 SELECT userid, usernm, reg_dt, NVL(reg_dt, LAST_DAY(SYSDATE)) dt
 FROM users;
 
 
 
 
 
 
 
 
 
 
 
 