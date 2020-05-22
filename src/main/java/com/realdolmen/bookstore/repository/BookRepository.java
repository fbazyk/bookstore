package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookRepository extends JpaRepository<Book, Long> {
}
