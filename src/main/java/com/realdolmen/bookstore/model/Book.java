package com.realdolmen.bookstore.model;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "books", uniqueConstraints={
        @UniqueConstraint( name = "books_unique",  columnNames ={"isbn"})
})
public class Book extends Article {



    @Size(max = 100)
    @Column(name = "author")
    private String author;

    @NotNull
    @Column(name = "isbn")
    private String isbn;

    @Column(name = "pages")
    private Long pages;


}
