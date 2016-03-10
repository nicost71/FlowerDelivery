<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.text.*,java.util.*"%>
<%@ page import="Instances.Flower"%>
<%@ page import="servlets.FlowerServlet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="style/bootstrap.css" />
<link type="text/css" rel="stylesheet" href="style/flowerDelivery.css" />

<title>Flower Delivery</title>
</head>
<body
	onload="<%ArrayList<Flower> flowers = FlowerServlet.getCurrentFlowers();%>">
	<div class="container">
		<div class="jumbotron text-center">
			<h1>Flower Delivery</h1>
		</div>
		<div class="row" style="display: table; width: 100%;">
			<div class="col-md-3"
				style="display: table-cell; float: none; vertical-align: middle;">
				<h2>Current Flowers</h2>
			</div>
			<div class="col-md-9" style="display: table-cell; float: none;">
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
						<h4><%=flowers.get(i).getDescription()%></h4>
					</div>
				</div>
				<%
					}
				%>
				<%
					}
				%>

			</div>
		</div>

		<div class="row voffset50">
			<div class="col-md-6 text-center">
				<form action="StartServlet" method="get">
					<input type="hidden" name="action" value="order"> <input
						class="btn btn-primary" type="submit" value="Order Flower"
						style="font-size: 22px;">
				</form>
			</div>

			<div class="col-md-6 text-center">
				<form action="StartServlet" method="get">
					<input type="hidden" name="action" value="booking"> <input
						class="btn btn-primary" type="submit" value="Manage Booking"
						style="font-size: 22px;">
				</form>
			</div>
		</div>

	</div>

</body>
</html>