<%@page import="daos.ProductDAO"%>
<%@page import="daos.OrderDetailDAO"%>
<%@page import="models.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ include file="/templates/public/inc/header.jsp" %>


            <div class="main-content page-track-your-order" id="main-content">

                <div class="inner-xs">
                    <div class="page-header">
                        <h2 class="page-title">Track your Order</h2>
                    </div>
                </div>

                <div class="row inner-bottom-sm">
                    <div class="col-lg-8 center-block">

                        <div class="section">

                            

                                <div class="field-row row form-row form-row-first">
                                    <div class="col-xs-12">
                                    <%if(request.getAttribute("orderList")!=null){
                					List<Order> orderList = (ArrayList) request.getAttribute("orderList");
                					if(orderList.size()>0){
                					for(Order order : orderList){%>
                                        <label for="orderid">Ma đơn hàng: <%=order.getId()%></label>
                                       <label for="orderid">Tổng tiền: <%=order.getTotalMoney()%></label>
                                        <label for="orderid">Ngày tạo: <%=order.getCreateDate()%></label>
                                        <label for="orderid">Giảm giá: <%=order.getDiscount()*100%>&#37;</label>
                                        <div>
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
								         				List<OrderDetail> odList1 =  odDAO.findByOrderId(order.getId());
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
                  
                                    <%}}else{out.print("<h1>Ko tim thây đơn hàng nào của bạn!!!</h1>");}} %>
                                    </div>
                                    
                                </div>
                             
                           
                        </div>
                    </div>
                </div>
                <div class="row inner-bottom-sm">
                <div class="col-lg-8 center-block">
                <div id="div2">
                </div>
                </div>
                </div>
            </div>
            <!-- ============================================================= FOOTER ============================================================= -->
        <%@ include file="/templates/public/inc/footer.jsp" %>
   
  