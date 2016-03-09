<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.text.*,java.util.*"%>
<%@ page import="Instances.Flower"%>
<%@ page import="servlets.FlowerServlet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Flower Delivery</title>
</head>
<body onload="<%ArrayList<Flower> flowers = FlowerServlet.getCurrentFlowers();%>">

<form  action="FlowerServlet" method="get">
<h1>Current Flowers</h1>
    <table border="1">
    <% if(flowers != null) {
    	 for(int i = 0; i < flowers.size(); i+=1) { %>
            <tr>      
                <td><%= flowers.get(i).getFlowerName() %></td>
                <td><%= flowers.get(i).getDescription() %></td>
                <td><img src="<%= flowers.get(i).getImageLink() %>" width=100px height="100px"></td>
            </tr>
        <% } %>
    <%}%>

    </table> 
</form>
<form  action="StartServlet" method="get">
<input type="hidden" name="action" value="order">
<input type="submit" value="Order Flower">
</form>
<form  action="StartServlet" method="get">
<input type="hidden" name="action" value="booking">
<input type="submit" value="Manage Booking">
</form>

</body>
</html>