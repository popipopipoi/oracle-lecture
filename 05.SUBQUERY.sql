-- 05.SUBQUERY

-- 서브쿼리가 필요한 예

-- 노옹철 사원과 같은 부서에 소속 된 사원 조회

-- 사원명이 노옹철인 사람의 부서 조회
SELECT
       DEPT_CODE
  FROM EMPLOYEE
 WHERE EMP_NAME = '노옹철';
 
-- 부서코드가 D9인 직원 조회
SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9';
 
-- 위의 두 쿼리를 하나로 작성한다.
SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = (SELECT
                           DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '노옹철');
                     
-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급 코드, 급여 조회
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);
 
-- SUBQUERY의 유형
-- 단일행 서브쿼리 : 결과 행이 1행인 서브쿼리로 일반 비교 연산자 사용

-- 노옹철 사원의 급여보다 많이 받는 직원의 사번, 이름, 부서, 직급, 급여 조회
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > (SELECT SALARY
                   FROM EMPLOYEE
                  WHERE EMP_NAME = '노옹철');
                  
-- 가장 적은 급여를 받는 직원의 사번, 이름, 급여 조회
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE); 
 
-- WHERE절 뿐만 아니라 HAVING절에도 사용 가능하다.
-- 부서별 급여의 합계 중 합계가 가장 큰 부서의 부서명, 급여 합계 조회
SELECT
       DEPT_TITLE
     , SUM(SALARY)
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (SELECT
                             MAX(SUM(SALARY))
                        FROM EMPLOYEE
                       GROUP BY DEPT_CODE);
                       
-- 다중행 서브쿼리 : 결과 행이 여러 개인 서브쿼리, 일반 비교 연산자를 사용할 수 없다. 

-- 부서별 최고 급여와 동일 급여를 받는 직원의 이름, 부서, 급여조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY IN (SELECT MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE);
 
-- 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원 조회
-- > ANY / < ANY : 다중행 서브쿼리를 비교할 때 사용하는 연산자
-- > ANY : 서브 쿼리 결과의 최소 값보다 큰 값을 비교
-- < ANY : 서브 쿼리 결과의 최대 값보다 작은 값을 비교
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_NAME
     , SALARY
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE JOB_NAME = '대리'
   AND SALARY > ANY (SELECT
                        SALARY
                   FROM EMPLOYEE
                   JOIN JOB USING(JOB_CODE)
                  WHERE JOB_NAME = '과장');
                  
-- 차장 직급의 급여의 가장 큰 값보다 많이 받는 과장 직급의 사원 조회
-- > ALL : 서브쿼리의 결과 중 최대 값보다 큰 값 비교
-- < ALL : 서비쿼리의 결과 중 최소 값보다 작은 값 비교
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_NAME
     , SALARY
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE JOB_NAME = '과장'
   AND SALARY > ALL (SELECT
                        SALARY
                   FROM EMPLOYEE
                   JOIN JOB USING(JOB_CODE)
                  WHERE JOB_NAME = '차장');
                  
-- 다중열 서브쿼리 : 결과 열이 다중열인 서브쿼리
-- 퇴직한 여사원과 같은 부서, 같은 직급에 해당하는 사원 조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , JOB_CODE
  FROM EMPLOYEE
 WHERE DEPT_CODE = (SELECT DEPT_CODE  -- 부서확인
                      FROM EMPLOYEE
                     WHERE SUBSTR(EMP_NO, 8, 1) = '2'
                       AND ENT_YN = 'Y'
                    )
   AND JOB_CODE = (SELECT  JOB_CODE -- 직급확인
                      FROM EMPLOYEE
                     WHERE SUBSTR(EMP_NO, 8, 1) = '2'
                       AND ENT_YN = 'Y'
                    );
                    
-- 다중열 서브쿼리로 변경한다.
SELECT
       EMP_NAME
     , DEPT_CODE
     , JOB_CODE
  FROM EMPLOYEE
 WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE  
                                  FROM EMPLOYEE
                                 WHERE SUBSTR(EMP_NO, 8, 1) = '2'
                                   AND ENT_YN = 'Y'
                                );
                                
-- 인라인 뷰(Inline View) : FROM 절에서 사용 되는 서브 쿼리
-- 직급별 평균 급여를 계산한 테이블을 만들고 EMPLOYEE와 JOIN시
-- 평균 급여가 본인의 급여와 동일하면 조인하게 조건을 줘서
-- 직급별 평균 급여에 맞는 급여를 받고 있는 직원을 조회하는 구문
SELECT
       E.EMP_NAME
     , J.JOB_NAME
     , E.SALARY
  FROM (SELECT
               JOB_CODE
             , TRUNC(AVG(SALARY), -5) AS JOBAVG
          FROM EMPLOYEE
         GROUP BY JOB_CODE) V
    JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY AND V.JOB_CODE = E.JOB_CODE)
    JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
   ORDER BY J.JOB_NAME;
   
-- 인라인 뷰 사용 시 유의할 점
-- 인라인 뷰의 결과만이 남아있으므로 서브 쿼리에서 조회에 사용하지 않은 컬럼은 조회 불가
-- 별칭을 사용했다면 별칭만을 사용할 수 있음!
SELECT
       EMP_NAME
     , 부서명
     , 직급명
   --, SALARY
  FROM (SELECT
               EMP_NAME
             , DEPT_TITLE 부서명
             , JOB_NAME 직급명
          FROM EMPLOYEE
          LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
          JOIN JOB USING(JOB_CODE))
 WHERE 부서명 = '인사관리부';

