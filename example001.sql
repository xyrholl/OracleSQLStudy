SELECT *
FROM employees;
--문제1) EMPLOYEES 테이블에서 입사일자 순으로 정렬하여 사원번호, 이름, 업 무, 급여, 입사일자,부서번호를 출력하라. 
SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
ORDER BY hire_date;
--문제2) EMPLOYEES 테이블에서 가장 최근에 입사한 순으로 사원번호, 이름, 업무, 급여, 입사일자,부서번호를 출력하라. 
SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
ORDER BY hire_date DESC;
--문제3) EMPLOYEES 테이블에서 부서번호로 정렬한 후 부서번호가 같을 경우 급여가 많은 순으로 정렬하여 사원번호, 성명, 업무, 부서번호, 급여를 출력하 여라. 
SELECT job_id, salary
FROM employees
ORDER BY department_id, salary DESC;
--문제4) EMPLOYEES 테이블에서 첫번째 정렬은 부서번호로 두번째 정렬은 업무로 세번째 정렬은 급여가 많은 순으로 정렬하여 사원번호, 성명, 입사일자, 부서번호, 업무, 급여를 출력하여라. 
SELECT department_id, last_name, hire_date, job_id, salary
FROM employees
ORDER BY department_id, job_id, salary DESC;
--문제5) 부서별로 담당하는 업무를 한번씩 출력하여라. 
SELECT DISTINCT department_id, job_id
FROM employees
ORDER BY department_id;
--문제6) EMPLOYEES 테이블에서 King의 정보를 소문자로 검색하고 사원번호, 성명, 담당업무(소문자로),부서번호를 출력하라. 
SELECT employee_id, last_name, LOWER(job_id), department_id
FROM employees
WHERE LOWER(last_name) = 'king';
--문제7) EMPLOYEES 테이블에서 King의 정보를 대문자로 검색하고 사원번호, 성명, 담당업무(대문자로),부서번호를 출력하라. 
SELECT  employee_id, last_name, UPPER(job_id), department_id
FROM employees
WHERE UPPER (last_name) = 'KING';
--문제8) DEPARTMENTS 테이블에서 부서번호와 부서이름, 부서이름과 위치번 호를 합하여 출력하도록 하라. 
SELECT department_id || ' '|| department_name, department_name || ' ' || location_id
FROM departments;
--문제9) EMPLOYEES 테이블에서 이름의 첫 글자가 ?K? 보다 크고 ?Y?보다 적은 사원의 정보를 사원번호, 이름, 업무, 급여, 부서번호를 출력하라. 단 이름순으로 정렬하여라. 
SELECT employee_id, first_name || ' ' || last_name, job_id, salary, department_id
FROM employees
WHERE first_name > 'K' AND first_name < 'Y'
ORDER BY first_name || last_name;
--문제10) EMPLOYEES 테이블에서 20번 부서 중 이름의 길이 및 급여의 자릿수 를 사원번호, 이름, 이름의 자릿수, 급여, 급여의 자릿수를 출력하라. 
SELECT LENGTH(first_name||last_name),  department_id, first_name|| ' '|| last_name, salary, LENGTH(salary)
FROM employees
WHERE department_id = '20';
--문제11) EMPLOYEES 테이블에서 이름 중 ?e?자의 위치를 출력하라. 
SELECT INSTR(first_name, 'e')"앞에서 e", INSTR(last_name, 'e')"뒤에서 e", first_name || ' ' || last_name
FROM employees
WHERE first_name || last_name LIKE '%e%';
--문제12) 다음의 쿼리를 실행하고 결과를 분석하라. 
SELECT ROUND(4567.678),ROUND(4567.678,0), ROUND(4567.678,2),ROUND(4567.678,-2) FROM dual; 
-- 1의 자리부터 표기하고 소숫점은 반올림한다., 1의자리부터 표기하고 소숫점은 반올림한다., 소숫점 둘째자리부터 표기하고 밑으로는 반올림한다., 10의자리 아래로 반올림표기한다.
--문제13) EMPLOYEES 테이블에서 부서번호가 80인 사람의 급여를 30으로 나눈 나머지를 구하여 출력하라. 
SELECT MOD(salary, 30)
FROM employees
WHERE department_id = '80';
--문제14) EMPLOYEES 테이블에서 30번 부서 중 이름과 담당 업무를 연결하여 출력하여라. 단 담당 업무를 한 줄 아래로 출력하라.  --보이기엔 한줄처럼 보이지만 그리드를 더블 클릭하면 개행 되었다는 것을 확인할 수 있습니다.
SELECT first_name || ' ' || last_name || chr(13) || chr(10) || job_id
FROM employees
WHERE department_id = '30';
--문제15) EMPLOYEES 테이블에서 현재까지 근무일 수가 몇주 몇일 인가를 출 력하여라. 단 근무 일수가 많은 사람 순으로 출력하여라. 
SELECT first_name || ' ' || last_name"이름" , ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)/12*365/7, 0)"주", ROUND(MOD( MONTHS_BETWEEN(SYSDATE, hire_date)/12*365/54, 7), 0)+1"일", hire_date"입사날짜"
FROM employees
ORDER BY hire_date;
--문제16) EMPLOYEES 테이블에서 부서 50에서 급여 앞에 $를 삽입하고 3자리 마다 ,를 출력하라 
SELECT TO_CHAR(salary, '$999,999,999,999')
FROM employees
WHERE department_id = '50';
--문제17) 다음의 결과를 분석하여 보아라.
SELECT EMPLOYEE_ID,LAST_NAME,JOB_ID,SALARY,DECODE(JOB_ID,'IT_PROC', SALARY*1.1, 'ST_MAN', SALARY*1.15,'SA_MAN', SALARY*1.2, SALARY) d_sal FROM EMPLOYEES ORDER BY SALARY DESC;
-- employees 테이블에서 급여 내림차순으로 정렬하고, 사원번호, 이름, 담당업무, 급여로 출력하되, IT_PROG의 급여는 1.1배, ST_MAN의 급여는 1.15배, SA_MAN의 급여는 1,2배를하고, 다른 직업은 인상하지 않는다.
--문제18) EMPLOYEES 테이블에서 모든 SALESMAN(SA_MAN)에 대하여 급여의 평균, 최고액, 최저액, 합계를 구하여 출력하여라. 
SELECT job_id, AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees
GROUP BY job_id
HAVING job_id ='SA_MAN';
--문제19) EMPLOYEES 테이블에 등록되어 있는 인원수, 보너스가 NULL이 아닌 인원수, 보너스의 평균, 등록되어 있는 부서의 수를 구하여 출력하라. 
SELECT COUNT(*)"사원 수", COUNT(commission_pct)"보너스를 받는 인원", ROUND(SUM(salary*NVL(commission_pct, 0))/COUNT(*), 0)"보너스 평균", TRUNC(AVG(commission_pct * salary))"보너스를 받을 수 있는", COUNT(DISTINCT(department_id))"부서의 수"
FROM employees; -- 보너스를 받을 수 있는 사람의 보너스 평균을 구하려면 commission 탭에 null값을 0으로 초기화 하지 않고 계산하는것이 맞다. 
--문제20) EMPLOYEES 테이블에서 부서별로 인원수, 평균 급여, 최저급여, 최고 급여, 급여의 합을 구하여 출력하라. 
SELECT  COUNT(department_id)"부서 인원", ROUND(AVG(salary),0)"평균 급여", MAX(salary)"부서 최고 급여", SUM(salary)"부서 급여 합계"
FROM employees 
GROUP BY department_id
HAVING department_id IS NOT NULL
ORDER BY department_id;

