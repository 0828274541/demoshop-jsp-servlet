package models;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Category {

	private int id;

	private String name;

	private int parent_id;

	private int createBy;

	private int updateBy;

	private Timestamp createDate;

	private Timestamp updateDate;

	public Category(String name) {
		super();
		this.name = name;
	}

	public Category(int id) {
		super();
		this.id = id;
	}

	public Category(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}

	public Category(String name, int parent_id) {
		super();
		this.name = name;
		this.parent_id = parent_id;
	}

	public Category(int id, String name, int parent_id) {
		super();
		this.id = id;
		this.name = name;
		this.parent_id = parent_id;
	}

	public Category(String name, int parent_id, int createBy) {
		super();
		this.name = name;
		this.parent_id = parent_id;
		this.createBy = createBy;
	}

	public Category(int id, String name, int parent_id, int updateBy, Timestamp createDate) {
		super();
		this.id = id;
		this.name = name;
		this.parent_id = parent_id;
		this.updateBy = updateBy;
		this.createDate = createDate;
	}

}
