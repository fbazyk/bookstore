package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
public class UserService {

    private UserRepository userRepository;

    Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> findAll(){
        return this.userRepository.findAll();
    }

    public void checkUserCredentials(User user) {
        logger.debug("CheckUserCredentials for {}", user.getUserName());
        this.userRepository.findByUserName(user.getUserName()).ifPresent(user1 -> {
            logger.debug(user1.getUserName());
            logger.debug(user1.getId().toString());
        });
    }

    public User findByUserName(String username) {
        logger.debug("Find User"+username+"in DB");
        Optional<User> currentUser = this.userRepository.findByUserName(username);
        //todo check optional usage
        return currentUser.get();

    }
}
