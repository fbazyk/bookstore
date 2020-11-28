package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.Review;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.repository.ReviewRepository;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class ReviewService {

    private ReviewRepository reviewRepository;

    public ReviewService(
            ReviewRepository reviewRepository){
        this.reviewRepository = reviewRepository;
    }

    /**
     * FindReview of user logged in
     * @param articleType
     * @param articleId
     * @param user
     * @return  */
    public Optional<Review> findReview(ArticleType articleType, Long articleId, User user){

        Example<Review> example = Example.of(new Review(articleType, articleId, user));
        return this.reviewRepository.findOne(example);
    }

    /**
     * Find All reviews for an article
     * */
}
