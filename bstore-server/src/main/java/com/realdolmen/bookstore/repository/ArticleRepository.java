package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.Article;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface ArticleRepository extends JpaRepository<Article, Long> {
    //todo union 3 tables

    //todo named
    // query on mappedsuperclass

    //

    @Transactional
    @Query(name = "findAll",
            value = "select b.id, b.title, b.price, b.supplier_id from books b\n" +
            "union select g.id, g.title, g.price, g.supplier_id from games g\n" +
            "union select l.id, l.title, l.price, l.supplier_id from lps l",
            nativeQuery = true)
    public List<Article> findAll();

}
