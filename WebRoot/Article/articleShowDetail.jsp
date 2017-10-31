<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/struts-tags"  prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js "></script>
		<!-- 搜索框 -->
	<link href="${pageContext.request.contextPath}/css/search/search.css" rel='stylesheet' type='text/css' />
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"> 
	<!--百度编辑器  -->
  	<script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor-forReply.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/lang/zh-cn/zh-cn.js"></script>
   <!--sweetalert  -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/sweetalert/sweetalert.min.js "></script>
   <link rel="stylesheet" href="<%=basePath%>css/sweetalert/sweetalert.css">	
   <!--顶部返回 -->
  	<script src="<%=basePath%>jquery/go-top/go-top.js"></script> 
  	<link href="<%=basePath%>css/go-top/go-top.css" rel="stylesheet" type="text/css" />
  	<!-- 分页 -->
	<link rel="stylesheet" href="<%=basePath%>css/pagination/style.css">
	<!--引入评论样式  含头像转动-->
	<link href='<%=basePath%>css/comment/style.css' rel='stylesheet' type='text/css'>
	<link href='<%=basePath%>css/comment/bootstrap.css' rel='stylesheet' type='text/css'>
	<!--引入文章格式和tag样式  -->
	<link rel="stylesheet" href="<%=basePath%>css/index-css/zerogrid.css">
	<link rel="stylesheet" href="<%=basePath%>css/index-css/style.css">
	<!--引入基本样式（头）  -->
	<link href="<%=basePath%>css/index-css/bootstrap.min.css" rel='stylesheet' type='text/css' />
	<link href="<%=basePath%>css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="<%=basePath%>css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" />
	
	<style type="text/css">
		a:hover,a:focus{
			text-decoration: none;
		}
		img{
			max-width: 660px;
		}
		video {
		    margin-left: 80px;
			width: 663px;
    		height: 443px;
		}
	</style>

 <script type="text/javascript">
 
   var ue = UE.getEditor('editor');
 
   var targetUser,targetCRId,type='';
 
	//分页操作
	function paginationPage(method,currentPage){
		 if(method != 'currentPage'){
		 	var action ="<%=basePath%>"+'article/getArticleDetail.action?userArticle.id='
			     + '${userArticle.id}' +'&pagerMethod='+method
			     +'&currentPage=' +'${currentPage}'	+ '&isToEnd=true';
		    location.href = action;
		 }else{ //直接跳转DAO某页
		 	var action = "<%=basePath%>"+'article/getArticleDetail.action?userArticle.id='
			    + '${userArticle.id}' + 
			     '&currentPage=' + currentPage + '&isToEnd=true';
		    location.href = action;
		 } 
	}
	
	//是否DAO底部
	$(document).ready(function(){
		if('${isToEnd}' == 'true'){
			$(function(){ window.location.hash = "#cr"; });
		}
	});
	//是否显示分页
	$(function(){
		if('${fn:length(crlist)}'=='0'){
			$("#pagination").hide();
		}
	});
	var targetCRName = '';
	//提交表单
	function submitForm(){
		if('${sessionScope.name}' == ''){
			swal("请先登入");
		}else{
    			var t = ue.getContent();
    			if($.trim(t).length==0){
    				swal("请先填写内容哦~");
    			}else{
    				  $("input[name='CR']").val($.trim(t));  
    			   if(type == '') {
						document.form.action = "<%=basePath%>"+'article/saveUserArticleComment.action?userArticle.id=' + '${userArticle.id}'+ '&isToEnd=true';
						document.form.submit();  
						//alert(type);
					}
					else{	
					 
						document.form.action ="<%=basePath%>"+'article/saveUserArticleReply.action?userArticle.id=' + '${userArticle.id}' 
						+ '&userArticleReply.targetCRId=' + targetCRId + '&userArticleReply.type=' + type + '&isToEnd=true' + '&userArticleReply.targetUser.username=' +targetCRName; 
						//alert(type);
						document.form.submit();
    	 			}  
    			} 
		}
	}
 
	//当点击回复某个评论的时候
	function reply(rank,targetcrId,username,targetuser){
		  if('${sessionScope.name}' == ''){
			swal("请先登入哦~");
		}else{
			//ue.focus();
		 	//ue.setContent("[回复:"+username+"]");  
		 	//防止了焦点乱跑
		 	ue.focus();  
			ue.execCommand('inserthtml',"[回复:"+username+"]");  
		 	targetCRName = username;
		 	
		 	var h = $(document).height();
            $(document).scrollTop(h);
            
           //为了区分  reply表中的  fatherId是对这个reply表中的还是对这个comment的表中的ID
			if(rank == '0'){
				type = 'comment';
			}
			else  type = 'reply';
				targetCRId = targetcrId; 
				targetUser = targetuser;
		   } 
		}
 
	$(document).ready(function(){
		var taggle = true;
		//是否重新点赞
		$("#great").click(function(){
			if('<%= request.getSession().getAttribute("name")%>' == "null"){
			swal("请先登入哦");
		}
		else{
			 var method = '减';
			if($(this).attr("src") == ('<%=basePath%>' + 'image/11.jpg')){
				$(this).attr("src", "<%=basePath%>"+ "image/00.jpg");
				method = '减';
			}
			else{
				$(this).attr("src", "<%=basePath%>"+ "image/11.jpg");
				method = '加';
			}
			  var url = "<%=basePath%>"+"article/addOrSub.action";
			var userArticle_id = "${userArticle.id}";
			var ar = {"method":method, "userArticle_id":userArticle_id};
			var args = JSON.stringify(ar);
			$.post(url, {json:args}, function(data){
				$(".greatCount").text(data.greatCount);
			},"json");  
		}
	  });
	});
 	
 	//用户删除文章
 	function deleteUserArticle(userArticle_id){
 		swal({
			  title: "确定删除吗？",
			  text: "",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#DD6B55",
			  confirmButtonText: "Yes, delete it!",
			  closeOnConfirm: false
		},
		function(){
		  var url = '<%=basePath%>' + 'userArticle/deleteUserArticle.action' ;
		  var ar = {"userArticle_id" : userArticle_id};
		  var args = JSON.stringify(ar);
		  $.post(url, {json : args}, function(){
		  	 swal({
				  title: "已经成功删除",
				  type: "success",
				  showCancelButton: false,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "OK!",
				  closeOnConfirm: true
				},
			function(){
			  window.location.href = '<%=basePath%>' + 'article/getArticleAll.action'; 
			});
		  	 
		  });

		});
 	}
 	 
	
