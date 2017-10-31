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
	<!--sweetalert  -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/sweetalert/sweetalert.min.js "></script>
   <link rel="stylesheet" href="<%=basePath%>css/sweetalert/sweetalert.css">
	<!--按钮样式  -->
	<link href="../css/button/button.css" rel="stylesheet" type="text/css" />
	<!--正在加载  -->
	<link href="../css/loading/loading.css" rel="stylesheet" type="text/css" />
	<!--顶部返回 -->
  	<script src="../jquery/go-top/go-top.js"></script> 
  	<link href="../css/go-top/go-top.css" rel="stylesheet" type="text/css" />
	<!-- 搜索框 -->
	<link href="../css/search/search.css" rel='stylesheet' type='text/css' />
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	
   <!--start slider -->
   <link href="../css/index-css/style.css" rel='stylesheet' type='text/css' />
   
  <script type="text/javascript" src="../jquery/index-js/jquery.min.js"></script>
  <script type="text/javascript" src="../jquery/index-js/bootstrap.js"></script>
  <script type="text/javascript" src="../jquery/index-js/bootstrap.min.js"></script>
 
    <link rel="stylesheet" href="../css/index-css/fwslider.css" media="all">
    <script src="../jquery/index-js/jquery-ui.min.js"></script>
    <script src="../jquery/index-js/css3-mediaqueries.js"></script>
    <script src="../jquery/index-js/fwslider.js"></script>
 
 	<!--引入基本样式（头）  -->
	 <link href="../css/index-css/bootstrap.min.css" rel='stylesheet' type='text/css' />
	<link href="../css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="../css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" /> 
 	
 	<style type="text/css">
 		a:focus,a:hover{
 			text-decoration: none;
 			color: white;
 		}
 		
 		
 	</style>
 	
  	<script type="text/javascript">
 		
 		var startCount = '${fn:length(listAritcle)}';//得到第一次加载进来的长度
 		var size = 3;//设置每次多加载2篇
 		var count = 0;//点击加载的次数
 		var total = Number(startCount);//总的个数
 		//现将loadinghide
 		$(function(){
 			$(".load-wrapp").hide();
 		});
 		
 		//利用ajax进行更多文章的加载
 		$(document).ready(function(){
 			$("#getMoreArticle").click(function (){
 				$(this).hide();
				$(".load-wrapp").show();
 				getData();
 			});
 		});
 		
 		function getData(){
 			var url = "<%=basePath%>"+'article/getArticleMore.action';
 			var args= {"total":total, "size":size};
 			var JSONargs = JSON.stringify(args);
 			var result = '';
 			var state = 0;
 			$.post(url, {json:JSONargs},function(data){
 				for(var i = 0; i < data.length; i++){	
 					 result += '<div class="blog_list" style=" padding: 16px 20px; margin-bottom: 15px;">'+
 							   '<div class="col-md-2 blog_date">'+
 							   		'<span class="date">'+ data[i].userArticle.time.month + '月<p>' + data[i].userArticle.time.date + '</p></span>' +
 							   	'</div>' +
 							   	'<div class="col-md-10 blog_left">'+
 							   		'<a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=' + data[i].userArticle.id + '">' +
 							   			'<img src="<%=basePath%>' + data[i].userArticle.cover + ' "class="img-responsive"/></a>' +
 							   			'<h4><a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id='+ data[i].userArticle.id+'">' + data[i].userArticle.title + '</a></h4>' +
 							   				'<span>' +
 							   						'By&nbsp;&nbsp;'+
 							   							'<a target="_blank" href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName=' + data[i].userArticle.user.username +'">' +
 							   								'<img src="<%=basePath%>' + data[i].userArticle.user.avatar + '" style="height: 20px;width: 20px;border-radius:3px" >' +
 							   							'</a>'+
 							   							'&nbsp;&nbsp;'+
 							   								'<a target="_blank" href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName=' + data[i].userArticle.user.username +'">' +
 							   									 data[i].userArticle.user.username + 
 							   								'</a>' +
 							   								'<a target="_blank" class="left" href="<%=basePath%>article/getArticleDetail.action?isToEnd=true&userArticle.id='+ data[i].userArticle.id+'">'+
 							   									'<i class="fa fa-comment"></i>' + data[i].userArticle.commentCount + '&nbsp;评论</a> ' +
 							   								'<a target="_blank" class="left" href="<%=basePath%>article/getArticleDetail.action?userArticle.id='+data[i].userArticle.id +'">'+
 							   									'<i class="fa fa-eye"></i>' + data[i].userArticle.wantCount + '&nbsp;浏览</a>' +
 							   				 '</span>'	+
 							   				 '<p class="para">' + data[i].userArticle.content.substring(0,400) +'...</p>' +
 							   				 '<div class="read_btn">'	+
 							   				 	'<a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=' + data[i].userArticle.id + '">' +
 							   				 		'<button class="btn">文章详情</button>'	+
 							   				 	 '</a>' +
 							   				  '</div>' +
 							   				'</div>'+
 							   				'<div class="clearfix"></div>' +
 							   			'</div>' ; 
 						state = data[i].state;	
 				}
 				setTimeout(function (){
 					 count++;
 					 total = Number(startCount) + Number(count * size);
   			 		 $(".load-wrapp").hide();
   			 		 // $('.blog_main :last').append(result);
   			 	 	 $(".load-wrapp").before(result);
   			 	 	 if(state == 1){ 
   			 	 	 	$("#getMoreArticle").show(); //是否可以继续加载
   			 	 	  } 
   					}, 500);
 
 			}
 			,"json");
 		}
 
	//点击发表文章的时候
	$(function(){
		$('#publishArticle').click(function(){
			if('${sessionScope.name}' == ''){
				swal('请先登入哦~');
			}else{
				location.href='<%=basePath%>' + 'userArticle/getUserDraft.action';
			}
		});
	});

  	</script>
