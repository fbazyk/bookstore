package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

}
