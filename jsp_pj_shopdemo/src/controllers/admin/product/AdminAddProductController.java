package controllers.admin.product;

import java.io.IOException;
import java.sql.Date;
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
public class AdminAddProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CatDAO catDAO;

	public AdminAddProductController() {
		super();
		catDAO = new CatDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfor")==null) {
			response.sendRedirect(request.getContextPath()+"/login");
			return;
		}
		List<Category> catList = new ArrayList<Category>();
		catList = catDAO.findAll();
		RequestDispatcher rd = request.getRequestDispatcher("/view/admin/product/add.jsp");
		request.setAttribute("catList", catList);
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

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
		int createBy = 0;
		
		HttpSession session = request.getSession();
		User user= (User)session.getAttribute("userInfor");
		createBy = user.getId();
		
		if(request.getParameter("name")!=null) {
			name = request.getParameter("name");
		}
		if(request.getParameter("category_id")!=null) {
			categoryId = Integer.parseInt(request.getParameter("category_id"));
		}
		if(request.getParameter("price")!=null) {
			price = Integer.parseInt(request.getParameter("price"));
		}
		if(request.getParameter("sale_off")!=null) {
			try {
			saleOff = Integer.parseInt(request.getParameter("sale_off"));
			}catch(Exception e) {
				saleOff = 0;
			}
		}
		if(request.getParameter("preview")!=null) {
			preview = request.getParameter("preview");
		}
		if(request.getParameter("storage")!=null) {
			storage = request.getParameter("storage");
		}
		if(request.getParameter("ram")!=null) {
			ram = request.getParameter("ram");
		}
		if(request.getParameter("camera_feature")!=null) {
			cameraFeature = request.getParameter("camera_feature");
		}
		if(request.getParameter("battery_capacity")!=null) {
			batteryCapacity = request.getParameter("battery_capacity");
		}
		if(request.getParameter("producer")!=null) {
			producer = request.getParameter("producer");
		}

		if (request.getParameter("release_date") != null) {
			String startDateStr = request.getParameter("release_date");
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			try {
			
				java.sql.Date sql = new java.sql.Date(formatter.parse(startDateStr).getTime());
				releaseDate = sql;
				//System.out.println(formatter.format(sql));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		

		Product pro = new Product();
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
		pro.setCreateBy(createBy);
		
		
		ProductDAO proDAO = new ProductDAO();
		if(proDAO.checkCatProduct(pro)) {
		
			response.sendRedirect(request.getContextPath()+"/admin/product/index?err=1");
			return;
		}
		if(proDAO.addItem(pro)>0) {
			ProductImageDAO proImgDAO = new ProductImageDAO();
			List<Product> list = new ArrayList<Product>();
			list = proDAO.findAll();
			int maxId = 0;
			if (list.size() > 0) {
				for (Product product : list) {
					if (product.getId() > maxId) {
						maxId = product.getId();

					}
				}
			}
			// Upload images
			List<ProductImage> proImgList = new ArrayList<ProductImage>();
			try {
				// Cái này là kiểu viết mới thôi chứ ko có gì hết
				// code bình thương là new ra cái list rồi loop trong vòng for 
				// nếu cái nào có tên là file và size ko rỗng thì add vào thôi
				List<Part> fileParts = request.getParts().stream()
						.filter(part -> Objects.equals(part.getName(), "file") && Objects.nonNull(part.getSize()))
						.collect(Collectors.toList());

				String realPath = request.getServletContext().getRealPath("");
				proImgList = FileUtil.uploadImage(fileParts, realPath);	
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			if(proImgList.size()>0) {
				
				for (ProductImage productImage : proImgList) {
					productImage.setProduct(new Product(maxId));
					proImgDAO.addItem(productImage);
				}
			}
			
			response.sendRedirect(request.getContextPath()+"/admin/product/index?msg=1");
			return;
		}else {
			response.sendRedirect(request.getContextPath()+"/admin/product/index?err=2");
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
