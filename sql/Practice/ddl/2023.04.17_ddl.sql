-- 2023.04.17
-- DDL

create table ddl_test(
    no number(3),
    name varchar(10),
    birth date default sysdate
    );
    
desc ddl_test;

-- 사원번호, 사원이름, 급여 3개의 칼럼으로 구성된 emp01 테이블을 생성해봅시다.
create table emp01(
    empno number(4),
    ename varchar2(10),
    sal number(7,2)
    );
    
desc emp01;

insert into emp01(empno, ename, sal) values (1111, 'SON', 3000);
select * from emp01;

-- 서브쿼리를 이용해서 기존 테이블의 구조로 테이블을 생성, 데이터도 저장, 제약조건은 복사되지않는다.
create table emp02 as select * from emp;
desc emp02;
desc emp;

select *from emp02;

-- 원하는 컬럼만 또는 원하는 row만 선택해서 테이블 생성
create table emp03 as select empno, ename, job, hiredate from emp;
select *from emp03;

create table emp04 as select empno, ename, job, hiredate from emp where deptno = 30;
select *from emp04;

--데이터 필요없이 스키마만 복사
create table emp05 as select *from emp where 1=0;
select *from emp05;

--테이블의 변경 : 저장구조 (스키마의 구조 : 컬럼들의 집합) 가 변경
-- 컬럼 변경 (테이블에 컬럼을 추가, 테이블에 있는 컬럼을 삭제, 컬럼의 내용이나 이름을 수정)

--테이블의 변경
-- alter table [tableName] [add, modify, drop column](domain)
desc emp01;
alter table emp01 add(job varchar2(9));

--직급(JOB) 칼럼을 최대 30글자까지 저장할 수 있게 변경해 보도록하자.
desc emp01;
alter table emp01 modify(job varchar2(50) null);

select *from emp01;
delete from emp01;
commit;

-- emp01 테이블에서 job컬럼을 삭제
alter table emp01 drop column job;
desc emp01;

--테이블 객체의 삭제
-- drop table 테이블이름 -> 스키마 삭제와 저장데이터 삭제
-- DDL : 자동 commit, DML 작업중 DDL 작업은 신중하게

-- emp01 테이블을 삭제해 보자
drop table emp01;

-- 테이블의 모든 행을 삭제 : truncate table 테이블이름
select *from emp02;
truncate table emp02;

select *from emp03;
select ename from emp03;
delete from emp03;
rollback;

-- 테이블 이름 변경
-- rename 이전이름 to 새이름
desc ddl_test;

rename ddl_test to test;

------------------------------------
-- 제약조건의 필요성
insert into dept values (10,'test','test');

--not null 제약조건 : 설정한 컬럼에 null 값 입력을 금지하는 제약조건
-- column 수준에서만 정의 가능
drop table emp02;
-- 사원테이블 생성 : 사원번호, 사원이름, 직급, 부서명
create table emp02(
    empno number(4) not null,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
    );

insert into emp02 values(null, null, 'MANAGER', 30);
desc emp02;

-- emp03 생성 : 사원번호, 사원이름, 직급, 부서번호
-- empno : unique
-- ename : not null
drop table emp03;

create table emp03(
    empno number(4) constraint uni_num unique,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
    );
desc emp03;

insert into emp03 values(1111, 'KING', 'MANAGER', 10);
insert into emp03 values(1112, 'SON', 'MANAGER', 20);
-- not null, unique 함께 사용
drop table emp01;
create table emp01(
    empno number(4) not null constraint uni_num_emp01 unique,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
    );
insert into emp03 values(1111, 'KING', 'MANAGER', 40);
alter table emp01 modify(empno number(4) constraint pk_emp01 primary key);
desc emp01;

--check : 범위

-- defalut : 컬럼에 입력 값이 없을때 기본값을 설정해서 데이터 입력

create table emp01(
    empno number(4) not null constraint uni_num_emp01 unique,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2),
    gender char(1) check (gender in ('M','F'))
    );
desc emp01;
alter table emp01 modify(ename varchar2(12));
alter table emp01 add(deptno number(2));

create table emp06 as select * from emp where 0=1;
select * from emp03;
drop table emp06;

insert into emp03(job, deptno, empno, ename) values ('MANAGER', 20, 1114, 'LEE111');
select rownum,ename from emp03;
delete from emp03 where ename='LEE';
select * from emp03;
select rownum, ename from emp03;