package Instances;

public class Administrator
{
	private int id;
	private String password;
	public Administrator(){}
	
	public Administrator(int id, String password)
	{
		this.id = id;
		this.password = password;
	}
	public int getId()
	{
		return id;
	}
	public String getPassword()
	{
		return password;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public void setPassword(String password)
	{
		this.password = password;
	}
}
