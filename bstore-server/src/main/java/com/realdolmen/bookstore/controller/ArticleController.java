package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.exception.ArticleNotFoundException;
import com.realdolmen.bookstore.exception.UnableToUpdateArticleException;
import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.model.ArticlesPage;
import com.realdolmen.bookstore.service.ArticleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.ConstraintViolationException;
import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin(origins = "http://localhost:4201")
@RequestMapping
public class ArticleController {

    Logger logger = LoggerFactory.getLogger(ArticleController.class);

    private ArticleService articleService;

    @Autowired
    public ArticleController(ArticleService articleService) {
        this.articleService = articleService;
    }

    @GetMapping("/articles")
    public List<Article> findAll() {

        List<Article> result =this.articleService.findAll();
        return result;
    }

    @GetMapping("/articlespaged")
    public ArticlesPage findAllPaged(@RequestParam Long page, @RequestParam Long psize) {
        ArticlesPage articlesPage = new ArticlesPage();
        articlesPage =this.articleService.findAllPaged(page, psize);
        return articlesPage;
    }

    @GetMapping("/articlescatpaged")
    public ArticlesPage findCategoryPaged(@RequestParam Long page,
                                          @RequestParam Long psize,
                                          @RequestParam String category
    ) {
        ArticlesPage articlesPage = new ArticlesPage();
        logger.debug("Category is {}", category);
        articlesPage =this.articleService.findCatPaged(page, psize, category);
        return articlesPage;
    }

    @GetMapping("/articlescatfilteredpaged")
    public ArticlesPage findCatFilteredPaged(@RequestParam Long page,
                                          @RequestParam Long psize,
                                          @RequestParam String category,
                                             @RequestParam String filter
    ) {
        ArticlesPage articlesPage = new ArticlesPage();
        logger.debug("Category is {}", category);
        logger.debug("Filter is {}", filter);
        articlesPage =this.articleService.findCatFilteredPaged(page, psize, category, filter);
        return articlesPage;
    }



    @GetMapping("/article/{type}/{id}")
    public ResponseEntity<?> getArticle(@PathVariable String type, @PathVariable long id) {
        try{
            Article article = articleService.getArticle(type, id);
            return ResponseEntity.ok().body(article);
        } catch (ArticleNotFoundException ex){
            String errorMessage = "Unable to find Article" + type + ":" + id;
            return ResponseEntity.badRequest().body(errorMessage);
        }
    }
    @DeleteMapping("/article/{type}/{id}")
    public ResponseEntity<?> deleteArticle(@PathVariable String type, @PathVariable long id) {
        try{
            articleService.deleteByTypeById(type, id);
            String successMessage = "Deleted Article: " + type + "@" + id;
            return ResponseEntity.ok().body(successMessage);
        } catch (ArticleNotFoundException ex){
            String errorMessage = "Unable to delete Article" + type + ":" + id;
            return ResponseEntity.badRequest().body(errorMessage);
        }
    }

    @PostMapping(value = "/article/{type}/{id}", produces="text/plain")
    public ResponseEntity<?> changeArticle(@PathVariable String type, @PathVariable long id, @RequestBody Article article) {
        try{
            if(article.getId() != id) throw new UnableToUpdateArticleException();
            articleService.updateArticle(article);
            return ResponseEntity.ok("Article Updated");
        } catch (UnableToUpdateArticleException ex){
            return ResponseEntity.unprocessableEntity().body("Article Was Not Updated");
        }
    }

    @PutMapping(value = "/article/{type}", produces = "text/plain")
    public ResponseEntity<?> addArticle(@RequestBody Article article, @PathVariable String type) {
        //TODO unmarshall Article object into correct type
        //TODO Create ArticleDTO with explicitly stated type
        //TODO read https://stackabuse.com/data-transfer-object-pattern-in-java-implementation-and-mapping/
        //TODO check if the object with the same type and
        //TODO call respective repository based on the result of the conversion


        logger.debug("Put Article {}", article.getId());
        logger.debug("Put Article {}", type);
        try{
            if(article.getId() == 0){
                Article noId = article;
                noId.setId(null);
                articleService.addArticle(type, noId);
            }
        } catch (ConstraintViolationException constraintViolationException){
            logger.debug("Constraint Violation Exception: {}", constraintViolationException.getConstraintViolations());
            logger.debug("Constraint Violation Exception: {}", constraintViolationException.getMessage());
            String reason = "Article could not be added:" + constraintViolationException.getMessage();
            return ResponseEntity.status(HttpStatus.EXPECTATION_FAILED).body(reason);
        }         catch (Exception ex){
            String reason = "Article could not be added:" + ex.getMessage();
            return ResponseEntity.unprocessableEntity().body(reason);
        }
        String result = "Article added!";
            return ResponseEntity.ok(result);
    }

    @PostMapping("/article/search")
    public ResponseEntity<List<Article>> searchArticle(@RequestBody Map<String,String> searchFields) {
        List<Article> resultLsit = this.articleService.search(searchFields);
        //todo catch custom exception and throw bad request "field not provided"
        if(resultLsit != null && resultLsit.size()>0){
            logger.debug("ResultList {}", resultLsit);
            return new ResponseEntity<List<Article>>(resultLsit, HttpStatus.OK);
        } else {
            return ResponseEntity.noContent().build();
        }

    }
}
