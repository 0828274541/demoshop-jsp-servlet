package controllers.auth;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.UserDAO;
import models.User;
import utils.FileUtil;
import utils.StringUtil;


public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public LogoutController() {
        super();
      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("userInfor");
		session.removeAttribute("cartList");
		session.removeAttribute("productId");
		session.removeAttribute("quantity");
		response.sendRedirect(request.getContextPath()+"/");
		return;
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
	}
}
