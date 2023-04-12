-- 2023.04.12
-- 함수
-- 더미 테이블 => 행 1개 -> x
desc dual;
select * from dual;

-- 단일 행 함수 / 집합(그룹) 함수
-- 단일행 함수 : 숫자, 문자, 날짜, 변환, 기타 함수

-- 숫자 함수
-- 절대값 abs
select 10, -10, abs(-10), abs(10)  from dual;

-- floor : 소수점 아래를 절사
select floor(2.1), floor(2.9) from dual;

-- round : 지정위치에서 반올림 처리
select round(1234.567, 1) from dual;
select 1234.567, round(1234.567), round(1234.567, 1), round(1237.567, -2) from dual;

-- trunc : 특정 자리수 아래를 절사
select 1234.567, trunc(1234.567), trunc(1234.567,1), trunc(1234.567,-1) from dual;

-- mod : 나머지 연산
select mod(1,3),mod(2,3),mod(0,3), mod(3,0) from dual;

-- 문자 처리 함수
-- 문자열 모두를 소문자로 변경
select 'SCOTT', lower('SCOTT'), upper('scott') from dual;
select dname, lower(dname) as dname from dept;
select 'scott', initcap('scott') from dual;

-- 문자열 추출 : substr(원본, 시작위치), substr(원본, 시작위치, 반환할 문자의 개수)
select substr('안녕하세여. 흥민손입니다.',8,3) from dual;

-- 문자열의 개수
select length('안녕하세요') from dual;

-- 문자열에서 특정 자리수가 지정하고 자리에 데이터가 없을때 패턴을 입력
select '10', lpad('10',5, '0') from dual;
select '이주용', lpad('이주용',12, '1501호') from dual;
select deptno, lpad(deptno,5,'0') from dept;

-- trim() : 공백제거 
select trim('    A B C     ') from dual;

select replace('Steven King', 'Steven', 'S.'), replace('Steven King', 'Steven', '') from dual;

-- 날짜 함수
select sysdate from dual;
select months_between('23/12/12', sysdate) from dual;
select add_months(sysdate, 5) from dual;
select next_day(sysdate,5) from dual;
select last_day(sysdate) from dual;
select round(sysdate) from dual;
select trunc(sysdate) from dual;

-- 변환함수
-- DATE -> CHAR
-- to_char(원본, '패턴')
select sysdate, 
to_char(sysdate,'yyyy.mm.dd'),
to_char(sysdate,'yyyy.mm.dd day HH24:MI:ss') 
from dual;

-- number -> char
select 123456789, 
to_char(123456789,'000,000,000'),
trim(to_char(123456789,'999,999,999')),
trim(to_char(123456789,'L999,999,999'))
from dual;

select ename, sal, to_char(sal*1300,'L999,999,999') as won from emp;

-- char -> Date
-- to_date('문자열', '패턴')
select ename, hiredate from emp where hiredate=to_date('1981.02.20','yyyy.mm.dd');
select ename, hiredate from emp where hiredate='81/02/20';

insert into emp values(9999, 'SON', 'MANAGER', 7788, to_date('2023-04-12','yyyy-mm-dd'), 4000, null, 10);
select * from emp;
rollback; -- 마지막 commit 시점으로 복귀

-- char -> number
-- to_number('문자열', '패턴') => 숫자 타입
select to_number('20,000','999,999') - to_number('10,000','999,999') from dual;

-- decode 함수 => 비교 연산 후 결과 출력을하는 함수 switch-case랑 비슷 하다.
SELECT ENAME, job, sal,
 nvl(DECODE(job,
 'ANALYST', sal+sal*0.05, 
 'SALESMAN', sal+sal*0.1,
 'MANAGER', sal+sal*0.15, 
 'CLERK', sal+sal*0.2 
 ),sal)
 AS UPsal
FROM EMP;


SELECT ENAME, DEPTNO,
 CASE WHEN DEPTNO=10 THEN 'ACCOUNTING' 
 WHEN DEPTNO=20 THEN 'RESEARCH' 
 WHEN DEPTNO=30 THEN 'SALES' 
 else 'OPERATIONS'
 END AS DNAME
FROM EMP;

-- 그룹함수, 집합함수, 집계함수, 다중행 함수
-- 하나의 행이 아닌 다중행을 그룹으로 묶어서 처리
-- sum, avg, count, man, min
-- 급여 총액을 구해보자
-- 그룹함수는 null 인대상은 배제하고 계산함

select to_char(sum(sal)*1300,'L999,999,999') as totalSal from emp;

-- 커미션의 총합
select to_char(sum(comm)*1300,'L999,999,999') as totalComm from emp;
select sum(comm), avg(comm), count(comm) from emp;
select comm from emp where comm is not null;

-- 평균 급여
select round(avg(sal)) from emp;

-- 최대급여 max(), 최소급여 min()
select max(sal), min(sal) from emp;

-- count() => row 개수
-- 전체 사원의 수
-- count의 실행 순서는 where절로 받은 데이터를 토대로 작동함
select count(*) from emp where deptno = 10;
-- 부서의 개수
select count(*) from dept;

select count(distinct job) from emp order by job;

select deptno, sum(sal), round(avg(sal)) from emp group by deptno;

-- group by => 행 단위로 그룹핑

select deptno, 
count(*) as "totalEmp", 
sum(sal)as "totalSal",
round(avg(sal))as "avgSal",
max(sal) as topSal,
min(sal) as bottomSal,
count(comm)
from emp group by deptno order by deptno;
select job from emp group by job;

select * from emp order by deptno;

