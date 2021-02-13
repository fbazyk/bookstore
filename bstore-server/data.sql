insert into address(city, country, number, postcode, street) values ('København', 'Denmark', '1', '1218', 'Proviantpassagen');
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2');
insert into users (username, enabled, first_name, last_name, role, password, address_id) values ('soren', true, 'Soren', 'Kierkegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC', 1);
insert into storage_location(code, level, row, segment) values ('111', '1', '1', '1');
insert into books (price, supplier_id, title, search_title, author, isbn, pages, location_id) values ( 10, '399', 'Book1', 'book1author1', 'Author1', '0525564454', 200, 1);insert into books (price, supplier_id, title, search_title, author, isbn, pages, location_id) values ( 12, '399', 'Book2', 'book2author2', 'Author2', '978-0140445770', 300, 1);
insert into books (price, supplier_id, title, search_title, author, isbn, pages, location_id) values ( 12, '399', 'The Myth of Sisyphus', 'themythofsisyphusalbertcamus', 'Albert Camus', '978-0525564454', 300, 1);
insert into books (price, supplier_id, title, search_title, author, isbn, pages, location_id) values ( 12, '399', 'Either/Or', 'eitherorsorenkierkegaard', 'Søren Kierkegaard', '0140445770', 300, 1);
insert into books (price, supplier_id, title, search_title, author, isbn, pages, location_id) values ( 12, '399', 'Repetition', 'repetitionsorenkierkegaard', 'Soren Kierkegaard', '0199214190', 300, 1);
insert into books (price, supplier_id, title, search_title, author, isbn, pages, location_id) values ( 50, '399', 'OCA / OCP Java SE 8 Programmer Certification Kit: Exam 1Z0-808 and Exam 1Z0-809 1st Edition', 'ocaocpjavase8programmercertificationkitexam1z0-808andexam1z0-8091steditionjeanneboyarsky', 'Jeanne Boyarsky', '1118957407', 300, 1);
insert into books (price, supplier_id, title, search_title, author, isbn, pages, location_id) values ( 35, '399', 'OCA: Oracle Certified Associate Java SE 8 Programmer I Study Guide: Exam 1Z0-808', 'ocaoraclecertifiedassociatejavase8programmeristudyguideexam1z0808jeanneboyarsky', 'Jeanne Boyarsky', '1119272092', 300, 1);
insert into games (price, supplier_id, title, search_title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'worldofwarcraftblizzardentertainment', 'MMORPG', 12,  'Blizzard Entertainment');
insert into games (price, supplier_id, title, search_title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'worldofwarcraftcataclysm', 'MMORPG', 12, 'Blizzard Entertainment');
insert into games (price, supplier_id, title, search_title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'worldofwarcraftwrathoflichykung', 'MMORPG', 12,  'Blizzard Entertainment');
insert into games (price, supplier_id, title, search_title, genre, minage, publisher) VALUES (50, '424', 'Cyberpunk 2077', 'cyberpunk2077cdprojekt', 'RPG', 18,  'CD Projekt');
insert into lps (price, supplier_id, title, search_title, artist, genre) VALUES (15, '299', 'Innuendo', 'innuendoqueen', 'Queen', 'rock');
insert into lps (price, supplier_id, title, search_title, artist, genre) VALUES (10, '299', 'Oasis of The Wind', 'oasisofthewindtakashikokubo', 'Takashi Kokubo', 'newage');
insert into lps (price, supplier_id, title, search_title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'darksideofthemoonpinkfloyd', 'Pink Floyd', 'rock');
insert into lps (price, supplier_id, title, search_title, artist, genre) VALUES (15, '299', 'M.O.J.O', 'mojonewtownkings', 'New Town Kings', 'ska');
insert into lps (price, supplier_id, title, search_title, artist, genre) VALUES (15, '299', 'Reach Out', 'reachoutnewtownkings', 'New Town Kings', 'ska');
insert into lps (price, supplier_id, title, search_title, artist, genre) VALUES (15, '299', 'Naixen Primaveres', 'naixenprimaveresaspencat', 'Aspencat', 'ska');
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2);
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2);
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1);
insert into orders(order_id, cart_date, order_date, shipping_date, order_total, user_id) VALUES (1, '2021-01-28 21:32:44.059699', '2021-01-28 21:32:44.059699', null, 10, 2);
insert into order_item(id, article_id, article_type, price, quantity, order_id) values (1, 1, 'BOOK', 10, 1, 1);
