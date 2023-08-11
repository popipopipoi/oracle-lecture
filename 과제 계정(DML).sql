-- 1. 과목유형 테이블(TB_CLASS_TYPE)에 아래와 같은 데이터를 입력하시오.
INSERT
  INTO TB_CLASS_TYPE
(
  class_type_no
, class_type_name
)
VALUES
(
  01
, '전공필수'
);
INSERT
  INTO TB_CLASS_TYPE
(
  class_type_no
, class_type_name
)
VALUES
(
  02
, '전공선택'
);
INSERT
  INTO TB_CLASS_TYPE
(
  class_type_no
, class_type_name
)
VALUES
(
  03
, '교양필수'
);
INSERT
  INTO TB_CLASS_TYPE
(
  class_type_no
, class_type_name
)
VALUES
(
  04
, '교양선택'
);
INSERT
  INTO TB_CLASS_TYPE
(
  class_type_no
, class_type_name
)
VALUES
(
  05
, '논문지도'
);

-- 2.  춘 기술대학교 학생들의 정보가 포함되어 있는 학생일반정보 테이블을 만들고자 한다. 
-- 아래 내용을 참고하여 적절한 SQL 문을 작성하시오. (서브쿼리를 이용하시오)
CREATE OR REPLACE VIEW TB_학생일반정보
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
  
-- 3. 국어국문학과 학생들의 정보만이 포함되어 있는 학과정보 테이블을 만들고자 한다. 
-- 아래 내용을 참고하여 적절한 SQL 문을 작성하시오. (힌트 : 방법은 다양함, 소신껏
-- 작성하시오)
CREATE OR REPLACE VIEW TB_국어국문학과
(
  학번
, 학생이름
, 출생년도
, 교수이름
)
AS
SELECT
       STUDENT_NO
     , STUDENT_NAME
     , STUDENT_SSN
     , PROFESSOR_NAME
  FROM (SELECT
                         STUDENT_SSN (EXTRACT(YEAR FROM (TO_DATE(SUBSTR(STUDENT_SSN, 1, 2), 'RR')))) 
                   FROM TB_STUDENT) V                        
  JOIN TB_PROFESSOR P ON(V.DEPARTMENT = P.DEPARTMENT);
  
-- 4. 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용할 SQL 문을 작성하시오. (단, 
--  반올림을 사용하여 소수점 자릿수는 생기지 않도록 한다)
CREATE SEQUENCE SEQ_DEPUP
START 



