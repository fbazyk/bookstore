package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.model.Audit;
import com.realdolmen.bookstore.model.Auditable;

import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import java.time.LocalDateTime;

public class SearchTitleListener {
    public SearchTitleListener() {
    }


    @PrePersist
    @PreUpdate
    public void setSearchTitle(Article article) {

        String searchTitle = article.getTitle().replaceAll("[^a-zA-Z0-9]", " ").toLowerCase();
        article.setSearchTitle(searchTitle);

    }

}
