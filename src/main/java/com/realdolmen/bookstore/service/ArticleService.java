package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.exception.ArticleNotFoundException;
import com.realdolmen.bookstore.exception.UnableToUpdateArticleException;
import com.realdolmen.bookstore.model.*;
import com.realdolmen.bookstore.repository.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static org.springframework.data.domain.Sort.Direction.DESC;

@Component
public class ArticleService {

    private ArticleRepository articleRepository;
    private BookRepository bookRepository;
    private GameRepository gameRepository;
    private LpRepository lpRepository;

    Logger logger = LoggerFactory.getLogger(ArticleService.class);

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
        if (type != null && article != null) {
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

        if (article.getId() != null && article.getId() > 0) {
            if (article instanceof Book) {
                try {
                    this.bookRepository.saveAndFlush((Book) article);
                    return true;
                } catch (Exception ex) {
                    throw new UnableToUpdateArticleException();
                }
            } else if (article instanceof Game) {
                try {
                    this.gameRepository.saveAndFlush((Game) article);
                    return true;
                } catch (Exception ex) {
                    throw new UnableToUpdateArticleException();
                }
            } else if (article instanceof LP) {
                try {
                    this.lpRepository.saveAndFlush((LP) article);
                    return true;
                } catch (Exception ex) {
                    throw new UnableToUpdateArticleException();
                }
            } else {
                throw new UnableToUpdateArticleException();
            }
        } else {
            throw new UnableToUpdateArticleException();
        }
    }

    public List<Article> search(Map<String, String> searchFields) {
        Long articleIdV = null;
        BigDecimal minpriceV = null;
        BigDecimal maxpriceV = null;
        String titleV = null;
        String type = null;
        String sortV = null;
        logger.debug(type);

        for (Map.Entry<String, String> field : searchFields.entrySet()) {
            if (Objects.equals(field.getKey(), "id")) {
                articleIdV = Long.valueOf(field.getValue());
            }
            if (Objects.equals(field.getKey(), "title")) {
                titleV = field.getValue();
            }
            if (Objects.equals(field.getKey(), "minprice")) {
                minpriceV = BigDecimal.valueOf(Long.parseLong(field.getValue()));
            }
            if (Objects.equals(field.getKey(), "maxprice")) {
                maxpriceV = BigDecimal.valueOf(Long.parseLong(field.getValue()));
            }
            if (Objects.equals(field.getKey(), "type")) {
                type = field.getValue();
            }
        }

        logger.debug(type);

        List<Article> resultList = new ArrayList<Article>();

        switch (type) {
            case ("all"): {

                Sort sort = Sort.by(DESC, "price");
                List<Book> listb = this.bookRepository.findByArticleParams(articleIdV, titleV, minpriceV, maxpriceV, sort);
                List<Game> listg = this.gameRepository.findByArticleParams(articleIdV, titleV, minpriceV, maxpriceV);
                List<LP> listl = this.lpRepository.findByArticleParams(articleIdV, titleV, minpriceV, maxpriceV);
                if (listb != null) {
                    resultList.addAll(listb);
                }
                if (listg != null) {
                    resultList.addAll(listg);
                }
                if (listl != null) {
                    resultList.addAll(listl);
                }
                break;
            }
            case ("book"): {
                resultList.addAll(this.bookRepository.findByArticleParams(articleIdV, titleV, minpriceV, maxpriceV, Sort.unsorted()));
                break;

            }
            case ("game"): {
                resultList.addAll(this.gameRepository.findByArticleParams(articleIdV, titleV, minpriceV, maxpriceV));
                break;

            }
            case ("lp"): {
                resultList.addAll(this.lpRepository.findByArticleParams(articleIdV, titleV, minpriceV, maxpriceV));
                break;
            }
        }


        return resultList;
    }
}
