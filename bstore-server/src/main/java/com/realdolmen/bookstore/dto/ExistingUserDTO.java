package com.realdolmen.bookstore.dto;

import com.realdolmen.bookstore.model.User;

public class ExistingUserDTO {
    private Long id;
    private String username;

    public Long getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public ExistingUserDTO(Long id, String username) {
        this.id = id;
        this.username = username;
    }


    public static ExistingUserDTO from(User user){
        return new ExistingUserDTO(user.getId(), user.getUserName());
    }
}
