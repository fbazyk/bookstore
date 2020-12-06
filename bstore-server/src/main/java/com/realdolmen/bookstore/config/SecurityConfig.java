package com.realdolmen.bookstore.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

public class SecurityConfig extends WebSecurityConfigurerAdapter
{
    Logger logger = LoggerFactory.getLogger(SecurityConfig.class);

    @Override
    protected void configure(HttpSecurity http) throws Exception
    {
        logger.debug("Security Configuration Running");
        http
                .csrf().disable()
                .authorizeRequests().anyRequest().authenticated()
                .and()
                .httpBasic();
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth)
            throws Exception
    {


        auth.inMemoryAuthentication()
                .withUser("admin")
                .password("{noop}password")
                .roles("USER", "ADMIN");


    }
}
