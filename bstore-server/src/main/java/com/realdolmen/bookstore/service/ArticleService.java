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
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static org.springframework.data.domain.Sort.Direction.ASC;

@Component
public class ArticleService {

    private ArticleRepository articleRepository;
    private BookRepository bookRepository;
    private GameRepository gameRepository;
    private LpRepository lpRepository;
    private UserRepository userRepository;


    @PersistenceContext
    private EntityManager entityManager;

    Logger logger = LoggerFactory.getLogger(ArticleService.class);

    @Autowired
    public ArticleService(ArticleRepository articleRepository,
                          BookRepository bookRepository,
                          GameRepository gameRepository,
                          LpRepository lpRepository, UserRepository userRepository) {
        this.articleRepository = articleRepository;
        this.bookRepository = bookRepository;
        this.gameRepository = gameRepository;
        this.lpRepository = lpRepository;
        this.userRepository = userRepository;
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
                    //TODO check if the book with the same title exists (tolowercase)
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

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public boolean deleteByTypeById(String type, long id) throws ArticleNotFoundException {
        if (type != null && id > 0) {
            switch (type) {
                case "book": {
                    try {
                        Book book = new Book();
                        this.bookRepository.deleteAllFavoriteRelationsByArticleId(id);
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
                        this.gameRepository.deleteAllFavoriteRelationsByArticleId(id);
                        this.gameRepository.deleteById(id);
                        this.gameRepository.flush();
                    } catch (Exception ex) {
                        throw new ArticleNotFoundException();
                    }
                    return true;
                }
                case "lp": {
                    try {
                        this.lpRepository.deleteAllFavoriteRelationsByArticleId(id);
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
                    Book existingBook = this.bookRepository.findById(article.getId()).get();
                    existingBook.setAuthor(((Book) article).getAuthor());
                    existingBook.setIsbn(((Book) article).getIsbn());
                    existingBook.setPages(((Book) article).getPages());
                    existingBook.setPrice(article.getPrice());
                    existingBook.setTitle(article.getTitle());
                    existingBook.setSupplierId(article.getSupplierId());
                    this.bookRepository.saveAndFlush(existingBook);
                    return true;
                } catch (Exception ex) {
                       logger.debug(ex.getMessage());
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
        String titleV = "";
        String type = null;
        String sortby = null;
        String sortorder = null;
        logger.debug(type);

        for (Map.Entry<String, String> field : searchFields.entrySet()) {
            if (Objects.equals(field.getKey(), "id")) {
                articleIdV = Long.valueOf(field.getValue());
            }
            if (Objects.equals(field.getKey(), "title")) {
                titleV = field.getValue().replaceAll("[^a-zA-Z0-9]", " ").toLowerCase();
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
            if (Objects.equals(field.getKey(), "sortby")) {
                sortby = field.getValue();
            }
            if (Objects.equals(field.getKey(), "sortorder")) {
                sortorder = field.getValue();
            }
        }
        Sort sort = Sort.by(ASC, "id");
        if(sortby != null && sortorder != null){
            sort = Sort.by(sortorder, sortby);
        }

        logger.debug(type);

        List<Article> resultList = new ArrayList<Article>();

        switch (type) {
            case ("all"): {

                List<Book> listb = this.bookRepository.findByArticleParams(articleIdV, titleV, minpriceV, maxpriceV);
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
                resultList.addAll(this.bookRepository.findByArticleParams(articleIdV, titleV, minpriceV, maxpriceV));
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

    public Article findByTypeAndId(ArticleType articleType, Long articleId) throws Exception {
        Article result = null;
        switch (articleType) {
            case BOOK: {
                result = (Article) this.bookRepository.findById(articleId).orElseThrow(() -> {
                            return new Exception("book not found");
                        }
                );
                break;
            }
            case GAME: {
                result = this.gameRepository.findById(articleId).orElseThrow(() -> {
                    return new Exception("game not found");
                });
                break;
            }
            case LP: {
                result = this.lpRepository.findById(articleId).orElseThrow(() -> {
                    return new Exception("lp not found");
                });
                break;
            }
        }

        return result;
    }
}
