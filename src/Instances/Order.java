package Instances;
import java.text.SimpleDateFormat;
import java.util.Date;


public class Order
{
	static int cnt = 1;
	static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	private int orderID;
	private String userPhoneNum;
	private String password;
	private String receiverName;
	private String receiverAddr;
	private String receiverPhone;
	private String flowers; //stand for flowers that the customer don't like, separated by semicolon; can be null
	private String nextDeliveryDay;
	private int receivePeriod;
	private int timesLeft;
	
	public Order()
	{
		this.orderID = cnt++;
		this.timesLeft = 4;
		this.nextDeliveryDay = dateFormat.format(new Date());
		this.receivePeriod = 11;
	}
	
	public Order(String userPhoneNum, String password, String receiverName, String receiverAddr, String receiverPhone,
			String flowers, String date, int receivePeriod, int timesLeft)
	{
		this.orderID = cnt++;
		this.userPhoneNum = userPhoneNum;
		this.password = password;
		this.receiverName = receiverName;
		this.receiverAddr = receiverAddr;
		this.receiverPhone = receiverPhone;
		this.flowers = flowers;
		this.nextDeliveryDay = date;
		this.receivePeriod = receivePeriod;
		this.timesLeft = timesLeft;
	}

	public int getOrderID()
	{
		return orderID;
	}

	public String getUserPhoneNum()
	{
		return userPhoneNum;
	}

	public String getReceiverName()
	{
		return receiverName;
	}

	public String getReceiverAddr()
	{
		return receiverAddr;
	}

	public String getReceiverPhone()
	{
		return receiverPhone;
	}

	public String getFlowers()
	{
		return flowers;
	}

	public String getNextDeliveryDay()
	{
		return nextDeliveryDay;
	}

	public int getReceivePeriod()
	{
		return receivePeriod;
	}

	public int getTimesLeft()
	{
		return timesLeft;
	}

	public void setOrderID(int orderID)
	{
		this.orderID = orderID;
	}

	public void setUserPhoneNum(String userPhoneNum)
	{
		this.userPhoneNum = userPhoneNum;
	}

	public void setReceiverName(String receiverName)
	{
		this.receiverName = receiverName;
	}

	public void setReceiverAddr(String receiverAddr)
	{
		this.receiverAddr = receiverAddr;
	}

	public void setReceiverPhone(String receiverPhone)
	{
		this.receiverPhone = receiverPhone;
	}

	public void setFlowers(String flowers)
	{
		this.flowers = flowers;
	}

	public void setNextDeliveryDay(String date)
	{
		this.nextDeliveryDay = date;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public void setReceivePeriod(int receivePeriod)
	{
		this.receivePeriod = receivePeriod;
	}

	public void setTimesLeft(int timesLeft)
	{
		this.timesLeft = timesLeft;
	}

}
