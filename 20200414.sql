/* SQL 주석 */
-- 한줄주석 ==> JAVA의 한줄주석 //

SELECT *    -- 모든 컬럼의 정보를 조회
FROM prod;  -- prod 테이블에서 라는 뜻

-- SQL 실행하는 방법
-- 1. 실행하려는 SQL을 선택하고 (shift) cntl + enter;
-- 2. 실행하려는 SQL문장 아무곳에서나 프롬프트를 위치시키고 cntl + enter;
--    * 단 위아래 다른 sql 문장이 있을 경우 ; 에 의해 sql이 구분되지 못할 경우 실행되지 못함
-- 특정 컬럼에 대해서만 조회 : SELECT 컬럼1, 컬럼2....
-- prod_id, prod_name 컬럼만 prod 테이블에서 조회;

