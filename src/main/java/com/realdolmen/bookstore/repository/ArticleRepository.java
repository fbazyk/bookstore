package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.Article;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ArticleRepository extends JpaRepository<Article, Long> {

}
