package com.realdolmen.bookstore.model;

import com.fasterxml.jackson.annotation.JsonBackReference;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "ORDERS")
public class Order {

    @Id
    @GeneratedValue
    private Long orderId;

    @OneToMany(cascade = CascadeType.ALL,
            fetch = FetchType.LAZY,
            orphanRemoval=true)
    @JoinColumn(name = "ORDER_ID")
    private Set<OrderItem> orderItems;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID")
    @JsonBackReference
    private User user;

    @Column
    private Instant cartDate;

    @Column
    private Instant orderDate;

    @Column
    private BigDecimal orderTotal;

    public Set<OrderItem> addItem(OrderItem item){
        if(this.orderItems == null){
            this.orderItems = new HashSet<>();
            this.orderItems.add(item);
        }else {
            this.orderItems.add(item);
        }
        return this.orderItems;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Set<OrderItem> getOrderItems() {
        if(orderItems == null){
            orderItems = new HashSet<>();
        }
        return orderItems;
    }

    public void setOrderItems(Set<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public Instant getCartDate() {
        return cartDate;
    }

    public void setCartDate(Instant cartDate) {
        this.cartDate = cartDate;
    }

    public Instant getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Instant orderDate) {
        this.orderDate = orderDate;
    }

    public BigDecimal getOrderTotal() {
        return orderTotal;
    }

    public void setOrderTotal(BigDecimal orderTotal) {
        this.orderTotal = orderTotal;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
