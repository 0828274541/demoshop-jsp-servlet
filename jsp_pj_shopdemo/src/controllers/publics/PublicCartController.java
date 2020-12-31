package controllers.publics;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.CatDAO;
import daos.ProductDAO;
import models.OrderDetail;
import models.Product;

public class PublicCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicCartController() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		int totalMoney = 0;
		Locale locale = new Locale("vi", "VN");
		NumberFormat format = NumberFormat.getCurrencyInstance(locale);
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

		request.setAttribute("orderMoney", format.format(totalMoney));
		RequestDispatcher rd = request.getRequestDispatcher("/view/public/cart.jsp");
		rd.forward(request, response);
		return;

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		int productId = 0;
		int quantity = 0;

		if (request.getParameter("quantity") != null) {
			quantity = Integer.parseInt(request.getParameter("quantity"));
		}
		if (request.getParameter("productId") != null) {
			productId = Integer.parseInt(request.getParameter("productId"));
		}

		List<OrderDetail> cartList = new ArrayList<OrderDetail>();
		if (session.getAttribute("cartList") != null) {
			cartList = (ArrayList<OrderDetail>) session.getAttribute("cartList");

		}
		if (quantity == 0 && productId == 0) {
			out.print(cartList.size());
			return;
		}

		ProductDAO productDAO = new ProductDAO();
		CatDAO catDAO = new CatDAO();

		Product productDetail = new Product();
		productDetail = productDAO.getItem(productId);

		if (session.getAttribute("userInfor") == null) {
			out.print("1");
			session.setAttribute("productId", productId);
			session.setAttribute("quantity", quantity);
			return;
		}

		boolean boo = false;
		for (OrderDetail orderDetail : cartList) {
			if (orderDetail.getProduct().getId() == productId) {
				boo = true;
			}
		}
		if (boo == true) {
			for (OrderDetail orderDetail : cartList) {
				if (orderDetail.getProduct().getId() == productId) {
					orderDetail.setQuantity(quantity + orderDetail.getQuantity());
					out.print("2");
				}
			}
		} else {
			OrderDetail od = new OrderDetail();
			od.setProduct(productDetail);
			od.setQuantity(quantity);
			cartList.add(od);
			session.setAttribute("cartList", cartList);
			out.print("2");
		}

	}

}
