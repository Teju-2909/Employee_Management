package com.registrationLogin.main.Dao;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.registrationLogin.main.entities.Employee;
import com.registrationLogin.main.repository.EmployeeRepository;
import com.registrationLogin.main.repository.UserRepository;

@Repository
public class EmployeeDao {

	@Autowired
	private EmployeeRepository employeeRepository;
	private UserRepository userRepository;

	public Employee addEmployee(Employee emp) {
		try {
			return employeeRepository.save(emp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Employee> findAllEmployees() {
		return employeeRepository.findAll();
	}

	public Employee getEmployeeById(long id) {
		return employeeRepository.findById(id).orElse(null);
	}

	public Employee updateEmployee(Employee employee) {
		return employeeRepository.save(employee);
	}

	public void deleteEmployee(long id) {
		employeeRepository.deleteById(id);
	}

	public void deleteAllEmployees() {
		employeeRepository.deleteAll();
	}

	public long countEmployees() {
		return employeeRepository.count();
	}

	public long count() {
		return employeeRepository.count();
	}

	public Object findById(Long id) {
		return null;
	}

	public Employee updateEmployee(Long id, Employee newEmployeeData, String username) {
		Employee existingEmployee = employeeRepository.findById(id).orElse(null);

		if (existingEmployee == null) {
			throw new RuntimeException("Employee not found");
		}

		StringBuilder changes = new StringBuilder();
		changes.append("Changes made to Employee ID: ").append(existingEmployee.getId()).append(". ");

		if (!existingEmployee.getName().equals(newEmployeeData.getName())) {
			changes.append("Name changed from ").append(existingEmployee.getName()).append(" to ")
					.append(newEmployeeData.getName()).append(". ");
			existingEmployee.setName(newEmployeeData.getName());
		}
		if (!existingEmployee.getDepartment().equals(newEmployeeData.getDepartment())) {
			changes.append("Department changed from ").append(existingEmployee.getDepartment()).append(" to ")
					.append(newEmployeeData.getDepartment()).append(". ");
			existingEmployee.setDepartment(newEmployeeData.getDepartment());
		}
		if (existingEmployee.getContact() != newEmployeeData.getContact()) {
			changes.append("Contact changed from ").append(existingEmployee.getContact()).append(" to ")
					.append(newEmployeeData.getContact()).append(". ");
			existingEmployee.setContact(newEmployeeData.getContact());
		}
		if (!existingEmployee.getAddress().equals(newEmployeeData.getAddress())) {
			changes.append("Address changed from ").append(existingEmployee.getAddress()).append(" to ")
					.append(newEmployeeData.getAddress()).append(". ");
			existingEmployee.setAddress(newEmployeeData.getAddress());
		}

		existingEmployee.setModifiedBy(username);
		existingEmployee.setModifiedAt(LocalDateTime.now());
		existingEmployee.setModificationDetails(changes.toString());

		return employeeRepository.save(existingEmployee);
	}

	public Employee findTopByOrderByModifiedAtDesc() {
		return employeeRepository.findTopByOrderByModifiedAtDesc();
	}

	public List<Employee> findByDepartment(String department) {
		return employeeRepository.findByDepartment(department);
	}

	public List<String> findDistinctDepartments() {
		return employeeRepository.findDistinctDepartments();
	}
}
