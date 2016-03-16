<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.text.*,java.util.*"%>
<%@ page import="Instances.Flower"%>
<%@ page import="Instances.Order"%>
<%@ page import="servlets.FlowerServlet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link type="text/css" rel="stylesheet" href="style/bootstrap.css" />
<link type="text/css" rel="stylesheet" href="style/flowerDelivery.css" />
<link href='https://fonts.googleapis.com/css?family=Josefin+Sans' rel='stylesheet' type='text/css'>
<title>New Flower Order</title>
</head>
<body
	onload="<%ArrayList<Flower> flowers = FlowerServlet.getCurrentFlowers();%>">
	<div class="container">

		<nav class="navbar navbar-default" style="margin-bottom: 40px">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="start.jsp"> <img alt="Brand"
					src="assets/icons/logo2_icon_64.png" style="max-height: 30px; margin-top: -5px;">
				</a> <span class="navbar-brand"
					style="border-left: 1px solid rgba(0, 0, 0, 0.2); margin-left: 0px; font-size: 15px">
					New Order </span>
					
			</div>
		</div>
		</nav>

		<%
			String status = (String) request.getAttribute("status");
			if (status == null || status == "invalidInput") {
		%>

		<h2>Create new order</h2>

		<div class="row voffset50">


			<form action="OrderServlet" method="POST">
				<input type="hidden" name="requestType" value="placeOrder">

				<div class="col-md-5" style="padding: 0px">
					<div class="form-group">
						<label>Phone Nr:</label> <input type="text" name="userPhoneNum"
							value="<%=request.getAttribute("userPhoneNum") != null ? request.getAttribute("userPhoneNum") : ""%>"
							class="form-control text-center" required>
					</div>
					<div class="form-group">
						<label class="<%=status != null ? "invalid-input" : ""%>">Password:</label>
						<input type="password" name="password"
							class="form-control text-center" required>
						<%
							if (status != null) {
						%>
						<p class="invalid-input">
							Wrong password for user '<%=request.getAttribute("userPhoneNum")%>'
						</p>
						<%
							}
						%>
					</div>
					<div class="form-group">
						<label>Delivery Address:</label> <input type="text"
							name="receiverAddr"
							value="<%=request.getAttribute("receiverAddr") != null ? request.getAttribute("receiverAddr") : ""%>"
							class="form-control text-center" required>
					</div>
					<div class="form-group">
						<label>Reciever Name:</label> <input type="text"
							name="receiverName"
							value="<%=request.getAttribute("receiverName") != null ? request.getAttribute("receiverName") : ""%>"
							class="form-control text-center" required>
					</div>
					<div class="form-group">
						<label>Reciever Phone:</label> <input type="text"
							name="receiverPhone"
							value="<%=request.getAttribute("receiverPhone") != null ? request.getAttribute("receiverPhone") : ""%>"
							class="form-control text-center" required>
					</div>

					<div class="row">

						<div class="col-md-6" style="padding: 0px">


							<div class="form-group">
								<%
									String deliveryDay = (String) request.getAttribute("deliveryDay");
								%>
								<label>Day of Delivery:</label> <br> <label
									class="radio-inline" style="margin-top: 5px;"><input
									type="radio" name="deliveryDay" value="Monday"
									<%if (deliveryDay == null || deliveryDay.equals("Monday")) {%>
									checked <%}%>>Monday</label> <label class="radio-inline"
									style="margin-top: 5px;"><input type="radio"
									name="deliveryDay" value="Saturday"
									<%if (deliveryDay != null && deliveryDay.equals("Saturday")) {%>
									checked <%}%>>Saturday</label>

							</div>
						</div>
						<div class="col-md-6">

							<div class="form-group">
								<%
									String receivePeriod = (String) request.getAttribute("receivePeriod");
								%>
								<label>Time of Delivery:</label> <br> <label> <select
									class="btn btn-default" name="receivePeriod">
										<option value="8"
											<%if (receivePeriod == null || receivePeriod.equals("8")) {%>
											selected <%}%>>8am</option>
										<option value="10"
											<%if (receivePeriod != null && receivePeriod.equals("10")) {%>
											selected <%}%>>10am</option>
										<option value="12"
											<%if (receivePeriod != null && receivePeriod.equals("12")) {%>
											selected <%}%>>12pm</option>
										<option value="14"
											<%if (receivePeriod != null && receivePeriod.equals("14")) {%>
											selected <%}%>>2pm</option>
										<option value="16"
											<%if (receivePeriod != null && receivePeriod.equals("16")) {%>
											selected <%}%>>4pm</option>
										<option value="18"
											<%if (receivePeriod != null && receivePeriod.equals("18")) {%>
											selected <%}%>>6pm</option>
								</select></label>
							</div>
						</div>


					</div>


				</div>

				<div class="col-md-5 col-md-offset-2" style="padding: 0px">
					<%
						if (flowers != null) {
								String[] checkedFlowers = (String[]) request.getAttribute("checkedFlowers");
								for (int i = 0; i < flowers.size(); i += 1) {
					%>
					<div class="panel panel-default panel-horizontal">
						<div class="panel-heading">
							<input type="checkbox" name="checkedFlowers"
								style="width: 100%; height: 25px;"
								value="<%=flowers.get(i).getFlowerName()%>"
								<%if (checkedFlowers == null || (checkedFlowers != null
								&& Arrays.asList(checkedFlowers).contains(flowers.get(i).getFlowerName()))) {%>
								checked <%}%>>
						</div>
						<div class="panel-body">
							<div class="text-center">
								<img src="<%=flowers.get(i).getImageLink()%>" width=75px
									height="75px">
							</div>

						</div>
						<div class="panel-footer" style="width: 100%;">
							<h3 class="panel-title"><%=flowers.get(i).getFlowerName()%></h3>

						</div>

					</div>
					<%
						}
					%>
					<%
						}
					%>

				</div>

				<input type="submit" class="btn btn-primary voffset50"
					style="font-size: 18px" value="Submit Order">
			</form>

		</div>

		<%
			} else if (status == "orderPlaced") {
				Order order = (Order) request.getAttribute("order");
				if (order != null) {
		%>
		<h2>Order successfully placed!</h2>
				<div class="row">
			<div class="panel panel-primary booking-table">
				<div class="panel-heading">
					<h3 class="panel-title">
						Booking
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
				<tr class="rowColor-current">
					<td><%=order.getFlowers()%></td>
					<td><%=order.getReceiverName()%></td>
					<td><%=order.getReceiverAddr()%></td>
					<td><%=order.getReceiverPhone()%></td>
					<td><%=order.getNextDeliveryDay()%></td>

				</tr>
			</tbody>
		</table>
		</div>
		</div>
		<button class="btn btn-primary" onclick="window.location='start.jsp'">Back
			to start</button>
		<%
			}
			}
		%>

	</div>
</body>
</html>