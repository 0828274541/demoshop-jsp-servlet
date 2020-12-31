<%@page import="models.ProductImage"%>
<%@page import="daos.CatDAO"%>
<%@page import="models.Product"%>
<%@page import="java.util.Date"%>
<%@page import="models.Category"%>

<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>

 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>General Form</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/admin/product/index">Home</a></li>
              <li class="breadcrumb-item active">(Về trang sản phẩm)</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <!-- left column -->
          <div class="col-md-12">
            <!-- general form elements -->
            <div class="card card-primary">
              <div class="card-header">
                <h2 class="card-title">Edit sản phẩm</h2>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <%
				CatDAO catDAO = new CatDAO();
               	int id = 0;
           		String name ="";	
           		int price = 0;	
           		int saleOff = 0;	
           		String preview ="";
           		String ram ="";
           		String storage ="";
           		String cameraFeature ="";
           		String batteryCapacity ="";
           		String producer ="";
           		Date releaseDate = null;
           		Category cat = new Category();
             	if(request.getAttribute("product")!=null){
             		Product pro = (Product)request.getAttribute("product");
             		id = pro.getId();
             		name = pro.getName();
             		price = pro.getPrice();
               		saleOff = pro.getSaleOff();
               		preview = pro.getPreview();
               		ram = pro.getRam();
               		storage = pro.getStorage();
               		cameraFeature = pro.getCameraFeature();
               		batteryCapacity = pro.getBatteryCapacity();
               		producer = pro.getProducer();
               		releaseDate = pro.getReleaseDate();
               		cat = pro.getGetCategory();
             	}
            
           %>    
              <form id="quickForm" action="<%=request.getContextPath()%>/admin/product/edit?id=<%=id%>" method="POST" enctype="multipart/form-data">
                <div class="card-body">
                  <div class="form-group">
                    <label>Tên sản phẩm(*)</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter category name" value="<%if(name !="") out.print(name);%>" >
                  </div>
                  <div class="form-group">
                  <label>Thuộc danh mục(*)</label>
                  <select class="form-control select2" style="width: 100%;" name="category_id" title="Please select something!" required>
                           <option select = 'selected' value="<%if(cat.getId() !=0) out.print(cat.getId());%>"><%if(cat.getId() !=0) out.print(cat.getName());%></option>
                            
                            <%
                           		ArrayList<Category> catList = new ArrayList();
                            	if(request.getAttribute("catList") != null){
                            		catList= (ArrayList<Category>) request.getAttribute("catList");
        							if(catList.size() > 0){
        								for(Category category : catList){
        									if(category.getId()!=cat.getId()){%>
                            
                            <option value="<%=category.getId()%>"><%=category.getName()%></option>
                            <% 
        									}
        								}
    								}
                        	}
                            %>
                      
                  </select>
                </div>
                   <div class="form-group">
                    <label>Giá(*)</label>
                    <input type="text" class="form-control" id="price" name="price" placeholder="Enter price" required value="<%if(price !=0) out.print(price);%>" >
                  </div>
                    <div class="form-group">
                    <label>Giá sale</label>
                    <input type="text" class="form-control" id="sale_off" name="sale_off" placeholder="Enter price_new" value="<%if(saleOff !=0) out.print(saleOff);%>">
                  </div>
                    <div class="form-group">
                    <label>Mô tả</label>
                    <input type="text" class="form-control" id="preview" name="preview" placeholder="Enter preview" value="<%if(preview !="") out.print(preview);%>">
                  </div>
                    <div class="form-group">
                    <label>Lưu trữ</label>
                    <input type="text" class="form-control" id="storage" name="storage" placeholder="Enter storage" value="<%if(storage !="") out.print(storage);%>">
                  </div>
                  
              	  <div class="form-group">
                    <label>Ram</label>
                    <input type="text" class="form-control" id="ram" name="ram" placeholder="Enter input" value="<%if(ram !="") out.print(ram);%>">
                  </div>
                    <div class="form-group">
                    <label>Tính năng Camera</label>
                    <input type="text" class="form-control" id="camera_feature" name="camera_feature" placeholder="Enter camera_feature" value="<%if(cameraFeature !="") out.print(cameraFeature);%>">
                  </div>
                    <div class="form-group">
                    <label>Dung lượng pin</label>
                    <input type="text" class="form-control" id="battery_capacity" name="battery_capacity" placeholder="Enter battery_capacity" value="<%if(batteryCapacity !="") out.print(batteryCapacity);%>">
                  </div>
                    
                    <div class="form-group">
                    <label>Nhà sản xuất(*):</label>
                    <input type="text" class="form-control" id="producer" name="producer" placeholder="Enter producer"  value="<%if(producer !="") out.print(producer);%>" required>
                  
                    </div>
                    
                  <div class="form-group">
                  <label>Ngày sản xuất(*):</label>
                  	<div class="input-container">
                    
                    <input type="date" class="form-control" id="release_date" name="release_date" placeholder="Enter release_date" value="<%if(releaseDate !=null) out.print(releaseDate);%>"required>
               		</div>
                </div>
                  <div class="form-group">
                    <label>Hinh ảnh(*)</label>
                  		<div style="display: none;">
                  				<input type="file" class="form-control" multiple name="file" id="file"  multiple />
                  		</div>
                  		<div  class="gallery">
                  			<%if(request.getAttribute("imageList")!=null){
                  				List<ProductImage> imageList= (ArrayList<ProductImage>)request.getAttribute("imageList"); %>
                                        <%if(imageList.size() > 0) {%>
                                        	
                                        	<%for(ProductImage proImg : imageList){%>
                                        		
	                                        		<img id="blahimage<%=id%>" width="150px" height="100px" 
		                                        		src="<%=request.getContextPath()%>/uploads/<%=proImg.getName()%>" alt=""/>
                                        		
	                                        
                                        
                     	<%}}}%>
                    	</div>
                     		<a href="#" id="changeImage" class="btn btn-primary">Thay ảnh</a> <a href="#" id="deleteImage" class="btn btn-secondary">Xóa ảnh</a>
                   </div>
                   <div style="display: none">
                   		<input type="text" id="applyDeleteImage" name="applyDeleteImage"  value="">
                   </div>
                </div>
                <!-- /.card-body -->

                <div class="card-footer">
                	
                  <button type="submit" class="btn btn-primary">Submit</button>
                  <a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/product/index">Cancel</a>
                </div>
              </form>
            </div>
            <!-- /.card -->
          </div>
          <!--/.col (right) -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
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