</script>
 
  </head>
 
<body style=" background-color: #f4f3ee;">
<div class="header_bg">
<div class="container">
	<div class="header">
		<div class="logo">
			<a href="<%=basePath%>index.jsp"><img style="margin-top: -15;  width: 120;margin-left: 60;" src="<%=basePath%>image/index-images/logo.png" alt=""/></a>
		</div>
		<div class="h_menu">
		<a id="touch-menu" class="mobile-menu" href="#">Menu</a>
		<nav>
		<ul class="menu list-unstyled">
			<li  ><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
			<li ><a href="${pageContext.request.contextPath}/sport/showSportAll.action?category1.name=全部地区&category2.name=全部类别&category3=score">乡村</a></li>
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
		  <li><a href="${pageContext.request.contextPath}/article/getArticleAll.action">见闻</a></li>
		  <li class="active">${userArticle.title}</li>
		</ol>
		<div class="clearfix"></div>
	</div>
</div>
</div>
<hr>
<section id="container">
	<div class="wrap-container">
		<div id="main-content">
			<div class="zerogrid">
				<div class="row wrap-content">
					<div class="col-3-4">
						<div class="wrap-col">
							<article style=" padding: 20px 30px;">
								<div class="art-header">
									<div class="entry-title"> 
										<h2 style="text-align: center;">${userArticle.title}</h2>
									</div>
									 
								</div>
								<div style="width: 100%; height: 30px;" class="art-content" >
									<span style="margin-right:35px;float:right;">
	            						<strong>${userArticle.wantCount}</strong>
	            		   				&nbsp;
	            		   				<img src="<%=basePath%>image/view-count.png" style="width: 20px;height: 20px; display:inline;"  > 
	            						&nbsp; &nbsp; 
	            						<strong><span class="greatCount" >${userArticle.greatCount}</span></strong>
	            		   				&nbsp; 
	            		   				<img src="<%=basePath%>image/00.jpg" style="width: 20px;height: 20px; display:inline;"  > 
	            						<c:if test="${sessionScope.name == userArticle.user.username}">
	            							&nbsp; &nbsp;
	            						 <strong>
	            						 	<a style="color: black;" href="<%=basePath%>userArticle/getArticleDetailUpdate.action?isRevise=true&userArticle.id=${userArticle.id}">
	            						 		修改</a> &nbsp;
	            							<img src="<%=basePath%>image/revice.png" style="width: 20px;height: 20px; display:inline;"  >
	            						  </strong>	
	            						  &nbsp; &nbsp;
	            						  <strong>
	            						  	<a style="color: black;" onclick="deleteUserArticle(${userArticle.id})" href="javascript:void(0);">
	            						  		删除 </a> &nbsp;
	            							<img src="<%=basePath%>image/delete.png" style="width: 20px;height: 20px; display:inline;"  >
	            						  </strong>	
	            						</c:if>
	            					</span>
								</div>
								<div class="art-content">
									${userArticle.content}
								</div>
								<hr style="border: 1px solid #888888;" >
								<!--想去count  -->
								<div style="margin-top: 40px; text-align: center;padding-bottom: 30px;" >
									<img style="height:70px;width: 70px;" src="${greatImg}" id="great" >
  	 							    <span  >
  	 							    	<strong style="font-size:20px;color:#888888;" >
  	 							    		&nbsp;&nbsp;<span  class="greatCount" >${userArticle.greatCount}</span>
  	 							    	&nbsp;赞同</strong>
  	 							    </span>
								</div>
							</article>
						</div>
					</div>
					 <div class="col-1-4">
						<div id="sidebar" class="wrap-col">
							<div class="wrap-sidebar">
								<div class="widget"> 
 									<div class="widget-box wid-tags">
									 <ul class="tag_nav list-unstyled">
										<h4>文章标签</h4>
											<c:forEach items="${tag}" var="tagName">
												<c:if test="${fn:length(tagName) != 0}">
													<li class="active">
														<a style="line-height: 20px;" target="_blank" href="<%=basePath%>sport/searchContent.action?method=tag&value=${tagName}">${tagName}</a>
													</li>
												</c:if>
											 </c:forEach> 
											<div class="clearfix"></div>
									</ul>
										 
									</div>
									<div class="widget-box wid-news">
										<div class="widget-title">
											<h5>TA的其他文章</h5>
										</div>
										<div class="widget-content">
											  <c:forEach items="${listAritcle}" var="article">
												 <div class="row"> 
												 	<div class="col-1-4">
														<div class="wrap-col">
															<a href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${article.id}"><img src= "<%=basePath%>${article.cover}" /></a>
														</div>
													</div>
												  	<div class="col-3-4">
														<div class="wrap-col">
															<a style="font-size: 17px;" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${article.id}">
																${fn:substring(article.title,0,8)}...
															</a>
														</div>
												   </div>  
												 </div>
												</c:forEach>
											</div>
									</div>
									 
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<hr>
<!--下面的是评论  -->
 <div style="margin-left: 90px; width: 100%; float: none;" id="cr">
  <div class="col-md-8 latest-news-agile-left-content" style="float: none" >
		  <c:forEach var="cr" items="${crlist}">
			 <div class="response" style="margin-left:${cr.rank}px;">
				 <div class="media response-info">
						 	    <div class="media-left response-text-left" style="text-align: center;">
						  			<a href="#">
							        	<div class="character360 red" style=" margin-top: 0px;" > 
							        		<a target="_blank" href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName=${cr.user.username}">
							        			<img src="<%=basePath%>${cr.user.avatar}" style="border-radius: 20px;height: 70px;width: 70px;" >
							        		</a>
							        	</div>
								 	</a>
									<h5>
										<a target="_blank" href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName=${cr.user.username}">
											${cr.user.username}
										</a>
									</h5>
							   </div>
							   <div class="media-body response-text-right" style="background-color:	#FFFFFF;border: 3px solid #f3f3f3;" >
								    <div style="margin: 10px 15px; font-size:17px; " > ${cr.content } </div> 
									 <ul>
									    <li style="padding:10px 15px;">${fn:substring(cr.time,0,16)}</li>
									     <li>
									     	<a href="javascript:void(0);" onclick="reply('${cr.rank}','${cr.id}','${cr.user.username}','${cr.user}')">
									     		<i class="fa fa-reply" aria-hidden="true"></i> Reply
									     	</a>
									     	  
									     </li>
								     </ul>		
						       </div>
				    </div>
			  </div>
		</c:forEach>  
		<c:if test="${fn:length(crlist)==0}">
			<div style="margin-left:600px;color: #888888;margin-bottom: 100px; font-size: 20px;">
				快来抢占沙发吧~
			</div>
		</c:if> 
	 </div>

