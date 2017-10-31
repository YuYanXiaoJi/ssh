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
 	
 	 <link href="<%=basePath%>css/checkbox/checkbox.css" rel="stylesheet" type="text/css" />
 	<!--sweetalert  -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/sweetalert/sweetalert.min.js "></script>
   <link rel="stylesheet" href="<%=basePath%>css/sweetalert/sweetalert.css">
 	<!--上传控件  -->
 	<script type="text/javascript" src="<%=basePath%>jquery/upload-file/ajaxfileupload.js "></script>
 	<!-- input输入框 -->
 	<link href="<%=basePath%>css/form/form.css" rel='stylesheet' type='text/css' />
 	<!--连接 a 按钮  -->
 	<link href="<%=basePath%>css/button/button.css" rel="stylesheet" type="text/css" />
	<!-- 搜索框 -->
	<link href="<%=basePath%>css/search/search.css" rel='stylesheet' type='text/css' />
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"> 
	<!--引入基本样式（头）  -->
	<link href="<%=basePath%>css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="<%=basePath%>css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" /> 
	
	
	<style type="text/css">
		a:hover,a:focus{
			color:white;
		}
		.category input{
			height:20;
		}
		.category span{
			display: block;
			margin-top:-20;
			margin-left:800;
			margin-bottom: 10; 
			width: 100px; 
		}
	</style>
  	
   
  
  </head>
  
  <body style="  text-align: center;">
    <div class="header_bg" style="background: #b3e5e1;">
<div class="container">
	<div class="header"  style="height: 10px; margin-top: -30;">
		<%-- <div class="logo">
			<a href="<%=basePath%>index.jsp"><img style="margin-top: -25;" src="<%=basePath%>image/index-images/logo.png" alt=""/></a>
		</div> --%>
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
			<li>
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
</div> <br>
 <div style="margin: 0 auto;" >
 	<!--个人信息的修改  -->
 	<form id="form"  method="post" enctype="multipart/form-data">
 		 <input type="hidden"  name="user.isForbidden" value="${user.isForbidden}"/>
 		 <input type="hidden" name="user.greatCount" value="${user.greatCount }" /> 
 		 <input type="hidden" name="user.questionCount" value="${user.questionCount }" /> 
 		 <input type="hidden" name="user.followingCount" value="${user.followingCount }" /> 
 		 <input type="hidden" name="user.followerCount" value="${user.followerCount}" /> 
 		 <input type="hidden" name="user.blogCount" value="${user.blogCount }" /> 
 		 <input type="hidden" name="user.answerCount" value="${user.answerCount }" /> 
 		 <input type="hidden" name="user.registerDate" value="${user.registerDate }" />
 		  <input type="hidden" name="user.managerOrNot" value="${user.managerOrNot }" />
 		 <input type="hidden" name="user.id" value="${user.id }" />
 		 <input type="hidden" name="user.username" value="${user.username }" />
  		 <input type="hidden" name="user.avatar" value="${user.avatar}">
 		 <input type="hidden" name="user.background" value="${user.background}">
 		 <input type="hidden" name="tagName" id="tagName">
 		 
 		 
 		 <span style="margin-left: -60;">个性签名</span>
 		 <input id="password" name="user.individualSignature" type="text" required style="width: 300px; margin-left: 43%;" value="${user.individualSignature}"/>
		 <br>
		 <span style="margin-left: -80;">密码</span>
  		 <input id="password" type="text" name="user.password" required style="width: 300px; margin-left: 43%;" value="${user.password }"/>
		  <br> 
		  <div class="report-file" style="margin-left: 43%; margin-top: 10px;">
      		<span>上传头像</span>
      		<input id="avatarfile" tabindex="3" size="3" name="photo" class="file-prew" type="file" onchange="text1()">
 		 </div>
 		<input type="text" id="avatar" style="width:180px; height:50px;border:1px solid darkgray" />
 		
 		<br>
 		<div class="report-file" style="margin-left: 43%; margin-top: 10px;">
      		<span>上传背景</span>
      		<input id="backfile"  tabindex="3" size="3" name="photo" class="file-prew" type="file" onchange="text2()">
 		</div>
 		<input type="text" id="back" style="width:180px; height:50px;border:1px solid darkgray" />
  		
  		
  		<br>
  		
  		<div class="category" > 
 			<input type="checkbox" name="category" value="民族风情"><span style="margin-left: 50%;">民族风情</span>
 			<input type="checkbox" name="category" value="人文历史"><span style="margin-left: 50%;">人文历史</span>
 			<input type="checkbox" name="category" value="田园休闲"><span style="margin-left: 50%;">田园休闲</span>
 			<input type="checkbox" name="category" value="健康生态"><span style="margin-left: 50%;">健康生态</span>
			<input type="checkbox" name="category" value="山青水绿"><span style="margin-left: 50%;">山青水绿</span>
       </div>
  		<br><br>
  		<div style="text-align: center;width: 400px; margin-left: 43%;">
	  		<div class="button" style="text-align: center;float: left;">
	    		<a href="javascript:void(0);" class="more red" id="save">保存</a>
			</div>
			<div class="button" style="text-align: center;float: left;">
	    		<a href="javascript:void(0);" class="more red"  id="cancel">返回</a>
			</div>
		</div>
  	</form>
    </div>
 		
 
     <script type="text/javascript">
     	
     	var array = new Array();
     	//只能选3个
     	$(function(){
     		$('input[type="checkbox"]').click(function(){
     			var length = $('input[type="checkbox"]:checked').length;
     			if($(this).is(':checked') && length == 4){
     				var name = $(this).prop('value');
     				$('input[type="checkbox"]:checked').each(function(){
     					if(name != $(this).prop('value')) {
     						$(this).prop('checked', false);
     						return false;
     					}
     				});
     			}
     			
     		});
     		
     	});
     	
     	//默认赋值用户标签
     	$(function(){
     		var array = '${tagName}'.split('/');
     		$('input[type="checkbox"]').each(function() {
     			for(var i in array) {
     				if(array[i] == $(this).prop('value')) {
     					$(this).prop('checked', true);
     				}
     			}
     		});
     	});
     	
     	//上传的操作 number用来区别是只上传了头像还是只上传了背景还是两个都上传了
     	var number = '';
     	
     	function text1(){
     		var t = $('#avatarfile').val();
     		$('#avatar').val(t);
     		if (number == '') {
     			number = 'one';
     		} else {
     			number = 'all';
     		}
     	}
     	
     	function text2(){
     		var t = $('#backfile').val();
     		$('#back').val(t);
     		if(number == 'one'){
     			number = 'all';
     		}else{
     			number = 'two';
     		}
     	}
     	//保存或者取消 
     	$(function(){
     		
     		$('#cancel').click(function(){
     			location.href = '<%=basePath%>' + 'getUserUpdate.action?category=activities&userUpdateName='+'${sessionScope.name}' ;
     		});
     		
     		$('#save').click(function(){
     			 var tagName = '';
     			 var length = $('input[type="checkbox"]:checked').length;
     			 if(length != 3) {
     			 	swal("必须选择3个兴趣标签哦~");
     			 }else {
				  	 $('input[type="checkbox"]:checked').each(function(){
				  		 tagName += '/' + $(this).prop('value');
				  		 $('#tagName').val(tagName.substr(1));
				  	 });
	     			 $('#form').prop('action','<%=basePath%>updateUser.action?number='+number);
	     			 $('#form').submit();
     			 }
     		});
     	});
     </script>
  </body>
</html>
