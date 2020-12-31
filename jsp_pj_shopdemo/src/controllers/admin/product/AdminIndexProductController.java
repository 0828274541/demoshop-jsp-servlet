package controllers.admin.product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.CatDAO;
import daos.ProductDAO;
import models.Category;
import models.Product;
import utils.DefineUtil;



public class AdminIndexProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminIndexProductController() {
        super();
     
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfor")==null) {
			response.sendRedirect(request.getContextPath()+"/login");
			return;
		}
		int currentPage = 1;
		try {
			currentPage =Integer.parseInt(request.getParameter("page"));
		}catch (Exception e) {
			currentPage = 1;
		}
		
		String searchResult = "";
		int searchId = 0;
		if(null!=(request.getParameter("searchResult"))) {
			searchResult = request.getParameter("searchResult");
		}
		if(null!=(request.getParameter("searchId"))) {
			searchId = Integer.parseInt(request.getParameter("searchId"));
		}
		
		ProductDAO productDAO = new ProductDAO();
		List<Category> listCatSearch = new ArrayList<Category>();
		CatDAO catDAO = new CatDAO();
		listCatSearch = catDAO.findCategoryParentById(1); //Show những danh muc con của danh mục sản phẩm
		List<Product> listProduct = new ArrayList<Product>();
		
		Product product = new Product(searchResult,new Category(searchId));	
		int numberOfItems = 0;
		int numberOfPages = 0;
		int offset = 0;
		int perPage = DefineUtil.NUMBER_PER_PAGE_ADMIN_PRODUCT_INDEX;
		
		if(searchId>0 || !"".equals(searchResult)) {
			numberOfItems = productDAO.numberOfItems(product);
			numberOfPages = (int) Math.ceil((float)numberOfItems / perPage);
			if(currentPage > numberOfPages || currentPage <1) {
				currentPage = 1;
			}
			offset = (currentPage - 1) * perPage;
			listProduct = productDAO.getByCategoryPaginationWithSeachResult(offset, product, perPage);	
		}else {
			numberOfItems = productDAO.numberOfItems();
			numberOfPages = (int) Math.ceil((float)numberOfItems / perPage);	
			if(currentPage > numberOfPages || currentPage <1) {
				currentPage = 1;
			}
			
			offset = (currentPage - 1) * perPage;
			listProduct = productDAO.getByCategoryPagination(offset, perPage);	
		}
			
		request.setAttribute("numberOfItems", numberOfItems);
		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("listProduct", listProduct);
		request.setAttribute("listCatSearch", listCatSearch);
		request.setAttribute("searchId", searchId);
		request.setAttribute("searchResult", searchResult);
		
		RequestDispatcher rd = request.getRequestDispatcher("/view/admin/product/index.jsp");
		rd.forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
