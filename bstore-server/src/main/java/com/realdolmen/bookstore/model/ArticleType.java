package com.realdolmen.bookstore.model;

public enum ArticleType {
    BOOK ("BOOK"),
    GAME ("GAME"),
    LP("LP"),
    ALL("ALL");

    private String type;

    ArticleType(String type) {
        this.type = type;
    }

    public static ArticleType getByType(String type){
        return   ArticleType.valueOf(type.toUpperCase());
    }
}
