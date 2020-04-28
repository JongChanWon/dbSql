 JOIN 1]
 --테이블명은 일관성있게..컬럼명도
 SELECT lprod_gu, lprod_nm, prod_id, prod_name
 FROM lprod, prod
 WHERE lprod.lprod_gu = prod.prod_lgu;
 
 join 2]
 SELECT BUYER_ID, BUYER_NAME, PROD_ID, PROD_NAME
 FROM prod, buyer
 WHERE prod.prod_buyer = buyer.buyer_id;
 
 join3] --결과 건수를 알려면 count
 --과도한 인라인뷰를 사용하면 해석하기 힘듦
 SELECT COUNT(*)
 FROM
    (SELECT  BUYER_ID, BUYER_NAME, PROD_ID, PROD_NAME
     FROM prod, buyer
     WHERE prod.prod_buyer = buyer.buyer_id);
 -- 밑에처럼
 
 SELECT BUYER_ID, BUYER_NAME, PROD_ID, PROD_NAME
 FROM buyer,prod
 WHERE buyer.buyer_id = prod.prod_buyer;
 
 buyer_name 별 건수 조회 쿼리 작성
 buyer_name, 건수
 
 SELECT buyer.buyer_name, COUNT(*)
 FROM prod, buyer
 WHERE prod.prod_buyer = buyer.buyer_id
 GROUP BY buyer.buyer_name;
 
 JOIN 3]
 
 SELECT member.MEM_ID, member.MEM_NAME, prod.PROD_ID, prod.PROD_NAME, cart.CART_QTY
 FROM member, cart, prod
 WHERE MEMBER.mem_id = cart.cart_member
   AND cart.cart_prod = prod.prod_id;
 
 join 3 을 안시문법으로 
 테이블 join 테이블 on/using 
  
 SELECT member.MEM_ID, member.MEM_NAME, prod.PROD_ID, prod.PROD_NAME, cart.CART_QTY
 FROM member, cart, prod
 WHERE MEMBER join cart on (member.mem_id = cart.cart_member)
              join prod on (cart.cart_prod = prod.prod_id);
 
 참고사항]
 두개의 쿼리는 같은데 약간,,,뭐라해야되나
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
 
 
 cycle : 애음주기
 cid : 고객 id
 pid : 제품 id
 day : 애음요일 (일요일 -1, 월욜날-2먹는지, 화욜날 먹는지...)
 cnt : 수량
 SELECT *
 FROM cycle;
 
 JOIN 4]
 SELECT customer.CID, customer.cnm, CYCLE.pid, CYCLE.DAY,CYCLE.cnt 
 FROM customer, cycle
 WHERE customer.cid = cycle.cid
   AND customer.cnm IN('brown','sally');
   
 SELECT customer.CID, cnm, pid, DAY, cnt --cid는 어디에있는 cid인지 모르니까 명시 해줘야함 
 FROM customer, cycle
 WHERE customer.cid = cycle.cid
   AND customer.cnm IN('brown','sally');
 
 natural join  
 SELECT cid,cnm, pid, day,cnt 
 FROM customer NATURAL JOIN cycle
 WHERE customer.cid = CYCLE.cid;
  --안시는 오라클과 다르게 cid 앞에 명시를 해주면 안됨
   
 join 5]
   
 SELECT customer.CID, customer.cnm, CYCLE.pid, product.pnm, CYCLE.DAY, CYCLE.cnt 
 FROM customer, cycle, product
 WHERE customer.cid = cycle.cid
   AND cycle.pid = product.pid
   AND customer.cnm IN('brown','sally');
   
join 6] --그룹바이절에 쓴 컬럼들은 셀렉트절에 묶여야하고 멀티로우펑션을 쓰면 
        --그룹바이절에 묶지 않아도 된다.
SELECT customer.cid, customer.cnm, CYCLE.pid, product.pnm, SUM(CYCLE.cnt)cnt
 FROM customer, cycle, product
 WHERE customer.cid = cycle.cid
   AND CYCLE.pid = product.pid
GROUP BY customer.cid, customer.cnm, CYCLE.pid, product.pnm
ORDER BY customer.cid, CYCLE.pid;
--count(cnt)- cnt 컬럼이 null이 아닌 행의개수

join 7]
SELECT product.pid, product.pnm, SUM(CYCLE.cnt)cnt
FROM product, cycle
WHERE cycle.pid = product.pid
 GROUP BY product.pid, product.pnm;
 
 --그룹바이 저렇게 해도됨 사이클이랑 겹치지 않아서
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
 

join 8~13 >>>과제!! 틀린문제도,,ㅇㅇ
 
 
 
 
 
 
 
 
 
 
 
 
