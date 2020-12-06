package com.realdolmen.bookstore.model;

import javax.persistence.*;

@Entity
@Table(name = "reviews")
public class Review {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @Column
    private Integer rating;

    @Column
    private String description;

    @Column(name = "USER_ID")
    private Long userId;

    @Column
    @Enumerated(EnumType.STRING)
    private ArticleType articleType;

    @Column
    private Long articleId;

    public Review() {
    }

    public Review(ArticleType articleType, Long articleId, Long userId) {
        this.articleType = articleType;
        this.articleId = articleId;
        this.userId = userId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public ArticleType getArticleType() {
        return articleType;
    }

    public void setArticleType(ArticleType articleType) {
        this.articleType = articleType;
    }

    public Long getArticleId() {
        return articleId;
    }

    public void setArticleId(Long articleId) {
        this.articleId = articleId;
    }
}
