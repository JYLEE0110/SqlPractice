-- create_phoneinfo_basic table
create table phoneInfo_basic(
        idx number(6) constraint PK_PHNEINFO_BASCI_IDX primary key,
        fr_name varchar2(20) not null,
        fr_phonenumber varchar2(20) not null,
        fr_email varchar2(20),
        fr_address varchar2(20),
        fr_regdate date default sysdate
        );

-- create_phoneinfo_university table
create table phoneInfo_univ(
        idx number(6) primary key,
        fr_u_major varchar2(20) default 'N' not null,
        fr_u_year number(1) default 1 not null check(fr_u_year > 0 and fr_u_year < 5) ,
        fr_ref number(7) references phoneInfo_basic(idx) not null
        );
        
-- create phoneInfo_com
create table phoneInfo_com(
        idx number(6) primary key,
        fr_c_company varchar(20) default 'N' not null,
        fr_ref number(6) references phoneInfo_basic(idx) not null
        );

-- phoneinfo_basic insert        
insert into phoneinfo_basic values(980110,'LEE','010-5420-xxxx', 'lee0110@naver.com','SEOUL','20/01/15');
insert into phoneinfo_basic values(960708,'KIM','010-5107-xxxx', 'kim@naver.com','DAEJEON','21/01/10');
insert into phoneinfo_basic values(970730,'PARK','010-9090-xxxx', 'park@naver.com','BUSAN','23/11/10');

-- phoneinfo_univ insert
insert into phoneinfo_univ values(100000,'COMPUTER',4,980110);
insert into phoneinfo_univ values(100001,'ELECTTRONICS',3,960708);
insert into phoneinfo_univ values(100002,'ECONOMICS',2, 970730);

--phoneinfo_com insert
insert into phoneinfo_com values(111111,'HUNDAI',980110);
insert into phoneinfo_com values(222222,'SAMSUNG',960708);
insert into phoneinfo_com values(333333,'APPLE', 970730);

commit;

-- select
select * from phoneinfo_basic;
select * from phoneinfo_univ;
select * from phoneinfo_com;

-- delete
delete from phoneinfo_com where fr_ref = 980110;
delete from phoneinfo_univ where fr_ref = 980110;
delete from phoneinfo_basic where idx = 980110;

rollback;

-- update
update phoneinfo_basic set fr_address = 'NEWYORK' where idx = 980110;
update phoneinfo_univ set fr_u_year = 4 where fr_ref = 960708;
update phoneinfo_com set fr_c_company = 'GOOGLE' where fr_ref = 980110;

rollback;