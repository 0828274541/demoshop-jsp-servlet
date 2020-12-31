package controllers.admin.cat;

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
import models.Category;
import models.User;



public class AdminEditCatController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	

    public AdminEditCatController() {
        super();
       
        

        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfor")==null) {
			response.sendRedirect(request.getContextPath()+"/login");
			return;
		}
		
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		int id = 0;
		try {
			id =Integer.parseInt(request.getParameter("id"));
		}catch (Exception e) {
			RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/edit.jsp?err=2");
			rd.forward(request, response);
			return;	
		}
		CatDAO catDAO = new CatDAO();
		Category category = catDAO.getItem(id);
		
		if(category !=null) {

		List<Category> catList = new ArrayList<Category>();
		catList = catDAO.findAll();
		
		request.setAttribute("catList", catList);
		request.setAttribute("category", category);
		RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/edit.jsp");
		rd.forward(request, response);
		return;
		}else {
			RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/edit.jsp?err=2");
			rd.forward(request, response);
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		int id = 0;
		String name = "";
		int parent_id = 0;
		int updateBy = 0;
		
		try {
			id =Integer.parseInt(request.getParameter("id"));
		}catch (Exception e) {
			RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/edit.jsp?err=2");
			rd.forward(request, response);
			return;
			
		}
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
			updateBy = user.getId();	
		}
		
		CatDAO catDAO = new CatDAO();
		Category category = catDAO.getItem(id);
		Category categoryEdit = new Category(id, name.trim(),parent_id,updateBy,category.getCreateDate());	
		
		
		//Check danh mục ko thể thuộc chính nó
				if(category.getId()==categoryEdit.getParent_id() ) {
					RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/edit.jsp?err=5");
					List<Category> catList = new ArrayList<Category>();
					catList = catDAO.findAll();	
					request.setAttribute("catList", catList);
					request.setAttribute("category", category);
					rd.forward(request, response);
					return;
				}
				
		//Check trùng tên cũ thi cho phep update
		if(categoryEdit.getName().equals(category.getName())) {
			if(catDAO.editItem(categoryEdit)>0) {
				RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/edit.jsp?msg=1");
				rd.forward(request, response);
				return;	
			}	
		}
		//Check trùng tên khác trong db thi ko cho phep update
		if(catDAO.hasCat(categoryEdit.getName()) ) {
			RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/edit.jsp?err=1");
			List<Category> catList = new ArrayList<Category>();
			catList = catDAO.findAll();	
			request.setAttribute("catList", catList);
			request.setAttribute("category", category);
			rd.forward(request, response);
			return;
		}
		//Check  tên rỗng thi ko cho phep update
		if(categoryEdit.getName().isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/edit.jsp?err=4");
			List<Category> catList = new ArrayList<Category>();
			catList = catDAO.findAll();	
			request.setAttribute("catList", catList);
			request.setAttribute("category", category);
			rd.forward(request, response);
			return;	
		}
		
		if(catDAO.editItem(categoryEdit)>0) {
			RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/edit.jsp?msg=1");
			rd.forward(request, response);
			return;	
		}	
		
		RequestDispatcher rd = request.getRequestDispatcher("/view/admin/cat/edit.jsp?err=3");
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
