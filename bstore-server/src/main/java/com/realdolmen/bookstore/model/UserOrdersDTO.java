package com.realdolmen.bookstore.model;

import java.util.List;

public class UserOrdersDTO {
    List<Order> orderList;

    public List<Order> getOrderList() {
        return orderList;
    }

    public void setOrderList(List<Order> orderList) {
        this.orderList = orderList;
    }
}
