package com.realdolmen.bookstore;

import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.Book;
import com.realdolmen.bookstore.model.Review;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.repository.ArticleRepository;
import com.realdolmen.bookstore.repository.BookRepository;
import com.realdolmen.bookstore.repository.ReviewRepository;
import com.realdolmen.bookstore.repository.UserRepository;
import com.realdolmen.bookstore.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.*;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = BookstoreApplication.class)
@ContextConfiguration(classes = BookstoreApplication.class)
public class UserFavoriteBookTest {

    Logger logger = LoggerFactory.getLogger(UserFavoriteBookTest.class);

    @Autowired
    private ReviewRepository reviewRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserService userService;

    @Autowired
    private ArticleRepository articleRepository;

    @Autowired
    private BookRepository bookRepository;

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    public void findUserWithFavoriteBooksById(){
        Book book = this.bookRepository.findById(1l).get();
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();
        }
        logger.debug(username);
        logger.debug(principal.toString());
        logger.debug("User is {}",principal);
        User currentUser = this.userService.findByUserName(username);
        currentUser.getFavoriteBooks().add(book);
        this.userRepository.save(currentUser);
        Set<User> users = this.userRepository.findByFavoriteBooksId(book.getId());
        logger.debug("User is {}", currentUser.getUserName());
        logger.debug("User's Favorite Book is is {}", users.stream().findFirst().get().getFavoriteBooks().stream().findFirst().get().getTitle());
        logger.debug("User's favorite books size is {}", currentUser.getFavoriteBooks().size());
        assertEquals(book.getTitle(), users.stream().findFirst().get().getFavoriteBooks().stream().findFirst().get().getTitle());
    }

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    public void findUserWithFavoriteBooksByBook(){
        Book book = this.bookRepository.findById(1l).get();
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();
        }
        logger.debug(username);
        logger.debug(principal.toString());
        logger.debug("User is {}",principal);
        User currentUser = this.userService.findByUserName(username);
        //add book as favorite for the user
        currentUser.getFavoriteBooks().add(book);
        this.userRepository.save(currentUser);
        //find users with the favorite book
        Set<User> users = this.userRepository.findAllByFavoriteBooksIs(book);
        assertTrue(users.size()>0);
        logger.debug("User is {}", users.toArray()[0]);
        logger.debug("Users size is {}", users.size());
        logger.debug("User's Favorite Book is is {}", users.stream().findFirst().get().getFavoriteBooks().stream().findFirst().get().getTitle());
        assertEquals(book.getTitle(), users.stream().findFirst().get().getFavoriteBooks().stream().findFirst().get().getTitle());
    }

}
