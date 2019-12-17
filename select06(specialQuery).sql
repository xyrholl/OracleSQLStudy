-- 특수 Query
-- CASE DECODE
SELECT employee_id, first_name, phone_number,
    CASE SUBSTR(phone_number, 1, 3)
        WHEN '515' THEN '서울'
        WHEN '590' THEN '부산'
        WHEN '659' THEN '광주'
        WHEN '603' THEN '대전'
        ELSE '기타'
    END AS "지역"  
FROM employees;

SELECT employee_id, first_name, phone_number,
    CASE
        WHEN SUBSTR(phone_number, 1, 3) = '515' THEN '서울'
        WHEN SUBSTR(phone_number, 1, 3) = '590' THEN '부산' 
        WHEN SUBSTR(phone_number, 1, 3) = '659' THEN '광주'
        WHEN SUBSTR(phone_number, 1, 3) = '603' THEN '대전'
        ELSE '기타'
    END AS 지역
FROM employees;

SELECT employee_id, first_name, phone_number,
    DECODE( SUBSTR(phone_number, 1, 3),
            '515', '서울',
            '590', '부산',
            '659', '광주',
            '603', '대전', '기타') AS "지역"
FROM employees;

-- 분석 함수
-- 순위 Rank
-- RANK()           1 2 3 3 5 6
-- DENSE_RANK()     1 2 3 3 4 5
-- ROW_NUMBER()     1 2 3 4 5 6
-- ROWNUM

-- OVER() PARTITION BY ORDER BY
SELECT job_id, COUNT(*)OVER()
FROM employees;

SELECT job_id, COUNT(*)OVER(PARTITION BY job_id)
FROM employees;

SELECT job_id, salary, COUNT(*)OVER(PARTITION BY job_id ORDER BY salary DESC)
FROM employees;

SELECT first_name, salary, 
    RANK() OVER(ORDER BY salary DESC) AS RANK,
    DENSE_RANK()OVER(ORDER BY salary DESC) AS DENSE_RANK,
    ROW_NUMBER()OVER(ORDER BY salary DESC) AS ROW_NUMBER
FROM employees;

-- ROWNUM
-- 10명의 ROW만을 산출하는 경우
SELECT ROWNUM, employee_id, first_name, salary
FROM employees
WHERE ROWNUM <= 10;

-- 11 ~ 20의 ROW만을 산출하는 경우
SELECT ROWNUM, employee_id, first_name, salary  -- 2
FROM employees
WHERE ROWNUM > 10 AND ROWNUM <= 20; -- 1

-- 1. 설정
-- 2. ROWNUM 완성
-- 3. 범위를 설정
SELECT RNUM, employee_id, first_name, salary  
FROM
    (SELECT ROWNUM AS RNUM, employee_id, first_name, salary      -- 2. ROWNUM 완성   
    FROM 
        (   SELECT employee_id, first_name, salary  -- 1.DATA 설정
            FROM employees
            ORDER BY salary DESC) 
    )
WHERE RNUM > 10 AND RNUM <= 20;    -- 3. 범위를 설정

/*
합집합 : UNION
교집합 : INTERSECT
차집합 : MINUS
*/

-- UNION
SELECT job_id    
FROM employees
WHERE job_id IN('AD_VP', 'FI_ACCOUNT')
UNION
SELECT job_id
FROM jobs
WHERE job_id IN('AD_VP', 'IT_PROG');

-- INTERSECT
SELECT employee_id
FROM employees
INTERSECT
SELECT manager_id 
FROM employees;

-- JOIN
SELECT DISTINCT a.employee_id
FROM employees A, employees B
WHERE A.employee_id = B.manager_id;

-- MINUS
SELECT employee_id  -- 매니저가 아닌 사원
FROM employees
MINUS
SELECT manager_id 
FROM employees;

-- SELECT 절
SELECT 컬럼 OR 함수 OR 그룹함수 OR SUBQUERY OR OVER()
FROM 테이블명 OR SUBQUERY
[ WHERE ] 조건절 IN AND OR ANY ALL LIKE < > <> != =
[ GROUP BY ] 컬럼, ...
[ HAVING ] 그룹핑의 조건
[ ORDER BY ] 정렬 ASC(올림), DESC(내림)
[ START BY ] 계층형
[ CONNECT BY ] 연결 PRIOR(상향, 하향) 

JOIN INNER, OUTTER, SELF
SUBQUERY

RANK()
ROW_NUMBER()
ROWNUM
