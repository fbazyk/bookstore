package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.dto.NewUserDTO;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(origins = "http://localhost:4201")
public class RegistrationController {


    Logger logger = LoggerFactory.getLogger(RegistrationController.class);

    @Autowired
    private UserService userService;

    @GetMapping(value = "/register/{username}")
    public ResponseEntity<?> checkUsername(@PathVariable String username){
        try{
            User user = this.userService.findByUserName(username);
            return ResponseEntity.status(HttpStatus.I_AM_A_TEAPOT).body("User Already Exists!");
        } catch (Exception exception) {
            return new ResponseEntity<Object>(
                    "Username available", HttpStatus.OK);
        }

    }

    @PostMapping(value = "/register")
    public ResponseEntity<?> registerUser(@RequestBody NewUserDTO newUserDTO){
        logger.debug("register {}", newUserDTO.getUsername());
        try{
            this.userService.create(newUserDTO);

        }catch (Exception ex){
            logger.debug(ex.getMessage());
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }finally {
        }
        return new ResponseEntity<>(HttpStatus.OK);

    }
}
