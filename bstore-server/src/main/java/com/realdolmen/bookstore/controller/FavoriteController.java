package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.repository.BookRepository;
import com.realdolmen.bookstore.repository.GameRepository;
import com.realdolmen.bookstore.repository.LpRepository;
import com.realdolmen.bookstore.repository.UserRepository;
import com.realdolmen.bookstore.service.BookService;
import com.realdolmen.bookstore.service.GameService;
import com.realdolmen.bookstore.service.LpService;
import com.realdolmen.bookstore.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(origins = "http://localhost:4201")
public class FavoriteController {

    Logger logger = LoggerFactory.getLogger(FavoriteController.class);

    private UserService userService;
    private BookService bookService;
    private UserRepository userRepository;
    private BookRepository bookRepository;
    private GameRepository gameRepository;
    private GameService gameService;
    private LpService lpService;
    private LpRepository lpRepository;

    public FavoriteController(UserService userService, BookService bookService, UserRepository userRepository, BookRepository bookRepository, GameRepository gameRepository, GameService gameService, LpService lpService, LpRepository lpRepository) {
        this.userService = userService;
        this.bookService = bookService;
        this.userRepository = userRepository;
        this.bookRepository = bookRepository;
        this.gameRepository = gameRepository;
        this.gameService = gameService;
        this.lpService = lpService;
        this.lpRepository = lpRepository;
    }

    @PostMapping(value = "/favorite/{type}/{id}", produces="text/plain")
    public ResponseEntity<?> favoriteArticle(@PathVariable String type, @PathVariable long id, @RequestBody Article article) {
        User user = this.userService.currentUser();
//
        switch (type.toUpperCase()){
            case "BOOK": {
                user.getFavoriteBooks().add(this.bookRepository.findById(id).get());
                this.userRepository.saveAndFlush(user);
                return ResponseEntity.ok("true");
            }
            case "GAME": {
                user.getFavoriteGames().add(this.gameRepository.findById(id).get());
                this.userRepository.saveAndFlush(user);
                return ResponseEntity.ok("true");
            }
            case "LP": {
                user.getFavoriteLps().add(this.lpRepository.findById(id).get());
                this.userRepository.saveAndFlush(user);
                return ResponseEntity.ok("true");
            }
        }
        return ResponseEntity.badRequest().body("false");
    }

    @PostMapping(value = "/unfavorite/{type}/{id}", produces="text/plain")
    public ResponseEntity<?> unfavoriteArticle(@PathVariable String type, @PathVariable long id, @RequestBody Article article) {
        User user = this.userService.currentUser();
//
        switch (type.toUpperCase()){
            case "BOOK": {
                user.getFavoriteBooks().remove(this.bookRepository.findById(id).get());
                this.userRepository.saveAndFlush(user);
                return ResponseEntity.ok("true");
            }
            case "GAME": {
                user.getFavoriteGames().remove(this.gameRepository.findById(id).get());
                this.userRepository.saveAndFlush(user);
                return ResponseEntity.ok("true");
            }
            case "LP": {
                user.getFavoriteLps().remove(this.lpRepository.findById(id).get());
                this.userRepository.saveAndFlush(user);
                return ResponseEntity.ok("true");
            }
        }
        return ResponseEntity.badRequest().body("false");
    }
}
