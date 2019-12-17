-- ORDER BY : 정렬
SELECT *
FROM emp
-- ORDER BY sal ASC    -- 오름차순 정렬 
-- ORDER BY sal DESC   -- 내림차순 정렬
ORDER BY hiredate;       -- 오름차순 정렬 

-- ALIAS
SELECT empno, ename, sal * 12 AS annsal
FROM emp
ORDER BY annsal ASC;

SELECT
    *
FROM emp
ORDER BY comm NULLS FIRST;

SELECT
    *
FROM emp
ORDER BY comm NULLS LAST;

SELECT employee_id, job_id, salary
FROM employees
ORDER BY job_id ASC, salary DESC;

-- 문자열을 합하는 기능
SELECT first_name || ' ' || last_name
FROM employees;

SELECT concat(first_name, last_name)
FROM employees;

-- months_between : 두날짜의 간의 월수(월간격)
SELECT MONTHS_BETWEEN('2020-05-04','2019-12-13')
FROM dual;

-- add_months : 특정 말짜 월에 정수에 더한 다음 해당 날짜를 반환
SELECT add_months('2019-12-13', 3)
FROM dual;

-- 날짜 정보에서 특정한 연도, 월, 일, 시, 분, 초
SELECT EXTRACT(year from to_date('191001', 'YYMMDD')) as 연도,
       EXTRACT(month from to_date('19/10/01')) as 월,
       EXTRACT(day from sysdate) as 일
FROM dual;

-- 시, 분, 초
SELECT EXTRACT(hour FROM CAST(sysdate AS TIMESTAMP)) as 시,
    EXTRACT(minute FROM CAST(sysdate AS TIMESTAMP)) as 분,
    EXTRACT(second FROM CAST(sysdate AS TIMESTAMP)) as 초
FROM dual;

-- 그룹으로 묶는 기능
SELECT DISTINCT department_id, employee_id
FROM employees
ORDER BY department_id ASC;

-- GROUP BY
SELECT department_id
FROM employees
GROUP BY department_id
ORDER BY department_id ASC;

/*
GROUP 함수
COUNT
SUM
AVG
MAX 
MIN
*/

SELECT COUNT(salary), COUNT(*), SUM(salary), AVG(salary),
    SUM(salary)/COUNT(*), job_id
FROM employees
WHERE job_id = 'IT_PROG';

SELECT COUNT(salary), COUNT(*), SUM(salary), AVG(salary),
    SUM(salary)/COUNT(*), job_id
FROM employees
GROUP BY job_id;

/*
NVL(대상이 되는 컬럼, 0)       NUMBER
대상이 되는 컬럼 != NULL --> 대상이 되는 컬럼
대상이 되는 컬럼 == NULL --> 0

NVL(대상이 되는 컬럼, '없음')   VARCHAR2 
대상이 되는 컬럼 != NULL --> 대상이 되는 컬럼
대상이 되는 컬럼 == NULL --> '없음'

NVL2(대상이 되는 컬럼, 1, 0)
대상이 되는 컬럼 != NULL --> 1
대상이 되는 컬럼 == NULL --> 0
*/

SELECT first_name, NVL(commission_pct, 0)
FROM employees;

SELECT first_name, NVL2(commission_pct, '있음', '없음')
FROM employees;

SELECT department_id, SUM(salary), MAX(salary), trunc(AVG(salary))
FROM employees
GROUP BY department_id
ORDER BY department_id ASC;

-- HAVING <- GROUP BY 와 같이 사용
SELECT job_id, SUM(salary)
FROM employees
GROUP BY job_id
HAVING SUM(salary) >= 100000
ORDER BY SUM(salary) DESC;

-- 급여가 5000이상 받는 사원만으로 합계를 내서 업무로 그룹화하여 급여 합계가 20000을 초과하는 
-- 업무명을 구하라.

SELECT job_id, count(*), sum(salary), round(avg(salary))
FROM employees
WHERE salary > 5000
GROUP BY job_id
HAVING SUM(salary) > 20000;