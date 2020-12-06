package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.dto.AddReviewDTO;
import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.Review;
import com.realdolmen.bookstore.service.ReviewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

@RestController
@CrossOrigin(origins = "http://localhost:4201")
public class ReviewController {

    private ReviewService reviewService;
    Logger logger = LoggerFactory.getLogger(ReviewController.class);

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping(value = "/reviews/{type}/{id}")
    @CrossOrigin(origins = "http://localhost:4201")
    public ResponseEntity<Set<Review>> reviews(@PathVariable String type, @PathVariable long id){
        logger.debug("reviews for: type {}, id {}", type, id);
        try{
            ArticleType atype = ArticleType.getByType(type);
            Set<Review> foundReviews = this.reviewService.findReviews(ArticleType.getByType(type), id);
            return ResponseEntity.ok(foundReviews);

        }catch (Exception ex){
            logger.debug(ex.getMessage());
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }finally {
        }

    }

    @PostMapping(value = "/reviews/add")
    public ResponseEntity<?> addReview(@RequestBody AddReviewDTO addReviewDTO){
        logger.debug("reviews for: type {}, id {}", addReviewDTO.getArticleType(), addReviewDTO.getArticleId());
        try{
            this.reviewService.addReview(addReviewDTO);

        }catch (Exception ex){
            logger.debug(ex.getMessage());
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }finally {
        }
        return new ResponseEntity<>(HttpStatus.OK);

    }


}
