NULL ó�� �ϴ� ��� (4���� �߿� ���� ���Ѱɷ� �ϳ� �̻��� ���)
 NVL, NVL2...
 
 SELECT NVL(empno,0), ename, NVL(sal, 0), NVL(comm, 0) --�̷��� �� �ʿ� ����
 FROM emp; 
 
 cnodition : CASE, DECODE
 
 �����ȹ : �����ȹ�� ���� ���� ����;
 
 SELECT empno, ename, job, deptno,
    DECODE(job,
           'SALESMAN', sal * 1.05
           'MANAGER', DECODE(deptno, 10, sal * 1.30, sal * 1.10),
           'PRESIDENT', sal * 1.20,
           sal) bo
           
 FROM emp;
 
 ���� A = {10, 15, 18, 23, 24, 25, 29, 30, 35, 37}
 �Ҽ� : {23, 29, 37}
 ��Ҽ�: {10, 15, 18, 24, 25, 30, 35}
 
 
 GROUP FUNCTION
 �������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
 �������� �Է¹޾� �ϳ��� ������ ����� ���δ�
 EX: �μ��� �޿� ���
     emp ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10, 20, 30) �� ���� �ִ�.
     �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�
     
 GROUP BY ����� ���ǻ���: SELECT ����� �� �ִ� �÷��� ���ѵ�    
 SELECT �׷��� ���� �÷�, �׷��Լ�
 FROM ���̺�
 GROUP BY �׷��� ���� �÷�
 [ORDER BY ];
 
 �μ����� ���� ���� �޿� ��
 
 SELECT deptno, MAX(sal)
 FROM emp
 GROUP BY deptno;
 
 group by ���ؿ� ��߳��� �÷��� ���� ������ �ȵȴ�
 and �׷��Լ��� �������� ������ ������
 SELECT deptno, sal
 FROM emp
 ORDER BY deptno, sal;
 
 
 emp ���̺��� �׷� ������ �μ���ȣ�� �ƴ� ��ü �������� ���� �ϴ� ���
 SELECT deptno, MIN(sal), --select������ deptno �� ���� ���� ������ �ٸ� group by �� ������ ���� �÷��� ���� �ȵ�
        MAX(sal), --�μ����� ���� ���� �޿� ��
        MIN(sal), --�μ����� ���� ���� �޿� ��
        ROUND(AVG(sal), 2), --�μ��� �޿� ���
        SUM(sal), --�μ��� �޿� �հ�
        COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null �� �ƴ� row�� ��)
        COUNT(*),    --�μ��� ���� ��
        COUNT(mgr)
 FROM emp
 GROUP BY deptno;
 
 * �׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� ���� ������
   ���� ���� �޿��� �޴� ����� �̸��� �� ���� ����
     ==> ���� WINDOW/�м� FUNCTION�� ���� �ذ� ����
     
 ��ü������ ������� �޿���, ��ü������ ���峷�� �޿���, ��ü������ �޿����, ��ü ������ �޿� ��, ��ü ������ �޿� ���
 ��ü������ �޿���, ��ü ������ �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
 ��ü ���� ��, mgr�÷��� null�� �ƴ� �Ǽ� --PT�� ��������
 
 2020.04.27 ��ǥ�� ���� Ȯ��
 GROUP BY ���� ����� �÷���
    SELECT ���� ������ ������ ��� �ȴ�(????)
    
 GROUP BY ���� ������� ���� �÷���(????)
    SELECT ���� ������ ����;
 
 --�׷�ȭ�� ���þ��� ������ ���ڿ��̳� ������� SELECT ���� ǥ�� �� �� �ִ�(���� �ƴ�)
 
 SELECT deptno, MIN(sal), 'TEST', 1, --select������ deptno �� ���� ���� ������ �ٸ� group by �� ������ ���� �÷��� ���� �ȵ�
        MAX(sal), --�μ����� ���� ���� �޿� ��
        MIN(sal), --�μ����� ���� ���� �޿� ��
        ROUND(AVG(sal), 2), --�μ��� �޿� ���
        SUM(sal), --�μ��� �޿� �հ�
        COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null �� �ƴ� row�� ��)
        COUNT(*),    --�μ��� ���� ��
        COUNT(mgr)
 FROM emp
 GROUP BY deptno;
 
 �׷��Լ����� NULL �÷��� ����
 
 SELECT deptno
 FROM emp;
 
 GROUP �Լ� ����� NULL ���� ���ܰ� �ȴ�.
 30�� �μ����� NULL ���� ���� ���� ������ SUM(comm) �� ���� ���������� ���� �� Ȯ�� �� �� �ִ�.
 SELECT deptno, SUM(comm)
 FROM emp
 GROUP BY deptno;
 
 10��, 20�� �μ��� SUM(comm) �÷��� NULL�� �ƴ϶� 0�� �������� NULLó��
 *Ư���� ������ �ƴϸ� �׷��Լ� ������� NULL ó���� �ϴ� ���� ���ɻ� ����
 
 NVL(SUM(comm), 0) : comm�÷��� sum �׷��Լ��� �����ϰ� ���� ����� NVL�� ����(1ȸ ȣ��) --�� ǥ���� �� ����
 SUM(NVL(comm, 0)) : ��� comm �÷��� nvl �Լ��� ������(�ش� �׷��� row�� ��ŭ ȣ��) sum �׷��Լ� ����
 
 SELECT deptno, SUM(NVL(comm, 0)), NVL(SUM(comm), 0)
 FROM emp
 GROUP BY deptno;
 
 single row �Լ��� where ���� ��� �� �� ������
 multi row �Լ�(�׷��Լ�) �� where ���� ��� �� �� ����
 GROUP BY �� ���� HAVING ���� ������ ���
 
 SELECT *
 FROM emp
 WHERE LOWER(ename) = 'smith';
 
 �μ��޿��� 9000�� �Ѵ� �μ�
 SELECT deptno, SUM(sal)
 FROM emp
 WHERE SUM(sal) > 9000
 GROUP BY deptno;
 
 SELECT deptno, SUM(sal)
 FROM emp
 GROUP BY deptno
 HAVING SUM(sal) > 9000;
 
 GRP1]
 
 SELECT MAX(sal),
        MIN(sal),
        ROUND(AVG(sal), 2),
        SUM(sal),
        COUNT(sal),
        COUNT(mgr),
        COUNT(*)        
 FROM emp;

 
 grp2]
 
