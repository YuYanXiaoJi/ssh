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
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js "></script>
   	<!--导入优秀回答rank  -->
   	<link href="../css/elite-user-rank/elite-user-rank.css" rel="stylesheet" type="text/css" />
   	<!-- 分页 -->
	<link rel="stylesheet" href="../css/pagination/style.css">
   	<!--导入问题列表样式  -->
   	<link href="../css/show-question/show-question.css" rel="stylesheet" type="text/css" />
   	<!--顶部返回 -->
  	<script src="../jquery/go-top/go-top.js"></script> 
  	<link href="../css/go-top/go-top.css" rel="stylesheet" type="text/css" />
    <!-- 搜索框 -->
	<link href="../css/search/search.css" rel='stylesheet' type='text/css' />
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!--引入基本样式（头）  -->
	<!-- <link href="../css/index-css/bootstrap.min.css" rel='stylesheet' type='text/css' /> -->
	<link href="../css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="../css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" /> 
    <!--sweetalert  -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/sweetalert/sweetalert.min.js "></script>
   <link rel="stylesheet" href="<%=basePath%>css/sweetalert/sweetalert.css">
   
    <style type="text/css">
		 .container a:hover{
		color: #41c074;
		text-decoration: none;
	 }
 
	</style>
    
    <script type="text/javascript">
    	//点击提问
    	$(document).ready(function(){
    		$("#ask").click(function(){
    			location.href = "${pageContext.request.contextPath}/ueditor/Question.jsp";
    		});
    	
    	});
    	//全局变量 作为  category 
    	var t;
    	//激活active(为你推荐。近期最热。最新问题)
    	$(document).ready(function(){
    		if('${category}' == '1'){
    			$("#1").addClass('active');
    			t = '1';
    		}else if('${category}' == '2'){
    			$("#2").addClass('active');
    			t = '2';
    		}else {
    			$("#3").addClass('active');
    			t = '3';
    		}
    	});
    	
	function checkIsLogin(){
		if('${sessionScope.name}' == ''){
			swal('请先登入哦~');
		}else{
			$('#questionForm').submit();
		}
	}
    	
    </script>
 </head>
<body>
  <div class="header_bg">
 <div class="container">
	<div class="header">
		<div class="logo">
			<a href="<%=basePath%>index.jsp"><img style="margin-top: -30;   width: 120;margin-left: 60;" src="../image/index-images/logo.png" alt=""/></a>
		</div>
		<div class="h_menu">
		<a id="touch-menu" class="mobile-menu" href="#">Menu</a>
		<nav>
		<ul class="menu list-unstyled">
			<li  ><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
			<li  ><a href="${pageContext.request.contextPath}/sport/showSportAll.action?category1.name=全部地区&category2.name=全部类别&category3=score">乡村</a></li>
			<li><a href="${pageContext.request.contextPath}/article/getArticleAll.action">见闻</a></li>
			<li><a href="${pageContext.request.contextPath}/recommend.action">为你推荐</a></li>
			<li><a href="${pageContext.request.contextPath}/userGetSpecialSchemeAll.action">特别策划</a></li>
			<li class="activate"><a href="${pageContext.request.contextPath}/talk/getQuestionAll.action?category=1">秉烛夜谈</a>
			 
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
<!--面包屑目录  -->
<!-- start main -->
<div class="main_bg">
<div class="container">
	<div class="main_grid1">
		<h3 class="style pull-left">our Portfolios</h3>
		<ol class="breadcrumb pull-right">
		  <li><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
		  <li class="active">秉烛夜谈</li>
		</ol>
		<div class="clearfix"></div>
	</div>
</div>
</div>
<!-- 问题的3个分类   为你推荐  热门问题  最新问题  (在index-css的blue中)-->
<div class="threeBlock" >
	<span style=" text-align:right;" >
		<a  href="<%=basePath%>talk/getQuestionAll.action?category=1" id="1" ><h3>为你推荐</h3></a>
	</span>
	<span style="text-align: center;">
		<a href="<%=basePath%>talk/getQuestionAll.action?category=2" id="2"><h3>近期最热</h3></a>
	</span>
	<span style=" text-align:left;">
		<a href="<%=basePath%>talk/getQuestionAll.action?category=3" id="3" ><h3>最新问题</h3></a>
	</span>
