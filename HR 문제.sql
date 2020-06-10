1문제

SELECT manager_id, department_id, COUNT(*)cnt
FROM employees
GROUP BY manager_id, department_id;
2문제
직원수
SELECT job, COUNT(*)
FROM emp
GROUP BY job;

SELECT mgr, COUNT(*)
FROM emp 
GROUP BY mgr;