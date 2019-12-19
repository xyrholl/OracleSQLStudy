-- 문제1) 테이블에서 king의 정보를 소문자로 검색하고 사원번호, 성명, 담당 업무(소문자로), 부서번호를 출력하라.
SELECT employee_id, first_name, last_name, LOWER(job_id), department_id
FROM employees
WHERE LOWER(last_name) = 'king';

-- 문제2) 테이블에서 king의 정보를 대문자로 검색하고 사원번호 성명, 담당업무(대문가) 부서번호 출력
SELECT employee_id, last_name, UPPER(job_id), department_id
FROM employees
WHERE UPPER(last_name) IS NOT NULL;

-- 문제3) 테이블에서 부서번호와 부서이름 부서이름과 위치번호를 합하여 출력하도록하라.
SELECT department_id || '' || department_name, department_name || ' '|| location_id
FROM departments;

SELECT CONCAT(department_id, department_name), CONCAT(department_name, location_id)
FROM departments;

-- 문제4) 테이블에서 이름의 첫글자가 k 보다 크고 보다 적은 사원의 정보를 사원번호 이름업무 급여 부서번호를 출력하라. 단이름순으로 정렬
SELECT employee_id, first_name, department_id
FROM employees
WHERE first_name > 'K' AND first_name < 'Y' -- SUBSTR으로 사용하는것이 앞글자가 K보다 큰 사람이 나온다. 이렇게 비교할 경우 문제가 K 뒤에 이름이 더 붙으면 그 사람들도 같이 검색된다.
ORDER BY first_name ASC;

-- 문제 5) 테이블에서 20번 부서중 이름의 길이 및 급여의 자릿수를 산원번호 이름 이름의 자릿수 급여 급여의 자리수를 출력하라.
SELECT LENGTH(last_name), LENGTH(salary), employee_id, last_name
FROM employees
WHERE department_id = '20';

SELECT COUNT(*)
FROM employees
WHERE department_id = 20;

-- 문제6) 테이블에서 이름중 e자의 위치를 출력하다.
SELECT LENGTH(last_name)
FROM employees
WHERE last_name LIKE '%e%';

-- 문제 7) 다음 쿼리를 실행하고 결과를 분석하라.
SELECT ROUND(4567.678), ROUND(4567.678,0), ROUND(4567.678,2), ROUND(4567.678,-2) -- TRUNC
FROM dual; -- 첫번째 소숫점 전체 반올림, 두번째 첫번째와 동일, 세번째 소숫점 둘째자리까지 표기하고 아래자리에서 반올림, 네번째 10으 자리에서 반올림.

-- 문제 8) 테이블에서 부서번호가 80인 사람의 급여를 30으로 나눈 나머지를 구하여 출력하라.
SELECT MOD(salary, 30)
FROM employees
WHERE department_id = '80';

-- 문제 9) 테이블에서 30번 부서중 이름과 담당업무를 연결하여 출력하여라. 단 담당업무를 한줄아래로 출력하라.
SELECT last_name || chr(13) || chr(10) || job_id -- chr(10) : \n 동일함.
FROM employees
WHERE department_id = '30'; -- 개행 안됨. 다시한번 확인 더블클릭할경우 개행된걸로 확인됨.

-- 문제 10) 테이블에서 현재까지 근무일 수가 몇주 몇일인가를 출력하여라, 단 근무일수가 많은 사람순으로 출력.
SELECT ROUND(MONTHS_BETWEEN(SYSDATE,hire_date), 0)"근속 월", ROUND((MONTHS_BETWEEN(SYSDATE,hire_date)/12)*54, 0)"근속 주", ROUND((MONTHS_BETWEEN(SYSDATE,hire_date)/12)*365, 0)"근속 일"
FROM employees
ORDER BY hire_date ASC;

SELECT first_name, hire_date, TRUNC((TO_DATE('19/12/01') - hire_date) / 7) AS"총 근무 주일수", MOD((TO_DATE('19/12/01') - hire_date), 7) AS"남은 날 수"
FROM employees
ORDER BY "총 근무 주일수" DESC;

