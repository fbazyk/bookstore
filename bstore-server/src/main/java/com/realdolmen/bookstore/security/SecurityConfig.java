package com.realdolmen.bookstore.security;

import com.realdolmen.bookstore.model.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
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
    private final UserDetailsService userDetailsService;


    public SecurityConfig(PasswordEncoder passwordEncoder,
                          @Qualifier("userDetailsServiceImplementation")
                                  UserDetailsService userDetailsService) {
        this.passwordEncoder = passwordEncoder;
        this.userDetailsService = userDetailsService;
    }


    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http
                .cors().and().csrf().disable()
                .authorizeRequests()
//                .antMatchers(HttpMethod.OPTIONS, "/**").permitAll()
                .antMatchers("/auth/**").permitAll()
                .antMatchers("/register/**").permitAll()
                .antMatchers(HttpMethod.DELETE, "/article/**").hasAuthority("ADMIN")
                .antMatchers(HttpMethod.PUT, "/article/**").hasAuthority("ADMIN")
                .antMatchers(HttpMethod.GET, "/users/id/**").hasAuthority("USER")
                .antMatchers(HttpMethod.GET, "/users/name/**").hasAnyAuthority("USER", "ADMIN")
                .antMatchers(HttpMethod.GET, "/users/**").hasAuthority("ADMIN")
                .antMatchers(HttpMethod.POST, "/article/search**").hasAnyAuthority("USER", "ADMIN")
                .antMatchers(HttpMethod.POST, "/article/**").hasAuthority("ADMIN")
                .antMatchers(HttpMethod.GET, "/orders/new").hasAuthority("ADMIN")
                .antMatchers(HttpMethod.GET, "/orders/plist/**").hasAuthority("ADMIN")
//                .antMatchers(HttpMethod.GET, "/articlespaged?**").hasAnyRole("USER", "ADMIN")
//                .antMatchers(HttpMethod.GET, "/articlescatpaged?**").hasAnyRole("USER", "ADMIN")
//                .antMatchers(HttpMethod.GET, "/articlescatfilteredpaged?**").hasAnyRole("USER", "ADMIN")
                .antMatchers( "/reviews/**").hasAnyAuthority("USER", "ADMIN")
//                .antMatchers(HttpMethod.POST, "/favorites/**").hasAnyRole("USER", "ADMIN")
//                .antMatchers(HttpMethod.POST, "/users/address").hasAnyAuthority("USER", "ADMIN")
//                .antMatchers(HttpMethod.GET, "/articles/**").hasAnyAuthority("USER", "ADMIN")
//                .antMatchers(HttpMethod.DELETE, "/orderitem/**").hasAnyAuthority("USER", "ADMIN")
//                .antMatchers(HttpMethod.GET, "/reviews/**").hasAnyAuthority("USER", "ADMIN")
//                .antMatchers(HttpMethod.GET,"/admin/**").hasAnyRole(UserRole.ADMIN.name(), UserRole.SUBADMIN.name())
//                .antMatchers(HttpMethod.DELETE, "/admin/**").hasRole(UserRole.ADMIN.name())
//                .antMatchers(HttpMethod.PUT, "/admin/**").hasRole(UserRole.ADMIN.name())
//                .antMatchers(HttpMethod.POST, "/admin/**").hasRole(UserRole.ADMIN.name())
//                .antMatchers(HttpMethod.OPTIONS, "/admin/test3").hasAnyAuthority(UserPermission.COURSES_READ.getPermission(), UserPermission.STUDENT_READ.getPermission())
//                .antMatchers(HttpMethod.OPTIONS, "/admin/test3").hasRole(UserRole.ADMIN.name())
                .anyRequest().authenticated().and().httpBasic();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(daoAuthenticationProvider());
    }

    @Override
    protected UserDetailsService userDetailsService() {
        UserDetails user = User.builder()
                .username("soren")
                .password(passwordEncoder.encode("either"))
                .roles(UserRole.USER.name())
                .authorities("ROLE_USER")
                .build();

        UserDetails admin = User.builder()
                .username("andy")
                .password(passwordEncoder.encode("campbells"))
                .roles(UserRole.ADMIN.name())
                .authorities("ROLE_ADMIN")
                .build();

        return new InMemoryUserDetailsManager(user, admin);
    }


    @Bean
    protected DaoAuthenticationProvider daoAuthenticationProvider() {
        DaoAuthenticationProvider daoAuthenticationProvider = new DaoAuthenticationProvider();
        daoAuthenticationProvider.setPasswordEncoder(passwordEncoder);
        daoAuthenticationProvider.setUserDetailsService(userDetailsService);
        return daoAuthenticationProvider;
    }
}
