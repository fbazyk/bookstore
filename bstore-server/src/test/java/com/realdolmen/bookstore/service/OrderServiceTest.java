package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.BookstoreApplication;
import com.realdolmen.bookstore.dto.CartArticles;
import com.realdolmen.bookstore.dto.OrderItemDTO;
import com.realdolmen.bookstore.exception.QuantityNotAvailableException;
import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.OrderItem;
import com.realdolmen.bookstore.model.User;
import org.junit.jupiter.api.Test;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.concurrent.atomic.AtomicReference;

import static org.junit.jupiter.api.Assertions.*;

//@RunWith(SpringRunner.class)
@SpringBootTest(classes = BookstoreApplication.class)
@ContextConfiguration(classes = BookstoreApplication.class)
public class OrderServiceTest {

    Logger logger = LoggerFactory.getLogger(OrderServiceTest.class);

    @Autowired
    OrderService orderService;

    @Autowired
    UserService userService;

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    @DirtiesContext(methodMode = DirtiesContext.MethodMode.BEFORE_METHOD)
    void findOpenOrder() {
        //
        Order order = this.orderService.findOpenOrder();
        logger.debug("Order ID is: {}", order.getOrderId());
        assertNotNull(order);
    }

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    @DirtiesContext(methodMode = DirtiesContext.MethodMode.AFTER_METHOD)
    public void openOrderTest() {
        //
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();

        }
        User currentUser = this.userService.findByUserName(username);
        logger.debug("Current User: {}", currentUser);
        Order openOrder = this.orderService.openOrder(currentUser);
        logger.debug("Open Order Id = {}", openOrder.getOrderId());
//        try {
//            Thread.sleep(1000);
//        }catch (Exception ex){
//            logger.debug("Could not wait {}", ex.getMessage());
//        }
        assertTrue(openOrder.getCartDate().isBefore(Instant.now()));

    }

    @Test
    void calcTotal__oneArticle() {
        Order order = new Order();
        OrderItem orderItem = new OrderItem();
        orderItem.setPrice(BigDecimal.valueOf(10l));
        orderItem.setQuantity(1l);
        order.getOrderItems().add(orderItem);
        //TODO add some articles to the order
        BigDecimal orderTotal = this.orderService.calcTotal(order);
        assertEquals(BigDecimal.valueOf(10l), orderTotal);
    }
    @Test
    void calcTotal__twoArticles() {
        Order order = new Order();
        OrderItem orderItem = new OrderItem();
        orderItem.setPrice(BigDecimal.valueOf(10l));
        orderItem.setQuantity(1l);
        OrderItem orderItem2 = new OrderItem();
        orderItem2.setPrice(BigDecimal.valueOf(20l));
        orderItem2.setQuantity(5l);
        order.getOrderItems().add(orderItem);
        order.getOrderItems().add(orderItem2);
        BigDecimal orderTotal = this.orderService.calcTotal(order);
        assertEquals(BigDecimal.valueOf(110l), orderTotal);
    }



    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    void placeOrder__CorrectQuantity() {
        OrderItemDTO orderITemDTO = new OrderItemDTO(ArticleType.BOOK, 1l, 2l);
        Order result = null;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();

        }
        User currentUser = this.userService.findByUserName(username);
        //TODO create an order for the current user
        this.orderService.openOrder(currentUser);
        Order order = this.orderService.findOpenOrder();
        this.orderService.addUpdateOrderItem(orderITemDTO);

        try {
            result = this.orderService.placeOrder(currentUser);
        } catch (Exception ex) {
            logger.debug("Unable to place order {}", ex.getMessage());
        }
        assertNotNull(result);
    }

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    void placeOrder__WrongQuantity() {
        OrderItemDTO orderITemDTO = new OrderItemDTO(ArticleType.BOOK, 3l, 3l);
        AtomicReference<Order> result = null;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();

        }
        User currentUser = this.userService.findByUserName(username);
        //TODO create an order for the current user
        Order order = this.orderService.findOpenOrder();
        this.orderService.addUpdateOrderItem(orderITemDTO);

        assertThrows(QuantityNotAvailableException.class, () -> {
            result.set(this.orderService.placeOrder(currentUser));
        });
        assertNull(result);
    }

    @Test
    void emptyCart() {
    }

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    void saveOrder() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();

        }
        User currentUser = this.userService.findByUserName(username);
        Order order = new Order();
        order.setCartDate(Instant.now());
        order.setUser(currentUser);
        Order savedOrder = this.orderService.saveOrder(order);
        assertNotNull(savedOrder.getOrderId());
    }

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    @DirtiesContext(methodMode = DirtiesContext.MethodMode.BEFORE_METHOD)
    void addUpdateOrderItem() {
        OrderItemDTO orderITemDTO = new OrderItemDTO(ArticleType.BOOK, 1l, 2l);
        Order openOrder = this.orderService.findOpenOrder();
        this.orderService.addUpdateOrderItem(orderITemDTO);
        Order updatedOrder = this.orderService.findOpenOrder();
        logger.debug("Order Total: {}", openOrder.getOrderTotal());
        logger.debug("Updated Total: {}", updatedOrder.getOrderTotal());
        assertTrue(updatedOrder.getOrderItems().size() == 1);
    }

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    @DirtiesContext(methodMode = DirtiesContext.MethodMode.BEFORE_METHOD)
    void deleteOrderItem() {
        //add item
        OrderItemDTO orderITemDTO = new OrderItemDTO(ArticleType.BOOK, 1l, 2l);
        Order openOrder = this.orderService.findOpenOrder();
        this.orderService.addUpdateOrderItem(orderITemDTO);
        Order updatedOrder = this.orderService.findOpenOrder();
        logger.debug("Order Total: {}", openOrder.getOrderTotal());
        logger.debug("Updated Total: {}", updatedOrder.getOrderTotal());
        //check items size == 1
        assertTrue(updatedOrder.getOrderItems().size() == 1);

        //delete item
        try{
            this.orderService.deleteOrderItem("BOOK", 1l);
        } catch (Exception ex){
            logger.debug("Unable to delete: {}", ex.getMessage());
        }
        Order orderDeletedItem = this.orderService.findOpenOrder();
        //check items size == 0
        assertTrue(orderDeletedItem.getOrderItems().size() == 0);
    }

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    @DirtiesContext(methodMode = DirtiesContext.MethodMode.BEFORE_METHOD)
    public void getCartArticles(){
        OrderItemDTO oid = new OrderItemDTO(ArticleType.BOOK, 1l, 3l);
        this.orderService.addUpdateOrderItem(oid);
        CartArticles ca = this.orderService.getCartArticles(1l, 5l);
        assertEquals(1l, ca.getTotalArticles());

    }
}
