<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>Dashboard</title>
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
	padding: 20px;
	width: calc(100% - 250px);
	text-align: center;
}

h1 {
	color: #333;
	font-size: 26px;
	margin-bottom: 10px;
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
}

.dashboard-card {
	display: inline-block;
	background-color: #1C4E80;
	color: white;
	padding: 20px;
	border-radius: 10px;
	margin: 10px;
	width: 20%;
	height: 100px;
	text-align: center;
	font-size: 18px;
}

.admin-panel {
	margin-top: 20px;
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

.dashboard-card h2 {
	font-size: 18px;
	font-weight: bold;
	word-wrap: break-word;
	overflow-wrap: break-word;
	white-space: normal; 
	max-width: 100%; 
}

.dashboard-card h2 a {
	color: white;
}

.btn:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>

	
	<div class="sidebar">
		<h2>Dashboard</h2>


		<c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">

			<a href="regPage">🔐 Register New User</a>

		</c:if>
		<a href="employeeList?showSearch=false">👥 View Employees</a>
		<c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
			<a href="add">➕ Add Employee</a>


		</c:if>
		<a href="employeeSearchList?showSearch=true"> 🔍 Search By Department:</a> 
			<a href="/employees/attendance/list">✨ View Attendance Records</a> 
			<a href="/employees/logout">🚪 Logout</a>
	</div>

	<!-- Main Content -->
	<div class="main-content">
		<div class="container">
			<div class="top-bar">
				<h1>Student Management System</h1>
			</div>


			<div class="dashboard-card">
				<p>Total Employees</p>
				<h2>${totalEmployees}</h2>
			</div>

			<div class="dashboard-card">
				<p>Total Users</p>
				<h2>${totalUsers}</h2>
			</div>


			<c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
				<div class="dashboard-card">
					<p>Who Logged In Before</p>
					<h2>${lastLoggedInUser}</h2>
				</div>


			</c:if>



			<c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
				<div class="dashboard-card">
					<p>See last Modification</p>
					<h2>
						<a href="/employees/modification">Click Here</a>
					</h2>

				</div>
			</c:if>




			<div class="dashboard-card">
				<p>Show Employee Attendance</p>
				<h2>
					<a href="/employees/attendance/list">View Attendance Records</a>
				</h2>
			</div>


			<br>

		</div>
	</div>

</body>
</html>
