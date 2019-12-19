/*
index == 색인 목차
원하는 정보의 위치를 빠르고 정확하게 알아 낼 수 있는 방법.

-- 자동생성 : Primary key, Unique key
-- 수동생성 : Query

생성을 했을때 효울적인 경우가 있고 비효율적인 경우도 있다.

효율적인 경우 :
1.WHERE 절이나 JOIN 조건안에 자주 사용 되는 COLUMN이 여기에 해당한다.
ex1) department_id -primary key 이기때문에 생성되어져있다.
2.NULL 값이 많이 포함되어 있는 column
ex2) manager_id
3.WHERE절이나 JOIN조건간에 두개이상 사용하는 COLUMN dlf ruddn

비효율적인 경우 : 
1.테이블의 크기가 작을때 (LOW)가 작을때 사용하면 오히려 역효과이다. 3000개 이하.
2.테이블이 자주 갱신될때 COLUMN의 추가 생성이 자주 일어날때

즉, 일반적으로는 Primary key 로 설정이 되어있어 자동생성이 되어있기 때문에 수동으로 생성하는 경우는 잘없다.
*/

CREATE TABLE emp_copy
AS
SELECT * FROM employees; -- 복사할 경우 제약조건이 없음.

-- 자동생성 (기본키와 고유키를 생성하면 자동생성된다.)
ALTER TABLE emp_copy
ADD 
CONSTRAINT pk_empcopy_01 PRIMARY KEY (employee_id);

-- INDEX 확인
SELECT * FROM ALL_INDEXES
WHERE index_name = 'pk_empcopy_01';

-- 강제생성
CREATE INDEX emp_copy_index01
ON emp_copy(manager_id);

SELECT * FROM ALL_INDEXES
WHERE index_name = 'emp_copy_index01';

DROP INDEX pk_empcopy_01; -- "cannot drop index used for enforcement of unique/primary key"
DROP INDEX emp_copy_index01;