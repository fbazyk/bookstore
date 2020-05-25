package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.service.ArticleService;
import com.realdolmen.bookstore.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
@RestController
@RequestMapping("/inventory/articles")
public class ArticleController {

    Logger logger = LoggerFactory.getLogger(ArticleController.class);

    private ArticleService articleService;

    @Autowired
    public ArticleController(ArticleService articleService) {
        this.articleService = articleService;
    }

    @CrossOrigin
    @GetMapping
    public List<Article> findAll() {

        List<Article> result =this.articleService.findAll();
        logger.debug("Articles 0: {}", result.get(0).getClass());
        logger.debug("Articles 0: {}", result.get(4).getClass());
        logger.error("Articles: {}", result);
        return result;
    }
}