<%@ include file="/templates/admin/inc/footer.jsp" %>
<script>
    document.getElementById("category").classList.add('active');
    

		

	
</script>
<script>
$( document ).ready(function() {
	$( "#deleteImage" ).click(function() {
		 $( ".gallery" ).empty();
		 $( "#applyDeleteImage" ).val("applyDeleteImage");
		 
   });
	
	$( "#changeImage" ).click(function() {
		$( "#file" ).click();
   });
	 // Multiple images preview in browser
    var imagesPreview = function(input, placeToInsertImagePreview) {
    	
        if (input.files) {
            var filesAmount = input.files.length;
           
            for (i = 0; i < filesAmount; i++) {
                var reader = new FileReader();

                reader.onload = function(event) {
                	
                    $($.parseHTML('<img width="150px" height="100px"  >')).attr('src', event.target.result).appendTo(placeToInsertImagePreview);
                }

                reader.readAsDataURL(input.files[i]);
            }
        }

    };

    $("#file").on('change', function() {
    	 $( ".gallery" ).empty();
        imagesPreview(this, 'div.gallery');
    });
    
    
	 if($("#err").val()=='1'){
		alert("Ko thể thêm vào danh mục đang có danh mục con")
	 }
	 if($("#err").val()=='2'){
		 Swal.fire({
			  icon: 'error',
			  title: 'Error...',
			  text: 'Lỗi chưa xác định!',
			  footer: '<a href>Why do I have this issue?</a>'
			})
	 }
	
	 $('#quickForm').validate({
		    rules: {
				name: {
		        required: true,
				},
				
		    },
		    messages: {
		    	name: {
		        required: "Please provide a name",
				},
				
		    },
		    errorElement: 'span',
		    errorPlacement: function (error, element) {
		      error.addClass('invalid-feedback');
		      element.closest('.form-group').append(error);
		    },
		    highlight: function (element, errorClass, validClass) {
		      $(element).addClass('is-invalid');
		    },
		    unhighlight: function (element, errorClass, validClass) {
		      $(element).removeClass('is-invalid');
		    }
		  });

	  $( function() {
		    $( "#release_date" ).show();
		  } );

});
</script>
<style type="text/css">
.input-container input {
    
   
    outline: 0;
    padding: .75rem;
    position: relative;
    width: 100%;
}
    input[type="date"]::-webkit-calendar-picker-indicator {
        background: transparent;
        bottom: 0;
        color: transparent;
        cursor: pointer;
        height: auto;
        left: 0;
        position: absolute;
        right: 0;
        top: 0;
        width: auto;
    }
</style>
  