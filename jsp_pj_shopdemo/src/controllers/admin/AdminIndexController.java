package controllers.admin;

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
import models.Category;


public class AdminIndexController extends HttpServlet {
	private static final long serialVersionUID = 1L;

   
    public AdminIndexController() {
    	super();
  
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfor")==null) {
			response.sendRedirect(request.getContextPath()+"/login");
			return;
		}
		
		CatDAO catDAO = new CatDAO();
		List<Category> catListLeftBar = new ArrayList<Category>();
		
		//catListLeftBar = catDAO.findCategoryParentById(1); //Show những danh muc con của danh mục sản phẩm
		
		RequestDispatcher rd = request.getRequestDispatcher("/view/admin/index.jsp");
		//session.setAttribute("catListLeftBar", catListLeftBar);
		rd.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
