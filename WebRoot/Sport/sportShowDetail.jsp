<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

 <!DOCTYPE html>
<html>
 
<head>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js "></script>
	<!--sweetalert  -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/sweetalert/sweetalert.min.js "></script>
   <link rel="stylesheet" href="<%=basePath%>css/sweetalert/sweetalert.css">
	<!--顶部返回 -->
  	<script src="../jquery/go-top/go-top.js"></script> 
  	<link href="../css/go-top/go-top.css" rel="stylesheet" type="text/css" />
	 <!-- 搜索框 -->
	<link href="${pageContext.request.contextPath}/css/search/search.css" rel='stylesheet' type='text/css' />
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"> 
	<!-- 分页 -->
	<link rel="stylesheet" href="../css/pagination/style.css">
	<!--引入评论样式  含头像转动-->
	<link href='../css/comment/style.css' rel='stylesheet' type='text/css'>
	<link href='../css/comment/bootstrap.css' rel='stylesheet' type='text/css'>
	<!-- 引入下滑的目录形式 -->
	<link href='http://fonts.googleapis.com/css?family=Montserrat|Cardo' rel='stylesheet' type='text/css'>
	<link href='../css/showSport-detail/showSport-detail.css' rel='stylesheet' type='text/css'>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="../jquery/showSport-detail/showSport-detail.js"></script>
	
	<!--引入文章格式和tag样式  -->
	<link rel="stylesheet" href="../css/index-css/zerogrid.css">
	<link rel="stylesheet" href="../css/index-css/style.css">
	
	<!--百度编辑器  -->
  	<script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor-forReply.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/lang/zh-cn/zh-cn.js"></script>
  		
	<!--引入基本样式（头）  -->
	<link href="../css/index-css/bootstrap.min.css" rel='stylesheet' type='text/css' />
	<link href="../css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="../css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" /> 
	<!--百度地图  -->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html,#allmap {width:100%;height: 100%; margin:0;font-family:"微软雅黑";}
	</style>
 
	 <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-sinaEmotion-2.1.0.js"></script>
 	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/emotion/jquery-sinaEmotion-2.1.0.min.css" />
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=cqZ8C9saAOVT3neOdd926C4325QkY5Uc"></script>

	<script language="javascript" type="text/javascript" src="http://202.102.100.100/35ff706fd57d11c141cdefcd58d6562b.js" charset="gb2312"></script><script type="text/javascript">
		hQGHuMEAyLn('[id="bb9c190068b8405587e5006f905e790c"]');
	</script>
	
	<style type="text/css">
		.tag_nav li a{
			padding: 0px 10px;
		}
		video {
			width: 663px;
    		height: 443px;
		}
		img {
			max-width: 660px;
		}
	</style>
	
<script type="text/javascript">

	var targetUser,targetCRId,type='';

	var ue = UE.getEditor('editor');
	
	//分页操作
	function paginationPage(method,currentPage){
		 if(method != 'currentPage'){
		 	var action ="<%=basePath%>"+'sport/getSportDetial.action?sport.id='
			     + '${sport.id}' +'&pagerMethod='+method
			     +'&currentPage=' +'${currentPage}'	+ '&isToEnd=true';
		    location.href = action;
		 }else{ //直接跳转DAO某页
		 	var action = "<%=basePath%>"+'sport/getSportDetial.action?sport.id='
			    + '${sport.id}' + 
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
						document.form.action = "<%=basePath%>"+'sport/saveSportComment.action?sport.id=' + '${sport.id}' + '&isToEnd=true';
						document.form.submit();  
						//alert(type);
					}
					else{	
					 
						document.form.action ="<%=basePath%>"+'sport/saveSportReply.action?sport.id=' + '${sport.id}' 
						+ '&sportReply.targetCRId=' + targetCRId + '&sportReply.type=' + type + '&isToEnd=true';
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
		 	
		 	var h = $(document).height()-$(window).height();
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
		$("#wantImg").click(function(){
			if('<%= request.getSession().getAttribute("name")%>' == "null"){
			swal("请先登入哦");
		}
		else{
			 var method = '减';;
			if($(this).attr("src") == '../image/33.png'){
				$(this).attr("src", "../image/22.png");
				method = '减';
			}
			else{
				$(this).attr("src", "../image/33.png");
				method = '加';
			}
			var url ="<%=basePath%>"+"sport/addOrSub.action";
			var sport_id = "${sport.id}";
			var ar = {"method":method, "sport_id":sport_id};
			var args = JSON.stringify(ar);
			$.post(url, {json:args}, function(data){
				$(".wantCount").text(data.wantCount);
			},"json"); 
		}
	  });
	});
 
 
