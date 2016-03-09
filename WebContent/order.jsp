<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.text.*,java.util.*"%>
<%@ page import="Instances.Flower"%>
<%@ page import="servlets.FlowerServlet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Flower Order</title>
</head>
<body onload="<%ArrayList<Flower> flowers = FlowerServlet.getCurrentFlowers();%>">
<a href="start.jsp"><img src="Icons/home.png" width=20px height="20px"></a>
<h2>Create new order</h2>
<form action="OrderServlet" method="POST">
<input type="hidden" name="requestType" value="placeOrder">
<table>
	<tr>
		<td>Phone Nr: <input type="text" name="userPhoneNum" size="20"></td>
		<td>Password: <input type="password" name="password" size="20"><br><br></td>
		<td>Delivery Address: <input type="text" name="receiverAddr" size="20"></td>
		<td>Reciever Name: <input type="text" name="receiverName" size="20"></td>
		<td>Reciever Phone <input type="text" name="receiverPhone" size="20"></td>
		<td><input type="radio" name="deliveryDay" value="monday"> Monday <br> <input type="radio" name="deliveryDay" value="saturday"> Saturday</td>
	</tr>
	<tr></tr>
</table>
    <table border="1">
      <thead>
  		<tr>
     		<th colspan="3">Flowers</th>
  		</tr>
 	</thead>
    <% if(flowers != null) {
    	 for(int i = 0; i < flowers.size(); i+=1) { %>
            <tr>      
                <td><%= flowers.get(i).getFlowerName() %></td>
                <td><img src="<%= flowers.get(i).getImageLink() %>" width=100px height="100px"></td>
                <td><input type="checkbox" name="checkedFlowers" value="<%= flowers.get(i).getFlowerName()%>" checked></td>
            </tr>
        <%}%>
    <%}%>

    </table> 
<input type="submit" value="Submit Order">
</form>
</body>
</html>