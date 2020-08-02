package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.LP;
import com.realdolmen.bookstore.repository.LpRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class LpService {

    private LpRepository lpRepository;

    @Autowired
    public LpService(LpRepository lpRepository) {
        this.lpRepository = lpRepository;
    }

    public List<LP> findAll(){
        return this.lpRepository.findAll();
    }
}
