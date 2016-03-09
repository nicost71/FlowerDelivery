<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="Instances.Order"%>
<%@ page import="java.sql.*,java.text.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Booking</title>
</head>
<body>
<a href="start.jsp"><img src="Icons/home.png" width=20px height="20px"></a>
<h2>Manage Booking</h2>
<% ArrayList<Order> orders = (ArrayList<Order>) request.getAttribute("orders");
if( orders == null || orders.size() == 0) {  %>
<form action="OrderServlet" method="POST">
<input type="hidden" name="requestType" value="userCheckOrder">
<table>
	<tr>
		<td>Phone Nr: <input type="text" name="userPhoneNum" size="20"></td>
		<td>Password: <input type="password" name="password" size="20"><br><br></td>
	</tr>
	<tr></tr>
</table>
<input type="submit" value="Submit Order">
</form>
<% } if(orders != null && orders.size() == 0){ %>
<p>No orders found</p>
<% } else if(orders != null) { %>
    <table border="1">
     <thead>
  		<tr>
     		<th>Flowers</th>
     		<th>Reciever Name</th>
     		<th>Reciever Address</th>
     		<th>Reciever Phone</th>
     		<th>Next Delivery Day</th>
  		</tr>
 	</thead>
    <% for(int i = 0; i < orders.size(); i+=1) { %>
            <tr>      
                <td><%= orders.get(i).getFlowers() %></td>
                <td><%= orders.get(i).getReceiverName() %></td>
                <td><%= orders.get(i).getReceiverAddr() %></td>
                <td><%= orders.get(i).getReceiverPhone() %></td>
                <td><%= orders.get(i).getNextDeliveryDay() %></td>
                
            </tr>
        <% } %>

    </table>
<% } %>
</body>
</html>