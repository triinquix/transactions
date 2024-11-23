create sequence sq_clients;

create table clients (
 id number not null,
 name varchar2(30) not null,
 surname varchar2(50) not null,
 constraint clients_pk PRIMARY KEY (id)
);

create sequence sq_transactions;


create table transactions (
 id number not null,
 client_id number not null,
 type number not null,
 tran_sum number not null,
 tr_date date not null,
 constraint pk_transactions primary key(id),
 constraint fk_clients foreign key(client_id) references clients(id)
);


