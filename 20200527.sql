DATA DICTIONARY
USER_ : 사용자가 소유한 객체
ALL_ : 사용자가 사용할 수 있는 권한을 부여받은 객체까지
DBA_ : 모든 객체
V$ : 성능관련, 시스템적인

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name IN ('LPROD', 'PROD')
  AND constraint_type IN ('P', 'R');
  

CREATE TABLE member2 AS
SELECT *
FROM member;

SELECT *
FROM member2;

UPDATE member2 SET mem_job = '군인'
WHERE mem_name = '김은대';

SELECT mem_name, mem_job
FROM member2
WHERE mem_name = '김은대';


CREATE OR REPLACE VIEW vw_prod_buy AS
SELECT buy_prod, SUM(buy_cost) sum_buy_cost
FROM buyprod
GROUP BY buy_prod;

SELECT *
FROM user_views;


SELECT *
FROM cart
WHERE cart_member = 'a001';

SQL 응용
1. 프로시져 제출
2. 1)CART 테이블을 이용하여 회원별(cart_member)
     상품구매수량(cart_qty(합계를 조회 하는 쿼리 작성
     ==>그룹함수
   2)

SELECT *
FROM cart
WHERE cart_member = 'a001';

SELECT cart_member, SUM(cart_qty)
FROM cart
GROUP BY cart_member;

SELECT cart.*, SUM(cart_qty) OVER (PARTITION BY cart_prod)
FROM cart;



1.
SELECT MAX(sal)m_s, MIN(sal)mi_s, ROUND(AVG(sal), 2)av_s, SUM(sal)s_s, COUNT(*)
FROM emp;

2.
SELECT deptno, COUNT(deptno)cnt
FROM emp
GROUP BY deptno;

3.
SELECT job, COUNT(job)cnt
FROM emp
GROUP BY job;

4.
SELECT COUNT(*)cnt_deptno
FROM
(SELECT COUNT(*)
 FROM emp
 GROUP BY deptno);


SELECT ename, job, sal,
    CASE
        WHEN job = 'SALESMAN' THEN sal *1.05
        WHEN job = 'MANAGER' THEN sal *1.10
        WHEN job = 'PRESIDENT' THEN sal *1.20
        ELSE sal*1
    END
FROM emp

SELECT ename, job, sal,
        DECODE(job, 'SALESMAN', sal * 1.05,
                    'MANAGER', sal * 1.10,
                    'PRESIDENT', sal * 1.20,
                    sal * 1) bonus
FROM emp;


1.
SELECT empno, ename,
        CASE
            WHEN deptno = 10 THEN 'ACCOUNTING'
            WHEN deptno = 20 THEN 'RESEARCH'
            WHEN deptno = 30 THEN 'SALES'
            WHEN deptno = 40 THEN 'OPERATION'
            ELSE 'DDIT'
        END DNAME
FROM emp;

SELECT empno, ename,
    DECODE( deptno, 10, 'ACCOUNTING',
                    20, 'RESEARCH',
                    30, 'SALES',
                    40, 'OPERATION',
                    'DDIT') dname
FROM emp;

2.
SELECT empno, ename, hiredate
    CASE
        WHEN 
FROM emp

