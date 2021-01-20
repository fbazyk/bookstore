package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.OrderItem;
import com.realdolmen.bookstore.model.OrderItemReportDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {

    public void deleteAllByArticleTypeAndArticleId(ArticleType type, Long id);
}
