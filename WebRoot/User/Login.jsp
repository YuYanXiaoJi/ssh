<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/struts-tags"  prefix="s"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js "></script>
  
  <!--登入样式  -->
  <link rel='stylesheet prefetch' href='https://fonts.googleapis.com/css?family=Open+Sans'>
  <link rel="stylesheet" href="<%=basePath%>css/login.css">
  <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/login.js"></script>
  <!--sweetalert  -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/sweetalert/sweetalert.min.js "></script>
   <link rel="stylesheet" href="<%=basePath%>css/sweetalert/sweetalert.css">
   <!-- 模态框 -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/bootstrap/bootstrap.min.js "></script>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css"> 
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkbox/checkbox.css"> 
   
 
  <script type="text/javascript">
    //切换验证码  
	function change(){  
    	var img1=document.getElementById('checkImg');  
    	img1.src='"<%=basePath%>"/checkImg.action?' + new Date().toString();  
	}  
 	//登入操作
	function login(){
		if($.trim($('#username_login').val()).length ==0 || $.trim($('#password_login').val()).length == 0){
			swal('请填写完整哦~');
		}else{
			var url = '<%=basePath%>' + 'loginValid.action';
		 	var args = {username:$.trim($('#username_login').val())
		 				,password:$.trim($('#password_login').val())
		 		 		,time:new Date()};
		 	var strUser = JSON.stringify(args); //将一个对象解析出字符串// JSON.parse(str)
		
		 	 $.post(url, {json : strUser}, function(data) {		 	   		 
		 	   			if(data.sta == 1){
		 	   				 var backUrl = '<%= request.getHeader("Referer")%>';
		 	   				 if(backUrl == 'null' || backUrl == 'http://localhost:8080/City/User/Login.jsp'){
		 	   				 	location.href = '<%=basePath%>' + 'index.jsp';
		 	   				 }else{
		 	   				 	location.href=backUrl;
		 	   				 }
		 	   			}else if(data.sta == 0) {
		 	   				swal('用户名或密码错误哦~');
		 	   			}else if(data.sta == 2) {  //admin deng ru
		 	   				window.location.href='<%=basePath%>' + 'Admin/index.jsp';
		 	   			} 
		 	   			
		 	   	}, 'json');
			
		}
	}
	//注册验证
	//定义全局变量  
	var flag1,flag2;
	function register() {

		if($.trim($('#username').val()).length == 0){
			$('#msg_username').html('<span style="color:red;">不能为空</span>');
		}
		else if($.trim($('#password').val()).length == 0){
			$('#msg_password').html('<span style="color:red;">不能为空</span>');
		}
		else if($.trim($('#checkcode').val()).length == 0){
			$('#msg_checkcode').html('<span style="color:red;">不能为空</span>');
		}
		else if(flag1 == 0 || flag2 == 0){
			swal("用户名或验证码错误哦~");
		}
		else if($('input[type="checkbox"]:checked').length != 3){
			$('#like').css('color', 'red');
		}
		else{ 
			//swal("注册成功！");
			//setTimeout(function (){
   			 //	$("#registerForm").prop("action","<%-- <%=basePath%>regist.action"); --%>
				//$("#registerForm").submit();
   			//}, 1500); 

		   $('#modal').modal('show');
			  
	 }  
		 
	}
 	//ajax注册用户名
	$(function(){
		$('#username').blur(function(){
		 	var val = $('#username').val();
		 	val = $.trim(val);//去除所有空格
		 	if(val != ''){
		 	   var url = '<%=basePath%>' + 'isExist.action';
		 	   var args = {username:val, time:new Date()};
		 	   var strUser = JSON.stringify(args); //将一个对象解析出字符串// JSON.parse(str)
		 	  $.post(url, {json: strUser}, function(data){		 	   		 
		 	   			if(data.sta == 1){
		 	   				$('#msg_username').css('color', 'green');
		 	   				$('#msg_username').html(data.msg);
		 	   			}else{
		 	   				$('#msg_username').css('color', 'red');
		 	   				$('#msg_username').html(data.msg);
		 	   			}
		 	   			flag1 = data.sta;
		 	   			
		 	   	},'json'); 
		 	};
		});
		//ajax 验证码
		$('#checkcode').change(function(){
			var val2 = $('#checkcode').val();
			val2 = $.trim(val2);
			if(val2 != ''){
				var url2 = '<%=basePath%>' + 'isCheckcodeTrue.action';
				var args2 = {'checkcode' : val2};
				$.post(url2, args2, function(data){
					    if(data.sta == 0){
		 	   				$('#msg_checkcode').css('color', 'red');
		 	   				$('#msg_checkcode').html(data.msg);
		 	   			}else{
		 	   				$('#msg_checkcode').css('color','green');
		 	   				$('#msg_checkcode').html(data.msg);
		 	   			}
					flag2 = data.sta;
				},'json');
			};
		});	
	});
 
  </script>
 
 
 	<style type="text/css">
 		form button,label {
	 		margin-left: 170;
		}
		.modal input{
			 display: inline-flex;
		}
 	</style>
 
  </head>


<body class="login-body" style="font-family: 'Trebuchet MS';" >

