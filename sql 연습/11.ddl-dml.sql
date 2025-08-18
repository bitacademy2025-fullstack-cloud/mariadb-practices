-- DDL / DML(insert, update, delete) 연습

drop table member;
create table member (
	no int not null auto_increment,
    email varchar(200) not null default '',
    password varchar(64) not null,
    name varchar(50) not null,
    department varchar(100),
    primary key(no)
);
desc member;

alter table member add column juminbunho char(13) not null;
desc member;

alter table member drop column juminbunho;
desc member;

alter table member add column juminbunho char(13) not null after email;
desc member;

alter table member change column department dept varchar(100) not null default 'none';
desc member;

alter table member add column self_intro text;
desc member;

alter table member drop column juminbunho;
desc member;

-- insert
insert
  into member
values (null, 'kickscar@gmail.com', password('1234'), '안대혁', '개발팀', null);
select * from member;

insert
  into member(email, name, password, dept)
values ('kickscar2@gmail.com', '안대혁2', password('1234'), '개발팀');
select * from member;

-- update
update member
   set email='kickscar3@gmail.com', password=password('4321')
 where no = 2;
select * from member;

-- delete
delete
  from member
 where no = 2; 
select * from member;

-- transaction
select no, email from member;

select @@autocommit from dual; -- 1, tx disabled
insert
  into member(email, name, password, dept)
values ('kickscar2@gmail.com', '안대혁2', password('1234'), '개발팀');
select no, email from member;

-- tx begin
set autocommit = 0;
select @@autocommit from dual; -- 0, tx enabled(tx begin)
insert
  into member(email, name, password, dept)
values ('kickscar3@gmail.com', '안대혁3', password('1234'), '개발팀');
select no, email from member;

-- tx end
commit;
select no, email from member;




 








