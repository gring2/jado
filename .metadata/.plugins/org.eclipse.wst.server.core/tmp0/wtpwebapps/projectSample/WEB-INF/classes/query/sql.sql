

create table user_tbl(
	userNum varchar2(10) primary key,
	userid varchar2(100) not null,
	userpassword varchar2(100) not null,
	username varchar2(20) not null
);

create table vote(
	userNum varchar2(10) not null,
	chatNum varchar2(20) not null,
	agreed char not null,
	constraint fk_userNum foreign key(userNum)
	references user_tbl(userNum)
);
create table project(
	proNum varchar2(10) primary key,
	title varchar2(30) not null,
	startDate date not null,
	enddate date
)
create table theme(
	thmNum varchar2(10) not null,
	proNum varchar2(10) not null,
	themeName varchar2(20) not null,
	constraint fk_proNum foreign key(proNum)
	references project(proNum)
)
create table member(
	memNum varchar2(20) primary key,
	userNum varchar2(10) not null,
	proNUm varchar2(10) not null
)
create table storage(
	fileName varchar2(20) not null,
	memNum varchar2(20) not null,
	constraint fk_memNum foreign key(memNum)
	references member(memNum)
)
alter table member add constraints fk_m_userum foreign key(userNum)
references user_tbl(usernum)
create table chat(
	chatNum varchar2(20) primary key,
	content varchar2(4000) not null,
	chatType varchar2(10),
	startDate date default sysdate,
	chatDate date default sysdate,
	memNum varchar2(20) not null,
	thmNum varchar2(10) not null
)

drop table chat;
drop table storage;
drop table member;
drop table theme;
drop table project;
drop table vote;
drop table user_tbl



/* Create Tables */

CREATE TABLE JADO_CHAT
(
	chatNum varchar2(20) NOT NULL,
	content varchar2(4000) NOT NULL,
	chatType varchar2(10),
	startDate date,
	chatDate date NOT NULL,
	memNum varchar2(20) NOT NULL,
	thmNum varchar2(10) NOT NULL,
	PRIMARY KEY (chatNum)
);


CREATE TABLE JADO_GANTCHART
(
	gantNum varchar2(13) NOT NULL,
	todo varchar2(100) NOT NULL,
	startDate date NOT NULL,
	duration number(3) NOT NULL,
	proNum varchar2(10) NOT NULL,
	PRIMARY KEY (gantNum)
);


CREATE TABLE JADO_GANTMEMBER
(
	userNum varchar2(10) NOT NULL,
	gantNum varchar2(13) NOT NULL
);


CREATE TABLE JADO_MEMBER
(
	memNum varchar2(20) NOT NULL,
	userNum varchar2(10) NOT NULL,
	proNum varchar2(10) NOT NULL,
	agreed char NOT NULL,
	PRIMARY KEY (memNum)
);


CREATE TABLE JADO_PROJECT
(
	proNum varchar2(10) NOT NULL,
	title varchar2(100) NOT NULL,
	startDate date NOT NULL,
	enddate date,
	PRIMARY KEY (proNum)
);


CREATE TABLE JADO_STORAGE
(
	fileName varchar2(200) NOT NULL,
	memNum varchar2(20) NOT NULL
);


CREATE TABLE JADO_THEME
(
	thmNum varchar2(10) NOT NULL,
	proNum varchar2(10) NOT NULL,
	themeName varchar2(20) NOT NULL,
	PRIMARY KEY (thmNum)
);


CREATE TABLE JADO_USER
(
	userNum varchar2(10) NOT NULL,
	id varchar2(100) NOT NULL UNIQUE,
	password varchar2(100) NOT NULL,
	name varchar2(20) NOT NULL,
	googleID varchar2(20),
	PRIMARY KEY (userNum)
);


CREATE TABLE JADO_VOTE
(
	userNum varchar2(10) NOT NULL,
	chatNum varchar2(20) NOT NULL,
	agreed char NOT NULL
);



/* Create Foreign Keys */

ALTER TABLE JADO_VOTE
	ADD FOREIGN KEY (chatNum)
	REFERENCES JADO_CHAT (chatNum)
;


ALTER TABLE JADO_GANTMEMBER
	ADD FOREIGN KEY (gantNum)
	REFERENCES JADO_GANTCHART (gantNum)
;


ALTER TABLE JADO_CHAT
	ADD FOREIGN KEY (memNum)
	REFERENCES JADO_MEMBER (memNum)
;


ALTER TABLE JADO_STORAGE
	ADD FOREIGN KEY (memNum)
	REFERENCES JADO_MEMBER (memNum)
;


ALTER TABLE JADO_GANTCHART
	ADD FOREIGN KEY (proNum)
	REFERENCES JADO_PROJECT (proNum)
;


ALTER TABLE JADO_MEMBER
	ADD FOREIGN KEY (proNum)
	REFERENCES JADO_PROJECT (proNum)
;


ALTER TABLE JADO_THEME
	ADD FOREIGN KEY (proNum)
	REFERENCES JADO_PROJECT (proNum)
;


ALTER TABLE JADO_CHAT
	ADD FOREIGN KEY (thmNum)
	REFERENCES JADO_THEME (thmNum)
;


ALTER TABLE JADO_GANTMEMBER
	ADD FOREIGN KEY (userNum)
	REFERENCES JADO_USER (userNum)
;


ALTER TABLE JADO_MEMBER
	ADD FOREIGN KEY (userNum)
	REFERENCES JADO_USER (userNum)
;


ALTER TABLE JADO_VOTE
	ADD FOREIGN KEY (userNum)
	REFERENCES JADO_USER (userNum)
;

CREATE SEQUENCE seq_user INCREMENT BY 1 START WITH 1 MAXVALUE 999999999;

CREATE SEQUENCE seq_pro INCREMENT BY 1 START WITH 1 MAXVALUE 999999999;

CREATE SEQUENCE seq_cht INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999999999999;
