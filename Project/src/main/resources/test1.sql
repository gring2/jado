
/* Drop Tables */

DROP TABLE JADO_VOTE CASCADE CONSTRAINTS;
DROP TABLE JADO_CHAT CASCADE CONSTRAINTS;
DROP TABLE JADO_GANTMEMBER CASCADE CONSTRAINTS;
DROP TABLE JADO_GANTCHART CASCADE CONSTRAINTS;
DROP TABLE JADO_STORAGE CASCADE CONSTRAINTS;
DROP TABLE JADO_MEMBER CASCADE CONSTRAINTS;
DROP TABLE JADO_THEME CASCADE CONSTRAINTS;
DROP TABLE JADO_PROJECT CASCADE CONSTRAINTS;
DROP TABLE JADO_USER CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE JADO_CHAT
(
	chatNum varchar2(20) NOT NULL,
	content varchar2(4000) NOT NULL,
	chatType varchar2(10),
	startDate date,
	chatDate date DEFAULT sysdate NOT NULL,
	memNum varchar2(20) NOT NULL,
	thmNum varchar2(10) NOT NULL,
	PRIMARY KEY (chatNum)
);


CREATE TABLE JADO_GANTCHART
(
	gantNum varchar2(13) NOT NULL,
	todo varchar2(100) NOT NULL,
	proNum varchar2(10) NOT NULL,
	PRIMARY KEY (gantNum)
);


CREATE TABLE JADO_GANTMEMBER
(
	userNum varchar2(10) NOT NULL,
	gantNum varchar2(13) NOT NULL,
	startDate date NOT NULL,
	duration number(3) NOT NULL
);


CREATE TABLE JADO_MEMBER
(
	memNum varchar2(20) NOT NULL,
	userNum varchar2(10) NOT NULL,
	proNum varchar2(10) NOT NULL,
	agreed char DEFAULT 'N' NOT NULL,
	PRIMARY KEY (memNum)
);


CREATE TABLE JADO_PROJECT
(
	proNum varchar2(10) NOT NULL,
	title varchar2(100) NOT NULL,
	startDate date DEFAULT sysdate NOT NULL,
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

insert into jado_project (proNum,title)
	values ('P'||to_char(lpad(seq_pro.nextval, 9, '0')),'프로젝트1');
insert into jado_project (proNum,title)
	values ('P'||to_char(lpad(seq_pro.nextval, 9, '0')),'프로젝트2');

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


	


