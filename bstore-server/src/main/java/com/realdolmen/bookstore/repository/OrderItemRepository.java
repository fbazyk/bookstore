package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {

    public void deleteAllByArticleTypeAndArticleId(ArticleType type, Long id);
}
