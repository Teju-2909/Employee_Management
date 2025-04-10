<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Employee</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f8f9fa;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.container {
	background-color: white;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 350px;
	text-align: center;
}

h1 {
	color: #333;
	margin-bottom: 20px;
}

input[type="text"] {
	width: 100%;
	padding: 8px;
	margin: 10px 0;
	border: 1px solid #ccc;
	border-radius: 4px;
}

input[type="submit"] {
	background-color: #28a745;
	color: white;
	border: none;
	padding: 10px;
	width: 100%;
	cursor: pointer;
	border-radius: 4px;
	font-size: 16px;
}

input[type="submit"]:hover {
	background-color: #218838;
}

.back-link {
	display: block;
	margin-top: 15px;
	text-decoration: none;
	color: #007BFF;
	font-size: 14px;
}

.back-link:hover {
	text-decoration: underline;
}
</style>
<script>

window.onload = function() {
    var successMessage = "${successMessage}";
    if (successMessage !== "" && successMessage !== "null" && successMessage !== undefined) {
        alert(successMessage);
        window.location.href = "/employees/employeeList"; 
    }
};


</script>

</head>
<body>
	<div class="container">
		<h1>Edit Employee</h1>
		<form action="../update/${employee.id}" method="post">
			<input type="text" name="name" value="${employee.name}"
				placeholder="Enter Name" required><br> <input
				type="text" name="department" value="${employee.department}"
				placeholder="Enter Department" required><br> <input
				type="text" name="contact" value="${employee.contact}"
				placeholder="Enter Contact" required><br> <input
				type="text" name="address" value="${employee.address}"
				placeholder="Enter Address" required><br> <input
				type="submit" value="Update">
		</form>
		<a href="/employees/employeeList" class="back-link">← Back to
			Employee List</a>
	</div>
</body>
</html>
