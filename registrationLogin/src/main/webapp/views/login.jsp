<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-image: url('<c:url value="/images/a.gif"/>');
	background-size: cover;
	text-align: center;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.login-container {
	background-color: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
	width: 320px;
	text-align: center;
}

h1 {
	color: #333;
	font-size: 28px;
	margin-bottom: 20px;
}

h4 {
	color: red;
	font-size: 16px;
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
	background-color: #0056b3;
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
	background-color: #007BFF;;
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
	.login-container {
		width: 90%;
	}
}
</style>

</head>
<body>
	<div class="login-container">
		<h1>Login</h1>

		<c:if test="${not empty errorMsg}">
			<h4>${errorMsg}</h4>
		</c:if>

		<form action="dashboard" method="post">
			<label>Email:</label> <input type="text" name="email" required /> <label>Password:</label>
			<input type="password" name="password" required /> <input
				type="submit" value="Login" />
		</form>
		<br> <a href="/index.html">Back</a>
	</div>
</body>
</html>
