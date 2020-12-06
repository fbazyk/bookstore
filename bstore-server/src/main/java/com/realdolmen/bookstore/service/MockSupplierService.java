package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.controller.ArticleController;
import com.realdolmen.bookstore.exception.QuantityNotAvailableException;
import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.OrderItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Set;
import java.util.stream.Collectors;

@Component
public class MockSupplierService {

    Logger logger = LoggerFactory.getLogger(MockSupplierService.class);

    /**
     *◦ When placing an order,
     *  the quantity of the each ordered article
     *  should be forwarded to a Mock Supplier Service
     *◦ If an exception is thrown when forwarding an order of a specific article
     *  This article should be removed of the order and an error message should be shown. (Mock this by throwing an exception when the quantity is a multiple of 3)
     * */
    public void placeOrder(Order order) throws Exception{
        Order processingOrder = order;

        Set<OrderItem> itemsQuantity3 = order.getOrderItems().stream().filter(orderItem -> {
            return orderItem.getQuantity() % 3 == 0;
        }).collect(Collectors.toSet());
        if(itemsQuantity3.size()>0){

            throw new QuantityNotAvailableException("Some items are not available", itemsQuantity3);
        } else {
            logger.debug("PLACE ORDER::All items are ordered");
        }
    }
}
