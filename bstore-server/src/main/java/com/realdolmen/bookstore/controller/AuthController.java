package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4201")
@RestController
public class AuthController {

    Logger logger = LoggerFactory.getLogger(AuthController.class);

    @Autowired
    private UserService userService;
//
//    @PostMapping(path = "/auth")
//    public User authenticate(@RequestBody User user){
//        logger.debug("Incoming User: {}", user.getUserName());
//        this.userService.checkUserCredentials(user);
//        return new User();
//    }

    @GetMapping(path = "/auth")
    public @ResponseBody User authenticate1(){
        logger.debug("Incoming User:");
        Object principal = SecurityContextHolder.getContext().getAuthentication(). getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();

        }
        logger.debug(username);
        User foundUser = this.userService.findByUserName(username);
        foundUser.setPassword(null);
        return foundUser;
    }
}
