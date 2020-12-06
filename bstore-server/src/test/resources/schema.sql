create sequence hibernate_sequence start 1 increment 1;

create table books (
                       id  bigserial not null,
                       price numeric(19, 2) not null,
                       supplier_id varchar(100) not null,
                       title varchar(100) not null,
                       author varchar(100),
                       isbn varchar(255) not null,
                       pages int8,
                       primary key (id)
);

create table games (
                       id  bigserial not null,
                       price numeric(19, 2) not null,
                       supplier_id varchar(100) not null,
                       title varchar(100) not null,
                       genre varchar(255),
                       minage int8,
                       publisher varchar(100),
                       primary key (id)
);

create table generic_entity (
                                id int8 not null,
                                value varchar(255),
                                primary key (id)
);

create table lps (
                     id  bigserial not null,
                     price numeric(19, 2) not null,
                     supplier_id varchar(100) not null,
                     title varchar(100) not null,
                     artist varchar(100) not null,
                     genre varchar(255),
                     primary key (id)
);

create table order_item (
                            id int8 not null,
                            article_id int8,
                            article_type varchar(255),
                            price numeric(19, 2),
                            quantity int8,
                            order_id int8,
                            primary key (id)
);

create table orders (
                        order_id int8 not null,
                        cart_date timestamp,
                        order_date timestamp,
                        order_total numeric(19, 2),
                        user_id int8,
                        primary key (order_id)
);

create table reviews (
                         id  bigserial not null,
                         article_id int8,
                         article_type varchar(255),
                         description varchar(255),
                         rating int4,
                         user_id int8,
                         primary key (id)
);

create table users (
                       id  bigserial not null,
                       enabled boolean,
                       first_name varchar(100) not null,
                       last_name varchar(100) not null,
                       password varchar(255),
                       role varchar(255),
                       username varchar(255),
                       primary key (id)
);

alter table books
    add constraint books_unique unique (isbn);

alter table users
    add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username);

alter table order_item
    add constraint FKt4dc2r9nbvbujrljv3e23iibt
        foreign key (order_id)
            references orders;

alter table orders
    add constraint FK32ql8ubntj5uh44ph9659tiih
        foreign key (user_id)
            references users;

alter table reviews
    add constraint FKcgy7qjc1r99dp117y9en6lxye
        foreign key (user_id)
            references users;

alter table reviews
    add constraint FK1li3ueh13an941teugj8bh2xb
        foreign key (article_id)
            references lps;
