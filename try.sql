 Try
 
 select empno||'--'|| ename as ���
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
 
 employees ���̺��� salary�� 30�Ϸ� ���� �� ���� ���� �Ҽ��� ù° �ڸ�, �Ҽ��� ��° �ڸ�, ���� ù° �ڸ����� �ݿø��� ���� ����ϼ���.
 
 SELECT sal/30 before, ROUND(sal/30, -1) after
 FROM emp;
 
 ����Ŭ���� ����¡ó�� �ϴ� ����� ROWNUM �� ����.
 
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
 
 
 