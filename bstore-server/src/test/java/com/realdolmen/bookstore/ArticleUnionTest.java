package com.realdolmen.bookstore;

import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.repository.ArticleRepository;
import org.junit.Test;
import org.junit.jupiter.api.Assertions;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = BookstoreApplication.class)
@ContextConfiguration(classes = BookstoreApplication.class)
public class ArticleUnionTest {

    Logger logger = LoggerFactory.getLogger(ArticleUnionTest.class);

    @Autowired
    ArticleRepository articleRepository;

    @Test
    public void articleUnionTest(){

        Assertions.assertThrows (Exception.class, () -> {
            List<Article> articles = this.articleRepository.findAll();
            logger.debug("Article list size is {}:", articles.size());
        });
    }

}
