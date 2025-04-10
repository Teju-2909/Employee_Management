package com.registrationLogin.main.repository;

import com.registrationLogin.main.entities.Attendance;
import com.registrationLogin.main.entities.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
    List<Attendance> findByEmployee(Employee employee);
    List<Attendance> findByDate(LocalDate date);
    List<Attendance> findByEmployeeAndDateBetween(Employee employee, LocalDate start, LocalDate end);

    @Query("SELECT a FROM Attendance a WHERE " +
           "(:employeeId IS NULL OR a.employee.id = :employeeId) AND " +
           "(:month IS NULL OR FUNCTION('DATE_FORMAT', a.date, '%Y-%m') = :month)")
    List<Attendance> findByEmployeeAndMonth(@Param("employeeId") String employeeId,
                                            @Param("month") String month);
    
    List<Attendance> findByEmployeeId(Long employeeId);
    List<Attendance> findByDateBetween(LocalDate start, LocalDate end);
    List<Attendance> findByEmployeeIdAndDateBetween(Long employeeId, LocalDate start, LocalDate end);
}
