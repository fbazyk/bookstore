package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.repository.OrderRepository;
import com.realdolmen.bookstore.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.time.Instant;

@Component
public class OrderService {

    private OrderRepository orderRepository;
    private UserService userService;

    Logger logger = LoggerFactory.getLogger(OrderService.class);

    public OrderService(OrderRepository orderRepository,
                        UserService userService) {
        this.orderRepository = orderRepository;
        this.userService = userService;
    }

    public Order findOpenOrder() {
        //TODO find an order where cart date <= LocalDate.now() && orderDate == null
        Object principal = SecurityContextHolder.getContext().getAuthentication(). getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();

        }
        logger.debug(username);
        User foundUser = this.userService.findByUserName(username);

        Order openOrder = this.orderRepository.findOrdersByOrderDateIsNullAndUser(foundUser);
        if(openOrder == null){
            openOrder = new Order();
            openOrder.setUser(foundUser);
            openOrder.setCartDate(Instant.now());
        }
        return openOrder;
    }


    public void saveOrder(Order openOrder) {
        this.orderRepository.saveAndFlush(openOrder);
    }
}