SELECT d.department_id, d.department_name,  e.department_id
FROM employees e, departments d
WHERE e.department_is =  d.department_id
GROUP BY d.department_id, department_name, e.department_id
ORDER BY department_id; -- 그룹+ 조인 왜안돼
--문제21) EMPLOYEES 테이블에서 각 부서별로 인원수,급여의 평균, 최저 급여, 최고 급여, 급여의 합을 구하여 급여의 합이 많은 순으로 출력하여라. 
SELECT department_id, COUNT(department_id)"부서 인원 수", ROUND(AVG(salary),0), MIN(salary), MAX(salary), SUM(salary)
FROM employees
GROUP BY department_id
ORDER BY SUM(salary) DESC;
--문제22) EMPLOYEES 테이블에서 부서별, 업무별 그룹하여 결과를 부서번호, 업 무, 인원수, 급여의 평균, 급여의 합을 구하여 출력하여라. 
SELECT department_id, job_id, COUNT(*)"부서 인원 수", ROUND(AVG(salary)), SUM(salary) -- 어떤 그룹의 평균과 합계인지???
FROM employees
GROUP BY department_id, job_id; -- department_id 로 묶고 나서 job_id로 묶었다. 마지막 결과값들은 마지막 job_id로 묶인 값들이 나오는 것이 맞다.

SELECT *
FROM employees
WHERE department_id = 110; -- 확인

--문제23) EMPLOYEES 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합을 구하여 출력하여라.(GROUP BY, HAVING)
SELECT department_id, COUNT(department_id), SUM(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(department_id) > 4;

--문제24) EMPLOYEES 테이블에서 급여가 최대 10000이상인 부서에 대해서 부 서번호, 평균 급여, 급여의 합을 구하여 출력하여라.
SELECT department_id, ROUND(AVG(salary)), SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 10000;
--문제25) EMPLOYEES 테이블에서 업무별 급여의 평균이 10000 이상인 업무에 대해서 업무명,평균 급여, 급여의 합을 구하여 출력하라. 
SELECT job_id,  ROUND(AVG(salary)), SUM(salary)
FROM employees
GROUP BY job_id
HAVING ROUND(AVG(salary)) >= 1000;
--문제26) EMPLOYEES 테이블에서 젂체 월급이 10000을 초과하는 각 업무에 대 해서 업무와 월급여 합계를 출력하라. 단 판매원은 제외하고 월 급여 합계로 정렬(내림차순)하라.(SA_) 
SELECT job_id, SUM(salary)
FROM employees
GROUP BY job_id
HAVING SUM(salary) > 10000 AND job_id NOT LIKE 'SA_%'
ORDER BY SUM(salary) DESC;

