<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.text.*,java.util.*"%>
<%@ page import="Instances.Administrator"%>
<%@ page import="database.DBConnection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>admin.jsp</title>

<style>
table, td, th {
	border: 1px solid green;
}

th {
	background-color: green;
	color: white;
}
</style>

</head>
<body>
	<input type="submit" action="AdminServlet" method="post">
	<img src="FlowerList/April/Azalea.jpg" alt="Mountain View" style="width:304px;height:228px;">
	<%
		/* ArrayList<Integer> list = (ArrayList<Integer>) request.getAttribute("test");
		out.println("<h1>"+list.size()+"</h1>");
		out.println("<h1>"+list+"</h1>"); */
	%>
	<%
		DBConnection dbConnection = new DBConnection();
		dbConnection.conn = dbConnection.getConnection("FlowerDelivery");
		String sql = "select * from administrator";
		//String sql2 = "insert into administrator values(1,'abcd')";
		//dbConnection.update(sql2);
		dbConnection.rs = dbConnection.query(sql);
		//DBConnection.print(rs);
		ArrayList<Administrator> adminList = new ArrayList<Administrator>();
		adminList = (ArrayList<Administrator>) dbConnection.addCollection(adminList);
		dbConnection.closeDB();
		//System.out.print("hello");
	%>
	<table border=2>
		<%
			out.println("<tr><td>ID</td><td>psd</td></tr>");
			for (Administrator admin : adminList)
			{
				out.println("<tr><td>" + admin.getId() + "</td><td>" + admin.getPassword() + "</td></tr>");
				//out.println("Password: " + administrator.getPassword());
			}
		%>
	</table>
</body>
</html>