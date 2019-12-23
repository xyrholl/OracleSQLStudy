/*
sequence : 유일한 값을 생성해주는 Oracle Object
회원번호, 게시판 관리 글 번호
초기화가 불가능하다. 삭제후 다시 사용
static int count = 1;
count++;
*/
--sequence 생성
CREATE SEQUENCE test_seq
INCREMENT BY 1 -- 증가 설정
START WITH 10 -- 시작 숫자 설정
MAXVALUE 100 -- 최대 설정 (보통생략함.)
MINVALUE 1; -- 최소 설정 


-- CURRVAL -- 현재의 시퀀스 값
SELECT test_seq.CURRVAL -- currentvalue
FROM dual; -- 바로실행시 오류가 나옴 nextval 실행후 실행시켜야함.

-- NEXTVAL -- 진행 값
SELECT test_seq.NEXTVAL
FROM dual;

--INSERT INTO employees
--VALUES (employees_seq.NEXTVAL) 이렇게 사용함.

-- sequence 수정
ALTER SEQUENCE test_seq
INCREMENT BY 3;

-- SEQUENCE 초기화가 불가 하므로 지워야한다.
DROP SEQUENCE test_seq;

-- 동의어 (SYNONYM / 객체의 별명)
/*
Oracle DB 개발자들은 자주사용함.
int array_position_number[];
int arrPosNum[] = array_position_number[];
*/
CREATE SYNONYM "사원들"
FOR employees;

INSERT INTO  "사원들"
VALUES (employees_seq.NEXTVAL, '길동', '홍', 'hgd.naver.com', '123-456-8910', TO_DATE('20051001', 'YYYYMMDD'), 'IT_PROG', 20000, NULL, 100, 10);

SELECT *
FROM 사원들;