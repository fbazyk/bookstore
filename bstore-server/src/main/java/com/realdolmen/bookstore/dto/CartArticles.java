package com.realdolmen.bookstore.dto;

import com.realdolmen.bookstore.model.Article;

import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

public class CartArticles {
    private Set<Article> articles = new LinkedHashSet<Article>();
    Long totalArticles;
    Long currentPage;
    Long totalPages;

    public CartArticles() {
    }

    public Set<Article> getArticles() {
        return articles;
    }

    public void setArticles(Set<Article> articles) {
        this.articles = articles;
    }

    public Long getTotalArticles() {
        return totalArticles;
    }

    public void setTotalArticles(Long totalArticles) {
        this.totalArticles = totalArticles;
    }

    public Long getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Long currentPage) {
        this.currentPage = currentPage;
    }

    public Long getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(Long totalPages) {
        this.totalPages = totalPages;
    }
}
