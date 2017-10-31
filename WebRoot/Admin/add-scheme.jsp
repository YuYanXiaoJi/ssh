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
<link rel="stylesheet" type="text/css" href="<%=basePath%>Admin/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>Admin/css/style.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>Admin/css/font-awesome.min.css">
<link rel="apple-touch-icon-precomposed" href="<%=basePath%>Admin/images/icon/icon.png">
<link rel="shortcut icon" href="<%=basePath%>Admin/images/icon/favicon.ico">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js "></script>
  </head>
  
<body class="user-select">
<section class="container-fluid">
 <header>
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false"> <span class="sr-only">切换导航</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
          <a class="navbar-brand" href="<%=basePath%>index.jsp" target="_blank">&nbsp;知了</a> </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav navbar-right">
            <li class="dropdown" style="margin-right: 40px;">
              <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
            	${sessionScope.admin}<span class="caret"></span></a>
              	<ul class="dropdown-menu dropdown-menu-left">
                	<li><a title="查看或修改个人信息" data-toggle="modal" data-target="#seeUserInfo">个人信息</a></li>
                	<li><a href="<%=basePath%>adminLoginOut.action" >退出登入</a></li>
              	</ul>
            </li>
         
          </ul>
        </div>
      </div>
    </nav>
  </header>
  <div class="row">
       <aside class="col-sm-3 col-md-2 col-lg-2 sidebar">
      <ul class="nav nav-sidebar">
        <li ><a href="<%=basePath%>Admin/index.jsp">报告</a></li>
      </ul>
      <ul class="nav nav-sidebar">
        <li><a href="<%=basePath%>adminGetSportAll.action">乡村</a></li>
        <li><a href="<%=basePath%>adminGetArticleAll.action">见闻</a></li>
        <li><a href="<%=basePath%>adminGetQuestionAll.action">秉烛夜谈</a></li>
        <li><a class="dropdown-toggle" id="userMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">用户</a>
          <ul class="dropdown-menu" aria-labelledby="userMenu">
            <li><a href="<%=basePath%>adminGetUserAll.action">管理用户</a></li>
          </ul>
        </li>
        <li>
       	   <a class="dropdown-toggle" id="userMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">特别策划</a>
        	<ul class="dropdown-menu" aria-labelledby="userMenu">
            	<li><a href="<%=basePath%>getSpecialSchemeAll.action">管理活动</a></li>
            	<li><a href="javascript:">管理报名</a></li>
          	</ul>
        </li>
      </ul>
   </aside>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-lg-10 col-md-offset-2 main" id="main">
      <div class="row">
        <form action="saveScheme.action" id="save-scheme-form" method="post" class="add-article-form">
          <div class="col-md-9">
            <h1 class="page-header">增加活动</h1>
             <div class="add-article-box">
               <h2 class="add-article-box-title"  ><span>活动标题</span></h2>
               <div class="add-article-box-content">
              	<input type="text" class="form-control" placeholder="请输入标题" id="title" name="specialScheme.title" autocomplete="off">
              </div>
            </div>
            
            <div class="add-article-box" >
              <h2 class="add-article-box-title"  ><span>标题1</span></h2>
              <div class="add-article-box-content">
                <input type="hidden"  id="specialScheme-userCount" name="specialScheme.userCount" />
              	<input type="hidden" id="specialScheme-id"  name="specialScheme.id"/>
              	<input type="hidden" id="specialScheme-time" name="specialScheme.time" />
              	<input type="text" class="form-control" placeholder="请输入标题" id="h1"name="specialScheme.h1"autocomplete="off">
                <span class="prompt-text">用于结合图片展示</span>
              </div>
            </div>
            <div class="add-article-box">
              <h2 class="add-article-box-title"><span>简概1</span></h2>
              <div class="add-article-box-content">
              	<textarea id="p1" class="form-control" name="specialScheme.p1" autocomplete="off"></textarea>
              </div>
            </div>
            
             <div class="add-article-box">
              <h2 class="add-article-box-title"><span>标题2</span></h2>
              <div class="add-article-box-content">
              	<input type="text" class="form-control" placeholder="请输入标题" id="h2" name="specialScheme.h2" autocomplete="off">
                <span class="prompt-text">用于结合图片展示</span>
              </div>
            </div>
            <div class="add-article-box">
              <h2 class="add-article-box-title"><span>简概2</span></h2>
              <div class="add-article-box-content">
              	<textarea id="p2" class="form-control" name="specialScheme.p2" autocomplete="off"></textarea>
              </div>
            </div>
            
             <div class="add-article-box">
              <h2 class="add-article-box-title"><span>标题3</span></h2>
              <div class="add-article-box-content">
              	<input type="text" class="form-control" placeholder="请输入标题" id="h3" name="specialScheme.h3" autocomplete="off">
                <span class="prompt-text">用于结合图片展示</span>
              </div>
            </div>
            <div class="add-article-box">
              <h2 class="add-article-box-title"><span>简概3</span></h2>
              <div class="add-article-box-content">
              	<textarea id="p3" class="form-control" name="specialScheme.p3" autocomplete="off"></textarea>
              </div>
            </div>
            
             <div class="add-article-box">
              <h2 class="add-article-box-title"><span>标题4</span></h2>
              <div class="add-article-box-content">
              	<input type="text" class="form-control" placeholder="请输入标题" id="h4" name="specialScheme.h4" autocomplete="off">
                <span class="prompt-text">用于结合图片展示</span>
              </div>
            </div>
            <div class="add-article-box">
              <h2 class="add-article-box-title"><span>简概4</span></h2>
              <div class="add-article-box-content">
              	<textarea id="p4" class="form-control" name="specialScheme.p4" autocomplete="off"></textarea>
              </div>
            </div>
            
             <div class="add-article-box">
              <h2 class="add-article-box-title"><span>标题5</span></h2>
              <div class="add-article-box-content">
              	<input type="text" class="form-control" placeholder="请输入标题" id="h5" name="specialScheme.h5" autocomplete="off">
                <span class="prompt-text">用于结合图片展示</span>
              </div>
            </div>
            <div class="add-article-box">
              <h2 class="add-article-box-title"><span>简概5</span></h2>
              <div class="add-article-box-content">
              	<textarea id="p5" class="form-control" name="specialScheme.p5" autocomplete="off"></textarea>
              </div>
            </div>
 
          </div>
          
          <div class="col-md-3">
            <h1 class="page-header">图片管理</h1>
            <!--上传的封面  -->
            <div class="add-article-box"  >
              <h2 class="add-article-box-title"><span>标题图片1</span></h2>
              <div class="add-article-box-content">
                <input type="text" class="form-control" placeholder="点击按钮选择图片" id="page1" name="specialScheme.page1" autocomplete="off">
              	<img alt="上传封面图片" id="imgPreview1">
              </div>
              <div class="add-article-box-footer">
                <button class="btn btn-default" type="button" onclick="uploadimage(1)">选择</button>
              </div>
            </div>
            <div class="add-article-box"  >
              <h2 class="add-article-box-title"><span>标题图片2</span></h2>
              <div class="add-article-box-content">
                <input type="text" class="form-control" placeholder="点击按钮选择图片" id="page2" name="specialScheme.page2" autocomplete="off">
              	<img alt="上传封面图片" id="imgPreview2">
              </div>
              <div class="add-article-box-footer">
                <button class="btn btn-default" type="button" onclick="uploadimage(2)">选择</button>
              </div>
            </div>
            <div class="add-article-box"  >
              <h2 class="add-article-box-title"><span>标题图片3</span></h2>
              <div class="add-article-box-content">
                <input type="text" class="form-control" placeholder="点击按钮选择图片" id="page3" name="specialScheme.page3" autocomplete="off">
              	<img alt="上传封面图片" id="imgPreview3">
              </div>
              <div class="add-article-box-footer">
                <button class="btn btn-default" type="button" onclick="uploadimage(3)">选择</button>
              </div>
            </div>
            <div class="add-article-box"  >
              <h2 class="add-article-box-title"><span>标题图片4</span></h2>
              <div class="add-article-box-content">
                <input type="text" class="form-control" placeholder="点击按钮选择图片" id="page4" name="specialScheme.page4" autocomplete="off">
              	<img alt="上传封面图片" id="imgPreview4">
              </div>
              <div class="add-article-box-footer">
                <button class="btn btn-default" type="button" onclick="uploadimage(4)">选择</button>
              </div>
            </div>
            <div class="add-article-box"  >
              <h2 class="add-article-box-title"><span>标题图片5</span></h2>
              <div class="add-article-box-content">
                <input type="text" class="form-control" placeholder="点击按钮选择图片" id="page5" name="specialScheme.page5" autocomplete="off">
              	<img alt="上传封面图片" id="imgPreview5">
              </div>
              <div class="add-article-box-footer">
                <button class="btn btn-default" type="button"onclick="uploadimage(5)">选择</button>
              </div>
            </div>
 
            
            <div class="add-article-box">
              <h2 class="add-article-box-title"><span>发布</span></h2>   
              <div class="add-article-box-footer">
                <button style="margin-right: 120;" class="btn btn-primary" type="button" id="issue">发布</button>
              </div>
            </div>
            
          </div>
        </form>
      </div>
    </div>
  </div>
