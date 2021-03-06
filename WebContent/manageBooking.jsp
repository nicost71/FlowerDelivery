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
<link href='https://fonts.googleapis.com/css?family=Josefin+Sans' rel='stylesheet' type='text/css'>
<title>Overview Booking</title>
</head>
<body>
	<div class="container">
		<nav class="navbar navbar-default">
			<div class="navbar-header">
				<a class="navbar-img" href="start.jsp"> <img alt="Brand" class="navbar-icon"
					src="assets/icons/logo2_icon_64.png">
				</a> <span class="navbar-brand">
					Overview Bookings </span>
			</div>
		</nav>
		<h2 class="text-center">Overview Bookings</h2>
		<%
			ArrayList<Order> orders = (ArrayList<Order>) request.getAttribute("orders");
		String status = (String) request.getAttribute("status");

			if (orders == null || orders.size() == 0) {
		%>
		<div class="login-container">

			<form action="OrderServlet" method="POST">
				<input type="hidden" name="requestType" value="userCheckOrder">


				<div class="input-group boffset10">
					<span class="input-group-addon"><i
						class="custom-icon icon-person small"></i></span> <input type="text"
						class="form-control" name="userPhoneNum"
						value="<%=request.getAttribute("userPhoneNum") != null ? request.getAttribute("userPhoneNum") : ""%>"
						placeholder="Phone Number">
				</div>
										<%
							if (status != null && status.equals("invalidUser")) {
						%>
						<p class="invalid-input text-center">User not found</p>
						<%
							}
						%>

				<div class="input-group boffset10">
					<span class="input-group-addon"><i
						class="custom-icon icon-lock small"></i></span> <input type="password"
						class="form-control" name="password" placeholder="Password">
				</div>
															<%
							if (status != null && status.equals("invalidPw")) {
						%>
						<p class="invalid-input text-center">Invalid Password</p>
						<%
							}
						%>

				<div class="text-center voffset30">
					<input type="submit" class="btn btn-primary" value="Check my Orders">
				</div>

			</form>
		</div>

		<%
			}
			if (orders != null && orders.size() == 0) {
				if(status == null){
		%>
		<h4 class="text-center voffset50">No orders found</h4>
		<%
				}
			} else if (orders != null) {
		%>


		<div class="row">
			<div class="panel panel-primary booking-table">
				<div class="panel-heading">
					<h3 class="panel-title">
						Bookings for "<%=orders.get(0).getUserPhoneNum()%>"
					</h3>
				</div>
				<table class="table">
					<thead>
						<tr class="booking-table-header">
							<th><input type="text" class="form-control"
								placeholder="Flowers" disabled></th>
							<th><input type="text" class="form-control"
								placeholder="Receiver Name" disabled></th>
							<th><input type="text" class="form-control"
								placeholder="Reveiver Address" disabled></th>
							<th><input type="text" class="form-control"
								placeholder="Receiver Phone" disabled></th>
							<th><input type="text" class="form-control"
								placeholder="Next Delivery Day" disabled></th>
						</tr>
					</thead>
					<tbody>
						<%
							for (int i = 0; i < orders.size(); i += 1) {
						%>
						
						<tr class="<%=orders.get(i).getTimesLeft() > 0 ? "rowColor-current" : "rowColor-old" %>">
							<td><%=orders.get(i).getFlowers()%></td>
							<td><%=orders.get(i).getReceiverName()%></td>
							<td><%=orders.get(i).getReceiverAddr()%></td>
							<td><%=orders.get(i).getReceiverPhone()%></td>
							<td><%=orders.get(i).getNextDeliveryDay()%></td>

						</tr>
						<%
							}
						%>
					</tbody>
				</table>
			</div>
		</div>


		<%
			}
		%>
	</div>

</body>
</html>