-- 문제 11) 테이블에서 부서 50 에서 급여앞에 $ 를 삽이하고 3자리 마다 , 을 출력하여라.
SELECT TO_CHAR(salary, '$999,999,999,999')"월급정리"
FROM employees
WHERE department_id = '50';

-- 문제 12) 다음 결과를 분석하여 보아라.
SELECT employee_id, last_name, job_id, salary, DECODE(job_id,'IT_PROG', salary*1.1, 'ST_MAN', salary*1.15, 'SA_MAN', salary*1.2, salary)d_sal
FROM employees
ORDER BY salary DESC; -- decode 안에 해당하는 job_id에 급여를 인상하였다.

-- 문제 1) 테이블에서 모든 SA_MAN에 대하여 급여의 평균, 최고액, 최저액, 합계를 구하여 출력
SELECT job_id, COUNT(*)"총인원", SUM(salary)"합계", AVG(salary)"평균", MAX(salary)"최고액", MIN(salary)"최저액" 
FROM employees
WHERE job_id = 'SA_MAN'
GROUP BY job_id;

-- 문제 2) 테이블에 등록되어있는 인원수 보너스가 NULL 이 아닌 인원수보너스의 평균, 등록되어있는 부서의 수를 구하여 출력
SELECT
(SELECT ROUND(SUM(AVG(commission_pct*salary)),0) FROM employees GROUP BY commission_pct)"보너스받는 사원평균",
(SELECT COUNT(*)FROM (SELECT job_id FROM employees WHERE commission_pct IS NOT NULL GROUP BY job_id))"부서의 수", 
(SELECT COUNT(*) FROM employees WHERE commission_pct IS NOT NULL)"보너스를 받는 인원"
FROM dual;

-- 문제 3) 테이블에서 부서별로 인원수, 평균 급여, 최저급여, 최고급여, 급여의 합을 구하여 출력하라.
SELECT department_id, COUNT(*)"인원수", ROUND(AVG(salary),0)"평균급여", MIN(salary)"최저급여", MAX(salary)"최고급여", SUM(salary)"부서급여 합계"
FROM employees
GROUP BY department_id
HAVING(department_id IS NOT NULL);

--문제 4) 테이블에서 각 부서별로 인원수, 급여의 평균 최저급여, 최고급여, 급여의 합을 구하여 급여의 합이 많은 순으로 출력
SELECT department_id, COUNT(*)"인원수", ROUND(AVG(salary),0)"평균급여", MIN(salary)"최저급여", MAX(salary)"최고급여", SUM(salary)"부서급여 합계"
FROM employees
GROUP BY department_id
HAVING(department_id IS NOT NULL)
ORDER BY SUM(salary)DESC;

-- 문제 5) 테이블에서 부서별, 업무별, 그룹하여 결과를 부서번호, 업무, 인원수, 급여의 평균, 급여의 합을 구하여 출력하여라.
SELECT department_id, job_id, COUNT(*), ROUND(AVG(salary)), SUM(salary)
FROM employees
GROUP BY department_id, job_id;

-- 문제 6) 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호 , 인원수, 급여의 합을 구하여 출력하라.
SELECT department_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(*) >4;

-- 문제7) 테이블에서 급여가 최대 10000 이상인 부서에 대해서 부서번호, 평균급여, 급여의 합을 구하여 출력
SELECT department_id, ROUND(AVG(salary)), SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 10000;

-- 문제 8) 테이블에서 업무별 급여의 평균이 1000 이상인 업무에 대해서 업무명, 평균급여, 급여의 합을 구하여 출력하라.
SELECT d.department_name"업무명", e.salary"급여"
FROM employees e, departments d
WHERE e.department_id = d.department_id AND e.salary > 1000; -- 다시 한번체크

-- 문제 9) 테이블에서 전체 월급이 1000을 초과하는 각업무에 대해서 업무와 월급여 합계를 출력하라, 단 판매원은 제외. 내림차순 정렬
SELECT job_id, SUM(salary)"급여 합계"
FROM employees
GROUP BY job_id
HAVING SUM(salary) > 10000 AND job_id NOT LIKE '%SA%'
ORDER BY SUM(salary) DESC;
