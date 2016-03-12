<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.text.*,java.util.*"%>
<%@ page import="Instances.Order"%>
<%@ page import="Instances.Flower"%>
<%@ page import="servlets.OrderServlet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="style/bootstrap.css" />
<link type="text/css" rel="stylesheet" href="style/flowerDelivery.css" />
<title>Administrator</title>

<script type="text/javascript">
	function toggleEdit(index) {
		var inputs = document.getElementsByClassName("input-toggle"+index);
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
		if (update) {
			document.getElementById('edit'+index).removeAttribute("style");
			document.getElementById('confirmEdit'+index).setAttribute('style',
					'display:none');
		} else {
			document.getElementById('edit'+index).setAttribute('style',
					'display:none');
			document.getElementById('confirmEdit'+index).removeAttribute("style");
		}

	}
	
	function updateOrder(index, orderId){
		window.location = "OrderServlet?orderID="+orderId+
				"&flowers="+document.getElementById('input_flowers'+index).value+
				"&receiverName="+document.getElementById('input_receiverName'+index).value+
				"&password=null"+
				"&receiverAddr="+document.getElementById('input_receiverAddr'+index).value+
				"&receiverPhone="+document.getElementById('input_receiverPhone'+index).value+
				"&userPhoneNum="+document.getElementById('input_userPhoneNum'+index).value+
				"&nextDeliveryDay="+document.getElementById('input_nextDeliveryDay'+index).value+
				"&receivePeriod="+document.getElementById('input_receivePeriod'+index).value+
				"&timesLeft="+document.getElementById('input_timesLeft'+index).value;

	}
	function updateFlower(index, flowerId){
		console.log('uupdating flower', flowerId);
		window.location = "FlowerServlet?updateFlower=true"+
				"&flowerID="+flowerId+
				"&flowerName="+document.getElementById('input_flowerName'+index).value+
				"&description="+document.getElementById('input_description'+index).value+
				"&month="+document.getElementById('input_month'+index).value+
				"&available="+document.getElementById('input_available'+index).value;

	}
