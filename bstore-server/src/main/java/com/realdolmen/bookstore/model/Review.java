package com.realdolmen.bookstore.model;

import com.realdolmen.bookstore.service.AuditListener;

import javax.persistence.*;

@Entity
@Table(name = "reviews")
@EntityListeners(AuditListener.class)
public class Review implements Auditable{


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
//
//    @Version
//    private Integer version;

    @Column
    private Integer rating;

    @Column
    private String description;

    @Column(name = "USER_ID")
    private Long userId;

    @Column
    @Enumerated(EnumType.STRING)
    private ArticleType articleType;

    @Column (name = "article_id")
    private Long articleId;

    @Embedded
    private Audit audit;

    public Audit getAudit() {
        if(audit == null) {
            audit = new Audit();
        }
        return audit;
    }

    public void setAudit(Audit audit) {
        this.audit = audit;
    }

    public Review() {
    }

    public Review(ArticleType articleType, Long articleId, Long userId) {
        this.articleType = articleType;
        this.articleId = articleId;
        this.userId = userId;
    }
//
//    public Integer getVersion() {
//        return version;
//    }
//
//    public void setVersion(Integer version) {
//        this.version = version;
//    }

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
