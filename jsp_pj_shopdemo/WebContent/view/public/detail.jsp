
<%@page import="models.Product"%>
<%@page import="models.ProductImage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/templates/public/inc/header.jsp" %>



<div id="single-product">
    <div class="container">

         <div class="no-margin col-xs-12 col-sm-6 col-md-5 gallery-holder">
    <div class="product-item-holder">

        <div id="owl-single-product">
              <%if(request.getAttribute("imgList")!=null){
                		List<ProductImage> imgList = (ArrayList) request.getAttribute("imgList");
                		if(imgList.size()>0){
                			for(ProductImage proImg : imgList){%>
            <div class="single-product-gallery-item" id="<%=proImg.getId()%>">
                <a data-rel="prettyphoto" href="#">
                	
                				<img class="img-responsive"  alt="" src="<%=request.getContextPath()%>/uploads/<%=proImg.getName()%>" data-echo="<%=request.getContextPath()%>/uploads/<%=proImg.getName()%>" />
                	
                    
                </a>
            </div><!-- /.single-product-gallery-item -->
       	
    
		<%}
                		}	
                	}%>
        </div><!-- /.single-product-slider -->
		<div class="nav-holder left hidden-xs">
                <a class="prev-btn slider-prev" data-target="#owl-single-product" href="#prev"></a>
            </div><!-- /.nav-holder -->
            
            <div class="nav-holder right hidden-xs">
                <a class="next-btn slider-next" data-target="#owl-single-product" href="#next"></a>
            </div><!-- /.nav-holder -->
    </div><!-- /.single-product-gallery -->
</div><!-- /.gallery-holder -->

		<% Product product = new Product();
				if(request.getAttribute("productDetail")!=null){
					product =  (Product)request.getAttribute("productDetail");
				}
				%>        
        <div class="no-margin col-xs-12 col-sm-7 body-holder">
    <div class="body">


        <div class="title"><a href="#"><%=product.getName() %></a></div>
        <div class="brand"><%=product.getProducer() %></div>

        <div class="social-row">
            <span class="st_facebook_hcount"></span>
            <span class="st_twitter_hcount"></span>
            <span class="st_pinterest_hcount"></span>
        </div>

        <div class="excerpt">
        	<p><%if(product.getPreview()!=null){out.print(product.getPreview());} %></p>
        </div>
        
        <div class="prices">
         
        	 
             <%if(product.getSaleOff()!=0) {%>
             <div class="price-prev"><%=format.format(product.getPrice())%></div>
             <div class="price-current"><%=format.format(product.getSaleOff())%></div>
              <%}else{%>
               <div class="price-current"><%=format.format(product.getPrice())%></div>
              <%} %>
              
        </div>

        <div class="qnt-holder">
            <div class="le-quantity">
                <form id="quickForm">
                    <a class="minus" href="#reduce"></a>
                    
                    <input id="quantity" name="quantity" readonly="readonly" type="input" value="1" min="1"/>
                    <a class="plus" href="#add"></a>
                </form>
            </div>
            <a id="addToCart" href="#" class="le-button huge">Thêm vào giỏ</a>
        </div><!-- /.qnt-holder -->
    </div><!-- /.body -->

</div><!-- /.body-holder -->
    </div><!-- /.container -->
</div><!-- /.single-product -->

