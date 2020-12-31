<%@page import="models.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/templates/public/inc/header.jsp" %>

	

	<!-- ========================================= CONTENT ========================================= -->

<section id="checkout-page">
    <div class="container">
        <div class="col-xs-12 no-margin">
            <section id="your-order">
                <h2 class="border h1">Đơn hàng của bạn</h2>
                <form>
                	<%if(session.getAttribute("cartList")!=null){ 
                		List<OrderDetail> cartList = (ArrayList)session.getAttribute("cartList");
                		if(cartList.size()>0){
                		for(OrderDetail od : cartList){%>
                    <div class="row no-margin order-item">
                        <div class="col-xs-12 col-sm-1 no-margin">
                            <a href="#" class="qty"><%=od.getQuantity()%> x</a>
                        </div>

                        <div class="col-xs-12 col-sm-9 ">
                            <div class="title"><a href="<%=request.getContextPath()%>/public/detail?id=<%=od.getProduct().getId()%>"><%=od.getProduct().getName()%></a></div>
                            <div class="brand"><%=od.getProduct().getProducer()%></div>
                        </div>

                        <div class="col-xs-12 col-sm-2 no-margin">
                        <%if(od.getProduct().getSaleOff()!=0){%>
                        	<div class="price"><%=format.format(od.getProduct().getSaleOff()*od.getQuantity())%></div>
                        <%}else{ %>	
                        	<div class="price"><%=format.format(od.getProduct().getPrice()*od.getQuantity())%></div>
 						<%}%>		
                        </div>
                    </div><!-- /.order-item -->
                    <%}}else{out.print("<h1>Bạn chưa có đơn hàng nào</h1>");}}%>
                </form>
            </section><!-- /#your-order -->

			<div id="total-area" class="row no-margin">
                <div class="col-xs-12 col-lg-4 col-lg-offset-8 no-margin-left">
			<div id="cupon-widget" class="widget">
                <h1 class="border">Áp dụng mã giảm giá</h1>
                <div class="body">
                   
                        <div class="inline-input">
                            <input id="coupon" data-placeholder="Nhập mã 123 để đc giảm giá 50% đơn hàng" type="text" />
                            <a class="le-button" id="applyCoupon" href="#">Apply</a>
                        </div>
                    
                      </div>
            </div>	
                </div>
            </div><!-- /.widget -->
            <div id="total-area" class="row no-margin">
                <div class="col-xs-12 col-lg-4 col-lg-offset-8 no-margin-left">
                    <div id="subtotal-holder">
                        <ul class="tabled-data inverse-bold no-border">
                            <li>
                                <label>Thanh toán</label>
                                <div class="value "><%if(request.getAttribute("totalMoney")!=null){out.print(format.format(request.getAttribute("totalMoney")));} %></div>
                            </li>
                            <li>
                                <label>Mã giảm giá</label>
                                <div class="value"><div id ="valueCoupon"></div></div>
                            </li>
                        </ul><!-- /.tabled-data -->

                        <ul id="total-field" class="tabled-data inverse-bold ">
                            <li>
                                <label>Tổng tiền</label>
                                <div class="value"><div id ="myDiv2"><%if(request.getAttribute("totalMoney")!=null){out.print(format.format(request.getAttribute("totalMoney")));} %></div></div>
                            </li>
                        </ul><!-- /.tabled-data -->

                    </div><!-- /#subtotal-holder -->
                </div><!-- /.col -->
            </div><!-- /#total-area -->

			
      <div class="billing-address">
                <h2 class="border h1">Địa chỉ</h2>
                <%User user = new User();
                if(session.getAttribute("userInfor")!=null){
                	user = (User)session.getAttribute("userInfor");
                	
                }%>
                
                <form  action="<%=request.getContextPath()%>/public/checkout" id="orderForm" method="POST">
                    <div class="row field-row">
                        <div class="col-xs-12 col-sm-6">
                            <label>Họ tên *</label>
                            <input class="le-input" value="<%if(user.getFullname()!=null){out.print(user.getFullname());} %>" id="fullname" name="fullname">
                        </div>
                    </div><!-- /.field-row -->

                    <div class="row field-row">
                        <div class="col-xs-12 col-sm-6">
                            <label>Địa chỉ nhận hàng*</label>
                            <input type="text" class="le-input" value="<%if(user.getAddress()!=null){out.print(user.getAddress());} %>"  id="address"  name="address" >
                        </div>
                     
                    </div><!-- /.field-row -->

                    <div class="row field-row">
                        <div class="col-xs-12 col-sm-6">
                            <label>Số điện thoại *</label>
                            <input type="text" class="le-input" value="<%if(user.getTelephoneNumber()!=0){out.print(user.getTelephoneNumber());} %>" id="phone" name="phone" placeholder="">
                        </div>
                    </div><!-- /.field-row -->
                    <div hidden>
                         <input type="text" id="input1" name="totalMoney" value="<%if(request.getAttribute("totalMoney")!=null){out.print(request.getAttribute("totalMoney"));} %>" >
                    </div>
                    <div hidden>
                         <input type="text" id="input2" name="discount" value="0" >
                    </div>
                    <div class="row field-row">
                        <div class="col-xs-12 col-sm-2">
                            <label>Phương thức thanh toán</label>
                            
                             <label class="radio-inline">
      							Thanh toán tại nhà<input type="radio" value="Thanh toán tại nhà" id="paymentMethod" name="paymentMethod" checked >
    						</label>
                        </div>
                    </div><!-- /.field-row -->
                    <%if(odList.size()>0){ %>
                    <div class="place-order-button">
               			 <button type="submit" class="le-button big">Đặt hàng</button>
           			</div><!-- /.place-order-button --> 
           			<%}else{ %>
           			<div class="place-order-button" >
               			 <a href="<%=request.getContextPath()%>/public/index" class="le-button big">Về mua hàng</a>
           			 </div><!-- /.place-order-button -->
					<%} %>      
                </form>
            </div><!-- /.billing-address -->           
        </div><!-- /.col -->
    </div><!-- /.container -->    