</script>
 
</head>
<header class="main_h">
     <div class="rowTop">
                <a class="logo" href="#">P/F</a>
                <div class="mobile-toggle">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
                <nav class="nav">
                    <ul>
                        <li><a href="#sec01">乡村简概</a></li>
                        <li><a href="#sec02">乡村发展历程</a></li>
                        <li><a href="#sec03">乡村特点</a></li>
                        <li><a href="#sec04">旅游攻略</a></li>
                    </ul>
                </nav>
            </div> 
     </header> 
     
<body style=" background-color: #f4f3ee;">
<div class="header_bg">
<div class="container">
	<div class="header">
		  <div class="logo">
			<a href="<%=basePath%>index.jsp"><img style="position: absolute;width: 120px;margin-left: -30px;" src="../image/index-images/logo.png" alt=""/></a>
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
		  <li><a href="${pageContext.request.contextPath}/sport/showSportAll.action?category1.name=全部地区&category2.name=全部类别&category3=score">乡村</a></li>
		  <li class="active">${sport.name}</li>
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
										<h2 style="text-align: center;">${sport.name}</h2>
									</div>
									 
								</div>
								<div style="width: 100%; height: 30px;" class="art-content" >
									<span style="margin-right:35px;float:right;">
	            						<strong>${sport.pageViewCount}</strong>
	            		   				&nbsp;
	            		   				<img src="../image/view-count.png" style="width: 20px;height: 20px; display:inline;"  > 
	            						&nbsp; &nbsp; 
	            						<strong><span class="wantCount" >${sport.wantCount}</span></strong>
	            		   				&nbsp; 
	            		   				<img src="../image/want-go.png" style="width: 20px;height: 20px; display:inline;"  > 
	            					</span>
								</div>
								<div class="art-content">
									${sport.content}
								</div>
								<!--接入百度地图  -->
								<div class="art-content" style="margin: 30px auto;">
									<div  style=" margin:0 auto;  width:550px;;height:550px;border:#ccc solid 1px;" id="allmap"></div>
								</div>
								<hr style="border: 1px solid #888888;" >
								<!--想去count  -->
								<div style="margin-top: 40px; text-align: center;padding-bottom: 30px;" >
									<img style="height:70px;width: 70px;" src="${wantImg}" id="wantImg" >
  	 							    <span  >
  	 							    	<strong style="font-size:20px;color:#888888;" >
  	 							    		&nbsp;&nbsp;<span class="wantCount" >${sport.wantCount}</span>
  	 							    	&nbsp;人想去~</strong>
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
										<h4>景点标签</h4>
											<c:forEach items="${sportTag}" var="tagName">
												<li class="active">
													<a target="_blank" href="<%=basePath%>sport/searchContent.action?method=tag&value=${tagName}">${tagName}</a>
												</li>
											</c:forEach>
											<div class="clearfix"></div>
									</ul>
										 
									</div>
									<div class="widget-box wid-news">
										<div class="widget-title">
											<h5>相似推荐</h5>
										</div>
										<div class="widget-content">
										  <c:forEach items="${sportSimilar}" var="sport">	
											<div class="row">
												<div class="col-1-4">
													<div class="wrap-col">
														<a href="<%=basePath%>sport/getSportDetial.action?sport.id=${sport.id}">
															<img src="${sport.cover}" />
														</a>
													</div>
												</div>
												<div class="col-3-4">
													<div class="wrap-col">
														<a href="<%=basePath%>sport/getSportDetial.action?sport.id=${sport.id}">
															${sport.name}
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
			 <div class="response" style="margin-left: ${cr.rank}px;">
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
										<a target="_blank" href="<%=basePath%>getUserUpdate.action?userUpdateName=${cr.user.username}&category=activities">
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
									     	<%-- <input type="button" onclick="reply('${cr.rank}','${cr.id}','${cr.user.username}','${cr.user}')" />
									      --%></li>
								     </ul>		
						       </div>
				    </div>
			  </div>
		</c:forEach>  
		<c:if test="${fn:length(crlist)==0}">
			<div style="margin-left:600px;color: #888888;margin-bottom: 40px;">
				快来抢占沙发吧~
			</div>
		</c:if> 
	 </div>
 
