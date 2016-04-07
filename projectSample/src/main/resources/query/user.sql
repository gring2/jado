drop table user_tbl;
create table user_tbl(
	id varchar2(20) primary key,
	pw varchar2(20) not null,
	name varchar2(20) not null,
	phone varchar2(20)
);
insert into user_tbl values('10','10','10','100')
