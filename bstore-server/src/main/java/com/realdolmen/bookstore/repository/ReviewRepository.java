package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReviewRepository extends JpaRepository<Review, Long> {
}
