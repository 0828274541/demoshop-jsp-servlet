<%@page import="java.util.ArrayList"%>
<%@page import="models.Category"%>
<%@page import="controllers.admin.cat.AdminEditCatController"%>
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
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">General Form</li>
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
                <h2 class="card-title">Category Edit</h2>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
               <%
               	int catId = 0;
           		String name ="";			
           		int parentId = 0;
             	if(request.getAttribute("category")!=null){
             		Category cat = (Category)request.getAttribute("category");
             		catId = cat.getId();
             		name = cat.getName();
             		parentId= cat.getParent_id();
             	}
            
           %>
           
           
              <form id="quickForm" action="<%=request.getContextPath()%>/admin/cat/edit?id=<%=catId%>" method="POST">
                <div class="card-body">
                  <div class="form-group">
                    <label>Tên danh mục</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter category name" value="<%if(name !="") out.print(name);%>">
                  </div>
                  <div class="form-group">
                  <label>Thuộc danh mục</label>
                  <select class="form-control select2" style="width: 100%;" name="parent_id" title="Please select something!" >
                          <%	ArrayList<Category> catList = new ArrayList();
                            	if(request.getAttribute("catList") != null){
                            		String selected = null;
                            		catList= (ArrayList<Category>) request.getAttribute("catList");
                            		
        							if(catList.size() > 0){
        								
        								for(Category category : catList){
        										
        										if(category.getParent_id()==0){%>		
        									<option  value="<%=category.getId()%>"><%=category.getName()%></option>
                          
                          <%					 AdminEditCatController.showCatAdd(request,out, category.getId(), "|----");
                								}
        										
        								}%>
        				 <% 		}
                            		} %>
                  </select>
                </div>
                </div>
                <!-- /.card-body -->

                <div class="card-footer">
                  <button type="submit" class="btn btn-primary">Submit</button>
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
 <input type="hidden" id="check1" value="<%=parentId%>">
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
	var valueSelected = $('#check1').val();	
	$('.select2').val(valueSelected).change();
	
	 if($("#msg").val()=='1'){
		 Swal.fire(
				  'Success!',
				  'Edit category!',
				  'success'
				).then(function() {
				    window.location = "<%=request.getContextPath()%>/admin/cat/index";
				});
	 }
	 if($("#err").val()=='1'){
		 Swal.fire({
			  icon: 'error',
			  title: 'Error...',
			  text: 'Tên danh mục đã tồn tại',
			  footer: '<a href>Why do I have this issue?</a>'
			})
	 }
	 if($("#err").val()=='4'){
		 Swal.fire({
			  icon: 'error',
			  title: 'Error...',
			  text: 'Tên danh mục bị rỗng',
			  footer: '<a href>Why do I have this issue?</a>'
			})
	 }
	 if($("#err").val()=='5'){
		 Swal.fire({
			  icon: 'error',
			  title: 'Error...',
			  text: 'Một danh mục ko thể thuộc chính nó',
			  footer: '<a href>Why do I have this issue?</a>'
			})
	 }
	 if($("#err").val()=='3'){
		 Swal.fire({
			  icon: 'error',
			  title: 'Error...',
			  text: 'Lỗi chưa xác định!',
			  footer: '<a href>Why do I have this issue?</a>'
			}).then(function() {
			    window.location = "<%=request.getContextPath()%>/admin/cat/index";
			});
	 }
	 if($("#err").val()=='2'){
		 Swal.fire({
			  icon: 'error',
			  title: 'Error...',
			  text: 'Lỗi ko tìm thấy or ID ko tồn tại!',
			  footer: '<a href>Why do I have this issue?</a>'
			}).then(function() {
			    window.location = "<%=request.getContextPath()%>/admin/cat/index";
			});
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
});
</script>
  