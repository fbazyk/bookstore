package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.Book;
import com.realdolmen.bookstore.model.LP;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface BookRepository extends JpaRepository<Book, Long>, JpaSpecificationExecutor<Book> {

    @Query("SELECT b FROM Book b " +
            "WHERE (:articleId is null or b.id = :articleId) " +
            " and  (:title is null or lower(b.searchTitle) like lower(concat('%',:title,'%'))) " +
            " and (:minprice is null or b.price >= :minprice) " +
            " and (:maxprice is null or b.price <= :maxprice)" +
            " and b.deleted = false")
    List<Book> findByArticleParams(
            @Param("articleId") Long articleId,
            @Param("title") String title,
            @Param("minprice") BigDecimal minprice,
            @Param("maxprice") BigDecimal maxprice);

    public Book findByIdAndDeletedFalse(Long id);

    @Modifying
    @Transactional
    @Query(name = "deleteBooksFavorites", value = "delete from users_favorite_books ufb where ufb.favorite_books_id = :bookId", nativeQuery = true)
    public void deleteAllFavoriteRelationsByArticleId(@Param("bookId") long bookId);

}
