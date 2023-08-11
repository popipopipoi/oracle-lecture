-- 04. JOIN

-- 오라클 전용 구문

-- 연결에 사용할 두 컬럼명이 다른 경우
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , DEPT_TITLE
  FROM EMPLOYEE
     , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; --DEPT_CODE에 NULL은 포함하지 않았다.

-- 연결에 사용할 두 컬럼명이 같은 경우
-- 테이블명을 지정하지 않으면 열의 정의가 애매하다는 오류가 발생한다!
SELECT
       EMPLOYEE.EMP_ID
     , EMPLOYEE.EMP_NAME
     , EMPLOYEE.JOB_CODE
     , JOB.JOB_NAME
  FROM EMPLOYEE
     , JOB
 WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
 
 -- 테이블명에 별칭을 사용할 수 있다.
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.JOB_CODE
     , J.JOB_NAME
  FROM EMPLOYEE E
     , JOB J
 WHERE E.JOB_CODE = J.JOB_CODE; 

-- ANSI 표준 구문

-- 연결에 사용할 두 컬럼명이 같은 경우
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE);
  
-- 연결에 사용할 두 컬럼명이 다른 경우
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , DEPT_TITLE
  FROM EMPLOYEE
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
  
-- 컬럼명이 같은 경우에도 ON으로 작성할 수 있다.
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.JOB_CODE
     , J.JOB_NAME
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

-- DEPARTMENT 테이블과 LOCATION 테이블을 조인하여 모든 컬럼 조회
-- ORACLE 전용
SELECT
       *
  FROM DEPARTMENT
     , LACATION
WHERE LOCATION_ID = LOCAL_CODE;

-- ANSI 표준
SELECT
       *
  FROM DEPARTMENT 
  JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);
  
-- 조인은 기본적으로 일치하는 행만 결과에 포함하는 INNER JOIN으로 실행된다.
-- 일치하는 값이 없어도 결과에 포함시키고 싶을 경우 OUTER JOIN을 명시적으로 해야 한다.

-- LEFT OUTER JOIN
-- ANSI 표준
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
  LEFT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ORACLE 전용
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
     , DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID(+);
 
-- RIGHT OUTER JOIN
-- ANSI 표준
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
  RIGHT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ORACLE 전용
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
     , DEPARTMENT
 WHERE DEPT_CODE(+) = DEPT_ID;
 
-- FULL OUTER JOIN
-- ANSI 표준
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
  FULL /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ORACLE 전용
-- FULL OUTER JOIN을 하지 못한다.
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
     , DEPARTMENT
 WHERE DEPT_CODE(+) = DEPT_ID(+);
 
-- CROSS JOIN
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
 CROSS JOIN DEPARTMENT;
 
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
     , DEPARTMENT;
     
-- NON EQUAL JOIN
-- 등호 이외의 비교연산자를 사용하여 조인하는 것

-- ANSI 표준
SELECT
       EMP_NAME
     , SALARY
     , E.SAL_LEVEL "EMPLOYEE의 SAL_LEVEL"
     , S.SAL_LEVEL "SAL_GRADE의 SAL_LEVEL"
  FROM EMPLOYEE E
  JOIN SAL_GRADE S ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);
  
-- ORACLE 전용
SELECT
       EMP_NAME
     , SALARY
     , E.SAL_LEVEL "EMPLOYEE의 SAL_LEVEL"
     , S.SAL_LEVEL "SAL_GRADE의 SAL_LEVEL"
  FROM EMPLOYEE E
     , SAL_GRADE S 
 WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;
 
-- SELF JOIN
-- ANSI 표준
SELECT
       E1.EMP_ID 사번
     , E1.EMP_NAME 직원명
     , E1.MANAGER_ID 관리자사번
     , E2.EMP_NAME 관리자명
  FROM EMPLOYEE E1
  JOIN EMPLOYEE E2 ON(E1.MANAGER_ID = E2.EMP_ID);
  
-- ORACLE 전용
SELECT
       E1.EMP_ID 사번
     , E1.EMP_NAME 직원명
     , E1.MANAGER_ID 관리자사번
     , E2.EMP_NAME 관리자명
  FROM EMPLOYEE E1
     , EMPLOYEE E2 
 WHERE E1.MANAGER_ID = E2.EMP_ID;
 
-- 다중 JOIN : 두 개 이상의 테이블 JOIN
-- ANSI
-- 조인 구문 나열 순서에 유의해야 한다!
SELECT
       EMP_NAME
     , DEPT_TITLE
     , LOCAL_NAME
  FROM EMPLOYEE
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);
  
-- ORACLE 전용
-- 테이블명의 서술 순서는 관계 없음!
SELECT
       EMP_NAME
     , DEPT_TITLE
     , LOCAL_NAME
  FROM EMPLOYEE
     , DEPARTMENT
     , LOCATION
 WHERE DEPT_CODE = DEPT_ID
   AND LOCATION_ID = LOCAL_CODE;
   
--직급이 대리이면서 아시아 지역에 근무하는 직원의
-- 이름, 직급명, 부서명, 근무지역명 조회

-- ANSI 표준
SELECT
       EMP_NAME
     , JOB_NAME
     , DEPT_TITLE
     , LOCAL_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
 WHERE JOB_NAME = '대리'
   AND LOCAL_NAME LIKE 'ASIA%';
   
-- ORACLE 전용
SELECT
       E.EMP_NAME
     , J.JOB_NAME
     , D.DEPT_TITLE
     , L.LOCAL_NAME
  FROM EMPLOYEE E
     , JOB J
     , DEPARTMENT D
     , LOCATION L
 WHERE E.JOB_CODE = J.JOB_CODE
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND JOB_NAME = '대리'
   AND LOCAL_NAME LIKE 'ASIA%';
   

 



 
