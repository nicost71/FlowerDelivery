package Instances;

public class User
{
	private String userPhoneNum; // used as userID
	private String password;
	public User() {}
	public User(String userPhoneNum, String password)
	{
		this.userPhoneNum = userPhoneNum;
		this.password = password;
	}
	public String getUserPhoneNum()
	{
		return userPhoneNum;
	}
	public String getPassword()
	{
		return password;
	}
	public void setUserPhoneNum(String userPhoneNum)
	{
		this.userPhoneNum = userPhoneNum;
	}
	public void setPassword(String password)
	{
		this.password = password;
	}
	
	
}
