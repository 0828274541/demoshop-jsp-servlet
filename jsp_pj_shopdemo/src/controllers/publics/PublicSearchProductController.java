package controllers.publics;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.ProductDAO;
import models.Product;

public class PublicSearchProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicSearchProductController() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String searchResult = "";
		if (null != (request.getParameter("searchResult"))) {
			searchResult = request.getParameter("searchResult");
			ProductDAO productDAO = new ProductDAO();

			List<Product> listProduct = new ArrayList<Product>();
			Product product = new Product(searchResult);
			listProduct = productDAO.getBySeachResult(product);

			request.setAttribute("listProduct", listProduct);
			request.setAttribute("searchResult", searchResult);
			RequestDispatcher rd = request.getRequestDispatcher("/view/public/search.jsp");
			rd.forward(request, response);
			return;
		}

		response.sendRedirect(request.getContextPath() + "/public/index");
		return;
	}

}
