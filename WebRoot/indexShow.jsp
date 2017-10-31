<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<script type="text/javascript" src="<%=basePath%>jquery/jquery-3.2.1.min.js "></script>
  	<!--顶部返回 -->
  	<script src="${pageContext.request.contextPath}/jquery/go-top/go-top.js"></script> 
  	<link href="${pageContext.request.contextPath}/css/go-top/go-top.css" rel="stylesheet" type="text/css" />
  	<!--热门游记-->
  	 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/blog/blog.css" />
  	<!--照片流  -->
  	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/fluent/hero-slider-style.css" />
  	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/fluent/magnific-popup.css" />
  	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/fluent/templatemo-style.css" />
 
  	<!--start slider -->
   <link href="${pageContext.request.contextPath}/css/index-css/style.css" rel='stylesheet' type='text/css' />  
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/index-js/jquery.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/index-js/bootstrap.min.js"></script>
 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index-css/fwslider.css" media="all">
    <script src="${pageContext.request.contextPath}/jquery/index-js/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/jquery/index-js/fwslider.js"></script>
 	
 	<!--引入首页的相关js和css  -->
	<link href="${pageContext.request.contextPath}/css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="${pageContext.request.contextPath}/css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" /> 
	 
 
	<style type="text/css">
		a:visited,a:active,a:focus{
			color:white;
			text-decoration: none;
	 	}
	 	 .inside a{
	 	 	color:#428bca;
	 	 }
	 	 .inside a:hover{
	 	 	color:  #41c074;
	 	 } 
	 	 article{
	 	 	float: left;
	 	 	margin: 0 10;
	 	 }
	 	  
	</style>
 
  </head>
 <body   >
<div class="header_bg">
<div class="container">
	<div class="header">
		<div class="logo" style="margin: 25px 0px 0px 0px;">
			<a href="<%=basePath%>index.jsp"><img style="margin-top: -35;" src="${pageContext.request.contextPath}/image/index-images/logo.png" alt=""/></a>
		</div>
		<div class="h_menu">
		<a id="touch-menu" class="mobile-menu" href="#">Menu</a>
		<nav>
		<ul class="menu list-unstyled">
			<li class="activate" ><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
			<li><a href="${pageContext.request.contextPath}/sport/showSportAll.action?category1.name=全部地区&category2.name=全部类别&category3=score">乡村</a></li>
			<li><a href="${pageContext.request.contextPath}/article/getArticleAll.action">见闻</a></li>
			<li><a href="${pageContext.request.contextPath}/recommend.action">为你推荐</a></li>
			<li><a href="${pageContext.request.contextPath}/userGetSpecialSchemeAll.action">特别策划</a></li>
			<li><a href="${pageContext.request.contextPath}/talk/getQuestionAll.action?category=1">秉烛夜谈</a></li>
 
			<c:choose>
				<c:when test="${empty (sessionScope.name)}">
					<li><a href="${pageContext.request.contextPath}/User/Login.jsp">登入/注册</a></li>
				</c:when>
				<c:otherwise>
					  <!-- 用户 -->
					  <li class="dropdown topbar-user" style="margin:0px 30px -20px 5px;">
					  <img style="width: 48px;height: 48px;" src="<%=basePath%>${sessionScope.img}" alt="" class="img-responsive img-circle"/>
					 	<ul class="list-unstyled" style="margin-top: 5px;"><!--说明session没有失效  -->
							 <li><a href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName=${sessionScope.name}">我的首页</a></li>
							 <li><a href="<%=basePath%>getUserUpdate.action?category=blog&userUpdateName=${sessionScope.name}">我的见闻</a></li>
							 <li><a href="<%=basePath%>getUserUpdate.action?category=question&userUpdateName=${sessionScope.name}">我的提问</a></li>
							 <li><a href="#">我的消息</a></li>
							 <li><a href="<%=basePath%>cancel.action">退出登入</a></li>
						 </ul>
		            </li>
            	</c:otherwise>
			</c:choose>
		</ul>
		</nav>
		</div>
		<div class="clearfix"></div>
	</div>
