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
