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


public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public RegisterController() {
        super();
      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		

		RequestDispatcher rd = request.getRequestDispatcher("/view/auth/register.jsp");
		rd.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		UserDAO userDAO = new UserDAO();
		
		if(userDAO.hasUser(username)) {
			RequestDispatcher rd = request.getRequestDispatcher("/view/auth/register.jsp?err=1");
			rd.forward(request, response);
			return;
		}
		System.out.println("1 "+username+" "+password);
		password  = StringUtil.md5(password);
		
		User user = new User(username, password);
		if(userDAO.addItem(user)> 0) {
			response.sendRedirect(request.getContextPath()+"/register?msg=1");
			return;
	}else {
		response.sendRedirect(request.getContextPath()+"/register?err=2");
		return;
	}

}
}