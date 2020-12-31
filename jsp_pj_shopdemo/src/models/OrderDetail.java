package models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetail {


	public OrderDetail(Order order, Product product, int quantity) {
		super();
		this.order = order;
		Product = product;
		this.quantity = quantity;
	}
	
	public OrderDetail(Product product, int quantity) {
		super();
		Product = product;
		this.quantity = quantity;
	}

	private int id;
	
	private Order order;
	
	private Product Product;
	
	private int quantity;
	
	
	
}
