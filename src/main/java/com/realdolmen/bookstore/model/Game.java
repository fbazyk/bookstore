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

    public Game() {
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public long getMin_age() {
        return min_age;
    }

    public void setMin_age(long min_age) {
        this.min_age = min_age;
    }

    public GameGenre getGenre() {
        return genre;
    }

    public void setGenre(GameGenre genre) {
        this.genre = genre;
    }
}