SELECT SUM(salary), d.department_name
FROM employees e, departments d
WHERE e.employee_id = d.department_id 
GROUP BY d.department_name
HAVING SUM(salary) > 10000
ORDER BY SUM(salary) DESC;
--문제27) EMPLOYEES 테이블과 DEPARTMENTS 테이블을 Cartesian Product(모든 가능한 행들의 Join)하여 사원번호,이름,업무,부서번호,부서명, 근무지를 출력하여라. 

--문제28) EMPLOYEES 테이블에서 사원번호,이름,업무, EMPLOYEES 테이블의 부서번호, DEPARTMENTS 테이블의 부서번호,부서명,근무지를 출력하여라. 
SELECT e.employee_id"사원번호", last_name"이름", job_id"업무", e.department_id"부서번호", d.department_id"부서번호", d.department_name"부서명", d.location_id"근무지"
FROM employees e, departments d
WHERE e.department_id = d.department_id;
--문제29) Alexander Hunold 의 부서명을 출력하라.
SELECT e.first_name, e.last_name, d.department_name
FROM employees e , departments d
WHERE e.department_id = d.department_id AND e.first_name LIKE 'Alexander' AND last_name LIKE 'Hunold';
--문제30) 세일즈 부서에서 근무하고 있는 사람들을 출력하라. 
SELECT *
FROM employees e , departments d
WHERE e.department_id = d.department_id AND d.department_name LIKE 'Sales';
--문제31) EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고 SA_MAN 사원만의 사원번호,이름,급여,부서명,근무지를 출력하라. (Alias를 사용) 
SELECT e.employee_id"사원번호", last_name"이름", salary"급여", d.department_name"부서명", d.location_id"근무지"
FROM employees e, departments d
WHERE e.department_id = d.department_id AND e.job_id LIKE 'SA_MAN';
--문제32) EMPLOYEES 테이블과 DEPARTMENTS 테이블에서 DEPARTMENTS 테 이블에 있는 모든 자료를 사원번호,이름,업무, EMPLOYEES 테이블의 부서번 호, DEPARTMENTS 테이블의 부서번호,부서명,근무지를 출력하여라 (Outer Join) 

--문제33) EMPLOYEES 테이블에서 Self join하여 관리자(매니저)를 출력하여라. 
SELECT e.last_name"사원 이름", e.manager_id"매니저 아이디", d.employee_id"매니저 아이디", d.last_name"매니저 이름"
FROM employees e, employees d
WHERE e.manager_id = d.employee_id;
--문제34) EMPLOYEES 테이블에서 left join하여 관리자(매니저)를 출력하고 매니저 아이디가 없는 사람은 배제하고 하향식으로 하며, 급여는 역순으로 출력하라. 

--문제35) EMPLOYEES 테이블에서 right join하여 관리자(매니저)가 108번 상향식으로 급여는 역순으로 출력하라.

---- SCOTT
--문제1) emp테이블의 업무(job)을 첫글자는 대문자 나머지는 소문자로 출력하시오.
SELECT INITCAP(job)
FROM emp;
--문제2) emp테이블에서 사원이름 중 A가 포함된 사원이름을 구하고 그 이름 중 앞에서 3자만 추출하여 출력
SELECT INITCAP(ename)
FROM emp
WHERE ename LIKE '%A%';
--문제3) 이름의 세번째 문자가 A인 모든 사원의 이름을 표시하시오.
SELECT ename
FROM emp
WHERE SUBSTR(ename, 3, 1) LIKE 'A';
--문제4) 이름이 J,A 또는 M으로 시작하는 모든 사원의 이름 (첫 글자는 대문자로, 나머지 글자는 소문자로 표시) 및 이름의 길이를 표시하시오.(열 레이블은 name과 length로 표시) 
SELECT INITCAP(ename)
FROM emp
WHERE SUBSTR(ename,1 ,1) LIKE 'J'
OR SUBSTR(ename,1 ,1) LIKE 'A'
OR SUBSTR(ename,1 ,1) LIKE 'M';
--문제5) 이름의 글자수가 6자 이상인 사원의 이름을 소문자로 이름만 출력하시오
SELECT LOWER(ename)
FROM emp
WHERE LENGTH(ename) >= 6;
--문제6) 이름의 글자수가 6자 이상인 사람의 이름을 앞에서 3자만 구하여 소문자로 출력하시오.
SELECT SUBSTR(LOWER(ename), 1, 3)
FROM emp
WHERE LENGTH(ename) >= 6;
--문제7) 모든 사원의 이름과 급여를 표시하시오. 급여는 15자 길이로 왼쪽에 $기호가 채워진 형식으로 표기하고 열레이블을 SALARY로 지정하시오.
SELECT ename, sal, TO_CHAR(sal, '$999,999,999,999,999')"SALARY"
FROM emp;

