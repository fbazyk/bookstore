package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.dto.AddReviewDTO;
import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.Review;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.repository.ReviewRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Example;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@Component
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final UserService userService;
    Logger logger = LoggerFactory.getLogger(ReviewService.class);

    public ReviewService(
            ReviewRepository reviewRepository, UserService userService) {
        this.reviewRepository = reviewRepository;
        this.userService = userService;
    }

    /**
     * FindReview of user logged in
     *
     * @param articleType
     * @param articleId
     * @param user
     * @return
     */
    public Optional<Review> findReview(ArticleType articleType, Long articleId, User user) {

        Example<Review> example = Example.of(new Review(articleType, articleId, user.getId()));
        return this.reviewRepository.findOne(example);
    }

    /**
     * TODO
     * Add Review
     * Accepts DTO
     * Fetches current user
     * Builds Review object
     * Persists in DB
     */
    public void addReview(AddReviewDTO addReviewDTO) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();

        }
        logger.debug(username);
        User currentUser = this.userService.findByUserName(username);
        //Check if the review for the same article by the same user exists
        this.findReview(addReviewDTO.getArticleType(),
                addReviewDTO.getArticleId(),
                currentUser)
                .ifPresentOrElse(review -> {
                    //If review is present, update rating and description
                    review.setRating(addReviewDTO.getRating());
                    review.setDescription(addReviewDTO.getDescription());
                    this.reviewRepository.saveAndFlush(review);
                }, () -> {
                    //Build Review object
                    Review review = new Review();
                    review.setUserId(currentUser.getId());
                    review.setArticleType(addReviewDTO.getArticleType());
                    review.setArticleId(addReviewDTO.getArticleId());
                    review.setRating(addReviewDTO.getRating());
                    review.setDescription(addReviewDTO.getDescription());
                    reviewRepository.saveAndFlush(review);
                });

    }

    /**
     * Find All reviews for an article
     * @return list of reviews
     * */

    public Set<Review> findReviews(ArticleType articleType, Long articleId){
        logger.debug("Finding reviews by ArticleType {} and Id {}", articleType, articleId);
        Set<Review> foundReviews = this.reviewRepository.findAllByArticleTypeAndArticleId(articleType, articleId);
        return foundReviews;
    }

    public Set<Review> findReviewsByUserId(Long id) {
        return this.reviewRepository.findAllByUserId(id);
    }

    public Review findReviewById(Long id) {
        return this.reviewRepository.findById(id).get();
    }

    public void deleteReviewById(Long id) {
        this.reviewRepository.deleteById(id);
    }

    /** TODO
     *
     * */
}
