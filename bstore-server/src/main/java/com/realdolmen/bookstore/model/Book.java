package com.realdolmen.bookstore.model;


import org.hibernate.validator.constraints.ISBN;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

//TODO ISBN VALIDATOR https://stackoverflow.com/questions/37878992/custom-jpa-validation-in-spring-boot
// https://codereview.stackexchange.com/questions/133698/isbn-validation-with-hibernate-validator
@Entity
@Table(name = "books", uniqueConstraints={
        @UniqueConstraint( name = "books_unique",  columnNames ={"isbn"})
})
public class Book extends Article {

    @Size(max = 100)
    @Column(name = "author")
    private String author;

    @NotNull
    @ISBN
    @Column(name = "isbn", unique = true)
    private String isbn;

    @Column(name = "pages")
    private Long pages;

    public Book() {
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public Long getPages() {
        return pages;
    }

    public void setPages(Long pages) {
        this.pages = pages;
    }
}
