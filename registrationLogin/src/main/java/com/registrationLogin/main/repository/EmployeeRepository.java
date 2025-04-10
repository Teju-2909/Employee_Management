package com.registrationLogin.main.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.registrationLogin.main.entities.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {

	Employee getEmployeeById(Long id);
	  Employee findTopByOrderByModifiedAtDesc();
	  
	  
	  List<Employee> findByDepartment(String department);

	  @Query("SELECT DISTINCT e.department FROM Employee e")
	  List<String> findDistinctDepartments();

}
