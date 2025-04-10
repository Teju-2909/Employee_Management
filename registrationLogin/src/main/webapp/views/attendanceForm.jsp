<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Mark Attendance</title>
</head>
<body>
	<h2>Mark Attendance for ${employee.name}</h2>
	<form
		action="/employees/attendance/submit"
		method="post">
		<input type="hidden" name="empId" value="${employee.id}" /> Date: <input
			type="date" name="date" required /><br /> Present: <input
			type="radio" name="present" value="true" checked /> Yes <input
			type="radio" name="present" value="false" /> No <br /> <input
			type="submit" value="Submit Attendance" />
	</form>

</body>
</html>
