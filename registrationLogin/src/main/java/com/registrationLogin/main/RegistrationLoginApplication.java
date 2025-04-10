package com.registrationLogin.main;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@SpringBootApplication
@EntityScan(basePackages = "com.registrationLogin.main.entities")
public class RegistrationLoginApplication {

	public static void main(String[] args) {
		System.out.println("Started");
		SpringApplication.run(RegistrationLoginApplication.class, args);
		System.out.println("Ended");
	}

}
