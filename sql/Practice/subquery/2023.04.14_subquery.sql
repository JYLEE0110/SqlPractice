-- 2023. 04.14
-- sub query

-- 스칼라 부속질의 : select 절에 쓸 수 있는 서브쿼리, 단일 값(질의의 결과가 단일행 단일열)
select deptno , (select dname from dept where dept.deptno = emp.deptno) as dname-- '부서이름' => DECODE or JOIN or select(서브쿼리) 사용
from emp
where ename = 'SCOTT';


select o.custid, c.name, sum(saleprice)
from orders o, customer c
where o.custid = c.custid
group by o.custid, c.name
;

select o.custid, 
        (select name from customer c where c.custid = o.custid) as name,
        (select sysdate from dual) as day,
        sum(o.saleprice)
from orders o
group by o.custid;

-- inline vie : from절 뒤에 오는 서브쿼리, 가상의 테이블, 테이블처럼 사용

select empno, ename, job, hiredate 
from emp
where deptno = 30
;

select *
from (select empno, ename, job, hiredate from emp where deptno = 30)
where ename = 'WARD';

-- 고객번호가 2이하인 고객들의 총 판매액
select c.name
from(select custid, name from customer where custid <=2) c, orders o
where c.custid = o.custid
group by o.custid
;

select rownum, ename, hiredate
from emp
order by hiredate
;

select rownum, ename, hiredate 
from(select ename, hiredate from emp order by hiredate)
-- 데이터 입력순으로 되기 때문에 rownum으로 입사일을 못뽑아서 인라인 뷰를 사용
where rownum <= 3
;
