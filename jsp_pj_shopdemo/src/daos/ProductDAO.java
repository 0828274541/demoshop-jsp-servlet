package daos;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Category;
import models.Order;
import models.Product;
import utils.ConnectDBUtils;

public class ProductDAO extends AbstractDAO {
	Category category;

	public int numberOfItems(Product product) {
		int count = 0;
		con = ConnectDBUtils.getConnection();
		String sql = " SELECT COUNT(*) AS count " + "FROM products AS p " + "INNER JOIN categories AS c "
				+ "ON p.category_id = c.id WHERE 1 ";

		if (!"".equals(product.getName())) {
			sql += "AND p.name LIKE ? ";
		}

		if (product.getGetCategory().getId() > 0) {
			sql += "AND c.id = ?";
		}
		// ORDER BY s.id DESC
		try {
			pst = con.prepareStatement(sql);
			if (product.getGetCategory().getId() > 0 && !"".equals(product.getName())) {
				pst.setString(1, "%" + product.getName() + "%");
				pst.setInt(2, product.getGetCategory().getId());
			} else {
				if (!"".equals(product.getName()) && product.getGetCategory().getId() == 0) {
					pst.setString(1, "%" + product.getName() + "%");
				} else if ("".equals(product.getName()) && product.getGetCategory().getId() > 0) {
					pst.setInt(1, product.getGetCategory().getId());
				}
			}
			rs = pst.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count");

			}

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);

		}
		return count;
	}

	public int numberOfItems() {
		int count = 0;
		con = ConnectDBUtils.getConnection();
		String sql = " SELECT COUNT(*) AS count FROM products ";
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);

			if (rs.next()) {
				count = rs.getInt("count");

			}

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);

		}
		return count;
	}

	public List<Product> getByCategoryPagination(int offset, int perPage) {
		List<Product> list = new ArrayList<>();
		con = ConnectDBUtils.getConnection();
		String sql = "SELECT p.id,p.name,p.preview,p.count,p.price,p.storage,p.ram,p.camera_feature,p.battery_capacity,p.sale_off,p.producer,p.release_date,"
				+ "c.id, c.name from" + " products AS p INNER JOIN categories AS c ON p.category_id = c.id "
				+ " ORDER BY p.id DESC LIMIT ?, ?";
		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1, offset);
			pst.setInt(2, perPage);
			rs = pst.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("p.id");
				String name = rs.getString("p.name");
				String preview = rs.getString("p.preview");
				int count = rs.getInt("p.count");
				int price = rs.getInt("p.price");
				int saleOff = rs.getInt("p.sale_off");
				String storage = rs.getString("p.storage");
				String ram = rs.getString("p.ram");
				String batteryCapacity = rs.getString("p.battery_capacity");
				String cameraFeature = rs.getString("p.camera_feature");
				String producer = rs.getString("p.producer");
				Date releaseDate = rs.getDate("p.release_date");
				category = new Category(rs.getInt("c.id"), rs.getString("c.name"));

				Product product = new Product(id, name, category, price, saleOff, preview, storage, ram, cameraFeature,
						batteryCapacity, count, producer, releaseDate);
				list.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return list;
	}

	public ArrayList<Product> getByCategoryPaginationWithSeachResult(int offset, Product product, int perPage) {
		ArrayList<Product> list = new ArrayList<Product>();
		con = ConnectDBUtils.getConnection();
		String sql = "select p.id,p.name,p.preview,p.count,p.price,p.storage,p.ram,p.camera_feature,p.battery_capacity,p.sale_off,p.producer,p.release_date,"
				+ "c.id, c.name from products AS p INNER JOIN categories AS c ON p.category_id = c.id  WHERE 1 ";

		if (!"".equals(product.getName())) {
			sql += "AND p.name LIKE ? ";
		}

		if (product.getGetCategory().getId() > 0) {
			sql += "AND c.id = ?";
		}
		sql += " ORDER BY p.id DESC LIMIT ?, ?";
		try {
			pst = con.prepareStatement(sql);
			if (product.getGetCategory().getId() > 0 && !"".equals(product.getName())) {
				pst.setString(1, "%" + product.getName() + "%");
				pst.setInt(2, product.getGetCategory().getId());
				pst.setInt(3, offset);
				pst.setInt(4, perPage);
			} else {
				if (!"".equals(product.getName()) && product.getGetCategory().getId() == 0) {
					pst.setString(1, "%" + product.getName() + "%");
					pst.setInt(2, offset);
					pst.setInt(3, perPage);
				} else if ("".equals(product.getName()) && product.getGetCategory().getId() > 0) {
					pst.setInt(1, product.getGetCategory().getId());
					pst.setInt(2, offset);
					pst.setInt(3, perPage);
				}
			}
			rs = pst.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("p.id");
				String name = rs.getString("p.name");
				String preview = rs.getString("p.preview");
				int count = rs.getInt("p.count");
				int price = rs.getInt("p.price");
				int saleOff = rs.getInt("p.sale_off");
				String storage = rs.getString("p.storage");
				String ram = rs.getString("p.ram");
				String batteryCapacity = rs.getString("p.battery_capacity");
				String cameraFeature = rs.getString("p.camera_feature");
				String producer = rs.getString("p.producer");
				Date releaseDate = rs.getDate("p.release_date");
				category = new Category(rs.getInt("c.id"), rs.getString("c.name"));

				Product product1 = new Product(id, name, category, price, saleOff, preview, storage, ram, cameraFeature,
						batteryCapacity, count, producer, releaseDate);
				list.add(product1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, pst, con);
		}
		return list;
	}

	public int numberOfItems(int catId) {
		int count = 0;
		con = ConnectDBUtils.getConnection();
		String sql = " SELECT COUNT(*) AS count FROM products where category_id = ?";

		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1, catId);

			rs = pst.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count");

			}

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);

		}
		return count;
	}

	public Product getItem(int id) {
		Product product = new Product();
		con = ConnectDBUtils.getConnection();
		String sql = "select p.id,p.name,p.preview,p.count,p.price,p.storage,p.ram,p.camera_feature,p.battery_capacity,p.sale_off,p.producer,p.release_date,"
				+ "c.id, c.name from products AS p INNER JOIN categories AS c ON p.category_id = c.id  WHERE p.id = ? ";
		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while (rs.next()) {
				int productId = rs.getInt("p.id");
				String name = rs.getString("p.name");
				String preview = rs.getString("p.preview");
				int count = rs.getInt("p.count");
				int price = rs.getInt("p.price");
				int saleOff = rs.getInt("p.sale_off");
				String storage = rs.getString("p.storage");
				String ram = rs.getString("p.ram");
				String batteryCapacity = rs.getString("p.battery_capacity");
				String cameraFeature = rs.getString("p.camera_feature");
				String producer = rs.getString("p.producer");
				Date releaseDate = rs.getDate("p.release_date");
				category = new Category(rs.getInt("c.id"), rs.getString("c.name"));

				product = new Product(id, name, category, price, saleOff, preview, storage, ram, cameraFeature,
						batteryCapacity, count, producer, releaseDate);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return product;
	}

	public ArrayList<Product> getBySeachResult(Product product) {
		ArrayList<Product> list = new ArrayList<Product>();
		con = ConnectDBUtils.getConnection();
		String sql = "select p.id,p.name,p.preview,p.count,p.price,p.storage,p.ram,p.camera_feature,p.battery_capacity,p.sale_off,p.producer,p.release_date"
				+ " from products AS p  WHERE p.name LIKE ? ORDER BY p.id DESC";

		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, "%" + product.getName() + "%");
			rs = pst.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("p.id");
				String name = rs.getString("p.name");
				String preview = rs.getString("p.preview");
				int count = rs.getInt("p.count");
				int price = rs.getInt("p.price");
				int saleOff = rs.getInt("p.sale_off");
				String storage = rs.getString("p.storage");
				String ram = rs.getString("p.ram");
				String batteryCapacity = rs.getString("p.battery_capacity");
				String cameraFeature = rs.getString("p.camera_feature");
				String producer = rs.getString("p.producer");
				Date releaseDate = rs.getDate("p.release_date");

				Product product1 = new Product(id, name, price, saleOff, preview, storage, ram, cameraFeature,
						batteryCapacity, count, producer, releaseDate);
				list.add(product1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, pst, con);
		}
		return list;
	}

	public int addItem(Product pro) {
		int result = 0;
		con = ConnectDBUtils.getConnection();
		
		String sql = " INSERT INTO  products(name,category_id,preview,price,storage,ram,camera_feature,battery_capacity,sale_off,producer,release_date,create_by) values(?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, pro.getName());
			pst.setInt(2, pro.getGetCategory().getId());
			pst.setString(3, pro.getPreview());
			pst.setInt(4, pro.getPrice());
			pst.setString(5, pro.getStorage());
			pst.setString(6, pro.getRam());
			pst.setString(7, pro.getCameraFeature());
			pst.setString(8, pro.getBatteryCapacity());
			pst.setInt(9, pro.getSaleOff());
			pst.setString(10, pro.getProducer());
			pst.setDate(11, pro.getReleaseDate());
			pst.setInt(12, pro.getCreateBy());

			result = pst.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return result;
	}
	
	
	public List<Product> findAll() {
		List<Product> list = new ArrayList<Product>();
		con=ConnectDBUtils.getConnection();
		String sql="select * from products ";
		try {
			st=con.createStatement();
			rs= st.executeQuery(sql);
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String preview = rs.getString("preview");
				int count = rs.getInt("count");
				int price = rs.getInt("price");
				int saleOff = rs.getInt("sale_off");
				String storage = rs.getString("storage");
				String ram = rs.getString("ram");
				String batteryCapacity = rs.getString("battery_capacity");
				String cameraFeature = rs.getString("camera_feature");
				String producer = rs.getString("producer");
				Date releaseDate = rs.getDate("release_date");

				Product product1 = new Product(id, name, price, saleOff, preview, storage, ram, cameraFeature,
						batteryCapacity, count, producer, releaseDate);
				list.add(product1);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return list;
	}

	public boolean checkCatProduct(Product pro) {
		int result = 0 ;
		con=ConnectDBUtils.getConnection();
		String sql="select * from categories where parent_id=?";
		try {
			pst=con.prepareStatement(sql);
			pst.setInt(1, pro.getGetCategory().getId());
			rs= pst.executeQuery();
			while (rs.next()) {
				return true;
	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
	
		return false;
	}

	public int editItem(Product pro) {
		int result = 0;
		con = ConnectDBUtils.getConnection();
		String sql = "UPDATE products SET name = ?,"
				+ "category_id = ?,"
				+ "price = ?,"
				+ "storage = ?,"
				+ "preview = ?,"
				+ "ram = ?,"
				+ "camera_feature = ?,"
				+ "battery_capacity = ?,"
				+ "sale_off = ?,"
				+ "producer = ?,"
				+ "release_date = ?,"
				+ "update_by = ?,"
				+ "update_date = ?"
				+ " WHERE id = ?";
			try {
				pst = con.prepareStatement(sql);
				pst.setString(1, pro.getName());
				pst.setInt(2, pro.getGetCategory().getId());
				pst.setInt(3, pro.getPrice());
				pst.setString(4, pro.getStorage());
				pst.setString(5, pro.getPreview());
				pst.setString(6, pro.getRam());
				pst.setString(7, pro.getCameraFeature());
				pst.setString(8, pro.getBatteryCapacity());
				pst.setInt(9, pro.getSaleOff());
				pst.setString(10, pro.getProducer());
				pst.setDate(11, pro.getReleaseDate());
				pst.setInt(12, pro.getUpdateBy());
				pst.setTimestamp(13, pro.getUpdateDate());
				pst.setInt(14, pro.getId());
				result = pst.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		return result;
	}
}
