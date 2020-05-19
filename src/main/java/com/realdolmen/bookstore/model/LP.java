package com.realdolmen.bookstore.model;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "lps")
public class LP extends Article {

    @NotNull
    @Size(max = 100)
    private String artist;

    @Enumerated(EnumType.STRING)
    @Column(name = "genre")
    private LPGenre genre;

}
