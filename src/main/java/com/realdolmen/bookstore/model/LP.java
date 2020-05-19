package com.realdolmen.bookstore.model;

import javax.persistence.*;

@Entity
@Table(name = "lps")
public class LP extends Article {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
}
