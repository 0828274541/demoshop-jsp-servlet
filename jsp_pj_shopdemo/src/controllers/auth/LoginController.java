package controllers.auth;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.ProductDAO;
import daos.UserDAO;
import models.OrderDetail;
import models.Product;
import models.User;
import utils.StringUtil;


public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public LoginController() {
        super();
      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/view/auth/login.jsp");
		HttpSession session = request.getSession();
		if(request.getAttribute("productId")!=null && request.getAttribute("quantity")!=null) {
			int productId = (int) session.getAttribute("productId");
			int quantity = (int) session.getAttribute("quantity");
			session.setAttribute("productId", productId);
			session.setAttribute("quantity", quantity);

	}
				rd.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		int productId = 0;
		int quantity = 0;
		password  = StringUtil.md5(password);
		UserDAO userDAO = new UserDAO();
		User userInfor = userDAO.login(username, password);
		HttpSession session = request.getSession();
		
		if(userInfor != null) {	
			if(session.getAttribute("productId")!=null && session.getAttribute("quantity")!=null) {
					productId = (int) session.getAttribute("productId");
					quantity = (int) session.getAttribute("quantity");
			}
			
			if(productId!=0) {
				
				session.setAttribute("userInfor", userInfor);
				ProductDAO productDAO = new ProductDAO();
				Product productDetail = new Product();
				productDetail = productDAO.getItem(productId);
				List<OrderDetail> cartList = new ArrayList<OrderDetail>();
				OrderDetail od = new OrderDetail();
				od.setProduct(productDetail);
				od.setQuantity(quantity);
				cartList.add(od);
				session.setAttribute("cartList", cartList);
				session.setAttribute("msg", 1);
				response.sendRedirect(request.getContextPath()+"/public/detail?id="+productId);
				return;
				}
			
			session.setAttribute("userInfor", userInfor);
			response.sendRedirect(request.getContextPath()+"/public/index");
			return;
		}else {
			response.sendRedirect(request.getContextPath()+"/login?err=1");
			return;
		}
	}

}
