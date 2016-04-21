
/* Drop Tables */

DROP TABLE JADO_NOTICE CASCADE CONSTRAINTS;
DROP TABLE JADO_SCRAP CASCADE CONSTRAINTS;
DROP TABLE HR.JADO_CHAT CASCADE CONSTRAINTS;
DROP TABLE HR.JADO_GANTMEMBER CASCADE CONSTRAINTS;
DROP TABLE HR.JADO_GANTCHART CASCADE CONSTRAINTS;
DROP TABLE HR.JADO_MEMBER CASCADE CONSTRAINTS;
DROP TABLE HR.JADO_MSG CASCADE CONSTRAINTS;
DROP TABLE HR.JADO_STORAGE CASCADE CONSTRAINTS;
DROP TABLE HR.JADO_THEME CASCADE CONSTRAINTS;
DROP TABLE HR.JADO_PROJECT CASCADE CONSTRAINTS;
DROP TABLE HR.JADO_USER CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE JADO_NOTICE
(
	ID varchar2(100 char),
	content varchar2(1000),
	noticeDate date,
	PRONUM varchar2(10 char) NOT NULL
);


CREATE TABLE JADO_SCRAP
(
	title varchar2(50),
	content varchar2(4000),
	startDate date,
	USERNUM varchar2(10 char) NOT NULL
);


CREATE TABLE HR.JADO_CHAT
(
	CHATNUM varchar2(20 char) NOT NULL,
	CONTENT varchar2(4000 char) NOT NULL,
	CHATTYPE varchar2(10 char),
	STARTDATE date,
	CHATDATE date DEFAULT sysdate  NOT NULL,
	MEMNUM varchar2(20 char) NOT NULL,
	THMNUM varchar2(10 char) NOT NULL,
	CONSTRAINT SYS_C007544 PRIMARY KEY (CHATNUM)
);


CREATE TABLE HR.JADO_GANTCHART
(
	GANTNUM varchar2(13 char) NOT NULL,
	PRONUM varchar2(10 char) NOT NULL,
	TODO varchar2(100 char) NOT NULL,
	CONSTRAINT SYS_C007548 PRIMARY KEY (GANTNUM)
);


CREATE TABLE HR.JADO_GANTMEMBER
(
	USERNUM varchar2(10 char) NOT NULL,
	GANTNUM varchar2(13 char) NOT NULL,
	STARTDATE date,
	ENDDATE date,
	DURATION number(3,0),
	GANTPERCENT number(3,0) DEFAULT 0

);


