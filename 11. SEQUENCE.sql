-- 11. SEQUENCE

CREATE SEQUENCE SEQ_EMPID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-- 시퀀스명.CURRVAL : CURRENT VALUE
-- 시퀀스명.NEXTVAL : NEXT VALUE
-- NEXTVAL을 1회 수행해야 CURRVAL를 알 수 있다.
SELECT SEQ_EMPID.CURRVAL FROM DUAL;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --300
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --300
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --305
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --310
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --310

-- MAXVALUE를 넘어서면 에러 발생
SELECT SEQ_EMPID.NEXTVAL FROM DUAL;

-- 데이터 딕셔너리 USER_SEQUENCES를 통한 조회
SELECT * FROM USER_SEQUENCES;

-- 시퀀스 변경
-- START WITH 값은 변경 불가이므로 해당 값 변경은 DROP으로 삭제 후 다시 생성해야 함
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --320
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --320
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --330
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --330

-- 시퀀스 객체를 가장 많이 사용할 용도는 테이블의 인위적인 식별자(PK)로 사용하는 것이다.
CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

INSERT
  INTO EMPLOYEE
VALUES
(
  SEQ_EID.NEXTVAL, '홍길동', '660101-1111111', 'hong_gd@greedy.com', '01012345678',
  'D2', 'J7', 'S1', 5000000, 0.1, 200, SYSDATE, NULL, DEFAULT
);

SELECT
       E.*
  FROM EMPLOYEE E;
 
ROLLBACK; 

-- 시퀀스 삭제
DROP SEQUENCE SEQ_EMPID;