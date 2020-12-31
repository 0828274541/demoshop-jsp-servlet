package controllers.admin.cat;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.CatDAO;
import models.Category;
import models.User;



public class AdminDelCatController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CatDAO catDAO;
	
    public AdminDelCatController() {
        super();
        catDAO = new CatDAO();
      ;
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		if(session.getAttribute("userInfor")==null) {
			response.sendRedirect(request.getContextPath()+"/login");
			return;
		}
		int id = 0;
		try {
			id =Integer.parseInt(request.getParameter("id"));
		}catch (Exception e) {
			response.sendRedirect(request.getContextPath()+"/admin/cat/index?err=1");
			return;	
		}
		PrintWriter out = response.getWriter();
		Category cat = catDAO.getItem(id);

		List<Category> catList = new ArrayList<Category>();
		catList = catDAO.findAll();
		boolean boo = false;
		for (Category category : catList) {
			if(cat.getId()==category.getParent_id()) {
				boo = true;
			}
		}
		if(boo == true) {
			
			out.print("true");
			
		}else {
		
			catDAO.delItem(id);
			out.print("false");
		}
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
