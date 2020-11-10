package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.Book;
import com.realdolmen.bookstore.model.LP;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.util.List;

public interface LpRepository extends JpaRepository<LP, Long> {
    @Query("SELECT l FROM LP l " +
            "WHERE (:articleId is null or l.id = :articleId) " +
            " and  (:title is null or lower(l.title) like lower(concat('%',:title,'%'))) " +
            " and (:minprice is null or l.price >= :minprice) " +
            " and (:maxprice is null or l.price <= :maxprice)")
    List<LP> findByArticleParams(
            @Param("articleId") Long articleId,
            @Param("title") String title,
            @Param("minprice") BigDecimal minprice,
            @Param("maxprice") BigDecimal maxprice);
}
