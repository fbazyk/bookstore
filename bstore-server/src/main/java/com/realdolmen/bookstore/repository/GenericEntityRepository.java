package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.GenericEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GenericEntityRepository extends JpaRepository<GenericEntity, Long> {
}
