package com.registrationLogin.main.services;

import com.registrationLogin.main.entities.Attendance;
import com.registrationLogin.main.entities.Employee;
import com.registrationLogin.main.repository.AttendanceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

@Service
public class AttendanceService {

    @Autowired
    private AttendanceRepository attendanceRepository;

    public Attendance markAttendance(Employee employee, LocalDate date, boolean present) {
        Attendance attendance = new Attendance();
        attendance.setEmployee(employee);
        attendance.setDate(date);
        attendance.setPresent(present);
        return attendanceRepository.save(attendance);
    }

    public List<Attendance> getAttendanceByEmployee(Employee employee) {
        return attendanceRepository.findByEmployee(employee);
    }

    public List<Attendance> getAttendanceByDate(LocalDate date) {
        return attendanceRepository.findByDate(date);
    }

    public List<Attendance> getAttendanceBetween(Employee employee, LocalDate start, LocalDate end) {
        return attendanceRepository.findByEmployeeAndDateBetween(employee, start, end);
    }

    public List<Attendance> getAllAttendance() {
        return attendanceRepository.findAll();
    }

    public List<Attendance> getAttendanceByFilter(String employeeId, String month) {
        return attendanceRepository.findByEmployeeAndMonth(employeeId, month);
    }

    public List<Attendance> filterAttendance(Long employeeId, YearMonth month) {
        if (employeeId != null && month != null) {
            LocalDate startDate = month.atDay(1);
            LocalDate endDate = month.atEndOfMonth();
            return attendanceRepository.findByEmployeeIdAndDateBetween(employeeId, startDate, endDate);
        } else if (employeeId != null) {
            return attendanceRepository.findByEmployeeId(employeeId);
        } else if (month != null) {
            LocalDate startDate = month.atDay(1);
            LocalDate endDate = month.atEndOfMonth();
            return attendanceRepository.findByDateBetween(startDate, endDate);
        } else {
            return attendanceRepository.findAll();
        }
    }

	public void deleteById(Long id) {
		
		        attendanceRepository.deleteById(id);
		    }

	public void deleteAll() {
		attendanceRepository.deleteAll();
	}
	
}
