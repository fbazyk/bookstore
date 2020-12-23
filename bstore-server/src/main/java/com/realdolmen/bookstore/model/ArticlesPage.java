package com.realdolmen.bookstore.model;

import java.util.List;

public class ArticlesPage {

    List<Article> articles;
    Long totalArticles;
    Long currentPage;
    Long totalPages;

    public ArticlesPage() {
    }

    public List<Article> getArticles() {
        return articles;
    }

    public void setArticles(List<Article> articles) {
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
