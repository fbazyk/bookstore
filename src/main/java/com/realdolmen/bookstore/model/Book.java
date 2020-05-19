package com.realdolmen.bookstore.model;

import javax.persistence.*;

@Entity
@Table(name = "books")
public class Book extends Article {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
}
