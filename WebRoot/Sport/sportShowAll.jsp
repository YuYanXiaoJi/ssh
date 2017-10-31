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
  	<script src="<%=basePath%>jquery/go-top/go-top.js"></script> 
  	<link href="<%=basePath%>css/go-top/go-top.css" rel="stylesheet" type="text/css" />
	<!-- 分页 -->
	<link rel="stylesheet" href="../css/pagination/style.css">
	<!-- 搜索框 -->
	<link href="<%=basePath%>css/search/search.css" rel='stylesheet' type='text/css' />
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"> 
	<!--引入展示乡村的样式  -->
	<link rel="stylesheet" href="<%=basePath%>css/sport-show/animate.css">
	<link rel="stylesheet" href="<%=basePath%>css/sport-show/bootstrap.css">
	<link rel="stylesheet" href="<%=basePath%>css/sport-show/flexslider.css">
	<link rel="stylesheet" href="<%=basePath%>css/sport-show/style.css">
	<script src="<%=basePath%>jquery/sport-show/modernizr-2.6.2.min.js"></script>
	
	<!--引入基本样式（头）  -->
	<link href="<%=basePath%>css/index-css/bootstrap.min.css" rel='stylesheet' type='text/css' />
	<link href="<%=basePath%>css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="<%=basePath%>css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" /> 
 	
 	<style type="text/css">
 		.tt {
 			margin-top:40px; 
 		}
 	</style>
 
<script type="text/javascript">
	
	var c1 = '${category1.name}';//地区
	var c2 = '${category2.name}';//类型
	var c3 = '${category3}';//排序方式
	//滚轮下趁一点
	$(document).ready(function(){
		if('${isToEnd}' == 'true'){
			$(function(){ window.location.hash = "#best-deal"; });
		}
	});
	
	//监听是否出现新筛选
	$(function(){
		$(".filter").click(function(){
			 $($(this).parent().siblings().children()).removeClass('active');
			 $(this).addClass('active');
			 if($(this).hasClass('theme')){
			 	 c2 = $(this).prop('id');
			 }else if($(this).hasClass('district')){
			 	  c1 = $(this).prop('id');
			 }else if($(this).hasClass('sort')){
			 	  c3 = $(this).prop('id'); 
			 }
			var action = '<%=basePath%>'+'sport/showSportAll.action?category1.name='
			     + c1 + '&category2.name=' + c2 + '&category3=' +c3 +'&isToEnd=true';
		    location.href = action;
			 
		});	
	});
 
	//对筛选的按钮激活
	$(document).ready(function(){
		
		$("#"+c1).addClass('active');
		$("#"+c2).addClass('active');
		$("#"+c3).addClass('active');
		 
	});
 
	
	//分页操作
	function paginationPage(method,currentPage){
		 if(method != 'currentPage'){
		 	var action = '<%=basePath%>'+'sport/showSportAll.action?category1.name='
			     + c1 + '&category2.name=' + c2 + '&category3=' +c3 +'&pagerMethod='+method
			     +'&currentPage=' +'${currentPage}'	+'&isToEnd=true';
		    location.href = action;
		 }else{
		 	var action = '<%=basePath%>'+'sport/showSportAll.action?category1.name='
			     + c1 + '&category2.name=' + c2 + '&category3=' +c3 + 
			     '&currentPage=' + currentPage	+'&isToEnd=true';
		    location.href = action;
		 }
		 
		 
	}
  
</script>
 
</head>  

<body>
<div class="header_bg">
<div class="container">
	<div class="header">
		<div class="logo">  
			<a href="<%=basePath%>index.jsp"><img style="margin-top: -30;            width: 120;margin-left: 60; position: relative;" src="../image/index-images/logo.png" alt=""/></a>
		</div>
		<div class="h_menu">
		<a id="touch-menu" class="mobile-menu" href="#">Menu</a>
		<nav>
		<ul class="menu list-unstyled">
			<li  ><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
			<li class="activate"><a href="${pageContext.request.contextPath}/sport/showSportAll.action?category1.name=全部地区&category2.name=全部类别&category3=score">乡村</a></li>
			<li><a href="${pageContext.request.contextPath}/article/getArticleAll.action">见闻</a></li>
			<li><a href="${pageContext.request.contextPath}/recommend.action">为你推荐</a></li>
			<li><a href="${pageContext.request.contextPath}/userGetSpecialSchemeAll.action">特别策划</a></li>
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
<!-- start main -->
<div class="main_bg">
<div class="container">
	<div class="main_grid1">
		<h3 class="style pull-left">our Portfolios</h3>
		<ol class="breadcrumb pull-right">
		  <li><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
		  <li class="active">乡村</li>
		</ol>
		<div class="clearfix"></div>
	</div>
