create sequence hibernate_sequence start 1 increment 1
create table books (id  bigserial not null, created_by varchar(255), created_on timestamp, updated_by varchar(255), updated_on timestamp, deleted boolean default false, price numeric(19, 2) not null, search_title varchar(255), supplier_id varchar(100) not null, title varchar(255) not null, author varchar(100), isbn varchar(255) not null, pages int8, primary key (id))
create table games (id  bigserial not null, created_by varchar(255), created_on timestamp, updated_by varchar(255), updated_on timestamp, deleted boolean default false, price numeric(19, 2) not null, search_title varchar(255), supplier_id varchar(100) not null, title varchar(255) not null, genre varchar(255), minage int8, publisher varchar(100), primary key (id))
create table generic_entity (id int8 not null, value varchar(255), primary key (id))
create table lps (id  bigserial not null, created_by varchar(255), created_on timestamp, updated_by varchar(255), updated_on timestamp, deleted boolean default false, price numeric(19, 2) not null, search_title varchar(255), supplier_id varchar(100) not null, title varchar(255) not null, artist varchar(100) not null, genre varchar(255), primary key (id))
create table order_item (id int8 not null, article_id int8, article_type varchar(255), created_by varchar(255), created_on timestamp, updated_by varchar(255), updated_on timestamp, price numeric(19, 2), quantity int8, version int4, order_id int8, primary key (id))
create table orders (order_id int8 not null, created_by varchar(255), created_on timestamp, updated_by varchar(255), updated_on timestamp, cart_date timestamp, order_date timestamp, order_total numeric(19, 2), version int4, user_id int8, primary key (order_id))
create table reviews (id  bigserial not null, article_id int8, article_type varchar(255), created_by varchar(255), created_on timestamp, updated_by varchar(255), updated_on timestamp, description varchar(255), rating int4, user_id int8, primary key (id))
create table users (id  bigserial not null, enabled boolean, first_name varchar(100) not null, last_name varchar(100) not null, password varchar(255), role varchar(255), username varchar(255), primary key (id))
create table users_favorite_books (user_id int8 not null, favorite_books_id int8 not null, primary key (user_id, favorite_books_id))
create table users_favorite_games (user_id int8 not null, favorite_games_id int8 not null, primary key (user_id, favorite_games_id))
create table users_favorite_lps (user_id int8 not null, favorite_lps_id int8 not null, primary key (user_id, favorite_lps_id))
alter table books add constraint UK_kibbepcitr0a3cpk3rfr7nihn unique (isbn)
alter table users add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)
alter table order_item add constraint FKt4dc2r9nbvbujrljv3e23iibt foreign key (order_id) references orders
alter table orders add constraint FK32ql8ubntj5uh44ph9659tiih foreign key (user_id) references users
alter table reviews add constraint FK1li3ueh13an941teugj8bh2xb foreign key (article_id) references lps
alter table users_favorite_books add constraint FK4ws24swp37m2husfd3a0hk4ia foreign key (favorite_books_id) references books
alter table users_favorite_books add constraint FKri1qgsos75704kfd7wylun5kg foreign key (user_id) references users
alter table users_favorite_games add constraint FK6w6cc5d6w0dhlxsuxnhrwrbxj foreign key (favorite_games_id) references games
alter table users_favorite_games add constraint FKmwhmaosfoa3gulfr4mpm7akwj foreign key (user_id) references users
alter table users_favorite_lps add constraint FKfkrftqcrsc8eals21vvw6tdc foreign key (favorite_lps_id) references lps
alter table users_favorite_lps add constraint FKkvvvh03rrkdjp6qig2rdtlbcj foreign key (user_id) references users
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, search_title, author, isbn, pages) values ( 10, '399', 'Book1', 'book1author1', 'Author1', '0525564454', 200)
insert into books (price, supplier_id, title, search_title, author, isbn, pages) values ( 12, '399', 'Book2', 'book2author2', 'Author2', '978-0140445770', 300)
insert into books (price, supplier_id, title, search_title, author, isbn, pages) values ( 12, '399', 'The Myth of Sisyphus', 'themythofsisyphusalbertcamus', 'Albert Camus', '978-0525564454', 300)
insert into books (price, supplier_id, title, search_title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'eitherorsorenkierkegaard', 'Søren Kierkegaard', '0140445770', 300)
insert into books (price, supplier_id, title, search_title, author, isbn, pages) values ( 12, '399', 'Repetition', 'repetitionsorenkierkegaard', 'Soren Kierkegaard', '0199214190', 300)
insert into books (price, supplier_id, title, search_title, author, isbn, pages) values ( 50, '399', 'OCA / OCP Java SE 8 Programmer Certification Kit: Exam 1Z0-808 and Exam 1Z0-809 1st Edition', 'ocaocpjavase8programmercertificationkitexam1z0-808andexam1z0-8091steditionjeanneboyarsky', 'Jeanne Boyarsky', '1118957407', 300)
insert into books (price, supplier_id, title, search_title, author, isbn, pages) values ( 35, '399', 'OCA: Oracle Certified Associate Java SE 8 Programmer I Study Guide: Exam 1Z0-808', 'ocaoraclecertifiedassociatejavase8programmeristudyguideexam1z0808jeanneboyarsky', 'Jeanne Boyarsky', '1119272092', 300)
insert into games (price, supplier_id, title, search_title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'worldofwarcraftblizzardentertainment', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, search_title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'worldofwarcraftcataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, search_title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'worldofwarcraftwrathoflichykung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, search_title, genre, minage, publisher) VALUES (50, '424', 'Cyberpunk 2077', 'cyberpunk2077cdprojekt', 'RPG', 18,  'CD Projekt')
insert into lps (price, supplier_id, title, search_title, artist, genre) VALUES (15, '299', 'Innuendo', 'innuendoqueen', 'Queen', 'rock')
insert into lps (price, supplier_id, title, search_title, artist, genre) VALUES (10, '299', 'Oasis of The Wind', 'oasisofthewindtakashikokubo', 'Takashi Kokubo', 'newage')
insert into lps (price, supplier_id, title, search_title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'darksideofthemoonpinkfloyd', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, search_title, artist, genre) VALUES (15, '299', 'M.O.J.O', 'mojonewtownkings', 'New Town Kings', 'ska')
insert into lps (price, supplier_id, title, search_title, artist, genre) VALUES (15, '299', 'Reach Out', 'reachoutnewtownkings', 'New Town Kings', 'ska')
insert into lps (price, supplier_id, title, search_title, artist, genre) VALUES (15, '299', 'Naixen Primaveres', 'naixenprimaveresaspencat', 'Aspencat', 'ska')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
