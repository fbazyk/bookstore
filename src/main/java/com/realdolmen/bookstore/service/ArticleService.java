package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.*;
import com.realdolmen.bookstore.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.List;
import java.util.Map;
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

    public boolean addArticle(String type, Object article){

        //todo convert article Object to its respective class
        //TODO push it to respective repository

        //        switch (type){
//            case "book" : {
//                this.bookRepository.addBook(article);
//                break;
//            }
//            case "game":{
//                this.gameRepository.addGame(article);
//                break;
//            }
//            case "lp":{
//                this.lpRepository.addLp(article);
//                break;
//            }
//            default: return false;
//        }
        return true;
    }

    public boolean deleteByTypeById(String type, long id) {
//        switch (type){
//            case "book" : {
//                this.bookRepository.deleteById(id);
//                break;
//            }
//            case "game":{
//                this.gameRepository.deleteById(id);
//                break;
//            }
//            case "lp":{
//                this.lpRepository.deleteById(id);
//                break;
//            }
//            default: return false;
//        }
        return true;
    }

    public boolean editArticle() {
        //todo return new article from db?
        //todo or just return true so front-end must do another request to request the article?
        //i guess returning a new article will be faster...
        return false;

    }

    public List<Article> search(Map<String,String> searchFields) {
        //todo switch through the map and build a query parameter with each field
        //create a named query in each repository
        //or should it be some other type of query?
        List<Book> bookResults = this.bookRepository.searchallfields();
        return null;
    }
}
