1.
SELECT b.buy_date, b.buy_prod, p.prod_id, P.prod_name, b.buy_qty
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id
   AND b.buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD'); 

2.
SELECT NVL(b.buy_date,'05/01/25'), b.buy_prod, p.prod_id, P.prod_name, b.buy_qty
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id
   AND b.buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD'); 
   
3.
SELECT NVL(b.buy_date,'05/01/25'), b.buy_prod, p.prod_id, P.prod_name, NVL(b.buy_qty, 0)
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id
   AND b.buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD'); 

4.
SELECT p.pid, p.pnm, NVL(c.cid, 1)cid, NVL(c.day, 0)day, NVL(c.cnt, 0)cnt
FROM cycle c, product p
WHERE c.pid(+) = p.pid
  AND c.cid(+) =1;

5.
SELECT p.pid, p.pnm, NVL(c.cid, 1)cid, NVL(r.cnm, 'brown')cnm, NVL(c.day, 0)day, NVL(c.cnt, 0)cnt
FROM cycle c, product p, customer r
WHERE c.pid(+) = p.pid
  AND c.cid = r.cid(+)
  AND c.cid(+) = 1
ORDER BY p.pid desc;

ALLEN 의 직무와 같은 사람의 이름, 부서명, 급여, 직무를 출력하세요
SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND e.job = (SELECT job FROM emp WHERE ename = 'ALLEN');
  
  전체 사원의 평균 임금보다 많은 사원의 사우너번호, 이름, 부서명, 입사일, 지역, 급여를 출력하라.
   select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal
   from emp e join dept d
   on e.deptno = d.deptno
   and e.sal > (select avg(sal) from emp );
   
   
   
   
   
   1)
select *
from customer cross join product;

2)
select count(*)
from
(select *
from emp 
where sal > (select avg(sal) from emp));

3)
select *
from emp e,dept d
where e.deptno = d.deptno and e.job = (select job from emp where ename='ALLEN');

4)
select empno, ename, dname, hiredate, loc, sal
from emp e, dept d
where e.deptno = d.deptno and e.sal > (select avg(sal) from emp);


SELECT customer.cid, customer.cnm, product.pid, product.pnm
FROM customer CROSS JOIN product;

SELECT count(*)
FROM emp 
WHERE sal >(SELECT avg(sal)
            FROM emp);
            
            
SELECT *
FROM emp 
WHERE job IN (SELECT job
                FROM emp
                WHERE ename = 'ALLEN');
                
            
SELECT*
FROM emp
WHERE sal > ALL (SELECT avg(sal) 
                FROM emp JOIN dept ON (emp.deptno = dept.deptno));
                
select empno, ename, dname, hiredate, loc, sal
from emp e, dept d
where e.deptno = d.deptno 
  and e.sal > (select avg(sal) from emp);
  
  
  
  
  SELECT COUNT(*)
FROM(SELECT AVG(SAL) avg
     FROM emp), emp
WHERE sal > avg;

SELECT emp.*
FROM (SELECT job j
      FROM emp
      WHERE ename = 'ALLEN'), emp
WHERE j = job;

SELECT emp.*
FROM(SELECT AVG(SAL) avg
     FROM emp), emp
WHERE sal > avg;




261~271

select (select sysdate from dual) sdt
from dual

select (select dname
        from dept
        where deptno = emp.deptno)dname,
        emp.empno, ename
from emp;

select *
from (select round(avg(sal),2) sal
      from emp);
select *
from emp
where sal > (select avg(sal)
             from emp);
select *
from emp a
where sal > (select avg(sal)
             from emp b
             where deptno = a.deptno);
             
insert into dept values (99, 'ddit', 'daejeon');
rollback;



2.
select c.pid, p.pnm
from cycle c, product p
where c.pid = p.pid
  and p.pnm not in (select cid
                    from cycle
                    where cid = 1);
                    
SELECT *
FROM cycle;

SELECT *
FROM product;

1
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');

select *
from dept
where deptno not in (select deptno
                     from emp);
2.
SELECT *
FROM product
WHERE pid
    NOT IN(SELECT pid
            FROM cycle
            WHERE cid = 1);

3.
SELECT *
FROM cycle
WHERE cid = 1
  AND pid NOT IN (SELECT pid
                     FROM cycle
                     WHERE pid = 400);
                    
4.
SELECT cid, 

SELECT c.cid, (SELECT cnm FROM customer where cid = c.cid) cnm,
       c.pid, (SELECT pnm FROM product WHERE pid = c.pid)pnm, c.day, c.cnt
FROM cycle c
WHERE cid = 1
  AND pid IN (SELECT pid
              FROM cycle
              WHERE cid = 2);






select c.pid, p.pnm
from cycle c, product p
where c.cid = 1

select *
from cycle

select *
from product

select *
from customer


select *
from product
where cid=1

SELECT *
FROM dept
WHERE deptno NOT IN(SELECT deptno 
                    FROM emp
                    WHERE deptno);

select *
from emp
where (mgr, deptno) in (select mgr, deptno
                        from emp
                        where empno in (7499, 7782));



select *
from emp e, emp m
where e.empno = m.mgr

select *
from emp a
where EXISTS(select 'X'
             from emp b
             where b.empno = a.mgr);

select *
from product p
where exists(select *
             from cycle c
             where c.pid = p.pid
               AND c.cid = 1);

select *
from product p
where not exists(select *
             from cycle c
             where c.pid = p.pid
               AND c.cid = 1);

select empno as a, ename as b
from emp
where empno in(7369, 7698, 7792)

UNION

select empno, ename
from emp
where empno in (7566, 7698)
order by a;













                            
             