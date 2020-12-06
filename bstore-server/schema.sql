create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(id, article_id, article_type, rating, description, user_id) VALUES (2, 3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(id, article_id, article_type, rating, description, user_id) VALUES (2, 3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(id, article_id, article_type, rating, description, user_id) VALUES (2, 3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FKcgy7qjc1r99dp117y9en6lxye 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
create sequence hibernate_sequence start 1 increment 1

    create table books (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        author varchar(100),
        isbn varchar(255) not null,
        pages int8,
        primary key (id)
    )

    create table games (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        genre varchar(255),
        minage int8,
        publisher varchar(100),
        primary key (id)
    )

    create table generic_entity (
       id int8 not null,
        value varchar(255),
        primary key (id)
    )

    create table lps (
       id  bigserial not null,
        price numeric(19, 2) not null,
        supplier_id varchar(100) not null,
        title varchar(100) not null,
        artist varchar(100) not null,
        genre varchar(255),
        primary key (id)
    )

    create table order_item (
       id int8 not null,
        article_id int8,
        article_type varchar(255),
        price numeric(19, 2),
        quantity int8,
        order_id int8,
        primary key (id)
    )

    create table orders (
       order_id int8 not null,
        cart_date timestamp,
        order_date timestamp,
        order_total numeric(19, 2),
        user_id int8,
        primary key (order_id)
    )

    create table reviews (
       id  bigserial not null,
        article_id int8,
        article_type varchar(255),
        description varchar(255),
        rating int4,
        user_id int8,
        primary key (id)
    )

    create table users (
       id  bigserial not null,
        enabled boolean,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        password varchar(255),
        role varchar(255),
        username varchar(255),
        primary key (id)
    )

    alter table books 
       add constraint books_unique unique (isbn)

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item 
       add constraint FKt4dc2r9nbvbujrljv3e23iibt 
       foreign key (order_id) 
       references orders

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users

    alter table reviews 
       add constraint FK1li3ueh13an941teugj8bh2xb 
       foreign key (article_id) 
       references lps
create sequence hibernate_sequence start 1 increment 1

    create table books (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    author varchar(100),

    isbn varchar(255) not null,

    pages int8,

    primary key (id)

    )

    create table games (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    genre varchar(255),

    minage int8,

    publisher varchar(100),

    primary key (id)

    )

    create table generic_entity (
       

    id int8 not null,

    value varchar(255),

    primary key (id)

    )

    create table lps (
       

    id  bigserial not null,

    price numeric(19, 2) not null,

    supplier_id varchar(100) not null,

    title varchar(100) not null,

    artist varchar(100) not null,

    genre varchar(255),

    primary key (id)

    )

    create table order_item (
       

    id int8 not null,

    article_id int8,

    article_type varchar(255),

    price numeric(19, 2),

    quantity int8,

    order_id int8,

    primary key (id)

    )

    create table orders (
       

    order_id int8 not null,

    cart_date timestamp,

    order_date timestamp,

    order_total numeric(19, 2),

    user_id int8,

    primary key (order_id)

    )

    create table reviews (
       

    id  bigserial not null,

    article_id int8,

    article_type varchar(255),

    description varchar(255),

    rating int4,

    user_id int8,

    primary key (id)

    )

    create table users (
       

    id  bigserial not null,

    enabled boolean,

    first_name varchar(100) not null,

    last_name varchar(100) not null,

    password varchar(255),

    role varchar(255),

    username varchar(255),

    primary key (id)

    )

    alter table books

    add constraint books_unique unique (isbn)

    alter table users

    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table order_item

    add constraint FKt4dc2r9nbvbujrljv3e23iibt

    foreign key (order_id)

    references orders

    alter table orders

    add constraint FK32ql8ubntj5uh44ph9659tiih

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FKcgy7qjc1r99dp117y9en6lxye

    foreign key (user_id)

    references users

    alter table reviews

    add constraint FK1li3ueh13an941teugj8bh2xb

    foreign key (article_id)

    references lps
insert into users (username, enabled, first_name, last_name, role, password) values ('andy', true, 'Andy', 'Warhall', 'ADMIN', '$2y$10$s25xqwyrfniBLvLIJNwCHOo3h.A53CAy3EaGtGDrsUCHyH5YMiiu2')
insert into users (username, enabled, first_name, last_name, role, password) values ('soren', true, 'Soren', 'Kierkjegaard', 'USER', '$2y$10$mXSrKiM.ZLlLkCVyoV8JfOX/DB2XFRKyQkTW3DAKmsuRO/v4s22dC')
insert into books (price, supplier_id, title, author, isbn, pages) values ( 10, '399', 'Book1', 'Author1', '123', 200)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Book2', 'Author2', '1234', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Either/Or', 'Søren Kierkegaard', '12346', 300)
insert into books (price, supplier_id, title, author, isbn, pages) values ( 12, '399', 'Repetition', 'Soren Kierkegaard', '12345', 300)
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft', 'MMORPG', 12,  'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Cataclysm', 'MMORPG', 12, 'Blizzard Entertainment')
insert into games (price, supplier_id, title, genre, minage, publisher) VALUES (10, '323', 'World of Warcraft:Wrath of Lichy Kung', 'MMORPG', 12,  'Blizzard Entertainment')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Innuendo', 'Queen', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (15, '299', 'Dark Side Of The Moon', 'Pink Floyd', 'rock')
insert into lps (price, supplier_id, title, artist, genre) VALUES (13, '999', 'Dave Brubeck', 'Take Five', 'classic')
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (1, 'BOOK', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (2, 'LP', 10, 'Great Work!', 2)
insert into reviews(article_id, article_type, rating, description, user_id) VALUES (3, 'LP', 10, 'Great Work!', 1)
