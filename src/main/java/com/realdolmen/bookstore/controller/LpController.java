package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.model.LP;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.service.LpService;
import com.realdolmen.bookstore.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/lps")
public class LpController {

    Logger logger = LoggerFactory.getLogger(LpController.class);

    private LpService lpService;

    @Autowired
    public LpController(LpService lpService) {
        this.lpService = lpService;
    }

    @CrossOrigin
    @GetMapping
    public List<LP> findAll() {
        List<LP> result =this.lpService.findAll();
        return result;
    }
}