</section>
<!--个人信息模态框-->
<div class="modal fade" id="seeUserInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <form  id="form" method="post">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" >个人信息</h4>
        </div>
        <div class="modal-body">
          <table class="table" style="margin-bottom:0px;">
            <thead>
              <tr> </tr>
            </thead>
            <tbody>
              <tr>
                <td wdith="20%">
                	<span>姓名:</span>
                	<span class="message"></span>			
                </td><!--真实名字就暂存在background字段中  -->	<!--must  必须输入的选项  -->
                <td width="80%"><input type="text"   class="must form-control" id="truename" maxlength="10" autocomplete="off" /></td>
              </tr>
              <tr>
                <td wdith="20%">
                	<span>用户名:</span>
                	<span class="message"></span>
                </td>
                <td width="80%"><input type="text"  class="must form-control" id="username" maxlength="10" autocomplete="off" /></td>
              </tr>
              <tr>
                <td wdith="20%">
                	<span>电话:</span>
                	<span class="message"></span>
                </td>
                <td width="80%"><input type="text"   class="must form-control" id="usertel" maxlength="13" autocomplete="off" /></td>
              </tr>
              <tr>
                <td wdith="20%">
                	<span>旧密码:</span>
                	<span class="message"></span>
                </td>
                <td width="80%">
                	<input type="password"  class="form-control" id="oldPassword" maxlength="18" autocomplete="off" />
                </td>
             
              </tr>
              <tr>
                <td wdith="20%">
                	<span >新密码:</span>	
                	<span class="message"></span>
                </td>
                <td width="80%"><input type="password" id="newPassword" class="form-control"   maxlength="18" autocomplete="off" /></td>
              </tr>
              <tr>
                <td wdith="20%">
                	<span>确认密码:</span>
                	<span class="message"></span>
                </td>
                <td width="80%">
                	<input type="password" id="confirmPassword" class="form-control"  maxlength="18" autocomplete="off" />
                </td>
              </tr>
            </tbody>
            <tfoot>
              <tr></tr>
            </tfoot>
          </table>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
          <button type="button" class="btn btn-primary">提交</button>
        </div>
      </div>
    </form>
  </div>
