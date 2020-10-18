package com.realdolmen.bookstore.model;

import javax.persistence.*;
import java.time.Instant;
import java.util.Set;

@Entity
@Table(name = "ORDERS")
public class Order {

    @Id
    @GeneratedValue
    private Long orderId;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "ORDER_ID")
    private Set<OrderItem> orderItems;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @ManyToOne
    @JoinColumn(name = "USER_ID")
    private User user;

    @Column
    private Instant cartDate;

    @Column
    private Instant orderDate;
}