SELECT ename, sal, LPAD(sal, 15, '$')AS SALARY -- 15자 길이로 만들고 $로 채워라
FROM emp;

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


-- 문제1) 테이블과 테이블을 cartesian product 조인하여 사원번호 , 이름, 업무, 부서번호, 부서면, 근무지를 출력 -- cross 조인
SELECT e.employee_id, e.last_name, e.job_id, d.department_id, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.employee_id = d.department_id;

-- 문제2) 사원 테이블에서 사원번호, 이름, 업무, 부서테이블의 부서번호 부서명, 근무지를 출력하여라.
SELECT e.employee_id, e.last_name, e.job_id, d.department_id, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.employee_id = d.department_id;

-- 문제3) 알렉산더 혼올드의 부서명을 출력하여라
SELECT d.department_name
FROM employees e , departments d
WHERE e.department_id = d.department_id
AND e.last_name LIKE 'Hunold';

-- 문제4) 세일즈 부서에서 근무하고 있는 사람들을 출력하라.
SELECT e.first_name || ' ' || e.last_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND d.department_name LIKE 'Sales';

-- 문제5) 사원테이블과 부서 테이블의 부서번호를 조인하고 SA_MAN 사원만의 사원번호 이름 급여 부서면 근무지를 출력 , Alias사용
SELECT e.employee_id, e.first_name || ' ' || e.last_name, e.salary, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.job_id LIKE 'SA_MAN';

-- 문제6) 사원 테이블과 부서 테이블에서 부서 테이블에 있는 모든자료를 사원번호, 이름 업무
-- 사원테이블의 부서번호, 부서테이블의 부서번호, 부서명, 근무지를 출력하여라
SELECT *
FROM employees e FULL OUTER JOIN departments d
WHERE e.department_id = d.department_id;

-- 문제7) 사원테이블에서 셀프조인하여 관리자 를 출력하여라.
SELECT e.first_name || ' ' || e.last_name"사원", d.first_name || ' ' || d.last_name"관리자"
FROM employees e, employees d
WHERE e.manager_id = d.employee_id;

-- 문제8) 사원테이블에서 왼쪽조인하여 관리자 를 출력하고 매니저 아이디가 없는 사람은 배제하고 하향식으로 하며, 급여는 역순으로 출력하라.
SELECT e.first_name || ' ' || e.last_name"사원", d.first_name || ' ' || d.last_name"관리자", e.salary
FROM employees e, employees d
WHERE e.manager_id = d.employee_id(+)
AND e.manager_id IS NOT NULL
CONNECT BY e.manager_id = PRIOR e.employee_id
ORDER BY e.salary DESC;

-- 문제9) 사원테이블에서
SELECT e.first_name || ' ' || e.last_name"사원", d.first_name || ' ' || d.last_name"관리자", e.salary
FROM employees e, employees d
WHERE e.manager_id(+) = d.employee_id
AND e.manager_id IS NOT NULL
CONNECT BY PRIOR e.manager_id = e.employee_id
ORDER BY e.salary DESC;


-- 문제1) emp 테이블에서 kochhar의 급여보다 많은 사원의 정보를 사원번호, 이름, 담당 업무, 급여를 출력하라.
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Kochhar');

-- 문제2) emp테이블에서 급여의 평균보다 적은 사원의 정보를 사원번호, 이름, 담당 업무, 급여, 부서번호를 출력하여라.
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE salary < (SELECT AVG(salary)FROM employees);

-- 문제3) emp 테이블에서 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하라.
SELECT department_id
FROM employees
WHERE salary >(
SELECT MIN(salary)
FROM employees
WHERE department_id = '100')
GROUP BY department_id;

SELECT department_id
FROM employees
WHERE (SELECT MIN(salary)FROM employees GROUP BY department_id) > (SELECT MIN(salary)FROM employees WHERE department_id = '100')
GROUP BY department_id;

-- 문제4) 업무별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서번호를 출력하여라.
SELECT e.employee_id, e.last_name, e.job_id, e.department_id
FROM employees e, (SELECT job_id, MIN(salary)"최소급여"
FROM employees
GROUP BY job_id) a
WHERE e.job_id = a.job_id
AND e.salary = "최소급여"
ORDER BY e.job_id;

-- 문제5) emp와 dep 테이블에서 업무가 세일즈맨 사원의 정보를 이름, 업무, 부서명, 근무지를 출력하여라
SELECT e.last_name, job_id, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND job_id = 'SA_MAN';