SELECT deptno,
        MAX(sal)max_sal,
        MIN(sal)min_sal,
        ROUND(AVG(sal), 2)avg_sal,
        SUM(sal)sum_sal,
        COUNT(sal)count_sal,
        COUNT(mgr)count_mgr,
        COUNT(*)count_all
 FROM emp
 GROUP BY deptno;
 
 grp3]
 
SELECT deptno,  DECODE(deptno, 10, 'ACCOUNTING',
                       20, 'RESEARCH',
                       30, 'SALES',
                       40, 'OPERATIONS')job,             
        MAX(sal)max_sal,
        MIN(sal)min_sal,
        ROUND(AVG(sal), 1)avg_sal,
        SUM(sal)sum_sal,
        COUNT(sal)count_sal,
        COUNT(mgr)count_mgr,
        COUNT(*)count_all
 FROM emp
 GROUP BY deptno;
 
 
 SELECT TO_CHAR(hiredate,'YYYYMM')HIRE_YYYYMM, COUNT(hiredate)cnt
 FROM emp
 GROUP BY TO_CHAR(hiredate,'YYYYMM')
 ORDER BY TO_CHAR(hiredate,'YYYYMM'); --���̾��Ʈ ������ ����
 
 
 
 SELECT TO_CHAR(hiredate,'YYYY')HIRE_YYYY, COUNT(hiredate)cnt
 FROM emp
 GROUP BY TO_CHAR(hiredate,'YYYY')
 ORDER BY TO_CHAR(hiredate,'YYYY');
 
 grp6]
 SELECT SUM(COUNT(deptno))cnt
 FROM dept
 GROUP BY deptno;
 
 SELECT COUNT(*)
 FROM dept;
 
 SELECT TO_CHAR(hiredate,'yyyy')cnt
 FROM emp
 GROUP BY deptno,hiredate;
 
 
 
 
 
 
 
 
 
 
 
 