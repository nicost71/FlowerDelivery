package Instances;

public class Flower
{
	private String flowerID;
	private String flowerName;
	private int month;
	private String description = "";
	private String imageLink; //can be used in <img src> directly
	private int available;
	public Flower() {
		this.available = 1;
	}
	
	public Flower(String flowerName, String description, String imageLink, int month, int available) throws Exception
	{
		if(available!=0 && available!=1)
			throw new Exception("invalid value, available should be 0 or 1 only");
		
		this.flowerName = flowerName;
		this.flowerID = flowerName+"_"+month;
		this.month = month;
		this.description = description;
		this.imageLink = imageLink;
		this.available = available;
	}
	
	public Flower(String flowerID, String flowerName, String description, String imageLink, int month, int available) throws Exception
	{
		if(available!=0 && available!=1)
			throw new Exception("invalid value, available should be 0 or 1 only");
		
		this.flowerName = flowerName;
		this.flowerID = flowerID;
		this.month = month;
		this.description = description;
		this.imageLink = imageLink;
		this.available = available;
	}

	public String getFlowerID()
	{
		return flowerID;
	}

	public int getMonth()
	{
		return month;
	}

	public void setFlowerID(String flowerID)
	{
		this.flowerID = flowerID;
	}

	public void setMonth(int month)
	{
		this.month = month;
	}
	
	public String getFlowerName()
	{
		return flowerName;
	}

	public String getDescription()
	{
		return description;
	}

	public String getImageLink()
	{
		return imageLink;
	}

	public int getAvailable()
	{
		return available;
	}

	public void setFlowerName(String flowerName)
	{
		this.flowerName = flowerName;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

	public void setImageLink(String imageLink)
	{
		this.imageLink = imageLink;
	}

	public void setAvailable(int available)
	{
		this.available = available;
	}
	
	
}
