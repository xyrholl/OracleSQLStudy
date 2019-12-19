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
