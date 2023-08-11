--------------------------------------------------------------
-- 오지라퍼즈 계정 생성
CREATE USER C##OHGIRAFFERS IDENTIFIED BY OHGIRAFFERS;
GRANT RESOURCE, CONNECT TO C##OHGIRAFFERS;
ALTER USER C##OHGIRAFFERS QUOTA UNLIMITED ON USERS;

-----------------------------------------------------------------------------
----------콘솔 관리 프로그램 계정 생성
CREATE USER C##YUMMY IDENTIFIED BY YUMMY;
GRANT RESOURCE, CONNECT TO C##YUMMY;
ALTER USER C##YUMMY QUOTA UNLIMITED ON USERS;