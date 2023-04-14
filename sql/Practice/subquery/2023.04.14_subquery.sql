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
select c.name, sum(o.saleprice)
from(select custid, name from customer where custid <=2)c, orders o
where c.custid = o.custid
group by c.name
;
-------------------------------
select *
from(select custid, name from customer where custid <=2)c, orders o
where c.custid = o.custid;
-------------------------------

select rownum, ename, hiredate
from emp
order by hiredate
;

select rownum, ename, hiredate 
from(select ename, hiredate from emp order by hiredate)
-- 데이터 입력순으로 되기 때문에 rownum으로 입사일을 못뽑아서 인라인 뷰를 사용
where rownum <= 3
;

-- emp 테이블에서 최고 급여를 받는 사람 5명을 뽑아서 사원의 이름과 급여 정보를 출력
select rownum, ename, sal
from(select ename, sal from emp order by sal desc)
where rownum <= 5;

-- 중첩 질의 : where 절 뒤에 오는 비교연산과 연산자를 통해 처리할 때
select *
from emp
where sal > (select avg(sal)
            from emp);
            
select *
from emp
where sal > (select avg(sal)
            from emp);
            
-- 평균 주문금액 이하의 주문에대해서 주문번호 와 금액을 보이시오
select orderid, saleprice
from orders
where saleprice <= (select avg(saleprice) from orders);

-- 각 고객의 평균주문금액보다 큰금액의 주문 내역에 대해서
-- 주문번호, 고객번호, 금액을 보이시오
select o1.orderid, o1.custid, saleprice
from orders o1
where saleprice > (select avg(saleprice) from orders o2 where o2.custid = o1.custid);

-- 1번 고객의 평균 구매액
select avg(saleprice)
from orders
where custid = 1;

select *
from orders;

-- 주어진 문제가 3000 이상 받는 사원이 소속된 부서(10번, 20번)와 동일한 부서에서 근무하는 사원이기에 서브
-- 쿼리의 결과 중에서 하나라도 일치하면 참인 결과를 구하는 IN 연산자와 함께 사용되어야 합니다. 
select *
from emp
where sal>=3000;

select deptno
from emp
where sal>=3000;

select *
from emp
where deptno in (10,20);

select ename, sal, deptno
from emp
where deptno in (select distinct deptno
                from emp
                where sal>=3000);
                

-- 대한민국에 거주하는 고객에게
-- 판매한 도서의 총 판매액을 구하시오.
select sum(saleprice)
from orders
where custid in(select custid 
from customer 
where address like '%대한민국%');

select sum(saleprice)
from orders o, customer c
where o.custid = c. custid
and c.address like '%대한민국%';

-- 대한민국에 거주하는 고객 번호
select custid 
from customer 
where address like '%대한민국%';

--3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오

-- all : 서브쿼리의 결과 데이터 모두와 비교해서 참일때 => 참
select orderid, saleprice
from orders
where saleprice > all(select saleprice from orders where custid=3);
-- saleprice > 6000 and saleprice > 12000 and saleprice >13000


-- 3번 고객이 주문한 최고 금액
select max(saleprice)
from orders
where custid=3;

--다음은 부서번호가 30번인 사원들의 급여 중 가장 작은 값(950)보다 
--많은 급여를 받는 사원의 이름, 급여를 출력하는 예제를 작성해 봅시다.
select ename, sal
from emp
where sal > any(select sal 
from emp 
where deptno = 30);

-- sal > 2850 or sal > 1600 or sal>1250 or sal>1500 or sal > 950

-- exists, not exists 
-- 상관관계가 반드시 필요한 서브쿼리가 조건의 결과로 사용 : select의 결과가 존재 하는지 여부에 따라
-- 결과 처리

-- EXISTS 연산자로 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오. 
select sum(saleprice)
from orders o
where exists (select * from customer c where c.custid = o.custid and c.address like '%대한민국%')
;

select * from customer c where c.custid = 3 and c.address like '%대한민국%';