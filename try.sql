 Try
 
 select empno||'--'|| ename as 명단
 from emp;
 where hiredate > '1982-01-01';
 
 SELECT ename, sal, sal * 12 + comm sal_comm
 FROM emp;
 
 SELECT *
 FROM emp
 WHERE (ename) = 'smith';
 
 SELECT *
 FROM emp
 WHERE empno LIKE '_52_';
 
 employees 테이블에서 salary를 30일로 나눈 후 나눈 값의 소수점 첫째 자리, 소수점 둘째 자리, 정수 첫째 자리에서 반올림한 값을 출력하세요.
 
 SELECT sal/30 before, ROUND(sal/30, -1) after
 FROM emp;
 
 오라클에서 페이징처리 하는 방법은 ROWNUM 을 쓴다.
 
 SELECT ROWNUM, empno
 FROM emp
 WHERE ROWNUM BETWEEN 11 AND 20;

SELECT ROWNUM, X.*
  FROM (ELECT ROWNUM, A.*
    FROM emp A
    ORDER BY A.ename)X;
  
 SELECT ROWNUM, A.*
 FROM
 (SELECT *
 FROM
     (SELECT ROWNUM rn, A.*
      FROM 
       (SELECT  A.*
        FROM emp A
        WHERE ROWNUM <= 4 AND sal < 2000
        ORDER BY sal)A)
 ORDER BY ename)A;
 
 SELECT *
 FROM buyer;
 
 SELECT *
 FROM
  (SELECT ROWNUM RN, A.*
   FROM
      (SELECT A.*
       FROM prod A
       ORDER BY PROD_LGU DESC, PROD_COST)A)
 WHERE RN BETWEEN (:page-1) * :pageSize +1 AND :page * :pageSize
 ORDER BY prod_name;
 
 SELECT *
 FROM prod;
 
 
 