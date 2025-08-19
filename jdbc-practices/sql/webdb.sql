--
-- JDBC Test SQL
--

desc dept;

-- select 
select id, name from dept where name like '%개발%';

-- insert
insert into dept(name) values('UX팀');

-- delete
delete from dept where id = 11; 

-- update
update dept set name = '서비스개발팀' where id = 2; 

--
-- email application
--

desc email;


-- findAll

-- deleteByEmail

-- insert
insert into email


