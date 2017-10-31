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
 	<link href="${pageContext.request.contextPath}/css/user-home/user-home.css" rel='stylesheet' type='text/css' />
	<!--顶部返回 -->
  	<script src="${pageContext.request.contextPath}/jquery/go-top/go-top.js"></script> 
  	<link href="${pageContext.request.contextPath}/css/go-top/go-top.css" rel="stylesheet" type="text/css" />
  	<!-- 搜索框 -->
	<link href="${pageContext.request.contextPath}/css/search/search.css" rel='stylesheet' type='text/css' />
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"> 
	<!--引入基本样式（头）  -->
	<link href="${pageContext.request.contextPath}/css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="${pageContext.request.contextPath}/css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" /> 	
 
	<!--sweetalert  -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/sweetalert/sweetalert.min.js "></script>
   <link rel="stylesheet" href="<%=basePath%>css/sweetalert/sweetalert.css">
	
	<style type="text/css">
		a,a:hover {
    		color: inherit;
    		text-decoration: none;
		}

	</style>
	
	<script type="text/javascript">
		
		$(function(){
			var category = '${param.category}';
			if(category == 'activities'){
				$("#activities").addClass('activate');
			}else if(category == 'question'){
				$("#question").addClass('activate');
			}else if(category == 'answer'){
				$("#answer").addClass('activate');
			}else if(category == 'follower'){
				$("#follower").addClass('activate');
			}else if(category == 'following'){
				$("#following").addClass('activate');
			}else if(category == 'blog'){
				$("#blog").addClass('activate');
			}else if(category == 'focusQuestion'){
				$("#focusQuestion").addClass('activate');
			}
		});
		
		//点击关注的时候
		$(function(){
			  $('body').on('click', '.FollowButton', function() {
				if('${sessionScope.name}' == ''){
					swal("请先登入哦~");
				}else{ 
					var method = '';
					if('关注TA' == $(this).text()){
						$(this).removeClass('Button--blue');
						$(this).addClass('Button--grey');
						$(this).text('已关注');
						method = 'focus';
					}else{
						method = 'cancelFocus';
						$(this).text('关注TA');
						$(this).removeClass('Button--grey');
						$(this).addClass('Button--blue');
					}
					//改变人数数量
					if('${isOwner}' != ''){//也就是我的自己的主页
						if(method == 'focus'){
							$('#followingCount').text(Number($('#followingCount').text()) + 1);
						}else{
							$('#followingCount').text(Number($('#followingCount').text()) - 1);
						}
					}
					//进行ajax
				 	var url = '<%=basePath%>' + 'focusUserOrNot.action';
				 	var ar = {'targetUsername':$(this).prop('id'),'method':method};
				 	var args = JSON.stringify(ar);
				 	$.post(url,{json:args}); 
				}
 		});
 	});
		
	</script>
	
  </head>
		
