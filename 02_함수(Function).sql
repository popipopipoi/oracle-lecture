-- 2. 함수(Function)

-- 그룹 함수 
-- SUM : 합계를 구하여 리턴
SELECT
       SUM(SALARY)
  FROM EMPLOYEE;
  
-- AVG : 평균을 구하여 리턴
SELECT
       AVG(SALARY)
  FROM EMPLOYEE;
  
-- MAX : 컬럼에서 가장 큰 값 리턴. 취급 하는 자료형은 ANY TYPE
SELECT
       MAX(EMAIL)
     , MAX(HIRE_DATE)
     , MAX(SALARY)
  FROM EMPLOYEE;
  
-- MIN : 컬럼에서 가장 작은 값 리턴. 취급 하는 자료형은 ANY TYPE
SELECT
       MIN(EMAIL)
     , MIN(HIRE_DATE)
     , MIN(SALARY)
  FROM EMPLOYEE;
  
-- COUNT : 행의 갯수를 헤아려서 리턴
SELECT
       COUNT(*)  --모든(NULL포함)
     , COUNT(DEPT_CODE) -- NULL을 제외한 실제 값
     , COUNT(DISTINCT DEPT_CODE) -- 중복제거
  FROM EMPLOYEE;
  
-- 단일행 함수

-- 문자 처리 함수

-- LENGTH, LENGTHB
SELECT
       LENGTH('오라클')
     , LENGTHB('오라클')
  FROM DUAL;
  
SELECT
       LENGTH(EMAIL)
     , LENGTHB(EMAIL)
  FROM EMPLOYEE;
  
-- INSTR
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- 뒤에서부터 찾는다
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 두번째 B를 찾으라는 뜻
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;

SELECT
       EMAIL
     , INSTR(EMAIL, '@', -1) 위치
  FROM EMPLOYEE;
  
-- LAPD / RPAD
SELECT LPAD(EMAIL, 20, '#') FROM EMPLOYEE; --아무것도 없으면 빈공간으로 채워준다.
SELECT RPAD(EMAIL, 20, '#') FROM EMPLOYEE;
SELECT LPAD(EMAIL, 10) FROM EMPLOYEE;
SELECT RPAD(EMAIL, 10) FROM EMPLOYEE;

-- LTRIM / RTRIM / TRIM
SELECT LTRIM(' OHGIRAFFERS') FROM DUAL;
SELECT LTRIM(' OHGIRAFFERS', ' ') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123123OHGIRAFFERS', '123') FROM DUAL;
SELECT LTRIM('132123OHGIRAFFERS123', '123') FROM DUAL;
SELECT LTRIM('ACABACOHGIRAFFERS', 'ABC') FROM DUAL;
SELECT LTRIM('5782OHGIRAFFERS', '0123456789') FROM DUAL;

SELECT RTRIM('OHGIRAFFERS ') FROM DUAL;
SELECT RTRIM('OHGIRAFFERS ', ' ') FROM DUAL;
SELECT RTRIM('123456000', '0') FROM DUAL;
SELECT RTRIM('OHGIRAFFERS123123', '123') FROM DUAL;
SELECT RTRIM('123123OHGIRAFFERS123', '123') FROM DUAL;
SELECT RTRIM('OHGIRAFFERSACABAC', 'ABC') FROM DUAL;
SELECT RTRIM('OHGIRAFFERS5782', '0123456789') FROM DUAL;

SELECT TRIM(' OHGIRAFFERS ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZOHGIRAFFERSZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZOHGIRAFFERSZZZ') FROM DUAL; -- 왼쪽에서부터
SELECT TRIM(TRAILING 'Z' FROM 'ZZZOHGIRAFFERSZZZ') FROM DUAL; -- 오른쪽에서부터
SELECT TRIM(BOTH 'Z' FROM 'ZZZOHGIRAFFERSZZZ') FROM DUAL; -- 양쪽다

-- SUBSTR
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('쇼우 미 더 머니', 2, 5) FROM DUAL;

