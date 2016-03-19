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
<link href='https://fonts.googleapis.com/css?family=Josefin+Sans'
	rel='stylesheet' type='text/css'>
<title>Flower Delivery</title>

<style>
.mfp-no-margins .mfp-container {
	padding: 0;
}
</style>
<script>

function openModal(flowerName, imageLink, description){
	// Get the modal
	var modal = document.getElementById('myModal');
	var modalHeader = document.getElementById('modal-header');
	modalHeader.innerHTML = flowerName;
	var modalImage = document.getElementById('modalImage');
	modalImage.src = imageLink;
	var modalDescription = document.getElementById('modal-description');
	modalDescription.innerHTML = description;

	var span = document.getElementsByClassName("close")[0];

	    modal.style.display = "block";

	span.onclick = function() {
	    modal.style.display = "none";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	    if (event.target == modal) {
	        modal.style.display = "none";
	    }
	}
}
</script>
</head>
<body
	onload="<%ArrayList<Flower> flowers = FlowerServlet.getCurrentFlowers();%>">

	<div class="container">

		<div class="row" class="boffset50">
			<div class="col-sm-6 logo-container">
				<img alt="logo" src="assets/logo2.png" style="max-width:400px">
			</div>
			<div class="col-sm-5">
				<h3 class="pull-right voffset60">Every week your
					world has new sights!</h3>
			</div>
			<div class="col-sm-1 voffset50">
				<a href="help.jsp"><img class="pull-right"
					src="assets/icons/info_64.png" style="max-height: 40px"></a>
			</div>
		</div>

		<div class="row" class="start-container">
			<div class="col-md-3 start-text">
				<h2>Welcome to Flower Delivery</h2>
				<br>
				<h3>Order flowers of the month directly to your home</h3>
				<br>
				<h3 style="font-weight: bold">Just $50 for 4 Bouquets!</h3>
			</div>
			<div class="col-md-9 flower-container">
				<%
					if (flowers != null) {
						for (int i = 0; i < flowers.size(); i += 1) {
				%>

				<div class="panel panel-default panel-horizontal"
					onclick="openModal('<%=flowers.get(i).getFlowerName()%>','<%=flowers.get(i).getImageLink()%>', '<%=flowers.get(i).getDescription()%>')">
					<div class="panel-heading panel-fixed-length">
						<h3 class="panel-title"><%=flowers.get(i).getFlowerName()%></h3>
					</div>
					<div class="panel-body">
						<img src="<%=flowers.get(i).getImageLink()%>" width=100px
							height="100px" id="img">
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
						class="btn btn-primary" type="submit" value="Order Flower">
				</form>
			</div>

			<div class="col-md-6 text-center">
				<form action="StartServlet" method="get">
					<input type="hidden" name="action" value="booking"> <input
						class="btn btn-primary" type="submit" value="Manage Booking">
				</form>
			</div>
		</div>

	</div>

	<div id="myModal" class="modal">

		<div class="modal-content">
			<div class="modal-header">
				<span class="close">X</span>
				<h2 id="modal-header"></h2>
			</div>
			<div class="modal-body row voffset30">
				<div class="col-md-4">
					<img id="modalImage" alt="" src=""
						style="max-width: 100%">
				</div>
				<div class="col-md-8">
					<div id="modal-description"></div>
				</div>
			</div>

		</div>

	</div>

</body>
</html>