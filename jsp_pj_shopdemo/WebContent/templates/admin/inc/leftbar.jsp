
<%@page import="java.util.ArrayList"%>
<%@page import="models.Category"%>
<%@page import="java.util.List"%>
<%@page import="models.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4	">
    <!-- Brand Logo -->
    <a href="<%=request.getContextPath()%>/view/admin/index.jsp" class="brand-link">
      <img src="<%=request.getContextPath()%>/templates/admin/assets/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">AdminLTE 3</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="<%=request.getContextPath()%>/templates/admin/assets/dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block"><%if(session.getAttribute("userInfor")!=null){
        	  User user = (User)session.getAttribute("userInfor");
        	  out.print(user.getUsername()); }%></a>
         
        </div>
      </div>

      <!-- SidebarSearch Form -->
      <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item">
            <a id ="category" href="<%=request.getContextPath()%>/admin/cat/index" class="nav-link">
              <i class="nav-icon fas fa-th"></i>
              <p>
                Quản lý danh mục
                <span class="right badge badge-danger">New</span>
              </p>
            </a>
          </li>
          <!-- <li class="nav-item menu-open"> -->
          <li class="nav-item">
            <a id ="product" href="<%=request.getContextPath()%>/admin/product/index" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Quản lý Sản phẩm
                <!-- <i class="right fas fa-angle-left"></i> -->
              </p>
            </a>
            <%-- <ul class="nav nav-treeview">
            <%	List<Category> catListLeftBar = (List<Category>)session.getAttribute("catListLeftBar");
            	if(catListLeftBar!=null && catListLeftBar.size()>0){
            		
            	catListLeftBar = (List<Category>)session.getAttribute("catListLeftBar");
            	for(Category cat : catListLeftBar){%>
              <li class="nav-item">
                <a href="<%=request.getContextPath()%>/admin/product/index?id=<%=cat.getId()%>" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p><%=cat.getName()%></p>
                </a>
              </li>
            <%} }%>  
            </ul> --%>
          </li>   
          <li class="nav-item">
            <a id ="user" href="<%=request.getContextPath()%>/admin/user/index" class="nav-link">
              <i class="nav-icon fas fa-copy"></i>
              <p>
                Quản lý người dùng
                
              </p>
            </a>
          </li>
          <%--  
           <li class="nav-item">
            <a id ="contact" href="<%=request.getContextPath()%>" class="nav-link">
              <i class="nav-icon fas fa-copy"></i>
              <p>
                Quản lý liên hệ
                
              </p>
            </a>
          </li> --%>
          
           <li class="nav-item">
            <a id ="order" href="<%=request.getContextPath()%>/admin/order/index" class="nav-link">
              <i class="nav-icon fas fa-circle"></i>
              <p>
                Quản lý đơn hàng               
              </p>
            </a>
          </li> 
                <li class="nav-item">
            <a href="<%=request.getContextPath()%>/logout" class="nav-link">
              <i class="nav-icon fas fa-sign-out-alt" style='color:green'></i>
              <p>
                Đăng xuất              
              </p>
            </a>
          </li> 
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>