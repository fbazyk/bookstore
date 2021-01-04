package com.realdolmen.bookstore.dto;

import com.realdolmen.bookstore.model.ArticleType;

public class AddReviewDTO {
    private ArticleType articleType;
    private Long articleId;
    private Integer rating;
    private String description;

    public AddReviewDTO(ArticleType articleType, Long articleId, Integer rating, String description) {
        this.articleType = articleType;
        this.articleId = articleId;
        this.rating = rating;
        this.description = description;
    }

    public ArticleType getArticleType() {
        return articleType;
    }

    public Long getArticleId() {
        return articleId;
    }

    public Integer getRating() {
        return rating;
    }

    public String getDescription() {
        return description;
    }
}
