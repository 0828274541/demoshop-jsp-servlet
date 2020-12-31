package models;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {

	public Order(int id, int totalMoney, String paymentMethod, float discount) {
		super();
		this.id = id;
		this.totalMoney = totalMoney;
		this.paymentMethod = paymentMethod;
		this.discount = discount;
	}

	public Order(int id) {
		super();
		this.id = id;
	}

	public Order(int id, int totalMoney, Timestamp createDate) {
		super();
		this.id = id;
		this.totalMoney = totalMoney;
		this.createDate = createDate;
	}

	public Order(int id, int totalMoney, Timestamp createDate, float discount) {
		super();
		this.id = id;
		this.totalMoney = totalMoney;
		this.createDate = createDate;
		this.discount = discount;
	}

	private int id;

	public Order(int id, int totalMoney, String paymentMethod, float discount, int createBy, Timestamp createDate) {
		super();
		this.id = id;
		this.totalMoney = totalMoney;
		this.paymentMethod = paymentMethod;
		this.discount = discount;
		this.createBy = createBy;
		this.createDate = createDate;
	}

	private int totalMoney;

	private String paymentMethod;

	private float discount;

	private int createBy;

	private int updateBy;

	private Timestamp createDate;

	private Timestamp updateDate;

}
