package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.dto.AddReviewDTO;
import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.Review;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.service.ReviewService;
import com.realdolmen.bookstore.service.UserService;
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
    private UserService userService;
    Logger logger = LoggerFactory.getLogger(ReviewController.class);

    public ReviewController(ReviewService reviewService, UserService userService) {
        this.reviewService = reviewService;
        this.userService = userService;
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

    @GetMapping(value = "/reviews/user/{id}")
    public ResponseEntity<Set<Review>> userReviews(@PathVariable Long id){
        logger.debug("Reviews for user: id{}", id);
        Set<Review> foundReviews = this.reviewService.findReviewsByUserId(id);
        return ResponseEntity.ok(foundReviews);
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

    @DeleteMapping(value="/reviews/{id}")
    public ResponseEntity<?> deleteReview(@PathVariable Long id){
        logger.debug("Deleting the review for id {}", id);
        //TODO get review from service
        Review existingReview = this.reviewService.findReviewById(id);
        User currentUser = this.userService.currentUser();
        if(existingReview.getUserId().equals(currentUser.getId())){
            this.reviewService.deleteReviewById(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.status(HttpStatus.EXPECTATION_FAILED).build();
        }
        //TODO Make sure that user is the user in the review
    }

}