SELECT
       SUBSTR('ORACLE', 3, 2)
     , SUBSTRB('ORACLE', 3, 2)
  FROM DUAL;
SELECT
       SUBSTR('오라클', 2, 2)
     , SUBSTRB('오라클', 4, 6)
  FROM DUAL;
  
-- 직원들의 주민 번호를 조회하여 사원명, 생년, 생월, 생일을 각각 분리하여 조회(컬럼 별칭 사용)
SELECT
       EMP_NAME 사원명
     , SUBSTR(EMP_NO, 1, 2) 생년
     , SUBSTR(EMP_NO, 3, 2) 생월
     , SUBSTR(EMP_NO, 5, 2) 생일
  FROM EMPLOYEE;
  
-- 날짜 데이터에도 SUBSTR 사용 가능
-- 입사일에서 입사년도, 입사월, 입사 날짜 각각 분리하여 조회(컬럼 별칭 사용)
SELECT
       HIRE_DATE
     , SUBSTR(HIRE_DATE, 1, 2) 입사년도
     , SUBSTR(HIRE_DATE, 4, 2) 입사월
     , SUBSTR(HIRE_DATE, 7, 2) 입사일
  FROM EMPLOYEE;

-- WHERE절에도 함수를 사용할 수 있다.
-- EMP_NO를 통해 성별을 판단하여 여성 직원의 모든 컬럼 정보 조회
SELECT
       *
  FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO, 8, 1) = '2';
 
-- WHERE절에는 단일행 함수만 사용 가능
SELECT
       *
  FROM EMPLOYEE
 WHERE AVG(SALARY) > 100;
 
-- 함수 중첩 사용 가능
-- 사원명과 주민번호를 조회한다. 주민번호는 생년원일 이후 '-' 다음의 값은 '*'로 바꿔 출력한다.
SELECT
       EMP_NAME
     , RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*')
  FROM EMPLOYEE;
  
-- 사원명과 이메일을 조회한다. 이메일은 @ 이후를 제거한 아이디만 조회한다.
SELECT
       EMP_NAME
     , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
  FROM EMPLOYEE;
  
-- LOWER / UPPER / INITCAP
SELECT LOWER('Welcome To My World') FROM DUAL;
SELECT UPPER('Welcome To My World') FROM DUAL;
SELECT INITCAP('welcome to my world') FROM DUAL; --하나의 문자에서 앞글자를 대문자로 변경

-- CONCAT
SELECT CONCAT('가나다라', 'ABCD') FROM DUAL;

-- REPLACE
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;
       
-- 숫자 처리 함수

-- ABS 절대값
SELECT ABS(10), ABS(-10) FROM DUAL;

-- MOD
SELECT MOD(10, 5), MOD(10, 3) FROM DUAL;

-- ROUND : 반올림
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL; -- 소수점 하나를 남기라는 뜻
SELECT ROUND(123.456, 2) FROM DUAL; -- 소수점 두개를 남기라는 뜻
SELECT ROUND(123.456, -2) FROM DUAL; -- 10의 자리까지 정리

-- FLOOR : 내림 , 무조건 정수 반환
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC : 내림(자리수 설정)
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.678, 1) FROM DUAL;
SELECT TRUNC(123.678, 2) FROM DUAL;
SELECT TRUNC(123.678, -1) FROM DUAL;

-- CEIL : 올림 ,  정수만 반환
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

-- 날짜 처리 함수

-- SYSDATE
SELECT SYSDATE FROM DUAL;

--MONTHS_BETWEEN : 두 날짜의 개월수 차이 숫자로 리턴
SELECT
       EMP_NAME
     , HIRE_DATE
     , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
  FROM EMPLOYEE;
  
-- ADD_MONTHS : 날짜에 숫자만큼 개월 수를 더해서 날짜로 리턴
SELECT
       ADD_MONTHS(SYSDATE, 5)
  FROM DUAL;
  
