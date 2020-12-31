<%@page import="models.OrderDetail"%>
<%@page import="daos.ProductDAO"%>
<%@page import="daos.OrderDetailDAO"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="models.Order"%>
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
            <h1>Order</h1>
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
          
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table id="example1" class="table table-bordered table-striped">
                  <thead>
                  <tr>
                  	<th>Id</th>
                    <th>Tổng tiền</th>
                    <th>Phương thức thanh toán</th> 
                    <th>Giảm giá</th> 
                    <th>Ngày tạo</th> 
                    <th>ID Người tạo</th>
                    <th>Chi tiet</th>            
                  </tr>
                  </thead>
                  <tbody>
          <%	Locale locale = new Locale("vi", "VN");
          NumberFormat format =  NumberFormat.getCurrencyInstance(locale);
      			ArrayList<Order> orderList = new ArrayList<Order>();
				if(request.getAttribute("orderList")!=null){
					orderList = (ArrayList<Order>)request.getAttribute("orderList");
					
				if(orderList.size()>0){
					for(Order pro: orderList){
							
		  %>                      
                     <tr class="tr" id="<%=pro.getId()%>">
                     <td><%=pro.getId()%></td>
                     <td><%=format.format(pro.getTotalMoney())%></td>
                      <td><%=pro.getPaymentMethod() %></td>
                      <td><%=pro.getDiscount()*100%>%</td>
                     <td><%=pro.getCreateDate()%></td>
                     <td><%=pro.getCreateBy() %></td>
                     <td>
                     <button type="button"  class="btn btn-block btn-success" data-toggle="modal" data-target="#modal-default<%=pro.getId()%>">Xem</button>
                     <!-- The Modal -->
				      <div class="modal fade" id="modal-default<%=pro.getId()%>">
				        <div class="modal-dialog">
				          <div class="modal-content">
				            <div class="modal-header">
				              <h4 class="modal-title">Chi tiết đơn hàng</h4>
				              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                <span aria-hidden="true">&times;</span>
				              </button>
				            </div>
				            <div class="modal-body">
								<table id="example1" class="table table-bordered table-striped">
					                  <thead>
					                  <tr>
					                  	 <th>Tên sản phẩm</th>        
								         <th>Số lượng</th>
								         <th>Đơn Giá</th>           
					                  </tr>
					                  </thead>
					                  <tbody>
					                  	 <%	OrderDetailDAO odDAO = new OrderDetailDAO();
								                  		ProductDAO productDAO = new ProductDAO();
								         				List<OrderDetail> odList1 =  odDAO.findByOrderId(pro.getId());
								                        if(odList1.size() > 0){
								                        	for(OrderDetail orderDetail : odList1){
								                        		
								                  %>
								                  			
								                    			 <tr>
								                    			 <td><%= productDAO.getItem(orderDetail.getProduct().getId()).getName()%></td>
								                    			 <td><%= orderDetail.getQuantity()%></td>
								                    			 <% if(productDAO.getItem(orderDetail.getProduct().getId()).getSaleOff()>0){%>
								                    			 <td><%= format.format(productDAO.getItem(orderDetail.getProduct().getId()).getSaleOff())%></td>
								                    			 <%}else{ %>
								                    			 <td><%=format.format(productDAO.getItem(orderDetail.getProduct().getId()).getPrice())%></td>
								                    			 <%} %>
								                    			 </tr>
								                        			
								                   <% 
								    
								                        	}
								                        }
								                  		
								                   %>
					                  </tbody>
								  </table>
				            </div>
				          </div>
				          <!-- /.modal-content -->
				        </div>
				        <!-- /.modal-dialog -->
				      </div>
				      <!-- /.modal -->
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
   				urlPage = request.getContextPath()+"/admin/order/index?page=";
  				
   			  %>
              <div class="card-footer clearfix">
              <ul class="pagination pagination-sm m-0 float-left">
                  	<li id="li" class="page-item "><p >Trang <%=currentPage%> của <%=numberOfPages%>(Có <%=numberOfItems%> kết quả) </p></li>
                </ul>
                <ul class="pagination pagination-sm m-0 float-right">
                  	<li id="li1"  class="page-item"><a class="page-link" href="<%=urlPage%><%=currentPage-1%>">&laquo;</a></li>
					<li id="li2" class="page-item"><a class="page-link" href="<%=urlPage%><%=currentPage-1%>"><%=currentPage-1%></a></li>
					<li id="li3" class="page-item active"><p class="page-link"><%=currentPage%></p></li>
					<li id="li4" class="page-item"><a class="page-link" href="<%=urlPage%><%=currentPage+1%>"><%=currentPage+1%></a></li>
					<li id="li5" class="page-item"><a class="page-link" href="<%=urlPage%><%=currentPage+1%>">&raquo;</a></li>
                </ul>
              </div>
              <%}%>
              <input type="hidden" id="numberOfPages" value="<%=numberOfPages%>">
           	  <input type="hidden" id="currentPage" value="<%=currentPage%>">
           	  <input type="hidden" id="numberOfItems" value="<%=numberOfItems%>">
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
		 
	 document.getElementById("order").classList.add('active');
	 
	 
	  $(function() {
		    var Toast = Swal.mixin({
		      toast: true,
		      position: 'top-end',
		      showConfirmButton: false,
		      timer: 3000
		    });
});
  </script>  
