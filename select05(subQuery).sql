-- SUB QUERY
-- Query 안의 Query
-- 한개의 행(row)에서 결과 값이 반환되는 Query

-- SELECT   단일 ROW 단일 COLUMN  (나오는 데이터가 한개, 컬럼 한개)
-- FROM     다중 ROW 다중 COLUMN
-- WHERE    다중 ROW 다중 COLUMN    --> 제일 많이 사용
/*
SELECT EMPLOYEE_ID, (SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES) -- 다중컬럼 사용x
SELECT EMPLOYEE_ID, (SELECT FIRST_NAME FROM EMPLOYEES)            -- 다중row 사용x   
*/

-- select
SELECT employee_id, first_name,
    (SELECT salary FROM employees WHERE employee_id = 100),
    (SELECT COUNT(*) FROM employees)
FROM employees;

-- FROM
SELECT employee_id, first_name, department_id
FROM (  SELECT employee_id, first_name, department_id
        FROM employees
        WHERE department_id = 20);

-- 부서번호가 20번, 급여가 6000이상의 사원
SELECT e.employee_id, e.salary
FROM (  SELECT employee_id, salary
        FROM employees
        WHERE department_id = 20 ) e
WHERE salary > 6000;        
        
SELECT a.employee_id, a.first_name, 
    a.job_id, b.job_id,
    b."급여합계", b."인원수"
FROM employees a, (SELECT job_id, sum(salary) as "급여합계", COUNT(*) as "인원수"
                    FROM employees
                    GROUP BY job_id) b
WHERE a.job_id = b.job_id;

-- where
SELECT first_name, salary
FROM employees
WHERE salary > ( SELECT AVG(salary) 
                 FROM employees );
  
SELECT first_name, job_id, department_id
FROM employees
WHERE job_id IN(    SELECT job_id 
                    FROM employees
                    WHERE department_id = 90);
           
-- 부서별로 가장 급여를 적게 받는 사원과 같은 급여를 받는 사원 9000 20000                  
SELECT department_id, first_name || '  '|| last_name, salary
FROM employees
WHERE salary IN (SELECT MIN(salary) FROM employees GROUP BY department_id)
ORDER BY department_id ASC;
                    
-- 부서별로 가장 급여를 적게 받는 사원의 정보
SELECT department_id, first_name, salary
FROM employees
WHERE (salary, department_id) IN (SELECT MIN(salary), department_id FROM employees GROUP BY department_id )
ORDER BY department_id ASC;
