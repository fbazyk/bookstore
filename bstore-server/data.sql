insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2');
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC');
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200);
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300);
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300);
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300);
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment');
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment');
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment');
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock');
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock');
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic');
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2);
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2);
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1);