</div>
<!--问题列表和tag和优秀回答者  -->
<div class="main_btm1">
<div class="container">
	<div class="blog">
			<!-- start blog -->
			<div class="blog_main col-md-9">
 
				<c:forEach items="${list}" var="q">
					<div>
						 <article class="type-post hentry clearfix" style="font-size: 17px;" >
		                           <header class="clearfix">
		                                  <h3 class="post-title" >
		                                        <a target="_blank" href="<%=basePath%>talk/getQuestionDetail?question.id=${q.question.id}" >
		                                        	${q.question.title}
		                                        </a>
		                                   </h3>
		 								<div class="post-meta clearfix">
		                                       <span class="date">${fn:substring(q.answer.time,0,16)}</span>
		                                        <span class="category">
		                                        	<c:forEach items="${q.tag}" varStatus="status" var="t" >
		                                        		<c:choose>
		                                        		<c:when test="${ status.index != fn:length(q.tag)-1 }">
			                                        		<a href="javascript:;" title="View all posts in Advanced Techniques">
			                                        			&nbsp;${t}&nbsp;&
			                                        		</a>
		                                        		</c:when>
		                                        		<c:otherwise>
		                                        			<a href="#" title="View all posts in Advanced Techniques">
			                                        			&nbsp;${t}&nbsp;
			                                        		</a>
		                                        		</c:otherwise>
		                                        		</c:choose>
		                                        	</c:forEach>
		                                        </span>
		                                         <c:if test="${category != 3}">
		                                         	<span class="comments">${q.commentCount}&nbsp;评论</span>
		                                         	<span class="like-count">${q.answer.greatCount}</span>
		                                 		  </c:if>
		                                 		  <c:if test="${category == 3 }">
		                                 		  	<span ><img style="height: 20px;;width: 15px;" src="../image/page-view-grey.png"> ${q.commentCount}&nbsp;浏览</span>
		                                         	<span ><img style="height: 15px;width: 15px;" src="../image/focus-count-grey.png">&nbsp;${q.answer.focusCount}&nbsp;关注</span>
		                                 		  </c:if>
		                                 </div><!-- end of post meta -->
		 							</header>
		 							  
		 								<div style="width:100%; height: 35px;">
		 									<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=${q.answer.user.username}">	
		 										<img alt="" src="<%=basePath %>${q.answer.user.avatar}" style="height:35px;border-radius: 10px; width:35px; ">
		 									</a>
		 									<span style="line-height:20px;margin-left:15px;font-size: 20px;">${q.answer.user.username}</span>
		 								</div>
		 								<div style="margin-top: 20px;"><span>${fn:substring(q.answer.content,0,400)}</span></div>	
		 								<a target="_blank"  class="readmore-link" href="<%=basePath%>talk/getQuestionDetail?question.id=${q.question.id}">
		 									更多
		 								</a>
		 							 
		 				</article>
		 			</div>
						 <br>
						 <br>
				 </c:forEach>
 
				 
			</div>
			<div class="col-md-3 blog_right"> 
				<div class="news_letter">
					  <form id="questionForm" action="<%=basePath%>ueditor/Question.jsp" >
						<input type="button" style="font-family:'Lucida Console', Monaco, monospace;
						 font-size:30px; color: white;background:#65c4bc; float: none;line-height: 30px;width:170px;"  onclick="checkIsLogin()"  value="我要提问">
					 </form>
				</div>
	
				<hr style="border-top:10px solid #D8D8D8;" />
				<ul class="tag_nav list-unstyled">
					<h4>热门标签</h4><!--10个  -->
						 <c:forEach items="${hotTag}" var="tag" >
						 	<li class="active"><a target="_blank" href="<%=basePath%>sport/searchContent.action?method=tag&value=${tag.tag}">${tag.tag}</a></li>
						 </c:forEach>
 			 
				</ul>
				<hr style="border-top:10px solid #D8D8D8;" />
				<!--罗列优秀回答用户  -->
				<h4>近期优秀回答</h4>
				<br>
				 <section class="comments">
  					<c:forEach items="${bestAnswerUser}" var="answer">
  						<article class="comment">
      					<a target="_blank" class="comment-img" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=${answer.user.username}">
        					<img src="<%=basePath%>${answer.user.avatar}" width="50" height="50">
      					</a>
					      <div class="comment-body">
					        <div class="text">
					          <p>${fn:substring(answer.content, 0, 40)}...</p>
					        </div>
					        <p class="attribution">
					        	<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=${answer.user.username}">
					        		${answer.user.username}
					        	</a>
					        	&nbsp;${fn:substring(answer.time,0,16)}
					        </p>
					      </div>
					    </article>
					 </c:forEach>	   
					     
					  </section>
			    </div>
	  
	</div><!-- end blog -->