<body style="background:#f3f3f3;">
<div class="header_bg" style="background: #b3e5e1;">
<div class="container">
	<div class="header"  style="height: 10px; margin-top: -30;">
		 <div class="logo">
			<a href="<%=basePath%>index.jsp"><img style="margin-top: -10; width: 120;margin-left:  -60;" src="${pageContext.request.contextPath}/image/index-images/logo.png" alt=""/></a>
		</div>  
		<div class="h_menu">
		<a id="touch-menu" class="mobile-menu" href="#">Menu</a>
		<nav>
		<ul class="menu list-unstyled">
			<li  ><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
			<li ><a href="${pageContext.request.contextPath}/sport/showSportAll.action?category1.name=全部地区&category2.name=全部类别&category3=score">乡村</a></li>
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
					  <img style="width: 48px;height: 48px;" src="<%=basePath%>${sessionScope.img}"  class="img-responsive img-circle"/>
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
			<li  >
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
<!--下面是主要的内容了  -->
<div class="ProfileHeader">
<div class="Card">
	<div class="UserCover"  >
		<img class="UserCover-image" width="1000"  src="<%=basePath%>${user.background}" alt="用户封面">
	</div>
	<div class="ProfileHeader-wrapper">
		<div class="ProfileHeader-main">
			<div class=" ProfileHeader-avatar" style="top: -57px;">
				<div class="UserAvatar">
					<img class="Avatar Avatar--large UserAvatar-inner" width="160" height="160" src="<%=basePath%>${user.avatar}">
				</div>
			</div>
			<div class="ProfileHeader-content">
				<div class="ProfileHeader-contentHead">
					<h1 class="ProfileHeader-title">
						 <span class="ProfileHeader-name">${userUpdateName}</span>
						 <span class="RichText ProfileHeader-headline">${user.individualSignature}</span>
					</h1>
				</div>
				<div class="ProfileHeader-contentFooter">
				  <c:choose>
				    <c:when test="${empty (isOwner)}"> 
					<div class="MemberButtonGroup ProfileButtonGroup ProfileHeader-buttons">
						<!-- <button id="focusUser" class="Button FollowButton Button--primary Button--blue" type="button">关注TA</button> -->
 						<c:choose>
							<c:when test="${empty (isFocus) }">
				  	  	 		<button id="${userUpdateName}" class="Button FollowButton Button--primary Button--blue">关注TA</button>
							</c:when>
							<c:otherwise>
								<button id="${userUpdateName}"  class="Button FollowButton Button--primary Button--grey">已关注</button>
							</c:otherwise>
						</c:choose>							
						<button class="Button">发私信</button>
					</div>
					</c:when>
					<c:otherwise>
						<div class="ProfileButtonGroup ProfileHeader-buttons">
						<button onclick="javascript:window.location.href='<%=basePath%>userArticle/getUserDraft.action' " class="Button Button--blue" type="button">
							书写见闻
						</button>&nbsp;&nbsp;&nbsp;
						<button onclick="javascript:window.location.href='getUserDetail.action' " class="Button Button--blue" type="button">
							编辑个人资料
						</button>
					</div>
					</c:otherwise>
					</c:choose>	
				</div>
			</div>
		</div>
	</div>
</div>
</div>
 <!--下面是导航分类  -->
