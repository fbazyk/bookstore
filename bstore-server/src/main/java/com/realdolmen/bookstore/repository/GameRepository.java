package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.Book;
import com.realdolmen.bookstore.model.Game;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

public interface GameRepository extends JpaRepository<Game, Long> {
    @Query("SELECT g FROM Game g " +
            "WHERE (:articleId is null or g.id = :articleId) " +
            " and  (:title is null or lower(g.title) like lower(concat('%',:title,'%'))) " +
            " and (:minprice is null or g.price >= :minprice) " +
            " and (:maxprice is null or g.price <= :maxprice)")
    List<Game> findByArticleParams(
            @Param("articleId") Long articleId,
            @Param("title") String title,
            @Param("minprice") BigDecimal minprice,
            @Param("maxprice") BigDecimal maxprice);

    @Modifying
    @Transactional
    @Query(name = "deleteGamesFavorites", value = "delete from users_favorite_games ufg where ufg.favorite_games_id = :articleId", nativeQuery = true)
    public void deleteAllFavoriteRelationsByArticleId(@Param("articleId") long articleId);
}
