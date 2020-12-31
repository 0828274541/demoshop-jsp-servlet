package daos;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Category;
import utils.ConnectDBUtils;
import utils.DefineUtil;

public class CatDAO extends AbstractDAO{
	
	
	Category category;
	CatDAO catDAO;
	
	public int add(Category cat) {
		int result = 0;
		con=ConnectDBUtils.getConnection();
		String sql=" INSERT INTO  categories(name,parent_id,create_by) values(?,?,?)";
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, cat.getName());
			pst.setInt(2, cat.getParent_id());
			pst.setInt(3, cat.getCreateBy());
			result = pst.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			ConnectDBUtils.close(rs, st, con);
		}
		return result;
	}

	public Category getItem(int id) {
		System.out.println(id);
		con=ConnectDBUtils.getConnection();
		String sql="select * from categories where id=?";
		try {
			pst=con.prepareStatement(sql);
			pst.setInt(1, id);
			rs= pst.executeQuery();
			while (rs.next()) {
				category = new Category(rs.getInt("id"),rs.getString("name"),rs.getInt("parent_id"));
	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return category;	
	}

	public boolean hasCat(String name) {
	
		con=ConnectDBUtils.getConnection();
		String sql=" SELECT * FROM categories WHERE name = ?";
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, name);
			rs = pst.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			ConnectDBUtils.close(rs, st, con);
		}
		return false; 
	}

	public int editItem(Category category) {
		int result = 0;
		con=ConnectDBUtils.getConnection();
		String sql=" UPDATE categories SET name = ?, parent_id =?, update_by =?, update_date =?  WHERE id = ?";
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, category.getName());
			pst.setInt(2, category.getParent_id());
			pst.setInt(3, category.getUpdateBy());
			pst.setTimestamp(4, category.getCreateDate());
			pst.setInt(5, category.getId());
			result = pst.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			ConnectDBUtils.close(rs, st, con);
		}
		return result;
	}

	public int delItem(int id) {
		int result = 0;
		con=ConnectDBUtils.getConnection();
		String sql=" DELETE FROM categories  WHERE id = ?";
		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1,id);
			result = pst.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			ConnectDBUtils.close(rs, st, con);
		}
		return result;
	}

	public List<Category> findAll() {
		
			List<Category> list=new ArrayList<>();
			con=ConnectDBUtils.getConnection();
			String sql="select * from categories ";
			try {
				st=con.createStatement();
				rs= st.executeQuery(sql);
				while (rs.next()) {
					Category  cat = new Category(rs.getInt("id"),rs.getString("name"),rs.getInt("parent_id"));
					list.add(cat);
					
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				ConnectDBUtils.close(rs, st, con);
			}
			return list;
		
	
	}

	public Category getItemByParentId(int parent_id) {
		
		con=ConnectDBUtils.getConnection();
		String sql="select * from categories where id=?";
		try {
			pst=con.prepareStatement(sql);
			pst.setInt(1, parent_id);
			rs= pst.executeQuery();
			while (rs.next()) {
				category = new Category(rs.getInt("id"),rs.getString("name"),rs.getInt("parent_id"));
	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return category;	
	}

	public int numberOfItems() {
		int count = 0;
		con=ConnectDBUtils.getConnection();
		String sql=" SELECT COUNT(*) AS count FROM categories ";
		try {
			st=con.createStatement();
			rs= st.executeQuery(sql);
			
			if(rs.next()) {
				 count = rs.getInt("count");
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			ConnectDBUtils.close(rs, st, con);
		
		}
		return count;
	}
	
	public List<Category> getByCategoryPagination(int offset) {
		List<Category> list=new ArrayList<>();
		con=ConnectDBUtils.getConnection();
		String sql="select c.id, c.name, c.parent_id FROM categories AS c "
				+ " ORDER BY c.id ASC  LIMIT ?, ?";
		try {
			pst=con.prepareStatement(sql);
			pst.setInt(1, offset);
			pst.setInt(2, DefineUtil.NUMBER_PER_PAGE_PUBLIC_INDEX);
			rs= pst.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("c.id");
				String name = rs.getString("c.name");
				int parent_id = rs.getInt("c.parent_id");
				
				
				category = new Category(id,name,parent_id);
				list.add(category);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return list;	
	}
	
//parent-> to child
public List<Category> findCategoryParentById(int parent_id) {
		
		List<Category> list=new ArrayList<>();
		con=ConnectDBUtils.getConnection();
		String sql="select * from categories where parent_id=? ";
		try {
			pst=con.prepareStatement(sql);
			pst.setInt(1, parent_id);
			rs= pst.executeQuery();
			while (rs.next()) {
				Category  cat = new Category(rs.getInt("id"),rs.getString("name"),rs.getInt("parent_id"));
				list.add(cat);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return list;	
	}

//child->to parent
public Category getListCat(int id) {
	Category  cat = new Category();
	
	con=ConnectDBUtils.getConnection();
	String sql="select * from categories where id=? ";
	try {
		pst=con.prepareStatement(sql);
		pst.setInt(1, id);
		rs= pst.executeQuery();
		while (rs.next()) {
			  cat = new Category(rs.getInt("id"),rs.getString("name"),rs.getInt("parent_id"));
			  	
			
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		ConnectDBUtils.close(rs, st, con);
	}
	return cat;
	
}



			
			
		



}
