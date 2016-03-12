<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="Instances.Order"%>
<%@ page import="java.sql.*,java.text.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link type="text/css" rel="stylesheet" href="style/bootstrap.css" />
<link type="text/css" rel="stylesheet" href="style/flowerDelivery.css" />
<title>Flower Delivery - Administrator</title>
</head>
<body>
	<div class="container">
		<a href="start.jsp"><img src="assets/icons/home.png" width=20px
			height="20px"></a>
		<h2 class="text-center">Flower Delivery - Administrator</h2>
		
		<div class="login-container">
			<form action="AdminServlet" method="post">
				<div class="form-group">
					<label>UserID</label> <input type="number" name="userID"
						class="form-control text-center" required>
					<div class="form-group">
						<label>Password:</label> <input type="password" name="password"
							class="form-control text-center" required>
					</div>
				</div>
				<div class="text-center">
								<input type="submit" class="btn btn-primary" value="Login">
				
				</div>
			</form>
		</div>
	</div>

</body>
</html>