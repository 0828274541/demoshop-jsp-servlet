<%@page import="models.Category"%>
<%@page import="models.User"%>
<%@page import="controllers.admin.cat.AdminAddCatController"%>
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
              <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/admin/cat/index">Home</a></li>
              <li class="breadcrumb-item active">(Về trang danh mục)</li>
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
                <h2 class="card-title">Thêm danh mục</h2>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form id="quickForm" action="<%=request.getContextPath()%>/admin/cat/add" method="POST">
                <div class="card-body">
                  <div class="form-group">
                    <label>Tên danh mục</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter category name">
                  </div>
                  <div class="form-group">
                  <label>Thuộc danh mục</label>
                  <select class="form-control select2" style="width: 100%;" name="parent_id" title="Please select something!" required>
                           <option value=""></option>
                            <option value="0">Danh mục gốc</option>
                            <%
                           		ArrayList<Category> catList = new ArrayList();
                            	if(request.getAttribute("catList") != null){
                            		catList= (ArrayList<Category>) request.getAttribute("catList");
        							if(catList.size() > 0){
        								for(Category category : catList){
        									if(category.getParent_id()==0){%>
                            
                            <option value="<%=category.getId()%>"><%=category.getName()%></option>
                            <% AdminAddCatController.showCatAdd(request,out, category.getId(), "|----");
        									}
        								}
    								}
                        	}
                            %>
                      
                  </select>
                </div>
                 
                </div>
                <!-- /.card-body -->

                <div class="card-footer">
                	
                  <button type="submit" class="btn btn-primary">Submit</button>
                  <a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/cat/index">Cancel</a>
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
	 if($("#msg").val()=='1'){
		 Swal.fire(
				  'Success!',
				  'Add category!',
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
});
</script>
  