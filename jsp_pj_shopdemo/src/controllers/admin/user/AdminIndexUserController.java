package controllers.admin.user;

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
import daos.UserDAO;
import models.Category;
import models.Product;
import models.User;
import utils.AuthUtil;
import utils.DefineUtil;



public class AdminIndexUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminIndexUserController() {
        super();
     
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath()+"/login");
			return;
		}
		UserDAO userDAO = new UserDAO();
		HttpSession session = request.getSession();
	
		User user = (User) session.getAttribute("userInfor");
		RequestDispatcher rd = request.getRequestDispatcher("/view/admin/user/index.jsp");
		if(user.getRole().getName().equals("ADMIN")) {
			List<User> userList = userDAO.findAllExceptId(user.getId());
			request.setAttribute("userList", userList);
			
			rd.forward(request, response);
			return;
		}
		
		rd.forward(request, response);
		return;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
