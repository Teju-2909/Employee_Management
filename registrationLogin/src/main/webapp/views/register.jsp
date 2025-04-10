<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Page</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-image: url('<c:url value="/images/g.jpg"/>');
	background-size: cover;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	padding: 0;
	text-align: center;
}

.register-container {
	background-color: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 0 15pxn rgba(0, 0, 0, 0.2);
	width: 350px;
	text-align: center;
}

h1 {
	color: #333;
	font-size: 28px;
	margin-bottom: 20px;
}

.success-msg {
	color: green;
	font-size: 16px;
	margin-bottom: 10px;
}

.error-msg {
	color: red;
	font-size: 16px;
	margin-bottom: 10px;
}

form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

input[type="text"], input[type="password"] {
	width: 90%;
	padding: 10px;
	margin: 8px 0;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 14px;
}

input[type="submit"] {
	background-color: #28a745;
	color: white;
	padding: 10px;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	transition: 0.3s;
	width: 95%;
}

input[type="submit"]:hover {
	background-color: #218838;
}

a {
	display: inline-block;
	text-decoration: none;
	font-size: 14px;
	color: #0056b3;
	margin-top: 10px;
	font-weight: bold;
}

a:hover {
	color: #007BFF;
}

@media ( max-width : 600px) {
	.register-container {
		width: 90%;
	}
}
</style>
</head>
<body>
	<div class="register-container">
		<h1>Register</h1>

		<c:if test="${not empty successMsg}">
			<h4 class="success-msg">${successMsg}</h4>
		</c:if>

		<c:if test="${not empty errorMsg}">
			<h4 class="error-msg">${errorMsg}</h4>
		</c:if>

		<form action="regForm" method="post">
			<label>Name:</label> <input type="text" name="name" required /> <label>Email:</label>
			<input type="text" name="email" required /> <label>Password:</label>
			<input type="password" name="password" required /> <label>Phone
				No:</label> <input type="text" name="phoneno" required /> <label>Role:</label>
			<input type="text" name="role" required /> <input type="submit"
				value="Register" />
		</form>


		<a href="employeeList">Back</a>
	</div>
</body>
</html>
