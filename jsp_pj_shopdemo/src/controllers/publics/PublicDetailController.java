package controllers.publics;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.ProductDAO;
import daos.ProductImageDAO;
import models.Product;
import models.ProductImage;

public class PublicDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicDetailController() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");

		int id = 0;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (Exception e) {
			RequestDispatcher rd = request.getRequestDispatcher("/view/public/404.jsp");
			String msg = "ko tim thấy trang yêu cầu";
			request.setAttribute("msg", msg);
			rd.forward(request, response);
			return;
		}
		ProductDAO productDAO = new ProductDAO();

		Product productDetail = new Product();
		productDetail = productDAO.getItem(id);
		if (productDetail == null) {
			RequestDispatcher rd = request.getRequestDispatcher("/view/public/404.jsp");
			String msg = "ko tim thấy trang yêu cầu";
			request.setAttribute("msg", msg);
			rd.forward(request, response);
			return;
		}
		ProductImageDAO proImgDAO = new ProductImageDAO();
		List<ProductImage> imgList = proImgDAO.getByProductId(id);
		System.out.println(productDetail.getReleaseDate());

		request.setAttribute("imgList", imgList);
		request.setAttribute("productDetail", productDetail);
		RequestDispatcher rd = request.getRequestDispatcher("/view/public/detail.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
