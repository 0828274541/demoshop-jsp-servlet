package daos;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Category;
import models.OrderDetail;
import models.Product;
import models.User;
import utils.ConnectDBUtils;

public class OrderDetailDAO extends AbstractDAO {

	

	public int addItem(OrderDetail orderDetail) {
		int result = 0;
		con=ConnectDBUtils.getConnection();
		String sql=" INSERT INTO  order_details(order_id,product_id,quantity) values(?,?,?)";
		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1, orderDetail.getOrder().getId());
			pst.setInt(2, orderDetail.getProduct().getId());
			pst.setInt(3, orderDetail.getQuantity());
			result = pst.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			ConnectDBUtils.close(rs, st, con);
		}
		return result;
	}


	public List<OrderDetail> findByOrderId(int orderId) {
		List<OrderDetail> list=new ArrayList<>();
		con=ConnectDBUtils.getConnection();
		String sql="select * from order_details where order_id = ? ";
		try {
			pst=con.prepareStatement(sql);
			pst.setInt(1, orderId);
			rs= pst.executeQuery();
			while (rs.next()) {
				OrderDetail  orderDetail = new OrderDetail(new Product(rs.getInt("product_id")),rs.getInt("quantity"));
				list.add(orderDetail);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUtils.close(rs, st, con);
		}
		return list;	
	}


}
