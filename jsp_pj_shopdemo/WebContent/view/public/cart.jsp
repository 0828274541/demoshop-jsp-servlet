<%@page import="daos.ProductImageDAO"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="models.OrderDetail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/templates/public/inc/header.jsp" %>


		<section id="cart-page">
    <div class="container">
        <!-- ========================================= CONTENT ========================================= -->
        <div class="col-xs-12 col-md-9 items-holder no-margin">
            
            
			<%
			
				if(odList.size()>0){
					for(OrderDetail od : odList){%>
							<div id="<%=od.getProduct().getId()%>">
							<div class="row no-margin cart-item">
			                <div class="col-xs-12 col-sm-2 no-margin">
			                    <a href="<%=request.getContextPath()%>/public/detail?id=<%=od.getProduct().getId()%>" class="thumb-holder">
			                        <img class="lazy" width="79px" height="79px"alt="" src="<%=request.getContextPath()%>/uploads/<%=proImgDAO.getItemByProductId(od.getProduct().getId()).getName()%>" />
			                    </a>
			                </div>
			
			                <div class="col-xs-12 col-sm-5">
			                    <div class="title">
			                        <a href="<%=request.getContextPath()%>/public/detail?id=<%=od.getProduct().getId()%>"><%=od.getProduct().getName()%></a>
			                    </div>
			                    <div class="brand"><%=od.getProduct().getProducer()%></div>
			                </div> 
			
			                <div class="col-xs-12 col-sm-3 no-margin">
			                    <div class="quantity">
			                        <div class="le-quantity">
			                            <form>
			                            	<div id="div1">
			                                <a class="minus changeQuantity"  id ="<%=od.getProduct().getId()%>" href="#"></a>
			                                </div>
			                                <input id="getQuantity<%=od.getProduct().getId()%>" name="quantity" readonly="readonly" type="text" value="<%=od.getQuantity()%>" />
			                                <a class="plus changeQuantity" id ="<%=od.getProduct().getId()%>" href="#"></a>
			                            </form>
			                        </div>
			                    </div>
			                </div>
			
			                <div class="col-xs-12 col-sm-2 no-margin">
			                    <div class="price">
			                    <div class="price<%=od.getProduct().getId()%>">
			                          <%
							            if(od.getProduct().getSaleOff()!=0) {
							            	out.print(format.format(od.getProduct().getSaleOff()*od.getQuantity()));
							          	}else{
							          		out.print(format.format(od.getProduct().getPrice()*od.getQuantity()));
							          	}%>
			                    </div>
			                    </div>
			                    <a class="close-btn delOnCart" id="<%=od.getProduct().getId()%>" href="#"></a>
			                </div>
			            </div><!-- /.cart-item -->	
			           </div>
			           
			<%		}
				}
				
			 %>
            
        </div>
        <!-- ========================================= CONTENT : END ========================================= -->

        <!-- ========================================= SIDEBAR ========================================= -->

        <div class="col-xs-12 col-md-3 no-margin sidebar ">
            <div class="widget cart-summary">
                <h1 class="border">Giỏ hàng</h1>
                <div class="body">
                    <ul class="tabled-data no-border inverse-bold">
                        <li>
                            <label>Tổng tiền</label>
                            <div class="value pull-right"><div class="orderMoney" ><%if(request.getAttribute("orderMoney")!=null){out.print(request.getAttribute("orderMoney"));} %></div></div>
                        </li>
                        <li>
                            <label>Phí giao hàng</label>
                            <div class="value pull-right">Miến phí</div>
                        </li>
                    </ul>
                    <ul id="total-price" class="tabled-data inverse-bold no-border">
                        <li>
                            <label>order total</label>
                            <div class="value pull-right"><div class="orderMoney" ><%if(request.getAttribute("orderMoney")!=null){out.print(request.getAttribute("orderMoney"));} %></div></div>
                        </li>
                    </ul>
                    <div class="buttons-holder">
                        <a class="le-button big" href="<%=request.getContextPath()%>/public/checkout" >Mua hàng</a>
                        <a class="simple-link block" href="<%=request.getContextPath()%>/public/index" >Tiếp tục mua sắm</a>
                    </div>
                </div>
            </div><!-- /.widget -->

 
        </div><!-- /.sidebar -->

        <!-- ========================================= SIDEBAR : END ========================================= -->
    </div>
</section>	         
<%if(request.getParameter("msg")!=null){
	String msg = request.getParameter("msg");%>
<input type="hidden" id="msg" value="<%=msg%>">
<%} %>
 <%@ include file="/templates/public/inc/footer.jsp" %>
 <script>
$( document ).ready(function() {
	  if(!!window.performance && window.performance.navigation.type == 2)
	  {
	      window.location.reload();
	  }
	  
		$("#cart1").hide();
	  	
		$('.delOnCart').click(function() {
		  var proId = $(this).attr("id");
	 	
	 	$.ajax({
			url: '<%=request.getContextPath()%>/public/dellcart',
				
							type : 'POST',
							cache : false,
							data : {
								productId: proId,
							},
							
							success : function() {
								
								$("div").remove("#"+proId);
							
								//edit Cart Subtotal Order Total
								$.ajax({
						 			url: '<%=request.getContextPath()%>/public/editcart',
						 				
						 							type : 'POST',
						 							cache : false,
						 							data : {
						 								
						 							},
						 							
						 							success : function(responseText) {
						 								$('.orderMoney').text(responseText);
						 		
						 							},
						 							error : function() {
						 								alert('Có lỗi xảy ra khi click');
						 							}
						 						}); 
							},
							error : function() {
								alert('Có lỗi xảy ra khi click');
							}
						}); 
});
	
	$('.changeQuantity').click(function() {
		  var proId = $(this).attr("id");
		  var quantity1 = $('#getQuantity'+proId).val();
		
	 	$.ajax({
			url: '<%=request.getContextPath()%>/public/editcart',
				
							type : 'GET',
							cache : false,
							data : {
								productId: proId,
								quantity1: quantity1,
							},
							
							success : function(result) {
								$('.price'+proId).text(result);
								
								//edit Cart Subtotal Order Total
								$.ajax({
						 			url: '<%=request.getContextPath()%>/public/editcart',
						 				
						 							type : 'POST',
						 							cache : false,
						 							data : {
						 								
						 							},
						 							
						 							success : function(responseText) {
						 								$('.orderMoney').text(responseText);
						 		
						 							},
						 							error : function() {
						 								alert('Có lỗi xảy ra khi click');
						 							}
						 						}); 
							},
							error : function() {
								alert('Có lỗi xảy ra khi click');
							}
						}); 
	});
	
	
	
	
	
});
</script>