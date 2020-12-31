<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="daos.ProductImageDAO"%>
<%@page import="models.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/templates/public/inc/header.jsp" %>

<!-- ============================================================= HEADER : END ============================================================= -->		
<section id="category-grid">
    <div class="container">

        <!-- ========================================= SIDEBAR ========================================= -->
        <div class="col-xs-12 col-sm-3 no-margin sidebar narrow">
    <%@ include file="/templates/public/inc/sidebar.jsp" %>
            <!-- ========================================= PRODUCT FILTER ========================================= -->

           


        </div>
        <!-- ========================================= SIDEBAR : END ========================================= -->

        <!-- ========================================= CONTENT ========================================= -->

        <div class="col-xs-12 col-sm-9 no-margin wide sidebar">

            <div id="grid-page-banner">
                <a href="#">
                    <img width="899px" height="277px" src="<%=request.getContextPath()%>/templates/public/assets/images/banners/TA-4143-1606290908.jpg" alt="" />
                </a>
            </div>

            <section id="gaming">
    <div class="grid-list-products">
        <h2 class="section-title"> 
        	<% if(request.getAttribute("cat")!=null){
        		Category cat = (Category)request.getAttribute("cat");
        		CatDAO catDAO = new CatDAO();
        		List<Category> list = new ArrayList();
        		list.add(cat);
        		int parentId = cat.getParent_id();
                do {
                	Category cat1 = catDAO.getListCat(parentId);
                	list.add(cat1);
                	parentId = cat1.getParent_id();
                } while (parentId>0);
                
        		for(int i = list.size(); i>0; i--){
        			
        			out.print(list.get(i-1).getName());
        			if(i!=1){
        				out.print("|");
        			}
        		}
        		
        			}%>
        </h2>
            <div class="grid-list-buttons">
                <ul>
                    <li class="grid-list-button-item active"><a data-toggle="tab" href="#list-view"><i class="fa fa-th-list"></i> List</a></li>
                </ul>
            </div>
    
                                
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
                                    <div class="price-current"><%=format.format(pro.getSaleOff())%></div>
                                    	<%}else{ %>
                                    	<div class="price-current"><%=format.format(pro.getPrice())%></div>
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
        		if(request.getAttribute("cat")!=null){
        			Category cat =(Category) request.getAttribute("cat");
        			out.print("<h1 text-alignt:center> ko có sản phẩm nao thuộc danh mục '<i style ='font-weight: bold;'> "+cat.getName()+"</i>' dc tìm thấy</h1>");
        		}
        		
        	}
        }%>	
        </div><!-- /.tab-content -->
           <%
           	   	int numberOfPages = 0;
  				int currentPage = 0;
  				int numberOfItems = 0;
  				int perPage = 0;
  				int offSet = 0;
              	if(request.getAttribute("numberOfPages") !=null && request.getAttribute("currentPage")!=null && request.getAttribute("numberOfItems")!=null && request.getAttribute("perPage")!=null && request.getAttribute("offSet")!=null){
						 numberOfPages = (Integer)request.getAttribute("numberOfPages");
    			 		currentPage = (Integer)request.getAttribute("currentPage");
    					 numberOfItems = (Integer)request.getAttribute("numberOfItems");
    					 perPage = (Integer)request.getAttribute("perPage");
    					 offSet = (Integer)request.getAttribute("offSet");
    			String urlPage="";
    			
    			if(request.getAttribute("cat")!=null){
        			Category cat =(Category) request.getAttribute("cat");
        			urlPage = request.getContextPath()+"/public/cat?id="+cat.getId()+"&page=";
        		}
   				
  				if(numberOfItems>0){
   			  %>
                <div class="pagination-holder">
                    <div class="row">
                        <div class="col-xs-12 col-sm-6 text-left">
                            <ul class="pagination">
                                <li id="li1" class=""><a class="" href="<%=urlPage%><%=currentPage-1%>">Prev</a></li>
								<li id="li2" class=""><a class="" href="<%=urlPage%><%=currentPage-1%>"><%=currentPage-1%></a></li>
								<li id="li3" class="current"><a class="" href="" ><%=currentPage%></a></li>
								<li id="li4" class=""><a class="" href="<%=urlPage%><%=currentPage+1%>"><%=currentPage+1%></a></li>
								<li id="li5" class=""><a class="" href="<%=urlPage%><%=currentPage+1%>">Next</a></li>
                            </ul><!-- /.pagination -->
                        </div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="result-counter">
                                Showing <span><%=(offSet+1)%>-<%int sum = (perPage+offSet);if(sum>numberOfItems){out.print(numberOfItems);}else{out.print(sum);}%></span> of <span><%=numberOfItems%></span> results
                            </div><!-- /.result-counter -->
                        </div>
                    </div><!-- /.row -->
                </div><!-- /.pagination-holder -->
			<%}}%>
              <input type="hidden" id="numberOfPages" value="<%=numberOfPages%>">
           	  <input type="hidden" id="currentPage" value="<%=currentPage%>">
           	  <input type="hidden" id="numberOfItems" value="<%=numberOfItems%>">
    </div><!-- /.grid-list-products -->

</section><!-- /#gaming -->                        
        </div><!-- /.col -->
        <!-- ========================================= CONTENT : END ========================================= -->    
    </div><!-- /.container -->
</section><!-- /#category-grid -->	
<%if(request.getParameter("id")!=null){
	String catId1 = request.getParameter("id");%>
<input type="hidden" id="catId1" value="<%=catId1%>">
<%} %>
<%@ include file="/templates/public/inc/footer.jsp" %>
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
  });
</script>