<div class="Profile-main">
	<div class="Profile-mainColumn">
		<div class="Card ProfileMain">
			<div class="ProfileMain-header">
				<ul class="Tabs ProfileMain-tabs">
					<div class="ProfileMainPrivacy-authWrapper">
						<li id="activities" class="Tabs-item ProfileMainPrivacy-pointerWrapper Tabs-item--noMeta">
							<a class="Tabs-link" href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName=${param.userUpdateName}">
								<span class="Tabs-link">动态</span>
							</a>
						</li>
					</div>
					<div id="blog" class="ProfileMainPrivacy-authWrapper">
						<li  class="Tabs-item ProfileMainPrivacy-pointerWrapper Tabs-item--noMeta">
							<a class="Tabs-link" href="<%=basePath%>getUserUpdate.action?category=blog&userUpdateName=${param.userUpdateName}">	
								<span class="Tabs-link">见闻</span>
							</a>
						</li>
					</div>
					<div class="ProfileMainPrivacy-authWrapper">
						<li id="answer" class="Tabs-item ProfileMainPrivacy-pointerWrapper Tabs-item--noMeta">
							<a class="Tabs-link" href="<%=basePath%>getUserUpdate.action?category=answer&userUpdateName=${param.userUpdateName}">
								<span class="Tabs-link">回答</span>
							</a>
						</li>
					</div>
					<div id="question" class="ProfileMainPrivacy-authWrapper">
						<li class="Tabs-item ProfileMainPrivacy-pointerWrapper Tabs-item--noMeta">
						 	<a class="Tabs-link" href="<%=basePath%>getUserUpdate.action?category=question&userUpdateName=${param.userUpdateName}">
								<span class="Tabs-link">提问</span>
							</a>
						</li>
					</div>
					<div id="focusQuestion" class="ProfileMainPrivacy-authWrapper">
						<li class="Tabs-item ProfileMainPrivacy-pointerWrapper Tabs-item--noMeta">
							<a class="Tabs-link" href="<%=basePath%>getUserUpdate.action?category=focusQuestion&userUpdateName=${param.userUpdateName}">	
								<span class="Tabs-link">关注的问题</span>
							</a>
						</li>
					</div>
					<div id="following"class="ProfileMainPrivacy-authWrapper">
						<li class="Tabs-item ProfileMainPrivacy-pointerWrapper Tabs-item--noMeta">
							<a class="Tabs-link" href="<%=basePath%>getUserUpdate.action?category=following&userUpdateName=${param.userUpdateName}&currentPage=1">	
								<span class="Tabs-link">关注了</span>
							</a>
						</li>
					</div>
					<div id="follower" class="ProfileMainPrivacy-authWrapper">
						<li class="Tabs-item ProfileMainPrivacy-pointerWrapper Tabs-item--noMeta">
							<a class="Tabs-link" href="<%=basePath%>getUserUpdate.action?category=follower&userUpdateName=${param.userUpdateName}&currentPage=1">	
								<span class="Tabs-link">关注者</span>
							</a>
						</li>
					</div>
				</ul>
			</div>
			<!--个人动态  -->
			<div class="List Profile-answers">
				<div class="List-header">
					<h4 class="List-headerText">
						<c:choose>
							<c:when test="${empty (isOwner)}">
								<span>TA的
							</c:when>
							<c:otherwise>
								<span>我的
							</c:otherwise>
						</c:choose>
						<c:if test="${param.category == 'activities'}">动态</span></c:if>
						<c:if test="${param.category == 'blog'}">见闻</span></c:if>
						<c:if test="${param.category == 'answer'}">回答</span></c:if>
						<c:if test="${param.category == 'question'}">提问</span></c:if>
						<c:if test="${param.category == 'focusQuestion'}">关注的问题</span></c:if>
						<c:if test="${param.category == 'follower'}">关注者</span></c:if>
						<c:if test="${param.category == 'following'}">关注</span></c:if>
					</h4>
				</div>
				<div class = "append">
				<!--  进行分类区别   -->
				<c:if test="${param.category != 'following' && param.category != 'follower'}">
				   <c:forEach items="${userUpdateList}" var="update">
					  <div class="List-item">
						<div style="margin-bottom: 25;font-size: 16;">	
						 <div class="List-itemMeta">
						 	<div class="ActivityItem-meta">
						 		<span class="ActivityItem-metaTitle">
						 			${update.flag}  <!--文章的类别   点赞了**   发表了游记...  -->
						 		</span>
						 		<span>${fn:substring(update.time,0,16)}</span>
						 	</div>
						 </div>
						 <div style="padding-bottom: 20px; border-bottom: 1px solid #f3f3f3;" >
							<c:if test="${update.flag == '点赞了景点' }" > 
								<a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=${update.other_id}" >
									<h2 class="ContentItem-title">
										${update.title}
									</h2>
								</a>	
							 </c:if>
							 <c:if test="${update.flag == '点赞了游记' || update.flag == '发表了游记' }" > 
								<a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${update.other_id}" >
									<h2 class="ContentItem-title">
										${update.title}
									</h2>
								</a>	
							 </c:if>
							 <c:if test="${update.flag == '关注了问题' || update.flag == '提出了问题' }" > 
								<a target="_blank" href="<%=basePath%>talk/getQuestionDetail.action?question.id=${update.other_id}" >
									<h2 class="ContentItem-title">
										${update.title}
									</h2>
								</a>	
							 </c:if>
							 <!--当点击问题标题是     只显示被点赞的回答或者本人回答（显示一个）     会有（提示展开全部回答按钮）点击展开  可见全部回答       -->
							 <c:if test="${update.flag == '点赞了回答' || update.flag == '回答了问题'}" > <!-- 用名字作为传递的userID号 -->
								<a target="_blank" href="<%=basePath%>talk/getQuestionDetail.action?question.id=${update.other_id}&isShowAnswerAll=false&userUpdateName=${userUpdateName}" >
									<h2 class="ContentItem-title">
										${update.title}
									</h2>
								</a>	
							 </c:if>
							 <!--上面的显示 动态flag 和 动态标题  -->
							 <!-- 下面显被。。的详情内容 -->
							<div class="ContentItem-meta">
							 
								<div>
								    <c:if test="${update.author != null}">
									<div class="AuthorInfo ArticleItem-authorInfo">
										<span class="UserLink AuthorInfo-avatarWrapper">
											<div class="Popover">
												<div>
													<a target="_blank" href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName=${update.author.username}"> 
														<img height="25" width="25" class="Avatar AuthorInfo-avatar" 
															 src="<%=basePath %>${update.author.avatar}">
													</a>
												</div>
											</div>
										</span>
										<div class="AuthorInfo-content">
											<div class="AuthorInfo-head">
												<span class="UserLink AuthorInfo-name">
													 ${update.author.username}
												</span>
											</div>
										</div>
										
									</div>
									</c:if>	
									<c:if test="${update.count != null}">
										<div class="ArticleItem-extraInfo">
											<span class="Voters">
												${update.count}  
												<c:if test="${update.flag == '点赞了景点'}">
													人想去
												</c:if>
												<c:if test="${update.flag == '发表了游记'  || update.flag == '点赞了游记' || update.flag == '点赞了回答' || update.flag == '回答了问题'}">
													人点赞
												</c:if>
												<c:if test="${update.flag == '关注了问题'}">
													人关注
												</c:if>
											</span>
										</div>
									</c:if>
								</div>
							  
							</div>
							 <div class="RichContent is-collapsed">
							  <c:if test="${fn:length(update.content) != 0 }"> 
								<div class="RichContent-inner" style="max-height: 400px;">
									<span class="RichText CopyrightRichText-richText">${update.content}...</span>
								</div>
								<%-- <c:if test="${sessionScope.name ==  userUpdateName}">
									 <div class="ContentItem-actions" >
										 <button class="Button ContentItem-action Button--plain" style="margin-left: 0px;">
										 	<img  alt="修改" src="<%=basePath%>image/revice.png" height="20" width="20">
										 	修改
										 </button>
										 <button class="Button ContentItem-action Button--plain" >
										 	<img  alt="删除" src="<%=basePath%>image/delete.png" height="20" width="20">
										 	删除
										 </button>
									</div> 
								</c:if> --%> 
							</c:if> 
							</div>	
						 </div>
						 </div>
						 </div>
					  </c:forEach> 
					 
				  </c:if>
				  <c:if test="${param.category == 'following' || param.category == 'follower'}">
				  	<c:forEach items="${userFocusOrNot}" var="person">  
				  	  <div class="List-item" style="border-bottom: 1px solid #f0f2f7;">
				  	  	  	<div class="ContentItem">
				  	  	  		<div class="ContentItem-main">
				  	  	  			<div class="ContentItem-image">
				  	  	  				<span class="UserLink UserItem-avatar">
				  	  	  					<div class="Popover">
				  	  	  						<div>
				  	  	  							<a class="UserLink-link" target="_blank" href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName=${person.user.username}">
				  	  	  								<img height="60px" width="60px" class="Avatar Avatar--large UserLink-avatar"
				  	  	  								 src="<%=basePath%>${person.user.avatar}">
				  	  	  							</a>
				  	  	  						</div>
				  	  	  					</div>
				  	  	  				</span>
				  	  	  			</div>
				  	  	  			<div class="ContentItem-head">
				  	  	  				<h2 class="ContentItem-title">
				  	  	  					<div class="UserItem-title">
				  	  	  						<span class="UserLink UserItem-name">
				  	  	  							<div class="Popover">
				  	  	  								<div>
				  	  	  									<a class="UserLink-link"target="_blank">${person.user.username}</a>
				  	  	  								</div>
				  	  	  							</div>
				  	  	  						</span>
				  	  	  					</div>
				  	  	  				</h2>
				  	  	  				<div class="ContentItem-meta">
				  	  	  					<div>
				  	  	  						${person.user.individualSignature}
				  	  	  						<div class="ContentItem-status">
				  	  	  							<span class="ContentItem-statusItem">
				  	  	  								${person.user.answerCount}&nbsp;回答</span>&nbsp;
				  	  	  							<span class="ContentItem-statusItem">
				  	  	  								${person.user.blogCount}&nbsp;见闻</span>&nbsp;
				  	  	  							<span class="ContentItem-statusItem">
				  	  	  								${person.user.followerCount}&nbsp;关注者</span>&nbsp;
				  	  	  						</div>
				  	  	  					</div>
				  	  	  				</div>
				  	  	  			</div>
				  	  	  			<div class="ContentItem-extra">
				  	  	  			  <c:choose>
				  	  	  			    <c:when test="${person.isFocus == 'true'}">
				  	  	  					<button id="${person.user.username}" class="Button FollowButton Button--primary Button--grey">已关注</button>
				  	  	  				</c:when>
				  	  	  				<c:otherwise>
				  	  	  					<button id="${person.user.username}" class="Button FollowButton Button--primary Button--blue">关注TA</button>
				  	  	  			  	</c:otherwise>
				  	  	  			  </c:choose>		
				  	  	  			</div>
				  	  	  		</div>
				  	  	  	</div>
				  	  </div>
				  	 </c:forEach> 
				  	 <div class="Pagination">
				  	 	 
				  	 </div>	
				 </c:if>
				</div>
			</div>
		
		</div>
 
	</div>
	<!--下面的是边侧  -->
	 <div class="Profile-sideColumn" style="margin-left: 20;">
		<div class="Card">
			<div class="Card-header Profile-sideColumnTitle">
				<div class="Card-headerText">个人成就</div>
			</div>
			<div class="Profile-sideColumnItems" style="font-size: 17px;">
				<div class="Profile-sideColumnItem">
					<div class="IconGraf">
						<span><img height="16px" width="16px" src="${pageContext.request.contextPath}/image/great.png" /> </span>
						获得&nbsp;${user.greatCount}&nbsp;个赞同
					</div>
					<div class="IconGraf">
						<span><img height="16px" width="16px" src="${pageContext.request.contextPath}/image/article.png" /> </span>
						发表了&nbsp;${user.blogCount}&nbsp;篇见闻
					</div>
					<div class="IconGraf">
						<span><img height="16px" width="16px" src="${pageContext.request.contextPath}/image/answer-count.png" /> </span>
						回答了&nbsp;${user.answerCount}&nbsp;个问题
					</div>
					
				</div>
			</div>
		</div>
		<div class="Card FollowshipCard">
			<div class="NumberBoard FollowshipCard-counts">
				<a class="Button NumberBoard-item Button--plain" type="button">
					<div class="NumberBoard-name">关注了</div>
					<div id="followingCount" class="NumberBoard-value">${user.followingCount }</div>
				</a>
				<div class="NumberBoard-divider"></div>
				<a class="Button NumberBoard-item Button--plain" type="button">
					<div class="NumberBoard-name">关注者</div>
					<div class="NumberBoard-value">&nbsp;${user.followerCount}</div>
				</a>
			</div>
		</div>
		<div class="Profile-lightList">
			<a class="Profile-lightItem"  >
				<span class="Profile-lightItemName">关注的问题</span>
				<span class="Profile-lightItemValue">${user.questionCount}</span>
			</a>
		</div>
	</div> 
