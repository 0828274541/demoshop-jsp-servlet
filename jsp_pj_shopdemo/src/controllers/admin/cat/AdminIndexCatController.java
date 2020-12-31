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

import daos.CatDAO;
import models.Category;
import utils.DefineUtil;



public class AdminIndexCatController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CatDAO catDAO;
    public AdminIndexCatController() {
        super();
        catDAO = new CatDAO();
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
		
	
	
		CatDAO catDAO = new CatDAO();
		List<Category> catList  = catDAO.findAll();
		
        
		RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/index.jsp");
		request.setAttribute("catList", catList);
		rd.forward(request, response);
		return;
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	public static void showCat(HttpServletRequest request, JspWriter out, int parentId, String menu) throws ServletException, IOException {
		CatDAO catDAO = new CatDAO();
		List<Category> catListChild = catDAO.findCategoryParentById(parentId);
		if(catListChild.size()>0) {
				
			for (Category category : catListChild) {
				out.print("<tr><td>"+category.getId()+"</td><td>"+menu+category.getName()+"</td><td><a href='"+request.getContextPath()+"/admin/cat/edit?id="+category.getId()+"' class='btn btn-primary'><i class='fa fa-edit'></i>Sửa</a><a href='#' id="+category.getId()+" class='btn btn-secondary xoa'><i class='fa fa-edit'></i>Xóa</a></td></tr>");
    			showCat(request, out, category.getId(), menu+"|----");
			}
			
		}
	}
	
}
