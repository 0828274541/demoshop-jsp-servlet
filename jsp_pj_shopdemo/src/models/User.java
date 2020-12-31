package models;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
	
	public User(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}

	public User(int id, String username) {
		super();
		this.id = id;
		this.username = username;
		
	}
	
	
	public User(int id, String username, String fullname, String address, int telephoneNumber, int createBy,
			Timestamp createDate, Role role) {
		super();
		this.id = id;
		this.username = username;
		this.fullname = fullname;
		this.address = address;
		this.telephoneNumber = telephoneNumber;
		this.createBy = createBy;
		this.createDate = createDate;
		this.role = role;
	}





	public User(int id, String username, String password, String fullname, String address, int telephoneNumber, int createBy, 
			int updateBy, Timestamp createDate, Timestamp updateDate,Role role) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.fullname = fullname;
		this.address = address;
		this.telephoneNumber = telephoneNumber;

		this.createBy = createBy;
		this.updateBy = updateBy;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.role = role;
	}





	private int id;
	
	private String username;
	
	private String password;
	
	private String fullname;

	private String address;
	
	private int telephoneNumber;

	private int status;
	
	private Role role;
	
	private int createBy;
	
	private int updateBy;
	
	private Timestamp createDate;
	
	private Timestamp updateDate;
}
