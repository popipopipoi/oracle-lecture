-- 10. VIEW

-- 사번, 이름, 직급명, 부서명, 근무지역을 조회하고 그 결과를 V_RESULT_EMP라는 뷰로 생성
CREATE OR REPLACE VIEW V_RESULT_EMP
AS
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_NAME
     , DEPT_TITLE
     , LOCAL_NAME
  FROM EMPLOYEE E
  LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);
  
-- 직원 관리 계정에는 뷰 객체 생성 권한이 부여 되어 있지 않아 권한 불충분 오류 발생
-- 시스템 계정으로 변환하여 뷰 객체 생성 권한을 부여한 뒤 작업한다
GRANT CREATE VIEW TO C##EMPLOYEE;

-- 뷰를 통해 조회
SELECT
       V.*
  FROM V_RESULT_EMP V
 WHERE V.EMP_ID = '205';
 
-- 뷰에 대한 정보를 확인하는 데이터 딕셔너리
SELECT
       UV.*
  FROM USER_VIEWS UV;

-- 뷰에 별칭을 부여해서 생성
CREATE OR REPLACE VIEW V_EMP
(
  사번
, 이름
, 부서
)
AS
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
  FROM EMPLOYEE;
  
SELECT
       V.*
  FROM V_EMP V;

-- 뷰 삭제
DROP VIEW V_EMP;

-- 베이스테이블에서 정보 변경 테스트
COMMIT;

UPDATE
       EMPLOYEE
   SET EMP_NAME = '홍길동'
 WHERE EMP_ID = '200';
 
SELECT
       E.*
  FROM EMPLOYEE E
 WHERE EMP_ID = '200';

-- 베이스 테이블의 정보가 변경 되면 VIEW의 정보도 같이 변경된다.
SELECT
       V.*
  FROM V_RESULT_EMP V
 WHERE EMP_ID = '200';
 
ROLLBACK;

DROP VIEW V_RESULT_EMP;

-- 컬럼에 함수식 연산 등이 처리 되었을 경우 뷰의 컬럼명이 될 수 없으므로
-- 반드시 별칭을 지정해서 뷰를 생성해야 한다.
CREATE OR REPLACE VIEW V_EMP_JOB
(
  사번
, 이름
, 직급
, 성별
, 근무년수
)
AS
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_NAME
     , DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여')
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE);
  
SELECT
       V.*
 FROM V_EMP_JOB V;
 
-- VIEW를 이용한 DML 구문 동작 테스트
CREATE OR REPLACE VIEW V_JOB
AS
SELECT
       JOB_CODE
     , JOB_NAME
  FROM JOB;
  
INSERT
  INTO V_JOB
(
  JOB_CODE
, JOB_NAME
)
VALUES
(
  'J8'
, '인턴'
);

SELECT
       V.*
  FROM V_JOB V;
  
SELECT
       J.*
  FROM JOB J;
  
UPDATE
       V_JOB
   SET JOB_NAME = '알바'
 WHERE JOB_CODE = 'J8';
 
SELECT
       V.*
  FROM V_JOB V;
  
SELECT
       J.*
  FROM JOB J;
  
DELETE
  FROM V_JOB
 WHERE JOB_CODE = 'J8';
 
SELECT
       V.*
  FROM V_JOB V;
  
SELECT
       J.*
  FROM JOB J;
  
-- DML 명령어로 VIEW 조작이 불가능한 경우

-- 1. 뷰 정의에 포함 되지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW V_JOB2
AS
SELECT JOB_CODE
  FROM JOB;
  
SELECT
       V.*
  FROM V_JOB2 V;
-- "JOB_NAME": 부적합한 식별자 오류 
INSERT
  INTO V_JOB2
(
  JOB_CODE
, JOB_NAME
)
VALUES
(
  'J8'
, '인턴'
);
-- 뷰 정의에 사용 된 컬럼만 사용하므로 삽입 가능
INSERT
  INTO V_JOB2
(
  JOB_CODE
)
VALUES
(
  'J8'
);

SELECT
       J.*
  FROM JOB J;

-- 뷰 정의에 사용 된 컬럼만 사용하여 DELETE 가능
DELETE
  FROM V_JOB2
 WHERE JOB_CODE = 'J8';
 
-- 2. 뷰에 포함되지 않은 컬럼중에 
-- 베이스가 되는 테이블의 컬럼이 NOT NULL 제약 조건이 지정 된 경우
CREATE OR REPLACE VIEW V_JOB3
AS
SELECT JOB_NAME
  FROM JOB;
  
SELECT
       V.*
  FROM V_JOB3 V;
-- "JOB_CODE": 부적합한 식별자 
INSERT
  INTO V_JOB3
(
  JOB_CODE
, JOB_NAME
)
VALUES
(
  'J8'
, '인턴'
);
-- NULL을 ("C##EMPLOYEE"."JOB"."JOB_CODE") 안에 삽입할 수 없습니다
INSERT
  INTO V_JOB3
