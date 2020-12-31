<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Đăng ký tài khoản | Registration Page (v2)</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/templates/admin/assets/plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/templates/admin/assets/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/templates/admin/assets/dist/css/adminlte.min.css">
  <!-- SweetAlert 2 -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/templates/admin/assets/plugins/sweetalert2/sweetalert2.min.css">
</head>
<body class="hold-transition register-page">
<div class="register-box">
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <a href="<%=request.getContextPath()%>/login" class="h1"><b>Admin</b>LTE</a>
    </div>
    <div class="card-body">
      <p class="login-box-msg">Register a new membership</p>

      <form  id="quickForm" action="<%=request.getContextPath()%>/register" method="post">
        <div class="form-group">
          <input type="text" class="form-control" id="username" name="username" placeholder="Username">
       
        </div>
        <div class="form-group">
          <input type="password" class="form-control" id="password" name="password" placeholder="Password">
         
        </div>
        <div class="form-group">
          <input type="password" class="form-control" id="repassword" name="repassword" placeholder="Retype password">
       
        </div>
        <div class="row">
          <div class="form-group mb-0">
            <div class="icheck-primary">
              <input type="checkbox" id="agreeTerms" name="terms" value="agree">
              <label for="agreeTerms">
               Tôi đồng ý với các điều <a href="#">điều khoảng</a>
              </label>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block">Đăng ký</button>
          </div>
          <!-- /.col -->
        </div>
      </form>

      <div class="social-auth-links text-center">
  
      </div>
      <a href="<%=request.getContextPath()%>/login" class="text-center">Tôi đã có tài khoản</a><br> 
      <a href="<%=request.getContextPath()%>/" class="text-center">Về giao diện mua sắm</a>
    </div>
      
  
    <!-- /.form-box -->
  </div><!-- /.card -->
</div>
<!-- /.register-box -->
<%if(request.getParameter("msg")!=null){
	String msg = request.getParameter("msg");%>
<input type="hidden" id="msg" value="<%=msg%>">
<%} %>
<%if(request.getParameter("err")!=null){
	String err = request.getParameter("err");%>
<input type="hidden" id="err" value="<%=err%>">
<%} %>
<!-- jQuery -->
<script src="<%=request.getContextPath()%>/templates/admin/assets/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="<%=request.getContextPath()%>/templates/admin/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- SweetAlert 2 -->
<script src="<%=request.getContextPath()%>/templates/admin/assets/plugins/sweetalert2/sweetalert2.min.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/templates/admin/assets/dist/js/adminlte.min.js"></script>
<!-- jquery-validation -->
<script src="<%=request.getContextPath()%>/templates/admin/assets/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="<%=request.getContextPath()%>/templates/admin/assets/plugins/jquery-validation/additional-methods.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="<%=request.getContextPath()%>/templates/admin/assets/dist/js/demo.js"></script>
<!-- Page specific script -->

<script>
$( document ).ready(function() {
	
	 if($("#msg").val()=='1'){
		 Swal.fire(
				  'Success!',
				  'Creat Account!',
				  'success'
				).then(function() {
				    window.location = "<%=request.getContextPath()%>/login";
				});
	 }if($("#err").val()=='1'){
		 Swal.fire({
			  icon: 'error',
			  title: 'Error...',
			  text: 'Username đã tồn tại!',
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
		      username: {
		        required: true,
		        
		      },
		      password: {
		        required: true,
		       
		      },
		      repassword: {
		    	  equalTo : "#password"
			      },
		      terms: {
		        required: true
		      },
		    },
		    messages: {
		    	username: {
		        required: "Please enter a username",
		       
		      },
		      password: {
		        required: "Please provide a password",
		       
		      },
		      repassword: {
		    	  equalTo: "That password doesn't match",
			       
			  },
		      terms: "Please accept our terms"
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
</body>
</html>
