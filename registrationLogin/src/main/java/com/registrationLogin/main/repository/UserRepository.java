package com.registrationLogin.main.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.registrationLogin.main.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findByEmail(String email);

	List<User> findByLastLoginBefore(LocalDateTime lastLogin);

	User findTopByEmailNotOrderByLastLoginDesc(String currentAdminEmail);

}
