create table jado_msg(
content varchar2(4000),
startDate date,
sender varchar2(100) not null,
receiver varchar2(100) not null,
isinvate varchar(4)
);
alter table jado_msg add constraint fk_receiver_msg foreign key(receiver)
references jado_user(id);

alter table jado_msg add constraint fk_sender2_msg foreign key(sender)
references jado_user(id)

