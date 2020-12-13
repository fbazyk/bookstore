create sequence hibernate_sequence start 1 increment 1

create table books (


                       id  bigserial not null,
                       created_by varchar(255),
                       created_on timestamp,

                       updated_by varchar(255),

                       updated_on timestamp,

                       price numeric(19, 2) not null,

                       search_title varchar(255),

                       supplier_id varchar(100) not null,

                       title varchar(255) not null,

                       version int4,

                       author varchar(100),

                       isbn varchar(255) not null,

                       pages int8,

                       primary key (id)

)

create table games (


                       id  bigserial not null,
                       created_by varchar(255),
                       created_on timestamp,

                       updated_by varchar(255),

                       updated_on timestamp,

                       price numeric(19, 2) not null,

                       search_title varchar(255),

                       supplier_id varchar(100) not null,

                       title varchar(255) not null,

                       version int4,

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
                     created_by varchar(255),
                     created_on timestamp,

                     updated_by varchar(255),

                     updated_on timestamp,

                     price numeric(19, 2) not null,

                     search_title varchar(255),

                     supplier_id varchar(100) not null,

                     title varchar(255) not null,

                     version int4,

                     artist varchar(100) not null,

                     genre varchar(255),

                     primary key (id)

)

create table order_item (


                            id int8 not null,

                            article_id int8,

                            article_type varchar(255),
                            created_by varchar(255),
                            created_on timestamp,

                            updated_by varchar(255),

                            updated_on timestamp,

                            price numeric(19, 2),

                            quantity int8,

                            version int4,

                            order_id int8,

                            primary key (id)

)

create table orders (


                        order_id int8 not null,
                        created_by varchar(255),
                        created_on timestamp,

                        updated_by varchar(255),

                        updated_on timestamp,

                        cart_date timestamp,

                        order_date timestamp,

                        order_total numeric(19, 2),

                        version int4,

                        user_id int8,

                        primary key (order_id)

)

create table reviews (


                         id  bigserial not null,

                         article_id int8,

                         article_type varchar(255),
                         created_by varchar(255),
                         created_on timestamp,

                         updated_by varchar(255),

                         updated_on timestamp,

                         description varchar(255),

                         rating int4,

                         user_id int8,

                         version int4,

                         primary key (id)

)

create table users (


                       id  bigserial not null,
                       created_by varchar(255),
                       created_on timestamp,

                       updated_by varchar(255),

                       updated_on timestamp,

                       enabled boolean,

                       first_name varchar(100) not null,

                       last_name varchar(100) not null,

                       password varchar(255),

                       role varchar(255),

                       username varchar(255),

                       version int4,

                       primary key (id)

)

create table users_favorite_books (


                                      user_id int8 not null,

                                      favorite_books_id int8 not null,

                                      primary key (user_id, favorite_books_id)

)

create table users_favorite_games (


                                      user_id int8 not null,

                                      favorite_games_id int8 not null,

                                      primary key (user_id, favorite_games_id)

)

create table users_favorite_lps (


                                    user_id int8 not null,

                                    favorite_lps_id int8 not null,

                                    primary key (user_id, favorite_lps_id)

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

alter table users_favorite_books

    add constraint FK4ws24swp37m2husfd3a0hk4ia

        foreign key (favorite_books_id)

            references books

alter table users_favorite_books

    add constraint FKri1qgsos75704kfd7wylun5kg

        foreign key (user_id)

            references users

alter table users_favorite_games

    add constraint FK6w6cc5d6w0dhlxsuxnhrwrbxj

        foreign key (favorite_games_id)

            references games

alter table users_favorite_games

    add constraint FKmwhmaosfoa3gulfr4mpm7akwj

        foreign key (user_id)

            references users

alter table users_favorite_lps

    add constraint FKfkrftqcrsc8eals21vvw6tdc

        foreign key (favorite_lps_id)

            references lps

alter table users_favorite_lps

    add constraint FKkvvvh03rrkdjp6qig2rdtlbcj

        foreign key (user_id)

            references users
