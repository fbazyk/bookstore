package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.*;
import com.realdolmen.bookstore.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Component
public class ArticleService {

    private ArticleRepository articleRepository;
    private BookRepository bookRepository;
    private GameRepository gameRepository;
    private LpRepository lpRepository;

    @Autowired
    public ArticleService(ArticleRepository articleRepository,
                          BookRepository bookRepository,
                          GameRepository gameRepository,
                          LpRepository lpRepository) {
        this.articleRepository = articleRepository;
        this.bookRepository = bookRepository;
        this.gameRepository = gameRepository;
        this.lpRepository = lpRepository;
    }

    public List<Article> findAll() {
        List<Book> books = this.bookRepository.findAll();
        List<Game> games = this.gameRepository.findAll();
        List<LP> lps = this.lpRepository.findAll();
        List<Article> articles = Stream.of(books, games, lps)
                .flatMap(Collection::stream)
                .collect(Collectors.toList());
        return articles;
    }
}