-- 근무년수가 20년 이상인 직원들의 모든 컬럼 조회
SELECT
       *
  FROM EMPLOYEE
 WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;
-- WHERE ADD_MINTHS(HIRE_DATE, 240) <= SYSDATE;

-- NEXT_DAY : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜 리턴
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;
-- 시스템 환경에 따른 언어 설정을 변경
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY : 해당 월의 마지막 날짜를 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- 사원명, 입사일, 입사달의 근무일수(주말 포함)
SELECT
       EMP_NAME
     , HIRE_DATE
     , LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 "입사달 근무일수"
  FROM EMPLOYEE;
  
-- EXTRACT : 년, 월, 일 정보를 추출하여 리턴
SELECT
       EXTRACT(YEAR FROM SYSDATE) 년도
     , EXTRACT(MONTH FROM SYSDATE) 월
     , EXTRACT(DAY FROM SYSDATE) 일
  FROM DUAL;
  
-- 직원의 이름, 입사일, 근무년수 조회
SELECT
       EMP_NAME
     , HIRE_DATE
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
  FROM EMPLOYEE;
  
-- 근무년수를 만으로 계산하는 경우에는 월의 차이를 계산해야 한다.
SELECT
       EMP_NAME
     , HIRE_DATE
     , FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) "만 근무년수"
  FROM EMPLOYEE;

-- 형변환 함수

-- TO_CHAR : 날짜 혹은 숫자 데이터를 문자형 데이터로 변환하여 리턴
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL; /대상하는 숫자가 총 5자리(9갯수)맞춰서 포맷
SELECT TO_CHAR(1234, '00000') FROM DUAL;
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; /원화가 붙는 앞에 공백을 제거할려면 FM붙인다.
SELECT TO_CHAR(1234, '$99999') FROM DUAL; / 달러
SELECT TO_CHAR(1234, '00,000') FROM DUAL;
SELECT TO_CHAR(1234, '999') FROM DUAL; /실제 값보다 작게 붙어 있으면 결과가 안나옴

-- 직원 테이블에서 사원명, 급여 조회
-- 급여는 '\9,000,000' 형식으로 표시하세요
SELECT
       EMP_NAME
     , TO_CHAR(SALARY, 'L99,999,999')
  FROM EMPLOYEE;
  
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-fmMM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '분기' FROM DUAL;

SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') 입사일
  FROM EMPLOYEE;
SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') 입사일 --
  FROM EMPLOYEE;
SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY/MM/DD HH24:MI:SS') 상세입사일
  FROM EMPLOYEE;
  
-- RR과 YY의 차이
-- RR은 두자리 년도를 네자리로 바꿀 때 바꿀 년도가 50년 미만이면 2000년을 적용하고
-- 50년 이상이면 1900년을 적용한다.
-- YY는 년도를 바꿀 때 현재 세기(2000년)를 적용한다.
SELECT
       TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYY-MM-DD')
  FROM DUAL;
SELECT
       TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYY-MM-DD')
  FROM DUAL;
  
-- 오늘 날짜에서 월만 출력
SELECT
       TO_CHAR(SYSDATE, 'MM')
     , TO_CHAR(SYSDATE, 'MONTH')
     , TO_CHAR(SYSDATE, 'MON')
     , TO_CHAR(SYSDATE, 'RM')
  FROM DUAL;
 
-- 오늘 날짜에서 일만 출력
SELECT
       TO_CHAR(SYSDATE, '"1년 기준 " DDD"일 째"')
     , TO_CHAR(SYSDATE, '"달 기준 " DD"일 째"')
     , TO_CHAR(SYSDATE, '"주 기준 " D"일 째"')
  FROM DUAL;
  
-- 오늘 날짜에서 분기와 요일 출력 처리
SELECT
       TO_CHAR(SYSDATE, 'Q"분기"')
     , TO_CHAR(SYSDATE, 'DAY')
     , TO_CHAR(SYSDATE, 'DY')
  FROM DUAL;
  