</section><!-- /#checkout-page -->

 <%@ include file="/templates/public/inc/footer.jsp" %>
 			<!-- jQuery -->
		<script src="<%=request.getContextPath()%>/templates/public/assets/js/jquery-3.2.1.min.js"></script>
		<!-- jquery-validation -->
		<script src="<%=request.getContextPath()%>/templates/public/assets/js/jquery.validate.min.js"></script>
		
 <script>
  $(document).ready(function() {  
	  //$('#valueTotalMoney').html($('#mydiv1').html());
	 // alert($("#myDiv2").html());
	 $("#cart1").hide();
	 
	 function formatCurrency(n, separate = "."){
		  var s = n.toString();
		  var len = s.length;
		  var ret = "";
		  for(var i = 1; i <= len; i++) {
		    ret = s[(len-i)] + ret;
		    
		    if( i % 3  === 0 && i < len) {
		      ret = separate + ret;
		    }
		  }
		  return ret;
		}
	  
   	 $('#applyCoupon').click(function() {
   		 var coupon = $("#coupon").val();
   		 moneyCurrent = $('#input1').val();
   		 if(moneyCurrent!="0"){
   			if(coupon == '123'){
   	   			$("#valueCoupon").html("50%");
   	   			
   	   			var totalMoneySaleOff = moneyCurrent * 50 / 100;
   	   			$('#myDiv2').html(formatCurrency(totalMoneySaleOff, ".")+"&nbsp;₫");
   	   			$('#input1').val(totalMoneySaleOff);
   	   			$('#input2').val(0.5);
   	   		 }else{
   	   			alert("Mã giảm giá ko hợp lệ");
   	   		 }
   	   		 
   		 }
   		 
   	});
   	
	 $('#orderForm').validate({
		 
		    rules: {
				fullname: {
		        	required: true,
				},
				address: {
			        required: true,
					},
				phone: {
				    required: true,
				    number: true,
					},
				paymentMethod: {
				    required: true,
				    
					},
				
		    },
		    messages: {
		    	fullname: {
			        required: "Please enter a fullname",
			    },
			    address: {
			        required: "Please provide a address",
		        },
		        phone: {
				      required: "Please provide a phone",
				      number: "Please enter a valid number.",
				},
				paymentMethod: {
				    required:  "Please choose a method",
				    
					},
				
		    },
		    
		  });

});
 </script>