</div>
 
 
<script src="<%=basePath%>Admin/js/bootstrap.min.js"></script> 
<script src="<%=basePath%>Admin/js/admin-scripts.js"></script> 
<script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor.all.min.js"> </script>
<script src="<%=basePath%>ueditor/lang/zh-cn/zh-cn.js"></script> 

<!--利用ueditor的单图的上传  -->
<script id="uploadUe" type="text/plain" ></script>

<!-- 判断是否session outtime -->
<script type="text/javascript">
//是否session已经过期
	$(function(){
		if('${sessionScope.admin}' == '') {
			window.location.href = '<%=basePath%>User/Login.jsp';
			return false;
		}
	});
</script>

<!-- 是否是修改还是新增  -->
<script type="text/javascript">
	$(function(){
		if('${specialScheme}' != '') {
			$('#specialScheme-userCount').val('${specialScheme.id}');
			$('#specialScheme-id').val('${specialScheme.id}');
			$('#specialScheme-time').val('${specialScheme.time}');
			
			$('#title').val('${specialScheme.title}');
			$('#h1').val('${specialScheme.h1}');
			$('#p1').val('${specialScheme.p1}');
			$('#h2').val('${specialScheme.h2}');
			$('#p2').val('${specialScheme.p2}');
			$('#h3').val('${specialScheme.h3}');
			$('#p3').val('${specialScheme.p3}');
			$('#h4').val('${specialScheme.h4}');
			$('#p4').val('${specialScheme.p4}');
			$('#h5').val('${specialScheme.h5}');
			$('#p5').val('${specialScheme.p5}');
			
			$('#page1').prop('value', '${specialScheme.page1}');
	        $('#imgPreview1').attr('src', '${specialScheme.page1}');
			$('#page2').prop('value', '${specialScheme.page2}');
	        $('#imgPreview2').attr('src', '${specialScheme.page2}');
	        $('#page3').prop('value', '${specialScheme.page3}');
	        $('#imgPreview3').attr('src', '${specialScheme.page3}');
			$('#page4').prop('value', '${specialScheme.page4}');
	        $('#imgPreview4').attr('src', '${specialScheme.page4}');
			$('#page5').prop('value', '${specialScheme.page5}');
	        $('#imgPreview5').attr('src', '${specialScheme.page5}');
	        
	        for(var i = 1; i <= 5; i++) {
	        	isUploadCover.push(i);
	        	$('#imgPreview'+i).css('height',300);
	            $('#imgPreview'+i).css('width',290);
	        }
		}
	});
	
