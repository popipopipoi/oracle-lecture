-- 13. 권한과 ROLE

-- 1. 시스템 권한

-- <시스템 계정으로 실행>
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;

-- 생성한 계정으로 접속 시도 시 접속 권한(CREATE SESSION)이 없어서 접속 불가
-- <시스템 계정으로 실행>
GRANT CREATE SESSION TO C##SAMPLE;

-- <샘플 계정으로 실행>
CREATE TABLE TEST_TABLE(
  COL1 VARCHAR2(20),
  COL2 NUMBER
);

-- 테이블 생성 권한이 없어 생성 불가
-- <시스템 계정으로 실행>
GRANT CREATE TABLE TO C##SAMPLE;

-- WITH ADMIN OPTION : 사용자에게 시스템 권한을 부여할 때 사용하는 옵션
-- 권한을 부여받은 사용자는 다른 사용자에게 권한을 지정할 수 있다.

-- <시스템 계정으로 실행>
GRANT CREATE SESSION TO C##SAMPLE
WITH ADMIN OPTION;
-- <시스템 계정으로 실행>
CREATE USER C##SAMPLE2 IDENTIFIED BY SAMPLE2;

-- <샘플 계정으로 실행>
-- WITH ADMIN OPTION으로 부여받은 CREATE SESSION 권한은 다른 사용자에게 부여 가능하나
-- 그 외의 권한은 부여할 수 있는 권한이 없어 불가능하다.
GRANT CREATE SESSION TO C##SAMPLE2;
GRANT CREATE TABLE TO C##SAMPLE2;

-- 2. 객체 권한

-- WITH GRANT OPTION : 사용자가 특정 객체를 조작하거나 접근할 수 있는 권한을 부여 받으면서
-- 그 권한을 다른 사용자에게 다시 부여할 수 있는 권한 옵션

-- <시스템 계정으로 실행>
GRANT SELECT ON C##EMPLOYEE.EMPLOYEE TO C##SAMPLE
WITH GRANT OPTION;

-- <샘플 계정으로 실행>
-- 조회 권한을 부여 받았기 때문에 SAMPLE 계정을 통해 EMPLOYEE 테이블 조회가 가능하다.
-- 그 외의 DEPARTMENT 테이블 등은 SAMPLE 계정으로 조회 할 수 없다.
SELECT
       EE.*
  FROM C##EMPLOYEE.EMPLOYEE EE;
  
SELECT
       ED.*
  FROM C##EMPLOYEE.DEPARTMENT ED;
  
-- <샘플 계정으로 실행>
-- WITH GRANT OPTION으로 부여 받은 SELECT 권한은 다른 계정에게 부여 가능하나
-- 그 외의 INSERT와 같은 권한은 부여할 수 없다.
GRANT SELECT ON C##EMPLOYEE.EMPLOYEE TO C##SAMPLE2;
GRANT INSERT ON C##EMPLOYEE.EMPLOYEE TO C##SAMPLE2;

-- <시스템 계정으로 실행>
-- REVOKE : 권한 철회
REVOKE SELECT ON C##EMPLOYEE.EMPLOYEE FROM C##SAMPLE;

-- <샘플 계정으로 실행>
-- 조회 권한이 철회 되어 조회 불가능
SELECT
       EE.*
  FROM C##EMPLOYEE.EMPLOYEE EE;
  
-- 참고) WITH GRANT OPTION은 REVOKE시 다른 사용자에게 부여한 권한도 함께 회수한다.
-- WITH SAMIN OPTION은 특정 사용자의 권한만 회수 되고 나머지 사용자에게 부여한 권한은
-- 회수 되지 않는다.

-- ROLE : 여러 개의 권한을 묶어서 사용하는 것
-- 사용자에게 부여한 권한을 수정하고자 할 때도 그 롤만 수정하면 해당 롤의 권한을 부여 받은
-- 사용자들의 권한이 자동으로 수정 된다.

-- 1. 사전 정의 된 롤 : 오라클 설치 시 시스템에서 기본적으로 제공
SELECT
       GRANTEE
     , PRIVILEGE
  FROM DBA_SYS_PRIVS
 WHERE GRANTEE = 'RESOURCE'
    OR GRANTEE = 'CONNECT';
    
-- 2. 사용자가 정의하는 롤
CREATE ROLE C##MYROLE; -- 롤 이름을 지정해서 생성
GRANT CREATE VIEW, CREATE SEQUENCE TO C##MYROLE; -- 생성 된 롤에 원하는 권한들을 추가
GRANT C##MYROLE TO C##SAMPLE; --사용자에게 롤 부여

-- C##MYROLE의 권한 확인
SELECT
       GRANTEE
     , PRIVILEGE
  FROM DBA_SYS_PRIVS
 WHERE GRANTEE = 'C##MYROLE';
 
-- C##SAMPLE 계정의 롤 권한 확인
SELECT
       DRP.*
  FROM DBA_ROLE_PRIVS DRP
 WHERE GRANTEE = 'C##SAMPLE';
 
-- <샘플 계정으로 실행>
CREATE SEQUENCE SEQ_TEST;