 주어진것 : 년월을 담고있는 문자열 '201912' ==> 31
 SELECT TO_DATE(:yyyymm, 'YYYYMM'))param, '31' DT
        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), --바인드변수로 치환하려면 앞에 :(콜론) 을 붙이면 된다
        TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')
 FROM dual;
 
 
 *LAST_DAY(DATE1) DATE1 이 속한 월의 마지막 날짜를 반환
 ++마지막 날짜를 구하는것++ 중요!
 SYSDATE: 2020/04/21 ==> 2020/04/30
 SELECT LAST_DAY(SYSDATE)
 FROM dual;
 LAST_DAY(TO_DATE('201602', 'YYYYMM')) param
 NULL값은 가장 큰값으로 한다
 
 EXPLAIN PLAN FOR
 SELECT *
 FROM emp
 WHERE empno='7369';
 
 SELECT *
 FROM TABLE(DBMS_XPLAN.DISPLAY);
 
 실행계획을 보는 순서(id)
 * 들여쓰기 되어있으면 자식 오퍼레이션
 1. 위에서 아래로
    *단 자식 오퍼레이션이 있으면 자식부터 읽는다
    
    1 ==> 0번 순으로 읽는다
 Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |-- 그다음 부모
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |-- 들여쓰기 되있으니까 자식부터
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)
 
Note
-----
   - dynamic sampling used for this statement (level=2)
 
 
--------------------------------------------------------
 
 EXPLAIN PLAN FOR
 SELECT *
 FROM emp
 WHERE TO_CHAR(empno) = '7369';
 
 SELECT *
 FROM TABLE(DBMS_XPLAN.DISPLAY);
 
 Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_CHAR("EMPNO")='7369')
 
Note
-----
   - dynamic sampling used for this statement (level=2)
 
 EXPLAIN PLAN FOR
 SELECT *
 FROM emp
 WHERE empno = 7300+ '69'; --문자열에서는 더하기 연산자를 못쓰는데 SQL에서는 숫자로 인식한다.
 
 SELECT *
 FROM TABLE(DBMS_XPLAN.DISPLAY);
 
 Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_CHAR("EMPNO")='7369')
 
Note
-----
   - dynamic sampling used for this statement (level=2)
   
   
i18n

000900
0001000
SELECT ename, sal, TO_CHAR(sal, 'L009,999.00')
FROM emp;
 
 NULL과 관련된 함수
 NVL
 NVL2
 NULLIF
 COALESCE;
 
 
 왜 NULL 처리를 해야할까?
 NULL에 대한 연산결과는 NULL이다.
 예를 들어서 emp테이블에 존재하는 sal, comm 두개의 컬럼 값을 합한 값을 알고 싶어서
 다음과 같이 SQL을 작성.
 
 SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
 FROM emp;
 
 
 NVL(expr1,expr2) 
 expr1이 null이면 expr2값을 리턴하고
 expr1이 null아니면 expr1값을 리턴
 
 SELECT empno, ename, sal, comm, sal+ NVL(comm, 0) sal_plus_comm --comm 일때 0 을 리턴 하겠다.
 FROM emp;
 
 SELECT userid, usernm, reg_dt, NVL(reg_dt, LAST_DAY(SYSDATE)) dt
 FROM users;
 
 
 
 
 
 
 
 
 
 
 
 