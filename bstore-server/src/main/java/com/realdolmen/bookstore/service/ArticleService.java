package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.dto.SearchDTO;
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
    private OrderItemRepository orderItemRepository;


    @PersistenceContext
    private EntityManager entityManager;

    Logger logger = LoggerFactory.getLogger(ArticleService.class);

    @Autowired
    public ArticleService(ArticleRepository articleRepository,
                          BookRepository bookRepository,
                          GameRepository gameRepository,
                          LpRepository lpRepository,
                          UserRepository userRepository,
                          OrderItemRepository orderItemRepository
    ) {
        this.articleRepository = articleRepository;
        this.bookRepository = bookRepository;
        this.gameRepository = gameRepository;
        this.lpRepository = lpRepository;
        this.userRepository = userRepository;
        this.orderItemRepository = orderItemRepository;
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

    public ArticlesPage findAllPaged(Long page, Long psize) {
        List<Book> books = this.bookRepository.findAll();
        List<Game> games = this.gameRepository.findAll();
        List<LP> lps = this.lpRepository.findAll();
        Long offset = (page - 1) * psize;
        List<Article> articles = Stream.of(books, games, lps)
                .flatMap(Collection::stream)
                .skip(offset).limit(psize)
                .collect(Collectors.toList());
        ArticlesPage resultPage = new ArticlesPage();
        resultPage.setArticles(articles);
        resultPage.setTotalArticles(Stream.of(books, games, lps).flatMap(Collection::stream).count());
        resultPage.setCurrentPage(page);
        resultPage.setTotalPages((long) Math.ceil((resultPage.getTotalArticles() / (double) psize)));
        return resultPage;
    }

    public ArticlesPage findCatPaged(Long page, Long psize, String category) {
        List<Book> books = new ArrayList<>();
        List<Game> games = new ArrayList<>();
        List<LP> lps = new ArrayList<>();
        switch (category.toUpperCase()) {
            case "BOOK": {
                books = this.bookRepository.findAll();
                break;
            }
            case "GAME": {
                games = this.gameRepository.findAll();
                break;
            }
            case "LP": {
                lps = this.lpRepository.findAll();
                break;
            }
            case "ALL": {
                books = this.bookRepository.findAll();
                games = this.gameRepository.findAll();
                lps = this.lpRepository.findAll();
                break;
            }
        }
        Long offset = (page - 1) * psize;
        List<Article> articles = Stream.of(books, games, lps)
                .flatMap(Collection::stream)
                .skip(offset).limit(psize)
                .collect(Collectors.toList());
        ArticlesPage resultPage = new ArticlesPage();
        resultPage.setArticles(articles);
        resultPage.setTotalArticles(Stream.of(books, games, lps).flatMap(Collection::stream).count());
        resultPage.setCurrentPage(page);
        resultPage.setTotalPages((long) Math.ceil((resultPage.getTotalArticles() / (double) psize)));
        return resultPage;
    }

    public Article getArticle(String type, Long id) throws ArticleNotFoundException {
        if (type != null && id != null) {
            switch (type.toUpperCase()) {
                case "BOOK": {
                    return this.bookRepository.findById(id).get();
                }
                case "GAME": {
                    return this.gameRepository.findById(id).get();
                }
                case "LP": {
                    return this.lpRepository.findById(id).get();
                }
                default: {
                    throw new ArticleNotFoundException("Wrong category");
                }
            }
        } else {
            throw new ArticleNotFoundException("Article does not exist");
        }
    }

    public Article getNotDeletedArticle(String type, Long id) throws ArticleNotFoundException {
        if (type != null && id != null) {
            switch (type.toUpperCase()) {
                case "BOOK": {
                    return this.bookRepository.findByIdAndDeletedFalse(id);
                }
                case "GAME": {
                    return this.gameRepository.findByIdAndDeletedFalse(id);
                }
                case "LP": {
                    return this.lpRepository.findByIdAndDeletedFalse(id);
                }
                default: {
                    throw new ArticleNotFoundException("Wrong category");
                }
            }
        } else {
            throw new ArticleNotFoundException("Article does not exist");
        }
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
            //TODO delete order items with this type and id
            this.orderItemRepository.deleteAllByArticleTypeAndArticleId(ArticleType.getByType(type), id);
            switch (type) {
                case "book": {
                    try {
                        Book book;
//                        this.bookRepository.deleteAllFavoriteRelationsByArticleId(id);
                        book = this.bookRepository.findById(id).get();
                        book.setDeleted(true);
                        this.bookRepository.save(book);
//                        this.bookRepository.flush();
                    } catch (Exception ex) {
                        //todo throw another exception to the controller
                        throw new ArticleNotFoundException();
                    }
                    return true;
                }
                case "game": {
                    try {
                        Game game;
//                        this.gameRepository.deleteAllFavoriteRelationsByArticleId(id);
                        game = gameRepository.findById(id).get();
                        game.setDeleted(true);
                        this.gameRepository.save(game);
//                        this.gameRepository.flush();
                    } catch (Exception ex) {
                        throw new ArticleNotFoundException();
                    }
                    return true;
                }
                case "lp": {
                    try {
                        LP lp;
//                        this.lpRepository.deleteAllFavoriteRelationsByArticleId(id);
                        lp = lpRepository.findById(id).get();
                        lp.setDeleted(true);
                        this.lpRepository.save(lp);
//                        this.lpRepository.flush();
                    } catch (Exception ex) {
                        throw new ArticleNotFoundException();
                    }
                    return true;
                }
                default:
                    return false;
            }

        } else {
            return false;
        }
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
        if (sortby != null && sortorder != null) {
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


    public ArticlesPage findCatFilteredPaged(Long page, Long psize, String category, String filter) {
        logger.debug("Page {}", page);
        logger.debug("Page Size{}", psize);
        logger.debug("Category {}", category);
        logger.debug("Filter {}", filter);

        List<Book> books = new ArrayList<>();
        List<Game> games = new ArrayList<>();
        List<LP> lps = new ArrayList<>();
        switch (category.toUpperCase()) {
            case "BOOK": {
                books = this.bookRepository.findAll();
                break;
            }
            case "GAME": {
                games = this.gameRepository.findAll();
                break;
            }
            case "LP": {
                lps = this.lpRepository.findAll();
                break;
            }
            case "ALL": {
                books = this.bookRepository.findAll();
                games = this.gameRepository.findAll();
                lps = this.lpRepository.findAll();
                break;
            }
        }
        Long offset = (page - 1) * psize;
        //Filter Articles
        List<Article> filteredArticles = Stream.of(books, games, lps)
                .flatMap(Collection::stream)
                .filter(article -> {
                    logger.debug(article.getSearchTitle());
                    return article.getSearchTitle().contains(filter.replaceAll("[^a-zA-Z0-9]", " ").toLowerCase());
                })
                .collect(Collectors.toList());
        //Page Filtered Articles
        List<Article> pagedArticles = Stream.of(filteredArticles)
                .flatMap(Collection::stream)
                .skip(offset).limit(psize).collect(Collectors.toList());

        ArticlesPage resultPage = new ArticlesPage();
        resultPage.setArticles(pagedArticles);
        resultPage.setTotalArticles(Stream.of(filteredArticles).flatMap(Collection::stream).count());
        resultPage.setCurrentPage(page);
        resultPage.setTotalPages((long) Math.ceil((resultPage.getTotalArticles() / (double) psize)));
        return resultPage;
    }

    public ArticlesPage search(Long page, Long psize, String category, String filter, SearchDTO searchDto) {
        logger.debug("Page {}", page);
        logger.debug("Page Size{}", psize);
        logger.debug("Category {}", category);
        logger.debug("Filter {}", filter);
        logger.debug("Search {}", searchDto);

        Long articleIdV = null;
        BigDecimal minpriceV = null;
        BigDecimal maxpriceV = null;
        String titleV = "";
        String type = null;
        String sortby = null;
        String sortorder = null;
        logger.debug(type);

        if (searchDto.getArticleType() != null) {
            type = searchDto.getArticleType();
        }
        if (searchDto.getArticleId() != null) {
            articleIdV = searchDto.getArticleId();
        }
        if (!searchDto.getSearchTitle().isEmpty()) {
            titleV = searchDto.getSearchTitle().replaceAll("[^a-zA-Z0-9]", " ").toLowerCase();
        }
        if (searchDto.getMinPrice() != null) {
            minpriceV = BigDecimal.valueOf(searchDto.getMinPrice());
        }
        if (searchDto.getMaxPrice() != null) {
            maxpriceV = BigDecimal.valueOf(searchDto.getMaxPrice());
        }
        if (!searchDto.getSortBy().isEmpty()) {
            sortby = searchDto.getSortBy();
        }
        if (!searchDto.getSortOrder().isEmpty()) {
            sortorder = searchDto.getSortOrder();
        }
        Sort sort = Sort.by(ASC, "id");
        if (sortby != null && sortorder != null) {
            sort = Sort.by(sortorder, sortby);
        }

        logger.debug(type);

        List<Article> resultList = new ArrayList<Article>();

        switch (type.toUpperCase()) {
            case ("ALL"): {

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
            case ("BOOK"): {
                resultList.addAll(this.bookRepository.findByArticleParams(articleIdV, titleV, minpriceV, maxpriceV));
                break;

            }
            case ("GAME"): {
                resultList.addAll(this.gameRepository.findByArticleParams(articleIdV, titleV, minpriceV, maxpriceV));
                break;

            }
            case ("LP"): {
                resultList.addAll(this.lpRepository.findByArticleParams(articleIdV, titleV, minpriceV, maxpriceV));
                break;
            }
        }


        Long offset = (page - 1) * psize;
        //Filter Articles
        List<Article> filteredArticles = Stream.of(resultList)
                .flatMap(Collection::stream)
                .filter(article -> {
                    logger.debug(article.getSearchTitle());
                    return article.getSearchTitle().contains(filter.replaceAll("[^a-zA-Z0-9]", " ").toLowerCase());
                })
                .collect(Collectors.toList());
        //TODO Sort articles
        List<Article> sortedArticles;
        //TODO select sorting field
        if(sortby != null && !sortby.isEmpty()){
            switch (sortby.toUpperCase()){
                case ("TYPE"): {
                    sortedArticles         = Stream.of(filteredArticles)
                            .flatMap(Collection::stream)
                            .sorted((o1, o2) -> {
                                if(searchDto.getSortOrder().equals("ASC")){
                                    return o1.getClass().getName().compareTo(o2.getClass().getName());
                                } else {
                                    return o2.getClass().getName().compareTo(o1.getClass().getName());
                                }
                            }).collect(Collectors.toList());
                    break;
                }
                case ("ID"): {
                    sortedArticles         = Stream.of(filteredArticles)
                            .flatMap(Collection::stream)
                            .sorted((o1, o2) -> {
                                if(searchDto.getSortOrder().equals("ASC")){
                                    return o1.getId().compareTo(o2.getId());
                                } else {
                                    return o2.getId().compareTo(o1.getId());
                                }
                            }).collect(Collectors.toList());
                    break;
                }
                case ("TITLE"):{
                    sortedArticles         = Stream.of(filteredArticles)
                            .flatMap(Collection::stream)
                            .sorted((o1, o2) -> {
                                if(searchDto.getSortOrder().equals("ASC")){
                                    return o1.getSearchTitle().compareTo(o2.getSearchTitle());
                                } else {
                                    return o2.getSearchTitle().compareTo(o1.getSearchTitle());
                                }
                            }).collect(Collectors.toList());
                    break;
                }
                case ("PRICE"):{
                    sortedArticles         = Stream.of(filteredArticles)
                            .flatMap(Collection::stream)
                            .sorted((o1, o2) -> {
                                if(searchDto.getSortOrder().equals("ASC")){
                                    return o1.getPrice().compareTo(o2.getPrice());
                                }else {
                                    return o2.getPrice().compareTo(o1.getPrice());
                                }
                            }).collect(Collectors.toList());
                    break;
                }
                default :{
                    sortedArticles = filteredArticles;
                }
            }
        } else {
            sortedArticles = filteredArticles;
        }
        List<Article> categorizedArticles;
        switch (category.toUpperCase()){
            case "ALL":{
                categorizedArticles = sortedArticles;
                break;
            }
            case "BOOK":{
                categorizedArticles = Stream.of(sortedArticles).flatMap(Collection::stream).filter(article -> {
                    return article instanceof Book;
                }).collect(Collectors.toList());
                break;
            }
            case "GAME":{
                categorizedArticles = Stream.of(sortedArticles).flatMap(Collection::stream).filter(article -> {
                    return article instanceof Game;
                }).collect(Collectors.toList());
                break;
            }
            case "LP":{
                categorizedArticles = Stream.of(sortedArticles).flatMap(Collection::stream).filter(article -> {
                    return article instanceof LP;
                }).collect(Collectors.toList());
                break;
            }
            default: {
                categorizedArticles = sortedArticles;
            }
        }

        //Page Filtered Articles
        List<Article> pagedArticles = Stream.of(categorizedArticles)
                .flatMap(Collection::stream)
                .skip(offset).limit(psize).collect(Collectors.toList());

        ArticlesPage resultPage = new ArticlesPage();
        resultPage.setArticles(pagedArticles);
        resultPage.setTotalArticles(Stream.of(categorizedArticles).flatMap(Collection::stream).count());
        resultPage.setCurrentPage(page);
        resultPage.setTotalPages((long) Math.ceil((resultPage.getTotalArticles() / (double) psize)));
        return resultPage;
    }

}