-- 문제6) emp 테이블에서 가장 많은 사원을 갖는 manager의 사원번호를 출력하여라.
SELECT ROWNUM, manager_id
FROM (SELECT manager_id, COUNT(*)
FROM employees
GROUP BY manager_id ORDER BY COUNT(*)DESC)
WHERE ROWNUM = 1;

SELECT "순서", manager_id
FROM(
SELECT ROWNUM"순서", manager_id
FROM (SELECT manager_id, COUNT(*)
FROM employees
GROUP BY manager_id ORDER BY COUNT(*)DESC)
)WHERE "순서" = 1;

SELECT manager_id, COUNT(manager_id)
FROM employees
GROUP BY manager_id
HAVING COUNT(manager_id) =( SELECT MAX(COUNT(*))FROM employees GROUP BY manager_id);

-- 문제7) emp 테이블에서 가장 많은 사원이 속해 있는 부서번호와 사원수를 출력하여라.
SELECT e.department_id, "사원수"
FROM employees e, (
SELECT ROWNUM, manager_id,"사원수"
FROM (SELECT manager_id, COUNT(*)"사원수"
FROM employees
GROUP BY manager_id ORDER BY COUNT(*)DESC)
WHERE ROWNUM = 1) d
WHERE e.employee_id = d.manager_id; -- 다시확인

SELECT department_id, COUNT(department_id)
FROM employees
GROUP BY department_id
HAVING COUNT(department_id) = (SELECT MAX(COUNT(*))FROM employees GROUP BY department_id);

-- 문제8) emp 테이블에서 사원번호가 123인 사원의 직업과 같고 사원번호가 192인 사원의 급여(SAL) 보다 많은 사원의 사원번호, 이름, 직업, 급여를 출력하여라.
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id = ( SELECT job_id FROM employees WHERE employee_id = '123' )
AND salary > ( SELECT salary FROM employees WHERE employee_id = '192' );

-- 문제9) 직업(job)별로 최소 급여를 받는 사원의 정보를 사원번호. 이름, 업무, 부서면을 출력하여라. -- 조건1: 직업별로 내림차순정렬
SELECT e.employee_id, e.last_name, e.job_id, e.department_id, e.salary
FROM employees e, (SELECT job_id, MIN(salary)"최소급여" FROM employees GROUP BY job_id ORDER BY job_id DESC) a
WHERE e.job_id = a.job_id
AND e.salary = "최소급여";

-- 문제10) emp 테이블에서 업무별로 최소급여를 받는 사원의 정보를 사원번호, 이름, 업무, 입사일자, 급여, 부서번호를 출력
SELECT e.employee_id, e.last_name, e.job_id, e.hire_date, e.salary, e.department_id
FROM employees e, (SELECT job_id, MIN(salary)"최소급여" FROM employees GROUP BY job_id ORDER BY job_id DESC) a
WHERE e.job_id = a.job_id
AND e.salary = "최소급여";

-- 문제11) emp 테이블에서 50번 부서의 최소 급여를 받는 사원 보다 많은 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 입사일자, 급여, 부서번호를 출력하라. 단 50번의 제외
SELECT employee_id, last_name, job_id, hire_date, salary, department_id
FROM employees
WHERE salary > (SELECT MIN(salary) FROM employees GROUP BY department_id HAVING department_id = '50')
AND department_id NOT IN ('50');

-- 문제12) emp 테이블에서 50번 부서의 최고급여를 받는 사원보다 많은 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 입사일자, 급여, 부서번호를 출력하라. 단 50번은 제외
SELECT employee_id, last_name, job_id, hire_date, salary, department_id
FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees GROUP BY department_id HAVING department_id = '50')
AND department_id NOT IN ('50');

-- 문제13) 최근 입사한 사원 순으로 작성해서 1~ 10번째 11~ 20번 사원의 정보를 출력하시오.
SELECT e.employee_id, e.last_name, "입사순서", e.hire_date, e.salary
FROM employees e, (
SELECT ROWNUM"입사순서", hire_date, employee_id
FROM (SELECT * FROM employees ORDER BY hire_date)) a
WHERE e.employee_id  = a.employee_id
AND "입사순서" BETWEEN 1 AND 20;

-- 특수쿼리 scott
-- 문제14) 각사원의 이름을 표시하고 근무달 수 (입사일로부터 현재까지의 달수) 를 게산하여, 열 레이블을 MONTHS WORKED로 지정하시오.
-- 결과는 정수로 반올림하여 표시하고, 근무달수를 기준으로 오름차순으로 정렬하시오. (MONTHS_BETWEEN 참고)
SELECT ename, ROUND(MONTHS_BETWEEN(SYSDATE,hiredate))"MONTHS WORKED" -- MONTHS_BETWEEN 날짜 빼주는것
FROM emp
ORDER BY hiredate DESC;

