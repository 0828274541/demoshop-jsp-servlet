package daos;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Role;
import models.User;
import utils.ConnectDBUtils;

public class UserDAO extends AbstractDAO {

	private User user;

	public int addItem(User item) {
		int result = 0;
		con=ConnectDBUtils.getConnection();
		String sql=" INSERT INTO  users(username,password) values(?,?)";
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, item.getUsername());
			pst.setString(2, item.getPassword());
			
			result = pst.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			ConnectDBUtils.close(rs, st, con);
		}
		return result;
	}



	public boolean hasUser(String username) {
		
		con=ConnectDBUtils.getConnection();
		String sql="SELECT * FROM users WHERE username = ? ";
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, username);
			rs = pst.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			ConnectDBUtils.close(rs, st, con);
		}
		return false;
	}

	
	
	public User login(String username, String password) {
		User user = null;
		con=ConnectDBUtils.getConnection();
		String sql="select u.id, u.username, u.fullname, u.address,u.telephone_number,u.create_date,u.create_by,u.role_id,s.name"
				+ " FROM users AS u INNER JOIN roles AS s ON u.role_id= s.id WHERE username = ? && password = ?"; 
		try {
			pst=con.prepareStatement(sql);
			pst.setString(1, username);
			pst.setString(2, password);
			rs= pst.executeQuery();
			while (rs.next()) {
				
			user = new User(rs.getInt("u.id"),
							rs.getString("u.username"),
							rs.getString("u.fullname"),
							rs.getString("u.address"),
							rs.getInt("u.telephone_number"),
							rs.getInt("u.create_by"),
							rs.getTimestamp("u.create_date"),
							new Role(rs.getInt("u.role_id"),rs.getString("s.name")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return user;
	}



	public int editItem(User user) {
		int result = 0;
		con=ConnectDBUtils.getConnection();
		String sql=" UPDATE users SET fullname = ?, address =?, telephone_number =?, update_by =? , update_date = ? WHERE id = ?";
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, user.getFullname());
			pst.setString(2, user.getAddress());
			pst.setInt(3, user.getTelephoneNumber());
			pst.setInt(4, user.getUpdateBy());
			pst.setTimestamp(5, user.getUpdateDate());
			pst.setInt(6, user.getId());
			result = pst.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			ConnectDBUtils.close(rs, st, con);
		}
		return result;
	}


	public List<User> findAllExceptId(int id) {
		List<User> list = new ArrayList<User>();
		con = ConnectDBUtils.getConnection();
		String sql = "SELECT u.id, u.username, u.fullname, u.address,u.telephone_number,u.create_date,u.create_by,u.role_id,s.name"
				+ " FROM users AS u INNER JOIN roles AS s ON u.role_id = s.id  WHERE u.id != ?";
		try {
			pst=con.prepareStatement(sql);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while(rs.next()) {
				user = new User(rs.getInt("u.id"),
						rs.getString("u.username"),
						rs.getString("u.fullname"),
						rs.getString("u.address"),
						rs.getInt("u.telephone_number"),
						rs.getInt("u.create_by"),
						rs.getTimestamp("u.create_date"),
						new Role(rs.getInt("u.role_id"),rs.getString("s.name")));
				list.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}



	public User getItem(int id) {
		User user  = new User();
		con = ConnectDBUtils.getConnection();
		String sql="select u.id, u.username, u.password, u.fullname, u.address,u.telephone_number,u.create_date,u.create_by,u.update_by,u.update_date,u.role_id,s.name"
				+ " FROM users AS u INNER JOIN roles AS s ON u.role_id= s.id WHERE u.id = ?";
				
		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while(rs.next()) {
				user = new User(rs.getInt("u.id"),
						rs.getString("u.username"),
						rs.getString("u.password"),
						rs.getString("u.fullname"),
						rs.getString("u.address"),
						rs.getInt("u.telephone_number"),
						rs.getInt("u.update_by"),
						rs.getInt("u.create_by"),
						rs.getTimestamp("u.update_date"),
						rs.getTimestamp("u.create_date"),
						new Role(rs.getInt("u.role_id"),rs.getString("s.name")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return user;
	}


}
