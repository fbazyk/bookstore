package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.dto.NewUserDTO;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.service.ReviewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(origins = "http://localhost:4201")
public class ReviewController {

    private ReviewService reviewService;
    Logger logger = LoggerFactory.getLogger(ReviewController.class);

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @PostMapping(value = "/reviews/{type}/{id}")
    public ResponseEntity<?> reviews(@PathVariable String type, @PathVariable long id){
        logger.debug("reviews for: type {}, id {}", type, id);
        try{
//            this.reviewService.findReview();

        }catch (Exception ex){
            logger.debug(ex.getMessage());
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }finally {
        }
        return new ResponseEntity<>(HttpStatus.OK);

    }


}
