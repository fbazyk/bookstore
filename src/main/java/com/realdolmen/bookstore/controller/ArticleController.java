package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.exception.ArticleNotFoundException;
import com.realdolmen.bookstore.exception.UnableToUpdateArticleException;
import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.service.ArticleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping
public class ArticleController {

    Logger logger = LoggerFactory.getLogger(ArticleController.class);

    private ArticleService articleService;

    @Autowired
    public ArticleController(ArticleService articleService) {
        this.articleService = articleService;
    }

    @CrossOrigin
    @GetMapping("/articles")
    public List<Article> findAll() {

        List<Article> result =this.articleService.findAll();
        logger.debug("Articles 0: {}", result.get(0).getClass());
        logger.debug("Articles 0: {}", result.get(4).getClass());
        logger.error("Articles: {}", result);
        return result;
    }

    @CrossOrigin
    @DeleteMapping("/article/{type}/{id}")
    public ResponseEntity<?> deleteArticle(@PathVariable String type, @PathVariable long id) {
        try{
            articleService.deleteByTypeById(type, id);
            String successMessage = "Deleted Article" + type + ":" + id;
            return ResponseEntity.ok(successMessage);
        } catch (ArticleNotFoundException ex){
            String errorMessage = "Unable to delete Article" + type + ":" + id;
            return ResponseEntity.badRequest().body(errorMessage);
        }
    }

    @CrossOrigin
    @PostMapping("/article/{type}/{id}")
    public ResponseEntity<?> changeArticle(@PathVariable String type, @PathVariable long id, @RequestBody Article article) {
        try{
            if(article.getId() != id) throw new UnableToUpdateArticleException();
            articleService.updateArticle(article);
            return ResponseEntity.ok("Article Updated");
        } catch (UnableToUpdateArticleException ex){
            return ResponseEntity.unprocessableEntity().body("Article Was Not Updated");
        }
    }

    @CrossOrigin
    @PutMapping("/article/{type}")
    public ResponseEntity<?> addArticle(@RequestBody Article article, @PathVariable String type) {
        logger.debug("Put Article {}", type);
        try{
            articleService.addArticle(type, article);
        } catch (Exception ex){
            String reason = "Article could not be added:" + ex.getMessage();
            return ResponseEntity.unprocessableEntity().body(reason);
        }
            return ResponseEntity.ok(true);
    }

    @CrossOrigin
    @PostMapping("/article/search")
    public ResponseEntity<?> searchArticle(@RequestBody Map<String,String> searchFields) {
        List<? extends Article> resultLsit = this.articleService.search(searchFields);
        //todo catch custom exception and throw bad request "field not provided"
        return ResponseEntity.ok(resultLsit);
    }
}
