/*
    JOIN
    두개 이상의 테이블을 연결해서 데이터를 검색하는 방법이다.
    보통 두개이상의 행(row)들의 공통된 값 Primary key(기본키), Foreign key(외래키)값을
    사용해서 조인한다.
    
    Primary key(기본키) : 테이블에서 중복이 되지 않는 키
    Foreign key(외래키) : 다른 테이블에서 Primary key, Unique 가능성이 크다. 
    
    inner JOIN  *****   == 교집합
    cross JOIN  X
    outer JOIN
        left    ***
        right   ***
    self JOIN   ***** 
*/

-- inner JOIN
-- Ansi SQL
SELECT employee_id, first_name, 
    e.department_id, d.department_id,
    d.department_name
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id;

-- Oracle
SELECT employee_id, first_name, 
    e.department_id, d.department_id,
    d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- Shanta 의 업무명
SELECT e.employee_id, e.first_name,
    e.job_id, j.job_id,
    j.job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id
    AND e.first_name = 'Shanta';

-- 147번 사원의 부서명, 업무명을 구하라.
SELECT e.employee_id, e.first_name,
    e.department_id, d.department_id,
    e.job_id, j.job_id,
    d.department_name, j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
    AND e.job_id = j.job_id
    AND e.employee_id = 147;

-- cross Join
-- ansi
SELECT e.employee_id, e.first_name,
    e.department_id, d.department_id,
    d.department_name
FROM employees e CROSS JOIN departments d;

-- oracle
SELECT e.employee_id, e.first_name,
    e.department_id, d.department_id,
    d.department_name
FROM employees e, departments d;

-- full outer Join
SELECT e.employee_id, e.first_name,
    e.department_id, d.department_id,
    d.department_name
FROM employees e FULL OUTER JOIN departments d
    ON e.department_id = d.department_id
WHERE e.department_id IS NULL OR d.department_id IS NULL;

-- outer JOIN
-- left(right)
-- Ansi
SELECT e.employee_id, e.first_name,
    e.department_id, d.department_id,
    d.department_name
FROM employees e LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id;

-- Oracle
SELECT e.employee_id, e.first_name,
    e.department_id, d.department_id,
    d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+)
    AND e.department_id IS NULL;

-- self JOIN : 동일한 테이블 Join
SELECT a.employee_id, a.first_name,
    a.manager_id, b.employee_id,
    b.first_name
FROM employees a, employees b   -- a:사원 b:상사 
WHERE a.manager_id = b.employee_id;

-- 계층형 구조 오름, 내림
SELECT a.employee_id, a.first_name as "사원",
    a.manager_id as "사원의 상사", b.employee_id,
    b.first_name as "상사"
FROM employees a, employees b
WHERE a.manager_id = b.employee_id(+)
-- CONNECT BY PRIOR a.manager_id = a.employee_id;  -- 상향식
CONNECT BY a.manager_id = PRIOR a.employee_id; -- 하향식
