package models;


import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product {
	
	

	public Product(String name, Category getCategory) {
		super();
		this.name = name;
		this.getCategory = getCategory;
	}
	public Product(String name) {
		super();
		this.name = name;
		
	}
	public Product(int id, String name, int price, int saleOff, String preview, String storage,
			String ram, String cameraFeature, String batteryCapacity, int count, String producer, Date releaseDate) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.saleOff = saleOff;
		this.preview = preview;
		this.storage = storage;
		this.ram = ram;
		this.cameraFeature = cameraFeature;
		this.batteryCapacity = batteryCapacity;
		this.count = count;
		this.producer = producer;
		this.releaseDate = releaseDate;
	}
	
	public Product(int id, String name, Category getCategory, int price, int saleOff, String preview, String storage,
			String ram, String cameraFeature, String batteryCapacity, int count, String producer, Date releaseDate) {
		super();
		this.id = id;
		this.name = name;
		this.getCategory = getCategory;
		this.price = price;
		this.saleOff = saleOff;
		this.preview = preview;
		this.storage = storage;
		this.ram = ram;
		this.cameraFeature = cameraFeature;
		this.batteryCapacity = batteryCapacity;
		this.count = count;
		this.producer = producer;
		this.releaseDate = releaseDate;
	}

	public Product(int id) {
		super();
		this.id = id;
	}


	private int id;
	
	private String name;
	
	private Category getCategory;

	private int price;
	
	private int saleOff;
	
	private String preview;
	
	private String storage;
	
	private String ram;
	
	private String cameraFeature;
	
	private String batteryCapacity;
	
	private int count;

	private String producer;
	
	private Date releaseDate;
	
	private int createBy;
	
	private int updateBy;
	
	private Timestamp createDate;
	
	private Timestamp updateDate;

}
