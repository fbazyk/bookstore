package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.Book;
import com.realdolmen.bookstore.model.LP;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface LpRepository extends JpaRepository<LP, Long> {
    @Query("SELECT l FROM LP l " +
            "WHERE (:articleId is null or l.id = :articleId) " +
            " and  (:title is null or lower(l.searchTitle) like lower(concat('%',:title,'%'))) " +
            " and (:minprice is null or l.price >= :minprice) " +
            " and (:maxprice is null or l.price <= :maxprice)" +
            " and l.deleted = false")
    List<LP> findByArticleParams(
            @Param("articleId") Long articleId,
            @Param("title") String title,
            @Param("minprice") BigDecimal minprice,
            @Param("maxprice") BigDecimal maxprice);

    public LP findByIdAndDeletedFalse(Long id);

    @Modifying
    @Transactional
    @Query(name = "deleteLpsFavorites", value = "delete from users_favorite_lps ufl where ufl.favorite_lps_id = :articleId", nativeQuery = true)
    public void deleteAllFavoriteRelationsByArticleId(@Param("articleId") long articleId);
}
