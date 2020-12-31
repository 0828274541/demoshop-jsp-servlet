<%@page import="models.Product"%>
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
            <h1>User</h1>
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
              <%User userInfor = new User();
              if(session.getAttribute("userInfor")!=null){
            	  userInfor = (User)session.getAttribute("userInfor");
            	  if(userInfor.getRole().getName().equals("ADMIN")){
              
              %>
              
                <h3 class="card-title"><a class="btn btn-block btn-success" href="<%=request.getContextPath()%>/admin/product/add">Thêm tài khoản</a></h3>    
             <%}} %>         
              </div>
              <!-- /.card-header -->
              <div class="card-body">
              	<div class="col-sm-6">
           			 <h3 style="color:blue">Tài khoản của bạn</h3>
          		</div>
                <table id="example1" class="table table-bordered table-striped">
                  <thead>
                  <tr>
                  	<th>Id</th>
                    <th>Username</th>
                    <th>Fullname</th> 
                    <th>Address</th> 
                    <th>Telephone_number</th>
                    <th>Role</th>
                    <th>Action</th>             
                  </tr>
                  </thead>
                  <tbody>
          <%	
				if(userInfor.getId()!=0){
						
		  %>                      
                     <tr class="tr" id="<%=userInfor.getId()%>">
                     <td><%=userInfor.getId()%></td>
                     <td><%=userInfor.getUsername()%></td>
                     <td><%=userInfor.getFullname()%></td>
                     <td><%=userInfor.getAddress()%></td>
                     <td><%=userInfor.getTelephoneNumber()%></td>
                     <td><%=userInfor.getRole().getName()%></td>
                     <td>
                     <button type="button"  class="btn btn-block btn-success" data-toggle="modal" data-target="#modal-default<%=userInfor.getId()%>">Edit</button>
                     <!-- The Modal -->
				      <div class="modal fade" id="modal-default<%=userInfor.getId()%>">
				        <div class="modal-dialog">
				          <div class="modal-content">
				            <div class="modal-header">
				              <h4 class="modal-title">Sửa thông tin</h4>
				              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                <span aria-hidden="true">&times;</span>
				              </button>
				            </div>
				            <div class="modal-body">
								  <div class="card card-primary">
						              <div class="card-header">
						                <h2 class="card-title">Sửa thông tin</h2>
						              </div>
						              <!-- /.card-header -->
						              <!-- form start -->
						              <form id="editForm" action="<%=request.getContextPath()%>/admin/user/edit" method="POST">
						                <div class="card-body">
						                  <div class="form-group">
						                    <label>Fullname</label>
						                    <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Enter fullname" value="<%if(userInfor.getFullname()==null){out.print("");}else{out.print(userInfor.getFullname());}%>">
						                  </div>
						                   <div class="form-group">
						                    <label>Address</label>
						                    <input type="text" class="form-control" id="address" name="address" placeholder="Enter address" value="<%if(userInfor.getAddress()==null){out.print("");}else{out.print(userInfor.getAddress());}%>">
						                  </div>
						                   <div class="form-group">
						                    <label>Telephone_number</label>
						                    <input type="text" class="form-control" id="telephoneNumber" name="telephoneNumber" placeholder="Enter telephoneNumber" value="<%if(userInfor.getTelephoneNumber()==0){out.print("");}else{out.print(userInfor.getTelephoneNumber());}%>">
						                  </div>
						                 	<input type="hidden"  id="id" name="id" value="<%=userInfor.getId()%>">
						                </div>
						                <!-- /.card-body -->
						
						                <div class="card-footer">
						                	
						                  <button type="submit" class="btn btn-primary">Save changes</button>
						                  
						                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						                </div>
						              </form>
						            </div>
						            <!-- /.card -->
				            </div>
				          </div>
				          <!-- /.modal-content -->
				        </div>
				        <!-- /.modal-dialog -->
				      </div>
				      <!-- /.modal -->
                     </td>
                     </tr>  
          	<%}%> 
                  </tbody>
                
                </table>
              </div>
              <!-- /.card-body -->
           	  <div style="display: none;" id="result" ></div> 
            </div>
            <!-- /.card -->
            <%	List<User> userList = new ArrayList();
            	if(request.getAttribute("userList")!=null){
            		userList = (ArrayList)request.getAttribute("userList");
            	}
            	if(userList.size()>0){%>	
            <div class="card">
              <div class="card-body">
              	<div class="col-sm-6">
           			 <h3>Quan Ly Tai Khoan</h3>
          		</div>
                <table id="example1" class="table table-bordered table-striped">
                  <thead>
                  <tr>
                  	<th>Id</th>
                    <th>Username</th>
                    <th>Fullname</th> 
                    <th>Address</th> 
                    <th>Telephone_number</th>
                    <th>Role</th>
                    <th>Action</th>             
                  </tr>
                  </thead>
                  <tbody>
          <%	for(User user : userList){
		  %>                      
                     <tr class="tr" id="<%=userInfor.getId()%>">
                     <td><%=user.getId()%></td>
                     <td><%=user.getUsername()%></td>
                     <td><%if(user.getFullname()==null){out.print("Chưa cập nhật");}else{out.print(user.getFullname());}%></td>
                     <td><%if(user.getAddress()==null){out.print("Chưa cập nhật");}else{out.print(user.getAddress());}%></td>
                     <td><%if(user.getTelephoneNumber()==0){out.print("Chưa cập nhật");}else{out.print(user.getTelephoneNumber());}%></td>
                     <td><%=user.getRole().getName()%></td>
                                          <td>
                     <button type="button"  class="btn btn-block btn-success" data-toggle="modal" data-target="#modal-default<%=user.getId()%>">Edit</button>
                     <!-- The Modal -->
				      <div class="modal fade" id="modal-default<%=user.getId()%>">
				        <div class="modal-dialog">
				          <div class="modal-content">
				            <div class="modal-header">
				              <h4 class="modal-title">Sửa thông tin</h4>
				              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                <span aria-hidden="true">&times;</span>
				              </button>
				            </div>
				            <div class="modal-body">
								 <div class="card card-primary">
						              <div class="card-header">
						                <h2 class="card-title">Sửa thông tin</h2>
						              </div>
						              <!-- /.card-header -->
						              <!-- form start -->
						              <form id="editForm" action="<%=request.getContextPath()%>/admin/user/edit" method="POST">
						                <div class="card-body">
						                  <div class="form-group">
						                    <label>Fullname</label>
						                    <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Enter fullname" value="<%if(user.getFullname()==null){out.print("");}else{out.print(user.getFullname());}%>">
						                  </div>
						                   <div class="form-group">
						                    <label>Address</label>
						                    <input type="text" class="form-control" id="address" name="address" placeholder="Enter address" value="<%if(user.getAddress()==null){out.print("");}else{out.print(user.getAddress());}%>">
						                  </div>
						                   <div class="form-group">
						                    <label>Telephone_number</label>
						                    <input type="text" class="form-control" id="telephoneNumber" name="telephoneNumber" placeholder="Enter telephoneNumber" value="<%if(user.getTelephoneNumber()==0){out.print("");}else{out.print(user.getTelephoneNumber());}%>">
						                  </div>
						                 	<input type="hidden"  id="id" name="id" value="<%=user.getId()%>">
						                </div>
						                <!-- /.card-body -->
						
						                <div class="card-footer">
						                	
						                  <button type="submit" class="btn btn-primary">Save changes</button>
						                  
						                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						                </div>
						              </form>
						            </div>
						            <!-- /.card -->
				            </div>
				          </div>
				          <!-- /.modal-content -->
				        </div>
				        <!-- /.modal-dialog -->
				      </div>
				      <!-- /.modal -->
                     </td>
                     </tr>  
          	<%}%> 
                  </tbody>
                
                </table>
              </div>
              <!-- /.card-body -->
             </div>
             <!-- /.card -->
             <%} %>
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
<%if(session.getAttribute("err")!=null){
	String err = (String)session.getAttribute("err");
	session.removeAttribute("err");
%>
	<input type="hidden" id="err" value="<%=err%>">
<%} %>
<%if(session.getAttribute("msg")!=null){
	String msg = (String)session.getAttribute("msg");
	session.removeAttribute("msg");
%>
	<input type="hidden" id="msg" value="<%=msg%>">
<%} %>  
  <%@ include file="/templates/admin/inc/footer.jsp" %>

<script>
  $(document).ready(function() {  
	  if($("#msg").val()!=null){
			alert($("#msg").val());
		 }
	  if($("#err").val()!=null){
			alert($("#msg").val());
		 }
	  
	 if($('#numberOfPages').val() == 1){
			 $('#li1').hide();
			 $('#li2').hide();
			 $('#li4').hide();
			 $('#li5').hide();
			
		 }else if($('#currentPage').val() == 1){
			 $('#li1').hide();
			 $('#li2').hide();
			
		 }else if($('#currentPage').val() == $('#numberOfPages').val()){
			 $('#li4').hide();
			 $('#li5').hide();
			
		 }
		 
	 document.getElementById("user").classList.add('active');
	 
	 $('#editForm').validate({
		    rules: {
		      fullname: {
		        required: true,
		        
		      },
		      address: {
		        required: true,
		       
		      },
		      telephoneNumber: {
		    	  required : true,
		    	  number : true,
			      },
		     
		    },
		    messages: {
		    	fullname: {
		        required: "Please enter a fullname",
		       
		      },
		      address: {
		        required: "Please provide a required",
		       
		      },
		      telephoneNumber: {
		    	  required: "Please provide a required",
			      number: "Please provide a number",
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
