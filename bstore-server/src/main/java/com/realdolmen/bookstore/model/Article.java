package com.realdolmen.bookstore.model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.realdolmen.bookstore.service.AuditListener;
import com.realdolmen.bookstore.service.SearchTitleListener;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Set;

/**
 * https://stackoverflow.com/questions/16396489/named-query-on-a-mapped-superclass
 *
 * A mapped superclass, unlike an entity, is not queryable
 * and must not be passed as an argument to EntityManager or Query operations.
 * */

@JsonTypeInfo(use = JsonTypeInfo.Id.NAME,
        include = JsonTypeInfo.As.PROPERTY,
        property = "type")
@JsonSubTypes({
        @JsonSubTypes.Type(value = Book.class, name = "book"),
        @JsonSubTypes.Type(value = Game.class, name = "game"),
        @JsonSubTypes.Type(value = LP.class, name = "lp"),
})
@MappedSuperclass
@EntityListeners({AuditListener.class, SearchTitleListener.class})
public class Article implements Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Size(max = 255)
    private String title;

    private String searchTitle;

    @NotNull
    private BigDecimal price;

//    @Version
//    private Integer version;

    @Column(name = "deleted", columnDefinition = "boolean default false")
    private boolean deleted = false;

    @NotNull
    @Column
    @Size(max=100)
    private String supplierId;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval=true)
    @JoinColumn(name = "article_id")
    private Set<Review> reviews;

    @OneToOne(cascade = {CascadeType.REFRESH, CascadeType.MERGE, CascadeType.PERSIST})
    @JoinColumn(name = "location_id", referencedColumnName = "id")
    @JsonManagedReference
    private StorageLocation location;

    @Embedded
    private Audit audit;



    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public Audit getAudit() {
        if(audit == null) {
            audit = new Audit();
        }
        return audit;
    }

    public StorageLocation getLocation() {
        return location;
    }

    public void setLocation(StorageLocation location) {
        this.location = location;
    }

    public void setAudit(Audit audit) {
        this.audit = audit;
    }

    public Article() {
    }

    public String getSearchTitle() {
        return searchTitle;
    }

    public void setSearchTitle(String searchTitle) {
        this.searchTitle = searchTitle;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Set<Review> getReviews() {
        return reviews;
    }

    public void setReviews(Set<Review> reviews) {
        this.reviews = reviews;
    }

//    public Integer getVersion() {
//        return version;
//    }
//
//    public void setVersion(Integer version) {
//        this.version = version;
//    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }
}
