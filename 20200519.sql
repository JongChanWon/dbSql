'202005' -> 일반적인 달력을 row, col;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno);

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno;

UNION ALL

SELECT NULL, SUM(sal)
FROM emp

JOIN 수업할 때
CROSS JOIN : 데이터 복제 할 때...

부서번호별, 전체 행 별 SAL 합을 구하는 3번째 방법
SELECT DECODE(lv, 1, deptno, 2, NULL) deptno, SUM(sal)sal
FROM emp, (SELECT LEVEL lv
           FROM dual
           CONNECT BY LEVEL <= 2)
GROUP BY DECODE(lv, 1, deptno, 2, NULL)
ORDER BY 1; -- 1은 컬럼 순서

**계층쿼리**
계층구조가 바뀔때마다 설계가 바뀌어야함

create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XX회사', '');
insert into dept_h values ('dept0_00', '디자인부', 'dept0');
insert into dept_h values ('dept0_01', '정보기획부', 'dept0');
insert into dept_h values ('dept0_02', '정보시스템부', 'dept0');
insert into dept_h values ('dept0_00_0', '디자인팀', 'dept0_00');
insert into dept_h values ('dept0_01_0', '기획팀', 'dept0_01');
insert into dept_h values ('dept0_02_0', '개발1팀', 'dept0_02');
insert into dept_h values ('dept0_02_1', '개발2팀', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '기획파트', 'dept0_01_0');
commit;

계층형 쿼리
START WITH : 계층 쿼리의 시작점 기술
CONNECT BY : 계층(행) 간 연결고리를 표현

XX회사부터(최상위 노드) 에서 부터 하향식으로 조직구조를 탐색하는 오라클 계층형 쿼리 작성
1. 시작점을 선택 : XX회사
2. 계층간(행과 행) 연결고리 표현SELECT
   PRIOR : 내가 현재 읽고 있는 행을 표현
   아무것도 붙이지 않음: 내가 앞으로 읽을 행을 표현
   
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*3) || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

h_2]
SELECT LEVEL, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd  
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

상향식
시작점 : 디자인팀 - dept0_00_0

SELECT *
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

h_3]
SELECT LEVEL, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd  
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all

select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;

SELECT *
FROM h_sum;

h_4]
SELECT LPAD(' ', (LEVEL-1)*3) ||s_id s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;


create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XX회사', null, 1);
insert into no_emp values('정보시스템부', 'XX회사', 2);
insert into no_emp values('개발1팀', '정보시스템부', 5);
insert into no_emp values('개발2팀', '정보시스템부', 10);
insert into no_emp values('정보기획부', 'XX회사', 3);
insert into no_emp values('기획팀', '정보기획부', 7);
insert into no_emp values('기획파트', '기획팀', 4);
insert into no_emp values('디자인부', 'XX회사', 1);
insert into no_emp values('디자인팀', '디자인부', 7);

commit;
SELECT *
FROM no_emp

SELECT LPAD(' ', (LEVEL-1)*3) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

**CONNECT BY 이후에 이어서 PRIOR 가 오지 않아도 상관 없다
PRIOR 는 현재 읽고 있는 행을 지칭하는 키워드 --위 아래는 똑같은 결과가 나옴

SELECT LPAD(' ', (LEVEL-1)*3) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY parent_org_cd = PRIOR org_cd;


PRUNING BRANCH : 가지 치기
WHERE 절에 조건을 기술 했을 때 : 계층형 쿼리를 실행 후 가장 마지막에 적용
CONNECT BY  절에 기술 했을 때 : 
의 차이를 비교
*단 계층형 쿼리에는 FROM -> START WITH CONNECT BY -> WHERE 절 순으로 처리된다

1. WHERE 절에 조건을 기술한 경우
SELECT LEVEL, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd  
FROM dept_h
WHERE deptnm != '정보기획부'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

2. CONNECT BY 절에 조건을 기술한 경우 --정보기획부의 하위부서들까지 없어짐(접근 몬함)
SELECT LEVEL, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd  
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '정보기획부';


계층형 쿼리에서 사용할 수 있는 특수 함수
CONNECT_BY_ROOT(column) : 해당 컬럼의 최상위 데이터를 조회
SYS_CONNECT_BY_PATH(column, 구분자) : 해당 행을 오기까지 거쳐온 행의 column 들을 표현하고 구분자를 통해 연결
CONNECT_BY_ISLEAF 인자가 없음 : 해당 행이 연결이 더이상 없는 마지막 노드인지 (LEAF 노드)
                               LEAF 노드 : 1, NO LEAF 노드 : 0
(게시판)root 는 원본글
원본글
    -답글
        -답글