<p class="tip">瞧，你在这夜的底片上...</p>
<div class="cont">
  <div class="form sign-in">
    <h2>Welcome back,</h2>
    <form  id="loginForm">
    <label>
      <span>账号</span>
      <input type="text" id="username_login"  name="user.username"/>
    </label>
    <label>
      <span>密码</span>
      <input type="password" id="password_login" name="user.password" />
    </label>
     
    <button type="button" class="submit" onclick="login()" >登入</button>
    </form>
  </div>
  <div class="sub-cont">
    <div class="img">
      <div class="img__text m--up">
        <h2>惊鸿一瞥?</h2>
        <p>走！我们一起去框住这属于你我的却被遗忘的美景</p>
      </div>
      <div class="img__text m--in">
        <h2>设计重逢?</h2>
        <p>来！加入我们，一起去发现这村野之舍</p>
      </div>
      <div class="img__btn">
        <span class="m--up">Sign Up</span>
        <span class="m--in">Sign In</span>
      </div>
    </div>
    <div class="form sign-up">
      <h2>Time to feel like home,</h2>
     <form id="registerForm" method="post">
      <label style="display: block;"  >
        <span >用户名</span>
        <span id="msg_username" ></span>
        <input type="hidden" id="tagName" name="tagName">
        <input type="text" id="username"  name="user.username" />
        </label>
        <label style="display: block;">
        	<span>密码</span>
        	<span id="msg_password" ></span>
        	<input type="password" id="password" name="user.password" />
        </label>
        <label>
        	<img id="checkImg"  src="<%=basePath %>checkImg.action" onclick="change()" />
        	<br>
        	<span >验证码</span>
        	<span id="msg_checkcode" ></span>
        	<input type="text" id="checkcode" />
        </label>

 	
        <button type="button" class="submit" onclick="register()">注册</button>
      </form>
     </div>
 	</div>
 	</div>
 
<!--选择类别  模态框  --> 	
<div class="modal fade" id="modal" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <form    method="post">
      <div class="modal-content">
        <div class="modal-header">
         <%--  <button type="button" style="width:10" class="close" data-dismiss="modal" aria-label="Close">
          	<span aria-hidden="true"  >&times;</span>
          </button> --%>
          <h4 class="modal-title" >选择你的兴趣(三项)</h4><span id="modal-msg" style="color:red" ></span>
        </div>
        <div class="modal-body" style="text-align: center;">
            <div style="height: 50px;width: 100%;">
           		<div style=" height: -webkit-fill-available;float: left;width: 50%;">
           			<input style="margin-top: 10;margin-left: 120;" type="checkbox" name="choice1" checked  value="民族风情" /></div>
           		<div style="font-size:20px;margin-left: 20px;width: 50%;margin-top: -40;text-align: left;float: right;">民族风情</div>
           	</div> 
           	<div style="height: 50px;width: 100%;">
           		<div style=" height: -webkit-fill-available;float: left;width: 50%;">
           			<input style="margin-top: 10;margin-left: 120;" type="checkbox" name="choice1" checked  value="人文历史" /></div>
           		<div style="font-size:20px;margin-left: 20px;width: 50%;margin-top: -40;text-align: left;float: right;">人文历史</div>
           	</div> 
           	<div style="height: 50px;width: 100%;">
           		<div style=" height: -webkit-fill-available;float: left;width: 50%;">
           			<input style="margin-top: 10;margin-left: 120;" type="checkbox" name="choice1" checked   value="田园休闲" /></div>
           		<div style="font-size:20px;margin-left: 20px;width: 50%;margin-top: -40;text-align: left;float: right;">田园休闲</div>
           	</div> 
           	<div style="height: 50px;width: 100%;">
           		<div style=" height: -webkit-fill-available;float: left;width: 50%;">
           			<input style="margin-top: 10;margin-left: 120;" type="checkbox" name="choice1"    value="健康生态" /></div>
           		<div style="font-size:20px;margin-left: 20px;width: 50%;margin-top: -40;text-align: left;float: right;">健康生态</div>
           	</div> 
           	<div style="height: 50px;width: 100%;">
           		<div style=" height: -webkit-fill-available;float: left;width: 50%;">
           			<input style="margin-top: 10;margin-left: 120;" type="checkbox" name="choice1"   value="山青水绿" /></div>
           		<div style="font-size:20px;margin-left: 20px;width: 50%;margin-top: -40;text-align: left;float: right;">山青水绿</div>
           	</div> 
        
        </div>
        <div class="modal-footer">
          <button style="width: 50;" id="categorySubmit" type="button" class="btn btn-primary">提交</button>
        </div>
      </div>
    </form>
  </div>
</div>
 
	
 	
 	
 <script type="text/javascript">
 		//提交表单 存入数据库
 		$(function(){
 			$('#categorySubmit').click(function(){
 				var length = $('input[type="checkbox"]:checked').length;
 				if(length != 3) {
 					$('#modal-msg').text('请选择三项');
 				}else {
 					var tagName = '';
				  	$('input[type="checkbox"]:checked').each(function(){
				  		tagName += '/' + $(this).prop('value');	
				   });	
				   tagName = tagName.substr(1);
				  $('#tagName').val(tagName);
				  $('#modal').modal('hide');
				  swal({
					  title: "注册成功！",
					  text: "",
					  type: "success",
					  showCancelButton: false,
					  confirmButtonColor: "#aedef4",
					  confirmButtonText: "Okay",
					  closeOnConfirm: true
					},
					function(){
					    $('#registerForm').prop('action', '<%=basePath%>regist.action');
					   $('#registerForm').submit();
					   //$('input').each(function(){
				  		//$(this).val('');	
				     //});
						
					});
				   
 				}
 			});
 		});
 
 		//设置只能选3个
 		$(function(){
 			$('.modal-body input[type="checkbox"]').click(function(){
 				if($(this).is(':checked')){	 					
 					  var length = $('input[type="checkbox"]:checked').length;
 					  if(length > 3){
 					  	var name = $(this).prop('value');
 					  	$('input[type="checkbox"]:checked').each(function(){
 					  		if(name != $(this).prop('value')){
 					  			$(this).prop('checked', false);
 					  			return false;
 					  		}
 					 	 });
 					  }
 					  
 				}
 			});
 		});
 	
 </script>
 </body>
</html>
