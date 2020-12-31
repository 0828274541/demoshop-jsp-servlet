package daos;

import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import models.Category;
import models.Order;
import models.Product;
import models.User;
import utils.ConnectDBUtils;

public class OrderDAO extends AbstractDAO {


	public void addItem(Order order) {
		int result = 0;
		System.out.println(order.getUpdateDate());
		con=ConnectDBUtils.getConnection();
		String sql=" INSERT INTO  orders(total_money,payment_method,discount,create_by) values(?,?,?,?)";
		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1, order.getTotalMoney());
			pst.setString(2, order.getPaymentMethod());
			pst.setFloat(3, order.getDiscount());
			pst.setInt(4, order.getCreateBy());
		
			result = pst.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			ConnectDBUtils.close(rs, st, con);
		}
		
	}

	public List<Order> findAll() {
		List<Order> orderList = new ArrayList<Order>();
		con=ConnectDBUtils.getConnection();
		String sql="select * from orders ";
		try {
			st=con.createStatement();
			rs= st.executeQuery(sql);
			while (rs.next()) {
				Order  order = new Order(rs.getInt("id"),
						rs.getInt("total_money"),
						rs.getString("payment_method"),
						rs.getFloat("discount"));
				orderList.add(order);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return orderList;
	}



	public Order getItem(int orderId) {
		Order order = new Order();
		con=ConnectDBUtils.getConnection();
		String sql="select * from orders where id=?";
		try {
			pst=con.prepareStatement(sql);
			pst.setInt(1, orderId);
			rs= pst.executeQuery();
			while (rs.next()) {
				 order = new Order(rs.getInt("id"),rs.getInt("total_money"),rs.getTimestamp("create_date"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return order;
	}

	public List<Order> findList(int userId) {
		List<Order> list=new ArrayList<>();
		con=ConnectDBUtils.getConnection();
		String sql="select * from orders where create_by =? ";
		try {
			pst=con.prepareStatement(sql);
			pst.setInt(1, userId);
			rs= pst.executeQuery();
			while (rs.next()) {
				Order  order = new Order(rs.getInt("id"),rs.getInt("total_money"),rs.getTimestamp("create_date"),rs.getFloat("discount"));
				list.add(order);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return list;	
	}
	
	public int numberOfItems() {
		int count = 0;
		con = ConnectDBUtils.getConnection();
		String sql = " SELECT COUNT(*) AS count FROM orders ";
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

	public List<Order> getByCategoryPagination(int offset, int perPage) {
		List<Order> list = new ArrayList<>();
		con = ConnectDBUtils.getConnection();
		String sql = "SELECT o.id,o.total_money,o.payment_method,o.discount,o.create_date,o.create_by from orders AS o  ORDER BY o.id DESC LIMIT ?, ?";
		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1, offset);
			pst.setInt(2, perPage);
			rs = pst.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("o.id");
				int totalMoney = rs.getInt("o.total_money");
				String paymentMethod = rs.getString("o.payment_method");
				int discount = rs.getInt("o.discount");
				Timestamp createDate = rs.getTimestamp("create_date");
				int createBy = rs.getInt("o.create_by");
				
				Order order = new Order(rs.getInt("o.id"),
						rs.getInt("o.total_money"),
						rs.getString("o.payment_method"),
						rs.getFloat("o.discount"),
						rs.getInt("o.create_by"),
						rs.getTimestamp("create_date"));

				list.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return list;
	}

}
