package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    Order findOrdersByOrderDateIsNullAndUser(User user);
    List<Order> findOrdersByOrderDateIsNull();
    List<Order> findOrdersByUserAndOrderDateIsNotNull(User user);

    Order findOrdersByUserAndId(User currentUser, Long id);
    List<Order> findOrdersByOrderDateIsNotNullAndShippingDateIsNull();
}
