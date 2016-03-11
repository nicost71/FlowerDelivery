<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.text.*,java.util.*"%>
<%@ page import="Instances.Order"%>
<%@ page import="servlets.OrderServlet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="style/bootstrap.css" />
<link type="text/css" rel="stylesheet" href="style/flowerDelivery.css" />
<title>Administrator</title>
</head>
<body>
	<div class="container">
		<h2 class="text-center">All Bookings</h2>

		<%	
		ArrayList<Order> orders = (ArrayList<Order>) request.getAttribute("orders");
			if (orders != null && orders.size() == 0) {
				System.out.println("a");
		%>
		<h4 class="text-center voffset50">No orders found</h4>
		<%
			} else if (orders != null) {
				System.out.println("b");

		%>

		<div class="row">
			<div class="panel panel-primary booking-table">
				<div class="panel-heading">
					<h3 class="panel-title">
						All Orders
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
						<tr class="${orders.get(i).getTimesLeft() > 0 ? 'rowColor-current' : 'rowColor-old'}">
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