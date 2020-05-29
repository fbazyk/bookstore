package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.exception.ArticleNotFoundException;
import com.realdolmen.bookstore.exception.UnableToUpdateArticleException;
import com.realdolmen.bookstore.jpaclassification.ArticleSpecifications;
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

    public boolean addArticle(String type, Article article) {
        if(type != null && article != null){
            switch (type) {
                case "book": {
                    this.bookRepository.saveAndFlush((Book) article);
                    return true;
                }
                case "game": {
                    this.gameRepository.saveAndFlush((Game) article);
                    return true;
                }
                case "lp": {
                    this.lpRepository.saveAndFlush((LP) article);
                    return true;
                }
                default:
                    return false;
            }
        }
        return true;
    }

    public boolean deleteByTypeById(String type, long id) throws ArticleNotFoundException {
        if (type != null && id > 0) {
            switch (type) {
                case "book": {
                    try {
                        this.bookRepository.deleteById(id);
                        this.bookRepository.flush();
                    } catch (Exception ex) {
                        //todo throw another exception to the controller
                        throw new ArticleNotFoundException();
                    }
                    return true;
                }
                case "game": {
                    try {
                        this.gameRepository.deleteById(id);
                        this.gameRepository.flush();
                    } catch (Exception ex) {
                        throw new ArticleNotFoundException();
                    }
                    return true;
                }
                case "lp": {
                    try {
                        this.lpRepository.deleteById(id);
                        this.lpRepository.flush();
                    } catch (Exception ex) {
                        throw new ArticleNotFoundException();
                    }
                    return true;
                }
                default:
                    return false;
            }
        } else return false;
    }

    public boolean updateArticle(Article article) throws UnableToUpdateArticleException {

        if(article.getId()!= null && article.getId()>0){
            if(article instanceof Book){
                try{
                    this.bookRepository.saveAndFlush((Book)article);
                    return true;
                } catch (Exception ex){
                    throw new UnableToUpdateArticleException();
                }
            } else if(article instanceof Game){
                try{
                    this.gameRepository.saveAndFlush((Game) article);
                    return true;
                } catch (Exception ex){
                    throw new UnableToUpdateArticleException();
                }
            } else if(article instanceof LP){
                try{
                    this.lpRepository.saveAndFlush((LP) article);
                    return true;
                } catch (Exception ex){
                    throw new UnableToUpdateArticleException();
                }
            } else {
                throw new UnableToUpdateArticleException();
            }
        } else {
            throw new UnableToUpdateArticleException();
        }
    }

    public List<? extends Article> search(Map<String, String> searchFields) {
//        searchFields.entrySet().stream();
        //todo map searchfields to the search query arguments
        List<Book> booksByAuthor = this.bookRepository.findAll(ArticleSpecifications.bookHasAuthor2(searchFields.get("author")));

        //todo stream the fields through the function that adds a query parameter

        //todo switch through the map and build a query parameter with each field
        //create a named query in each repository
        //or should it be some other type of query?
//        List<Book> bookResults = this.bookRepository.searchallfields();
        return booksByAuthor;
    }
}
