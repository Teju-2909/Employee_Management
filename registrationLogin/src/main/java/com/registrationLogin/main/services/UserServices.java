package com.registrationLogin.main.services;



import com.registrationLogin.main.entities.User;

public interface UserServices {

	public User loginUser(String email, String password);

	boolean registerUser(User user, String adminEmail);

	public long getUserCount();

	User findLastLoggedInUserBefore(String currentAdminEmail);

}
