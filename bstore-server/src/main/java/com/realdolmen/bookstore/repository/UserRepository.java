package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.Book;
import com.realdolmen.bookstore.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.lang.annotation.Native;
import java.util.Collection;
import java.util.Optional;
import java.util.Set;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByUserName(String username);

    Set<User> findByFavoriteBooksId(Long id);

    Set<User> findAllByFavoriteBooksIs(Book book);


//    @Native( value="Select b from Book b where b.type = :type")
//    Collection<User> targetQuery(Long id);


}