-- 문제15) emp 테이블에서 이름, 업무, 근무연차를 출력하시오.
SELECT ename, job, hiredate, SUBSTR(TO_CHAR(SYSDATE, 'YYYYMMDD'), 1,4) - SUBSTR(TO_CHAR(hiredate, 'YYYYMMDD'),1,4)"연차"
FROM emp;

-- 문제16) emp 테이블에서 사원이름, 월급, 월급과 커미션을 더한 값을 컬럼명 실급여라고 해서 출력, 단, NULL 값은 나타나지 않게 작성하시오
SELECT ename, sal"월급", sal+NVL(comm, 0)"실급여"
FROM emp;

-- 문제17) 월급과 커미션을 합친 금액이 2000 이상인 급여를 받는 사원의 이름, 업무, 월급, 커미션, 고용날짜를 출력하시오. 단 고용날짜는 1980-12-17 형태로 출력
SELECT ename"이름", job"업무", sal"월급", NVL(comm,0)"커미션", TO_CHAR(hiredate, 'YYYY-MM-DD')"고용날짜" -- 문자로 바꾸기 TO_CHAR
FROM emp
WHERE sal+NVL(comm, 0) > 2000;

-- 문제18) DECODE 또는 CASE WHEN THEN 함수를 사용하여 다음데이터에 따라 JOB 열의 값을 기준으로 모든 사원의 등급을 표시하시오.
SELECT ename, job,
    CASE job
    WHEN 'PRESIDENT' THEN 'A'
    WHEN 'ANALYST' THEN 'B'
    WHEN 'MANAGER' THEN 'C'
    WHEN 'SALESMAN' THEN 'D'
    WHEN 'CLERK' THEN 'E'
    ELSE '0'
    END "직업등급"
FROM emp;

SELECT ename, job, DECODE(job, 'PRESIDENT','A', 'ANALYST','B', 'MANAGER','C', 'SALESMAN','D', 'CLERK','E','0')"직업등급"
FROM emp;

-- SUBQUERY
-- 문제19) BLAKE와 같은부서에 있는 사원들의 이름과 입사일을 구하는데 BLAKE는 제외하고 출력하시오.
SELECT ename, hiredate, deptno
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE ename = 'BLAKE')
AND ename NOT IN('BLAKE');

-- 문제20) 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을 출력하는데 월급이 높은 사람순으로 출력하시오.
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT AVG(sal)FROM emp)
ORDER BY sal DESC;

-- 문제21) 10번 부서에서 급여를 가장 적게 받는 사원 과 동일한 급여를 받는 사원의 이름을 출력하시오.
SELECT ename, sal
FROM emp
WHERE sal = (SELECT MIN(sal) FROM emp WHERE deptno = '10');

-- 문제22) 사원수가 3명이 넘는 부서의 부서명과 사원수를 출력하시오.
SELECT DISTINCT d.dname, "사원수"
FROM emp e, (SELECT deptno, COUNT(*)"사원수" FROM emp GROUP BY deptno HAVING COUNT(*)>3)c, dept d
WHERE e.deptno = d.deptno
AND e.deptno = c.deptno;

-- 문제23) 사원번호가 7844인 사원 보다 빨리 입사한 사원의 이름과 입사일을 출력하시오.
SELECT ename, hiredate
FROM emp
WHERE hiredate < (SELECT hiredate FROM emp WHERE empno = '7844');

-- 문제24) 직속상사 (mgr)가 king인 모든사원의 이름과 급여를 출력하시오
SELECT ename, sal
FROM emp
WHERE mgr = (SELECT empno FROM emp WHERE ename = 'KING');

-- 문제25) 20번부서에서 가장 급여를 많이 받는 사원과 동일한 급여를 받는 사원의 이름과 부서명, 급여, 급여등급을 출력하시오
SELECT e.ename, d.dname, e.sal, s.grade
FROM emp e, dept d, salgrade s
WHERE e.deptno = d.deptno
AND sal = (SELECT MAX(sal) FROM emp WHERE deptno = '20')
AND sal BETWEEN s.losal AND s.hisal;


-- 문제26) 총급여 sal +comm 이 평균급여보다 많은 급여를 받는 사람의 부서번호, 이름, 총급여, 커미션을,출력하시오. 커미션은 유 o 무x 로 표시하고, 컬럼명은 "comm유무" 출력
SELECT deptno, ename, sal+NVL(comm,0), NVL2(comm, 'O', 'X'),
    CASE NVL(comm,0)
    WHEN 0 THEN 'x'
    ELSE 'o'
    END"comm유무"
FROM emp
WHERE sal+NVL(comm,0) > (SELECT AVG(sal) FROM emp);

-- 문제27) CHICAGO 지역에서 근무하는 사원의 평균 급여보다 높은 급여를 받는 사원의 이름과 급여 지역명을 출력하시오.
SELECT e.ename, e.sal, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND sal > (SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'CHICAGO')); -- 그룹을 안해도 값이 나오는이유

