<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Add Employee</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-image: url("${pageContext.request.contextPath}/images/a6.jpg");
	background-size: cover;
	background-position: center;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}
.container {
	background-color: white;
	padding: 25px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	width: 400px;
	text-align: center;
	display: flex;
	flex-direction: column;
	gap: 15px;
}
h1 {
	color: #333;
	margin-bottom: 10px;
}
input[type="text"] {
	width: 95%;
	padding: 10px;
	margin: 5px 0;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 14px;
}
input[type="submit"] {
	background-color: #0056b3;
	color: white;
	border: none;
	padding: 12px;
	width: 100%;
	cursor: pointer;
	border-radius: 5px;
	font-size: 16px;
	font-weight: bold;
	transition: background 0.3s ease;
}
input[type="submit"]:hover {
	background-color: #007BFF;
}
.back-link {
	display: inline-block;
	margin-top: 10px;
	text-decoration: none;
	color: #0056b3;
	font-size: 14px;
	font-weight: bold;
}
.back-link:hover {
	text-decoration: underline;
}
</style>
<script>
window.onload = function() {
    var successMessage = "<%=request.getAttribute("successMessage")%>";
	if (successMessage && successMessage !== "null") {
		alert(successMessage);
		window.location.href = "/employees/employeeList";
	}
};
</script>
</head>
<body>
	<div class="container">
		<h1>Add Employee</h1>
		<form action="save" method="post">
			<input type="text" name="name" placeholder="Enter Name" required>
			<input type="text" name="department" placeholder="Enter Department" required>
			<input type="text" name="contact" placeholder="Enter Contact" required>
			<input type="text" name="address" placeholder="Enter Address" required>
			<input type="submit" value="Save">
		</form>
		<a href="employeeList" class="back-link">← Back to Employee List</a>
	</div>
</body>
</html>
