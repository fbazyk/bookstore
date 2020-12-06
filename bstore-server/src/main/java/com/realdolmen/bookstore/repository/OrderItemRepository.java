package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
}
