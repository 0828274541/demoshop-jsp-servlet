package daos;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.PreparedStatement;

import models.Role;
import utils.ConnectDBUtils;

public class RoleDAO extends AbstractDAO{

	public List<Role> findAll(){
		List<Role> list = new ArrayList();
		String sql ="SELECT * FROM roles";
		con = ConnectDBUtils.getConnection();
		
		try {
			st= con.createStatement();
			rs= st.executeQuery(sql);
			while(rs.next()) {
				
				Role role = new Role(rs.getInt("id"),rs.getString("name"));
				list.add(role);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		return list;
		
	}
}
