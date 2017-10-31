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
	 <link href="<%=basePath%>css/user-home/user-home.css" rel='stylesheet' type='text/css' />
 	<link href="<%=basePath%>css/recommend-for-you/recommend-for-you.css" rel='stylesheet' type='text/css' />
	<!--顶部返回 -->
  	<script src="<%=basePath%>jquery/go-top/go-top.js"></script> 
  	<link href="<%=basePath%>css/go-top/go-top.css" rel="stylesheet" type="text/css" />
  	<!-- 搜索框 -->
	<link href="<%=basePath%>css/search/search.css" rel='stylesheet' type='text/css' />
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"> 
	<!--引入基本样式（头）  -->
	<link href="<%=basePath%>css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="<%=basePath%>css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" /> 
	<!-- 搜索框 -->
	<link href="../css/search/search.css" rel='stylesheet' type='text/css' />
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">	
 
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/sweetalert/sweetalert.min.js "></script>
   <link rel="stylesheet" href="<%=basePath%>css/sweetalert/sweetalert.css">
	
	<style type="text/css">
 
		a,a:link,a:hover,a:focus {
    		text-decoration: none;
    		color:inherit;
    		cursor: auto;
		}
	</style>
 
  </head>
		
<body style="background: #f2f4f6;">
<div class="header_bg" style="background: #b3e5e1;">
<div class="container">
	<div class="header"  style="height: 10px; margin-top: -30;">
		<div class="logo" >
			<a href="<%=basePath%>index.jsp"><img style="width: 120;margin-left: 60;   margin-top: -10;" src="<%=basePath%>image/index-images/logo.png" alt=""/></a>
		</div>
		<div class="h_menu">
		<a id="touch-menu" class="mobile-menu" href="#">Menu</a>
		<nav>
		<ul class="menu list-unstyled">
			<li  ><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
			<li><a href="${pageContext.request.contextPath}/sport/showSportAll.action?category1.name=全部地区&category2.name=全部类别&category3=score">乡村</a></li>
			<li><a href="${pageContext.request.contextPath}/article/getArticleAll.action">见闻</a></li>
			<li  class="activate" ><a href="${pageContext.request.contextPath}/recommend.action">为你推荐</a></li>
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
<!--下面是内容-->
<div class="zhi page-roundtable page-roundtable-list">
	<main class="pure-g receptacle" >
		<section class="page-content-main pure-u-1 pure-u-md-17-24" style="width: 732px;" >
			<div class="unit-inner">
				<div class="pure-g roundtable-list">
				<c:forEach items="${recommendSport}" var="sport">
					<div class="pure-u-1 pure-u-md-1-3 item">
						<div class="content">
							<a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=${sport.id}" class="item-link"
								 style="background-image:url(${sport.cover})">
								<span class="mask">
									<%-- <span class="mask-fallback"></span> --%>
									<img src="${sport.cover}" width="200" height="200" class="avatar">
									<span class="name">${sport.name}</span>
								</span>
							</a>
							<span class="visits">${fn:substring(sport.summary,0,50)}...</span>
						</div>
					</div>
 				</c:forEach>	
 				<c:forEach items="${recommendArticle}" var="article">
					<div class="pure-u-1 pure-u-md-1-3 item">
						<div class="content">
							<a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${article.id}" class="item-link"
								 style="background-image:url(<%=basePath%>${article.cover})">
								<span class="mask">
									<%-- <span class="mask-fallback"></span> --%>
									<img src="<%=basePath%>${article.cover}" width="200" height="200" class="avatar">
									<span class="name">${article.title}</span>
								</span>
							</a>
							<span class="visits">${fn:substring(article.content,0,50)}...</span>
						</div>
					</div>
 				</c:forEach>
				</div>
			</div>
			<div class="Pagination" style="background-color: white;width: 685px;">
				  	 	 <button class="Button PaginationButton PaginationButton-prev Button--plain" type="button">上一页</button>
				  	 	 <c:if test="${currentPage != 1}">
				  	 	 	<button class="Button PaginationButton Button--plain">1</button>
				  	 	 </c:if>
				  	 	 <c:if test="${currentPage - 1 >= 3}">
				  	 	 	<span class="PaginationButton PaginationButton--fake">...</span>
				  	 	 </c:if>	
				  	 	 <c:if test="${currentPage - 1 >= 2}">
				  	 	 	<button class="Button PaginationButton Button--plain">${currentPage - 1}</button>
				  	 	 </c:if>	
				  	 	 <button class="Button PaginationButton  Button--plain">${currentPage}</button>
				  	 	 <c:if test="${currentPage + 1 < totalPage}">	
				  	 	 	<button class="Button PaginationButton Button--plain">${currentPage + 1}</button>
				  	 	 </c:if>
				  	 	 <c:if test="${totalPage - currentPage >= 3}">
				  	 	  	<span class="PaginationButton PaginationButton--fake">...</span>
				  	 	  </c:if>
				  	 	  <c:if test="${totalPage != currentPage}">
				  	 	  		<button class="Button PaginationButton Button--plain">${totalPage}</button>
				  	 	  </c:if>
				  	 	  <button class="Button PaginationButton PaginationButton-prev Button--plain" type="button">下一页</button> 	 	 
			</div>  	 
		
		</section>
		<aside class="page-sidebar pure-u-1 pure-u-md-7-24" style="width:272; " >
			<div class="unit-inner">
				<div class="module organizations">
					<div class="module-header">
						<h5>可能感兴趣的人</h5>
						<img id="img"  style="margin: -34 10 0 0;float:right;"src="<%=basePath%>image/switch.png" width="30" height="30" >
						<a id="switch" href="javascript:void(0);">
							<span style="float:right;margin: -27 55 0 0;" >换一换</span>
						<a>
					</div>
					<div class="module-body">
						<ul class="items">
						 <c:forEach var="user" items="${recommendUser}">
							<li class="item" style="margin-left: -30px;">
								<div class="item-header">
									<a target="_blank" class="item-link" href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName=${user.username}" >
										<img class="avatar d50" src="<%=basePath%>${user.avatar}">
									</a>
									<div class="content">
										<a class="name">${user.username}</a>
										<div class="bio">${fn:substring(user.individualSignature,0,10)}</div>
									</div>
								</div>
							</li>
						</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</aside>
	</main>	
