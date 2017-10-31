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
  	
  	<link rel="stylesheet" type="text/css" href="<%=basePath%>SpecialScheme/css/specialScheme.css">
  	<!--顶部返回 -->
  	<script src="<%=basePath%>jquery/go-top/go-top.js"></script> 
  	<link href="<%=basePath%>css/go-top/go-top.css" rel="stylesheet" type="text/css" />
  	<!-- 搜索框 -->
	<link href="<%=basePath%>css/search/search.css" rel='stylesheet' type='text/css' />
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"> 
	<!--引入基本样式（头）  -->
	<link href="<%=basePath%>css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="<%=basePath%>css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" /> 	
 
  	<!--start slider -->
   <link href="<%=basePath%>css/index-css/style.css" rel='stylesheet' type='text/css' />  
   <script type="text/javascript" src="<%=basePath%>jquery/index-js/jquery.min.js"></script>
 
    <link rel="stylesheet" href="<%=basePath%>css/index-css/fwslider.css" media="all">
    <script src="<%=basePath%>jquery/index-js/jquery-ui.min.js"></script>
    <script src="<%=basePath%>jquery/index-js/fwslider.js"></script>
 	
 	<!--引入首页的相关js和css  -->
	<link href="<%=basePath%>css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="<%=basePath%>css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" /> 
	
	<!--sweetalert  -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/sweetalert/sweetalert.min.js "></script>
   <link rel="stylesheet" href="<%=basePath%>css/sweetalert/sweetalert.css">
	
	<style type="text/css">
		 a:link, a:visited,a:active,a:focus{
			color: #636363;
			text-decoration: none;
	 	} 
 
	</style>
 
  </head>
 <body   >
<div class="header_bg" style="background: #b3e5e1;">
<div class="container">
	<div class="header"  style="height: 10px; margin-top: -30;">
		<div class="logo">
			<a href="<%=basePath%>index.jsp"><img style="width: 120;margin-left: 60;    margin-top: -20;" src="<%=basePath%>image/index-images/logo.png" alt=""/></a>
		</div>
		<div class="h_menu">
		<a id="touch-menu" class="mobile-menu" href="#">Menu</a>
		<nav>
		<ul class="menu list-unstyled">
			<li  ><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
			<li ><a href="${pageContext.request.contextPath}/sport/showSportAll.action?category1.name=全部地区&category2.name=全部类别&category3=score">乡村</a></li>
			<li><a href="${pageContext.request.contextPath}/article/getArticleAll.action">见闻</a></li>
			<li><a href="${pageContext.request.contextPath}/recommend.action">为你推荐</a></li>
			<li class="activate"><a href="${pageContext.request.contextPath}/userGetSpecialSchemeAll.action">特别策划</a></li>
			<li><a href="${pageContext.request.contextPath}/talk/getQuestionAll.action?category=1">秉烛夜谈</a>
			 
			</li>
			 
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
			<li >
				<div class="search bar7" style="margin: auto 0;" >
					<form action="<%=basePath%>sport/searchContent.action?method=input" method="post" >
						<input name="value" type="text" placeholder="请输入您要搜索的内容...">
						<button type="submit"></button>
					</form>
				</div>
			</li>
		</ul>
		</nav>
		</div>
		<div class="clearfix"></div>
	</div>
