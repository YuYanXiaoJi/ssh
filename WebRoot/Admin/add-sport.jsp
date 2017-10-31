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
        <form action="saveUpdateSport.action" id="form" method="post" class="add-article-form">
          <div class="col-md-9">
            <h1 class="page-header">撰写新文章</h1>
            <div class="form-group">
              <input type="hidden" id="sport-id" name="sport.id" />	
              <input type="hidden" id="sport-time"  name="sportTime"/>
              <input type="hidden" id="sport-wantCount"  name="sport.wantCount"/>
              <input type="hidden" id="sport-commentCount"  name="sport.commentCount"/>
              <input type="hidden" id="sport-pageViewCount"  name="sport.pageViewCount"/>
              <input type="hidden" id="sport-score" name="sport.score">
              
              <label for="article-title" class="sr-only">标题</label>
              <input type="text" id="sport-name" name="sport.name" class="form-control" placeholder="在此处输入标题" required autofocus autocomplete="off">
            </div>
            <!--百度编辑器加载  -->
            <div class="form-group">
              <label for="article-content" class="sr-only">内容</label>
              <script id="editor" type="text/plain"  >	</script>
              <input type="hidden" name="sport.content" id="sport-content" />
            </div>
            <div class="add-article-box">
              <h2 class="add-article-box-title"><span>自定义标签</span></h2>
              <div class="add-article-box-content">
              	<input type="text" class="form-control" placeholder="请输入自定义标签" id="sport-customTag" name="sport.customTag" autocomplete="off">
                <span class="prompt-text">多个标签请用‘/’隔开。</span>
              </div>
            </div>
            <div class="add-article-box">
              <h2 class="add-article-box-title"><span>总结描述（summary）</span></h2>
              <div class="add-article-box-content">
              	<textarea style="height: 150px;" id="sport-summary" class="form-control" name="sport.summary" autocomplete="off"></textarea>
                <span class="prompt-text">用于作为乡村的简概</span>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <h1 class="page-header">分类</h1>
            <div class="add-article-box">
              <h2 class="add-article-box-title"><span>类别一</span></h2>
              <div class="add-article-box-content">
                <ul class="category-list">
                  <li>
                    <label>
                      <input type="hidden" name="sportCategory1" id="sport-category1">
                      <input type="hidden" name="sportCategory2" id="sport-category2">
                  
                      <input name="category1" type="radio" value="浙江" checked>
                      	浙江  </label>
                  </li>
                  <li>
                    <label>
                      <input name="category1" type="radio" value="江苏">
                      	江苏</label>
                  </li>
                  <li>
                    <label>
                      <input name="category1" type="radio" value="云南">
                      	云南</label>
                  </li>
                  <li>
                    <label>
                      <input name="category1" type="radio" value="贵州">
                     	 贵州</label>
                  </li>
                  <li>
                    <label>
                      <input name="category1" type="radio" value="广东">
                      	广东</label>
                  </li>
                  <li>
                    <label>
                      <input name="category1" type="radio" value="四川">
                      	四川</label>
                  </li>
                   <li>
                    <label>
                      <input name="category1" type="radio" value="福建">
                      	福建</label>
                  </li>
                  <li>
                    <label>
                      <input name="category1" type="radio" value="辽宁">
                      	辽宁</label>
                  </li>
                  <li>
                    <label>
                      <input name="category1" type="radio" value="江西">
                      	江西</label>
                  </li>
                  <li>
                    <label>
                      <input name="category1" type="radio" value="安徽">
                       	安徽</label>
                  </li>
                  <li>
                    <label>
                      <input name="category1" type="radio" value="河南">
                       	河南</label>
                  </li>
                  <li>
                    <label>
                      <input name="category1" type="radio" value="新疆">
                      	新疆</label>
                  </li>
                  <li>
                    <label>
                      <input name="category1" type="radio" value="湖南">
                      	湖南</label>
                  </li>
                  <li>
                    <label>
                      <input name="category1" type="radio" value="广西">
                      	广西</label>
                  </li> 
                  <li>
                    <label>
                      <input name="category1" type="radio" value="其他">
                      	其他</label>
                  </li>
                </ul>
              </div>
            </div>
             <div class="add-article-box">
              <h2 class="add-article-box-title"><span>类别二</span></h2>
              <div class="add-article-box-content">
                <ul class="category-list">
                  <li>
                    <label>
                      <input name="category2" type="radio" value="民族风情" checked>
                      	民族风情</label>
                  </li>
                  <li>
                    <label>
                      <input name="category2" type="radio" value="人文历史">
                      	人文历史  </label>
                  </li>
                  <li>
                    <label>
                      <input name="category2" type="radio" value="田园休闲">
                      	田园休闲</label>
                  </li>
                  <li>
                    <label>
                      <input name="category2" type="radio" value="健康生态">
                     	健康生态</label>
                  </li>
                  <li>
                    <label>
                      <input name="category2" type="radio" value="山青水绿">
                      	山青水绿</label>
                  </li>
                </ul>
              </div>
            </div>
            <!--用户上传sport的封面  -->
            <div class="add-article-box">
              <h2 class="add-article-box-title"><span>标题图片</span></h2>
              <div class="add-article-box-content">
                <input type="text" class="form-control" placeholder="点击按钮选择图片" id="sport-cover" name="sport.cover" autocomplete="off">
              	<img alt="上传封面图片" id="imgPreview">
              </div>
              <div class="add-article-box-footer">
                <button class="btn btn-default" type="button" ID="upImage">选择</button>
              </div>
            </div>
            
            <!--经纬度  -->
            <div class="add-article-box">
              <h2 class="add-article-box-title"><span>乡村经纬度</span></h2>
              <div class="add-article-box-content">
                <input type="text" class="form-control" placeholder="乡村的经度（单位 E）" id="sport-x" name="sport.x" autocomplete="off">
                <input type="text" class="form-control" placeholder="乡村的纬度（单位 N）" id="sport-y" name="sport.y" autocomplete="off">
              </div>
            </div>
            
            <div class="add-article-box">
              <h2 class="add-article-box-title"><span>发布</span></h2>   
              <div class="add-article-box-footer">
                <button style="margin-right: 120;" class="btn btn-primary" type="button" id="issue">发布</button>
               <!--  <button style="margin-right: 30px;"class="btn btn-primary" type="submit" name="submit">保存草稿</button> -->
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

