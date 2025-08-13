-- 함수, 상수, 리터럴, 연산식
select version(), current_date, "hello",  1 + 2 from dual;

-- 수학함수, 문자열 함수, 날짜함수
select sin(pi()/4), upper("seoul"), curdate() from dual;

-- 대소문자 구문이 없다.
seLect VERSION(), current_DATE From DuaL;

-- table 생성: DDL
create table pet (
	name VARCHAR(100),
    owner VARCHAR(50),
    species VARCHAR(50),
    gender CHAR(1),
	birth DATE,
    death DATE
);

-- schema 확인
describe pet;
desc pet;


 

