package com.realdolmen.bookstore;


import com.realdolmen.bookstore.model.*;
import com.realdolmen.bookstore.repository.ArticleRepository;
import com.realdolmen.bookstore.repository.BookRepository;
import com.realdolmen.bookstore.repository.OrderRepository;
import com.realdolmen.bookstore.repository.UserRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Date;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = BookstoreApplication.class)
@ContextConfiguration(classes = BookstoreApplication.class)
public class OrderTest {

    Logger logger = LoggerFactory.getLogger(OrderTest.class);

    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ArticleRepository articleRepository;

    @Autowired
    private BookRepository bookRepository;

    @Test
    public void createOrderTest(){
        Order order = new Order();
        order.setCartDate(Instant.now());
        User user = this.userRepository.getOne(1L);
        order.setUser(user);
        OrderItem item = new OrderItem();
        item.setArticleType(ArticleType.BOOK);
        item.setArticleId(1L);
        item.setQuantity(2L);
        Book book = this.bookRepository.getOne(item.getArticleId());
        item.setPrice(book.getPrice());
        order.addItem(item);
        BigDecimal orderTotal = new BigDecimal(0L);
        for(OrderItem orderItem: order.getOrderItems()){
            BigDecimal quantity = new BigDecimal(orderItem.getQuantity());
            orderTotal = orderTotal.add(orderItem.getPrice().multiply(quantity));
        }

        order.setOrderTotal(orderTotal);

        this.orderRepository.saveAndFlush(order);

        Order persistedOrder = this.orderRepository.getOne(1L);
        logger.debug( persistedOrder.getOrderItems().iterator().next().getId().toString());
        logger.debug( persistedOrder.getOrderItems().iterator().next().getPrice().toString());
        logger.debug( persistedOrder.getOrderTotal().toString());


    }
}
