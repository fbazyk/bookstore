package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.Game;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GameRepository extends JpaRepository<Game, Long> {
}
