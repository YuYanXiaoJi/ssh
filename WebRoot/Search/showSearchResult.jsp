<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <script type="text/javascript" src="<%=basePath%>jquery/jquery-3.2.1.min.js "></script>
   <!-- 搜索框 -->
	<link href="${pageContext.request.contextPath}/css/search/search.css" rel='stylesheet' type='text/css' />
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"> 
   <!--顶部返回 -->
  	<script src="${pageContext.request.contextPath}/jquery/go-top/go-top.js"></script> 
  	<link href="${pageContext.request.contextPath}/css/go-top/go-top.css" rel="stylesheet" type="text/css" />
   <!--引入基本样式（头）  -->
	<link href="${pageContext.request.contextPath}/css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="${pageContext.request.contextPath}/css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" /> 	
 	<!--  搜索框 -->
 	<link href="${pageContext.request.contextPath}/css/search-result-search/search-result-search.css" rel='stylesheet' type='text/css' />
  	<!-- 分页 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination/style.css">
  	
  <style type="text/css">
  	 a:hover,a:focus {
  	 	color: #888;
  	 }
  	
  </style>	
  		
  
  </head>
  
  <body style="font-family: Arial,"Lucida Grande","Microsoft Yahei","Hiragino Sans GB","Hiragino Sans GB W3",SimSun,"PingFang SC",STHeiti;" >
 <div class="header_bg" style="background: #b3e5e1;">
<div class="container">
	<div class="header"  style="height: 10px; margin-top: -30;">
		<%-- <div class="logo" style="margin-left: -220;">
			<a href="<%=basePath%>index.jsp"><img style="margin-top: -25;" src="${pageContext.request.contextPath}/image/index-images/logo.png" alt=""/></a>
		</div>  -->
		<!--搜索框 --%>
		  <div class="search-header-searchbox" style="margin-bottom: 10px;">
		 	<form   action="<%=basePath%>sport/searchContent.action?method=input" method="post" >
			 	<input id="value" name="value" type="text" placeholder="请输入您要搜索的内容..." >	
			 	<div  class="search bar7" >
			 	 	<button type="submit" style="margin-top:5; margin-right: -50;"></button>
			 	</div>
		 	</form>
		 </div> 
		 
		  
 
		<div class="h_menu" style="    float: initial;width: 1300px;">
		<a id="touch-menu" class="mobile-menu" href="#">Menu</a>
		<nav>
		<ul class="menu list-unstyled">
			<li  ><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
			<li ><a href="${pageContext.request.contextPath}/sport/showSportAll.action?category1.name=全部地区&category2.name=全部类别&category3=score">乡村</a></li>
			<li><a href="${pageContext.request.contextPath}/article/getArticleAll.action">见闻</a></li>
			<li><a href="${pageContext.request.contextPath}/recommend.action">为你推荐</a></li>
			<li style="margin-left: -15"><a href="${pageContext.request.contextPath}/userGetSpecialSchemeAll.action">特别策划</a></li>
			<li style="margin-left: -30"><a href="${pageContext.request.contextPath}/talk/getQuestionAll.action?category=1">秉烛夜谈</a>
			</li> 
			<c:choose>
				<c:when test="${empty (sessionScope.name)}">
					<li><a href="${pageContext.request.contextPath}/User/Login.jsp">登入/注册</a></li>
				</c:when>
				<c:otherwise>
					  <!-- 用户 -->
					  <li class="dropdown topbar-user" style="margin:0px 30px -20px 5px;">
					  <img style="margin-top: -50;width: 48px;height: 48px;" src="<%=basePath%>${sessionScope.img}"  class="img-responsive img-circle"/>
						<ul class="list-unstyled" style="margin-top: -43px;"><!--说明session没有失效  -->
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

<!-- 显示关键字 -->
<div class="search-header-mps" style="  background: #f3f3f3;margin-top: -16;line-height: 70px;height: 70px;">
	<div class="common-wrapper" >
	 	<span>热门搜索：</span>
        <c:forEach items="${tagTopList}" var="tagName" begin="0" end="10">
			 <a class="search-header-mp-item" href="<%=basePath%>sport/searchContent.action?method=tag&value=${tagName.tag}">${tagName.tag}</a> 
 		</c:forEach>  
	</div>
