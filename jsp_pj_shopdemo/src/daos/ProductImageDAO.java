package daos;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Category;
import models.Product;
import models.ProductImage;
import utils.ConnectDBUtils;

public class ProductImageDAO extends AbstractDAO{
	
	
	public List<ProductImage> findAll() {
		List<ProductImage> list=new ArrayList<>();
		con=ConnectDBUtils.getConnection();
		String sql="select * from product_images ";
		try {
			st=con.createStatement();
			rs= st.executeQuery(sql);
			while (rs.next()) {
				ProductImage  productImage = new ProductImage(rs.getInt("id"),rs.getString("name"), new Product(rs.getInt("product_id")));
				list.add(productImage);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return list;
	}
	
	public List<ProductImage> getByProductId(int productId) {
		ProductImage  productImage = new ProductImage();
		List<ProductImage> list=new ArrayList<>();
		con=ConnectDBUtils.getConnection();
		String sql="select * from product_images where product_id= ? ORDER BY id DESC";
		try {
			pst=con.prepareStatement(sql);
			pst.setInt(1, productId);
			rs= pst.executeQuery();
			while (rs.next()) {
			  productImage = new ProductImage(rs.getInt("id"),rs.getString("name"), new Product(rs.getInt("product_id")));
			  list.add(productImage);
	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return list;	
	}
	
	public ProductImage getItemByProductId(int productId) {
		ProductImage  productImage = new ProductImage();
		con=ConnectDBUtils.getConnection();
		String sql="select * from product_images where product_id=?  ";
		try {
			pst=con.prepareStatement(sql);
			pst.setInt(1, productId);
			rs= pst.executeQuery();
			while (rs.next()) {
			  productImage = new ProductImage(rs.getInt("id"),rs.getString("name"), new Product(rs.getInt("product_id")));
				
	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return productImage;	
	}

	public void addItem(ProductImage productImage) {
		
		con=ConnectDBUtils.getConnection();
		String sql = "INSERT INTO product_images (name,product_id) values(?,?)";
		try {
			pst=con.prepareStatement(sql);
			pst.setString(1, productImage.getName());
			pst.setInt(2, productImage.getProduct().getId());
			pst.executeUpdate();
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
			
		
	}

	public void dellItem(int productId) {
		int result = 0;
		con=ConnectDBUtils.getConnection();
		String sql = "DELETE FROM product_images WHERE product_id = ?";
		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1, productId);
			result = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
