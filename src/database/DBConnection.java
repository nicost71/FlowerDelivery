package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;

import com.mysql.jdbc.Statement;

import Instances.Administrator;

public class DBConnection
{
	// Database configuration
	public static String dbAddr = "jdbc:mysql://localhost:3306/";
	public static String url;
	public static String dbdriver = "com.mysql.jdbc.Driver";
	public static String username = "root";
	public static String password = "890211";

	public Connection conn;
	public Statement st;
	public ResultSet rs;

	public DBConnection()
	{
		conn = null;
		st = null;
		rs = null;
	}

	public Connection getConnection(String dbName)
	{
		url = dbAddr + dbName;
		Connection con;
		try
		{
			Class.forName(dbdriver);
			con = DriverManager.getConnection(url, username, password);
			System.out.println("Database Connecting Success");
			return con;

		} catch (Exception ex)
		{
			System.out.println("Couldn't open connection to database");
			System.out.println("Exception in FlowerDB: ");
			ex.printStackTrace();
			return null;
		}
	}

	public ResultSet query(String sql)
	{
		System.out.println("DBQuery log");
		try
		{
			st = (Statement) conn.createStatement(); 

			return (ResultSet) st.executeQuery(sql);

		} catch (SQLException e)
		{
			System.out.println("Query Failed");
			return null;
		}
	}

	public void update(String sql)
	{
		try
		{
			st = (Statement) conn.createStatement();
			st.executeUpdate(sql); 
			System.out.println("Database Update Success");
		} catch (SQLException e)
		{
			System.out.println("Database Update Failed");
			e.printStackTrace();
		}
	}

	public void print()
	{
		try
		{
			if (rs.wasNull())
			{
				System.out.println("No Data found in Database");
			}
			System.out.println("Data Found");
			while (rs.next())
			{
				int adminID = rs.getInt(1);
				String password = rs.getString(2);
				System.out.println("adminID: " + adminID + " password: " + password);
			}
		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public Collection<Administrator> addCollection(Collection<Administrator> collections)
	{
		try
		{
			while (rs.next())
			{
				Administrator administrator = new Administrator();
				administrator.setId(rs.getInt(1));
				administrator.setPassword(rs.getString(2));
				collections.add(administrator);
			}

		} catch (SQLException e)
		{
			e.printStackTrace();
		}
		return collections;

	}

	public void closeDB() throws SQLException
	{
		if (null != rs)
			rs.close();
		if (null != st)
			st.close();
		if (null != conn)
			conn.close();
	}
	/*public static void main(String[] args)
	{
		DBConnection dbConnection = new DBConnection();
		dbConnection.conn = dbConnection.getConnection("FlowerDelivery");
		String[] flowers = "CarnationYellow, Jerusalem cherry, Lavender, NarcissusRed".split(",");
		System.out.println(Arrays.toString(flowers));
		try
		{
			for(int i=0;i<flowers.length;i++)
			{
				String flower = flowers[i].trim();
				String link = "FlowerList/December/"+flower+".jpg";
				String sql = "insert into flower_house values('"+flower+"','December','"+link+"',0)";
				System.out.println(sql);
				dbConnection.update(sql);
			}
			dbConnection.closeDB();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}*/
}