<!-- ========================================= SINGLE PRODUCT TAB ========================================= -->
<section id="single-product-tab">
    <div class="container">
        <div class="tab-holder">
            
            <ul class="nav nav-tabs simple" >
                <li class="active"><a href="#description" data-toggle="tab">Mô tả sản phẩm</a></li>
                <li><a href="#additional-info" data-toggle="tab">Thông tin sản phẩm</a></li>
                
            </ul><!-- /.nav-tabs -->
			
			
            <div class="tab-content">
                <div class="tab-pane active" id="description">
                    <p><%if(product.getPreview()!=null){out.print(product.getPreview());} %></p>
					
                    
                    
                </div><!-- /.tab-pane #description -->

                <div class="tab-pane" id="additional-info">
                    <ul class="tabled-data">
                    	<input type="hidden" id="productId" value="<%=product.getId()%>" name="<%=product.getId()%>"/>
                        <li>
                            <label>Khối lượng</label>
                            <div class="value">20 kg</div>
                        </li>
                        <li>
                            <label>Kích thước</label>
                            <div class="value">90x60x90 cm</div>
                        </li>
                        <li>
                            <label>Dung lượng</label>
                            <div class="value"><%if(product.getStorage()!=null){out.print(product.getStorage());} %> </div>
                        </li>
                        <li>
                            <label>Ram</label>
                            <div class="value"><%if(product.getRam()!=null){out.print(product.getRam());} %></div>
                        </li>
                        <li>
                            <label>Tính năng Camera</label>
                            <div class="value"><%if(product.getCameraFeature()!=null){out.print(product.getCameraFeature());} %></div>
                        </li>
                        <li>
                            <label>Dung lượng PIn</label>
                            <div class="value"><%if(product.getBatteryCapacity()!=null){out.print(product.getBatteryCapacity());} %></div>
                        </li>
                        <li>
                            <label>Nhà sản xuất</label>
                            <div class="value"><%if(product.getProducer()!=null){out.print(product.getProducer());} %></div>
                        </li>    
                        <li>
                            <label>Năm sản xuất</label>
                            <div class="value"><%if(product.getReleaseDate()!=null){out.print(product.getReleaseDate());} %></div>
                        </li>                      
                    </ul><!-- /.tabled-data -->

                    
                </div><!-- /.tab-pane #additional-info -->


                
            </div><!-- /.tab-content -->

        </div><!-- /.tab-holder -->
    </div><!-- /.container -->
</section><!-- /#single-product-tab -->
<!-- ========================================= SINGLE PRODUCT TAB : END ========================================= -->
<%if(session.getAttribute("msg")!=null){
	int msg = (Integer)session.getAttribute("msg");
	session.removeAttribute("msg");%>
<input type="hidden" id="msg" value="<%=msg%>">
<%} %>
<div style="display: none;" id="result" ></div>
<%@ include file="/templates/public/inc/footer.jsp" %>
<script>
  $(document).ready(function() {  
	
	  if(!!window.performance && window.performance.navigation.type == 2)
	  {
	      window.location.reload();
	  }
	
	  if($("#msg").val()=='1'){
			 alert('Thêm sản phẩm vào giỏ hàng thành công');
		 }
	  
   	 $('#addToCart').click(function() {
		 	var quantity = $('#quantity').val();
		 	var productId = $('#productId').val();
			//alert(quantity);
		$.ajax({
			url: '<%=request.getContextPath()%>/public/cart',
				
							type : 'POST',
							cache : false,
							data : {
								quantity: quantity,
								productId: productId,
							},
							
							success : function(responseText) {
								$('#result').text(responseText);
								
								myDivObj = document.getElementById("result");
								if(myDivObj.textContent=='1'){
									if (window.confirm('Bạn có muốn đăng nhập để thêm hàng vào giỏ?'))
									{
										 window.location = "<%=request.getContextPath()%>/login?quantity="+quantity+"&productId="+productId;
										 
									}
									else
									{
									    // They clicked no
									}
								}
								if(myDivObj.textContent=='2'){
									alert('thêm hàng vào giỏ thành công');
									$.ajax({
										//show so luong va tong so tien trong gio hang
										url: '<%=request.getContextPath()%>/public/viewcart',
											
														type : 'GET',
														cache : false,
														data : {
															
														},
														
														success : function(responseText) {
															$('#eventAddCart').html(responseText);
															
														},
														error : function() {
															alert('Có 2lỗi xảy ra');
														}
													}); 
									
								  
									//show chi tiet gio hang
								 		$.ajax({
								 			url: '<%=request.getContextPath()%>/public/viewcart',
								 				
								 							type : 'POST',
								 							cache : false,
								 							data : {
								 								
								 							},
								 							
								 							success : function(responseText) {
								 								$('#viewCart').html(responseText);
								 		
								 							},
								 							error : function() {
								 								alert('Có lỗi xảy ra khi click');
								 							}
								 						}); 
								 	
								 	
								}
								
							},
							error : function() {
								alert('Có lỗi xảy ra');
							}
						}); 
	
	 });
});
  </script>  