</div>
 <!--返回顶部  -->
<a href="#0" class="cd-top">Top</a>

<script type="text/javascript">
	var i = 0 ;
	var startCount = '${fn:length(recommendUser)}';//最开始有的长度
	var count = 0;
	var size = 7;//每次加载回来的数量
	var startRow = Number(startCount);
	$(document).ready(function(){
		$('#switch').click(function(){
		  	
		   	i++;
          	document.getElementById("img").style.transform="rotate("+ i*90+"deg)"; 
     		//换一换
			 
		   var url = '<%=basePath%>' + 'recommendUserMore.action';
		   var ar = {"startRow" : startRow, "size" : 7};
		   var args = JSON.stringify(ar);
		   var result = '';
		   $.post(url, {json : args},
					function(data){
						for(var i = 0; i < data.length; i++) {							
							result += '<li class="item" style="margin-left: -30px;">' +
											'<div class="item-header">' +
													'<a target="_blank" class="item-link" href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName=' + data[i].username + '">' +
														'<img class="avatar d50" src="<%=basePath%>'+ data[i].avatar +'">' +
													 '</a>' +
													 '<div class="content">' +
													 	'<a class="name">'+ data[i].username +'</a>' +
													 		'<div class="bio">' + data[i].individualSignature.substr(0,10) +'</div>' +	
													 '</div></div></li>' ;
													 		
						}
						$('.items li').remove();
						$('.items').append(result); 
						count++;
 						startRow = Number(startCount) + Number(count) * Number(size); 
					}
			 ,"json");
				
		});
 
	});
	
	var currentPage = Number('${currentPage}');
	//翻页
	$(function(){
		//设置当前页
		$('.Pagination .Button').each(function(){
			if($(this).text() == '${currentPage}') {
				$(this).css('color', '#76c7c0');
			}
		});
		
		//点击事件
		$('.Pagination .Button').click(function(){
			
			if($(this).text() != '${currentPage}') {
					
					if($(this).text() == '上一页' && currentPage != 1){
						 currentPage = currentPage - 1;
					}else if($(this).text() == '下一页' && Number('${totalPage}') != currentPage){
						 currentPage = currentPage + 1;
					}else if($(this).text() != '上一页' && $(this).text() != '下一页'){
						currentPage = Number($(this).text());
					}else {
						return false;
					}
				window.location.href='<%=basePath%>' + 'recommend.action?currentPage=' + currentPage;
			}
		});
	});
 
</script>
 
</body>	

</html>


