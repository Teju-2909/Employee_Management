package com.registrationLogin.main.services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.registrationLogin.main.entities.User;
import com.registrationLogin.main.repository.UserRepository;

@Service
public class UserServiceImp implements UserServices {
	@Autowired
	private UserRepository repo;

	@Override

	public boolean registerUser(User user, String adminEmail) {
		User adminUser = repo.findByEmail(adminEmail);

		if (adminUser != null && "ADMIN".equals(adminUser.getRole())) {
			user.setRole("USER");
			repo.save(user);
			return true;
		}

		return false;
	}

	@Override
	public User loginUser(String email, String password) {
		User validUser = repo.findByEmail(email);

		if (validUser != null && validUser.getPassword().equals(password)) {
			validUser.setLastLogin(LocalDateTime.now());
			repo.save(validUser);
			return validUser;
		}
		return null;
	}

	@Override
	public long getUserCount() {
	
		return repo.count();
	}

	@Override
	public User findLastLoggedInUserBefore(String currentAdminEmail) {

		return repo.findTopByEmailNotOrderByLastLoginDesc(currentAdminEmail);
	}

}
