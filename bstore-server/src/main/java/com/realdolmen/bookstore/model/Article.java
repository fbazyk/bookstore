package com.realdolmen.bookstore.model;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Set;

@JsonTypeInfo(use = JsonTypeInfo.Id.NAME,
        include = JsonTypeInfo.As.PROPERTY,
        property = "type")
@JsonSubTypes({
        @JsonSubTypes.Type(value = Book.class, name = "book"),
        @JsonSubTypes.Type(value = Game.class, name = "game"),
        @JsonSubTypes.Type(value = LP.class, name = "lp"),
})
@MappedSuperclass
public class Article {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Size(max = 100)
    private String title;

    @NotNull
    private BigDecimal price;

    @NotNull
    @Column
    @Size(max=100)
    private String supplierId;

    public Set<Review> getReviews() {
        return reviews;
    }

    public void setReviews(Set<Review> reviews) {
        this.reviews = reviews;
    }

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval=true)
    @JoinColumn(name = "articleId")
    private Set<Review> reviews;

    public Article() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }
}
