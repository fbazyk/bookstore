package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Long> {
    Order findOrdersByOrderDateIsNullAndUser(User user);
}