원본글
    -답글
    -답글
SELECT LEVEL, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd,
       CONNECT_BY_ROOT(deptnm) root,
       LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-')TRIM,
       CONNECT_BY_ISLEAF LEAF
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, '첫번째 글입니다');
insert into board_test values (2, null, '두번째 글입니다');
insert into board_test values (3, 2, '세번째 글은 두번째 글의 답글입니다');
insert into board_test values (4, null, '네번째 글입니다');
insert into board_test values (5, 4, '다섯번째 글은 네번째 글의 답글입니다');
insert into board_test values (6, 5, '여섯번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (7, 6, '일곱번째 글은 여섯번째 글의 답글입니다');
insert into board_test values (8, 5, '여덜번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (9, 1, '아홉번째 글은 첫번째 글의 답글입니다');
insert into board_test values (10, 4, '열번째 글은 네번째 글의 답글입니다');
insert into board_test values (11, 10, '열한번째 글은 열번째 글의 답글입니다');
commit;

SELECT *
FROM board_test;

실습 h6]
SELECT seq, LPAD(' ', (LEVEL-1)*3) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

실습 h7] 최신글이 위로 오도록 정렬
계층형 쿼리를 정렬시 계층 구조를 유지하면서 정렬 하는 기능이 제공

ORDER SIBLINGS BY

SELECT seq, parent_seq, LPAD(' ', (LEVEL-1)*3) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DES
C; --ORDER BY seq DESC; 이렇게 하면 계층구조가 깨짐

계층쿼리 중요!!

emp테이블을 2번 읽어서 목적은 달성 -> 조금 더 효율적인 방법이 없을까?? -> WINDOW / ANALYSIS function 를 사용해서,, 
SELECT ename
FROM emp
WHERE sal = (SELECT MAX(sal)
             FROM emp);
전체 직원중에 가장 높은 급여를 받는 사람의 급여정보
가장 높은 급여를 받는 사람의 이름
근데 그게 누군데??
SELECT MAX(sal)
FROM emp;

실습 ana0

SELECT ename, sal, deptno, ROWNUM || 'sal_rank'sal_rank
FROM emp
ORDER BY deptno, sal desc;

쌤이푼거

SELECT a.*, b.lv, ROWNUM
FROM
 (SELECT deptno, COUNT(*)cnt
  FROM emp
  GROUP BY deptno)a, (SELECT LEVEL lv, ROWNUM
                      FROM dual
                      CONNECT BY LEVEL <= 6) b
 WHERE a.cnt >= lv
 ORDER BY a.deptno, b.lv;

CALENDAR 1]
데이터 : 일단위 실적
화면에 나타내야 하는 단위 : 월단위

SELECT NVL(MIN(DECODE(mm, '201901',sales)), 0) jan, NVL(MIN(DECODE(mm, '201902',sales)), 0) feb, 
       NVL(MIN(DECODE(mm, '201903',sales)), 0) mar, NVL(MIN(DECODE(mm, '201904',sales)), 0) apr,
       NVL(MIN(DECODE(mm, '201905',sales)), 0) may, NVL(MIN(DECODE(mm, '201906',sales)), 0) june
FROM
(SELECT TO_CHAR(dt, 'YYYYMM')mm, SUM(sales) sales
 FROM sales
 GROUP BY TO_CHAR(dt, 'YYYYMM'))


CALENDAR 2]
202005 ==> 해당월의 1일이 속하는 주의 일요일은 몇일인가?

SELECT TO_DATE('202005', 'YYYYMM'), TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D'),
       TO_DATE('202005', 'YYYYMM') - TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D') + 1
FROM dual;

202005 ==> 해당월의 마지막 일자가 속하는 주의 토요일은 몇일인가?

SELECT TO_DATE('202005', 'YYYYMM'), TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D'),
       TO_DATE('202005', 'YYYYMM') - TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D') + 1 s,
       LAST_DAY(TO_DATE('202005', 'YYYYMM')), TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'D'),
       LAST_DAY(TO_DATE('202005', 'YYYYMM')) + (7- TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'D')) e,
       
       (LAST_DAY(TO_DATE('202005', 'YYYYMM')) + (7- TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'D'))
       - (TO_DATE('202005', 'YYYYMM') - TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D') + 1) + 1 days
FROM dual;



SELECT DECODE(d, 1, iw+1, iw),
           MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, 
           MIN(DECODE(d, 3, dt)) tue, MIN(DECODE(d, 4, dt)) wed, 
           MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri,
           MIN(DECODE(d, 7, dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt, 
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') )
GROUP BY DECODE(d, 1, iw+1, iw)
ORDER BY DECODE(d, 1, iw+1, iw);








