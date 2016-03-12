package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		try {
			ArrayList<Flower> flowers;
			if (request.getParameter("updateFlower").equals("true")) {
				String flowerID = request.getParameter("flowerID");
				String flowerName = request.getParameter("flowerName");
				int month = Integer.parseInt(request.getParameter("month"));
				String description = request.getParameter("description");
				int available = Integer.parseInt(request.getParameter("available"));

				Flower flower = new Flower(flowerName, description, "", month, available);
				updateSingleFlower(flower, flowerID);
				flowers = getAllFlowersAdmin();
				request.setAttribute("flowerList", flowers);
				request.getRequestDispatcher("admin.jsp").forward(request, response);
			} else {
				DBConnection dbConnection = getDBcon();
				flowers = getCurrentFlowers(dbConnection);
				dbConnection.closeDB();
				request.setAttribute("flowerList", flowers);
				request.getRequestDispatcher("start.jsp").forward(request, response);
			}

			// to pass flowers to jsp

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		try {
			DBConnection dbConnection = getDBcon();
			ArrayList<Flower> flowers = getCurrentFlowers(dbConnection);

			// to pass flowers to jsp

			dbConnection.closeDB();
			request.setAttribute("flowersList", flowers);
			request.getRequestDispatcher("admin.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public static DBConnection getDBcon() {
		DBConnection dbConnection = new DBConnection();
		dbConnection.conn = dbConnection.getConnection("FlowerDelivery");
		return dbConnection;
	}

	public static ArrayList<Flower> getCurrentFlowers() throws Exception {
		try {
			DBConnection dbConnection = new DBConnection();
			dbConnection.conn = dbConnection.getConnection("FlowerDelivery");
			ArrayList<Flower> flowers = getCurrentFlowers(dbConnection);

			dbConnection.closeDB();
			return flowers;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	private static ArrayList<Flower> getCurrentFlowers(DBConnection dbConnection) throws Exception {
		ArrayList<Flower> flowers = new ArrayList<Flower>();
		int currentmonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
		String sql = "select * from flower_house where month = " + currentmonth + " and available = 1";
		dbConnection.rs = dbConnection.query(sql);
		while (dbConnection.rs.next()) {
			String flowerName = dbConnection.rs.getString(2);
			String description = dbConnection.rs.getString(3);
			String imageLink = dbConnection.rs.getString(4);
			int month = dbConnection.rs.getInt(5);
			int available = dbConnection.rs.getInt(6);
			Flower flower = new Flower(flowerName, description, imageLink, month, available);
			flowers.add(flower);
		}
		return flowers;
	}

	public static ArrayList<Flower> getAllFlowersAdmin() throws Exception {
		try {
			DBConnection dbConnection = new DBConnection();
			dbConnection.conn = dbConnection.getConnection("FlowerDelivery");
			ArrayList<Flower> flowers = new ArrayList<Flower>();
			String sql = "select * from flower_house";
			dbConnection.rs = dbConnection.query(sql);
			while (dbConnection.rs.next()) {
				String flowerID = dbConnection.rs.getString(1);
				String flowerName = dbConnection.rs.getString(2);
				String description = dbConnection.rs.getString(3);
				String imageLink = dbConnection.rs.getString(4);
				int month = dbConnection.rs.getInt(5);
				int available = dbConnection.rs.getInt(6);
				Flower flower = new Flower(flowerID, flowerName, description, imageLink, month, available);
				flowers.add(flower);
			}
			dbConnection.closeDB();
			return flowers;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	private void updateSingleFlower(Flower flower, String flowerID) throws SQLException {
		DBConnection dbConnection = new DBConnection();
		dbConnection.conn = dbConnection.getConnection("FlowerDelivery");
		dbConnection.update("update flower_house SET flowerName" + " = '" + flower.getFlowerName()
				+ "', description = '" + flower.getDescription() + "', month = " + flower.getMonth() + ", available = "
				+ flower.getAvailable() + " WHERE flowerID = '" + flowerID + "'");
		dbConnection.closeDB();
		System.out.println("updated flower: " + flower.getFlowerName());
	}

}