</script> 

<!--amdin 单图上传cover  -->
<script type="text/javascript">
	
	var ue = UE.getEditor('editor');//用于编写sport的content
	
	var uploadUe = UE.getEditor('uploadUe');//用于上传图片（sport-cover）
	var isUploadCover = [];
	var number = '';
	$(function(){
		uploadUe.ready(function(){
			uploadUe.setDisabled(['insertimage']); 
			uploadUe.hide();
			uploadUe.addListener('beforeInsertImage', function (t, arg) { 
				//得到单图片地址  
				$('#page'+number).prop('value', arg[0].src);
	            $('#imgPreview'+number).attr('src', arg[0].src);
	            $('#imgPreview'+number).css('height',300);
	            $('#imgPreview'+number).css('width',290);
	            isUploadCover.push(number);
             });
		});		
	});
	function  uploadimage(page) {
		var myImage = uploadUe.getDialog('insertimage');
    	myImage.open();
    	number = page;
	}
	
	//点击发表
	$(function(){
		$('#issue').click(function(){
			//检查是否填写完整
		    if ($.trim($('#title').val()) == '' ) {
				alert('请填写标题');return false;
			}
			for (var i = 1; i <= 5; i++) {
				if ($.trim($('#h'+i).val()) == '' || $.trim($('#p'+i).val()) == '') {
					alert('请填写完整标题'+i+'或内容'+i);
					return false;
				}
			} 
			for (var i = 1 ; i <= 5; i++) {
				var flag = false;
				for (var j = 0; j < isUploadCover.length; j++) {
					if(i == isUploadCover[j]) flag = true;	
				}
				if (flag == false) {
					alert('请上传图片' + i);
					return false;
				}
			}
			$('#save-scheme-form').submit();
			
		});
	});
    	
	 
