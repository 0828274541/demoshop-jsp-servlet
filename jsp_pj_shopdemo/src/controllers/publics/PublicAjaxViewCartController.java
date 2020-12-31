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

import daos.ProductImageDAO;
import models.OrderDetail;

public class PublicAjaxViewCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicAjaxViewCartController() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		int totalMoney = 0;
		Locale locale = new Locale("vi", "VN");
		NumberFormat format = NumberFormat.getCurrencyInstance(locale);
		List<OrderDetail> cartList = new ArrayList<OrderDetail>();
		if (session.getAttribute("cartList") != null) {
			cartList = (ArrayList<OrderDetail>) session.getAttribute("cartList");
		}

		out.print("<div class='basket-item-count'>");
		out.print("<span class='count'>" + cartList.size() + "</span>");

		out.print("<img src='" + request.getContextPath() + "/templates/public/assets/images/icon-cart.png' alt='' />");
		out.print("</div>");
		out.print(" <div class='total-price-basket'>");
		out.print("<span class='lbl'>your cart:</span>");
		out.print("<span class='total-price'>");

		if (cartList.size() > 0) {
			for (OrderDetail od : cartList) {

				if (od.getProduct().getSaleOff() != 0) {
					totalMoney += od.getProduct().getSaleOff() * od.getQuantity();
				} else {
					totalMoney += od.getProduct().getPrice() * od.getQuantity();
				}

			}
		}
		out.print("<span class='value'>" + format.format(totalMoney) + "</span>");
		out.print("</span>");
		out.print(" </div>");

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		List<OrderDetail> cartList = new ArrayList<OrderDetail>();
		if (session.getAttribute("cartList") != null) {
			cartList = (ArrayList<OrderDetail>) session.getAttribute("cartList");
		}
		ProductImageDAO proImgDAO = new ProductImageDAO();
		Locale locale = new Locale("vi", "VN");
		NumberFormat format = NumberFormat.getCurrencyInstance(locale);
		for (OrderDetail orderDetail : cartList) {
			out.print("<li id=" + orderDetail.getProduct().getId() + ">");
			out.println("<div class='basket-item'>");
			out.println("<div class='row'>");
			out.println("<div class='col-xs-4 col-sm-4 no-margin text-center'>");

			out.println("<div class='thumb'>");
			out.println("<a href='" + request.getContextPath() + "/public/detail?id=" + orderDetail.getProduct().getId()
					+ "'>");
			out.println("<img alt='' height='50px' width='50px' src='" + request.getContextPath() + "/uploads/"
					+ proImgDAO.getItemByProductId(orderDetail.getProduct().getId()).getName() + "'/>");
			out.println("</a>");
			out.println("</div>");

			out.println("</div>");
			out.println("<div class='col-xs-8 col-sm-8 no-margin'>");
			out.println("<div class='title'>");
			out.println("<a href='" + request.getContextPath() + "/public/detail?id=" + orderDetail.getProduct().getId()
					+ "'>");
			out.println(orderDetail.getProduct().getName() + "</a>");
			out.println("</div>");
			if (orderDetail.getProduct().getSaleOff() != 0) {
				out.println("<div class='price'>" + format.format(orderDetail.getProduct().getSaleOff()) + " x "
						+ orderDetail.getQuantity() + "</div>");
			} else {
				out.println("<div class='price'>" + format.format(orderDetail.getProduct().getPrice()) + " x "
						+ orderDetail.getQuantity() + "</div>");
			}
			out.println("</div>");
			out.println("</div>");
			out.println("<a class='close-btn xoa' id='" + orderDetail.getProduct().getId()
					+ "' onclick='dellItem(this)' href='#'>Xoa</a>");
			out.println("</div>");
			out.println("</li>");

		}

	}

}
