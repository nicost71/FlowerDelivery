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

<style>
.mfp-no-margins .mfp-container {
	padding: 0;
}
</style>
<script>
$(document).ready(function() {

	$('.image-popup-no-margins').magnificPopup({
		type: 'image',
		closeOnContentClick: true,
		closeBtnInside: false,
		fixedContentPos: true,
		mainClass: 'mfp-no-margins mfp-with-zoom', // class to remove default margin from left and right side
		image: {
			verticalFit: true
		},
		zoom: {
			enabled: true,
			duration: 300 // don't foget to change the duration also in CSS
		}
	});

});
</script>
</head>
<body
	onload="<%ArrayList<Flower> flowers = FlowerServlet.getCurrentFlowers();%>">

	<div class="container">

		<div class="jumbotron text-center"
			style="background-color: rgba(255, 255, 255, 0.4)">
			<h1>Flower Delivery</h1>
			<h3 style="float:right;font-style:italic;">Hot Line:2333 2333</h3>
		</div>
		<div class="row" style="display: table; width: 100%;">
			<div class="col-md-3"
				style="display: table-cell; float: none; vertical-align: middle;">
				<h2>Current Flowers</h2>
			</div>
			<div class="col-md-9" style="display: table-cell; float: none;">
				<%
					if (flowers != null)
					{
						for (int i = 0; i < flowers.size(); i += 1)
						{
				%>

				<div class="panel panel-default panel-horizontal">
					<div class="panel-heading panel-fixed-length">
						<h3 class="panel-title"><%=flowers.get(i).getFlowerName()%></h3>
					</div>
					<div class="panel-body">
						<a href="<%=flowers.get(i).getImageLink()%>"
							class="image-popup-no-margins"> 
							<img
							src="<%=flowers.get(i).getImageLink()%>" width="100px"
							height="100px" />
						</a>
						<!-- <img src="<%=flowers.get(i).getImageLink()%>" width=100px
							height="100px" id="img"> -->
					</div>
					<div class="panel-body-right"><%=flowers.get(i).getDescription()%></div>
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