<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Log in (v2)</title>

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
<body class="hold-transition login-page">
<div class="login-box">
  <!-- /.login-logo -->
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <a href="#" class="h1"><b>Đăng nhập</b></a>
    </div>
    <div class="card-body">
      <p class="login-box-msg">Sign in to start your session</p>

      <form id="quickForm" action="<%=request.getContextPath()%>/login" method="post">
        <div class="form-group">
          <input type="text" class="form-control" id="username" name="username" placeholder="Username">
        </div>
        <div class="form-group">
          <input type="password" class="form-control" id="password" name="password" placeholder="Password">

        </div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="remember">
              <label for="remember">
                Remember Me
              </label>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block">Sign In</button>
          </div>
          <!-- /.col -->
        </div>
      </form>

      <div class="social-auth-links text-center mt-2 mb-3">
  
      </div>
      <!-- /.social-auth-links -->

<!--       <p class="mb-1">
        <a href="#">I forgot my password</a>
      </p> -->
      <p class="mb-0">
        <a href="<%=request.getContextPath()%>/register" class="text-center">Tạo tài khoản mới</a><br>
      </p>
      <p class="mb-0">
        <a href="<%=request.getContextPath()%>/" class="text-center">Về giao diện mua sắm</a>
      </p>
    </div>
    <!-- /.card-body -->
  </div>
  <!-- /.card -->
</div>
<!-- /.login-box -->
<%if(request.getParameter("err")!=null){
	String err = request.getParameter("err");%>
<input type="hidden" id="err" value="<%=err%>">
<%} %>

<!-- jQuery -->
<script src="<%=request.getContextPath()%>/templates/admin/assets/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="<%=request.getContextPath()%>/templates/admin/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/templates/admin/assets/dist/js/adminlte.min.js"></script>
<!-- SweetAlert 2 -->
<script src="<%=request.getContextPath()%>/templates/admin/assets/plugins/sweetalert2/sweetalert2.min.js"></script>
<!-- jquery-validation -->
<script src="<%=request.getContextPath()%>/templates/admin/assets/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="<%=request.getContextPath()%>/templates/admin/assets/plugins/jquery-validation/additional-methods.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="<%=request.getContextPath()%>/templates/admin/assets/dist/js/demo.js"></script>
<script>
$( document ).ready(function() {
		
	 if($("#err").val()=='1'){
		 Swal.fire({
			  icon: 'error',
			  title: 'Error...',
			  text: 'Tk or Mk không đúng',
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
		    },
		    messages: {
		    	username: {
		        required: "Please provide a password",
				},
				password: {
		        required: "Please provide a password",
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

</body>
</html>
