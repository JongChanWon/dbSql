함수란?
-함수는 로직을 모듈화 한 코드이다.

함수를 사용하는 이유
-실제 사용하는 곳과 함수가 구현되어 있는 부분을 분리하여 
 유지보수의 편이성을 도모하기 때문이다.
 
 함수의 종류
 1.(single-row function) - 한번에 하나씩 처리하는 함수
 2.(multi-row function) - 한번에 여러개 처리하는 함수
 
 single row function 안에는
 
 LENGTH
 SUBSTR
 LPAD, RPAD
 REPLACE
 TRIM
 MOD()
 ROUND()
 
 Dual 테이블 
 1. 오라클 자체에서 제공되는 테이블(사용자 모두 공통으로 사용가능)
 2. dual 테이블은 사용자가 함수(계산) 를 실행할 때 임시로 사용하는데 적합하다.
    -함수에 대한 쓰임을 알고 싶을 때 특정 테이블을 생성할 필요 없이 dual 테이블을 이용하여 
     함수 값을 리턴 받을 수 있다.
     
*오라클 내장함수*

*대소문자 관련 함수
-인자로 문자열 하나를 받는다.
lower : 소문자로 바꿔줌
upper : 대문자로 바꿔줌
initcap : 맨 앞 문자만 대문자로 바꿔줌

SELECT LOWER('I wanna Going home') hm,
       UPPER('i wanna going home') hm1,
       INITCAP('hARD') hm2
FROM dual;

함수는 WHERE절 에서도 사용 가능하다
ex)

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith'
WHERE ename = UPPER('smith');

위의 두 where절 에서 두번째 where절이 올바른 방식이다.
=개발자로서 지켜야하는 룰중에 하나? 왼쪽에있는 컬럼값을 바꾸면 안된다

*문자열 연산 함수
1. CONCAT : 2개의 문자열을 입력으로 받아 결합한 문자열을 반환하는 함수

SELECT CONCAT('coding', 'Is...')cd
FROM dual;

'select' || 'from' || 'where' concat으로 묶어보기
SELECT CONCAT(CONCAT('select', 'from'), 'where')sfw  
FROM dual;
-CONCAT 은 두개의 문자열을 받을 수 있지만 위의 예제처럼 CONCANT안에 있는 
 두개의 문자열을 하나의 문자열로 받아서 3개의 문자열을 한번에 결합 할 수 있다.
 

2. SUBSTR(문자열, 시작인덱스, 종료인덱스) : 문자열의 시작인덱스 부터 종료인덱스 까지의 문자열
    -시작인덱스는 1부터 (JAVA의 경우는 0부터 시작)
    
   LENGTH(문자열) : 문자열의 길이를 반환
   INSTR(문자열, 찾을문자열, [검색 시작 인덱스]) : 문자열에서 찾을 문자열이 존재하는지, 존재할 경우
                                               찾을 문자열의 인덱스(위치) 반환
   LPAD, RPAD(문자열, 맞추고 싶은 전체 문자열 길이, [패딩문자열 - 기본 값은 공백])
   TRIM(문자열) : 문자열 앞 뒤의 존재하는 공백을 제거, 문자열 중간에 있는 공백은 제거 대상이 아님
   REPLACE(문자열, 검색할 문자열, 변경할 문자열) : 문자열에서 검색할 문자열을 찾아 변경할 문자열로 변경
    
 SELECT SUBSTR('Halo, coding', 1, 5)sub,
        LENGTH('Halo, coding')len,
        INSTR('Halo, coding', 'o')ins,
        INSTR('Halo, coding', 'o', 2)ins2,
        INSTR('Halo, coding', 'o',INSTR('Halo, coding', 'o')) ins3,
        LPAD('Halo, coding', 18, 'dirty ')lp,
        RPAD('Halo, coding', 17, ' coco')rp,
        REPLACE('halo, coding', 'halo', 'pro')rep,
        TRIM('   Halo, coding   ') tr,
        TRIM('c' FROM 'coding')tr2 --공백이 없을 때 지정해준 특정 문자(앞,뒤) 를 제거해준다
 FROM dual;
 
 *NUMBER 관련 함수
  ROUND(숫자, 반올림 위치) :  반올림
   ROUND(105.54, 1) : 소수점 첫번째 자리까지 결과를 생성 ==> 소수점 두번째에서 반올림
    ==>4는 버림이 되므로 105.5 가된다
  TRUNC(숫자, 내림 위치) : 내림
  MOD(피제수, 제수) 나머지 연산; -- 10 / 2 나누기를 했을 때 나눔을 당하는 수(피제수) 여기서는 '10' 
  
 SELECT ROUND(123.44, 1) rd,
        ROUND(123.45, 1) rd1,
        ROUND(123.45, 0) rd2, --123에서 1의 자리 까지 결과를 생성, 소수점 첫번째에서 반올림 123
        ROUND(123.45, -1) rd3, --123에서 10의 자리 까지 결과를 생성, 1의 자리 에서 반올림 120
 FROM dual;
 
 SELECT TRUNC(1871.897, 2) tr,
        TRUNC(1871.897, 1) tr1,
        TRUNC(1871.896, 0) tr2,
        TRUNC(1871.896, -1) tr3
 FROM dual;
 
 SELECT MOD(15, 3), sal, MOD(sal, 1000) md  --셀렉트 절에서는 변형이 안되고 가공 한다
  FROM emp;
  
  SELECT MOD(20, 3), sal, MOD(sal, 1000) md -- 세야할것이 없어서 오류
  FROM dual;

 *날짜 관련 함수
  SYSDATE : 사용중인 서버의 현재 시간, 날짜를 반환 (인자가 없는 함수)
            함수명; --괄호 안씀
  date type +- 정수 : 일자를 더하고 뺌
  정수 1 = 하루
  1/24 = 1시간
  1/24/60 = 1분

 SELECT SYSDATE sy, SYSDATE -1/24 sy_5 --5일전 날짜
 FROM dual;
 
 TO_DATE(문자열, 포맷) : 문자열을 포맷에 맞게 해석하여 날짜 타입으로 형변환
 TO_CHAR(날짜, 포맷) : 날짜 타입을 포맷에 맞게 문자열로 변환
 
 MM : 월
 DD : 일자
 D : 주간일자(1~7, 1-일요일, 2-월요일 ..... 7-토요일)
 IW : 주차 (52~53) 날짜를 가지고 몇주차에 속하는지 알 수 있음
 HH : 시간(12시간)
 HH24 : 24시간 표기
 MI : 분
 SS : 초
 
==(date, format)형식
 SELECT TO_CHAR(SYSDATE -1/24/60, 'YYYY/MM/DD/D/IW HH24:MI:SS') ch -- 자바랑 연동할때 변수명이랑 별칭이랑 같게하는게 좋음
 FROM dual;
 
SELECT TO_CHAR(ADD_MONTHS(TO_DATE('20200421', 'YYYYMMDD'), 1), 'YYYYMM')
FROM dual;
SELECT ADD_MONTHS(SYSDATE-2, 1)as a,
       ADD_MONTHS(TO_DATE('2020-01-02', 'YYYY-MM-DD'),1) as b, --todate에서 포맷형식 바꿀쑤?
       TRUNC((TO_DATE('20200302', 'YYYYMMDD')- TO_DATE('20200304', 'YYYYMMDD'))*24,2) TR
FROM dual;

