package com.realdolmen.bookstore.model;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
public class OrderItem {

    @Id
    @GeneratedValue
    private Long id;

    @Column
    private Long articleId;

    @Column
    private BigDecimal price;

    @Column
    private Long quantity;
}