CREATE TABLE HR.JADO_MEMBER
(
	MEMNUM varchar2(20 char) NOT NULL,
	USERNUM varchar2(10 char) NOT NULL,
	PRONUM varchar2(10 char) NOT NULL,
	AGREED char(1 char) DEFAULT '''N'' ' NOT NULL,
	CONSTRAINT SYS_C007555 PRIMARY KEY (MEMNUM)
);


CREATE TABLE HR.JADO_MSG
(
	CONTENT varchar2(4000 char),
	STARTDATE date,
	SENDER varchar2(100 char) NOT NULL,
	RECEIVER varchar2(100 char) NOT NULL,
	ISINVATE varchar2(4 char)
);


CREATE TABLE HR.JADO_PROJECT
(
	PRONUM varchar2(10 char) NOT NULL,
	TITLE varchar2(100 char) NOT NULL,
	STARTDATE date DEFAULT sysdate  NOT NULL,
	ENDDATE date,
	USERNUM varchar2(10 char) NOT NULL,
	CONSTRAINT SYS_C007560 PRIMARY KEY (PRONUM)
);


CREATE TABLE HR.JADO_STORAGE
(
	FILENAME varchar2(200 char) NOT NULL,
	THMNUM varchar2(10 char) NOT NULL
);


CREATE TABLE HR.JADO_THEME
(
	THMNUM varchar2(10 char) NOT NULL,
	PRONUM varchar2(10 char) NOT NULL,
	THEMENAME varchar2(50 char) NOT NULL,
	CONSTRAINT SYS_C007566 PRIMARY KEY (THMNUM)
);


CREATE TABLE HR.JADO_USER
(
	USERNUM varchar2(10 char) NOT NULL,
	ID varchar2(100 char) NOT NULL UNIQUE,
	PASSWORD varchar2(100 char) NOT NULL,
	NAME varchar2(20 char) NOT NULL,
	GOOGLEID varchar2(20 char),
	CONSTRAINT SYS_C007571 PRIMARY KEY (USERNUM)
);



/* Create Foreign Keys */

ALTER TABLE HR.JADO_GANTMEMBER
	ADD CONSTRAINT SYS_C007578 FOREIGN KEY (GANTNUM)
	REFERENCES HR.JADO_GANTCHART (GANTNUM)
	ON DELETE CASCADE
;


ALTER TABLE HR.JADO_CHAT
	ADD CONSTRAINT SYS_C007579 FOREIGN KEY (MEMNUM)
	REFERENCES HR.JADO_MEMBER (MEMNUM)
;


ALTER TABLE JADO_NOTICE
	ADD FOREIGN KEY (PRONUM)
	REFERENCES HR.JADO_PROJECT (PRONUM)
;


ALTER TABLE HR.JADO_GANTCHART
	ADD CONSTRAINT SYS_C007581 FOREIGN KEY (PRONUM)
	REFERENCES HR.JADO_PROJECT (PRONUM)
;


ALTER TABLE HR.JADO_MEMBER
	ADD CONSTRAINT SYS_C007582 FOREIGN KEY (PRONUM)
	REFERENCES HR.JADO_PROJECT (PRONUM)
;


ALTER TABLE HR.JADO_THEME
	ADD CONSTRAINT SYS_C007583 FOREIGN KEY (PRONUM)
	REFERENCES HR.JADO_PROJECT (PRONUM)
;


ALTER TABLE HR.JADO_CHAT
	ADD CONSTRAINT SYS_C007584 FOREIGN KEY (THMNUM)
	REFERENCES HR.JADO_THEME (THMNUM)
;


ALTER TABLE HR.JADO_STORAGE
	ADD FOREIGN KEY (THMNUM)
	REFERENCES HR.JADO_THEME (THMNUM)
;


ALTER TABLE JADO_SCRAP
	ADD FOREIGN KEY (USERNUM)
	REFERENCES HR.JADO_USER (USERNUM)
;


ALTER TABLE HR.JADO_GANTMEMBER
	ADD CONSTRAINT SYS_C007585 FOREIGN KEY (USERNUM)
	REFERENCES HR.JADO_USER (USERNUM)
;


ALTER TABLE HR.JADO_MEMBER
	ADD CONSTRAINT SYS_C007586 FOREIGN KEY (USERNUM)
	REFERENCES HR.JADO_USER (USERNUM)
;


ALTER TABLE HR.JADO_PROJECT
	ADD CONSTRAINT SYS_C007587 FOREIGN KEY (USERNUM)
	REFERENCES HR.JADO_USER (USERNUM)
;

alter table jado_notice add constraint fk_notice_id foreign key(id)
references jado_user(id);

alter table jado_msg add constraint fk_receiver_msg foreign key(receiver)
references jado_user(id);

alter table jado_msg add constraint fk_sender2_msg foreign key(sender)
references jado_user(id)

drop sequence seq_user;
drop sequence seq_pro;
drop sequence seq_thm;
drop sequence seq_cht;

CREATE SEQUENCE seq_user INCREMENT BY 1 START WITH 1 MAXVALUE 999999999;

CREATE SEQUENCE seq_pro INCREMENT BY 1 START WITH 1 MAXVALUE 999999999;

CREATE SEQUENCE seq_thm INCREMENT BY 1 START WITH 1 MAXVALUE 999999999;

CREATE SEQUENCE seq_cht INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999999999999;


insert into jado_user (userNum,id,password,name ,googleId)				
	values ('U'||to_char(lpad(seq_user.nextval, 9, '0')),'asdf','asdf','asdf','asdf');
insert into jado_user (userNum,id,password,name ,googleId)				
	values ('U'||to_char(lpad(seq_user.nextval, 9, '0')),'qwer','qwer','qwer','qwer');
insert into jado_user (userNum,id,password,name ,googleId)				
	values ('U'||to_char(lpad(seq_user.nextval, 9, '0')),'zxcv','zxcv','zxcv','zxcv');
insert into jado_user (userNum,id,password,name ,googleId)				
	values ('U'||to_char(lpad(seq_user.nextval, 9, '0')),'1234','1234','1234','1234');

insert into jado_project (proNum,title,userNum)
	values ('P'||to_char(lpad(seq_pro.nextval, 9, '0')),'프로젝트1','U000000001');
insert into jado_project (proNum,title,userNum)
	values ('P'||to_char(lpad(seq_pro.nextval, 9, '0')),'프로젝트2','U000000003');

insert into jado_member (userNum,proNum,memNum,agreed)
	values ('U000000001','P000000001', concat('U000000001','P000000001'),'Y');
insert into jado_member (userNum,proNum,memNum,agreed)
	values ('U000000002','P000000001', concat('U000000002','P000000001'),'Y');
insert into jado_member (userNum,proNum,memNum,agreed)
	values ('U000000003','P000000001', concat('U000000003','P000000001'),'Y');
insert into jado_member (userNum,proNum,memNum,agreed)
	values ('U000000003','P000000002', concat('U000000003','P000000002'),'Y');
insert into jado_member (userNum,proNum,memNum,agreed)
	values ('U000000004','P000000002', concat('U000000004','P000000002'),'Y');
	
insert into jado_theme (thmNum,proNum,themeName)
	values ('T'||to_char(lpad(seq_thm.nextval, 9, '0')),'P000000001','채팅1-1');
insert into jado_theme (thmNum,proNum,themeName)
	values ('T'||to_char(lpad(seq_thm.nextval, 9, '0')),'P000000001','채팅1-2');
insert into jado_theme (thmNum,proNum,themeName)
	values ('T'||to_char(lpad(seq_thm.nextval, 9, '0')),'P000000002','채팅2-1');
insert into jado_theme (thmNum,proNum,themeName)
	values ('T'||to_char(lpad(seq_thm.nextval, 9, '0')),'P000000002','채팅2-2');