-- 문제28) 업무가 SALESMAN인 직원이 2명 이상인 부서의 이름, 근무하는 사원의 이름, 업무를 출력하시오. ( 컬럼명은 부서명, 사원명, 업무로 출력)
SELECT de.dname"부서명", e.ename"사원명", e.job"업무"
FROM emp e, (SELECT deptno FROM emp WHERE job = 'SALESMAN' GROUP BY deptno HAVING COUNT(job) >2) d, dept de
WHERE e.deptno = d.deptno 
AND e.deptno = de.deptno;

-- 문제29) 커미션이 없는 사원들 중 월급이 가장 높은 사원의 이름과 급여등급을 출력하시오.
SELECT "순위", "사원이름", "급여등급"
FROM (SELECT ROWNUM"순위", "사원이름", "급여등급"
FROM (SELECT ename"사원이름", s.grade"급여등급"
FROM emp e, (SELECT empno FROM emp WHERE comm IS NULL)d, salgrade s
WHERE e.empno = d.empno
AND sal BETWEEN s.losal AND s.hisal
ORDER BY sal DESC))
WHERE "순위" = 1;

-- 문제30) SMITH의 관리자(mgr)의 이름과 부서명, 근무지역을 출력하시오.
SELECT e.ename, d.dname, d.loc
FROM emp e, dept d
WHERE empno =(SELECT mgr FROM emp WHERE ename = 'SMITH')
AND e.deptno = d.deptno;

-- 문제1) 테이블명 address, id, name, addr, phone, email 생성하기.
CREATE TABLE address (id VARCHAR2(10), name VARCHAR2(10), addr VARCHAR2(10), phone VARCHAR2(10), email VARCHAR2(10));

-- 문제2) 주소록 테이블의 구조와 데이터를 복사하여 addr_second 테이블을 생성. (구조와 데이터만 복사해서 생성함.)
CREATE TABLE addr_second AS SELECT * FROM address;

-- 문제3) 주소록 테이블에서 id, name 칼럼만 복사하여 addr_forth 테이블을 생성(구조만 복사)
CREATE TABLE addr_forth AS SELECT id, name FROM address WHERE 1=2;

-- 문제4) Address 테이블에 5개의 데이터를 추가하세요.
INSERT INTO address VALUES
  ('1 First', 'G45 EU8', 'Paris', 'CA', 'US');

-- 문제5) Address 테이블에서 id, name, 만 가진 Address2테이블을 만들고, 자료를 전부 가지고 오기.
CREATE TABLE address2 AS SELECT id, name FROM address; 

-- 문제6) 주소록 테이블에 날짜 타입을 가지는 birth 칼럼을 추가.
ALTER TABLE address
ADD birth DATE;

-- 문제7) 주소록 테이블에 문자 타입을 가지는 comments 칼럼을 추가. 기본값은 'NO COmment'로 지정하여라.
ALTER TABLE address
ADD (comments VARCHAR2(100) default 'NO Comment');

-- 문제8) 주소록 테이블에서 comments 칼럼을 삭제
ALTER TABLE address
DROP (comments);

-- 문제9) 주소록 테이블에서 phone 칼럼의 데이터 타입의 크기를 50으로 증가.
ALTER TABLE address
MODIFY (phone VARCHAR2(50));

DROP TABLE address
CASCADE CONSTRAINTS;

DROP TABLE addr_second
CASCADE CONSTRAINTS;

DROP TABLE addr_forth
CASCADE CONSTRAINTS;

-- 문제1) emp 테이블에서 부서별로 인원수, 평균, 급여, 급여의 합 , 최소급여, 최대 급여를 포함하는 emp_deptno 테이블을 생성하라.
CREATE TABLE emp_deptno AS SELECT COUNT(*)"인원수", AVG(sal)"평균급여", SUM(sal)"급여의 합", MIN(sal)"최소급여", MAX(sal)"최대급여" FROM emp GROUP BY deptno;

-- 문제2) emp_depto 테이블에 etc column을 추가하라. 단, 자료형음 varchar(50)을사용.
ALTER TABLE emp_deptno
ADD etc_column VARCHAR2(50);

-- 문제3) 자료형 15로 수정
ALTER TABLE emp_deptno
MODIFY etc_column VARCHAR2(15);

-- 문제4) 테이블에 있는 etc를 삭제하고 확인
ALTER TABLE emp_deptno
DROP (etc_column);

-- 문제5) 이전에 생성한 emp 테이블의 이름을 emp_dept
ALTER TABLE emp_deptno
RENAME TO emp_dept;

RENAME emp_deptno TO emp_dept; -- 이것도 가능.

-- 문제6) 테이블삭제
DROP TABLE emp_dept
CASCADE CONSTRAINTS;

-- 문제7) employees 테이블을 emp 테이블로 생성하고 복제 해라.
CREATE TABLE emp AS SELECT * FROM employees;

