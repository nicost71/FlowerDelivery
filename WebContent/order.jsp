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

		<a href="start.jsp"><img src="Icons/home.png" width=20px
			height="20px"></a>
		<h2>Create new order</h2>

		<div class="row voffset50">


			<form action="OrderServlet" method="POST">
				<input type="hidden" name="requestType" value="placeOrder">

				<div class="col-md-5">
					<div class="form-group">
						<label>Phone Nr:</label> <input type="text" name="userPhoneNum"
							class="form-control text-center" placeholder="Phone-Nr." required>
					</div>
					<div class="form-group">
						<label>Password:</label> <input type="password" name="password"
							class="form-control text-center" placeholder="Password" required>
					</div>
					<div class="form-group">
						<label>Delivery Address:</label> <input type="text" name="receiverAddr"
							class="form-control text-center" placeholder="Delivery Address" required>
					</div>
					<div class="form-group">
						<label>Reciever Name:</label> <input type="text" name="receiverName"
							class="form-control text-center" placeholder="Reciever Name" required>
					</div>
					<div class="form-group">
						<label>Reciever Phone:</label> <input type="text" name="receiverPhone"
							class="form-control text-center" placeholder="Reciever Phone" required>
					</div>
					
					<div class="form-group">
						<label>Day of Delivery:</label>
						<br>
						<label class="radio-inline"><input type="radio" name="deliveryDay" value="monday" checked>Monday</label>
						<label class="radio-inline"><input type="radio" name="deliveryDay" value="saturday">Saturday</label>
						
					</div>
				</div>

			<div class="col-md-5 col-md-offset-2">
				<%
					if (flowers != null) {
						for (int i = 0; i < flowers.size(); i += 1) {
				%>
				<div class="row row-eq-height " style="margin-top: 15px">

					<div class="col-md-3 row-eq-height ">
						<img src="<%=flowers.get(i).getImageLink()%>" width=100px
							height="100px">
					</div>
					<div class="col-md-3 row-eq-height ">
						<h4><%=flowers.get(i).getFlowerName()%></h4>
					</div>
					<div class="col-md-6 row-eq-height ">
						<input type="checkbox" name="checkedFlowers" value="<%= flowers.get(i).getFlowerName()%>" checked>
					</div>
				</div>
				<%
					}
				%>
				<%
					}
				%>

			</div>


				<input type="submit" class="btn btn-primary" value="Submit Order">
			</form>

		</div>

	</div>
</body>
</html>