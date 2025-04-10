<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance List</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #f4f7f6;
            display: flex;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: #1C4E80;
            color: white;
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 20px;
            text-align: center;
            box-shadow: 2px 0px 10px rgba(0, 0, 0, 0.2);
        }
        .sidebar h2 {
            margin-bottom: 20px;
            font-size: 22px;
        }
        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 12px;
            font-size: 16px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.3);
            transition: 0.3s;
        }
        .sidebar a:hover {
            background-color: #0056b3;
        }
        .main-content {
            margin-left: 250px;
            padding: 30px;
            width: calc(100% - 250px);
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1100px;
            margin-top: 30px;
        }
        h1 {
            font-size: 30px;
            margin-bottom: 20px;
            color: #1C4E80;
            text-align: center;
        }
        form.filter-form {
            display: flex;
            justify-content: center;
            gap: 20px;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        form.filter-form label {
            font-weight: bold;
            color: #333;
        }
        form.filter-form select,
        form.filter-form input[type="month"],
        form.filter-form button {
            padding: 8px 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        form.filter-form button {
            background-color: #1C4E80;
            color: white;
            border: none;
            cursor: pointer;
        }
        form.filter-form button:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 14px 16px;
            text-align: center;
        }
        th {
            background-color: #1C4E80;
            color: white;
            text-transform: uppercase;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #eef2f5;
            transition: 0.3s;
        }
        td span.present {
            color: #2ecc71;
            font-weight: bold;
        }
        td span.absent {
            color: #e74c3c;
            font-weight: bold;
        }

        .delete-link {
            background-color: #e74c3c;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            font-size: 14px;
            cursor: pointer;
            display: inline-block;
            transition: background-color 0.3s ease, transform 0.2s ease;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
        }

        .delete-link:hover {
            background-color: #c0392b;
            transform: translateY(-1px);
        }

        .back-button {
            text-decoration: none;
            background-color: #1C4E80;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            margin-top: 20px;
            transition: 0.3s;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
        }

        @media screen and (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            .main-content {
                margin-left: 0;
                width: 100%;
            }
            table {
                width: 95%;
                font-size: 14px;
            }
            form.filter-form {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h2>Activity Panel</h2>
    <a href="/employees/employeeList">👥 View Employees</a>
    <a href="/employees/employeeSearchList">🔍 Search By Department</a>
    <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
        <a href="/employees/add">➕ Add Employee</a>
    </c:if>
    <a href="/employees/attendance/list">✨ View Attendance Records</a>
    <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
        <a href="/employees/deleteAll" onclick="return confirm('Are you sure?');">❌ Delete All Employees</a>
          </c:if>
        <a href="/employees/attendance/deleteAll" onclick="return confirm('Are you sure you want to delete all attendance records?');">❌ Delete All Attendance</a>
  
    <a href="/employees/dashboard">⬅ Back to Dashboard</a>
    <a href="/employees/logout">🚪 Logout</a>
</div>

<div class="main-content">
    <div class="container">
        <h1>Employee Attendance Records</h1>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form action="/employees/attendance/filter" method="get" class="filter-form">
            <label for="employeeId">Select Employee:</label>
            <select name="employeeId" id="employeeId">
                <option value="">All</option>
                <c:forEach var="emp" items="${employeeList}">
                    <option value="${emp.id}" <c:if test="${param.employeeId == emp.id}">selected</c:if>>${emp.name}</option>
                </c:forEach>
            </select>

            <label for="month">Select Month:</label>
            <input type="month" name="month" id="month" value="${param.month}" />

            <button type="submit">Filter</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>Employee Name</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Activity</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty attendanceList}">
                        <c:forEach var="att" items="${attendanceList}">
                            <tr>
                                <td>${att.employee.name}</td>
                                <td>${att.date}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${att.present}">
                                            <span class="present">Present</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="absent">Absent</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="action-links">
                                    <a href="/employees/attendance/delete/${att.id}" class="delete-link"
                                       onclick="return confirm('Are you sure you want to delete this attendance record?');">
                                        Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4">No attendance records found for the selected criteria.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <br><br>
        <a href="/employees/employeeList" class="back-button">← Back to Employee List</a>
    </div>
</div>
</body>
</html>
