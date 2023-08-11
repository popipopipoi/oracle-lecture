-- 12.. INDEX

--ROWID
SELECT
       ROWID
     , EMP_ID
     , EMP_NAME
  FROM EMPLOYEE;
  
-- USER_INDEXES
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS;

-- 인덱스 힌트
-- 원하는 테이블의 인덱스를 사용할 수 있도록 구문을 통해 선택
SELECT /*+ INDEC(E 엔터키1_PK)*/
       E.*
  FROM EMPLOYEE E;

SELECT /*+ INDEC_DESE(E 엔터키1_PK)*/
       E.*
  FROM EMPLOYEE E;
  
-- 고유 인덱스
-- 중복 값이 없는 컬럼은 UNIQUE 인덱스를 생성할 수 있다.
CREATE UNIQUE INDEX IDX_EMPNO
ON EMPLOYEE(EMP_NO);
-- 중복 값이 있는 컬럼은 UNIQUE 인덱스를 생성할 수 없다.
CREATE UNIQUE INDEX IDX_DEPT_CODE
ON EMPLOYEE(DEPT_CODE);

-- 비고유 인덱스
-- WHERE절에서 빈번하게 사용 되는 일반 컬럼을 대상으로 생성할 수 있다.
CREATE INDEX IDX_DEPT_CODE
ON EMPLOYEE(DEPT_CODE);

-- 결합 인덱스
-- 결합 인덱스는 중복 값이 낮은 값이 먼저 오는 것이 검색 속도를 향상 시킨다.
CREATE INDEX IDX_DEPT
ON DEPARTMENT (DEPT_ID, DEPT_TITLE);

SELECT /*+ INDEX_DESC(D IDX_DEPT)*/
       D.DEPT_ID
  FROM DEPARTMENT D
 WHERE D.DEPT_ID > '0'
   AND D.DEPT_TITLE > '0';
   
-- 함수 기반 인덱스
-- 계산식으로 검색하는 경우가 많다면, 수식이나 함수식으로 이루어진 컬럼을 인덱스로 만들 수 있다.
CREATE INDEX IDX_EMP_SALCALC
ON EMPLOYEE((SALARY + (SALARY * NVL(BONUS, 0))) * 12);

SELECT /*+ INDEX_DESC(E IDX_EMP_SALCALC)*/
       E.EMP_ID
     , E.EMP_NAME
     , (E.SALARY + (E.SALARY * NVL(E.BONUS,0))) * 12 연봉
  FROM EMPLOYEE E
 WHERE (E.SALARY + (E.SALARY * NVL(E.BONUS,0))) * 12 > 1000000;