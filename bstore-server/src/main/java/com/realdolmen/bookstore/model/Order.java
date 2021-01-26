package com.realdolmen.bookstore.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.realdolmen.bookstore.service.AuditListener;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "ORDERS")
@EntityListeners(AuditListener.class)
public class Order implements Auditable{

    @Id
    @GeneratedValue
    private Long orderId;

    @OneToMany(cascade = CascadeType.ALL,
            fetch = FetchType.LAZY,
            orphanRemoval=true)
    @JoinColumn(name = "order_id")
    private Set<OrderItem> orderItems;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID")
    @JsonBackReference
    private User user;


    @Version
    private Integer version;

    @Column
    private Instant cartDate;

    @Column
    private Instant orderDate;

    @Column
    private BigDecimal orderTotal;

    @Column(name = "shipping_date")
    private Instant shippingDate;

    @Embedded
    private Audit audit;

    public Audit getAudit() {
        return audit;
    }

    public void setAudit(Audit audit) {
        this.audit = audit;
    }

    public Set<OrderItem> addItem(OrderItem item){
        if(this.orderItems == null){
            this.orderItems = new HashSet<>();
            this.orderItems.add(item);
        }else {
            this.orderItems.add(item);
        }
        return this.orderItems;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
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

    public Instant getShippingDate() {
        return shippingDate;
    }

    public void setShippingDate(Instant shippingDate) {
        this.shippingDate = shippingDate;
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
