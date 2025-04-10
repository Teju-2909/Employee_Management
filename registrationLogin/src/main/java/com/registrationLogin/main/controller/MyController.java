package com.registrationLogin.main.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.registrationLogin.main.entities.Attendance;
import com.registrationLogin.main.entities.Employee;
import com.registrationLogin.main.entities.User;
import com.registrationLogin.main.services.AttendanceService;
import com.registrationLogin.main.services.EmployeeServices;
import com.registrationLogin.main.services.UserServices;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/employees")
public class MyController {

    @Autowired
    private EmployeeServices employeeService;

    @Autowired
    private UserServices userService;

    @Autowired
    private AttendanceService attendanceService;

    @GetMapping("/regPage")
    public String openRegPage(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/regForm")
    public String submitRegForm(@ModelAttribute("user") User user, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"ADMIN".equals(loggedInUser.getRole())) {
            model.addAttribute("errorMsg", "Only admins can register new users.");
            return "register";
        }

        boolean status = userService.registerUser(user, loggedInUser.getEmail());
        if (status) {
            model.addAttribute("successMsg", "User registered successfully");
        } else {
            model.addAttribute("errorMsg", "Registration failed.");
        }
        return "register";
    }

    @GetMapping("/loginPage")
    public String openLoginPage(Model model) {
        model.addAttribute("user", new User());
        return "login";
    }

    @PostMapping("/dashboard")
    public String submitLoginForm(@ModelAttribute("user") User user, Model model, HttpSession session) {
        User validUser = userService.loginUser(user.getEmail(), user.getPassword());

        if (validUser != null) {
            User lastLoggedInUser = userService.findLastLoggedInUserBefore(validUser.getEmail());
            session.setAttribute("loggedInUser", validUser);

            long totalEmployees = employeeService.getEmployeeCount();
            long totalUsers = userService.getUserCount();
            Employee lastModifiedEmployee = employeeService.getLastModifiedEmployee();

            model.addAttribute("totalEmployees", totalEmployees);
            model.addAttribute("totalUsers", totalUsers);
            model.addAttribute("lastLoggedInUser", lastLoggedInUser != null ? lastLoggedInUser.getEmail() : "No previous user found");

            if (lastModifiedEmployee != null) {
                model.addAttribute("modifiedEmployeeId", lastModifiedEmployee.getId());
                model.addAttribute("modifiedBy", lastModifiedEmployee.getModifiedBy());
                model.addAttribute("modifiedAt", lastModifiedEmployee.getModifiedAt());
                model.addAttribute("modificationDetails", lastModifiedEmployee.getModificationDetails());
            } else {
                model.addAttribute("modifiedEmployeeId", "N/A");
                model.addAttribute("modifiedBy", "N/A");
                model.addAttribute("modifiedAt", "N/A");
                model.addAttribute("modificationDetails", "No recent modifications.");
            }

            return "dashboard";
        } else {
            model.addAttribute("errorMsg", "Invalid Email or Password");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/index.html";
    }

    @GetMapping("/add")
    public String showAddEmployeeForm(Model model) {
        model.addAttribute("employee", new Employee());
        return "addEmployee";
    }

    @PostMapping("/save")
    public String saveEmployee(@ModelAttribute Employee employee, RedirectAttributes redirectAttributes) {
        employeeService.addEmployee(employee);
        redirectAttributes.addFlashAttribute("successMessage", "Data saved successfully!");
        return "redirect:/employees/add";
    }

    @GetMapping("/edit/{id}")
    public String showEditEmployeePage(@PathVariable Long id, Model model) {
        Employee employee = employeeService.getEmployeeById(id);

        if (employee != null) {
            model.addAttribute("modifiedBy", employee.getModifiedBy());
            model.addAttribute("modifiedAt", employee.getModifiedAt());
            model.addAttribute("modificationDetails", employee.getModificationDetails());
        }

        model.addAttribute("employee", employee);
        return "editEmployee";
    }

    @PostMapping("/update/{id}")
    public String updateEmployee(@PathVariable long id, @ModelAttribute Employee employee, RedirectAttributes redirectAttributes, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "You need to be logged in to edit employees.");
            return "redirect:/employees/loginPage";
        }

        Employee existingEmployee = employeeService.getEmployeeById(id);
        StringBuilder changes = new StringBuilder();

