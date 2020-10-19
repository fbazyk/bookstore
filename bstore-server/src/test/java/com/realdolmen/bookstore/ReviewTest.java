package com.realdolmen.bookstore;

import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.Review;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.repository.ArticleRepository;
import com.realdolmen.bookstore.repository.ReviewRepository;
import com.realdolmen.bookstore.repository.UserRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = BookstoreApplication.class)
@ContextConfiguration(classes = BookstoreApplication.class)
public class ReviewTest {

    Logger logger = LoggerFactory.getLogger(ReviewTest.class);

    @Autowired
    private ReviewRepository reviewRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ArticleRepository articleRepository;

    @Test
    public void createReview(){
        Review sorenReview = new Review();
        createUser();
        User user = this.userRepository.findById(1L).get();
        sorenReview.setRating(5);
        sorenReview.setArticleType(ArticleType.BOOK);
        sorenReview.setArticleId(1L);
        sorenReview.setText("Masterpiece");
        sorenReview.setUser(user);

        this.reviewRepository.saveAndFlush(sorenReview);

        List<Review> addedReviews = this.reviewRepository.findAll();
        addedReviews.forEach(review -> {
            logger.debug(review.getText());
        });

    }

    private void createUser() {
        User user = new User();
        user.setLastName("Python");
        user.setFirstName("Monty");
        user.setRole("admin");

        this.userRepository.saveAndFlush(user);
    }
}
