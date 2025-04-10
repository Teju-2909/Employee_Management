<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Modification Logs</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-image: url('<c:url value="/images/a1.jpg"/>');
	background-size: cover;
	margin: 0;
	padding: 0;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	text-align: center;
}

h2 {
	color: black;
	margin-bottom: 20px;
}

.log-card {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	width: 500px;
	padding: 20px;
	text-align: left;
	border-left: 5px solid #0056b3;
}

.log-card p {
	font-size: 16px;
	margin: 10px 0;
}

.log-card b {
	color: #0056b3;
}

.no-logs {
	font-size: 18px;
	color: #666;
}

.btn-container {
	margin-top: 20px;
}

a {
	display: inline-block;
	background-color: #0056b3;
	color: white;
	padding: 10px 15px;
	text-decoration: none;
	border-radius: 5px;
	transition: background 0.3s;
}

a:hover {
	
	background-color: #007bff;
}
</style>
</head>
<body>
	<h2>Employee Modification Logs</h2>

	<c:if test="${empty modifiedEmployeeId}">
		<p class="no-logs">No recent modifications found.</p>
	</c:if>

	<c:if test="${not empty modifiedEmployeeId}">
		<div class="log-card">
			<p>
				<strong>Modified Employee ID:</strong> <b>${modifiedEmployeeId}</b>
			</p>
			<p>
				<strong>Last Modified By:</strong> <b>${modifiedBy}</b>
			</p>
			<p>
				<strong>Last Modified At:</strong> <b>${modifiedAt}</b>
			</p>
			<p>
				<strong>Changes:</strong> <b>${modificationDetails}</b>
			</p>
		</div>
	</c:if>

	<div class="btn-container">
		<a href="<c:url value='/employees/dashboard' />">Back to Dashboard</a>
	</div>
</body>
</html>
