package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Instances.Administrator;
import database.DBConnection;

/**
 * Servlet implementation class Admin
 */
@WebServlet("/Admin")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
		 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		try
		{
			int userID = Integer.parseInt(request.getParameter("userID"));
			String password = request.getParameter("password");
			DBConnection dbConnection = new DBConnection();
			dbConnection.conn = dbConnection.getConnection("FlowerDelivery");
			int ok = checkAdmin(dbConnection, userID, password);
			
			dbConnection.closeDB();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		/*ArrayList<Integer> list = new ArrayList<Integer>();
		list.addAll(Arrays.asList(0,1,2,3));
		RequestDispatcher rd = request.getRequestDispatcher("/admin.jsp");  
		request.setAttribute("test",list);//存值  
		rd.forward(request,response);//开始跳转 */	
	}
	private int checkAdmin(DBConnection dbConnection, int userID, String password) throws Exception
	{
		String sql = "select * from administrator where userID=" + userID;
		dbConnection.rs = dbConnection.query(sql);
		int ok;
		// ok = 1: this user information is correct;
		// ok = 0: new user;
		// ok = -1: this user information is incorrect
		if (dbConnection.rs.wasNull())
			ok = 0;
		else if (dbConnection.rs.getString(2).equals(password))
			ok = 1;
		else
			ok = -1;
		return ok;
	}
}
