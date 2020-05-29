package com.realdolmen.bookstore.jpaclassification;

import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.model.Book;
import com.realdolmen.bookstore.model.LP;
import org.springframework.data.jpa.domain.Specification;

import java.time.LocalDate;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.function.Predicate;

import static javafx.scene.input.KeyCode.T;


public class ArticleSpecifications {

    public static Specification<Book> bookHasAuthor(String author) {
        return (root, query, cb) ->{
            return cb.like(root.get("author"), author);
        };
    }
    public static Specification<LP> lpHasArtist(String artist) {
        return (root, query, cb) ->{
            return cb.lessThan(root.get("artist"), artist);
        };
    }

    public static Specification<Book> bookHasAuthor2(String author) {
        return (root, query, cb) -> author == null ? null : cb.like(root.get("author"), author);
    }

    public static Specification<Book> withPages(String rating) {
        return (root, query, cb) -> rating == null ? null : cb.equal(root.get("rating"), rating);
    }

    public static Specification<Book> withIsbn(Long isbn) {
        return (root, query, cb) -> isbn == null ? null : cb.equal(root.get("isbn"), isbn);
    }



//    CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
//    CriteriaQuery<Item> criteriaQuery = criteriaBuilder.createQuery(Item.class);
//    Root<Article> itemRoot = criteriaQuery.from(Item.class);

//    public static Specification<Book> bookHasAuthor() {
//        return new Specification<Book> {
//            public Predicate toPredicate(Root<T> root, CriteriaQuery query, CriteriaBuilder cb) {
//                return cb.equal(root.get(Customer_.birthday), today);
//            }
//        };
//    }
//
//    public static Specification<Book> getBookByAuthor(String author) {
//        return (root, query, criteriaBuilder) -> {
//            return criteriaBuilder.equal(root.get(Book_.autor), author);
//        };
//    }
//
//    public static Specification<Book> isLongTermCustomer() {
//        return new Specification<Book>() {
//            public Predicate toPredicate(Root<> root, CriteriaQuery query, CriteriaBuilder cb) {
//                return cb.lessThan(root.get(Book_.createdAt), new LocalDate.minusYears(2));
//            }
//        };
//    }
}
