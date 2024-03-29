-- 1. 계열 정보를 저장한 카테고리 테이블을 만들려고 한다. 다음과 같은 테이블을
-- 작성하시오.
CREATE TABLE TB_CATEGORY (
   NAME VARCHAR2(10)
 , USE_YN CHAR(1)DEFAULT 'Y'
); 

-- 2.과목 구분을 저장할 테이블을 만들려고 한다. 다음과 같은 테이블을 작성하시오.
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY
  , NAME VARCHAR2(10)
);

-- 3. TB_CATAGORY 테이블의 NAME 컬럼에 PRIMARY KEY 를 생성하시오.
-- (KEY 이름을 생성하지 않아도 무방함. 만일 KEY 이를 지정하고자 한다면 이름은 본인이
-- 알아서 적당한 이름을 사용한다.)
ALTER TABLE TB_CATEGORY 
ADD CONSTRAINT PK_NAME PRIMARY KEY(NAME);

-- 4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오
ALTER TABLE TB_CLASS_TYPE
MODIFY NAME CONSTRAINT NN_NAME NOT NULL;

-- 5. 두 테이블에서 컬럼 명이 NO 인 것은 기존 타입을 유지하면서 크기는 10 으로, 컬럼명이
-- NAME 인 것은 마찬가지로 기존 타입을 유지하면서 크기 20 으로 변경하시오.
ALTER TABLE TB_CATEGORY
MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CLASS_TYPE
MODIFY NO VARCHAR2(10)
MODIFY NAME VARCHAR2(20);

-- 6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을 각 각 TB_ 를 제외한 테이블 이름이 앞에
-- 붙은 형태로 변경한다.
ALTER TABLE TB_CATEGORY
RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NO TO CLASS_TYPE_NO;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NAME TO CLASS_TYPE_NAME;

-- 7. TB_CATAGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이
-- 변경하시오.
-- Primary Key 의 이름은 ?PK_ + 컬럼이름?으로 지정하시오. (ex. PK_CATEGORY_NAME )
ALTER TABLE TB_CATEGORY
RENAME CONSTRAINT PK_NAME TO PK_CATEGORY_NAME; 

ALTER TABLE TB_CLASS_TYPE
RENAME CONSTRAINT SYS_C007503 TO PK_CLASS_TYPE_NEME;

-- 8. 다음과 같은 INSERT 문을 수행한다.
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT; 

-- 9.TB_DEPARTMENT 의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 부모
-- 값으로 참조하도록 FOREIGN KEY 를 지정하시오. 이 때 KEY 이름은
-- FK_테이블이름_컬럼이름으로 지정한다. (ex. FK_DEPARTMENT_CATEGORY )
ALTER TABLE TB_DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_CATEGORY
FOREIGN KEY (CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

-- 10.춘 기술대학교 학생들의 정보만이 포함되어 있는 학생일반정보 VIEW 를 만들고자 한다. 
-- 아래 내용을 참고하여 적절한 SQL 문을 작성하시오.
GRANT CREATE VIEW TO C##HOMEWORK;
CREATE OR REPLACE VIEW VW_학생일반정보
(
  학번
, 학생이름
, 주소
)
AS
SELECT
       STUDENT_NO
     , STUDENT_NAME
     , STUDENT_ADDRESS
  FROM TB_STUDENT;
  
-- 11. 춘 기술대학교는 1 년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행한다. 
-- 이를 위해 사용한 학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW 를 만드시오.
-- 이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오 (단, 이 VIEW 는 단순 SELECT 
-- 만을 한 경우 학과별로 정렬되어 화면에 보여지게 만드시오.)
CREATE OR REPLACE VIEW VW_지도면담
(
  학생이름
, 학과이름
, 지도교수이름
)
AS
SELECT
       S.STUDENT_NAME
     , D.DEPARTMENT_NAME
     , P.PROFESSOR_NAME
  FROM TB_STUDENT S
  LEFT JOIN TB_PROFESSOR P ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO)
  LEFT JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
  ORDER BY D.DEPARTMENT_NAME;
  
SELECT
       V.*
  FROM VW_지도면담 V;
  
CREATE OR REPLACE VIEW VW_지도면담
(
  학생이름
, 학과이름
, 지도교수이름
)
AS 
SELECT 
       S.STUDENT_NAME
     , D.DEPARTMENT_NAME
     , NVL(P.PROFESSOR_NAME, '지도교수 없음')
  FROM 
       TB_STUDENT S
     , TB_DEPARTMENT D
     , TB_PROFESSOR P
 WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
   AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+)
 ORDER BY 2;

       
-- 12. 모든 학과의 학과별 학생 수를 확인할 수 있도록 적절한 VIEW 를 작성해 보자.
CREATE OR REPLACE VIEW VW_학과별학생수
AS
SELECT
       D.DEPARTMENT_NAME "DEPARTMENT_NAME"
     , STUDENT_COUNT
  FROM (SELECT
            DEPARTMENT_NO
         , COUNT(*) "STUDENT_COUNT"
         FROM TB_STUDENT
         GROUP BY DEPARTMENT_NO) S
  JOIN TB_DEPARTMENT D ON(D.DEPARTMENT_NO = S.DEPARTMENT_NO);
  
CREATE OR REPLACE VIEW VW_학과별학생수
(
  DEPARTMENT_NAME
, STUDENT_COUNT
)
AS 
SELECT 
       D.DEPARTMENT_NAME
     , COUNT(*)
  FROM TB_DEPARTMENT D
     , TB_STUDENT S
 WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
 GROUP BY D.DEPARTMENT_NAME;
 
  
-- 13.위에서 생성한 학생일반정보 View 를 통해서 학번이 A213046 인 학생의 이름을 본인
-- 이름으로 변경하는 SQL 문을 작성하시오.
UPDATE
       VW_학생일반정보
   SET 학생이름 = '강인선'
 WHERE 학번 = 'A213046';

SELECT
    학생이름
 ,  학번
 FROM VW_학생일반정보
 WHERE 학번 = 'A213046';
 
-- 14. 13번에서와 같이 VIEW 를 통해서 데이터가 변경될 수 있는 상황을 막으려면 VIEW 를
-- 어떻게 생성해야 하는지 작성하시오.

-- WITH READ ONLY로 뷰생성

GRANT CREATE VIEW TO C##HOMEWORK;
CREATE OR REPLACE VIEW VW_학생일반정보
(
  학번
, 학생이름
, 주소
)
AS
SELECT
       STUDENT_NO
     , STUDENT_NAME
     , STUDENT_ADDRESS
  FROM TB_STUDENT
  WITH READ ONLY;







       

       




 
