package com.realdolmen.bookstore.model;

import javax.persistence.*;

@Entity
@Table(name = "reviews")
public class Review {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
}