</div>	
 <!--返回顶部  -->
<a href="#0" class="cd-top">Top</a>

<script type="text/javascript">
 
	var currentPage = Number('${param.currentPage}');
	var category = '${param.category}';
	$(function(){
		//定位滚轮 
		 //if(Number($('.Profile-main').offset().top) > 100)
			// $('html,body').animate({scrollTop: $('.Profile-main').offset().top}, 1000);
		//第一次加载进来设置分页
		var reslut2 =  getPaginaion();
		$('.Pagination').empty();
		$('.Pagination').append(reslut2);
		setCurrentPage();
	});

	function setCurrentPage(){
		$('.PaginationButton').each(function(){
			if($(this).text() == currentPage){
				$(this).addClass('PaginationButton--current');
			}else {
				$(this).removeClass('PaginationButton--current');
			}
		});
	}

	
	//分页
	$(function(){
		  $('body').on('click', '.PaginationButton', function() {
		  
		  if(!$(this).hasClass('PaginationButton--current')){
					
					var state = {
								title : currentPage,
								selector: '.append',
								content : $('.append').html(),
								url : 'http://localhost:8080/City/getUserUpdate.action?category='+ category +'&userUpdateName=cc&currentPage=' + currentPage
					 };
					 
					window.history.pushState(state,state.title,state.url);
					
					if($(this).text() == '上一页' && currentPage != 1){
						 currentPage = currentPage - 1;
					}else if($(this).text() == '下一页' && Number('${totalPage}') != currentPage){
						 currentPage = currentPage + 1;
					}else if($(this).text() != '上一页' && $(this).text() != '下一页'){
						currentPage = Number($(this).text());
					}else {
						return;
					}
					category = '${param.category}';	
					var url = '<%=basePath%>' + 'getFollowPagination.action?category=' + category + '&userUpdateName=' + '${param.userUpdateName}';
					var ar = {"currentPage" : Number(currentPage)};
					var args = JSON.stringify(ar);
					var result = '';
					$.post(url, {json : args}, 
						function(data){
							for(var i = 0; i < data.length; i++){
								var temp = '';
								if(data[i].userFocusOrNot.isFocus == 'true'){
									temp = '<button id="' + data[i].userFocusOrNot.user.username + '" class="Button FollowButton Button--primary Button--grey">已关注</button>';
								}else{
									temp = '<button id="' + data[i].userFocusOrNot.user.username + '" class="Button FollowButton Button--primary Button--blue">关注TA</button>';
								}
							
								result += '<div class="List-item" style="border-bottom: 1px solid #f0f2f7;">' +
											 '<div class="ContentItem">' +
											 	'<div class="ContentItem-main">' +
											 		'<div class="ContentItem-image">' +
											 				'<span class="UserLink UserItem-avatar">' +
											 						'<div class="Popover"><div><a class="UserLink-link" target="_blank">' +
											 								'<img height="60px" width="60px" class="Avatar Avatar--large UserLink-avatar"' +
											 									'src="<%=basePath%>' + data[i].userFocusOrNot.user.avatar +'">' +
											 						 '</a></div></div>'	+
											 				'</span>' +	
											 		  '</div>' +
											 	'<div class="ContentItem-head"><h2 class="ContentItem-title"><div class="UserItem-title">'+
											 			'<span class="UserLink UserItem-name"><div class="Popover"><div><a class="UserLink-link"target="_blank">' +
											 					 data[i].userFocusOrNot.user.username +
											 			 '</a></div></div></span>'	+
											 	 		'</div></h2>' +
											 	 		'<div class="ContentItem-meta"><div>' +
											 	 			  data[i].userFocusOrNot.user.individualSignature +
											 	 			  '<div class="ContentItem-status">' +
											 	 			  		'<span class="ContentItem-statusItem">'	+ data[i].userFocusOrNot.user.answerCount + '&nbsp;回答</span>&nbsp;' +
											 	 			  		'<span class="ContentItem-statusItem">'	+ data[i].userFocusOrNot.user.blogCount + '&nbsp;见闻</span>&nbsp;' +
											 	 			  		'<span class="ContentItem-statusItem">'	+ data[i].userFocusOrNot.user.followerCount + '&nbsp;关注者</span>&nbsp;' + 
											 	 			  	'</div>' +
											 	 			'</div></div></div>' +	
											 	 '<div class="ContentItem-extra">' + temp +
											 	 '</div></div></div></div>';
											 	 		 
							}
							 var reslut3 =  getPaginaion();
							$('.Pagination').empty();
							$('.Pagination').append(reslut3);
 							
							setCurrentPage(); 
		 
							$('.append .List-item').remove();
							$('.Pagination').before(result);
							$("html,body").animate({scrollTop: $(".Profile-main").offset().top}, 1000);
							
							var state2 = {
								title : currentPage,
								selector: '.append',
								content : $('.append').html(),
								url : 'http://localhost:8080/City/getUserUpdate.action?category='+ category +'&userUpdateName=cc&currentPage=' + currentPage
							};
							
							window.history.replaceState(state2,state2.title,state2.url);
							window.addEventListener('popstate', function(e){
								var state = history.state;
								if(state == null) return;
								if(state.content == undefined) return;
						
								 $(state.selector).html(state.content);
								 window.history.replaceState(state,state.title,state.url);
							 
							});
 
						}
					,"json");
					}
 
			}); 
		}); 
 
	//分页
	function getPaginaion(){
		var reslut2 = '';
		reslut2 += '<button class="Button PaginationButton PaginationButton-prev Button--plain" type="button">上一页</button>';
		if(currentPage != 1){
				reslut2 += '<button class="Button PaginationButton Button--plain">1</button>';
		}
		if(currentPage - 1 >= 3){
				reslut2 += '<span class="PaginationButton PaginationButton--fake">...</span>';
		}
		if(currentPage - 1 >= 2){
			reslut2 += '<button class="Button PaginationButton Button--plain">' + (currentPage - 1) + '</button>';
		}
		reslut2 += '<button class="Button PaginationButton  Button--plain">' + currentPage + '</button>';
		if(currentPage + 1 < Number('${totalPage}')){
			reslut2 += '<button class="Button PaginationButton Button--plain">' + (currentPage + 1) + '</button>';
		}
		if(Number('${totalPage}') - currentPage >= 3){
			reslut2 += '<span class="PaginationButton PaginationButton--fake">...</span>';
		}
		if(Number('${totalPage}') != currentPage){
			reslut2 += '<button class="Button PaginationButton Button--plain">' + Number('${totalPage}') + '</button>';
		}
		reslut2 += '<button class="Button PaginationButton PaginationButton-prev Button--plain" type="button">下一页</button>';
		return reslut2;
	}
	
	
	//滚轮自动加载更多
	var startCount = '${fn:length(userUpdateList)}';//最开始有的长度
	var size = 2;//每次加载数
	var count = 0;//已经加载的次数
	var startRow =  Number(startCount); //需从后台从第几条开始
	var isEnd = false;
	var state = false; //防止快速滚轮
	
	$(function(){
		var category = '${param.category}';
		$(window).scroll(function(){
			if(isEnd == true){
				return ;
			}
			//进行加载
			if($(document).height() - $(this).scrollTop() - document.body.clientHeight  < 150 && state == false && category != 'following' && category != 'follwer'){
		  		 getData();
				 state = true;
			 }
		});
		
	});
	
	function getData(){
		var category = '${param.category}';				
		var url = '<%=basePath%>' + 'getUserUpdateMore.action?category=' + category + '&userUpdateName=' + '${param.userUpdateName}';
		var ar = {"startRow" : startRow, "size" : size};
		var args = JSON.stringify(ar);
		var result = '';
		$.post(url, {json : args}, 
			function(data){
				for(var i = 0; i < data.length; i++){
					var temp = '';
					if(data[i].userUpdate.flag == '点赞了景点'){
						temp =  '<a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=' + data[i].userUpdate.other_id + '" >' ;
					}else if(data[i].userUpdate.flag == '点赞了游记' || data[i].userUpdate.flag == '发表了游记'){
						temp =  '<a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=' + data[i].userUpdate.other_id + '" >';
					}else if(data[i].userUpdate.flag == '关注了问题' || data[i].userUpdate.flag == '提出了问题'){
						temp =  '<a target="_blank" href="<%=basePath%>talk/getQuestionDetail.action?question.id=' + data[i].userUpdate.other_id + '" >';
					}else if(data[i].userUpdate.flag == '点赞了回答' || data[i].userUpdate.flag == '回答了问题'){
						temp =  '<a target="_blank" href="<%=basePath%>talk/getQuestionDetail.action?question.id=' + data[i].userUpdate.other_id + '&isShowAnswerAll=false&userUpdateName=${userUpdateName}" >';
					}
					
					var temp2 = '';
					
					if(data[i].userUpdate.author != null){
						temp2 = '<div class="AuthorInfo ArticleItem-authorInfo">' +
									'<span class="UserLink AuthorInfo-avatarWrapper">' +
										 '<div class="Popover">' +
								 	     		'<div>' +
								 	     			'<a target="_blank" href="<%=basePath%>getUserUpdate.action?category=activities&userUpdateName='+ data[i].userUpdate.author.username +'">' +
								 	     				  	'<img height="25" width="25" class="Avatar AuthorInfo-avatar"' +
								 	     				  		' src="<%=basePath %>' + data[i].userUpdate.author.avatar + '">' +
								 	     			'</a>' +
								 	     		'</div>' +
								 	     	'</div>' +
								 	 '</span>' +
								 	  '<div class="AuthorInfo-content">' +
								 	    '<div class="AuthorInfo-head">' +
								 	     	'<span class="UserLink AuthorInfo-name">' +
								 	     			data[i].userUpdate.author.username +
								 	     	'</span>' +
								 	     '</div>' +
								 	  '</div>' +
								'</div>';
					}
					var temp3 = ''
					if(data[i].userUpdate.count != 0){
						temp3 =  '<div class="ArticleItem-extraInfo">' +
								 	     '<span class="Voters">'	 +
								 	     	  data[i].userUpdate.count ;
						 if(data[i].userUpdate.flag == '点赞了景点'){
						 	temp3 += '人想去';
						 }else if(data[i].userUpdate.flag == '发表了游记' || data[i].userUpdate.flag == '点赞了游记' || data[i].userUpdate.flag == '点赞了回答' || data[i].userUpdate.flag == '回答了问题'){
						 	temp3 += '人点赞';
						 }else if(data[i].userUpdate.flag == '关注了问题'){
						 	temp3 += '人关注';
						 }
						
						 temp3 += '</span></div>';
					}
					var temp4 = '';
					if(data[i].userUpdate.content != ''){
					   //alert(data[i].userUpdate.content);
						  temp4 += '<div class="RichContent-inner" style="max-height: 400px;">' +
								 	  '<span class="RichText CopyrightRichText-richText">' + data[i].userUpdate.content + '...</span>' +		 
								   '</div>' ;
								 	     	 
					}
 
					result += '<div class="List-item">' +
								 '<div style="margin-bottom: 25;font-size: 16;">' +
								 	'<div class="List-itemMeta">' +
								 	   '<div class="ActivityItem-meta">' +
								 	   	  '<span class="ActivityItem-metaTitle">' +
								 	   	     	data[i].userUpdate.flag +
								 	   	    '</span>' +
								 	   	    '<span>2017-'+ Number(data[i].userUpdate.time.month + 1) + '-' + data[i].userUpdate.time.date + '&nbsp;' + data[i].userUpdate.time.hours +':'+ data[i].userUpdate.time.minutes +'</span>' + 	
								 	   	 '</div>' +
								 	   '</div>' +
								 	'<div style="padding-bottom: 20px; border-bottom: 1px solid #f3f3f3;" >' +
								 		   temp	+
								 		   	'<h2 class="ContentItem-title">' +
								 				         data[i].userUpdate.title +
								 				    '</h2>' +
								 			 '</a>' +
								 			 	 
								 	     	'<div class="ContentItem-meta">' +
								 	     		'<div>' + temp2 +
								 	     		     temp3 +
								 	     				'</div>' +
								 	     			'</div>' +
								 	     		'<div class="RichContent is-collapsed">' +
								 	     			 temp4 +
								 	     	  	'</div>	' +
								 	     	  	'</div>	</div>	</div>	' ;
								 	     	  		 	
					isEnd = data[i].isEnd;  	
				}
				count++;
 				startRow = Number(startCount) + Number(count) * Number(size);
 
 				$('.append').append(result);
				state = false;
			}
		,"json");
		
	}
	

</script>
</body>	

</html>


