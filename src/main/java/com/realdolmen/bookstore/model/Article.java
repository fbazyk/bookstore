package com.realdolmen.bookstore.model;

import org.springframework.data.annotation.Id;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;

@MappedSuperclass
@Table(name="articles")
public class Article {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Size(max = 100)
    @Column(unique = true)
    private String title;

    @NotNull
    @Column(unique = true)
    private BigDecimal price;

    @NotNull
    @Column
    @Size(max=100)
    private String supplierId;
}
