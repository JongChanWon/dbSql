 OUTER JOIN
 ���̺� ���� ������ �����ص�, �������� ���� ���̺��� �÷��� ��ȸ�� �ǵ��� �ϴ� ���� ���
 <-->
 INNER JOIN(�츮�� ���ݱ��� ��� ���)

 LEFT OUTER JOIN   : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
 RIGHT OUTER JOIN  : ������ �Ǵ� ���̺��� JOIN Ű���� �����ʿ� ��ġ
 FULL OUTER JOIN   : LEFT OUTER JOIN + RIGHT OUTER JOIN -(�ߺ��Ǵ� �����Ͱ� �ѰǸ� ������ ó��)
 
 emp���̺��� �÷��� mgr�÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�.
 ������ KING ������ ��� ����ڰ� ���� ������ �Ϲ����� inner ���� ó����
 ���ο� �����ϱ� ������ KING�� ������ 13���� �����͸� ��ȸ�� ��.
 
 INNER ���� ����
 ����� ���, ����� �̸�, ���� ���, ���� �̸�
 
 ������ �����ؾ����� �����Ͱ� ��ȸ�ȴ�
 ==> KING�� ����� ����(mgr)�� NULL �̱� ������ ���ο� �����ϰ� 
     KING
 SELECT m.empno,m.ename, e.empno, e.ename 
 FROM emp e, emp m
 WHERE e.mgr = m.empno;
 
 ANSI
 SELECT m.empno,m.ename, e.empno, e.ename 
 FROM emp e JOIN emp m ON(e.mgr = m.empno);
 
 **���� ������ OUTER �������� ����
 (KING ������ ���ο� �����ص� ���� ������ ���ؼ��� ��������, ������ ����� ������ ���� ������ ������ �ʴ´�.)
 ;
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno );
 
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp m RIGHT OUTER JOIN emp e ON ( e.mgr = m.empno ); emp e �� ������ �Ƕ�(RIGHT �ϱ� �������� ����) 
 
 
 
 
 
 