</div>
</div>
   <div id="fwslider"><!-- start slider -->
    <div class="slide_content"   > <!-- "  -->
               <header>
                     <div class="wrap-header">
								<h1 style="position: absolute;z-index: 3;margin-left: 20%;margin-top: 120">今夜偏知春气暖，虫声新透绿窗纱</h1>
								<span style="z-index: 3;position: absolute;margin: 220 0 0 -100;">去框住你的美</span>
								<center>
									<div class="search-form">
										<form target="_blank"  method="post" action="<%=basePath%>sport/searchContent.action?method=input" id="search" class="f-right">
											<input style="height: 40px;outline: 0;z-index: 3;position: absolute;margin: 220 0 0 -240;" name="value" type="text" size="40"  placeholder="我要知道..." />
											<input  type="submit"  value="Search"  style="border: 0;z-index: 3;position: absolute;margin: 220 0 0 150;">
									   </form>
									</div>
								</center>
								<div id="top-destination" style="margin: 17px auto 0px auto;display: inline-block;">
									<nav style="position: absolute;z-index: 3;margin: 220 0 0 -320;" >
										<ul>
											<c:forEach items="${tagList}" var="tagName" begin="0" end="8">
												<li><a target="_blank" href="<%=basePath%>sport/searchContent.action?method=tag&value=${tagName.tag}">${tagName.tag}</a></li>
 											</c:forEach>  
										</ul>
									</nav>
								</div>
							</div>
                </header>  
         </div>
        <div class="slider_container">
          
          <div class="slide"  > 
                <a target="_blank;"  href="<%=basePath %>sport/getSportDetial.action?sport.id=20"> 
                 	<img  height="720" src="${pageContext.request.contextPath}/image/index-images/slider1.jpg">
            	</a>
            </div>  
            
             <div class="slide">
             	 <a target="_blank;"  href="<%=basePath %>sport/getSportDetial.action?sport.id=38">
                	<img  height="720" src="${pageContext.request.contextPath}/image/index-images/slider2.jpg">
            	 </a>
            </div> 
            
             <div class="slide">
             	 <a target="_blank;"  href="<%=basePath %>sport/getSportDetial.action?sport.id=35">
                	<img  height="720" src="${pageContext.request.contextPath}/image/index-images/slider5.jpg">
            	 </a>
            </div>   
          
        </div>
 
         <div class="timers"></div>
        <div class="slidePrev"><span></span></div>
        <div class="slideNext"><span></span></div> 
    </div>  
    <!--/slider -->
     
    <br>
   
    <ul class="cd-hero-slider" style="background:  #f0f0f0; height: auto;" >
                <li class="selected" style="background:  #f0f0f0;height: 900px;;">                    
                    <!-- <div class="cd-full-width" style="margin-left: 270px;height: auto;">
                        <div class="container-fluid js-tm-page-content" data-page-no="1" data-page-type="gallery" > 
                            <div class="tm-img-gallery-container" style="height: auto;margin-left: 35%;margin-top: 5%;">-->
                          <div class="tm-img-gallery gallery-one" style="margin-left: 35%;margin-top:5%;width:58%;">
                                <!-- Gallery One pop up connected with JS code below -->     <!--margin: 0 30px;  -->
                                    <div class="grid-item" style="width: 40%;height: 360px;margin-left:-40%; background-image: url(<%=basePath%>image/index-images/custom.jpg)">
                                        <figure class="effect-sadie">
                                            <img style="height: 360px;"  class="img-fluid tm-img">
                                            <figcaption>
                                                <h2 class="tm-figure-title"><span><strong>民族风情</strong></span></h2>
                                                <p class="tm-figure-description">
													那里有酒香四溢、节庆欢喜,那里的民族风情多姿多彩,那里的自然景观奇异独特,去过,便是一场难忘而美妙的旅行
												</p>
                                                <a href="<%=basePath %>sport/showSportAll.action?category1.name=全部地区&category2.name=民族风情&category3=score">View more</a>
                                            </figcaption>           
                                        </figure>
                                    </div><!-- margin-right: 30px; -->
                                    <div class="grid-item" style="width: 40%;height: 360px; margin:0 3%;  background-image: url(<%=basePath%>image/index-images/history.jpg) ">
                                        <figure class="effect-sadie">
                                            <img style="height: 360px;" class="img-fluid tm-img">
                                            <figcaption>
                                                <h2 class="tm-figure-title"><span><strong>人文历史</strong></span></h2>
                                                <p class="tm-figure-description">
                                                	在历史的时间线上，村落一直努力耀眼着自己的人文气息，这里的见证过历史的砖瓦，一砖一墙无不让你心境澄澈
                                                </p>
                                                <a href="<%=basePath %>sport/showSportAll.action?category1.name=全部地区&category2.name=人文历史&category3=score">View more</a>
                                            </figcaption>
                                        </figure>
                                    </div>
                                   <div class="grid-item"  style=" width: 40%;height: 360px; background-image: url(<%=basePath%>image/index-images/leisure.jpg) ">
                                        <figure class="effect-sadie">
                                            <img style="height: 360px;"   class="img-fluid tm-img">
                                            <figcaption>
                                                <h2 class="tm-figure-title"><span><strong>田园休闲</strong></span></h2>
                                                <p class="tm-figure-description">
                                                	都市低沉的高楼和厚重的空气不断的逼入你的眼和呛进你的肺，这里还你应得的沙提，浅草，绿荫，暖树，孤山...
                                                </p>
                                                <a href="<%=basePath %>sport/showSportAll.action?category1.name=全部地区&category2.name=田园休闲&category3=score">View more</a>
                                            </figcaption>           
                                        </figure>
                                    </div>
                                   <br>  <!-- margin: 30px 100px; -->
                          	 <div class="grid-item"  style="width: 23%;height: 360px;    position: absolute;   margin-left: -15%;margin-top: 370;    background-image: url(${pageContext.request.contextPath}/image/index-images/health.jpg) ">
                                        <figure class="effect-sadie">
                                            <img style="height: 360px;"  class="img-fluid tm-img">
                                            <figcaption>
                                                <h2 class="tm-figure-title"><span><strong>健康生态</strong></span></h2>
                                                <p class="tm-figure-description">
                                                	自然，宇宙，地球，一切都是让人自卑人类的渺小。然而，渺小和伟大真的孰优孰劣吗？真的需要互相一争高下吗？
                                                </p>
                                                <a href="<%=basePath %>sport/showSportAll.action?category1.name=全部地区&category2.name=健康生态&category3=score">View more</a>
                                            </figcaption>           
                                     </figure>
                        	</div> 
                        	 <div class="grid-item" style="width: 40%;height: 360px; margin: 30px 20%;background-image: url(${pageContext.request.contextPath}/image/index-images/hill.jpg)">
                                        <figure class="effect-sadie">
                                            <img style="height: 360px;" class="img-fluid tm-img">
                                            <figcaption>
                                                <h2 class="tm-figure-title"><span><strong>山青水绿</strong></span></h2>
                                                <p class="tm-figure-description">
                                                	没有什么比这青山绿水更能让人接近自己了，一切都被抹上一层浓厚的墨绿，将自己置身其间，和自己不期而遇
                                                </p>
                                                <a href="<%=basePath %>sport/showSportAll.action?category1.name=全部地区&category2.name=山青水绿&category3=score">View more</a>
                                            </figcaption>           
                                        </figure>
                               </div>  
    					</div>
    					<!-- </div>
    				</div>
    			</div> -->
			</li>
				 </section>
    <div style="margin-top: -5%; text-align: center;">
     	<a href="<%=basePath%>sport/showSportAll.action?category1.name=全部地区&category2.name=全部类别&category3=score"  class="button">查看更多</a>
	</div>		
  </ul>
 
    <!--特别推荐  -->
    	<div class="sap_tabs" style=" background: #f0f0f0;margin-top: 20;">
			<div class="container">
			<label class="line"> </label>
			<h2>热门推荐</h2>
						 <div id="horizontalTab" style="display: block; width: 100%; margin: 0px;">
						  <ul class="resp-tabs-list">
						  	  <li class="resp-tab-item" aria-controls="tab_item-0" role="tab"><span>当季热点</span></li>
							  <li class="resp-tab-item" aria-controls="tab_item-1" role="tab"><span>编辑推荐</span></li>
							  <li class="resp-tab-item" aria-controls="tab_item-2" role="tab"><span>最爱乡村</span></li>
							  <div class="clearfix"></div>
						  </ul>				  	 
							<div class="resp-tabs-container">
							    <div class="tab-1 resp-tab-content" aria-labelledby="tab_item-0">
									<div class="tab_img">
									  <div class="img-top simpleCart_shelfItem">
										   <a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=61">	
					   		  			   <img src="../image/index-images/body12.jpg" class="img-responsive"  />
												 <div class="tab_desc">
													<div class="agency ">
														<div class="agency-left">
															<h6 class="jean">江西婺源——油菜烂漫</h6>
															<div class="clearfix"> </div>
														</div>
													 </div>
												  </div>
											  </a>
										
										</div>
										<div class="img-top simpleCart_shelfItem">
										   <a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=37">	
					   		  			   <img src="../image/index-images/body13.jpg" class="img-responsive" alt=""/>
												 <div class="tab_desc">
													<div class="agency ">
														<div class="agency-left">
															<h6 class="jean">湖南湘西凤凰——再读《边城》</h6>
															<%-- <span class="dollor item_price"></span> --%>
															<div class="clearfix"> </div>
														</div>
														 
													 </div>
												  </div>
											  </a>
										
										</div>

									     <div class="img-top simpleCart_shelfItem">
										   <a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=14">	
					   		  			   <img src="../image/index-images/body32.jpg" class="img-responsive" alt=""/>
												 <div class="tab_desc">
													<div class="agency ">
														<div class="agency-left">
															<h6 class="jean">江西景德镇——陶瓷魅力</h6>
															<div class="clearfix"> </div>
														</div>
														 
													 </div>
												  </div>
											  </a>
										
										</div>
											 
							    	 </div> 	        					 
						  		</div>
						  		<div class="tab-1 resp-tab-content" aria-labelledby="tab_item-0">
									<div class="tab_img">
									  <div class="img-top simpleCart_shelfItem">
										   <a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=41">	
					   		  			   <img src="../image/index-images/body21.jpg" class="img-responsive" alt=""/>
												 <div class="tab_desc">
													<div class="agency ">
														<div class="agency-left">
															<h6 class="jean">贵州西江千户苗寨——民族风情</h6>
															<div class="clearfix"> </div>
														</div>
														 
													 </div>
												  </div>
											  </a>
										
										</div>
										<div class="img-top simpleCart_shelfItem">
										   <a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=16">		
					   		  			   <img src="../image/index-images/body22.jpg" class="img-responsive" alt=""/>
												 <div class="tab_desc">
													<div class="agency ">
														<div class="agency-left">
															<h6 class="jean">福建培田古村——明清建筑文化</h6>
															<div class="clearfix"> </div>
														</div>
														 
													 </div>
												  </div>
											  </a>
										
										</div>

									     <div class="img-top simpleCart_shelfItem">
										   <a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=9">		
					   		  			   <img src="../image/index-images/body23.jpg" class="img-responsive" alt=""/>
												 <div class="tab_desc">
													<div class="agency ">
														<div class="agency-left">
															<h6 class="jean">浙江乌镇——江南水乡</h6>
															<div class="clearfix"> </div>
														</div>
														 
													 </div>
												  </div>
											  </a>
										
										</div>
											 
							    	 </div> 	        					 
						  		</div>
						  			<div class="tab-1 resp-tab-content" aria-labelledby="tab_item-0">
									<div class="tab_img">
									  <div class="img-top simpleCart_shelfItem">
										   <a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=34">	
					   		  			   <img src="../image/index-images/body31.jpg" class="img-responsive" alt=""/>
												 <div class="tab_desc">
													<div class="agency ">
														<div class="agency-left">
															<h6 class="jean">云南元阳——仰望天梯</h6>
															<div class="clearfix"> </div>
														</div>
														 
													 </div>
												  </div>
											  </a>
										
										</div>
										<div class="img-top simpleCart_shelfItem">
										   <a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=63">		
					   		  			   <img src="../image/index-images/body11.jpg" class="img-responsive" alt=""/>
												 <div class="tab_desc">
													<div class="agency ">
														<div class="agency-left">
															<h6 class="jean">四川稻城——最后的净土</h6>
															<div class="clearfix"> </div>
														</div>
														 
													 </div>
												  </div>
											  </a>
										
										</div>

									     <div class="img-top simpleCart_shelfItem">
										   <a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=5">		
					   		  			   <img src="../image/index-images/body33.jpg" class="img-responsive" alt=""/>
												 <div class="tab_desc">
													<div class="agency ">
														<div class="agency-left">
															<h6 class="jean">诸葛八卦村——诫子书的文化</h6>
															<div class="clearfix"> </div>
														</div>
														 
													 </div>
												  </div>
											  </a>
										
										</div>
											 
							    	 </div> 	        					 
						  		</div>		
                  </div>
          </div>
         </div>
	</div>
	
	 <!-- 热门博客 -->		 
	 <section id="news" class="single-page scrollblock" style="background:#f0f0f0;margin-top: 20;"  >
      	<div class="container" >
        	<div class="align">
        		<i class="icon-pencil-circled"></i>
        	</div>
       		<h1>Our Blog</h1>
        	<!-- 文章列表 -->
        	<div class="row"   >
          		<c:forEach var="article" items="${listAritcle}" >
          			<article class="span4 post"  style="width:30%;" >
          				<a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${article.id}">
          					<img   class="img-news" src="<%=basePath%>${article.cover}" alt="">
            			</a>
            			<div class="inside" style="height: 250;overflow:hidden;">
            				<a href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${article.id}"> 
              			   	  <h2>${article.title}</h2>
              			    </a>
	              			  <div class="entry-content">
	                			<p style="height: 96px;">${fn:substring(article.content,0,140)}...</p>
	                			 
	                		 </div>
            			</div>
          			</article>	
          		</c:forEach>
            </div>
 		 </div>
 		 <div style="margin: 0 auto; text-align: center; "  >
     		<a href="<%=basePath%>article/getArticleAll.action"  class="button">查看更多</a>
		</div>
    </section>
    	 
	<!--返回顶部  -->
	<a href="#0" class="cd-top">Top</a>
	
<link href="<%=basePath%>css/index-show-recommend/style.css" rel="stylesheet" type="text/css" media="all" />	 
<script src="<%=basePath%>css/index-show-recommend/easyResponsiveTabs.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
		   $('#horizontalTab').easyResponsiveTabs({
				 type: 'default',            
				  width: 'auto',  
				   fit: true   
				 });
		 });
	</script>	 
 
 </body>
</html>
