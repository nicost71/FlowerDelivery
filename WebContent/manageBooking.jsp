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
		<nav class="navbar navbar-default" style="margin-bottom: 40px">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="start.jsp"> <img alt="Brand"
					src="assets/icons/home.png" style="max-width: 20px">
				</a> <span class="navbar-brand"
					style="border-left: 1px solid rgba(0, 0, 0, 0.2); margin-left: 0px; font-size: 15px">
					Manage Booking </span>
			</div>
		</div>
		</nav>
		<h2 class="text-center">Manage Booking</h2>
		<%
			ArrayList<Order> orders = (ArrayList<Order>) request.getAttribute("orders");
			if (orders == null || orders.size() == 0) {
		%>
		<div class="login-container">

			<form action="OrderServlet" method="POST">
				<input type="hidden" name="requestType" value="userCheckOrder">


				<div class="input-group" style="margin-bottom: 10px">
					<span class="input-group-addon"><i
						class="custom-icon icon-person small"></i></span> <input type="text"
						class="form-control" name="userPhoneNum"
						placeholder="Phone Number">
				</div>

				<div class="input-group" style="margin-bottom: 10px">
					<span class="input-group-addon"><i
						class="custom-icon icon-lock small"></i></span> <input type="password"
						class="form-control" name="password" placeholder="Password">
				</div>

				<div class="text-center voffset30">
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