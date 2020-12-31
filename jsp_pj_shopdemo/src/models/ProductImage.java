package models;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductImage {
	
	private int id;
	
	private String name;
	
	private Product product;
	
	private Timestamp updateDate;
	
	private int updateBy;

	public ProductImage(String name) {
		super();
		this.name = name;
	}

	public ProductImage(int id, String name, Product product) {
		super();
		this.id = id;
		this.name = name;
		this.product = product;
	}
	
	public ProductImage(String name, Product product) {
		super();


		this.name = name;
		this.product = product;
	}
}
