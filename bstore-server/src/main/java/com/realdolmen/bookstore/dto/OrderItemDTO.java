package com.realdolmen.bookstore.dto;

import com.realdolmen.bookstore.model.ArticleType;

import javax.persistence.criteria.CriteriaBuilder;

public class OrderItemDTO {
    private ArticleType articleType;
    private Long articleId;
    private Long quantity;

    public OrderItemDTO(ArticleType articleType, Long articleId, Long quantity) {
        this.articleType = articleType;
        this.articleId = articleId;
        this.quantity = quantity;
    }

    public Long getQuantity() {
        return quantity;
    }

    public ArticleType getArticleType() {
        return articleType;
    }

    public Long getArticleId() {
        return articleId;
    }
}
