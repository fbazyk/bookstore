package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.BookstoreApplication;
import com.realdolmen.bookstore.exception.QuantityNotAvailableException;
import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.OrderItem;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import java.math.BigDecimal;
import java.time.Instant;

import static org.junit.jupiter.api.Assertions.*;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = BookstoreApplication.class)
@ContextConfiguration(classes = BookstoreApplication.class)
public class MockSupplierServiceTest {

    @Autowired
    MockSupplierService mockSupplierService;

    public MockSupplierServiceTest() {
    }

    @Test
    public void placeOrder__IncorrectQuantity__ThrowError(){
        //Set up the order
        Order order = new Order();
        order.setCartDate(Instant.now());
        order.setOrderDate(Instant.now());
        OrderItem orderItem = new OrderItem();
        orderItem.setQuantity(3l);
        orderItem.setArticleType(ArticleType.BOOK);
        orderItem.setArticleId(1l);
        orderItem.setPrice(BigDecimal.valueOf(10l));
        order.getOrderItems().add(orderItem);
        //pass the order to the place order method
        assertThrows(QuantityNotAvailableException.class, () -> {
            this.mockSupplierService.placeOrder(order);
        });
    }

}