</div>
</div>
<!-- start main_btm -->
<div class="main_btm1">
<div class="container">
	<div class="portfolio_main">
						<ul id="filters" class="clearfix" >
							<span style=" font-family: 'Aclonica';font-size: 22px;">主题</span>
							 &nbsp;&nbsp;&nbsp;
							 <li>
								<span class="filter theme" id="全部类别">全部类别</span>
							</li>
							 <li>
								<span class="filter theme" id="人文历史">人文历史</span>
							</li>
							<li>
								<span class="filter theme" id="山青水绿">山青水绿</span>
							</li>
							<li>
								<span class="filter theme" id="田园休闲">田园休闲</span>
							</li>
							<li>
								<span class="filter theme" id="健康生态">健康生态</span>
							</li>
							<li>
								<span class="filter theme" id="民族风情">民族风情</span>
							</li>
						</ul>
						<ul id="filters" class="clearfix">
							<span style=" font-family: 'Aclonica';font-size: 22px;">排序</span>
							 &nbsp;&nbsp;&nbsp;
							<li>
								<span class="filter sort" id="score">推荐</span>
							</li>
							<li>
								<span class="filter sort" id="wantCount">最多想去</span>
							</li>
							<li>
								<span class="filter sort" id="commentCount">最多评论</span>
							</li>
							<li>
								<span class="filter sort" id="pageViewCount">最多浏览</span>
							</li>
 
						</ul>
						<ul id="filters" class="clearfix" style="margin-top: -20px;">
							<span style=" font-family: 'Aclonica';font-size: 22px;"  >地区</span>
							 &nbsp;&nbsp;&nbsp;
							<li>
								<span class="filter district" id="全部地区">全部地区</span>
							</li>
							<li>
								<span class="filter district" id="浙江">浙江</span>
							</li>
							<li>
								<span class="filter district" id="云南">云南</span>
							</li>
							<li>
								<span class="filter district" id="贵州">贵州</span>
							</li>
							<li>
								<span class="filter district" id="四川">四川</span>
							</li>
							<li>
								<span class="filter district " id="江苏">江苏</span>
							</li>		
							<li>
								<span class="filter district" id="广东">广东</span>
							</li> 
							<li class="tt">
								<span class="filter district" id="江西">江西</span>
							</li>
							<li class="tt">
								<span class="filter district" id="福建" >福建</span>
							</li>
							<li class="tt">
								<span class="filter district" id="安徽">安徽</span>
							</li>
							 
							<li class="tt">
								<span class="filter district" id="广西">广西</span>
							</li>
							<li class="tt">
								<span class="filter district" id="湖南">湖南</span>
							</li>
							<li class="tt">
								<span class="filter district" id="辽宁">辽宁</span>
							</li>
							<li class="tt">
								<span class="filter district" id="新疆">新疆</span>
							</li>
							<li class="tt">
								<span class="filter district" id="河南"  >河南</span>
							</li  >
 							<li class="tt">
								<span class="filter district" id="其他"  >其他</span>
							</li>
						</ul>
		</div>
	</div>
</div> 
<!-- 展示乡村 -->
	<div id="best-deal">
		<div class="container">
			<div class="row">
 				<c:forEach var="sport" items="${list}">
				<div class="col-md-4 item-block animate-box" data-animate-effect="fadeIn">
                   <div class="fh5co-property">
						<figure>
							<a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=${sport.id}">
								<img style="height: 270px;" src=" ${sport.cover}"  class="img-responsive">
							</a>
						</figure>
						<div class="fh5co-property-innter" style="overflow: hidden;">
							<h3><a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=${sport.id}">
								${sport.name}
							</a></h3>
		               		<p style="height: 140px;">${sport.summary}</p>
	            		</div>
	            	<p class="fh5co-property-specification">
	            		<span>
	            			<strong>${sport.pageViewCount}</strong>
	            		   &nbsp; 
	            		   <img src="../image/view-count.png" style="width: 20px;height: 20px; display:inline;"  > 
	            		</span> 
	            		<span>
	            			<strong>${sport.wantCount}</strong>
	            		   &nbsp; 
	            		   <img src="../image/want-go.png" style="width: 20px;height: 20px; display:inline;"  > 
	            		</span> 
	            		<span>
	            			<strong>${sport.commentCount}</strong>
	            		   &nbsp; 
	            		   <img src="../image/answer-count.png" style="width: 20px;height: 20px; display:inline;"  > 
	            		</span> 	 
	            	</p>
					</div>
				</div>
 			</c:forEach>
		</div>
	</div>
 <div class="pagination-container wow zoomIn mar-b-1x" data-wow-duration="0.5s"
   	 	style="border-top: 10px solid #FFFFFF;border-bottom: 0px solid #FFFFFF;">
	<ul class="pagination">
		<!--以当前页为对称左右展开   -->
	<c:if test="${currentPage != null}">
	  <li class="pagination-item--wide first"> 
	  	<a class="pagination-link--wide first" href="#" onclick="paginationPage('previous','${currentPage}')">上一页</a> </li>
	  <c:forEach begin="${startPage}" end="${endPage}" varStatus="status" >
			  <c:choose>
			  	<c:when test="${status.index==currentPage}">
					<li class="pagination-item is-active "> <a class="pagination-link" href="#" onclick="paginationPage('currentPage','${currentPage}')" >${currentPage}</a> </li>
				</c:when>
			  	<c:when test="${status.index==startPage}">
					<li class="pagination-item   first-number "> <a class="pagination-link" href="#" onclick="paginationPage('currentPage','${status.index}')">${status.index}</a> </li>
				</c:when>			
				<c:when test="${status.index!=currentPage&&status.index!=startPage}">
					<li class="pagination-item   "> <a class="pagination-link" href="#" onclick="paginationPage('currentPage','${status.index}')">${status.index} </a> </li>
				</c:when>
			</c:choose>  
	  </c:forEach>
	  <li class="pagination-item--wide last"> 
	  	<a class="pagination-link--wide last" href="#" onclick="paginationPage('next','${currentPage}')">下一页</a> </li>	
	 </c:if>	
	 </ul>
</div>

<!--返回顶部  -->
<a href="#0" class="cd-top">Top</a>
 
    <!-- 必须放在此处加载（sport-show） -->
	<script src="<%=basePath%>jquery/sport-show/jquery.waypoints.min.js"></script>
	<script src="<%=basePath%>jquery/sport-show/jquery.flexslider-min.js"></script>
	<script src="<%=basePath%>jquery/sport-show/main.js"></script>
</body>  
   
</html> 