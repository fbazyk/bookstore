package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.*;

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

        if(article instanceof Book){
            searchTitle = searchTitle + ((Book) article).getAuthor().replaceAll("[^a-zA-Z0-9]", " ").toLowerCase();
        }
        if(article instanceof Game){
            searchTitle = searchTitle + ((Game) article).getPublisher().replaceAll("[^a-zA-Z0-9]", " ").toLowerCase();
        }
        if(article instanceof LP){
            searchTitle = searchTitle + ((LP) article).getArtist().replaceAll("[^a-zA-Z0-9]", " ").toLowerCase();
        }
        article.setSearchTitle(searchTitle);

    }

}