-- 이름과 입사일 조회
-- 입사일 포맷은 '2018년 6월 15일 (수)' 형식으로 출력
SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY"년" fmMM"월" DD"일" (DY)')
  FROM EMPLOYEE;
  
-- TO_DATE
SELECT
       TO_DATE('20100101', 'RRRRMMDD')
  FROM DUAL;
SELECT
       TO_CHAR(TO_DATE('20100101', 'RRRRMMDD'), 'RRRR, MON')
  FROM DUAL;
SELECT
       TO_DATE('041030 143000', 'RRMMDD HH24MISS')
  FROM DUAL;
SELECT
       TO_CHAR(TO_DATE('041030 143000', 'RRMMDD HH24MISS'), 'DD-MON-RRRR HH:MI:SS PM')
  FROM DUAL;
  
-- 2000년도 이후 입사한 사원의 사번, 이름, 입사일 조회
SELECT
       EMP_NO
     , EMP_NAME
     , HIRE_DATE
  FROM EMPLOYEE
-- WHERE HIRE_DATE >= TO_DATE('20000101', 'RRRRMMDD');
-- WHERE HIRE_DATE >='200000101';
 WHERE HIRE_DATE >= TO_DATE(20000101, 'RRRRMMDD');
-- WHERE HIRE_DATE >=20000101; --불가능하다

--TO_NUMBER
SELECT '123' + '456' FROM DUAL;
SELECT '123' + '456A' FROM DUAL;

-- 사번이 홀수인 직원들의 정보 조회
SELECT
       *
  FROM EMPLOYEE
 WHERE MOD(EMP_ID, 2) = 1;
 
SELECT 
       TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('500,000', '999,999')
  FROM DUAL;
  
-- NULL 처리 함수

-- NVL(컬럼명, NULL일 때 바꿀 값)
SELECT
       EMP_NAME
     , BONUS
     , NVL(BONUS, 0)
  FROM EMPLOYEE;
  
-- MVL2(컬럼명, 값이 있을 경우의 대체값, NULL일 경우의 대체값)
-- 보너스가 NULL인 직원은 0.5로NULL이 아닌 직원은 0.7로 변경하여 조회
SELECT
       EMP_NAME
     , BONUS
     , NVL2(BONUS, 0.7, 0.5)
  FROM EMPLOYEE;
  
-- 선택 함수

-- DECODE(컬럼명, 조건값1, 선택값1, 조건값2, 선택값2, ...)

-- 성별을 구분하여 '남' 또는 '여'로 조회
SELECT
       EMP_NAME
     , EMP_NO
     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여')
  FROM EMPLOYEE;
  
-- 마지막 인자로 조건 값 없이 선택 값을 작성하면 아무런 조건에 해당하지 않을 때
-- 마지막 선택 값을 무조건 선택함
SELECT
       EMP_NAME
     , EMP_NO
     , DECODE(SUBSTR(EMP_NO,8,1),'1', '남', '여')
  FROM EMPLOYEE;
  
-- 직원 급여 인상
-- 직급 코드 J7 => 10%, J6 => 15%, J5 =>20% 그외 => 5%
SELECT
       EMP_NAME
     , JOB_CODE
     , SALARY
     , DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                        SALARY * 1.05) 인상급여
  FROM EMPLOYEE;
  
-- CASE
/*
CASE
    WHEN 조건식 THEN 결과값
    WHEN 조건식 THEN 결과값
    ELSE 결과값
  END
*/ -- DECODE는 조건값. 값이 일치하는지만 확인 CASE는 조건식.

--급여가 500만원을 초가하면 고급, 300~500 사이면 중급, 그 이하는 초급으로 조회
SELECT
       EMP_NAME
     , SALARY
     , CASE
         WHEN SALARY > 5000000 THEN '고급'
         WHEN SALARY BETWEEN 3000000 AND 5000000 THEN '중급'
         ELSE '초급'
       END 구분
  FROM EMPLOYEE;
       