</head>
  
<body  >
	<div class="header_bg">
	<div class="container">
	<div class="header">
		<div class="logo">
			<a href="<%=basePath%>index.jsp"><img style="margin-top: -15;       margin-left: 60;width: 120;"  src="../image/index-images/logo.png" alt=""/></a>
		</div>
		<div class="h_menu">
		<a id="touch-menu" class="mobile-menu" href="#">Menu</a>
		<nav>
		<ul class="menu list-unstyled">
			<li  ><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
			<li  ><a href="${pageContext.request.contextPath}/sport/showSportAll.action?category1.name=全部地区&category2.name=全部类别&category3=score">乡村</a></li>
			<li class="activate"><a href="${pageContext.request.contextPath}/article/getArticleAll.action">见闻</a></li>
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
							 <!-- <li><a href="#">我的消息</a></li> -->
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
<!-- slide -->
  <div id="fwslider"  ><!-- start slider -->
        <div class="slider_container" style=" width: 100%;" >
            <div class="slide" style=" height: 500px;"> 
                <!-- Slide image -->
                <a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=38"> 
                	<img style="z-index: 1; position: absolute;" src="../image/index-images/article-slider1.jpg">
                </a>
                <div class="slide_content">
                    <div class="slide_content_wrap">   
                         
                        	<div class="cover" style="  float: right; height: 100%;width: 50%;margin-top: 100;"> 
                        		 <h1 style="z-index:1;position:absolute; margin: 50 0 0 -300;">黄瑶古镇</h1>
                        		 <br>
                        		 <span style="width: 500;z-index:1;position:absolute;margin:150 0 0 -300">古镇是白墙灰瓦，小小的石拱桥，穿城而过如碧玉带般秀美的河水。</span>
                        	 </div> 
                        	
                         
                    </div> 
                </div>
                  
            </div>
            <div class="slide">
	             <a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=45"> 
                	<img style="z-index: 1; position: absolute;" src="../image/index-images/article-slider2.jpg">
                </a>
                <div class="slide_content">
                    <div class="slide_content_wrap">   
                        <div class="cover" style="  float: right; height: 100%;width: 50%;margin-top: 100;"> 
                        		 <h1 style="z-index:1;position:absolute; margin: 50 0 0 -300;">丝绸之旅</h1>
                        		 <br>
                        		 <span style="width: 500;z-index:1;position:absolute;margin:150 0 0 -300">重温丝绸之路的足迹   ，再次感受那段黄沙漫天、历尽艰辛的旅程，耳边仿佛又响起了清脆悠扬的驼铃声声</span>
                        	 </div> 
                        	
                        </div>  
                    </div> 
               
           </div> 
           
            <div class="slide">
	             <a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=36"> 
                	<img style="z-index: 1; position: absolute;" src="../image/index-images/article-slider3.jpg">
                </a>
                <div class="slide_content">
                    <div class="slide_content_wrap">   
                       <div class="cover" style="  float: right; height: 100%;width: 50%;margin-top: 100;"> 
                        		 <h1 style="z-index:1;position:absolute; margin: 50 0 0 -300;">宏村</h1>
                        		 <br>
                        		 <span style="width: 500;z-index:1;position:absolute;margin:150 0 0 -300">趁时间还没走，去感受历史的遗迹，美丽，难道只能用眼睛去评判吗？</span>
                        	 </div> 
                        	
                        </div>  
                    
                </div>
           </div> 
           
            
        </div>
         <div class="timers"></div>
        <div class="slidePrev"><span></span></div>
        <div class="slideNext"><span></span></div> 
    </div>
