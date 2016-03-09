package Instances;

public class Flower
{
	private String flowerName;
	private String description;
	private String imageLink; //can be used in <img src> directly
	private int available;
	public Flower() {
		this.available = 0;
	}
	
	public Flower(String flowerName, String description, String imageLink, int available) throws Exception
	{
		if(available!=0 && available!=1)
			throw new Exception("invalid value, available should be 0 or 1 only");
		
		this.flowerName = flowerName;
		this.description = description;
		this.imageLink = imageLink;
		this.available = available;
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