-- 문제8) emp 테이블에 row를 추가, 다만 반드시 데이터를 기입 null 설정.
INSERT INTO emp (employee_id, frist_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (300, null, '홍', 'HONG@naver.com', null, SYSDATE, 'IT_PROG', 10000, NULL, NULL, 60);

-- 문제9) employees 테이블에서 empno ename sal hiredate 선택 emp_10 테이블을 생성
CREATE TABLE emp_10 AS SELECT empno, ename, sal, hiredate FROM emp;

-- 문제10)emp 테이블에서 사원번호가 107인 사원의 부서를 10번으로 변경
UPDATE employees
SET department_id = 10
WHERE employee_id = 107;

-- 문제11) emp 테이블에서 사원번호가 180 인 사원의 부서를 20, 급여를 3500으로 변경 하여라.
UPDATE employees
SET department_id = 20, salary = 3500
WHERE employee_id = 180;

-- 문제12) emp 테이블에서 smith의 업무와 급여가 hall의 업무와 급여와 일치하도록 수정하여라.
UPDATE employees
SET job_id = (SELECT job_id FROM employees WHERE last_name IN('Hall')),
salary = (SELECT salary FROM employees WHERE last_name IN('Hall'))
WHERE last_name IN('Smith'); -- HALL 업무 SA_REP, 급여 9000

-- OR REPLACE VIEW를 많이 사용함.
--문제1) EMPLOYEES 테이블에서 20번 부서의 세부 사항을 포함하는 EMP_20 VIEW를 생성 하라 
CREATE VIEW emp_20
AS
SELECT e.employee_id, e.first_name, e.last_name, e.job_id, e.salary , d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.department_id = 20;

SELECT *
FROM emp_20;

DROP VIEW emp_20;
--문제2) EMPLOYEES 테이블에서 30번 부서만 EMPLOYEE_ID 를 emp_no 로 LAST_NAME을 name으로 SALARY를 sal로 바꾸어 EMP_30 VIEW를 생성하라. 
CREATE VIEW emp_30 ("emp_no", "name", "sal")
AS
SELECT employee_id, last_name, salary
FROM employees
WHERE department_id = 30; -- 3가지 column 만 가지고 왔기 때문에 추가나 수정이 불가능한 view 이다.

SELECT *
FROM emp_30;

DROP VIEW emp_30;
--문제3) 부서별로 부서명,최소 급여,최대 급여,부서의 평균 급여를 포함하는 DEPT_SUM VIEW을 생성하여라. 
CREATE OR REPLACE VIEW dept_sum("부서명", "최소 급여", "최대 급여", "부서의 평균 급여")
AS
SELECT DISTINCT d.department_name,
MIN(e.salary)OVER(PARTITION BY e.department_id ),
MAX(e.salary)OVER(PARTITION BY e.department_id ),
ROUND(AVG(e.salary)OVER(PARTITION BY e.department_id))
FROM employees e, departments d
WHERE e.department_id = d.department_id;

CREATE OR REPLACE VIEW dept_sum("부서명", "최소 급여", "최대 급여", "부서의 평균 급여")
AS
SELECT DISTINCT d.department_name, MIN(e.salary), MAX(e.salary),ROUND(AVG(e.salary))
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_name;

SELECT *
FROM dept_sum;

DROP VIEW dept_sum;

--문제4) 앞에서 생성한 EMP_20,EMP_30 VIEW을 삭제하여라. ^^
DROP VIEW emp_20;
DROP VIEW emp_30;
-- SEQUENCE

--문제1) 초기값1부터 최대값999,999까지 1씩 증가하는 TEST_SEQ SEQUENCE를 생성하여라.
CREATE SEQUENCE test_seq
INCREMENT BY 1 -- 증가 설정
START WITH 1 -- 시작 숫자 설정
MAXVALUE 999999 -- 최대 설정 (보통생략함.)
NOCACHE -- 오라클서버가 미리 할당하고, 유지하는것을 결정
NOCYCLE -- 최대값, 최소값에 도달한 후에 계속 값을 생성할지를 지정
MINVALUE 1; -- 최소 설정 

--문제2) 1번에서 작성한 SRQUENCE의 현재 값을 조회하여라.
SELECT test_seq.NEXTVAL
FROM dual;
SELECT test_seq.CURRVAL -- sequence CURRVAL has been selected before sequence NEXTVAL
FROM dual;

--문제3) CURRVAL과 NEXTVAL을 설명하여라.
-- CURRVAL 은 현재의 시퀀스넘버를 불러오는것이며,
-- NEXTVAL 은 다음 시퀀스 값을 생성해 역할을 한다.
-- 즉, 초기에 NEXTVAL을 실행시키지 않으면, 시퀀스값이 없기 때문에 시퀀스를 생성하고 바로 CURRVAL 을 실행하면 오류가 나온다.

--문제4) 1번에서 생성한 SRQUENCE를 삭제하여라.
DROP SEQUENCE test_seq;