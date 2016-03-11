package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.crypto.provider.RSACipher;

import Instances.Flower;
import database.DBConnection;

/**
 * Servlet implementation class FlowerServlet
 */
@WebServlet("/FlowerServlet")
public class FlowerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FlowerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try
		{
			DBConnection dbConnection = getDBcon();
			ArrayList<Flower> flowers = getCurrentFlowers(dbConnection);
			
			// to pass flowers to jsp
			
			dbConnection.closeDB();
			request.setAttribute("flowersList", flowers);
			request.getRequestDispatcher("start.jsp").forward(request,response);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public static DBConnection getDBcon()
	{
		DBConnection dbConnection = new DBConnection();
		dbConnection.conn = dbConnection.getConnection("FlowerDelivery");
		return dbConnection;
	}
	
	public static ArrayList<Flower> getCurrentFlowers() throws Exception{
		try
		{
			DBConnection dbConnection = new DBConnection();
			dbConnection.conn = dbConnection.getConnection("FlowerDelivery");
			ArrayList<Flower> flowers = getCurrentFlowers(dbConnection);			
			
			dbConnection.closeDB();
			return flowers;
		} catch (Exception e)
		{
			e.printStackTrace();
			return null;
		}
	}

	private static ArrayList<Flower> getCurrentFlowers(DBConnection dbConnection) throws Exception
	{
		ArrayList<Flower> flowers = new ArrayList<Flower>();
		int currentmonth = Calendar.getInstance().get(Calendar.MONTH)+1;
		String sql = "select * from flower_house where month = "+currentmonth+" and available = 1";
		dbConnection.rs = dbConnection.query(sql);
		while(dbConnection.rs.next())
		{
			String flowerName = dbConnection.rs.getString(2);
			String description = dbConnection.rs.getString(3);
			String imageLink = dbConnection.rs.getString(4);
			int month = dbConnection.rs.getInt(5);
			int available = dbConnection.rs.getInt(6);
			Flower flower = new Flower(flowerName,description,imageLink,month,available);
			flowers.add(flower);
		}
		return flowers;
	}

}