</div>
<!-- 选择类型 -->
<div class="search-header-tabs" style="height: 50;border-bottom: 5px solid #f3f3f3;padding-bottom: 65px;">
	<div class="common-wrapper" style="font-size: 20px;line-height: 50px; ">
		<a href="javascript:;"  class="on"  id="1" >全部</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:;" id="2" >乡村</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:;" id="3" >见闻</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:;" id="4">秉烛夜谈</a>&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
</div>
<!--search的内容  -->
<div class="mfw-search-main">
	<div class="wid clearfix">
		<div class="ser-nums">
			<div class="sr-nums">
				<p class="ser-result-primary">
            		以下是为您找到相关结果&nbsp;<span id="searchCount"></span>&nbsp;条</p>
			</div>
		</div>
		<div class="flt1 ser-lt">
			<div class="_j_search_section">
				<div class="att-list">
					<ul>
					  	<c:choose> 
					  		<c:when test="${empty (searchList) }">
					  			<h2 style="color: #888;margin: 160 0 0 500;">这里空空如也...</h2>
					  		</c:when>
					  		<c:otherwise>
					  	<c:forEach items="${searchList}" var="temp">
						  <c:if test="${temp.flag != 'question'}">
							  <li>
								<div class="clearfix">
									<div class="flt1">
										    <c:if test="${temp.flag == 'article'}">
										    	<a href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${temp.object.id}" target="_blank" class="_j_search_link">
													<img src="<%=basePath%>${temp.object.cover}" style="width:250px;height:170px;">
												</a>
											</c:if>
											<c:if test="${temp.flag == 'sport'}">
												<a href="<%=basePath%>sport/getSportDetial.action?sport.id=${temp.object.id}" target="_blank" class="_j_search_link">
													<img src="${temp.object.cover}" style="width:250px;height:170px;">
												</a>
											</c:if>
										  
									</div>
									<div class="ct-text ">
										<h3>
										 	<c:if test="${temp.flag == 'article'}">
											   <a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id=${temp.object.id}">${temp.object.title}</a>
											</c:if>
											<c:if test="${temp.flag == 'sport'}">
												 <a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id=${temp.object.id}">${temp.object.title}</a>
											</c:if>
										</h3>
										<p class="seg-desc">
											 ${temp.object.content}...
										</p>
									</div>
								 </div>	
						       </li>
					       </c:if>
					       <c:if test="${temp.flag == 'question'}">
					       		<li>
								<div class="clearfix">
									<div class="ct-text" style="margin-left: -280px;">
										<h3>
											 <a target="_blank" href="<%=basePath%>talk/getQuestionDetail?question.id=${temp.object.id}">${temp.object.title}</a>
										</h3>
										<p  class="seg-desc">
											 ${temp.object.content}...
										</p>
									</div>
								 </div>	
						       </li>
					       </c:if>
					     </c:forEach>
					      </c:otherwise>
					  	</c:choose>		
					</ul>
				</div>
			</div>	
			</div>	
		</div>
	</div>
<%-- <c:if test="${fn:length(searchList > 10)}"></c:if> --%>
	<div class="pagination-container wow zoomIn mar-b-1x" 
		style="margin-bottom: 30; margin-left: -330px;"data-wow-duration="0.5s">
	 
 	</div>	

	
