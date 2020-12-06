package com.realdolmen.bookstore.exception;

import com.realdolmen.bookstore.model.OrderItem;

import java.util.Set;

public class QuantityNotAvailableException extends Exception{

    Set<OrderItem> itemSet;

    public QuantityNotAvailableException(String message) {
        super(message);
    }

    public QuantityNotAvailableException(String message, Set<OrderItem> items){
        super(message);
        this.itemSet = items;
    }

    public Set<OrderItem> getItemSet() {
        return itemSet;
    }
}
