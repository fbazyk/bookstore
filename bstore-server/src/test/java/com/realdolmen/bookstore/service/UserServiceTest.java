package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.BookstoreApplication;
import com.realdolmen.bookstore.dto.NewUserDTO;
import com.realdolmen.bookstore.model.User;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import static org.junit.jupiter.api.Assertions.*;
@RunWith(SpringRunner.class)
@SpringBootTest(classes = BookstoreApplication.class)
@ContextConfiguration(classes = BookstoreApplication.class)
class UserServiceTest {

    @Autowired
    UserService userService;

    @Test
    void findAll() {
    }

    @Test
    void checkUserCredentials() {
    }

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    void findByUserName() {
        User user = this.userService.findByUserName("soren");
        assertEquals("soren", user.getUsername());
    }

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    void findByUserName__faulty() {
        assertThrows(Exception.class, () -> {
            this.userService.findByUserName("asdf");
        });
    }

    @Test
    void create() {
        NewUserDTO nud = new NewUserDTO("monty", "different", "Monty", "Python");
        User createdUser = this.userService.create(nud);
        assertEquals(3l, createdUser.getId());
    }

    @Test
    void findById() throws Exception {
        User user = this.userService.findById(1l);
        assertEquals(1l, user.getId());
        assertEquals("andy", user.getUsername());
    }

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    void currentUser() {
        User user = this.userService.currentUser();
        assertEquals("soren", user.getUserName());
        assertEquals("USER", user.getRole());
    }

    @Test
    @WithMockUser(username = "soren", password = "either", roles = "USER")
    void currentUserName() {
        assertEquals("soren", this.userService.currentUserName());
    }
}
