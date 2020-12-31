package controllers.publics;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.OrderDAO;
import daos.OrderDetailDAO;
import daos.UserDAO;
import models.Order;
import models.OrderDetail;
import models.User;

public class PublicCheckOutController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicCheckOutController() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		int totalMoney = 0;
		List<OrderDetail> cartList = new ArrayList<OrderDetail>();
		if (session.getAttribute("cartList") != null) {
			cartList = (ArrayList<OrderDetail>) session.getAttribute("cartList");
		}

		if (cartList.size() > 0) {
			for (OrderDetail od : cartList) {

				if (od.getProduct().getSaleOff() != 0) {
					totalMoney += od.getProduct().getSaleOff() * od.getQuantity();
				} else {
					totalMoney += od.getProduct().getPrice() * od.getQuantity();
				}

			}
		}

		request.setAttribute("totalMoney", totalMoney);
		RequestDispatcher rd = request.getRequestDispatcher("/view/public/checkout.jsp");
		rd.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		List<OrderDetail> cartList = new ArrayList<OrderDetail>();
		if (session.getAttribute("cartList") != null) {
			cartList = (ArrayList<OrderDetail>) session.getAttribute("cartList");
		}

		String fullname = "";
		String address = "";
		int telephoneNumber = 0;
		int totalMoney = 0;
		float discount = 0;
		String paymentMethod = "";

		if (request.getParameter("totalMoney") != null) {
			totalMoney = Integer.parseInt(request.getParameter("totalMoney"));
		}
		if (request.getParameter("discount") != null) {
			discount = Float.parseFloat(request.getParameter("discount"));
		}
		if (request.getParameter("paymentMethod") != null) {
			paymentMethod = request.getParameter("paymentMethod");
		}
		if (request.getParameter("fullname") != null) {
			fullname = request.getParameter("fullname");
		}
		if (request.getParameter("address") != null) {
			address = request.getParameter("address");
		}
		if (request.getParameter("phone") != null) {
			telephoneNumber = Integer.parseInt(request.getParameter("phone"));
		}
		User user = new User();
		if (session.getAttribute("userInfor") != null) {
			user = (User) session.getAttribute("userInfor");
		}
		// edit them thong tin user
		user.setFullname(fullname);
		user.setAddress(address);
		user.setTelephoneNumber(telephoneNumber);
		user.setUpdateBy(user.getId());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		user.setUpdateDate(timestamp);
		UserDAO userDAO = new UserDAO();
		userDAO.editItem(user);

		// add don hang
		Order order = new Order();
		order.setTotalMoney(totalMoney);
		order.setDiscount(discount);
		order.setPaymentMethod(paymentMethod);
		order.setCreateBy(user.getId());

		OrderDAO orderDAO = new OrderDAO();
		orderDAO.addItem(order);

		// add chi tiet don hang
		List<Order> orderList = new ArrayList<Order>();
		orderList = orderDAO.findAll();
		int maxId = 0;
		if (orderList.size() > 0) {
			for (Order order1 : orderList) {
				if (order1.getId() > maxId) {
					maxId = order1.getId();

				}
			}
		}
		OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
		if (cartList.size() > 0) {
			for (OrderDetail order3 : cartList) {
				OrderDetail orderDetail = new OrderDetail(new Order(maxId), order3.getProduct(), order3.getQuantity());
				orderDetailDAO.addItem(orderDetail);
			}
		}

		session.removeAttribute("cartList");
		response.sendRedirect(request.getContextPath() + "/public/index?msg=1&orderId=" + maxId);
		return;

	}
}