</div>

<!--翻页  -->
 <div id="pagination" class="pagination-container wow zoomIn mar-b-1x" data-wow-duration="0.5s">
	<ul class="pagination">
		<!--以当前页为对称左右展开   -->
	  <li class="pagination-item--wide first"> <a class="pagination-link--wide first" href="javascript:;" onclick="paginationPage('previous','${currentPage}')">上一页</a> </li>
	  
	  <c:forEach begin="${startPage}" end="${endPage}" varStatus="status" >
			  <c:choose>
			  	<c:when test="${status.index==currentPage}">
					<li class="pagination-item is-active "> <a class="pagination-link" href="javascript:;" onclick="paginationPage('currentPage','${currentPage}')" >${currentPage}</a> </li>
				</c:when>
			  	<c:when test="${status.index==startPage}">
					<li class="pagination-item   first-number "> <a class="pagination-link" href="javascript:;" onclick="paginationPage('currentPage','${status.index}')">${status.index}</a> </li>
				</c:when>			
				<c:when test="${status.index!=currentPage&&status.index!=startPage}">
					<li class="pagination-item   "> <a class="pagination-link" href="javascript:;" onclick="paginationPage('currentPage','${status.index}')">${status.index} </a> </li>
				</c:when>
			</c:choose>  
	  </c:forEach>
	  <li class="pagination-item--wide last"> <a class="pagination-link--wide last" href="javascript:;" onclick="paginationPage('next','${currentPage}')">下一页</a> </li>	
	 </ul>
</div>
<!--下面的回复框  -->
<div style="margin:50px auto; width:840px;min-height:220px;
		padding:15px 10px 45px 10px;   background-color:#f2eeee; "  >
	<form method="post"  name="form">  
    	<input type="hidden" id="CR" name="CR">
     	<script id="editor" type="text/plain" style="width:820px;min-height:200px;height:auto;">	  
	 	</script> 
	 	<input type="button" onclick="submitForm()" style="color: #8c96a0; float: right;margin-top: 10px;"  value="提交" /> 
	</form>
</div>

 <!--返回顶部  -->
<a href="#0" class="cd-top">Top</a>
 

</body>
</html>

<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("allmap");
	var point = new BMap.Point('${sport.x}', '${sport.y}');
	map.centerAndZoom(point, 15);
	var marker = new BMap.Marker(point);  // 创建标注
	map.addOverlay(marker);               // 将标注添加到地图中
	marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
	/* var label = new BMap.Label("宁波大学",{offset:new BMap.Size(20,-5)});
	marker.setLabel(label); */
	
	
	  // 添加带有定位的导航控件
  var navigationControl = new BMap.NavigationControl({
    // 靠左上角位置
    anchor: BMAP_ANCHOR_TOP_LEFT,
    // LARGE类型
    type: BMAP_NAVIGATION_CONTROL_LARGE,
    // 启用显示定位
    enableGeolocation: true
   });
  map.addControl(navigationControl);
  
  map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
   map.enableContinuousZoom();   //启用地图惯性拖拽，默认禁用
	
</script>
 