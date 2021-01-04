package com.realdolmen.bookstore.dto;

import com.realdolmen.bookstore.model.User;

public class NewUserDTO {
    private String username;
    private String password;
    private String firstName;
    private String lastName;

    public NewUserDTO(String username, String password, String firstName, String lastName) {
        this.username = username;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

}
