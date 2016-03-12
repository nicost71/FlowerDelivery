package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Instances.Order;
import database.DBConnection;

/**
 * Servlet implementation class Admin
 * 
 * Description: get Admin info from login form, and check with database whether it's correct or not.
 * 
 * 
 */
@WebServlet("/AdminServelt")
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
		
		try {
			int userID = Integer.parseInt(request.getParameter("userID"));
			String password = request.getParameter("password");
			DBConnection dbConnection = new DBConnection();
			dbConnection.conn = dbConnection.getConnection("FlowerDelivery");
			
			int loginStatus = checkAdmin(dbConnection, userID, password);
			RequestDispatcher rd;
			if (loginStatus==1)
			{
				ArrayList<Order> orders = OrderServlet.getOrdersAdmin();
				if(orders == null)
					orders = new ArrayList<Order>();
				request.setAttribute("orders", sortOrders(orders));
				rd = request.getRequestDispatcher("/admin.jsp"); 
			} else{
				rd = request.getRequestDispatcher("/admin_login.jsp"); 
			}
			
			rd.forward(request,response);//start directing 
			
			dbConnection.closeDB();
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		/*ArrayList<Integer> list = new ArrayList<Integer>();
		list.addAll(Arrays.asList(0,1,2,3));*/
		
		
		
	}
	private int checkAdmin(DBConnection dbConnection, int userID, String password) throws Exception
	{
		String sql = "select * from administrator where userID=" + userID;
		dbConnection.rs = dbConnection.query(sql);
		int ok = -1;
		// ok = 1: this user information is correct;
		// ok = 0: new user;
		// ok = -1: this user information is incorrect
		if (dbConnection.rs.wasNull())
			ok = 0;
		else{
			dbConnection.rs.next();
			if (dbConnection.rs.getString(2).equals(password))
				ok = 1;
		}
		return ok;
	}
	
	private ArrayList<Order> sortOrders(ArrayList<Order> orders){
	    Collections.sort(orders, new Comparator<Order>() {
	        @Override public int compare(Order p1, Order p2) {
	            return p2.getTimesLeft() - p1.getTimesLeft();
	        }
	    });
		return orders;
	}
}
