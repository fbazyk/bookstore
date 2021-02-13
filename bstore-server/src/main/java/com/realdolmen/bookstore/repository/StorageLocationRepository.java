package com.realdolmen.bookstore.repository;

import com.realdolmen.bookstore.model.StorageLocation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StorageLocationRepository extends JpaRepository<StorageLocation, Long> {
    StorageLocation findByCode(String code);
}
