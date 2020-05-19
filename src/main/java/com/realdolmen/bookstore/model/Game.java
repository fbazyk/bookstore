package com.realdolmen.bookstore.model;

import javax.persistence.*;
import javax.validation.constraints.Size;

@Entity
@Table(name = "games")
public class Game extends Article {

    @Column(name = "publisher")
    @Size(max = 100)
    private String publisher;

    @Column(name = "min_age")
    private long min_age;

    @Enumerated(EnumType.STRING)
    @Column(name = "genre")
    private GameGenre genre;

}
