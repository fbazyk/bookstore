package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.Book;
import com.realdolmen.bookstore.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class BookService {

    private BookRepository bookRepository;
    @Autowired
    public BookService (BookRepository bookRepository){
        this.bookRepository = bookRepository;
    }

    public List<Book> findAll(){
        return this.bookRepository.findAll();
    }
}
