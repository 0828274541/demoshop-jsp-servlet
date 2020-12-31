package controllers.publics;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.CatDAO;
import daos.ProductDAO;
import models.Category;
import models.Product;
import utils.DefineUtil;

public class PublicCategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicCategoryController() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int currentPage = 1;
		int catId = 0;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			currentPage = 1;
		}
		try {
			catId = Integer.parseInt(request.getParameter("id"));

		} catch (Exception e) {
			RequestDispatcher rd = request.getRequestDispatcher("/view/public/404.jsp");
			String msg = "ko tim thấy trang yêu cầu";
			request.setAttribute("msg", msg);
			rd.forward(request, response);
			return;
		}

		ProductDAO productDAO = new ProductDAO();
		CatDAO catDAO = new CatDAO();
		Category cat = new Category();
		cat = catDAO.getItem(catId);

		if (cat == null) {
			RequestDispatcher rd = request.getRequestDispatcher("/view/public/404.jsp");
			String msg = "ko tim thấy trang yêu cầu";
			request.setAttribute("msg", msg);
			rd.forward(request, response);
			return;
		}
		List<Product> listProduct = new ArrayList<Product>();

		int numberOfItems = 0;
		int numberOfPages = 0;
		int offSet = 0;
		int perPage = DefineUtil.NUMBER_PER_PAGE_PUBLIC_PRODUCT_CATEGORY;

		numberOfItems = productDAO.numberOfItems(catId);
		if (numberOfItems > 0) {
			numberOfPages = (int) Math.ceil((float) numberOfItems / perPage);
			if (currentPage > numberOfPages || currentPage < 1) {
				currentPage = 1;
			}

			offSet = (currentPage - 1) * perPage;
			listProduct = productDAO.getByCategoryPagination(offSet, perPage);
		}

		request.setAttribute("perPage", perPage);
		request.setAttribute("offSet", offSet);
		request.setAttribute("numberOfItems", numberOfItems);
		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("listProduct", listProduct);
		request.setAttribute("cat", cat);

		RequestDispatcher rd = request.getRequestDispatcher("/view/public/category.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
