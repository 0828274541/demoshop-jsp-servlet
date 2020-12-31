package controllers.admin.product;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.servlet.jsp.JspWriter;

import daos.CatDAO;
import daos.ProductDAO;
import daos.ProductImageDAO;
import models.Category;
import models.Product;
import models.ProductImage;
import models.User;
import utils.FileUtil;

@MultipartConfig
public class AdminEditProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CatDAO catDAO;

	public AdminEditProductController() {
		super();
		catDAO = new CatDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		if (session.getAttribute("userInfor") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		int id = 0;
		if (request.getParameter("id") != null) {
			try {
				id = Integer.parseInt(request.getParameter("id"));
			} catch (Exception e) {
				id = 0;
			}
		}
		ProductImageDAO proImgDAO = new ProductImageDAO();
		ProductDAO proDAO = new ProductDAO();
		Product pro = proDAO.getItem(id);
		List<Category> catList = new ArrayList<Category>();
		catList = catDAO.findAll();
		List<Category> catListChild = new ArrayList<Category>();
		for (int i = 0; i < catList.size(); i++) {
			boolean boo = false;
			for (Category category : catList) {
				if (catList.get(i).getParent_id() != category.getId()) {
					if (catList.get(i).getParent_id() != 0
							&& !(catDAO.findCategoryParentById(catList.get(i).getId()).size() > 0)) {
						boo = true;
					}
				}
			}
			if (boo == true) {
				catListChild.add(catList.get(i));
			}
		}
		List<ProductImage> imageList = proImgDAO.getByProductId(id);
		RequestDispatcher rd = request.getRequestDispatcher("/view/admin/product/edit.jsp");
		request.setAttribute("catList", catListChild);
		request.setAttribute("product", pro);
		request.setAttribute("imageList", imageList);
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		int id = 0;
		String name = "";
		int categoryId = 0;
		int price = 0;
		int saleOff = 0;
		String preview = "";
		String storage = "";
		String ram = "";
		String cameraFeature = "";
		String batteryCapacity = "";
		String producer = "";
		Date releaseDate = null;
		int updateBy = 0;
		String applyDeleteImage= "";
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("userInfor");
		updateBy = user.getId();

		if (request.getParameter("id") != null) {
			id = Integer.parseInt(request.getParameter("id"));
		}
		if (request.getParameter("name") != null) {
			name = request.getParameter("name");
		}
		if (request.getParameter("category_id") != null) {
			categoryId = Integer.parseInt(request.getParameter("category_id"));
		}
		if (request.getParameter("price") != null) {
			price = Integer.parseInt(request.getParameter("price"));
		}
		if (request.getParameter("sale_off") != null) {
			try {
				saleOff = Integer.parseInt(request.getParameter("sale_off"));
			} catch (Exception e) {
				saleOff = 0;
			}
		}
		if (request.getParameter("preview") != null) {
			preview = request.getParameter("preview");
		}
		if (request.getParameter("storage") != null) {
			storage = request.getParameter("storage");
		}
		if (request.getParameter("ram") != null) {
			ram = request.getParameter("ram");
		}
		if (request.getParameter("camera_feature") != null) {
			cameraFeature = request.getParameter("camera_feature");
		}
		if (request.getParameter("battery_capacity") != null) {
			batteryCapacity = request.getParameter("battery_capacity");
		}
		if (request.getParameter("producer") != null) {
			producer = request.getParameter("producer");
		}

		if (request.getParameter("applyDeleteImage") != null) {
			applyDeleteImage = request.getParameter("applyDeleteImage");
		}
		
		if (request.getParameter("release_date") != null) {
			String startDateStr = request.getParameter("release_date");
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			try {

				java.sql.Date sql = new java.sql.Date(formatter.parse(startDateStr).getTime());
				releaseDate = sql;
				// System.out.println(formatter.format(sql));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        
		Product pro = new Product();
		pro.setId(id);
		pro.setName(name);
		pro.setGetCategory(new Category(categoryId));
		pro.setPrice(price);
		pro.setSaleOff(saleOff);
		pro.setPreview(preview);
		pro.setBatteryCapacity(batteryCapacity);
		pro.setCameraFeature(cameraFeature);
		pro.setProducer(producer);
		pro.setReleaseDate(releaseDate);
		pro.setRam(ram);
		pro.setStorage(storage);
		pro.setUpdateBy(updateBy);
		pro.setUpdateDate(timestamp);
		ProductDAO proDAO = new ProductDAO();

		if (proDAO.editItem(pro) > 0) {
			ProductImageDAO proImgDAO = new ProductImageDAO();
			List<Product> list = new ArrayList<Product>();

			List<ProductImage> proImgListDelete = new ArrayList<ProductImage>();
			proImgListDelete = proImgDAO.getByProductId(id);
			if(applyDeleteImage.equals("applyDeleteImage")) {
				
				for (ProductImage productImage : proImgListDelete) {
					FileUtil.delFile(productImage.getName(), request); // xoa file trong folder du an
					proImgDAO.dellItem(id); // xoa file name trong db
				}
			}
			// Check Upload images
			List<ProductImage> proImgList = new ArrayList<ProductImage>();
			try {

				List<Part> fileParts = request.getParts().stream()
						.filter(part -> Objects.equals(part.getName(), "file") && Objects.nonNull(part.getSize()))
						.collect(Collectors.toList());

				String realPath = request.getServletContext().getRealPath("");
				proImgList = FileUtil.uploadImage(fileParts, realPath); // tra ve danh sach file anh
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			if (proImgList.size() > 0) {
				
				for (ProductImage productImage : proImgListDelete) {
					FileUtil.delFile(productImage.getName(), request);
					proImgDAO.dellItem(id);
				}
				
				for (ProductImage productImage : proImgList) {
					productImage.setProduct(new Product(id));
					proImgDAO.addItem(productImage);
				}
			}

			response.sendRedirect(request.getContextPath() + "/admin/product/index?msg=2");
			return;
		} else {
			response.sendRedirect(request.getContextPath() + "/admin/product/index?err=2");
			return;
		}

	}

	public static void showCatAdd(HttpServletRequest request, JspWriter out, int parentId, String menu)
			throws ServletException, IOException {

		CatDAO catDAO = new CatDAO();
		List<Category> catListChild = catDAO.findCategoryParentById(parentId);
		if (catListChild.size() > 0) {

			for (Category category : catListChild) {
				out.print("<option value=" + category.getId() + ">" + menu + category.getName() + "</option>");
				showCatAdd(request, out, category.getId(), menu + "|----");
			}

		}
	}
}
