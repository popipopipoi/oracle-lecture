-- 1. 4개 테이블에 포함된 데이터 건 수를 구하는 SQL 구문을 만드는 SQL 구문을 작성하시오
SELECT
       'SELECT COUNT(*) FROM '||TABLE_NAME||';'
    FROM USER_TABLES;

SELECT
    'TB_BOOK' AS 테이블,
    COUNT(*) AS "데이터 건 수"
FROM
    TB_BOOK
UNION ALL
SELECT
    'TB_BOOK_AUTHOR' AS 테이블,
    COUNT(*) AS "데이터 건 수"
FROM
    TB_BOOK_AUTHOR
UNION ALL
SELECT
    'TB_PUBLISHER' AS 테이블,
    COUNT(*) AS "데이터 건 수"
FROM
    TB_PUBLISHER
UNION ALL
SELECT
    'TB_WRITER' AS 테이블,
    COUNT(*) AS "데이터 건 수"
FROM
    TB_WRITER;
    
    select 
    (select count(*) from tb_book) as "도서관리테이블",
    (select count(*) from tb_book_author)as "저자관리테이블",
    (select count(*) from tb_publisher)as "출판사관리테이블",
    (select count(*) from tb_writer) as "작가관리테이블"
from dual;
    
-- 2. 4개 테이블의 구조를 파악하려고 한다. 제시된 결과처럼 TABLE_NAME, COLUMN_NAME, DATA_TYPE,
-- DATA_DEFAULT, NULLABLE, CONSTRAINT_NAME, CONSTRAINT_TYPE, R_CONSTRAINT_NAME 값을
-- 조회하는 SQL 구문을 작성하시오.
SELECT 
       UCT.TABLE_NAME
     , UCT.COLUMN_NAME
     , UCT.DATA_TYPE
     , UCT.DATA_DEFAULT
     , UCT.NULLABLE
     , UC.CONSTRAINT_NAME
     , UC.CONSTRAINT_TYPE
     , UC.R_CONSTRAINT_NAME
 FROM USER_TAB_COLUMNS UCT
 JOIN USER_CONSTRAINTS UC
   ON UCT.TABLE_NAME = UC.TABLE_NAME
  AND CONSTRAINT_NAME = (
  SELECT R_CONSTRAINT_NAME
  FROM USER_CONSTRAINTS
   WHERE ROWNUM = 1)
 ORDER BY 2;
 
 
SELECT * FROM USER_TAB_COLUMNS;
SELECT * FROM USER_CONSTRAINTS;
 
-- 3. 도서명이 25자 이상인 책 번호와 도서명을 화면에 출력하는 SQL 문을 작성하시오.
SELECT
       BOOK_NO
     , BOOK_NM
  FROM TB_BOOK
 WHERE LENGTH(BOOK_NM) >= 25;
 
-- 4. 휴대폰 번호가 ‘019’로 시작하는 김씨 성을 가진 작가를 이름순으로 정렬했을 때 가장 먼저 표시되는 작가
-- 이름과 사무실 전화번호, 집 전화번호, 휴대폰 전화번호를 표시하는 SQL 구문을 작성하시오.
SELECT
       WRITER_NM
     , OFFICE_TELNO
     , HOME_TELNO
     , MOBILE_NO
  FROM (SELECT
               WRITER_NM
             , OFFICE_TELNO
             , HOME_TELNO
             , MOBILE_NO
          FROM TB_WRITER
         WHERE MOBILE_NO LIKE '019%'
           AND WRITER_NM LIKE '김%'
         ORDER BY 1)
 WHERE ROWNUM = 1 ;
 
-- 5. 저작 형태가 “옮김”에 해당하는 작가들이 총 몇 명인지 계산하는 SQL 구문을 작성하시오. (결과 헤더는
-- “작가(명)”으로 표시되도록 할 것) 
SELECT
       COUNT(*) "작가(명)"
  FROM TB_BOOK_AUTHOR
 WHERE COMPOSE_TYPE = '옮김';
 
-- 6. 300권 이상 등록된 도서의 저작 형태 및 등록된 도서 수량을 표시하는 SQL 구문을 작성하시오.(저작
-- 형태가 등록되지 않은 경우는 제외할 것)
SELECT
       COMPOSE_TYPE
     , COUNT(*)
  FROM TB_BOOK_AUTHOR
  JOIN TB_BOOK USING(BOOK_NO)
  WHERE COMPOSE_TYPE IS NOT NULL
  GROUP BY COMPOSE_TYPE
  HAVING
    COUNT(*) >= 300;
    
-- 7. 가장 최근에 발간된 최신작 이름과 발행일자, 출판사 이름을 표시하는 SQL 구문을 작성하시오.
SELECT 
       
       BOOK_NM
     , ISSUE_DATE
     , PUBLISHER_NM
  FROM (SELECT
       BOOK_NM
     , ISSUE_DATE
     , PUBLISHER_NM
     FROM TB_BOOK
     ORDER BY ISSUE_DATE DESC)  
 WHERE ROWNUM = 1 ;
 
-- 8. 가장 많은 책을 쓴 작가 3명의 이름과 수량을 표시하되, 많이 쓴 순서대로 표시하는 SQL 구문을 작성하시오.
-- 단, 동명이인(同名異人) 작가는 없다고 가정한다. (결과 헤더는 “작가 이름”, “권 수”로 표시되도록 할
-- 것)
SELECT
       "작가 이름" 
     , "권 수"
  FROM (SELECT
               WRITER_NM "작가 이름"
             , COUNT(*) "권 수"
          FROM TB_WRITER 
          JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
        GROUP BY WRITER_NM
        ORDER BY COUNT(*) DESC
      ) 
      WHERE ROWNUM BETWEEN 1 AND 3;
      
-- 9. 작가 정보 테이블의 모든 등록일자 항목이 누락되어 있는 걸 발견하였다. 누락된 등록일자 값을 각 작가의
-- ‘최초 출판도서의 발행일과 동일한 날짜’로 변경시키는 SQL 구문을 작성하시오. (COMMIT 처리할 것)
COMMIT;
UPDATE TB_WRITER
   SET REGIST_DATE = NULL
   WHERE ISSUE_DATE =(SELECT
               WRITER_NM "작가 이름"
             , BOOK_NM
             , ISSUE_DATE
          FROM TB_WRITER W
         JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
         JOIN TB_BOOK B USING(BOOK_NO)
        ORDER BY ISSUE_DATE);

UPDATE TB_WRITER AS a
SET a.REGIST_DATE = p.
FROM (
  SELECT 작가ID, MIN(출판도서발행일) AS 최초출판도서발행일
  FROM 작가정보테이블
  GROUP BY 작가ID
) AS p
WHERE a.작가ID = p.작가ID;


--   SELECT
--     A.WRITER_NO
--    , A.WRITER_NM
--    ,MIN(B.ISSUE_DATE) " 최종 발행일"
-- FROM TB_WRITER A
-- JOIN TB_BOOK_AUTHOR BA ON A.WRITER_NO = BA.WRITER_NO


  



     
    
   
     

