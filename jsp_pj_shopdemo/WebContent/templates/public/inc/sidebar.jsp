<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="controllers.publics.PublicIndexController"%>
<%@page import="daos.CatDAO"%>
<%@page import="models.Category"%>
		            <!-- ========================================= CATEGORY TREE ========================================= -->
<div class="widget accordion-widget category-accordions">
    <h1 class="border">Danh mục đệ quy</h1>
    <div class="accordion">
    <!-- --------------------------------- -->
        
  
                   <%
          				
                  		
                  		if(session.getAttribute("catListRecursive")!=null){
         				ArrayList<Category> parentList = (ArrayList<Category>)session.getAttribute("catListRecursive");
                        if(parentList.size() > 0){
                        	for(Category category : parentList){
                        		
                        		if(category.getParent_id()==0){%>
                        	<div class="accordion-group">
            					<div class="accordion-heading">	
                        		 <a class="accordion-toggle collapsed" data-toggle="collapse" href="#<%=category.getId()%>"><%=category.getName()%></a>
                     			</div>
           							 <div id="<%=category.getId()%>" class="accordion-body collapse">
               							 <div class="accordion-inner">
               							  
                       						 
                  		 <%  PublicIndexController.showCat(request, out, category.getId());%>
                  		  </div><!-- /.accordion-inner -->
   					 	 </div>
						 </div><!-- /.accordion-group -->	<%	}
                  		
                        		}
                  			 		
                       }
                   
                  	 	}
                   %>
 

    </div><!-- /.accordion -->
</div><!-- /.category-accordions -->
<!-- ========================================= CATEGORY TREE : END ========================================= -->