</div>
</div>
<hr style="  border: 1px solid #D8D8D8; margin: 10px 520px 10px 220px;" >
<c:if test="${list != ''}">
<div class="pagination-container wow zoomIn mar-b-1x" 
		style="margin-bottom: 30; margin-left: 300px;"data-wow-duration="0.5s">
		<ul class="pagination" style="margin-left: -500px;">
			<c:choose>	
	        	<c:when test="${1 != currentPage}">
	        		<li class="pagination-item--wide first"> <a class="pagination-link--wide first" href="<%=basePath%>talk/getQuestionAll.action?category=${category}&currentPage=${currentPage-1}">上一页</a> </li>	
	 			</c:when>	
	 			<c:otherwise>
	 				 <li class="pagination-item--wide first"> <a class="pagination-link--wide first" href="javascript:void(0);">上一页</a> </li>	
	 			</c:otherwise>
	 		</c:choose> 
			<c:if test="${currentPage != 1}">
				   <li class="pagination-item "> <a class="pagination-link" href="<%=basePath%>talk/getQuestionAll.action?category=${category}&currentPage=1">1</a> </li>
			</c:if>	
			<c:if test="${currentPage - 1 >= 3}">
				   <li class="pagination-item   "> <a class="pagination-link" href="javascript:void(0);"  >...</a> </li>
			</c:if>	
			<c:if test="${currentPage - 1 >= 2}">
				   <li class="pagination-item  "> <a class="pagination-link" href="<%=basePath%>talk/getQuestionAll.action?category=${category}&currentPage=${currentPage-1}">${currentPage - 1}</a></li>
			 </c:if>	  
			 <li class="pagination-item is-active "> <a class="pagination-link" href="<%=basePath%>talk/getQuestionAll.action?category=${category}&currentPage=${currentPage}">${currentPage}</a></li> 
			 <c:if test="${currentPage + 1 < totalPage}">	
				  <li class="pagination-item "> <a class="pagination-link" href="<%=basePath%>talk/getQuestionAll.action?category=${category}&currentPage=${currentPage+1}"  >${currentPage + 1}</a></li>
			 </c:if>
			 <c:if test="${totalPage - currentPage >= 3}">
				   <li class="pagination-item   "> <a class="pagination-link" href="javascript:void(0);"  >...</a> </li>
			 </c:if>
			 <c:if test="${totalPage != currentPage}">
				  <li class="pagination-item  "> <a class="pagination-link" href="<%=basePath%>talk/getQuestionAll.action?category=${category}&currentPage=${totalPage}">${totalPage}</a></li>
			 </c:if>		 
			<c:choose>	
	        	<c:when test="${totalPage != currentPage}">
	        		<li class="pagination-item--wide last"> <a class="pagination-link--wide last" href="<%=basePath%>talk/getQuestionAll.action?category=${category}&currentPage=${currentPage+1}">下一页</a> </li>	
	 			</c:when>	
	 			<c:otherwise>
	 				 <li class="pagination-item--wide last "> <a class="pagination-link--wide last" href="javascript:void(0);">下一页</a> </li>	
	 			</c:otherwise>
	 		</c:choose>
	 </ul>
 </div>	
</c:if>
<!--返回顶部  -->
<a href="#0" class="cd-top">Top</a>
 
</body>
</html>
