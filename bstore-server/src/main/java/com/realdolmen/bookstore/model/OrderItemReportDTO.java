package com.realdolmen.bookstore.model;

import java.math.BigDecimal;

public class OrderItemReportDTO {
    private Long id;
    private Long articleId;
    private ArticleType articleType;
    private BigDecimal price;
    private Long quantity;
    private Article article;
    private String title;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public OrderItemReportDTO(OrderItem oi){
        this.id = oi.getId();
        this.articleId = oi.getArticleId();
        this.articleType = oi.getArticleType();
        this.price = oi.getPrice();
        this.quantity = oi.getQuantity();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getArticleId() {
        return articleId;
    }

    public void setArticleId(Long articleId) {
        this.articleId = articleId;
    }

    public ArticleType getArticleType() {
        return articleType;
    }

    public void setArticleType(ArticleType articleType) {
        this.articleType = articleType;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
    }
}