</div>
</div> 
  <!-- start slider -->
     <div id="fwslider" style="height:350px;">
        <div class="slider_container">
            <div class="slide"> 
                  <a target="_blank" href="<%=basePath%>userGetSpecialSchemeDetail.action?specialScheme.id=1"> 
                    <img style="height:400px;" src="<%=basePath%>image/index-images/special-scheme1.jpg">
                  </a>
                <div class="slide_content" style="    margin-top: 5%;">
                    <div class="slide_content_wrap">
                        <!-- Text title -->
                        <h4 class="title" style="font-size: 2.5em;">
                        	碧江静淌吻蓝天，云舞娇姿搂翠山</h4>
                        <p class="description">白云朵朵，溪流淙淙，一片纯净而神秘的疆土</p>
                    </div>
                </div>
            </div>
            <div class="slide">
                <a target="_blank" href="<%=basePath%>userGetSpecialSchemeDetail.action?specialScheme.id=3"> 
                    <img style="height:400px;" src="<%=basePath%>image/index-images/special-scheme2.jpg">
                </a>
                <div class="slide_content" style="    margin-top: 5%;">
                    <div class="slide_content_wrap">
                        <h4 class="title" style="font-size: 2.5em;">
                        	谁言无梦至此，我自踏步来寻</h4>
                        <p class="description">你是因为魂牵梦绕才行至徽州？还是因为无梦所想才踏步来寻？</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="timers"></div>
        <div class="slidePrev"><span></span></div>
        <div class="slideNext"><span></span></div>
    </div>
 <!--下面是特别策划展示 -->	 
	<div class="header_title title">
        <div class="header_title_img"></div>
    </div>
 <!--活动内容  -->   
    <div class="subject_set">
    		<div id="subject_cards_set" class="subject_cards_set">
    			<ul id="card_list" class="subject_cards clearfix">
    				<c:forEach items="${specialSchemeList}" var="scheme" >
    				<li>
    					<a href="<%=basePath%>userGetSpecialSchemeDetail.action?specialScheme.id=${scheme.id}" target="_blank">
    						<div class="subject_card web">
    							<img  src="${scheme.page1}" class="subject_card_img">
    							<div class="subject_card_footer clearfix">
    								<div class="subject_card_words fl">
    									${scheme.title}
    								</div>
    							</div>
    						</div>
    					</a>
    				</li>
    				</c:forEach>	
 
    			</ul>
    		</div>
    </div>	  
<!--下面是分页  -->   
<c:if test="${!empty (specialSchemeList)}">	 
<div class="cards_pages_bar">
	<div class="cards_pages" >
		<ul id="cards_pages">
			<ul>
             <c:choose> 
	              <c:when test="${currentPage != 1}">
		              <li>
		              	<a href="<%=basePath%>userGetSpecialSchemeAll.action?currentPage=${currentPage-1}">上一页 </a>
		              </li>
	              </c:when>
	              <c:otherwise>
	              	   <li >
		              	 上一页  
		              </li>
	              </c:otherwise>
              </c:choose>
              <c:if test="${currentPage != 1}">
              	 <li>	
				   <a href="<%=basePath%>userGetSpecialSchemeAll.action?currentPage=1">1</a>
				 </li>     
			  </c:if>
               <c:if test="${currentPage - 1 >= 3}">
               		<li > ...</li>	
               </c:if>
               <c:if test="${currentPage - 1 >= 2}">
               		<li > <a href="<%=basePath%>userGetSpecialSchemeAll.action?currentPage=${currentPage - 1}">${currentPage - 1}</a> </li>
               </c:if>
              <li class="active" > ${currentPage} </li>
              <c:if test="${currentPage + 1 < totalPage}">	
               		<li >
               			<a href="<%=basePath%>userGetSpecialSchemeAll.action?currentPage=${currentPage + 1}" >${currentPage + 1}</a>
               		</li>
               </c:if>
               <c:if test="${totalPage - currentPage >= 3}">
               		<li>
               			 ... 
               		</li>	
               </c:if>
               <c:if test="${totalPage != currentPage}">
				  	 <li><a href="<%=basePath%>userGetSpecialSchemeAll.action?currentPage=${totalPage}"  >${totalPage}</a></li>
			   </c:if>
			    <c:choose> 
	              <c:when test="${currentPage != totalPage }">
		              <li>
		              	<a href="<%=basePath%>userGetSpecialSchemeAll.action?currentPage=${currentPage+1}" > 下一页</a>
		              </li>
	              </c:when>
	              <c:otherwise>
	              	   <li  >
		              	 下一页 
		              </li>
	              </c:otherwise>
              </c:choose>     
            </ul>
         </ul>
	</div>
</div>
</c:if> 
<!--返回顶部  -->
<a href="#0" class="cd-top">Top</a>
	
 
 
 </body>
</html>
