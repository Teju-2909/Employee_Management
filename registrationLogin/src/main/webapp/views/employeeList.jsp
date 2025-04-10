<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>Employee List</title>
<style>
body {
	font-family: 'Poppins', sans-serif;
	background-color: #f4f7f6;
	margin: 0;
	padding: 0;
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
}

.container {
	background-color: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	width: 90%;
	max-width: 1100px;
	margin: auto;
}

h1 {
	color: #333;
	font-size: 28px;
	margin-bottom: 20px;
	text-align: center;
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}


form {
	text-align: center;
	margin-bottom: 25px;
}

form label {
	font-weight: bold;
	font-size: 16px;
	margin-right: 10px;
	color: #333;
}

form select {
	padding: 10px 12px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 15px;
	margin-right: 10px;
}

form input[type="submit"] {
	padding: 10px 20px;
	background-color: #0056b3;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	font-size: 15px;
}

form input[type="submit"]:hover {
	background-color: #007BFF;
}

.btn {
	display: inline-block;
	text-decoration: none;
	background-color: #007BFF;
	color: white;
	padding: 10px 15px;
	border-radius: 5px;
	font-size: 14px;
	transition: 0.3s ease-in-out;
	margin: 5px;
}

.logout-btn {
	background-color: #dc3545;
}

.logout-btn:hover {
	background-color: #c82333;
}

.delete-all-btn {
	background-color: #ff4500;
}

.delete-all-btn:hover {
	background-color: #d73800;
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
	text-align: left;
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

.action-links a {
	text-decoration: none;
	padding: 6px 12px;
	border-radius: 4px;
	font-size: 14px;
	margin: 0 5px;
	display: inline-block;
	transition: 0.3s ease-in-out;
}

.edit-link {
	background-color: #28a745;
	color: white;
}

.edit-link:hover {
	background-color: #218838;
}

.attendance-link {
	background-color: #6CA6CD;
	color: white;
}

.attendance-link:hover {
	background-color: #218838;
}

.delete-link {
	background-color: #dc3545;
	color: white;
}

.delete-link:hover {
	background-color: #c82333;
}

.back-btn {
	background-color: #6c757d;
}

.back-btn:hover {
	background-color: #5a6268;
}
</style>

<script>
window.onload = function() {
	var successMessage = "<%=request.getAttribute("successMessage")%>
	";
		if (successMessage !== "null") {
			alert(successMessage);
			window.location.href = "/employees/employeeList";
		}
	};
</script>
</head>
<body>

	
	<div class="sidebar">
		<h2>Activity Panel</h2>
		<!-- <a href="dashboard">🏠 Dashboard</a> -->
		<a href="employeeList">👥 View Employees</a> <a
			href="employeeSearchList"> 🔍 Search By Department:</a>
		<c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
			<a href="add">➕ Add Employee</a>
			
			</c:if>
			<a href="/employees/attendance/list">✨ View Attendance Records</a>
			<c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
			<a href="/employees/deleteAll"
				onclick="return confirm('Are you sure?');">❌ Delete All
				Employees</a>
		</c:if>

		<a href="dashboard">⬅ Back to Dashboard</a> <a
			href="/employees/logout">🚪 Logout</a>
	</div>

	<!-- Main Content -->
	<div class="main-content">

		<!-- Department Filter -->
		<c:if test="${showSearch}">
			<form method="get" action="employeeSearchList">
				<label for="department">


					<div style="font-size: 30px;">Search By Department :</div>

				</label><br> <select name="department" id="department">
					<option value="">All Departments</option>
					<c:forEach var="dept" items="${departments}">
						<option value="${dept}"
							${dept == selectedDepartment ? 'selected' : ''}>${dept}</option>
					</c:forEach>
				</select> <input type="submit" value="Search" />
			</form>

		</c:if>



		<div class="container">
			<div class="top-bar">
				<h1>Employee List</h1>
			</div>

			<table>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Department</th>
					<th>Contact</th>
					<th>Address</th>
					<th>Actions</th>
				</tr>
				<c:choose>
					<c:when test="${not empty employees}">
						<c:forEach var="emp" items="${employees}">
							<tr>
								<td>${emp.id}</td>
								<td>${emp.name}</td>
								<td>${emp.department}</td>
								<td>${emp.contact}</td>
								<td>${emp.address}</td>
								<td class="action-links"><a href="edit/${emp.id}"
									class="edit-link">Edit</a> <c:if
										test="${sessionScope.loggedInUser.role == 'ADMIN'}">
										<a href="delete/${emp.id}" class="delete-link"
											onclick="return confirm('Are you sure you want to delete this employee?');">
											Delete </a>
									</c:if> <a href="attendance/${emp.id}" class="attendance-link">attendance</a>

								</td>

							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6">No employees found.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div>
</body>
</html>
