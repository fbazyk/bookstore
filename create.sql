create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id));
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), minage int8, publisher varchar(100), primary key (id));
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id));
create table reviews (id  bigserial not null, primary key (id));
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id));
alter table books add constraint books_unique unique (isbn);
CREATE EXTENSION unaccent;
