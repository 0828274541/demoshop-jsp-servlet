package utils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;

import constances.GlobalConstant;
import models.ProductImage;

public class FileUtil {

	public static String rename(String fileName) {
		String nameFile = "";
		if (!fileName.isEmpty()) {
			String[] arrImg = fileName.split("\\.");
			String duoiFileImg = arrImg[arrImg.length - 1];
			
			for (int i = 0; i < (arrImg.length - 1); i++) {
				if (i == 0) {
					nameFile = arrImg[i];
				} else {
					nameFile += "-" + arrImg[i];
				}
			}
			nameFile = nameFile + "-" + System.nanoTime() + "." + duoiFileImg;
		}
		return nameFile;
	}

	public static String getName(final Part part) {
		for (String content : part.getHeader("content-disposition").split(";")) {
			if (content.trim().startsWith("filename")) {
				return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
			}
		}
		return null;
	}

	public static String upload(String nameInput,HttpServletRequest request	)throws ServletException,IOException{
		Part part = request.getPart(nameInput);
		String fileName =rename(part.getSubmittedFileName()) ;//ten file
		if(!"".equals(fileName)) {
		String dirPath = request.getServletContext().getRealPath("") + GlobalConstant.DIR_UPLOAD;
		File saveDir = new File(dirPath);//java.io
		if(!saveDir.exists()) {
			saveDir.mkdirs();
		}
		String filePath = dirPath + File.separator + fileName;
		part.write(filePath);
		}
		return fileName;
	}
	

	public static List<ProductImage> uploadImage(List<Part> fileItems, String realPath) {
		List<ProductImage> productImages = new ArrayList<ProductImage>();
		if (CollectionUtils.isNotEmpty(fileItems) && StringUtils.isNotBlank(realPath)) {
			// xử lý upload file khi người dùng nhấn nút thực hiện
			try {
				for (Part part : fileItems) {
						// xử lý file
						ProductImage proImg = new ProductImage();
						proImg.setName(rename(Paths.get(part.getSubmittedFileName()).getFileName().toString()));

						if (!proImg.getName().equals("")) {
							String dirUrl = realPath + GlobalConstant.DIR_UPLOAD;
							File dir = new File(dirUrl);
							if (!dir.exists()) {
								dir.mkdir();
							}
							String fileImg = dirUrl + File.separator + proImg.getName();

							part.write(fileImg);
							productImages.add(proImg);
							System.out.println("UPLOAD THÀNH CÔNG...!");
							System.out.println("ĐƯỜNG DẪN KIỂM TRA UPLOAD HÌNH ẢNH : \n" + dirUrl);
						}

				}
			} catch (Exception e) {
				System.out.println("CÓ LỖ TRONG QUÁ TRÌNH UPLOAD!");
				e.printStackTrace();
			}
			
		}
		return productImages;
	}

	public static void delFile (String filename, HttpServletRequest request) {
		
			
			String filePart = request.getServletContext().getRealPath("") + GlobalConstant.DIR_UPLOAD + File.separator + filename;
			
			File file = new File(filePart);
			
			file.delete();
	
		
		
	}

	
}