(
  JOB_NAME
)
VALUES
(
  '인턴'
);
-- 뷰에 정의 된 컬럼만을 사용한 UPDATE 수행 가능
UPDATE
       V_JOB3
   SET JOB_NAME = '인턴'
 WHERE JOB_NAME = '사원';
 
-- 3. 산술 표현식으로 정의 된 경우
CREATE OR REPLACE VIEW EMP_SAL
AS
SELECT EMP_ID
     , EMP_NAME
     , SALARY
     , (SALARY+ (SALARY * NVL(BONUS, 0))) * 12 연봉
  FROM EMPLOYEE;
-- 가장 컬럼에는 INSERT 불가
INSERT
  INTO EMP_SAL
(
  EMP_ID
, EMP_NAME
, SALARY
, 연봉
)
VALUES
(
  '800'
, '정지훈'
, 3000000
, 40000000
);
-- 가상 컬럼을 UPDATE 하는 것도 불가
UPDATE
       EMP_SAL
   SET 연봉 = 88000000
 WHERE EMP_ID = '200';
-- DELETE의 조건 컬럼으로는 사용 가능
DELETE
  FROM EMP_SAL
 WHERE 연봉 = 124800000;
 
ROLLBACK;

-- 4. JOIN을 이용해 여러 테이블을 연결한 경우
CREATE OR REPLACE VIEW V_JOINEMP
AS
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- 조인 뷰에 의하여 하나 이상의 기본 테이블을 수정할 수 없습니다.
INSERT
  INTO V_JOINEMP
(
  EMP_ID
, EMP_NAME
, DEPT_TITLE
)
VALUES
(
  888
, '조세오'
, '인사관리부'
);
-- 키-보존된것이 아닌 테이블로 대응한 열을 수정할 수 없습니다
UPDATE
       V_JOINEMP V
   SET V.DEPT_TITLE = '인사관리부';
-- DELETE의 조건으로 사용하는 것은 가능   
DELETE
  FROM V_JOINEMP V
 WHERE V.EMP_ID = '219';
 
ROLLBACK;

-- 5.DISTINCT를 포함한 경우
CREATE OR REPLACE VIEW V_DT_EMP
AS
SELECT DISTINCT E.JOB_CODE
  FROM EMPLOYEE E;
-- 뷰에 대한 데이터 조작이 부적합합니다 
INSERT
  INTO V_DT_EMP
(
  JOB_CODE
)
VALUES
(
  'J9'
);

UPDATE
       V_DT_EMP V
   SET V.JOB_CODE = 'J9';
   
DELETE
  FROM V_DT_EMP V
 WHERE V.JOB_CODE = 'J7';
 
-- 6. 그룹 함수나 GROUP BY절을 포함한 경우
CREATE OR REPLACE VIEW V_GROUPDEPT
AS
SELECT E.DEPT_CODE
     , SUM(E.SALARY) 합계
     , AVG(E.SALARY) 평균
  FROM EMPLOYEE E
 GROUP BY E.DEPT_CODE;
-- 가상 컬럼에 INSERT 불가 
INSERT
  INTO V_GROUPDEPT
(
  DEPT_CODE
, 합계
, 평균
)
VALUES
(
  'D0'
, 6000000
, 400000
);
-- 뷰에 대한 데이터 조작이 부적합합니다
UPDATE
       V_GROUPDEPT V
   SET V.DEPT_CODE = 'D10'
 WHERE V.DEPT_CODE = 'D1';
-- 뷰에 대한 데이터 조작이 부적합합니다 
DELETE
  FROM V_GROUPDEPT V
 WHERE V.DEPT_CODE = 'D1';
 
-- VIEW OPTION
-- FORCE / NOFORCE
CREATE OR REPLACE FORCE VIEW V_EMP
AS
SELECT TCODE
     , TNAME
     , TCONTNET
  FROM TT;
  
CREATE OR REPLACE /*NOFORCE*/ VIEW V_EMP
AS
SELECT TCODE
     , TNAME
     , TCONTNET
  FROM TT;
  
-- WITH CHECK OPTION : 조건절에 사용 된 컬럼의 값을 수정하기 못하게 하는 옵션
CREATE OR REPLACE VIEW V_EMP2
AS
SELECT
       E.*
  FROM EMPLOYEE E
 WHERE MANAGER_ID = '200'
  WITH CHECK OPTION;
  
UPDATE
       V_EMP2
   SET MANAGER_ID = '900'
 WHERE MANAGER_ID = '200';
 
-- WITH READ ONLY : DML 수행을 불가능하게 하는 옵션
CREATE OR REPLACE VIEW V_DEPT
AS
SELECT
       D.*
  FROM DEPARTMENT D
  WITH READ ONLY;
-- 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
DELETE
  FROM V_DEPT;
 


