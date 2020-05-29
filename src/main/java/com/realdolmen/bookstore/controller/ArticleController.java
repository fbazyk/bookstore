package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.service.ArticleService;
import com.realdolmen.bookstore.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

import static javafx.scene.input.KeyCode.T;

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
    @GetMapping("/inventory/articles")
    public List<Article> findAll() {

        List<Article> result =this.articleService.findAll();
        logger.debug("Articles 0: {}", result.get(0).getClass());
        logger.debug("Articles 0: {}", result.get(4).getClass());
        logger.error("Articles: {}", result);
        return result;
    }

    @CrossOrigin
    @DeleteMapping("/article/{type}/{id}")
    ResponseEntity<?> deleteArticle(@PathVariable String type, @PathVariable long id) {
        if(articleService.deleteByTypeById(type, id)){
            return ResponseEntity.ok(true);
        } else {
            return ResponseEntity.unprocessableEntity().build();
        }
    }

    @CrossOrigin
    @PostMapping("/article/{type}/{id}")
    ResponseEntity<?> changeArticle(@PathVariable String type, @PathVariable long id) {

        //TODO extract object from body


        if(articleService.editArticle()){
            return ResponseEntity.ok(true);
        } else {
            return ResponseEntity.unprocessableEntity().build();
        }
    }

    @CrossOrigin
    @PutMapping("/article/{type}")
    ResponseEntity<?> addArticle(@RequestParam String type) {
//        logger.debug("Put Article {} of type {}",article, type);
        logger.debug("Put Article {} of type {}", type);
//        if(articleService.addArticle(type, article)){
//        } else {
//            return ResponseEntity.unprocessableEntity().build();
//        }
            return ResponseEntity.ok(true);
    }

    @CrossOrigin
    @PostMapping("/article/search")
    ResponseEntity<?> searchArticle(@RequestBody Map<String,String> searchFields) {
        List<? extends Article> resultLsit = this.articleService.search(searchFields);
        //todo catch custom exception and throw bad request "field not provided"
        return ResponseEntity.ok(resultLsit);
    }
}
