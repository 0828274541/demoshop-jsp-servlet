<%@page import="daos.ProductImageDAO"%>
<%@page import="models.ProductImage"%>
<%@page import="models.Product"%>
<%@page import="daos.CatDAO"%>
<%@page import="models.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/templates/admin/inc/header.jsp"%>
<%@ include file="/templates/admin/inc/leftbar.jsp"%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1>Product</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="#">Home</a></li>
						<li class="breadcrumb-item active">DataTables</li>
					</ol>
				</div>
			</div>
		</div>
		<!-- /.container-fluid -->
	</section>

	<!-- Main content -->
	<section class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-header">

							<h3 class="card-title">
								<a class="btn btn-block btn-success"
									href="<%=request.getContextPath()%>/admin/product/add">Thêm
									san pham</a>
							</h3>

							<%
                  int searchId = 0;
                  String searchResult ="";
                  if(request.getAttribute("searchId")!=null){
                  	searchId = (Integer)request.getAttribute("searchId");
                  }
                  if(request.getAttribute("searchResult")!=null){
                  	searchResult = (String)request.getAttribute("searchResult");
                 } %>
							<form class="form-group" style='float: right;' method="get"
								action="<%=request.getContextPath()%>/admin/product/index">
								<select name="searchId"
									class="custom-select form-control-border"
									style='width: 180px; margin-right: 10px; float: left;'>
									<option value="0">--Show All--</option>
						<%-- 			<% List<Category> listCatSearch = new ArrayList();
                                       		if(request.getAttribute("listCatSearch")!=null){
                                       			listCatSearch= (ArrayList<Category>)request.getAttribute("listCatSearch");
                                       		
                                        		if(listCatSearch.size()>0){
                                        			for(Category objCat : listCatSearch){
                                        				
                                        %>
									<option
										<%if(searchId == objCat.getId()) out.print("selected = 'selected'");%>
										value="<%=objCat.getId() %>"><%=objCat.getName() %></option>
									<%		}
                                        	}
                                       	}%>       --%>
								</select>
								<div class="input-group" style='width: 300px; float: right;'>
									<input class="form-control form-control-border" type="search"
										name="searchResult"
										value="<%if(request.getParameter("searchResult")!=null) out.print(request.getParameter("searchResult")); %>"
										placeholder="Search" aria-label="Search">
									<div class="input-group-append">
										<button class="btn btn-navbar" style='color: #605ca8;'
											type="submit">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
							</form>

						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<table id="example1" class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>Id</th>
										<th>Tên sản phẩm</th>
										<th>Giá</th>
										<th>Sale Off</th>
										<th>Mô tả</th>
										<th>Lưu trữ</th>
										<th>RAM</th>
										<th>Tính năng Camera</th>
										<th>Dung lượng pin</th>
										<th>Lượt xem</th>
										<th>Nhà sản xuất</th>
										<th>Ngày sản xuất</th>
										<th>Hinh anh</th>
										<th>Chức năng</th>
									</tr>
								</thead>
								<tbody>
									<%	
      			ArrayList<Product> listProduct = new ArrayList<Product>();
				if(request.getAttribute("listProduct")!=null){
					listProduct = (ArrayList<Product>)request.getAttribute("listProduct");
					
				if(listProduct.size()>0){
					for(Product pro: listProduct){
						String delete = request.getContextPath()+"/admin/product/delete?id="+pro.getId();	
						String edit = request.getContextPath()+"/admin/product/edit?id="+pro.getId();		
		  %>
									<tr class="tr" id="<%=pro.getId()%>">
										<td><%=pro.getId()%></td>
										<td><%=pro.getName()%></td>
										<td><%=pro.getPrice()%></td>
										<td><%=pro.getSaleOff()%></td>
										<td><%=pro.getPreview()%></td>
										<td><%=pro.getStorage()%></td>
										<td><%=pro.getRam()%></td>
										<td><%=pro.getCameraFeature()%></td>
										<td><%=pro.getBatteryCapacity()%></td>
										<td><%=pro.getCount()%></td>
										<td><%=pro.getProducer()%></td>
										<td><%=pro.getReleaseDate()%></td>
										
										<td>
											<button type="button" class="btn btn-block btn-success"
												data-toggle="modal"
												data-target="#modal-default<%=pro.getId()%>">Xem</button> <!-- The Modal -->
											<div class="modal fade" id="modal-default<%=pro.getId()%>">
												<div class="modal-dialog">
													<div class="modal-content">
														<div class="modal-header">
															<h4 class="modal-title">Hinh anh</h4>
															<button type="button" class="close" data-dismiss="modal"
																aria-label="Close">
																<span aria-hidden="true">&times;</span>
															</button>
														</div>
														<div class="modal-body">
															<div class="card card-primary">
																<div class="card-header">
																	<h2 class="card-title">Hinh anh</h2>
																</div>
																<!-- /.card-header -->
																<div class="card-body">
																<table id="example2" class="table table-bordered table-striped">
																	<thead>
																		<tr>
																			<th>Tên ảnh</th>
																			<th>Hình ảnh</th>
																			
																		</tr>
																		</thead>
																		<tbody>
																<%
												                ProductImageDAO proImgDAO = new ProductImageDAO();
												                List<ProductImage> imageList = new ArrayList();
												                imageList = proImgDAO.getByProductId(pro.getId());
												                if(imageList.size()>0){
												                	for(ProductImage proImg : imageList){%>
												                		<tr>
												                			<td><%=proImg.getName() %></td>
												                			<td><img id="blahimage<%=proImg.getId()%>" height="100px" src="<%=request.getContextPath()%>/uploads/<%=proImg.getName() %>" /></td>
												                			<%-- <td><a href="#" id="image<%=proImg.getId()%>" onclick="changeImage(this)" class="btn btn-primary">Thay đổi</a> <a href="#" class="btn btn-success">Xóa</a></td>
												                			 --%>
												                		</tr>
																<%}} %>
																		</tbody>
																</table>
																	<div class="card-footer">
																		<button type="button" class="btn btn-default"
																			data-dismiss="modal">Close</button>
																	</div>	
															</div>
															<!-- /.card -->
														</div>
													</div>
													<!-- /.modal-content -->
												</div>
												<!-- /.modal-dialog -->
											</div> <!-- /.modal -->
										</td>
										<td>
                         					<a href="<%=edit %>" title="" class="btn btn-primary">Sửa</a> 
                              				
                   						  </td> 
									</tr>
									<%}}}%>
								</tbody>

							</table>
						</div>
						<!-- /.card-body -->
						<%
           	   	int numberOfPages = 0;
  				int currentPage = 0;
  				int numberOfItems = 0;
              	if(request.getAttribute("numberOfPages") !=null && request.getAttribute("currentPage")!=null && request.getAttribute("numberOfItems")!=null){
						 numberOfPages = (Integer)request.getAttribute("numberOfPages");
    			 		currentPage = (Integer)request.getAttribute("currentPage");
    					 numberOfItems = (Integer)request.getAttribute("numberOfItems");
    			String urlPage="";
   				urlPage = request.getContextPath()+"/admin/product/index?page=";
  				
   			  %>
						<div class="card-footer clearfix">
							<ul class="pagination pagination-sm m-0 float-left">
								<li id="li" class="page-item "><p>
										Trang
										<%=currentPage%>
										của
										<%=numberOfPages%>(Có
										<%=numberOfItems%>
										kết quả)
									</p></li>
							</ul>
							<ul class="pagination pagination-sm m-0 float-right">
								<li id="li1" class="page-item"><a class="page-link"
									href="<%=urlPage%><%=currentPage-1%>&searchId=<%=searchId%>&searchResult=<%=searchResult%>">&laquo;</a></li>
								<li id="li2" class="page-item"><a class="page-link"
									href="<%=urlPage%><%=currentPage-1%>&searchId=<%=searchId%>&searchResult=<%=searchResult%>"><%=currentPage-1%></a></li>
								<li id="li3" class="page-item active"><p class="page-link"><%=currentPage%></p></li>
								<li id="li4" class="page-item"><a class="page-link"
									href="<%=urlPage%><%=currentPage+1%>&searchId=<%=searchId%>&searchResult=<%=searchResult%>"><%=currentPage+1%></a></li>
								<li id="li5" class="page-item"><a class="page-link"
									href="<%=urlPage%><%=currentPage+1%>&searchId=<%=searchId%>&searchResult=<%=searchResult%>">&raquo;</a></li>
							</ul>
						</div>
						<%}%>
						<input type="hidden" id="numberOfPages" value="<%=numberOfPages%>">
						<input type="hidden" id="currentPage" value="<%=currentPage%>">
						<input type="hidden" id="numberOfItems" value="<%=numberOfItems%>">
						<div style="display: none;" id="result"></div>
					</div>
					<!-- /.card -->
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<%if(request.getParameter("err")!=null){
	String err = request.getParameter("err");%>
<input type="hidden" id="err" value="<%=err%>">
<%} %>
<%if(request.getParameter("msg")!=null){
	String msg = request.getParameter("msg");%>
<input type="hidden" id="msg" value="<%=msg%>">
<%} %>
<%@ include file="/templates/admin/inc/footer.jsp"%>

