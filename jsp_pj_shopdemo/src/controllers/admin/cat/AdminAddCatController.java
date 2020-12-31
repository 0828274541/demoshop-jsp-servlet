	package controllers.admin.cat;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;
import javax.websocket.Session;

import daos.CatDAO;
import models.Category;
import models.User;



public class AdminAddCatController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CatDAO catDAO;
    public AdminAddCatController() {
        super();
        catDAO = new CatDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfor")==null) {
			response.sendRedirect(request.getContextPath()+"/login");
			return;
		}
		
		List<Category> catList = new ArrayList<Category>();
		catList = catDAO.findAll();
		RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/add.jsp");
		request.setAttribute("catList", catList);
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		
		
		String name = "";
		int parent_id = 0;
		int createBy= 0;
		if(request.getParameter("name")!=null) {
			 name = request.getParameter("name");
		}
		if(request.getParameter("parent_id")!=null) {
			parent_id = Integer.parseInt(request.getParameter("parent_id"));
		}
		
		
		
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfor")==null) {
			User user = new User();
			user = (User) session.getAttribute("userInfor");
			createBy = user.getId();	
		}
		Category cat = new Category(name.trim(),parent_id,createBy);
		
		if(catDAO.hasCat(cat.getName())) {
			RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/add.jsp?err=1");
			rd.forward(request, response);
			return;
		}
	
		if(catDAO.add(cat) > 0) {
			response.sendRedirect(request.getContextPath()+"/admin/cat/add?msg=1");
			return;
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/add.jsp?err=2");
		rd.forward(request, response);
		return;
	}
	public static void showCatAdd(HttpServletRequest request,JspWriter out, int parentId, String menu) throws ServletException, IOException {
	
		CatDAO catDAO = new CatDAO();
		List<Category> catListChild = catDAO.findCategoryParentById(parentId);
		if(catListChild.size()>0) {
				
			for (Category category : catListChild) {
				out.print("<option value="+category.getId()+">"+menu+category.getName()+"</option>");
				showCatAdd(request, out, category.getId(), menu+"|----");
			}
			
		}
	}
}
