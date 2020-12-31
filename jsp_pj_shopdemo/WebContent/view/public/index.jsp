

<%@page import="daos.ProductImageDAO"%>
<%@page import="models.Product"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="models.ProductImage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/templates/public/inc/header.jsp" %>


	<div id="top-banner-and-menu">
	<div class="container">
		<div class="col-xs-12 col-sm-4 col-md-3 sidemenu-holder">
			
			
<%@ include file="/templates/public/inc/sidebar.jsp" %>
			
			
		</div><!-- /.sidemenu-holder -->

		<div class="col-xs-12 col-sm-8 col-md-9 homebanner-holder">
			<!-- ========================================== SECTION – HERO ========================================= -->
		
		<%String productImage1="";
		String productImage2="";
		
		if(request.getAttribute("listImageBanner")!=null){
			List<ProductImage> listImage = (ArrayList<ProductImage>)request.getAttribute("listImageBanner");
			if(listImage.size()>0){
				for(ProductImage proImg : listImage){
					if(productImage1.equals("")){
						productImage1 = proImg.getName();
					}else{
						productImage2 = proImg.getName();
					}
	
				}
			}
		}%>	
<div id="hero">
	<div id="owl-main" class="owl-carousel owl-inner-nav owl-ui-sm">
		
		<%
		if(request.getAttribute("listImageBanner")!=null){
			List<ProductImage> listImage = (ArrayList<ProductImage>)request.getAttribute("listImageBanner");
			if(listImage.size()>0){
				for(ProductImage proImg : listImage){%>
					
		<div class="item" style="background-image: url(<%=request.getContextPath()%>/uploads/<%=proImg.getName()%>);  background-size: 600px 300px;">
			<div class="container-fluid">
				<div class="caption vertical-center text-left">
					<div class="big-text fadeInDown-1">
						Save up to a<span class="big"><span class="sign">$</span>400</span>
					</div>

					<div class="excerpt fadeInDown-2">
						on selected laptops<br>
						& desktop pcs or<br>
						smartphones
					</div>
					<div class="small fadeInDown-2">
						terms and conditions apply
					</div>
					<div class="button-holder fadeInDown-3">
						<a href="<%=request.getContextPath()%>/public/detail?id=<%=proImg.getProduct().getId()%>" class="big le-button ">Mua ngay</a>
					</div>
				</div><!-- /.caption -->
			</div><!-- /.container-fluid -->
		</div><!-- /.item -->
	<% 			}
			}
		}%>	
	</div><!-- /.owl-carousel -->
</div>
			
<!-- ========================================= SECTION – HERO : END ========================================= -->			
		</div><!-- /.homebanner-holder -->

	</div><!-- /.container -->
</div><!-- /#top-banner-and-menu -->



<div id="products-tab" class="wow fadeInUp">
    <div class="container">
        <div class="tab-holder">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" >
                <li class="active"><a href="#featured" data-toggle="tab">Sản phẩm nổi bật</a></li>
               
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane active" id="featured">
                    <div class="product-grid-holder">
                        
                        <%
		if(request.getAttribute("listProduct")!=null){
			List<Product> listProduct = (ArrayList<Product>)request.getAttribute("listProduct");
			if(listProduct.size()>0){
				for(Product pro : listProduct){%>
				
                        <div class="col-sm-4 col-md-3 no-margin product-item-holder hover">
                            <div class="product-item">
                                <div class="ribbon blue"><span>new!</span></div> 
                                <div class="image">
                                	<a href="<%=request.getContextPath()%>/public/detail?id=<%=pro.getId()%>">
                                    <img alt="" height="200px" src="<%=request.getContextPath()%>/uploads/<%=proImgDAO.getItemByProductId(pro.getId()).getName()%>" data-echo="<%=request.getContextPath()%>/uploads/<%=proImgDAO.getItemByProductId(pro.getId()).getName()%>" />
                                	</a>
                                </div>
                                <div class="body">
                                    <div class="label-discount clear"></div>
                                    <div class="title">
                                        <a href="<%=request.getContextPath()%>/public/detail?id=<%=pro.getId()%>"><%=pro.getName()%></a>
                                    </div>
                                    <div class="brand"><%=pro.getProducer()%></div>
                                </div>
                                <div class="prices">
                          
                                    
                                    <%if(pro.getSaleOff()!=0) {%>
                                    <div class="price-prev"><%=format.format(pro.getPrice())%></div>
                                    <div class="price-current pull-right"><%=format.format(pro.getSaleOff())%></div>
                                    <%}else{ %>
                                    <div class="price-current pull-right"><%=format.format(pro.getPrice())%></div>
                                    <%} %>
                                </div>
                                <div class="hover-area">
                                    <div class="add-cart-button">
                                        <a href="<%=request.getContextPath() %>/public/detail?id=<%=pro.getId()%>" class="le-button">Thêm vào giỏ</a>
                                    </div>

                                </div>
                            </div>
                        </div>
                     	<% 			}
			}
		}%>	   
                        
                </div>
                

    
            </div>
            
            
        </div>
        
    </div>
    
</div>
                
                <%
           	   	int numberOfPages = 0;
  				int currentPage = 0;
  				int numberOfItems = 0;
              	if(request.getAttribute("numberOfPages") !=null && request.getAttribute("currentPage")!=null && request.getAttribute("numberOfItems")!=null){
						 numberOfPages = (Integer)request.getAttribute("numberOfPages");
    			 		currentPage = (Integer)request.getAttribute("currentPage");
    					 numberOfItems = (Integer)request.getAttribute("numberOfItems");
    			String urlPage="";
   				urlPage = request.getContextPath()+"/public/index?page=";
  				
   			  %>
              <div>
              
              <ul class="pagination " style=" margin-left: 500px;">
                     
              		<li id="li1" class=""><a class="" href="<%=urlPage%><%=currentPage-1%>">Prev</a></li>
					<li id="li2" class=""><a class="" href="<%=urlPage%><%=currentPage-1%>"><%=currentPage-1%></a></li>
					<li id="li3" class="current"><a class="" href="" ><%=currentPage%></a></li>
					<li id="li4" class=""><a class="" href="<%=urlPage%><%=currentPage+1%>"><%=currentPage+1%></a></li>
					<li id="li5" class=""><a class="" href="<%=urlPage%><%=currentPage+1%>">Next</a></li>
               
              </ul>
              </div>
              <%}%>
              <input type="hidden" id="numberOfPages" value="<%=numberOfPages%>">
           	  <input type="hidden" id="currentPage" value="<%=currentPage%>">
           	  <input type="hidden" id="numberOfItems" value="<%=numberOfItems%>">
						
						
 
</div>
<%if(request.getParameter("msg")!=null){
	String msg = request.getParameter("msg");%>
<input type="hidden" id="msg" value="<%=msg%>">
<%} %>
<%if(request.getParameter("orderId")!=null){
	String orderId = request.getParameter("orderId");%>
<input type="hidden" id="orderId" value="<%=orderId%>">
<%} %>
<%@ include file="/templates/public/inc/footer.jsp" %>

<script>
  $(document).ready(function() { 
	  //reload lai trang khi click go to back tren trinh duyet
	  if(!!window.performance && window.performance.navigation.type == 2)
	  {
	      window.location.reload();
	  }
	  
		 if($("#msg").val()=='1'){
			alert("Đặt hàng thành công. Mã đơn hàng là : "+$("#orderId").val());
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
  });
</script>