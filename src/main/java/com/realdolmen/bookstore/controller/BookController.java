package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.model.Book;
import com.realdolmen.bookstore.service.ArticleService;
import com.realdolmen.bookstore.service.BookService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/books")
public class BookController {

    Logger logger = LoggerFactory.getLogger(BookController.class);

    private BookService bookService;

    @Autowired
    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @CrossOrigin
    @GetMapping
    public List<Book> findAll() {
        List<Book> result =this.bookService.findAll();
        logger.error("Books: {}", result);
        return result;
    }

}
