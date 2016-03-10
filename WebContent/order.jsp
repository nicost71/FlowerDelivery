<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.text.*,java.util.*"%>
<%@ page import="Instances.Flower"%>
<%@ page import="servlets.FlowerServlet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link type="text/css" rel="stylesheet" href="style/bootstrap.css" />
<link type="text/css" rel="stylesheet" href="style/flowerDelivery.css" />
<title>New Flower Order</title>
</head>
<body
	onload="<%ArrayList<Flower> flowers = FlowerServlet.getCurrentFlowers();%>">
	<div class="container">

		<nav class="navbar navbar-default" style="margin-bottom: 40px">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="start.jsp"> <img alt="Brand"
					src="assets/icons/home.png" style="max-width: 20px">
				</a> <span class="navbar-brand"
					style="border-left: 1px solid rgba(0, 0, 0, 0.2); margin-left: 0px; font-size: 15px">
					New Order </span>
			</div>
		</div>
		</nav>

		<h2>Create new order</h2>

		<div class="row voffset50">


			<form action="OrderServlet" method="POST">
				<input type="hidden" name="requestType" value="placeOrder">

				<div class="col-md-5">
					<div class="form-group">
						<label>Phone Nr:</label> <input type="text" name="userPhoneNum"
							class="form-control text-center" required>
					</div>
					<div class="form-group">
						<label>Password:</label> <input type="password" name="password"
							class="form-control text-center" required>
					</div>
					<div class="form-group">
						<label>Delivery Address:</label> <input type="text"
							name="receiverAddr" class="form-control text-center" required>
					</div>
					<div class="form-group">
						<label>Reciever Name:</label> <input type="text"
							name="receiverName" class="form-control text-center" required>
					</div>
					<div class="form-group">
						<label>Reciever Phone:</label> <input type="text"
							name="receiverPhone" class="form-control text-center" required>
					</div>

					<div class="row">

						<div class="col-md-6">


							<div class="form-group">
								<label>Day of Delivery:</label> <br> <label
									class="radio-inline" style="margin-top: 5px;"><input
									type="radio" name="deliveryDay" value="Monday" checked>Monday</label>
								<label class="radio-inline" style="margin-top: 5px;"><input
									type="radio" name="deliveryDay" value="Saturday">Saturday</label>

							</div>
						</div>
						<div class="col-md-6">

							<div class="form-group">
								<label>Time of Delivery:</label> <br> <label> <select
									class="btn btn-default" name="receivePeriod">
										<option value="8">8am</option>
										<option value="10">10am</option>
										<option value="12">12pm</option>
										<option value="14">2pm</option>
										<option value="16">4pm</option>
										<option value="18">6pm</option>
								</select></label>
							</div>
						</div>


					</div>


				</div>

				<div class="col-md-5 col-md-offset-2">
					<%
						if (flowers != null) {
							for (int i = 0; i < flowers.size(); i += 1) {
					%>
					<div class="panel panel-default panel-horizontal">
						<div class="panel-heading">
							<input type="checkbox" name="checkedFlowers" style="width: 100%; height: 25px;"
								value="<%=flowers.get(i).getFlowerName()%>" checked>
						</div>
						<div class="panel-body">
							<div class="text-center">
								<img src="assets/<%=flowers.get(i).getImageLink()%>" width=75px
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

	</div>
</body>
</html>