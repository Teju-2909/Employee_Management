package com.registrationLogin.main.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.registrationLogin.main.Dao.EmployeeDao;
import com.registrationLogin.main.entities.Employee;

@Service
public class EmployeeServices {

	@Autowired
	private EmployeeDao employeeDao;

	public Employee addEmployee(Employee emp) {
		return employeeDao.addEmployee(emp);
	}

	public List<Employee> getAllEmployees() {
		List<Employee> employees = employeeDao.findAllEmployees();
		System.out.println("Employees fetched: " + employees.size()); // Debugging line
		return employees;
	}

	public Employee getEmployeeById(long id) {
		return employeeDao.getEmployeeById(id);

	}

	public Employee updateEmployee(long id, Employee employee) {
		Employee existingEmployee = employeeDao.getEmployeeById(id);
		if (existingEmployee != null) {
			existingEmployee.setName(employee.getName());
			existingEmployee.setDepartment(employee.getDepartment());
			existingEmployee.setContact(employee.getContact());
			existingEmployee.setAddress(employee.getAddress());
			return employeeDao.updateEmployee(existingEmployee);
		}
		return null;
	}
	
	
	
	   
	 public Employee updateEmployee(Long id, Employee newEmployeeData, String username) {
	        return employeeDao.updateEmployee(id, newEmployeeData, username);
	    }

	

	public String deleteEmployee(long id) {
		Employee existingEmployee = employeeDao.getEmployeeById(id);
		if (existingEmployee != null) {
			employeeDao.deleteEmployee(id);
			return "Employee with ID " + id + " deleted successfully.";
		}
		return "Employee with ID " + id + " not found.";
	}

	public String deleteAllEmployees() {
		long count = employeeDao.countEmployees();
		if (count > 0) {
			employeeDao.deleteAllEmployees();
			return "All employees deleted successfully.";
		}
		return "No employees found to delete.";
	}

	public long getEmployeeCount() {

		return employeeDao.count();
	}

	public Employee getLastModifiedEmployee() {
        return employeeDao.findTopByOrderByModifiedAtDesc(); 
	
	}

	public List<Employee> getEmployeesByDepartment(String department) {
	    return employeeDao.findByDepartment(department);
	}

	public List<String> getAllDepartments() {
	    return employeeDao.findDistinctDepartments();
	}




}
