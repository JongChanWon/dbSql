 JOIN 1]
 --���̺���� �ϰ����ְ�..�÷���
 SELECT lprod_gu, lprod_nm, prod_id, prod_name
 FROM lprod, prod
 WHERE lprod.lprod_gu = prod.prod_lgu;
 
 join 2]
 SELECT BUYER_ID, BUYER_NAME, PROD_ID, PROD_NAME
 FROM prod, buyer
 WHERE prod.prod_buyer = buyer.buyer_id;
 
 join3] --��� �Ǽ��� �˷��� count
 --������ �ζ��κ並 ����ϸ� �ؼ��ϱ� ����
 SELECT COUNT(*)
 FROM
    (SELECT  BUYER_ID, BUYER_NAME, PROD_ID, PROD_NAME
     FROM prod, buyer
     WHERE prod.prod_buyer = buyer.buyer_id);
 -- �ؿ�ó��
 
 SELECT BUYER_ID, BUYER_NAME, PROD_ID, PROD_NAME
 FROM buyer,prod
 WHERE buyer.buyer_id = prod.prod_buyer;
 
 buyer_name �� �Ǽ� ��ȸ ���� �ۼ�
 buyer_name, �Ǽ�
 
 SELECT buyer.buyer_name, COUNT(*)
 FROM prod, buyer
 WHERE prod.prod_buyer = buyer.buyer_id
 GROUP BY buyer.buyer_name;
 
 JOIN 3]
 
 SELECT member.MEM_ID, member.MEM_NAME, prod.PROD_ID, prod.PROD_NAME, cart.CART_QTY
 FROM member, cart, prod
 WHERE MEMBER.mem_id = cart.cart_member
   AND cart.cart_prod = prod.prod_id;
 
 join 3 �� �Ƚù������� 
 ���̺� join ���̺� on/using 
  
 SELECT member.MEM_ID, member.MEM_NAME, prod.PROD_ID, prod.PROD_NAME, cart.CART_QTY
 FROM member, cart, prod
 WHERE MEMBER join cart on (member.mem_id = cart.cart_member)
              join prod on (cart.cart_prod = prod.prod_id);
 
 �������]
 �ΰ��� ������ ������ �ణ,,,�����ؾߵǳ�
 SELECT *
 FROM
      (SELECT deptno, COUNT(*)
        FROM emp
        GROUP BY deptno)
 WHERE deptno = 30;
 
 SELECT deptno, COUNT(*)
 FROM emp
 WHERE deptno = 30
 GROUP BY deptno;
 
 cid : customer id
 cnm : customer name
 SELECT *
 FROM customer;
 
 pid : porduct id
 pnm : product name
 SELECT *
 FROM product;
 
 
 cycle : �����ֱ�
 cid : �� id
 pid : ��ǰ id
 day : �������� (�Ͽ��� -1, ���糯-2�Դ���, ȭ�糯 �Դ���...)
 cnt : ����
 SELECT *
 FROM cycle;
 
 JOIN 4]
 SELECT customer.CID, customer.cnm, CYCLE.pid, CYCLE.DAY,CYCLE.cnt 
 FROM customer, cycle
 WHERE customer.cid = cycle.cid
   AND customer.cnm IN('brown','sally');
   
 SELECT customer.CID, cnm, pid, DAY, cnt --cid�� ����ִ� cid���� �𸣴ϱ� ��� ������� 
 FROM customer, cycle
 WHERE customer.cid = cycle.cid
   AND customer.cnm IN('brown','sally');
 
 natural join  
 SELECT cid,cnm, pid, day,cnt 
 FROM customer NATURAL JOIN cycle
 WHERE customer.cid = CYCLE.cid;
  --�Ƚô� ����Ŭ�� �ٸ��� cid �տ� ��ø� ���ָ� �ȵ�
   
 join 5]
   
 SELECT customer.CID, customer.cnm, CYCLE.pid, product.pnm, CYCLE.DAY, CYCLE.cnt 
 FROM customer, cycle, product
 WHERE customer.cid = cycle.cid
   AND cycle.pid = product.pid
   AND customer.cnm IN('brown','sally');
   
join 6] --�׷�������� �� �÷����� ����Ʈ���� �������ϰ� ��Ƽ�ο������ ���� 
        --�׷�������� ���� �ʾƵ� �ȴ�.
SELECT customer.cid, customer.cnm, CYCLE.pid, product.pnm, SUM(CYCLE.cnt)cnt
 FROM customer, cycle, product
 WHERE customer.cid = cycle.cid
   AND CYCLE.pid = product.pid
GROUP BY customer.cid, customer.cnm, CYCLE.pid, product.pnm
ORDER BY customer.cid, CYCLE.pid;
--count(cnt)- cnt �÷��� null�� �ƴ� ���ǰ���

join 7]
SELECT product.pid, product.pnm, SUM(CYCLE.cnt)cnt
FROM product, cycle
WHERE cycle.pid = product.pid
 GROUP BY product.pid, product.pnm;
 
 --�׷���� ������ �ص��� ����Ŭ�̶� ��ġ�� �ʾƼ�
SELECT product.pid, product.pnm, SUM(CYCLE.cnt)cnt
FROM product, cycle
WHERE cycle.pid = product.pid
 GROUP BY product.pid, pnm;
 
 SELECT a.pid, b.pnm, a.cnt
 FROM
    (SELECT pid, SUM(cnt)
    FROM cycle
    GROUP BY  cycle.pid) a, product b
 WHERE b.pid = b.pid; 
 

join 8~13 >>>����!! Ʋ��������,,����
 
 
 
 
 
 
 
 
 
 
 
 
