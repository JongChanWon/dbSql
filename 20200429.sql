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
 
 *ANSI-SQL : OUTER
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno );
 
 ���̺� ����Ű���� ���̺�
 
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp m RIGHT OUTER JOIN emp e ON ( e.mgr = m.empno ); emp e �� ������ �Ƕ�(RIGHT �ϱ� �������� ����) 
 
 *ORACLE-SQL : OUTER
 oracle join
 1. FROM���� ������ ���̺� ���(�޸��� ����)
 2. WHERE���� ���� ������ ���
 3. ���� �÷�(�����)�� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ��ش�
   ==> ������ ���̺� �ݴ����� ���̺��� �÷�
   
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e,emp m --emp e �� ������ ���̺��̴ϱ� �ݴ����ʿ� (+)�� ����
 WHERE e.mgr = m.empno(+);
 
 OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ
 
 *������ ����� �̸�, ���̵� �����ؼ� ��ȸ
 ��, ������ �ҼӺμ��� 10���� ���ϴ� �����鸸 �����ؼ�;
 
 ������ ON���� ���������
 
 ���ο� ���� ������ 
 SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
 FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno AND e.deptno = 10 );
 
 ������ WHERE���� ���������
 SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
 FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno )
 WHERE e.deptno = 10;
 
 **OUTER ������ �ϰ� ���� ���̶�� ������ ON���� ����ϴ°� �´�
   WHERE ���� ����ص��Ǵµ� OUTER������ ȿ���� �������� (INNER �������� ��ȯ��)
 
 ORACLE -SQL
 SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
 FROM emp e, emp m 
 WHERE e.mgr = m.empno(+)
   AND e.deptno = 10;
   
 @��������@
 
 SELECT *
 FROM buyprod
 WHERE buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');
 
 --��� ������ �Ǵ°��� �䱸���׿����� �޶�����
 --�����̵Ǵ� �÷�(master) �ݴ��� (+)�ٿ������ where���� and�� ���� ��� ������ �ش�Ǵ� ���(�����͹ݴ���) �÷��� ,,,
 SELECT b.buy_date, b.buy_prod, p.prod_id, P.prod_name, b.buy_qty
 FROM buyprod b, prod p
 WHERE b.buy_prod(+) = p.prod_id
   AND b.buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD'); 
   
 SELECT b.buy_date, b.buy_prod, p.prod_id, P.prod_name, b.buy_qty
 FROM buyprod b RIGHT OUTER JOIN prod p ON ( b.buy_prod = p.prod_id AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));  
 
 SELECT b.buy_date, b.buy_prod, p.prod_id, P.prod_name, b.buy_qty
 FROM prod p LEFT OUTER JOIN buyprod b ON ( b.buy_prod = p.prod_id AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));  
