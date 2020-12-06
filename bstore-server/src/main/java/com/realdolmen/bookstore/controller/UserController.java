package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.dto.ExistingUserDTO;
import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.Review;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

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

    /**
     * Find User by Id
     * */

    @GetMapping(value = "/id/{id}")
    @CrossOrigin(origins = "http://localhost:4201")
    public ResponseEntity<ExistingUserDTO> userById(@PathVariable long id){
        logger.debug("User for, id {}", id);
        try{
            ExistingUserDTO foundUser = ExistingUserDTO.from(this.userService.findById(id));
            return ResponseEntity.ok().body(foundUser);

        }catch (Exception ex){
            logger.debug(ex.getMessage());
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}
