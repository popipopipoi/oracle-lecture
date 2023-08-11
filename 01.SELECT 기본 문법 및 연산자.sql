-- 01. SELECT 기본 문법

-- 모든 행 모든 컬럼 조회
SELECT
       *
  FROM EMPLOYEE;
  
-- 원하는 컬럼 조회
-- 사번, 이름 조회
SELECT
      EMP_ID
    , EMP_NAME
 FROM EMPLOYEE;
 
 -- 원하는 행 조회
 -- 부서코드가 D9인 사원 조회
 SELECT
       *
   FROM EMPLOYEE
  WHERE DEPT_CODE = 'D9';
-- 직급 코드가 J1인 사원 조회
SELECT
       *
  FROM EMPLOYEE
 WHERE JOB_CODE = 'J1';
 
 -- 원하는 행과 컬럼 조회
 --금여가 300만원 이상인 사원의 사번, 이름, 부서코드, 급여 조회
 SELECT
        EMP_ID
      , EMP_NAME
      , DEPT_CODE
      , SALARY
   FROM EMPLOYEE
  WHERE SALARY >= 3000000;
  
-- AS + 별칭을 기술하여 별칭을 지을 수 있다.
SELECT
        EMP_NAME AS 이름
      , SALARY * 12 "1년 급여"
      , (SALARY + (SALARY * BONUS)) * 12 AS "총 소득"
      , (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "총 소득"
  FROM EMPLOYEE;
  -- 임의로 지정한 문자열을 SELECT절에서 사용할 수 있다.
SELECT
        EMP_ID
      , EMP_NAME
      , SALARY
      , '원' AS 단위
   FROM EMPLOYEE;
   
-- DISTINCT
SELECT
       DISTINCT JOB_CODE
  FROM EMPLOYEE;
  
SELECT
       DISTINCT JOB_CODE
    , /*DISTINCT*/ DEPT_CODE
  FROM EMPLOYEE;
  
-- 부서코드가 D6이고 급여가 200만원을 초과하는 직원의
-- 이름, 부서코드, 급여 조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D6'
   AND SALARY > 2000000;
   
-- NULL값 조회
-- 보너스를 지급받지 않는 사원의 사번, 이름, 급여, 보너스를 조회
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , BONUS
  FROM EMPLOYEE
 WHERE BONUS IS NULL;
 
 -- NULL값 조회
-- 보너스를 지금받는 사원의 사번, 이름, 급여, 보너스를 조회
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , BONUS
  FROM EMPLOYEE
 WHERE BONUS IS NOT NULL;
 
-- 연결 연산자
-- 컬럼과 컬럼의 연결
SELECT
       EMP_NAME || SALARY || BONUS
  FROM EMPLOYEE;
  
-- 컬럼과 리터럴 연결
SELECT
       EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.'
  FROM EMPLOYEE;
  
-- 부서코드가 D9가 아닌 사원의 사번, 이름, 부서코드 조회
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
  FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D9';
-- WHERE DEPT_CODE ^= 'D9';
 WHERE DEPT_CODE <> 'D9';
 
-- 퇴사 여부가 N인 직원을 조회하고 근무 여부라는 별칭으로 재직중이라는 문자열을
-- 결과 집합에 포함해서 조회한다. (사번, 이름, 입사일, 근무여부 조회)
SELECT
       EMP_ID
     , EMP_NAME
     , HIRE_DATE
     , '재직중' 근무여부
  FROM EMPLOYEE
 WHERE ENT_YN = 'N';
 
-- 급여를 350만원 이상, 550만원 이하 받는 직원의
-- 이름, 부서코드, 급여 조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY >= 3500000
   AND SALARY <= 5500000;
   
-- BETWEEN AND
-- 월급을 350만원 이상 550만원 이하로 받는 직원들의 이름, 부서코드, 월급 조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY BETWEEN 3500000 AND 5500000;
 
 -- 위의 문항과 반대로
 -- 월급을 350만원 미만 550만원 초과로 받는 직원들의 이름, 부서코드, 월급 조회
 -- NOT 연산자는 컬럼명 앞, 또는 BETWEEN 연산자 앞에 붙을 수 있다.
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE NOT SALARY BETWEEN 3500000 AND 5500000;
 
-- LIKE 연산자
-- 성이 김씨인 직원의 이름, 입사일 조회
SELECT
       EMP_NAME
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '김%';
 
-- 성이 김씨가 아닌 직원의 이름, 입사일 조회
SELECT
       EMP_NAME
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE NOT EMP_NAME LIKE '김%';
 
-- 하 가 이름에 포함 된 직원의 이름, 부서코드 조회
SELECT
       EMP_NAME
     , DEPT_CODE
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '%하%';
 
-- 전화번호 국번이 9로 시작하는 직원의 이름, 전화번호 조회
SELECT
       EMP_NAME
     , PHONE
  FROM EMPLOYEE
 WHERE PHONE LIKE '___9%';
 
-- 전화번호 국번이 4자리이면서 9로 시작하는 직원의 이름, 전화번호 조회
SELECT
       EMP_NAME
     , PHONE
  FROM EMPLOYEE
 WHERE PHONE LIKE '___9_______%';
 
-- 이메일에서 _ 앞 글자가 3자리인 이메일 주소를 가진 사원의 이름, 이메일 주소 조회
SELECT
       EMP_NAME
     , EMAIL
  FROM EMPLOYEE
 WHERE EMAIL LIKE '___#_%' ESCAPE '#';
 
-- IN 연산자 
-- 부서 코드가 D6이거나 D8인 직원의 이름, 부서, 급여 조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE IN ('D6', 'D8');
 
-- 부서 코드가 D6이거나 D8인 직원을 제외한 이름, 부서, 급여 조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE NOT IN ('D6', 'D8')
-- NOT IN 처리 하더라도 NULL 값은 취급 되지 않으므로 필요하다면 별도 조건 추가
    OR DEPT_CODE IS NULL;
    
-- 연산자 우선 순위
-- AND가 OR보다 우선순위가 높다!!!
    
-- J2 직급의 급여 200만원 이상 받는 직원이거나
-- J7 직급인 직원의 이름, 급여, 직급 코드 조회
SELECT
       EMP_NAME
     , SALARY
     , JOB_CODE
  FROM EMPLOYEE
 WHERE JOB_CODE = 'J7'
   OR JOB_CODE = 'J2'
  AND SALARY >= 2000000;
  
-- J7 직급이거나 J2 직급인 직원들 중
-- 급여가 200만원 이상인 직원의 이름, 급여, 직급 코드 조회
SELECT
       EMP_NAME
     , SALARY
     , JOB_CODE
  FROM EMPLOYEE
 WHERE (JOB_CODE = 'J7'
    OR JOB_CODE = 'J2')
   AND SALARY >= 2000000;
 



