join 8]
 SELECT countries.region_id, region_name, country_name
 FROM countries, regions
 WHERE countries.region_id = regions.region_id
   AND region_name IN('Europe');
  
 join 9]
 SELECT countries.region_id, region_name, country_name, city
 FROM countries, regions, locations
 WHERE countries.region_id = regions.region_id
   AND countries.country_id = locations.country_id
   AND region_name IN('Europe');
   
 join 10]
 SELECT countries.region_id, region_name, country_name, city, department_name
 FROM countries, regions, locations, departments
 WHERE countries.region_id = regions.region_id
   AND countries.country_id = locations.country_id
   AND locations.location_id = departments.location_id
   AND region_name IN('Europe');
 
 join 11]
 SELECT countries.region_id, region_name, country_name, city, department_name,CONCAT(first_name,last_name)name
 FROM countries, regions, locations, departments, employees
 WHERE countries.region_id = regions.region_id
   AND countries.country_id = locations.country_id
   AND locations.location_id = departments.location_id
   AND departments.department_id = employees.department_id
   AND region_name IN('Europe');
   
 join 12]
 SELECT employee_id, CONCAT(first_name,last_name)name, jobs.job_id, job_title
 FROM employees, jobs
 WHERE employees.job_id = jobs.job_id;
   
join 13]
--자기컬럼과 연결되어있는거 
SELECT  e.manager_id, m.employee_id, 
        e.CONCAT(first_name,last_name)name, jobs.job_id, job_title, NVL(manager_id,100)
FROM employees e, jobs j, employees m
WHERE e.job_id = jobs.job_id
  AND e.manager_id = m.employee_id;


SELECT M.manager_id, CONCAT(first_name, last_name) name
FROM employees e, jobs j, employees m
WHERE e.job_id = j.job_id
  AND e.employee_id = m.employee_id; ???




--메니져도 직원이니까 employee 테이블 하나 더 추가
   ID에 NULL값이 없으면 조인이 된다
 
   
   
   
   
   
   
   
   
   
   
   