</div> 

<!--翻页  -->
 <div id="pagination" class="pagination-container wow zoomIn mar-b-1x" data-wow-duration="0.5s">
	<ul class="pagination">
		<!--以当前页为对称左右展开   -->
	  <li class="pagination-item--wide first"> <a class="pagination-link--wide first" href="javascript:void(0);" onclick="paginationPage('previous','${currentPage}')">上一页</a> </li>
	  
	  <c:forEach begin="${startPage}" end="${endPage}" varStatus="status" >
			  <c:choose>
			  	<c:when test="${status.index==currentPage}">
					<li class="pagination-item is-active "> <a class="pagination-link" href="javascript:void(0);" onclick="paginationPage('currentPage','${currentPage}')" >${currentPage}</a> </li>
				</c:when>
			  	<c:when test="${status.index==startPage}">
					<li class="pagination-item   first-number "> <a class="pagination-link" href="javascript:void(0);" onclick="paginationPage('currentPage','${status.index}')">${status.index}</a> </li>
				</c:when>			
				<c:when test="${status.index!=currentPage&&status.index!=startPage}">
					<li class="pagination-item   "> <a class="pagination-link" href="javascript:void(0);" onclick="paginationPage('currentPage','${status.index}')">${status.index} </a> </li>
				</c:when>
			</c:choose>  
	  </c:forEach>
	  <li class="pagination-item--wide last"> <a class="pagination-link--wide last" href="#" onclick="paginationPage('next','${currentPage}')">下一页</a> </li>	
	 </ul>
</div> 
<!--下面的回复框  -->
<div style="margin:50px auto; width:840px;min-height:220px;
		padding:15px 10px 45px 10px;   background-color:#f2eeee; "  >
	<form method="post"  name="form">  
    	<input type="hidden" id="CR" name="CR">
     	<script id="editor" type="text/plain" style="width:820px;min-height:200px;height:auto;">	  
	 	</script> 
	 	<input type="button" onclick="submitForm()"  style="color: #8c96a0; float: right;margin-top: 10px;"  value="提交" /> 
	</form>
</div>

 <!--返回顶部  -->
<a href="#0" class="cd-top">Top</a>
  
  
    
     
  </body>
</html>
