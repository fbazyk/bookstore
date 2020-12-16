package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.BookstoreApplication;
import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.Book;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import static org.junit.jupiter.api.Assertions.*;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = BookstoreApplication.class)
@ContextConfiguration(classes = BookstoreApplication.class)
class ArticleServiceTest {

    Logger logger = LoggerFactory.getLogger(ArticleServiceTest.class);

    @Autowired
    ArticleService articleService;

    @Test
    void findAll() {
        List<Article> foundArticles = this.articleService.findAll();
        logger.debug("List Size is {}", foundArticles.size());
        assertFalse(foundArticles.isEmpty());
        assertTrue(foundArticles.size() == 10);

    }

    /**
     * Add Article
     * Create article object with correct data
     * Call addArticle method on new article
     * Call findAll method to see if article was persisted,
     * by finding the created article in the article list
     * */
    @Test
    @WithMockUser(username = "andy", password = "campbells", roles = "ADMIN")
    void addArticle() throws Exception {

        Book newBook = new Book();
        newBook.setTitle("New Book");
        newBook.setPrice(BigDecimal.valueOf(10l));
        newBook.setSupplierId("1");
        newBook.setAuthor("New Author");
        newBook.setPages(100l);
        newBook.setIsbn("1234567");
        boolean articleAdded = this.articleService.addArticle("book", newBook);
        List<Article> allArticles = this.articleService.findAll();
        logger.debug("Article List Size = {}", allArticles.size());
        Article newArticle = allArticles.stream().filter(article -> {
            return article.getTitle().equals("New Book");
        }).findFirst().orElseThrow(Exception::new);
        logger.debug("Price of new book is {}", newArticle.getPrice());

        assertTrue(articleAdded);
        assertTrue(newBook.getIsbn().equals(((Book)newArticle).getIsbn()));
        assertEquals(11, allArticles.size());
    }

    @Test
    void deleteByTypeById() {
        try{
            this.articleService.deleteByTypeById("book", 1l);
        } catch (Exception exception){
            logger.debug("Exception {}", exception);
        }
        List<Article> allArticles = this.articleService.findAll();
        logger.debug("All Articles Size is {}", allArticles.size());
    }

    @Test
    void updateArticle() {
    }

    @Test
    void search() {
    }

    @Test
    void findByTypeAndId() {
    }
}
