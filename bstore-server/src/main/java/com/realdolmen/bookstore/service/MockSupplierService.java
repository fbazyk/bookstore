package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.controller.ArticleController;
import com.realdolmen.bookstore.exception.QuantityNotAvailableException;
import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.OrderItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.Set;
import java.util.stream.Collectors;

@Component
public class MockSupplierService {

    Logger logger = LoggerFactory.getLogger(MockSupplierService.class);

    /**
     *◦ When placing an order,
     *  the quantity of each article
     *  should be forwarded to a Mock Supplier Service
     *◦ If an exception is thrown when forwarding an order of a specific article
     *  This article should be removed of the order and an error message should be shown.
     *  (Mock this by throwing an exception when the quantity is a multiple of 3)
     * */
    public boolean placeOrder(Order order) throws Exception{
        Order processingOrder = order;

        Set<OrderItem> itemsQuantity3 = order.getOrderItems().stream().filter(orderItem -> {
            return orderItem.getQuantity() % 3 == 0;
        }).collect(Collectors.toSet());
        if(itemsQuantity3.size()>0){

            throw new QuantityNotAvailableException("Some items are not available", itemsQuantity3);
        } else {
            RestTemplate restTemplate = new RestTemplate();
            String mockSupplierURL
                    = "http://localhost:8089/supplier/order";
            HttpEntity<Order> request = new HttpEntity<>(processingOrder);
            String result = restTemplate.postForObject(mockSupplierURL, request, String.class);
            logger.debug("PLACE ORDER::All items are ordered {}", result);
            return true;
        }
    }
}
