package controllers.publics;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.OrderDetail;

public class PublicAjaxDelCartItemController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicAjaxDelCartItemController() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		int productId = 0;
		int quantity1 = 0;
		int price = 0;

		if (request.getParameter("quantity1") != null) {
			quantity1 = Integer.parseInt(request.getParameter("quantity1"));
		}
		if (request.getParameter("productId") != null) {
			productId = Integer.parseInt(request.getParameter("productId"));
		}
		List<OrderDetail> cartList = new ArrayList<OrderDetail>();
		if (session.getAttribute("cartList") != null) {
			cartList = (ArrayList<OrderDetail>) session.getAttribute("cartList");
		}
		for (OrderDetail orderDetail : cartList) {
			if (orderDetail.getProduct().getId() == productId) {
				orderDetail.setQuantity(quantity1 + orderDetail.getQuantity());

			}
			if (orderDetail.getProduct().getSaleOff() != 0) {
				price = orderDetail.getProduct().getSaleOff() * quantity1;
			} else {
				price = orderDetail.getProduct().getPrice() * quantity1;
			}
		}
		session.setAttribute("cartList", cartList);
		Locale locale = new Locale("vi", "VN");
		NumberFormat format = NumberFormat.getCurrencyInstance(locale);

		out.print(format.format(price));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		int productId = 0;
		if (request.getParameter("productId") != null) {
			productId = Integer.parseInt(request.getParameter("productId"));
		}

		List<OrderDetail> cartList = new ArrayList<OrderDetail>();
		if (session.getAttribute("cartList") != null) {
			cartList = (ArrayList<OrderDetail>) session.getAttribute("cartList");
		}
		if (cartList.size() > 0) {
			for (int i = 0; i < cartList.size(); i++) {

				if (cartList.get(i).getProduct().getId() == productId) {

					cartList.remove(i);
				}
			}
		}

		session.setAttribute("cartList", cartList);
	}

}
