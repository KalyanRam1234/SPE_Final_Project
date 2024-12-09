package com.Dockerates.BookLending;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.Dockerates.BookLending.Entity.Role;
import com.Dockerates.BookLending.Entity.User;
import com.Dockerates.BookLending.Exception.UserDuplicateEmailException;
import com.Dockerates.BookLending.Repository.UserRepository;
import com.Dockerates.BookLending.Service.UuidService;

@SpringBootApplication
public class BookLendingApplication implements CommandLineRunner{


	@Value("${appusername}")
    private String username;

    @Value("${email}")
    private String email;

    @Value("${apppassword}")
    private String password;

    @Value("${role}")
    private String role;
	
	@Autowired
	private UserRepository userRepository;

	public static void main (String[] args){
		SpringApplication.run(BookLendingApplication.class, args);
	}
	
	@Override
    public void run(String... args) throws UserDuplicateEmailException {
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        
        try {
            String encodedPassword = passwordEncoder.encode(password);
            User newUser = User.builder()
                .id(UuidService.getUUID())
                .username(username)
                .email(email)
                .password(encodedPassword)
                .role(Role.ADMIN)  // Assuming role is an enum
                .build();

            userRepository.save(newUser);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

	@Bean
	public WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/**")
					.allowedOriginPatterns("*")
					// .allowedOrigins("http://library-frontend-svc:5173","http://frontend.example.com","http://frontend:5173", "http://localhost:5173", "http://localhost:5174")
					.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
					.allowedHeaders("*")
					.allowCredentials(true)
					.maxAge(3600);
			}
		};
	}

}
