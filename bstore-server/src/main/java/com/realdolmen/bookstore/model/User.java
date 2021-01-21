package com.realdolmen.bookstore.model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.realdolmen.bookstore.service.AuditListener;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Arrays;
import java.util.Collection;
import java.util.Set;

@Entity
@Table(name = "users")
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

//    @Version
//    private Integer version;

    @Column(name = "username", unique = true)
    private String userName;

    @NotNull
    @Size(max = 100)
    private String firstName;

    @NotNull
    @Size(max = 100)
    private String lastName;

    @Column(name = "role")
    private String role;

    @Column(name = "password")
    private String password;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "USER_ID")
    @JsonManagedReference
    private Set<Order> userOrders;

    @ManyToMany()
//    @JoinColumn(name = "FAV_BOOKS")
    @JoinTable(name="users_favorite_books",
            joinColumns=@JoinColumn(name = "user_id"),
            inverseJoinColumns=@JoinColumn(name = "favorite_books_id"))
    @JsonManagedReference
    private Set<Book> favoriteBooks;
    @ManyToMany()
    @JoinColumn(name = "FAV_GAMES")
    @JsonManagedReference
    private Set<Game> favoriteGames;
    @ManyToMany()
    @JoinColumn(name = "FAV_LPS")
    @JsonManagedReference
    private Set<LP> favoriteLps;

    @Column(name = "enabled")
    private Boolean enabled;

    @OneToOne
    @JoinColumn(name = "address_id", referencedColumnName = "id")
    @JsonManagedReference
    private UserAddress address;

    public Set<Book> getFavoriteBooks() {
        return favoriteBooks;
    }

    public void setFavoriteBooks(Set<Book> favoriteBooks) {
        this.favoriteBooks = favoriteBooks;
    }

    public Set<Game> getFavoriteGames() {
        return favoriteGames;
    }

//    public Integer getVersion() {
//        return version;
//    }
//
//    public void setVersion(Integer version) {
//        this.version = version;
//    }

    public void setFavoriteGames(Set<Game> favoriteGames) {
        this.favoriteGames = favoriteGames;
    }

    public Set<LP> getFavoriteLps() {
        return favoriteLps;
    }

    public void setFavoriteLps(Set<LP> favoriteLps) {
        this.favoriteLps = favoriteLps;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Arrays.asList(new SimpleGrantedAuthority(role));
    }

    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return userName;
    }

    @Override
    public boolean isAccountNonExpired() {
        return enabled;
    }

    @Override
    public boolean isAccountNonLocked() {
        return enabled;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return enabled;
    }

    @Override
    public boolean isEnabled() {
        return enabled;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Set<Order> getUserOrders() {
        return userOrders;
    }

    public void setUserOrders(Set<Order> userOrders) {
        this.userOrders = userOrders;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public UserAddress getAddress() {
        return address;
    }

    public void setAddress(UserAddress address) {
        this.address = address;
    }
}
