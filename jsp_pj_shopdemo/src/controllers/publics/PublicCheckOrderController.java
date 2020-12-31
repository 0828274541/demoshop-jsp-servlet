package controllers.publics;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.OrderDAO;
import models.Order;
import models.User;

public class PublicCheckOrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicCheckOrderController() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		User user = new User();
		if (session.getAttribute("userInfor") != null) {
			user = (User) session.getAttribute("userInfor");
		}
		OrderDAO orderDAO = new OrderDAO();
		List<Order> orderList = new ArrayList();
		orderList = orderDAO.findList(user.getId());

		request.setAttribute("orderList", orderList);
		RequestDispatcher rd = request.getRequestDispatcher("/view/public/findorder.jsp");
		rd.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}
}
