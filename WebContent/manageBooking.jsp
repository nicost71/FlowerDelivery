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
<title>Manage Booking</title>
</head>
<body>
	<div class="container">
		<a href="start.jsp"><img src="Icons/home.png" width=20px
			height="20px"></a>
		<h2 class="text-center">Manage Booking</h2>
		<%
			ArrayList<Order> orders = (ArrayList<Order>) request.getAttribute("orders");
			if (orders == null || orders.size() == 0) {
		%>
		<div class="login-container">
			<form action="OrderServlet" method="POST">
				<input type="hidden" name="requestType" value="userCheckOrder">
				<div class="form-group">
					<label>Phone Nr:</label> <input type="text" name="userPhoneNum"
						class="form-control text-center" placeholder="Phone-Nr." required>
					<div class="form-group">
						<label>Password:</label> <input type="password" name="password"
							class="form-control text-center" placeholder="Password" required>
					</div>
				</div>
				<div class="text-center">
								<input type="submit" class="btn btn-primary" value="Check Order">
				
				</div>
			</form>
		</div>

		<%
			}
			if (orders != null && orders.size() == 0) {
		%>
		<h4 class="text-center voffset50">No orders found</h4>
		<%
			} else if (orders != null) {
		%>
		<div class="table-container">
		
		
		<table border="1">
			<thead>
				<tr>
					<th>Flowers</th>
					<th>Reciever Name</th>
					<th>Reciever Address</th>
					<th>Reciever Phone</th>
					<th>Next Delivery Day</th>
				</tr>
			</thead>
			<%
				for (int i = 0; i < orders.size(); i += 1) {
			%>
			<tr>
				<td><%=orders.get(i).getFlowers()%></td>
				<td><%=orders.get(i).getReceiverName()%></td>
				<td><%=orders.get(i).getReceiverAddr()%></td>
				<td><%=orders.get(i).getReceiverPhone()%></td>
				<td><%=orders.get(i).getNextDeliveryDay()%></td>

			</tr>
			<%
				}
			%>

		</table>
		</div>
		<%
			}
		%>
	</div>

</body>
</html>