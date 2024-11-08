package com.Dockerates.BookLending;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
public class BookLendingApplication {

	public static void main(String[] args) {
		SpringApplication.run(BookLendingApplication.class, args);
	}
	
	@Bean
	public WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/**").allowedOrigins("http://3.111.238.128:", "http://ec2-3-111-238-128.ap-south-1.compute.amazonaws.com")
				.allowedMethods("GET","POST","PUT","DELETE","OPTIONS")
				.allowCredentials(true);
			}
		};
	}

}
