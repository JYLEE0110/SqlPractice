

-- 2023.04.11
-- select
-- 로그인 한 사용자가 소유하고있는 테이블의 정보
select *from tab;

-- 테이블 정보 확인
DESC emp;
desc dept;

-- 데이터 추출하는 질의어 : select
-- select 컬럼이름, 컬럼이름 ... from 테이블이름(view 사용가능);
-- select *from 테이블이름;

select * from emp;

select dname,deptno, loc from dept;

-- select 구문의 프레젠테이션영역에 테이블이 가지는 컬럼 뿐 아니라 연산(함수)의 결과를 새로운 컬럼으로 출력

select sal from emp;
select sal, sal+100, sal-100, sal/2, sal*10 from emp;

-- 사원테이블에서 사원의 이름과 급여, 연봉계산 결과를 출력, 연봉의 계산은 급여*12

select ename,sal, sal*12 from emp;

-- 상여금 계산 -> sal*12+comm

select ename, sal, comm, sal*12+comm from emp;

select ename, sal, nvl(comm,0) as comm, sal*12+nvl(comm,0) as sal_of_year from emp;

select ename || ' is a ' || job as string from emp;

-- select [distinct] from...
-- -> 중복값 제거하고 값을 하나만 출력

select distinct job from emp;

-- 원하는 행row(tuple) 검색
-- where 절 사용
-- select ... from ... where
select * from emp where sal > 1000;

--다음은 이름이 FORD인 사원의 사원번호(EMPNO)과 사원이름(ENAME)과 급여(SAL)을 출력
select * from emp where ename = 'FORD';
select * from emp where hiredate > '81/12/03';
select *from emp where deptno=10 or job='MANAGER';

select *from emp where deptno != 10;

-- 2000~3000 의 급여를 받는 사원

select *from emp where sal>=2000 and sal<=3000;
select *from emp where sal between 2000 and 3000;

-- 10번, 20번, 30번 부서에 소속한 사원의 정보를 출력

select *from emp where deptno not in(10,20);

select *from emp where hiredate between '81/01/01' and '81/12/31';
select *from emp where hiredate not between '81/01/01' and '81/12/31';

-- null 여부를 판단 하는 is null / is not null
-- 커미션이 등록되지 않은 사원 리스트 => comm이 null인 사원
select * from emp where comm is null;

-- 커미션이 등록되어 있는 사원 리스트 => comm이 null이 아닌 사원
select * from emp where comm is not null;

-- 커미션을 받는 사원 리스트
select * from emp where comm is not null and comm != 0;

select *from emp order by ename;
select *from emp order by ename desc;

select *from emp order by hiredate desc ;

-- 급여순
select *from emp order by sal desc, ename;