<!--over slide  -->


<!-- start main -->
<div class="main_bg" style="border-bottom: 10px solid white;">
<div class="container">
	<div class="main_grid1">
		<h3 class="style pull-left">our Portfolios</h3>
		<ol class="breadcrumb pull-right">
		  <li><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
		  <li class="active">见闻</li>
		</ol>
		<div class="clearfix"></div>
	</div>
</div>
</div>
<!-- 为你推荐（分类） -->
<%-- <div style="width:100%; text-align: center;">
	<span>为你推荐</span>
	<hr>
</div> --%>
<!-- start main_btm -->
<div class="main_btm1">
<div class="container">
	<div class="blog"><!-- start blog -->
		<div class="blog_main col-md-9">
		<c:forEach items="${listAritcle}" var="article">
				<div class="blog_list" style=" padding: 16px 20px; margin-bottom: 15px;">
					<div class="col-md-2 blog_date">
						<span class="date">
							<c:choose>
								<c:when test="${fn:substring(article.time,5,6)==0}">
									${fn:substring(article.time,6,7)}月 
								</c:when>
								<c:otherwise>
									${fn:substring(article.time,5,7)}月
								</c:otherwise>
							</c:choose>
							<c:choose> 
								<c:when test="${fn:substring(article.time,8,9)==0}">
									<p>${fn:substring(article.time,9,10)}</p> 
								</c:when>
								<c:otherwise>
									<p>${fn:substring(article.time,8,11)}</p>
								</c:otherwise>
							</c:choose>	
						</span>
					</div>
					<div class="col-md-10 blog_left">
						<a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${article.id}">
							<img src="<%=basePath%>${article.cover}"  class="img-responsive"/>
						</a>
						<h4><a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${article.id}">${article.title }</a></h4>
						<span>
							By&nbsp;&nbsp;
							 <a target="_blank" href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName=${article.user.username}">
								<img src="<%=basePath%>${article.user.avatar}" style="height: 20px;width: 20px;border-radius:3px" >
							 </a>	
							&nbsp;&nbsp;
							 <a target="_blank" href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName=${article.user.username}">	
								${article.user.username}
							</a>
							<a class="left" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${article.id}&isToEnd=true" target="_blank">
								<i class="fa fa-comment"></i>${article.commentCount}&nbsp;评论
							</a> 
							<a class="left" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${article.id}" target="_blank">
								<i class="fa fa-eye"></i>${article.wantCount}&nbsp;浏览
							</a>
						</span>
						<p class="para">${fn:substring(article.content,0,400)}...</p>
						<div class="read_btn">
							<a href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${article.id}" target="_blank">
								<button class="btn">文章详情</button>
							</a>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</c:forEach>
			<div class="load-wrapp">
            	 <div class="load-3">
			          <div class="loading"></div>
		               <div class="loading"></div>
		               <div class="loading"></div>
                  </div>
    		</div>
    		
    		<div style="text-align: center;">
    			<a href="javascript:void(0);" class="more red" id="getMoreArticle" >加载更多</a>
			</div>	
			</div>
			
			
			<div class="col-md-3 blog_right" > 
				<ul class="tag_nav list-unstyled">
					<h4>热门标签</h4>
					 	<c:forEach items="${tag}" var="tagName">
							<li class="active"><a target="_blank" href="<%=basePath%>sport/searchContent.action?method=tag&value=${tagName}">${tagName}</a></li>
						</c:forEach>
						
				</ul>
				<hr style="border-bottom: 10px solid #c5c1c1;">
				<div class="news_letter">
					<h4>发表我的见闻</h4>
						<!-- <form>
							<input type="text" placeholder="Your email address">
							<input type="submit" value="subscribe">
						</form> -->
					<div style="text-align: center;">
    			  		<a href="javascript:void(0);" class="more red"  id="publishArticle" 
    			  			style=" box-shadow: 0px 5px 0px 0px white; background: #65c4bc;" >
    			  			写见闻</a>
				  	</div>
				</div>
			</div>
			<div class="clearfix"></div>
	</div><!-- end blog -->
</div>
</div>
<!--返回顶部  -->
<a href="#0" class="cd-top">Top</a>
 
	 
</body>
 
</html>
