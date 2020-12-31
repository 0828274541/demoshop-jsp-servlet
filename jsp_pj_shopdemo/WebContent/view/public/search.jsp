<%@page import="models.Product"%>
<%@page import="daos.ProductDAO"%>
<%@page import="daos.OrderDetailDAO"%>
<%@page import="models.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ include file="/templates/public/inc/header.jsp" %>


            <div class="main-content page-track-your-order" id="main-content">

                <div class="inner-xs">
                    <div class="page-header">
                    	<% if(request.getAttribute("searchResult")!=null){%>
                    			
                        	<h3 class="page-title">Tìm kiếm: '<%if(request.getAttribute("searchResult")!=null){out.print(request.getAttribute("searchResult"));}%>'.</h3>
                    	<%}%>
                    </div>
                </div>

                <div class="row inner-bottom-sm">
                    <div class="col-lg-8 center-block">

                        <div class="section">

                                <div class="field-row row form-row form-row-first">
                                    <div class="col-xs-12">
                                            <div class="tab-content">
        <%
        if(request.getAttribute("listProduct")!=null){
        	List<Product> listProduct = (ArrayList<Product>)request.getAttribute("listProduct");
        	
        	if(listProduct.size()>0){
        		
        		for(Product pro : listProduct){%>
        			
        
                   <div id="list-view" class="products-grid fade tab-pane in active ">
                <div class="products-list">
                    
                    <div class="product-item product-item-holder">
                        <div class="ribbon red"><span>sale</span></div> 
                        <div class="ribbon blue"><span>new!</span></div>
                        <div class="row">
                            <div class="no-margin col-xs-12 col-sm-4 image-holder">
                                <div class="image">
                                    <a href="<%=request.getContextPath()%>/public/detail?id=<%=pro.getId() %>">
                                    <img alt="" src="<%=request.getContextPath()%>/uploads/<%=proImgDAO.getItemByProductId(pro.getId()).getName()%>" data-echo="<%=request.getContextPath()%>/uploads/<%=proImgDAO.getItemByProductId(pro.getId()).getName()%>" />
                               		</a>
                                </div>
                            </div><!-- /.image-holder -->
                            <div class="no-margin col-xs-12 col-sm-5 body-holder">
                                <div class="body">
                                    
                                    <div class="title">
                                        <a href="<%=request.getContextPath()%>/public/detail?id=<%=pro.getId() %>"><%=pro.getName() %></a>
                                    </div>
                                    <div class="brand"><%=pro.getProducer() %></div>
                                    <div class="excerpt">
                                        <p><%if(pro.getPreview()!=null){out.print(pro.getPreview());} %></p>
                                    </div>
                          
                                </div>
                            </div><!-- /.body-holder -->
                            <div class="no-margin col-xs-12 col-sm-3 price-area">
                                <div class="right-clmn">
									<%if(pro.getSaleOff()!=0) {%>
                                    <div class="price-prev"><%=format.format(pro.getPrice())%></div>
                                    <div class="price-current "><%=format.format(pro.getSaleOff())%></div>
                                    <%}else{ %>
                                    <div class="price-current "><%=format.format(pro.getPrice())%></div>
                                    <%} %>
                                 
                                       <a class="le-button" href="<%=request.getContextPath()%>/public/detail?id=<%=pro.getId() %>">Thêm vào giỏ</a>
                                   
                                </div>
                            </div><!-- /.price-area -->
                        </div><!-- /.row -->
                    </div><!-- /.product-item -->
				 </div><!-- /.products-list -->

	         
            </div><!-- /.products-grid #list-view -->
 <%		}
        	}
        	else{
        		
        			out.print("<div class='page-header'><h3 class='page-title'>Ko tìm thấy kết quả nào phù hợp</h3></div");
        		
        		
        	}
        }else{%><h3 class="page-title">Ko tìm thấy kết quả nào phù hợp</h3><%} %>
        </div><!-- /.tab-content -->
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
   
  