        if (!existingEmployee.getName().equals(employee.getName())) {
            changes.append("Name changed from ").append(existingEmployee.getName()).append(" to ").append(employee.getName()).append(". ");
            existingEmployee.setName(employee.getName());
        }
        if (!existingEmployee.getDepartment().equals(employee.getDepartment())) {
            changes.append("Department changed from ").append(existingEmployee.getDepartment()).append(" to ").append(employee.getDepartment()).append(". ");
            existingEmployee.setDepartment(employee.getDepartment());
        }
        if (existingEmployee.getContact() != employee.getContact()) {
            changes.append("Contact changed from ").append(existingEmployee.getContact()).append(" to ").append(employee.getContact()).append(". ");
            existingEmployee.setContact(employee.getContact());
        }
        if (!existingEmployee.getAddress().equals(employee.getAddress())) {
            changes.append("Address changed from ").append(existingEmployee.getAddress()).append(" to ").append(employee.getAddress()).append(". ");
            existingEmployee.setAddress(employee.getAddress());
        }

        existingEmployee.setModifiedBy(loggedInUser.getEmail());
        existingEmployee.setModifiedAt(LocalDateTime.now());
        existingEmployee.setModificationDetails(changes.toString());

        employeeService.updateEmployee(id, existingEmployee);
        redirectAttributes.addFlashAttribute("successMessage", "Employee updated successfully!");
        return "redirect:/employees/edit/" + id;
    }

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            return "redirect:/employees/loginPage";
        }

        long totalEmployees = employeeService.getEmployeeCount();
        long totalUsers = userService.getUserCount();
        User lastLoggedInUser = userService.findLastLoggedInUserBefore(loggedInUser.getEmail());
        Employee lastModifiedEmployee = employeeService.getLastModifiedEmployee();

        model.addAttribute("totalEmployees", totalEmployees);
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("lastLoggedInUser", lastLoggedInUser != null ? lastLoggedInUser.getEmail() : "No previous user found");

        if (lastModifiedEmployee != null) {
            model.addAttribute("modifiedEmployeeId", lastModifiedEmployee.getId());
            model.addAttribute("modifiedBy", lastModifiedEmployee.getModifiedBy());
            model.addAttribute("modifiedAt", lastModifiedEmployee.getModifiedAt());
            model.addAttribute("modificationDetails", lastModifiedEmployee.getModificationDetails());
        } else {
            model.addAttribute("modifiedEmployeeId", "N/A");
            model.addAttribute("modifiedBy", "N/A");
            model.addAttribute("modifiedAt", "N/A");
            model.addAttribute("modificationDetails", "No recent modifications.");
        }

        return "dashboard";
    }

    @GetMapping("/delete/{id}")
    public String deleteEmployeeById(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        employeeService.deleteEmployee(id);
        redirectAttributes.addFlashAttribute("successMessage", "Employee deleted successfully!");
        return "redirect:/employees/employeeList";
    }

    @GetMapping("/deleteAll")
    public String deleteAllEmployees(HttpSession session, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"ADMIN".equals(loggedInUser.getRole())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Only admins can delete all employees.");
            return "redirect:/employees/loginPage";
        }

        employeeService.deleteAllEmployees();
        redirectAttributes.addFlashAttribute("successMessage", "All employees deleted successfully!");
        return "redirect:/employees/employeeList";
    }

    @GetMapping("/modification")
    public String showModificationLog(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"ADMIN".equals(loggedInUser.getRole())) {
            return "redirect:/employees/loginPage";
        }

        Employee lastModifiedEmployee = employeeService.getLastModifiedEmployee();

        if (lastModifiedEmployee != null) {
            model.addAttribute("modifiedEmployeeId", lastModifiedEmployee.getId());
            model.addAttribute("modifiedBy", lastModifiedEmployee.getModifiedBy());
            model.addAttribute("modifiedAt", lastModifiedEmployee.getModifiedAt());
            model.addAttribute("modificationDetails", lastModifiedEmployee.getModificationDetails());
        } else {
            model.addAttribute("modifiedEmployeeId", null);
        }

        return "modification";
    }

    @GetMapping("/employeeList")
    public String showEmployeeListPage(@RequestParam(required = false) String department, Model model) {
        List<Employee> employees;

        if (department != null && !department.isEmpty()) {
            employees = employeeService.getEmployeesByDepartment(department);
        } else {
            employees = employeeService.getAllEmployees();
        }

        List<String> allDepartments = employeeService.getAllDepartments();

        model.addAttribute("employees", employees);
        model.addAttribute("departments", allDepartments);
        model.addAttribute("selectedDepartment", department);
        return "employeeList";
    }

    @GetMapping("/employeeSearchList")
    public String listEmployees(@RequestParam(required = false) String department, @RequestParam(required = false, defaultValue = "true") boolean showSearch, Model model) {
        List<Employee> employees;
        if (department != null && !department.isEmpty()) {
            employees = employeeService.getEmployeesByDepartment(department);
            model.addAttribute("selectedDepartment", department);
        } else {
            employees = employeeService.getAllEmployees();
        }

        model.addAttribute("employees", employees);

        if (showSearch) {
            List<String> departments = employeeService.getAllDepartments();
            model.addAttribute("departments", departments);
        }

        model.addAttribute("showSearch", showSearch);
        return "employeeList";
    }

    @GetMapping("/attendance/{id}")
    public String showAttendanceForm(@PathVariable Long id, Model model) {
        Employee employee = employeeService.getEmployeeById(id);
        model.addAttribute("employee", employee);
        return "attendanceForm";
    }

    @PostMapping("/attendance/submit")
    public String submitAttendance(@RequestParam Long empId, @RequestParam String date, @RequestParam boolean present, RedirectAttributes redirectAttributes) {
        Employee employee = employeeService.getEmployeeById(empId);
        LocalDate attendanceDate = LocalDate.parse(date);
        attendanceService.markAttendance(employee, attendanceDate, present);
        redirectAttributes.addFlashAttribute("successMessage", "Attendance marked successfully!");
        return "redirect:/employees/attendance/list";
    }

    @GetMapping("/attendance/view/{id}")
    public String viewEmployeeAttendance(@PathVariable Long id, Model model) {
        Employee employee = employeeService.getEmployeeById(id);
        List<Attendance> attendanceList = attendanceService.getAttendanceByEmployee(employee);
        model.addAttribute("employee", employee);
        model.addAttribute("attendanceList", attendanceList);
        return "attendanceList";
    }

    @GetMapping("/attendance/list")
    public String showAttendanceList(Model model) {
        List<Attendance> attendanceList = attendanceService.getAllAttendance();
        List<Employee> employeeList = employeeService.getAllEmployees();
        model.addAttribute("attendanceList", attendanceList);
        model.addAttribute("employeeList", employeeList);
        return "attendance-list";
    }

    @GetMapping("/attendance/filter")
    public String filterAttendance(@RequestParam(required = false) Long employeeId, @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM") YearMonth month, Model model) {
        List<Attendance> attendanceList = attendanceService.filterAttendance(employeeId, month);
        List<Employee> employeeList = employeeService.getAllEmployees();
        model.addAttribute("attendanceList", attendanceList);
        model.addAttribute("employeeList", employeeList);
        return "attendance-list";
    }
    
    @PostMapping("/attendance/delete/{id}")
    public String deleteAttendance(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            attendanceService.deleteById(id);
            redirectAttributes.addFlashAttribute("message", "Attendance record deleted successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete attendance record.");
        }
        return "redirect:/employees/attendance/list";
    }
    
    @GetMapping("/attendance/delete/{id}")
    public String deleteAttendanceViaGet(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            attendanceService.deleteById(id);
            redirectAttributes.addFlashAttribute("message", "Attendance record deleted successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete attendance record.");
        }
        return "redirect:/employees/attendance/list";
    }

    
    @PostMapping("/attendance/deleteAll")
   
    public String deleteAllAttendanceRecords(RedirectAttributes redirectAttributes) {
        try {
            attendanceService.deleteAll();
            redirectAttributes.addFlashAttribute("message", "All attendance records deleted successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete attendance records.");
        }
        return "redirect:/employees/attendance/list";
    }
    @GetMapping("/attendance/deleteAll")
    
    public String deleteAllAttendanceRecords1(RedirectAttributes redirectAttributes) {
        try {
            attendanceService.deleteAll();
            redirectAttributes.addFlashAttribute("message", "All attendance records deleted successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete attendance records.");
        }
        return "redirect:/employees/attendance/list";
    }
}
