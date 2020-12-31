package controllers.admin.order;

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
import daos.OrderDAO;
import daos.ProductDAO;
import models.Category;
import models.Order;
import models.Product;
import utils.DefineUtil;



public class AdminIndexOrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminIndexOrderController() {
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
		
		OrderDAO  orderDAO = new OrderDAO();
		List<Order> orderList = new ArrayList();
		orderList=	orderDAO.findAll();
		int numberOfItems = 0;
		int numberOfPages = 0;
		int offset = 0;
		int perPage = DefineUtil.NUMBER_PER_PAGE_ADMIN_PRODUCT_INDEX;
		
		numberOfItems = orderDAO.numberOfItems();
		numberOfPages = (int) Math.ceil((float)numberOfItems / perPage);	
		if(currentPage > numberOfPages || currentPage <1) {
			currentPage = 1;
		}
		
		offset = (currentPage - 1) * perPage;
		orderList = orderDAO.getByCategoryPagination(offset, perPage);
		request.setAttribute("numberOfItems", numberOfItems);
		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("currentPage", currentPage);
	    request.setAttribute("orderList", orderList);  
		RequestDispatcher rd = request.getRequestDispatcher("/view/admin/order/index.jsp");
		rd.forward(request, response);
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
