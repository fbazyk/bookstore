package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Set;

public interface ReviewRepository extends JpaRepository<Review, Long> {
    public Set<Review> findAllByArticleTypeAndArticleId(ArticleType articleType, Long articleId);
    Set<Review> findAllByUserId(Long id);
}