-- 인라인 뷰를 사용한 TOP-N 분석

-- ROWNUM 확인
-- SALARY 기준 내림차순 정렬
-- 현재는 WHERE절에서 ROWNUM이 결정되어 급여를 많이 받는 순과 관계 없는 번호를 가진다.
SELECT
       ROWNUM
     , EMP_NAME
     , SALARY
  FROM EMPLOYEE
 ORDER BY SALARY DESC;

-- 따라서 원하는 순서의 ROWNUM이 붙게 하려면 인라인 뷰를 활용해야 한다.
SELECT
       ROWNUM
     , V.EMP_NAME
     , V.SALARY
  FROM (SELECT E.*
          FROM EMPLOYEE E
         ORDER BY E.SALARY DESC
        ) V
 WHERE ROWNUM <= 5;
 
-- 6위에서 10위까지 조회
-- WHERE절에서 ROWNUM은 1이 부여 되고 해당 값이 조건 상 FALSE가 되어 다음 행에 다시
-- ROWNUM이 1이 부여가 되므로 모든 행은 6~10 사이라는 조건을 만족할 수 없어 결과가 0행이 된다.
SELECT
       ROWNUM
     , V.EMP_NAME
     , V.SALARY
  FROM (SELECT E.*
          FROM EMPLOYEE E
         ORDER BY E.SALARY DESC
        ) V
 WHERE ROWNUM BETWEEN 6 AND 10;
 
 -- 6위에서 10위까지 조회 수정 구문
 SELECT
       V2.RNUM
     , V2.EMP_NAME
     , V2.SALARY
  FROM (SELECT
               ROWNUM RNUM
             , V.EMP_NAME
             , V.SALARY
          FROM (SELECT E.*
                  FROM EMPLOYEE E
                 ORDER BY E.SALARY DESC
                ) V
    ) V2
 WHERE RNUM BETWEEN 6 AND 10;
-- STOP KEY 사용
 SELECT
       V2.RNUM
     , V2.EMP_NAME
     , V2.SALARY
  FROM (SELECT
               ROWNUM RNUM
             , V.EMP_NAME
             , V.SALARY
          FROM (SELECT E.*
                  FROM EMPLOYEE E
                 ORDER BY E.SALARY DESC
                ) V
         WHERE ROWNUM < 11   --STOP KEY
    ) V2
 WHERE RNUM BETWEEN 6 AND 10;
 
-- 급여 평균 3위 안에 드는 부서의 부서코드, 부서명, 평균 급여 조회
SELECT
       ROWNUM
     , V.DEPT_CODE
     , V.DEPT_TITLE
     , V.평균급여
  FROM (SELECT
               E.DEPT_CODE
             , D.DEPT_TITLE
             , AVG(E.SALARY) 평균급여
          FROM EMPLOYEE E
          JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
         GROUP BY E.DEPT_CODE, D.DEPT_TITLE
         ORDER BY 3 DESC
        ) V
 WHERE ROWNUM <= 3;
 
-- RANK() OVER : 동일한 순위 이후의 등수를 인원수만큼 건너뛰고 다음 순위를 계산
-- DENSE_RANK() OVER : 동일한 순위 이후의 등수를 다음 등수로 계산
SELECT
       EMP_NAME
     , SALARY
     , RANK() OVER(ORDER BY SALARY DESC) 순위
  FROM EMPLOYEE;
  
SELECT
       EMP_NAME
     , SALARY
     , DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
  FROM EMPLOYEE;
  
-- SALARY 기준 5위까지 조회
SELECT
       V.*
  FROM (SELECT
                EMP_NAME
              , SALARY
              , RANK() OVER(ORDER BY SALARY DESC) 순위
           FROM EMPLOYEE) V
 WHERE V.순위 <= 5;
 
-- WITH
-- 서브쿼리에 이름을 붙여주고 재사용 할 수 있다.
WITH
       TOPN_SAL
    AS (SELECT
               EMP_ID
             , EMP_NAME
             , SALARY
          FROM EMPLOYEE
         ORDER BY SALARY DESC
        )
SELECT
       ROWNUM
     , T.EMP_NAME
     , T.SALARY
  FROM TOPN_SAL T;
  
-- 상관 서브커리
-- 관리자 사번이 EMPLOYEE 테이블에 존재하는 직원에 대한 조회
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , E.MANAGER_ID
  FROM EMPLOYEE E
 WHERE EXISTS (SELECT
                      E2.EMP_ID
                 FROM EMPLOYEE E2
                WHERE E.MANAGER_ID = E2.EMP_ID
);

-- 동일 직급의 급여 평균보다 급여를 많이 받고 있는 직원의 직원명, 직급코드, 급여 조회
SELECT
       EMP_NAME
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE E
 WHERE SALARY > (SELECT
                             TRUNC(AVG(E2.SALARY), -5)
                        FROM EMPLOYEE E2
                       WHERE E.JOB_CODE = E2.JOB_CODE
);

SELECT
       EMP_ID
     , EMP_NAME
     , MANAGER_ID
     , NVL((SELECT EMP_NAME
              FROM EMPLOYEE E2
             WHERE E.MANAGER_ID = E2.EMP_ID
            ), '없음') 관리자명
  FROM EMPLOYEE E
 ORDER BY 1;






