package com.realdolmen.bookstore.model;

import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.Size;

@Entity
@Table(name = "games")
public class Game extends Article {

    @Column(name = "publisher")
    @Size(max = 100)
    private String publisher;

    @Column(name = "minage")
    private long minage;

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

    public long getMinage() {
        return minage;
    }

    public void setMinage(long min_age) {
        this.minage = min_age;
    }

    public GameGenre getGenre() {
        return genre;
    }

    public void setGenre(GameGenre genre) {
        this.genre = genre;
    }
}
