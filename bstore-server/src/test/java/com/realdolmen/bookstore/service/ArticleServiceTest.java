package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.BookstoreApplication;
import com.realdolmen.bookstore.exception.ArticleNotFoundException;
import com.realdolmen.bookstore.exception.UnableToUpdateArticleException;
import com.realdolmen.bookstore.model.*;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = BookstoreApplication.class)
@ContextConfiguration(classes = BookstoreApplication.class)
@Transactional
//@DataJpaTest
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
class ArticleServiceTest {

    Logger logger = LoggerFactory.getLogger(ArticleServiceTest.class);

    @Autowired
    ArticleService articleService;

    @Test
    void findAll() {
        List<Article> foundArticles = this.articleService.findAll();
        logger.debug("List Size is {}", foundArticles.size());
        assertFalse(foundArticles.isEmpty());
//        assertTrue(foundArticles.size() == 10);

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
    void addArticleBook() throws Exception {

        Book newBook = new Book();
        newBook.setTitle("New Book");
        newBook.setPrice(BigDecimal.valueOf(10l));
        newBook.setSupplierId("1");
        newBook.setAuthor("New Author");
        newBook.setPages(100l);
        newBook.setIsbn("9788371815102");
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
    void deleteByTypeById_Book1() {
        try{
            this.articleService.deleteByTypeById("book", 1l);
        } catch (Exception exception){
            logger.debug("Exception {}", exception);
        }
        List<Article> allArticles = this.articleService.findAll();
        Optional<Article> deletedBook = allArticles.stream().filter(article -> {
            return article instanceof Book && article.getId().equals(1l);
        }).findFirst();
        logger.debug("All Articles Size is {}", allArticles.size());
        assertFalse(deletedBook.isPresent());
    }

    @Test
    void deleteByTypeById_Game2() {
        try{
            this.articleService.deleteByTypeById("game", 2l);
        } catch (Exception exception){
            logger.debug("Exception {}", exception);
        }
        List<Article> allArticles = this.articleService.findAll();
        Optional<Article> deletedBook = allArticles.stream().filter(article -> {
            return article instanceof Game && article.getId().equals(2l);
        }).findFirst();
        logger.debug("All Articles Size is {}", allArticles.size());
        assertFalse(deletedBook.isPresent());
    }

    @Test
    void deleteByTypeById_LP2() {
        try{
            this.articleService.deleteByTypeById("lp", 2l);
        } catch (Exception exception){
            logger.debug("Exception {}", exception);
        }
        List<Article> allArticles = this.articleService.findAll();
        Optional<Article> deletedBook = allArticles.stream().filter(article -> {
            return article instanceof LP && article.getId().equals(2l);
        }).findFirst();
        logger.debug("All Articles Size is {}", allArticles.size());
        assertFalse(deletedBook.isPresent());
    }

    @Test
    void findByTypeAndId(){
        Article article = new Article();
        Boolean success = false;
        try{

            article = this.articleService.findByTypeAndId(ArticleType.BOOK, 1l);
        } catch(ArticleNotFoundException anfex){
            logger.debug("FIND ARTICLE:: article not found: {}", anfex.getMessage());
        } catch (Exception ex){
            logger.debug("FIND ARTICLE:: something went wrong: {}", ex.getMessage());
        }
        assertNotNull(article);
    }

    /**
     *  find an article by type and id
     *  Change price, title, supplierId
     *  updateArticle
     *  find same article again, compare new values
     * */
    @Test
    @Transactional
    @WithMockUser(username = "andy", password = "campbells", roles = "ADMIN")
    void updateArticle() {
        Article article = new Article();
        Boolean success = false;
        try{

            article = this.articleService.findByTypeAndId(ArticleType.BOOK, 1l);
        } catch(ArticleNotFoundException anfex){
            logger.debug("FIND ARTICLE:: article not found: {}", anfex.getMessage());
        } catch (Exception ex){
            logger.debug("FIND ARTICLE:: something went wrong: {}", ex.getMessage());
        }
        article.setTitle("Test Title");
        article.setPrice(BigDecimal.valueOf(100l));
        article.setSupplierId("100");
        try{
            success = this.articleService.updateArticle(article);
        } catch (UnableToUpdateArticleException uuaex){
            logger.debug("UPDATE ARTICLE::unable to update article {}", uuaex.getMessage());
        }
        assertTrue(success);
        Article updatedArticle = new Article();
        try {
            updatedArticle = this.articleService.findByTypeAndId(ArticleType.BOOK, 1l);
        } catch(Exception ex){
            logger.debug("FIND ARTICLE::after update: {}", ex.getMessage());
        }
        assertEquals("Test Title", updatedArticle.getTitle());
        assertEquals(BigDecimal.valueOf(100l), updatedArticle.getPrice());
        assertEquals("100", updatedArticle.getSupplierId());
        assertTrue(updatedArticle.getSearchTitle().contains("test"));
    }

    @Test
    void search() {

        //TODO create a search object
        //TODO pass search object to the search method
        //TODO how to compare results?
        //TODO Variants: Id, Title, MinPrice, MaxPrice
        //TODO check ifpresent
    }

    @Test
    void findByTypeAndId__InvalidId() {
        ArticleType TYPE = ArticleType.BOOK;
        Long INVALID_ID = 10l;
        assertThrows(Exception.class, () -> {
            try {
                this.articleService.findByTypeAndId(TYPE, INVALID_ID);

            }catch (Exception ex){
                logger.debug(ex.getMessage());
                throw ex;
            }
        });

    }

    @Test
    void findAllPaged__page1() {

//        List<Article> articlesPaged = this.articleService.findAllPaged(1l, 5l);
//        assertEquals(5, articlesPaged.size());
//        articlesPaged.forEach(article -> {
//            logger.debug("Found Article {}, {}", article.getId(), article.getTitle());
//        });
    }
    @Test
    void findAllPaged__page2() {

//        List<Article> articlesPaged = this.articleService.findAllPaged(2l, 5l);
//        assertEquals(5, articlesPaged.size());
//        articlesPaged.forEach(article -> {
//            logger.debug("Found Article {}, {}", article.getId(), article.getTitle());
//        });
    }
}