<script>

	

	
	
	function changeImage(obj){
		
		$("#flupld"+obj.id).click();
		
		$("#flupld"+obj.id).change(function() {	
			
			  readURL(this);
			});
		
		function readURL(input) {
			  if (input.files && input.files[0]) {
			    var reader = new FileReader();
			    
			    reader.onload = function(e) {
			      $('#blah'+obj.id).attr('src', e.target.result);
			    }
			    
			    reader.readAsDataURL(input.files[0]); // convert to base64 string
				return;
			  }
			  alert("dsadas");
			}
			
	}
	
	
	
	
	$(document).ready(function() {
		if ($("#msg").val() == '1') {
			alert("Thêm thành công!!")
		}
		if ($("#msg").val() == '2') {
			alert("Cập nhật thành công!!")
		}
		if ($("#err").val() == '1') {
			alert("Ko thể thêm vào danh mục đang có danh mục con!!")
		}
		if ($("#err").val() == '2') {
			Swal.fire({
				icon : 'error',
				title : 'Error...',
				text : 'Lỗi chưa xác định!',
				footer : '<a href>Why do I have this issue?</a>'
			})
		}
		if ($('#numberOfPages').val() == 1) {
			$('#li1').hide();
			$('#li2').hide();
			$('#li4').hide();
			$('#li5').hide();

		} else if ($('#currentPage').val() == 1) {
			$('#li1').hide();
			$('#li2').hide();

		} else if ($('#currentPage').val() == $('#numberOfPages').val()) {
			$('#li4').hide();
			$('#li5').hide();

		}

		document.getElementById("product").classList.add('active');

	});
</script>
