package com.realdolmen.bookstore.dto;

public class SearchDTO {

    private String articleType;
    private Long articleId;
    private String searchTitle;
    private Long minPrice;
    private Long maxPrice;
    private String sortBy;
    private String sortOrder;

    public SearchDTO() {
    }

    public String getArticleType() {
        return articleType;
    }

    public void setArticleType(String articleType) {
        this.articleType = articleType;
    }

    public Long getArticleId() {
        return articleId;
    }

    public void setArticleId(Long articleId) {
        this.articleId = articleId;
    }

    public String getSearchTitle() {
        return searchTitle;
    }

    public void setSearchTitle(String searchTitle) {
        this.searchTitle = searchTitle;
    }

    public Long getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Long minPrice) {
        this.minPrice = minPrice;
    }

    public Long getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(Long maxPrice) {
        this.maxPrice = maxPrice;
    }

    public String getSortBy() {
        return sortBy;
    }

    public void setSortBy(String sortBy) {
        this.sortBy = sortBy;
    }

    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }

    @Override
    public String toString() {
        return "SearchDTO{" +
                "articleType='" + articleType + '\'' +
                ", articleId=" + articleId +
                ", searchTitle='" + searchTitle + '\'' +
                ", minPrice=" + minPrice +
                ", maxPrice=" + maxPrice +
                ", sortBy='" + sortBy + '\'' +
                ", sortOrder='" + sortOrder + '\'' +
                '}';
    }
}
