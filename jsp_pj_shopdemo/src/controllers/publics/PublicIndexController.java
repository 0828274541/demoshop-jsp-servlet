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
import javax.servlet.jsp.JspWriter;

import daos.CatDAO;
import daos.ProductDAO;
import daos.ProductImageDAO;
import models.Category;
import models.Product;
import models.ProductImage;
import utils.DefineUtil;

public class PublicIndexController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicIndexController() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			currentPage = 1;
		}

		ProductDAO productDAO = new ProductDAO();
		CatDAO catDAO = new CatDAO();

		List<Category> listCatSearch = new ArrayList<Category>();

		listCatSearch = catDAO.findCategoryParentById(2); // Show những danh muc con của danh mục điệnt thoại
		List<Product> listProduct = new ArrayList<Product>();

		int numberOfItems = 0;
		int numberOfPages = 0;
		int offset = 0;
		int perPage = DefineUtil.NUMBER_PER_PAGE_PUBLIC_PRODUCT_INDEX;

		numberOfItems = productDAO.numberOfItems();
		numberOfPages = (int) Math.ceil((float) numberOfItems / perPage);
		if (currentPage > numberOfPages || currentPage < 1) {
			currentPage = 1;
		}

		offset = (currentPage - 1) * perPage;
		listProduct = productDAO.getByCategoryPagination(offset, perPage);

		// Lay ra 2 hinh anh cua 2 san pham moi nhat;
		List<ProductImage> listImageBanner = new ArrayList<ProductImage>();
		ProductImageDAO productImageDAO = new ProductImageDAO();

		if (listProduct.size() > 0) {
			for (int i = 0; i < 2; i++) {
				ProductImage proImg = new ProductImage();
				proImg = productImageDAO.getItemByProductId(listProduct.get(i).getId());
				if (proImg.getName() != null) {
					listImageBanner.add(proImg);
				}

			}
		}
		HttpSession session = request.getSession();
		request.setAttribute("numberOfItems", numberOfItems);
		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("listProduct", listProduct);
		session.setAttribute("listCatSearch", listCatSearch);
		request.setAttribute("listImageBanner", listImageBanner);

		List<Category> catListRecursive = catDAO.findAll();

		session.setAttribute("catListRecursive", catListRecursive);
		RequestDispatcher rd = request.getRequestDispatcher("/view/public/index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	public static void showCat(HttpServletRequest request, JspWriter out, int parentId)
			throws ServletException, IOException {
		CatDAO catDAO = new CatDAO();
		String link = "";
		String collapse = "";
		List<Category> catList = catDAO.findCategoryParentById(parentId);
		if (catList.size() > 0) {

			for (Category category : catList) {
				List<Category> catListChild = catDAO.findCategoryParentById(category.getId());
				if (catListChild.size() > 0) {
					link = "#" + category.getId();
					collapse = "collapse";
				} else {
					link = request.getContextPath() + "/public/cat?id=" + category.getId();
					collapse = "";
				}
				out.println("<ul>");
				out.println("<li>");
				out.println("<div class='accordion-heading' id='showCat"+category.getId()+"'>");
				out.println("<a href='" + link + "' data-toggle='" + collapse + "'>" + category.getName() + "</a>");
				out.println("</div>");
				out.println("<div id=" + category.getId() + " class='accordion-body collapse in'>");

				showCat(request, out, category.getId());
				out.println("</div>");
				out.println("</li>");
				out.println("</ul>");
			}

		}
	}
}