</script>
</head>
<body>
	<div class="" style="margin: 60px">
		<h1 class="text-center">Flower Delivery - Administrator</h1>
		<div class="row">
			<%
				ArrayList<Order> orders = (ArrayList<Order>) request.getAttribute("orders");
			%>
			<form action="AdminServlet" method="GET">
				<div>
					<input
						class="<%=orders == null ? "input-submit-header-inactive" : "input-submit-header-active"%>"
						type="submit" name="adminOrders" value="All Orders"> <input
						class="<%=orders != null ? "input-submit-header-inactive" : "input-submit-header-active"%>"
						type="submit" name="adminFlowers" value="All Flowers">
				</div>

			</form>

		</div>
		<%
			if (orders != null && orders.size() == 0) {
		%>
		<h4 class="text-center voffset50">No orders found</h4>
		<%
			} else if (orders != null) {
		%>
		<form action="OrderServlet" method="POST">
			<div>
				<input type="hidden" name="requestType" value="adminUpdate">
				<input type="hidden" name="orders" value="<%=orders%>">
			</div>


			<div class="row">
				<div class="panel panel-primary booking-table">
					<div class="panel-heading">
						<h3 class="panel-title">All Orders</h3>
					</div>
					<table class="table">
						<thead>
							<tr class="booking-table-header">
								<th><input type="text" class="form-control"
									placeholder="Order-ID" disabled></th>
								<th><input type="text" class="form-control"
									placeholder="Phone Nr." disabled></th>
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
								<th><input type="text" class="form-control"
									placeholder="Receive Period" disabled></th>
								<th><input type="text" class="form-control"
									placeholder="Times Left" disabled></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<%
								for (int i = 0; i < orders.size(); i += 1) {
							%>
							<tr
								class="<%=orders.get(i).getTimesLeft() > 0 ? "rowColor-current" : "rowColor-old"%>">
								<td><input type="text" id="input_orderID<%=i%>"
									value="<%=orders.get(i).getOrderID()%>"
									class="input-toggle<%=i%> input-not-editable"></td>
								<td><input type="text" id="input_userPhoneNum<%=i%>"
									value="<%=orders.get(i).getUserPhoneNum()%>"
									class="input-toggle<%=i%> input-not-editable"></td>
								<td><input type="text" id="input_flowers<%=i%>"
									value="<%=orders.get(i).getFlowers()%>"
									class="input-toggle<%=i%> input-not-editable"></td>
								<td><input type="text" id="input_receiverName<%=i%>"
									value="<%=orders.get(i).getReceiverName()%>"
									class="input-toggle<%=i%> input-not-editable"></td>
								<td><input type="text" id="input_receiverAddr<%=i%>"
									value="<%=orders.get(i).getReceiverAddr()%>"
									class="input-toggle<%=i%> input-not-editable"></td>
								<td><input type="text" id="input_receiverPhone<%=i%>"
									value="<%=orders.get(i).getReceiverPhone()%>"
									class="input-toggle<%=i%> input-not-editable"></td>
								<td><input type="text" id="input_nextDeliveryDay<%=i%>"
									value="<%=orders.get(i).getNextDeliveryDay()%>"
									class="input-toggle<%=i%> input-not-editable"></td>
								<td><input type="text" id="input_receivePeriod<%=i%>"
									value="<%=orders.get(i).getReceivePeriod()%>"
									class="input-toggle<%=i%> input-not-editable"></td>
								<td><input type="text" id="input_timesLeft<%=i%>"
									value="<%=orders.get(i).getTimesLeft()%>"
									class="input-toggle<%=i%> input-not-editable"></td>

								<td id="confirmEdit<%=i%>"
									style="display: none; vertical-align: middle;"
									onclick="toggleEdit(<%=i%>)"><span
									onclick="updateOrder(<%=i%>, <%=orders.get(i).getOrderID()%>)"><span>
											<img alt="Edit" src="assets/icons/ok_64.png"
											style="max-width: 20px">
									</span></span></td>
								<td id="edit<%=i%>" onclick="toggleEdit(<%=i%>)"
									style="vertical-align: middle;"><span> <img
										alt="Edit" src="assets/icons/edit_64.png"
										style="max-width: 20px">
								</span></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</form>


		<%
			} else if (orders == null) {
				ArrayList<Flower> flowerList = (ArrayList<Flower>) request.getAttribute("flowerList");
				if (flowerList != null) {
		%>
		<div class="row">
			<div class="panel panel-primary booking-table">
				<div class="panel-heading">
					<h3 class="panel-title">All Flowers</h3>
				</div>
				<table class="table">
					<thead>
						<tr class="booking-table-header">
							<th><input type="text" class="form-control"
								placeholder="Flower-ID" disabled></th>
							<th><input type="text" class="form-control"
								placeholder="Flower Name" disabled></th>
							<th><input type="text" class="form-control"
								placeholder="Description" disabled></th>
							<th><input type="text" class="form-control"
								placeholder="Image" disabled></th>
							<th><input id="asf" type="text" class="form-control"
								placeholder="Month" disabled></th>
							<th><input type="text" class="form-control"
								placeholder="Available" disabled></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<%
							for (int i = 0; i < flowerList.size(); i += 1) {
						%>
						<tr>
							<td><input type="text" id="input_flowerID<%=i%>"
								value="<%=flowerList.get(i).getFlowerID()%>"
								class="input-toggle<%=i%> input-not-editable"></td>
							<td><input type="text" id="input_flowerName<%=i%>"
								value="<%=flowerList.get(i).getFlowerName()%>"
								class="input-toggle<%=i%> input-not-editable"></td>
							<td><textarea type="text" id="input_description<%=i%>"
									class="input-toggle<%=i%> input-not-editable"
									style="width: 100%; height: 100%;">
								<%=flowerList.get(i).getDescription()%></textarea></td>
							<td><img src="<%=flowerList.get(i).getImageLink()%>"
								style="height: 100px; width: 100px;"></td>
							<td><input type="text" id="input_month<%=i%>"
								value="<%=flowerList.get(i).getMonth()%>"
								class="input-toggle<%=i%> input-not-editable"></td>
							<td><input type="text" id="input_available<%=i%>"
								value="<%=flowerList.get(i).getAvailable()%>"
								class="input-toggle<%=i%> input-not-editable"></td>

							<td id="confirmEdit<%=i%>"
								style="display: none; vertical-align: middle;"
								onclick="toggleEdit(<%=i%>)"><span
								onclick="updateFlower(<%=i%>, '<%=flowerList.get(i).getFlowerID()%>')"><span>
										<img alt="Edit" src="assets/icons/ok_64.png"
										style="max-width: 20px">
								</span></span></td>
							<td id="edit<%=i%>" onclick="toggleEdit(<%=i%>)"
								style="vertical-align: middle;"><span> <img
									alt="Edit" src="assets/icons/edit_64.png"
									style="max-width: 20px">
							</span></td>
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
			}
		%>

	</div>



</body>
</html>