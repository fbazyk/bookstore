package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.dto.NewUserDTO;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
public class UserService {

    private UserRepository userRepository;
    private PasswordEncoder passwordEncoder;

    Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
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

    public void create(NewUserDTO newUserDTO) {
        User newUser = new User();
        newUser.setPassword(this.passwordEncoder.encode(newUserDTO.getPassword()));
        newUser.setUserName(newUserDTO.getUsername());
        newUser.setRole("USER");
        newUser.setFirstName(newUserDTO.getFirstName());
        newUser.setLastName(newUserDTO.getLastName());
        newUser.setEnabled(true);
        this.userRepository.saveAndFlush(newUser);
    }

    public User findById(long id) throws Exception{
        logger.debug("Finding user by ID {}", id);
        return this.userRepository.findById(id).orElseThrow(() -> {
            return new Exception("Something went wrong");
        });
    }

    public User currentUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication(). getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();

        }
        logger.debug(username);
        User foundUser = this.findByUserName(username);
        return foundUser;
    }
}
