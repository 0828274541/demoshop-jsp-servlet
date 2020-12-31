<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/templates/public/inc/header.jsp" %>


			<main id="faq" class="inner">
				<div class="container">
					<div class="row">
						<div class="col-md-8 center-block">
							<div class="info-404 text-center">
								<h2 class="primary-color inner-bottom-xs">404</h2>
								<p class="lead">We are sorry, the page you've requested is not available.</p>

								<div class="text-center">
									<a href="<%=request.getContextPath()%>/public/index" class="btn-lg huge"><i class="fa fa-home"></i> Go to Home Page</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>

			 <%@ include file="/templates/public/inc/footer.jsp" %>