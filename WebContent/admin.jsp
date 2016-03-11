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

<script type="text/javascript">
	function toggleEdit(order) {
		console.log("order: ",order);
		var inputs = document.getElementsByClassName("input-toggle");
		var update = false;
		for (var i = 0; i < inputs.length; i++) {
			if (inputs[i].classList.contains("input-editable")) {
				inputs[i].classList.remove("input-editable");
				inputs[i].classList.add("input-not-editable");
		        update = true;
			} else {
				inputs[i].classList.remove("input-not-editable");
				inputs[i].classList.add("input-editable");
			}
		}
		if(update){
	        document.getElementById('edit').setAttribute('style','visibility:visible');
	        document.getElementById('confirmEdit').setAttribute('style','visibility:hidden');
		}else{
	        document.getElementById('edit').setAttribute('style','visibility:hidden');
	        document.getElementById('confirmEdit').setAttribute('style','visibility:visible');
		}

	}
</script>
</head>
<body>
	<div class="container">
		<h2 class="text-center">All Bookings</h2>

		<%
			ArrayList<Order> orders = (ArrayList<Order>) request.getAttribute("orders");
			boolean edit = false;
			if (orders != null && orders.size() == 0) {
		%>
		<h4 class="text-center voffset50">No orders found</h4>
		<%
			} else if (orders != null) {
		%>

		<div class="row">
			<div class="panel panel-primary booking-table">
				<div class="panel-heading">
					<h3 class="panel-title">All Orders</h3>
					<span id="edit" class="pull-right" onclick="toggleEdit()" style="visibility: visible"> <img
						alt="Edit" src="assets/icons/edit_64.png" style="max-width: 20px">
					</span>
					<span id="confirmEdit" class="pull-right" onclick="toggleEdit();<%OrderServlet.updateAdmin(); %>" style="visibility: hidden"> <img
						alt="Edit" src="assets/icons/ok_64.png" style="max-width: 20px">
					</span>
				</div>
				<table class="table">
					<thead>
						<tr class="booking-table-header">
							<th><input type="text" class="form-control"
								placeholder="Flowers" disabled></th>
							<th><input type="text" class="form-control"
								placeholder="Receiver Name" disabled></th>
							<th><input id="asf" type="text" class="form-control"
								placeholder="Reveiver Address" disabled></th>
							<th><input type="text" class="form-control"
								placeholder="Receiver Phone" disabled></th>
							<th col><input type="text" class="form-control"
								placeholder="Next Delivery Day" disabled></th>
						</tr>
					</thead>
					<tbody>
						<%
							for (int i = 0; i < orders.size(); i += 1) {
						%>
						<tr
							class="<%=orders.get(i).getTimesLeft() > 0 ? "rowColor-current" : "rowColor-old" %>">
							<td><input type="text"
								value="<%=orders.get(i).getFlowers()%>"
								class="input-toggle input-not-editable"></td>
							<td><input type="text"
								value="<%=orders.get(i).getReceiverName()%>"
								class="input-toggle input-not-editable"></td>
							<td><input type="text"
								value="<%=orders.get(i).getReceiverAddr()%>"
								class="input-toggle input-not-editable"></td>
							<td><input type="text"
								value="<%=orders.get(i).getReceiverPhone()%>"
								class="input-toggle input-not-editable"></td>
							<td><input type="text"
								value="<%=orders.get(i).getNextDeliveryDay()%>"
								class="input-toggle input-not-editable"></td>

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