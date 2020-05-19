package com.realdolmen.bookstore.model;

import javax.persistence.*;

@Entity
@Table(name = "games")
public class Game extends Article {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
}