</script>

<!-- 用户信息update和退出 -->
<script type="text/javascript">
	//退出登入
	$(function(){
		$('#loginOut').click(function(){
			if(confirm('是否确认退出？')) {
				var url = '<%=basePath%>cancealAdminLogin.action';
				$.post(url);
				window.location.href = '<%=basePath%>User/Login.jsp';
			}
		});
	});
	 //一下为修改基本信息部分
	//当模态框show的时候调用事件  得到基本信息
	var password;
	var userId ;
	var loginTime;
	var loginCount;
	$('#seeUserInfo').on('show.bs.modal',function(){
			var url = '<%=basePath%>getAdminDetail.action';
			$.post(url,function(data){
				if(('sta' in data)) {
					window.location.href = '<%=basePath%>User/Login.jsp';
				}else {
					userId = data.admin.id;
					password = data.admin.password;
					loginTime   = data.loginTime;
					loginCount = data.admin.greatCount;
					$('#truename').val(data.admin.background);
					$('#username').val(data.admin.username);
					$('#usertel').val(data.admin.individualSignature);
				}
			}
			,'json');
		}
	);
	//清空
	$('#seeUserInfo').on('hidden.bs.modal',function(){
		$('.modal-content input').each(function(){
			$(this).val('');
			$(this).parent().prev().children('.message').text('');
		});
	});
	
	//若进行detail-update
	$('.btn-primary').click(function(){
		var flag = 1;
		$('td .must').each(function(){/* 对于必须输入的选项而言 */
			if($.trim($(this).val()) == '') {
				flag = 0;
				$(this).parent().prev().children('.message').text('请输入');
				$(this).parent().prev().children('.message').css('color', 'red');
			}
		});
		/* 如果输入了旧密码真确    保存新密码   */
		if($.trim($('#oldPassword').val()) == password) {
			if($.trim($('#newPassword').val()) != '' && ($.trim($('#newPassword').val()) == $.trim($('#confirmPassword').val()))) {
				 password = $.trim($('#newPassword').val());
			}else {
				flag = 0;//新密码和确认密码输入有问题
			}
		} 
		if(flag == 1) {  //更改个人信息
			//$('#form').submit();
			var url = '<%=basePath%>adminDetailUpdate.action?user.managerOrNot=true&user.id='+ userId + '&user.individualSignature='
					+ $.trim($('#usertel').val()) + '&user.password=' + password   +'&user.greatCount=' +loginCount +
					'&user.username=' + $.trim($('#username').val());
			var trueName = 	$.trim($('#truename').val());
			var ar = {'trueName':trueName,'loginTime':loginTime };
			var args = JSON.stringify(ar);
			$.post(url,{json:args});	
			$('#seeUserInfo').modal('hide');				
		}
	});
	
	//如果是修改密码了
	$(function(){
		$('#oldPassword').blur(function(){
			if($.trim($(this).val()) != password) {
				$(this).parent().prev().children('.message').text('输入错误');
				$(this).parent().prev().children('.message').css('color', 'red');
			}else {
				$(this).parent().prev().children('.message').text('输入正确');
				$(this).parent().prev().children('.message').css('color', 'green');
			}
		});
		//检查确认密码是不是对
		$('#confirmPassword').blur(function(){
			if($.trim($(this).val()) != $.trim($('#newPassword').val())) {
				$(this).parent().prev().children('.message').text('不一致');
				$(this).parent().prev().children('.message').css('color', 'red');
			}else if($.trim($(this).val()) != '') {
				$(this).parent().prev().children('.message').text('输入正确');
				$(this).parent().prev().children('.message').css('color', 'green');
			}
		});
		
	});
</script>
</body>
</html>
