GROUP FUNCTION(�׷��Լ�)
 -�������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
 �������� �Է¹޾� �ϳ��� ������ ����� ���δ�
 
 desc emp; �÷������� ��ȸ
  EX: �μ��� �޿� ���
     emp ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10, 20, 30) �� ���� �ִ�.
     �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�
     
     �׷��Լ����� MAX(),MIN() SUM() COUNT() COUNT(*) �Լ��� �ִ�.
EX)
 �׷�ȭ ���� ���� �÷��� ����Ʈ ������ �ü� ������ �׷��Լ��� ������ ����Ʈ ���� �� �� �ֵ�.
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
 
 �ٵ� ���⼭ �׷�ȭ�� �Ǿ����� ���� �÷��� SELECT ���� �ü� ������ �׷�ȭ�� ���þ��� ���ڿ��̳� ������� �� �� �ֵ�.
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
 
 **�׷��Լ��� �����Ŀ� nvl���� �ϴ°� ���������� ����
 *GROUP �Լ� ����� NULL ���� ���ܰ� �ȴ�.
 30�� �μ����� NULL ���� ���� ���� ������ SUM(comm) �� ���� ���������� ���� �� Ȯ�� �� �� �ִ�.
 
��) SELECT deptno, SUM(comm)
    FROM emp
    GROUP BY deptno;
 
 **HAVING ��
 single row �Լ��� where ���� ��� �� �� ������
 multi row �Լ�(�׷��Լ�) �� where ���� ��� �� �� ����
 GROUP BY �� ���� HAVING ���� ������ ������ ���
 
 �������� 9000�̻��� ���� ��ȸ�Ҷ�
 SELECT deptno, SUM(sal)
 FROM emp
 GROUP BY deptno
 HAVING SUM(sal) > 9000;
 
 
 