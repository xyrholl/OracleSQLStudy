-- WHERE절 == if == 조건절
/*
    표현식
    비교 연산자( >, <, >=, <=, =, !=, <> )   (!=  <>)같은 처리
    NULL, = NULL, IS NULL, IS NOT NULL
    ( ), NOT, AND, OR
    
    SELECT 
    FROM 
    WHERE   조건 
*/

-- FIRST_NAME == Julia
SELECT first_name, last_name, salary
FROM employees
WHERE first_name = 'Julia';

-- 급여가 $9000이상인 사원
SELECT first_name, salary
FROM employees
WHERE salary >= 9000;

-- 이름이 Shanta보다 큰 이름
SELECT first_name, salary
FROM employees
WHERE first_name >= 'Shanta';

SELECT first_name, salary
FROM employees
WHERE first_name >= 'a';

SELECT first_name, salary
FROM employees
WHERE manager_id = '';  -- null X

SELECT first_name, salary
FROM employees
WHERE manager_id IS NULL;

SELECT first_name, salary
FROM employees
WHERE manager_id IS NOT NULL;

-- AND
SELECT
    *
FROM employees
WHERE first_name = 'Shanta'
    AND first_name = 'John'; 

-- OR
SELECT
    *
FROM employees
WHERE first_name = 'Shanta'
    OR first_name = 'John'; 

-- 이름 John, 월급이 5000이상
SELECT first_name, salary
FROM employees
WHERE first_name = 'John'
    AND salary > 5000;

-- 2007년 12월 31일 이후에 입사한 사원을 출력하라.
SELECT first_name, hire_date
FROM employees
WHERE hire_date > '07/12/31';

SELECT first_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('20071231', 'YYYYMMDD');

-- ALL(AND), ANY(OR)
SELECT
    *
FROM employees
WHERE first_name = ALL('Julia', 'John');

SELECT
    *
FROM employees
WHERE first_name = ANY('Julia', 'John');

-- 8000, 3200, 6000
SELECT first_name, salary
FROM employees
WHERE salary = ANY(8000, 3200, 6000);

-- IN, NOT IN
SELECT first_name, salary
FROM employees
WHERE salary IN(8000, 3200, 6000);

SELECT first_name, salary
FROM employees
WHERE salary NOT IN(8000, 3200, 6000);

SELECT first_name, salary
FROM employees
WHERE first_name IN('Julia', 'John');

-- exists
SELECT first_name, job_id
FROM employees e
WHERE EXISTS(   SELECT 1 
                FROM dual 
                WHERE e.job_id = 'IT_PROG');

-- BETWEEN 범위 연산자
-- salary >= 3200 AND salary <= 9000
-- salary BETWEEN 3200 AND 9000

SELECT first_name, salary
FROM employees
-- WHERE salary BETWEEN 3200 AND 9000;
WHERE salary >= 3200 AND salary <= 9000;

SELECT first_name, salary
FROM employees
WHERE salary NOT BETWEEN 3200 AND 9000;
-- WHERE salary < 3200 OR salary > 9000;

-- LIKE
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'G_ra_d'; -- _ 한문자

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'K%y';    -- % 글자수의 제한이 없다

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '%Al%';

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '%e%';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '06/01%';
