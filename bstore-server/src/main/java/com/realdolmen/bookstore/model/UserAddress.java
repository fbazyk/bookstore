package com.realdolmen.bookstore.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.realdolmen.bookstore.dto.UserAddressDTO;

import javax.persistence.*;

@Entity
@Table(name = "address")
public class UserAddress {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;

    @OneToOne(mappedBy = "address")
    @JsonBackReference
    private User user;

    @Column (name = "street")
    private String street;

    @Column (name = "number")
    private String number;

    @Column (name = "city")
    private String city;

    @Column (name = "postcode")
    private String postcode;

    @Column (name = "country")
    private String country;

    public UserAddress() {
    }

    public UserAddress(User user, UserAddressDTO updatedAddress) {
        this.user = user;
        this.street = updatedAddress.getStreet();
        this.number = updatedAddress.getNumber();
        this.city = updatedAddress.getCity();
        this.postcode = updatedAddress.getPostcode();
        this.country = updatedAddress.getCountry();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
}
