<%@page import="controllers.admin.cat.AdminIndexCatController"%>
<%@page import="daos.CatDAO"%>
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
            <h1>Category</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">DataTables</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
		    <div class="card">
              <div class="card-header">
                 <h3 class="card-title"><a class="btn btn-block btn-success" href="<%=request.getContextPath()%>/admin/cat/add">Thêm danh muc</a></h3>    
              </div>
              
              <!-- /.card-header -->
              <div class="card-body">
                <table id="example1" class="table table-bordered table-striped">
                  <thead>
                  <tr>
                  	<th>Id</th>
                    <th>Tên sản phẩm</th>        
                    <th>Chức năng</th> 
                  </tr>
                  </thead>
                  <tbody>
             	
                  <%
          				
                  		
                  		if(request.getAttribute("catList")!=null){
         				ArrayList<Category> parents = (ArrayList<Category>)request.getAttribute("catList");
                        if(parents.size() > 0){
                        	for(Category category : parents){
                        		if(category.getParent_id()==0){%>
                     <tr><td><%= category.getId()%></td><td><%= category.getName()%></td><td><a href="<%=request.getContextPath()%>/admin/cat/edit?id=<%= category.getId()%>" class='btn btn-primary'><i class='fa fa-edit'></i>Sửa</a><a href="#" id="<%= category.getId()%>" class='btn btn-secondary xoa'><i class='fa fa-edit'></i>Xóa</a></td></tr>
                        			
                   <%   AdminIndexCatController.showCat(request, out, category.getId(), "|----");
                   }
                        	}
                        }
                  		}
                   %>
			
			</tbody>
                
                </table>
              </div>
              <!-- /.card-body -->
             
              <div class="card-footer clearfix">
              
              </div>
            
           	  <div style="display: none;" id="result" ></div> 
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
     
  <%@ include file="/templates/admin/inc/footer.jsp" %>


  
 <script>
  $(document).ready(function() {  
		 
	 document.getElementById("category").classList.add('active');
	 

	 
	 
	 
   	 $('.xoa').click(function(table) {
		 	var id = $(this).attr("id");
		 	var row = $(this).closest('tr');
		 	
	Swal.fire({
	  title: 'Are you sure?',
	  text: "You won't be able to revert this!",
	  icon: 'warning',
	  showCancelButton: true,
	  confirmButtonColor: '#3085d6',
	  cancelButtonColor: '#d33',
	  confirmButtonText: 'Yes, delete it!'
	}).then((result) => {
	  if (result.isConfirmed) {
		$.ajax({
			url: '<%=request.getContextPath()%>/admin/cat/delete',
				
							type : 'GET',
							cache : false,
							data : {
								id: id,
								
							},
							
							success : function(responseText) {
								$('#result').text(responseText);
								
								myDivObj = document.getElementById("result");
								if(myDivObj.textContent=='true'){
									Swal.fire({
										  icon: 'error',
										  title: 'Error...',
										  text: 'Ko thể xóa vì đang có danh mục con',
										  footer: '<a href>Why do I have this issue?</a>'
										})
								}
								if(myDivObj.textContent=='false'){
									Swal.fire(
											  'Success!',
											  'Delete category!',
											  'success'
											)
										row.remove();
								}
							},
							error : function() {
								alert('Có lỗi xảy ra');
							}
						});
	   
	  }
	})
	
	 });
});
  </script>  
