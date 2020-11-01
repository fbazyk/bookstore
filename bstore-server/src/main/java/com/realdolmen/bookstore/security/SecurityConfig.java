package com.realdolmen.bookstore.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final PasswordEncoder passwordEncoder;

    @Autowired
    public SecurityConfig(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }


    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http
                .authorizeRequests()
//                .antMatchers("/api/**").hasAnyRole(UserRole.STUDENT.name(), UserRole.ADMIN.name())
//                .antMatchers(HttpMethod.GET,"/admin/**").hasAnyRole(UserRole.ADMIN.name(), UserRole.SUBADMIN.name())
//                .antMatchers(HttpMethod.DELETE, "/admin/**").hasRole(UserRole.ADMIN.name())
//                .antMatchers(HttpMethod.PUT, "/admin/**").hasRole(UserRole.ADMIN.name())
//                .antMatchers(HttpMethod.POST, "/admin/**").hasRole(UserRole.ADMIN.name())
//                .antMatchers(HttpMethod.OPTIONS, "/admin/test3").hasAnyAuthority(UserPermission.COURSES_READ.getPermission(), UserPermission.STUDENT_READ.getPermission())
//                .antMatchers(HttpMethod.OPTIONS, "/admin/test3").hasRole(UserRole.ADMIN.name())
                .antMatchers("/**", "index", "/css/*","/js/*").permitAll()
                .anyRequest().authenticated().and().httpBasic();
    }

    @Override
    @Bean
    protected UserDetailsService userDetailsService() {
        UserDetails user = User.builder()
                .username("soren")
                .password(passwordEncoder.encode("either"))
                .authorities("ROLE_USER")
                .build();

        UserDetails admin = User.builder()
                .username("andy")
                .password(passwordEncoder.encode("campbells"))
//                .roles(UserRole.ADMIN.name())
                .authorities("ROLE_ADMIN")
                .build();

        return new InMemoryUserDetailsManager(user, admin);
    }
}
