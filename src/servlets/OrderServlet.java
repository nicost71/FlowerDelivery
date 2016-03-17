package servlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Instances.Flower;
import Instances.Order;
import database.DBConnection;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public OrderServlet() {
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
		// doPost(request, response);
		System.out.println("Update Single Order");
		try {
			long orderID = Long.parseLong(request.getParameter("orderID"));
			String userPhoneNum = request.getParameter("userPhoneNum");
			String receiverName = request.getParameter("receiverName");
			String receiverAddr = request.getParameter("receiverAddr");
			String receiverPhone = request.getParameter("receiverPhone");
			String flowers = request.getParameter("flowers");
			String nextDeliveryDay = request.getParameter("nextDeliveryDay");
			String receivePeriod = request.getParameter("receivePeriod");
			int timesLeft = Integer.parseInt(request.getParameter("timesLeft"));
			Order order = new Order(userPhoneNum, null, receiverName, receiverAddr, receiverPhone, flowers,
					nextDeliveryDay, receivePeriod, timesLeft);

			updateSingleOrder(order, orderID);
			ArrayList<Order> orders = getOrdersAdmin();
			if (orders == null)
				orders = new ArrayList<Order>();
			request.setAttribute("orders", sortOrders(orders));
			RequestDispatcher rd = request.getRequestDispatcher("/admin.jsp");

			rd.forward(request, response);
		} catch (Exception e) {
			System.out.println("EXCEPTION: " + e.getMessage());
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// handle 3 different kinds of request: placeOrder, userCheckOrder,
		// adminCheckOrder.
		// Distinguished by URL
		try {
			DBConnection dbConnection = new DBConnection();
			dbConnection.conn = dbConnection.getConnection("FlowerDelivery");

			String url = request.getParameter("requestType");
			System.out.println(url);

			if (url.contains("userCheckOrder")) {
				String userPhoneNum = request.getParameter("userPhoneNum");
				userPhoneNum = removeSpace(userPhoneNum);
				String password = request.getParameter("password");
				int ok = checkUser(dbConnection, userPhoneNum, password);
				if (ok == 1) {

					request.setAttribute("orders", sortOrders(userCheckOrder(dbConnection, userPhoneNum)));
				} else {
					if(ok == 0){
						request.setAttribute("status", "invalidUser");
					} else{
						request.setAttribute("status", "invalidPw");
					}
					request.setAttribute("orders", new ArrayList<Order>());
					request.setAttribute("userPhoneNum", request.getParameter("userPhoneNum"));
				}
				request.getRequestDispatcher("manageBooking.jsp").forward(request, response);

			} else if (url.contains("placeOrder")) {

				String userPhoneNum = request.getParameter("userPhoneNum");
				userPhoneNum = removeSpace(userPhoneNum);
				String password = request.getParameter("password");
				System.out.println("userPhoneNum: " + userPhoneNum);
				int ok = checkUser(dbConnection, userPhoneNum, password);
				if (ok == 0) {
					// new user, create user account and order
					dbConnection.update("insert into users values('" + userPhoneNum + "','" + password + "')");
					Order order = createOrder(request);
					placeOrder(dbConnection, order);
					request.setAttribute("status", "orderPlaced");
					request.setAttribute("order",  order);

				} else if (ok == 1) {
					// user account already exists
					Order order = createOrder(request);
					placeOrder(dbConnection, order);
					request.setAttribute("status", "orderPlaced");
					request.setAttribute("order",  order);
				} else if(ok == -1){
					request.setAttribute("status", "invalidInput");
					request.setAttribute("userPhoneNum", request.getParameter("userPhoneNum"));
					request.setAttribute("receiverAddr", request.getParameter("receiverAddr"));
					request.setAttribute("receiverName", request.getParameter("receiverName"));
					request.setAttribute("receiverPhone", request.getParameter("receiverPhone"));
					request.setAttribute("receivePeriod", request.getParameter("receivePeriod"));
					request.setAttribute("deliveryDay", request.getParameter("deliveryDay"));
					request.setAttribute("checkedFlowers", request.getParameterValues("checkedFlowers"));

				}

				request.getRequestDispatcher("order.jsp").forward(request, response);

			} else {
				response.sendRedirect("admin_login.jsp");
			}

			dbConnection.closeDB();
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private String removeSpace(String x) {
		String[] phones = x.trim().split(" ");
		String userPhoneNum = "";
		for (int i = 0; i < phones.length; i++)
			userPhoneNum += phones[i];

		return userPhoneNum;
	}

	public static ArrayList<Order> getOrdersAdmin() throws Exception {
		try {
			DBConnection dbConnection = new DBConnection();
			dbConnection.conn = dbConnection.getConnection("FlowerDelivery");
			ArrayList<Order> orders = new ArrayList<>(); // TODO: Check if
															// current user is
															// Admin!
															// (SECURITY!)
			String sql = "select * from orders";
			dbConnection.rs = dbConnection.query(sql);
			while (dbConnection.rs.next()) {
				Order order = createOrder(dbConnection.rs);
				orders.add(order);
			}

			dbConnection.closeDB();
			return orders;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	private void placeOrder(DBConnection dbConnection, Order order) {
		long id = System.currentTimeMillis();
		dbConnection.update("insert into orders values(" + id + ",'" + order.getNextDeliveryDay() + "','"
				+ order.getReceivePeriod() + "'," + order.getTimesLeft() + ",'" + order.getFlowers() + "','"
				+ order.getUserPhoneNum() + "','" + order.getReceiverName() + "','" + order.getReceiverAddr() + "','"
				+ order.getReceiverPhone() + "')");
	}

	private void updateSingleOrder(Order order, long orderID) throws SQLException {
		DBConnection dbConnection = new DBConnection();
		dbConnection.conn = dbConnection.getConnection("FlowerDelivery");
		dbConnection.update("update orders SET nextDeliveryDay" + " = '" + order.getNextDeliveryDay()
				+ "', receivePeriod = '" + order.getReceivePeriod() + "', timesLeft = " + order.getTimesLeft()
				+ ", flowers = '" + order.getFlowers() + "', userPhoneNum = '" + order.getUserPhoneNum()
				+ "', receiverName = '" + order.getReceiverName() + "', receiverAddr = '" + order.getReceiverAddr()
				+ "', receiverPhone = '" + order.getReceiverPhone() + "' WHERE orderID = " + orderID);
		dbConnection.closeDB();
	}

	private ArrayList<Order> userCheckOrder(DBConnection dbConnection, String userPhoneNum) throws Exception {
		ArrayList<Order> orders = new ArrayList<>();
		if (!userPhoneNum.isEmpty()) {
			String sql = "select * from orders where userPhoneNum=" + userPhoneNum;
			dbConnection.rs = dbConnection.query(sql);
			while (dbConnection.rs.next()) {
				Order order = createOrder(dbConnection.rs);
				orders.add(order);
			}
		}
		return orders;
	}

	private int checkUser(DBConnection dbConnection, String userPhoneNum, String password) throws Exception {
		int ok =-1;
		if (!userPhoneNum.isEmpty()) {
			System.out.println(userPhoneNum);
			String sql = "select * from users where userPhoneNum = '" + userPhoneNum+"'";
			System.out.println("Query: " + sql);
			dbConnection.rs = dbConnection.query(sql);
			// ok = 1: this user information is correct;
			// ok = 0: new user;
			// ok = -1: this user information is incorrect
			if(dbConnection.rs == null){
				ok = -1;
			}
			else if (!dbConnection.rs.next()) {
				ok = 0;
			} else if (dbConnection.rs.getString(2).equals(password)) {
				ok = 1;
			}
		}
		System.out.println("OK " + ok);
		return ok;
	}

	private Order createOrder(HttpServletRequest request) {
		String userPhoneNum = request.getParameter("userPhoneNum");
		userPhoneNum = removeSpace(userPhoneNum);
		String password = request.getParameter("password");
		String receiverName = request.getParameter("receiverName");
		String receiverAddr = request.getParameter("receiverAddr");
		String receiverPhone = request.getParameter("receiverPhone");
		String flowers = request.getParameterValues("checkedFlowers") == null ? "none" : String.join(", ", request.getParameterValues("checkedFlowers"));
		String deliveryDay = request.getParameter("deliveryDay");
		String receivePeriod = request.getParameter("receivePeriod");
		int timesLeft = 4;
		Order order = new Order(userPhoneNum, password, receiverName, receiverAddr, receiverPhone, flowers, deliveryDay,
				receivePeriod, timesLeft);
		return order;
	}

	private static Order createOrder(ResultSet rs) throws Exception {

		long orderID = rs.getLong(1);
		String nextDeliveryDay = rs.getString(2);
		String receivePeriod = rs.getString(3);
		int timesLeft = rs.getInt(4);
		String flowers = rs.getString(5);
		String userPhoneNum = rs.getString(6);
		String receiverName = rs.getString(7);
		String receiverAddr = rs.getString(8);
		String receiverPhone = rs.getString(9);

		Order order = new Order();
		order.setOrderID(orderID);
		order.setNextDeliveryDay(nextDeliveryDay);
		order.setReceivePeriod(receivePeriod);
		order.setTimesLeft(timesLeft);
		order.setFlowers(flowers);
		order.setUserPhoneNum(userPhoneNum);
		order.setReceiverName(receiverName);
		order.setReceiverAddr(receiverAddr);
		order.setReceiverPhone(receiverPhone);

		return order;
	}

	private ArrayList<Order> sortOrders(ArrayList<Order> orders) {
		Collections.sort(orders, new Comparator<Order>() {
			@Override
			public int compare(Order p1, Order p2) {
				return p2.getTimesLeft() - p1.getTimesLeft();
			}
		});
		return orders;
	}

}
