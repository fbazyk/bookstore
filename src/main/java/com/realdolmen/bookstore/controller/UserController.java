package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.model.User;
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
@RequestMapping("/users")
//@CrossOrigin(origins = "http://localhost", maxAge = 3600)
public class UserController {

    Logger logger = LoggerFactory.getLogger(UserController.class);

    private UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @CrossOrigin
    @GetMapping
    public List<User> findAll() {

        List<User> result =this.userService.findAll();
        logger.debug("Users", result.get(0));
        logger.debug("Users", result);
        return result;
    }
}
