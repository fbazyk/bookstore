create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
alter table books add constraint books_unique unique (isbn)
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255) not null, primary key (id))
alter table books add constraint books_unique unique (isbn)
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255) not null, primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role)
values ('Human', 'Being', 'ADMIN')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255) not null, primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role)
values ('Human', 'Being', 'ADMIN')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role)
values ('Human', 'Being', 'admin')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table customers (id int8 not null, firstname varchar(255), lastname varchar(255), primary key (id))
create table games (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, genre varchar(255), min_age int8, publisher varchar(100), primary key (id))
create table lps (id  bigserial not null, price numeric(19, 2) not null, supplier_id varchar(100) not null, title varchar(100) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table reviews (id  bigserial not null, primary key (id))
create table users (id  bigserial not null, first_name varchar(100) not null, last_name varchar(100) not null, role varchar(255), primary key (id))
alter table books add constraint books_unique unique (isbn)
insert into users (first_name, last_name, role) values ('Human', 'Being', 'admin')
insert into users (first_name, last_name, role) values ('Namuh', 'Gnieb', 'user')