***���� 3���� ������ ������ ����� ���´�***   
 
 OUTER JOIN 2]
 SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD')buy_date, b.buy_prod, p.prod_id, P.prod_name, b.buy_qty --select���� �׳� ����� ���� �� �ִ�
 FROM buyprod b, prod p
 WHERE b.buy_prod(+) = p.prod_id
   AND b.buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
   
 OUTER JOIN 3]
 
 SELECT NVL(b.buy_date,'05/01/25'), b.buy_prod, p.prod_id, P.prod_name, NVL(buy_qty, 0)
 FROM buyprod b, prod p
 WHERE b.buy_prod(+) = p.prod_id
   AND b.buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
   
 OUTER JOIN 4]
 
 SELECT p.pid, pnm, NVL(cid,1), NVL(day,0), NVL(cnt,0)
 FROM cycle c, product p
 WHERE c.pid(+) = p.pid
   AND cid(+) = 1; 
   
 --1�� ��ó�� ���ص� �ؿ� ����ó�� ǥ���ϴ°� �� ����
 SELECT p.pid, pnm, 1 cid, NVL(day,0), NVL(cnt,0)
 FROM cycle c, product p
 WHERE c.pid(+) = p.pid
   AND cid(+) = 1; 
   
 SELECT *
 FROM product p LEFT OUTER JOIN cycle c ON ( p.pid = c.pid
 WHERE;
 
 �ƿ��� ���� ����Ŭ����
 SELECT p.pid, pnm, 1 cid, NVL(day,0)day, NVL(cnt,0)cnt
 FROM cycle c, product p
 WHERE c.pid(+) = p.pid
 AND cid(+) = 1; 
 
 SELECT p.pid, pnm, 1 cid, NVL(day,0)day, NVL(cnt,0)cnt
 FROM 
    (SELECT p.pid, pnm, 1 cid, NVL(day,0)day, NVL(cnt,0)cnt
     FROM cycle c, product p
     WHERE c.pid(+) = p.pid
     AND cid(+) = 1),customer
 WHERE c.pid(+) = p.pid;
 
 SELECT product.pid, product.pnm, 1 cid, NVL(cycle.day, 0), NVL(cycle.cnt,0)cnt
 FROM product LEFT OUTER JOIN cycle ON (product.pid = cycle.pid AND cycle.cid=1)
                         JOIN customer ON (customer name = 'brown');
                         
 JOIN 5]
 
 SELECT *
 FROM cycle, product, customer
 WHERE 
                         
 SELECT m.empno,m.ename, e.empno, e.ename 
 FROM emp e, emp m
 WHERE e.mgr(+) = m.empno --�ƿ��������� �����̵Ǵ� �÷� �ݴ����÷���(+)
 ORDER BY mgr;
 
 customer���̺��� �߰��ϸ�
 45��
 �տ� �ΰ��� �ϸ� 15��
 15 -> 45
 
 SELECT *
 FROM product, cycle, customer
 WHERE product.pid = cycle.pid;
 
 CROSS JOIN
 ���� ������ ������� ���� ���
 ��� ������ ���� �������� ����� ��ȸ�ȴ�
 
 emp 14 * dept 4 = 56
 ANSI-SQL
 SELECT *
 FROM emp CROSS JOIN dept;
 
 ORACLE-SQL(�������̺� ����ϰ� where���� ������ ������� �ʴ´�.
 SELECT *
 FROM emp, dept;  
 
 crossjoin 1]
 SELECT cid, cnm, pid, pnm
 FROM customer, product;
      
 'TEST' ���ڿ� �߿� "" �ֵ���ǥ �ƴ�
 
 ��������(�߿�) -- �������� �ϱ⿡ ����
 WHERE : ������ �����ϴ� �ุ ��ȸ �ǵ��� ����
 SELECT *
 FROM emp
 WHERE 1 = 1
    OR 1 != 1;
 
 ���� <==> ����
 ���������� �ٸ� ���� �ȿ��� �ۼ��� ����
 �������� ������ ��ġ (3���� ����)
 1.SELECT ��
    SCALAR SUB QUERY
    * ��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� �Ѱ��� �÷��̾�� �Ѵ�
     EX) DUAL���̺�
    
 2.FROM ��
    INLINE-VIEW
    SELECT ������ ��ȣ�� ���� ��
    
 3.WHERE��
    SUB QUERY
    WHERE ���� ���� ������ ��������
    
    
SMITH�� ���� �μ��� ���� �������� ���� ������?

 1. SMITH�� ���� �μ��� �������??
 2. 1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ
 
 ==> �������� 2���� ������ ���� ����
     �ι�° ������ ù��°�� ������ ����� ���� ���� �ٸ��� �����;� �Ѵ�.
     (SMITH(20) => WARD(30) ==> �ι�° ���� �ۼ��� 20������ 30������ ������ ���� 
      ==> �������� ���鿡�� ����)
 
 ù��° ����;     
 SELECT deptno     --20
 FROM emp
 WHERE ename = 'SMITH'
 
 �ι�° ����;
 SELECT *
 FROM emp
 WHERE deptno = 20;
 
 ���������� ���� ���� ���� 
 SELECT *
 FROM emp
 WHERE deptno = (SELECT deptno     --20
                FROM emp
                WHERE ename = 'SMITH'); --WHERE �� ���������� ��ȣ�� ���������
 
 SELECT *
 FROM emp
 WHERE deptno = (SELECT deptno     --20
                FROM emp
                WHERE ename = :ename); -- :ename �� �ؼ� �ζ��κ� ȭ �� �� �ִ�,, �ڹٿ� �����Ҷ� 
   
 
 
 SELECT ROUND(AVG(sal), 2)
 FROM emp;
 
 SUB 1]
 SELECT COUNT(*)
 FROM emp
 WHERE sal > (SELECT AVG(sal)
              FROM emp);

 SUB 2]
 SELECT *
 FROM emp
 WHERE sal > (SELECT AVG(sal)
              FROM emp);


 
 
 


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 