<!--如果是update-sport的情况  -->
<script type="text/javascript">
		
	$(function(){
		if('${sport}' != '') {
			$('#sport-name').val('${sport.name}');
			ue.ready(function(){
				ue.setContent('${sport.content}');
			});
			$('#sport-summary').val('${sport.summary}');
			$('#sport-customTag').val('${sportCustomTag}');
			$('input[name=category1]').each(function(){
				if($(this).prop('value') == '${sport.category1.name}') {
					$(this).prop('checked', true);
				}
			});
			$('input[name=category2]').each(function(){
				if($(this).prop('value') == '${sport.category2.name}') {
					$(this).prop('checked', true);
				}
			});
			$('#sport-cover').val('${sport.cover}');
			$('#imgPreview').attr('src','${sport.cover}');
              $('#imgPreview').css('height',300);
              $('#imgPreview').css('width',290);
            $('#sport-x').val('${sport.x}');
            $('#sport-y').val('${sport.y}');
            isUploadCover = true;
            
            $('#sport-time').val('${sport.time}');
           
            $('#sport-id').val('${sport.id}');
            $('#sport-pageViewCount').val('${sport.pageViewCount}');
            $('#sport-commentCount').val('${sport.commentCount}'); 
            $('#sport-wantCount').val('${sport.wantCount}');
            $('#sport-score').val('${sport.score}');
             
		}
	});	

</script>
	
<!--admin issue -->
<script type="text/javascript">
	$(function(){
		$('#issue').click(function(){
			  if($('#sport-x').val() == '' || $('#sport-y').val() == '') {
				  alert('请填写乡村的经纬度'); return false;
			 }
			 if(isUploadCover == false) {
				  alert('请上传乡村封面图片'); return false;
			 }  
			 if($.trim($('#sport-customTag').val()) == '') {
			 	 alert('请填写自定义乡村标签'); return false;
			 }
			if($.trim($('#sport-name').val()) == '') {
				alert('请填写标题'); return false;
			}
			if(!ue.hasContents()) {
				alert('请填写正文内容'); return false ;
			}
			if($.trim($('#sport-summary').val()) == '') {
				alert('请填写乡村简概');return false;
			} 
			//提交表单
			var content = ue.getContent();
			$('#sport-content').val(content);
			//查找选中的大类标签（浙江，山青水绿）
			$('#sport-category1').val($('input[name="category1"]:checked').prop('value'));	
			$('#sport-category2').val($('input[name="category2"]:checked').prop('value'));	
			 
			 $('#form').submit(); 
			
			 
		});
	});
	/* 设置经纬度的输入格式 */
	$(function(){
		 $('#sport-x').keyup(function(){
                    $(this).val($(this).val().replace(/[^0-9.]/g,''));
                }).bind("paste",function(){  //CTR+V事件处理
                    $(this).val($(this).val().replace(/[^0-9.]/g,''));
                }).css("ime-mode", "disabled"); //CSS设置输入法不可用
        $('#sport-y').keyup(function(){
                    $(this).val($(this).val().replace(/[^0-9.]/g,''));
               }).bind("paste",function(){ 
                    $(this).val($(this).val().replace(/[^0-9.]/g,''));
              }).css("ime-mode", "disabled"); 
         
	});
	
</script>

<!--amdin 单图上传cover  -->
<script type="text/javascript">
	
	var ue = UE.getEditor('editor');//用于编写sport的content
	
	var uploadUe = UE.getEditor('uploadUe');//用于上传图片（sport-cover）
	var isUploadCover = false;
	$(function(){
		uploadUe.ready(function(){
			uploadUe.setDisabled(['insertimage']); 
			uploadUe.hide();
			uploadUe.addListener('beforeInsertImage', function (t, arg) { 
				//得到单图片地址    
            	$('#sport-cover').prop('value', arg[0].src);
            	$('#imgPreview').attr('src', arg[0].src);
            	$('#imgPreview').css('height',300);
            	$('#imgPreview').css('width',290);
 	 			isUploadCover = true;
             });
		});		
	});
	$('#upImage').click(function () {
    	var myImage = uploadUe.getDialog('insertimage');
    	myImage.open();
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