<script type="text/javascript">
	
	$(function(){
		$('#value').val('${value}');
		//初始 赋class=on	
		$('.search-header-tabs .common-wrapper a').each(function(){
			if($(this).hasClass('on')) {
				if($(this).text() == '全部') {
					$('#searchCount').text('${searchCount}');
				}
			}
		});
		//分页
		$('.pagination-container').empty(); 
		if('${fn:length(searchList)}' != 0) {
			pagination(Number('${current_page}'),Number('${total_page}'));
		}
 
		//当点击筛选（全部，乡村...）
		$('.search-header-tabs .common-wrapper a').click(function(){
			if (!$(this).hasClass('on')) {
				var temp = $(this);
				$(this).addClass('on');
				$('.search-header-tabs .common-wrapper a').each(function(){
					if ($(this).hasClass('on') && $(this).text() != temp.text()) {
						$(this).removeClass('on');
					}
				});
			   //ajax
			   var category = $(this).text();
			   ajax(1,category);//1为current_page页号码
			}
			
		});
 
	});	
	//点击分页的时候
	$(function(){
      $('body').on('click', '.pagination-container a', function(){
		if(!$(this).hasClass('disable') && !$(this).parent().hasClass('is-active') ) {
			 	var currentPage = 1;
			 	$('.pagination-container a').each(function(){
			 		if($(this).parent().hasClass('is-active')) {
			 			currentPage = Number($(this).text());
			 		}
			 	});
			 	var category = '';
			 	$('.search-header-tabs .common-wrapper a').each(function(){
				if($(this).hasClass('on')) {
					 category =  $(this).text();	 
					}
				});
			 	
			 	if($(this).text() == '上一页') {
			 		ajax(Number(currentPage - 1),category);
			 	}else if($(this).text() == '下一页') {
			 		ajax(Number(currentPage + 1),category);
			 	}else {
			 		ajax(Number($(this).text()),category);
			 	}
			}
		
			});
	});
	
	function ajax(current_page,category) {
			$('html,body').animate({scrollTop: $('.search-header-tabs').offset().top}, 1500);
			var url = '<%=basePath%>sport/getSearchCategory.action';
			var ar = '';
			if('${param.method}' == 'tag'){
				 ar = {'category' : category, 'method' : '${param.method}', 'value' : '${param.value}',
				'current_page' : Number(current_page)};
			}else {
				 ar = {'category' : category, 'method' : '${param.method}', 'value' :  $('#value').val(),
				'current_page' : Number(current_page)};
			}
			var args = JSON.stringify(ar);
			$.post(url,{json:args},function(data){
				//清空分页
					$('.pagination-container').empty();
					if(data.length == 0) {
						var result = '';
						result += '<h2 style="color: #888;margin: 160 0 0 500;">这里空空如也...</h2>';
						$('#searchCount').text('0');
						$('.att-list').empty();
						$('.att-list').append(result);
							
					} else {
						
						var result = '';
						if(category == '全部') {
							for(var i = 0; i < data.list.length; i++) {
								if(data.list[i].flag != 'question') {
									var temp1 = '',temp2 = '',temp3 = '';
									if(data.list[i].flag == 'sport') {
										temp1 = '<img src="'+ data.list[i].object.cover +'" style="width:250px;height:170px;">';
										temp2 = '<%=basePath%>sport/getSportDetial.action?sport.id='+data.list[i].object.id;
										temp3 = data.list[i].object.title;
										temp4 = data.list[i].object.content;
									}else {
									 	temp1 = '<img src="<%=basePath%>'+ data.list[i].object.cover +'" style="width:250px;height:170px;">'; 
										temp2 = '<%=basePath%>article/getArticleDetail.action?userArticle.id='+data.list[i].object.id;
										temp3 = data.list[i].object.title;
										temp4 = data.list[i].object.content;
									}
									result += '<ul><li><div class="clearfix"><div class="flt1">' + '<a href="'+ temp2+ '" target="_blank" class="_j_search_link">' +
												temp1 + '</a>' +
											 '</div><div class="ct-text "><h3>' +
											 	' <a target="_blank" href="'+ temp2+ '">'+temp3+'</a>' +
											 '</h3><p class="seg-desc">'+ temp4 +'...</p></div></div></li></ul>' ;
								}else {
									result += '<ul><li><div class="clearfix"><div class="ct-text" style="margin-left: -280px;"><h3>' +
												' <a target="_blank" href="<%=basePath%>talk/getQuestionDetail?question.id='+data.list[i].object.id+'">'+data.list[i].object.title +'</a></h3>' +
										   '<p class="seg-desc">'+ data.list[i].object.content +'...</p></div></div></li></ul>'	
								}
							 }
							 if(data.list.length != 0) {
							 	pagination(Number(data.current_page),Number(data.total_page));
							 }  	
						}
						else if(category == '乡村') {
							for(var i = 0; i < data.list.length; i++) {
								result += '<ul><li><div class="clearfix"><div class="flt1"><a href="<%=basePath%>sport/getSportDetial.action?sport.id='+ data.list[i].id +'" target="_blank" class="_j_search_link">' +
												'<img src="'+ data.list[i].cover +'" style="width:250px;height:170px;">' +
											 '</a></div><div class="ct-text "><h3>' +
											 	' <a target="_blank" href="<%=basePath%>sport/getSportDetial.action?sport.id='+ data.list[i].id + '">' +data.list[i].name+'</a>' +
											 '</h3><p class="seg-desc">'+ data.list[i].summary +'...</p></div></div></li></ul>' ;

							}
							 if(data.list.length != 0){
							 	pagination(Number(data.current_page),Number(data.total_page));
							 } 	
						}else if(category == '见闻') {//data.list.length
							for(var i = 0; i < data.list.length; i++) {
								result += '<ul>'+
												'<li>'+
													'<div class="clearfix">'+
														'<div class="flt1">'+
															'<a  target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id='+ data.list[i].id +'"  class="_j_search_link">' +
																'<img src="<%=basePath%>'+ data.list[i].cover + '" style="width:250px;height:170px;">' +
													 		'</a>'+
											 			'</div>'+
												 		'<div class="ct-text ">'+
													 		'<h3>' +
													 			' <a target="_blank" href="<%=basePath%>article/getArticleDetail.action?userArticle.id='+data.list[i].id+'">'+ data.list[i].title + '</a>' +
													 		'</h3>'+
													 		'<p class="seg-desc">'+ data.list[i].content +'...</p>'+
												 		'</div>'+
											 		'</div>'+
											 	'</li>'+
											'</ul>' ;
							 }
							 if(data.list.length != 0){
							 	pagination(Number(data.current_page),Number(data.total_page));
							 } 
						}else if(category == '秉烛夜谈') {
							for(var i = 0; i < data.list.length; i++) {
								 result += '<ul><li><div class="clearfix"><div class="ct-text" style="margin-left: -280px;"><h3>' +
												 '<a target="_blank" href="<%=basePath%>talk/getQuestionDetail?question.id='+data.list[i].id +'">' + data.list[i].title +'</a>' +
												 '</h3><p  class="seg-desc">' + data.list[i].content+ '...</p></div></div></li></ul>';			   
							}
							
							 if(data.list.length != 0){
							 	pagination(Number(data.current_page),Number(data.total_page));
							 } 
						}
						$('#searchCount').text(data.length);
						$('.att-list').empty();
					    $('.att-list').append(result);
					    
					 }
					
				}
			,'json');
	}
	
	
	//分页函数
	function pagination(c, t){
		var result = '';
		result += '<ul class="pagination" style="margin-left: -300px;">';
		if(Number(c != 1)) {
			result += '<li class="pagination-item--wide first"> <a class="pagination-link--wide first"  >上一页</a> </li>';				
		}else {
			result += '<li class="pagination-item--wide first "> <a class="pagination-link--wide first disable"  >上一页</a> </li>';
		}
		if(Number(c != 1)) {
			result += '<li class="pagination-item "> <a class="pagination-link">1</a> </li>';
		}
		if(Number(c - 1 >= 3)) {
			result += '<li class="pagination-item   "> <a class="pagination-link disable" >...</a> </li>';
		}
		if(Number(c - 1 >= 2)) {
			result += '<li class="pagination-item   "> <a class="pagination-link " >'+Number(c-1)+'</a> </li>';
		}
		result += '<li class="pagination-item is-active "> <a class="pagination-link" >'+c+'</a></li>';
		if(Number(1 + c < t)) {
			result += '<li class="pagination-item "> <a class="pagination-link"     >'+Number(c+1)+'</a></li>';
		}
		if(Number(t - c >= 3)) {
			result += '<li class="pagination-item   "> <a class="pagination-link disable" >...</a> </li>';
		}
		if(Number(t != c )) {
			result += '  <li class="pagination-item  "> <a class="pagination-link"  >'+t+'</a></li>';
		}
		if(Number(t != c )) {
			result += '<li class="pagination-item--wide last"> <a class="pagination-link--wide last"  >下一页</a> </li>';
		}else {
			result += '<li class="pagination-item--wide last"> <a class="pagination-link--wide last disable"  >下一页</a> </li>';
		}

		$('.pagination-container').append(result);
	}	
		
</script>	
	
	</body>		
	
</html>