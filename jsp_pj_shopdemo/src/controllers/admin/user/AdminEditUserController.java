package controllers.admin.user;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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



public class AdminEditUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminEditUserController() {
        super();
     
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath()+"/login");
			return;
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		
		UserDAO userDAO = new UserDAO();
		HttpSession session = request.getSession();
		User userLogin = new User();
		if(session.getAttribute("userInfor")!=null) {
			userLogin =(User) session.getAttribute("userInfor");
		}
		int id = 0;
		String fullname = null;
		String address = null;
		int telephoneNumber = 0;
		
		if(request.getParameter("fullname")!=null ) {
			fullname = request.getParameter("fullname");
		}
		if(request.getParameter("address")!=null) {
			address = request.getParameter("address");
		}
		if(request.getParameter("id")!=null) {
			try {
				id = Integer.parseInt(request.getParameter("id"));
			}catch(Exception e){
				id = 0;
				session.setAttribute("err", "Lỗi id ko xác định");
				response.sendRedirect(request.getContextPath()+"/admin/user/index");
				return;
			}
		}
		if(request.getParameter("telephoneNumber")!=null) {
			try {
				telephoneNumber = Integer.parseInt(request.getParameter("telephoneNumber"));
			}catch(Exception e){
				id = 0;
			}
		}

		User user =  userDAO.getItem(id);
		if(user.getId()==0) {
			session.setAttribute("err", "Lỗi id ko xác định");
			response.sendRedirect(request.getContextPath()+"/admin/user/index");
			return;
		}
	
		user.setFullname(fullname);
		user.setAddress(address);
		user.setTelephoneNumber(telephoneNumber);
		user.setUpdateBy(userLogin.getId());
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		user.setUpdateDate(timestamp);
		if(userDAO.editItem(user)>0) {
			
			if(userLogin.getId()==user.getId()) {
				session.setAttribute("userInfor", user);
			}
			session.setAttribute("msg", "Cập nhật thông tin thành công");
			response.sendRedirect(request.getContextPath()+"/admin/user/index");
			return;
		}else {
			session.setAttribute("err", "Lỗi ko xác định");
			response.sendRedirect(request.getContextPath()+"/admin/user/index");
			return;
		}
		
	}

}
