<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html >
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
      <form action="" method="post" >
        <h1 class="page-header">操作</h1>
        <ol class="breadcrumb">
          <li><a href="<%=basePath%>Admin/add-sport.jsp">增加乡村</a></li>
        </ol>
        <h1 class="page-header">管理 <!-- <span class="badge">7</span> --></h1>
        <div class="table-responsive">
          <table class="table table-striped table-hover">
            <thead>
              <tr>
                <th><span class="glyphicon glyphicon-th-large"></span> <span class="visible-lg">选择</span></th>
                <th><span class="glyphicon glyphicon-file"></span> <span class="visible-lg">标题</span></th>
                <th><span class="glyphicon glyphicon-list"></span> <span class="visible-lg">类别</span></th>
                <th class="hidden-sm"><span class="glyphicon glyphicon-eye-open"></span> <span class="visible-lg">浏览</span></th>
                <th class="hidden-sm"><span class="glyphicon glyphicon-comment"></span> <span class="visible-lg">评论</span></th>
                <th><span class="glyphicon glyphicon-time"></span> <span class="visible-lg">日期</span></th>
                <th><span class="glyphicon glyphicon-pencil"></span> <span class="visible-lg">操作</span></th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${sportList}" var="sport" >
              	<tr>
              		<td><input type="checkbox" class="input-control" name="checkbox[]" value="${sport.id}" /></td>
              		<td class="article-title">${sport.name}</td>
	                <td>${sport.category1.name}/${sport.category2.name}</td>
	                <td class="hidden-sm">${sport.pageViewCount}</td>
	                <td class="hidden-sm">${sport.commentCount }</td>
	                <td>${fn:substring(sport.time,0,16)}</td>
	                <td>
	                	<a href="<%=basePath%>adminGetSportDetail.action?sport.id=${sport.id}">修改&nbsp;</a>
	                	<a data-toggle="modal" onclick="getSportCommentAll(1,${sport.id})" >查看评论</a>
	                </td>
              		
              	</tr>
              </c:forEach>

            </tbody>
          </table>
        </div>
        <footer class="message_footer">
          <nav>
            <div class="btn-toolbar operation" role="toolbar">
              <div class="btn-group" role="group"> <a class="btn btn-default" onClick="select()">全选</a> <a class="btn btn-default" onClick="reverse()">反选</a> <a class="btn btn-default" onClick="noselect()">不选</a> </div>
              <div class="btn-group" role="group">
                <button type="button" id="delete-sport" class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="删除全部选中" name="checkbox_delete">删除</button>
              </div>
            </div>
           <c:if test="${!empty (sportList)}">
            <ul class="pagination pagenav">
             <c:choose> 
	              <c:when test="${currentPage != 1}">
		              <li>
		              	<a href="<%=basePath%>adminGetSportAll.action?currentPage=${currentPage-1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span> </a>
		              </li>
	              </c:when>
	              <c:otherwise>
	              	   <li class="disabled">
		              	 <a aria-label="Previous"> <span aria-hidden="true">&laquo;</span> </a>
		              </li>
	              </c:otherwise>
              </c:choose>
              <c:if test="${currentPage != 1}">
              	 <li>	
				   <a href="<%=basePath%>adminGetSportAll.action?currentPage=1">1</a>
				 </li>     
			  </c:if>
               <c:if test="${currentPage - 1 >= 3}">
               		<li class="disabled">
               			<a aria-label="Previous"> <span aria-hidden="true">...</span> </a>
               		</li>	
               </c:if>
               <c:if test="${currentPage - 1 >= 2}">
               		<li >
               			<a href="<%=basePath%>adminGetSportAll.action?currentPage=${currentPage - 1}">${currentPage - 1}</a>
               		</li>
               </c:if>
              <li class="active">
              	 <a href="<%=basePath%>adminGetSportAll.action?currentPage=${currentPage}">${currentPage}</a> 
              </li>
              <c:if test="${currentPage + 1 < totalPage}">	
               		<li >
               			<a href="<%=basePath%>adminGetSportAll.action?currentPage=${currentPage+1}">${currentPage + 1}</a>
               		</li>
               </c:if>
               <c:if test="${totalPage - currentPage >= 3}">
               		<li class="disabled">
               			<a aria-label="Previous"> <span aria-hidden="true">...</span> </a>
               		</li>	
               </c:if>
               <c:if test="${totalPage != currentPage}">
				  	 <li><a href="<%=basePath%>adminGetSportAll.action?currentPage=${totalPage}">${totalPage}</a></li>
			   </c:if>
			    <c:choose> 
	              <c:when test="${currentPage != totalPage }">
		              <li>
		              	<a href="<%=basePath%>adminGetSportAll.action?currentPage=${currentPage+1}" aria-label="Next"> <span aria-hidden="true">&raquo;</span> </a>
		              </li>
	              </c:when>
	              <c:otherwise>
	              	   <li class="disabled">
		              	<a  aria-label="Next"> <span aria-hidden="true">&raquo;</span> </a>
		              </li>
	              </c:otherwise>
              </c:choose>     
            </ul>
            </c:if> 
          </nav>
        </footer>
      </form>
    </div>
  </div>
</section>
<!-- admin 查看 管理  留言 模态框  -->
<div class="modal fade" id="getSportCommendAll" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width:1000px">
		<div class="modal-content">  
            <div class="modal-header">  
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>  
                <h4 class="modal-title" id="myModalLabel">评论列表</h4>  
            </div>  
            <div class="modal-body">  
              	<div id="modal-article-content" style="text-align: center;">
              		
              	</div>
            </div>  
            <div class="modal-footer">  
            	<div class="btn-toolbar operation" role="toolbar">
              		<div class="btn-group" role="group"> 
              			<a class="btn btn-default" onClick="select2()">全选</a> <a class="btn btn-default" onClick="reverse2()">反选</a> <a class="btn btn-default" onClick="noselect2()">不选</a> 
              		</div>
              		<div class="btn-group" role="group">
                		<button type="button" id="delete-comment" class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="删除全部选中" name="checkbox_delete">删除</button>
              		</div>
              		
            	</div>

            </div>  
        </div> 
	</div>
</div>

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

<!--admin 删除模态框中的comment  -->
<script type="text/javascript">
	$('body').on('click','#delete-comment',function(){
		var sportComment = [];
		$('#modal-article-content input[type="checkbox"]:checked').each(function(){
			//alert($(this).prop('id')+','+$(this).prop('value'));
			sportComment.push({
				id:$(this).prop('id'),
				rank:Number($(this).prop('value'))
			});
			var args = JSON.stringify(sportComment);
			var url = '<%=basePath%>adminDeleteComment.action';
			if(window.confirm('此操作不可逆，是否确认？')) {
			   $.post(url,{json:args},function(){
					$('#modal-article-content input[type="checkbox"]:checked').each(function(){
						$(this).parent().parent().remove();
					});
			  });
			} else {
				return false;
			}
		});
		$(this).blur();
		
	});
	
</script>

<!--admin 翻页查看评论  -->
<script type="text/javascript">
	 $('body').on('click', '.modal-footer ul a', function() {
		  if($(this).prop('text') == '...' || $(this).parent().hasClass('disabled')) {
		  	return false;
		  }
		  if($(this).prop('text') == '»') {
		  	 getSportCommentAll(modalCurrentPage+1,modalSportId);return false;
		  }
		  if($(this).prop('text') == '«') {
		  	getSportCommentAll(modalCurrentPage-1,modalSportId);return false;
		  }
		  getSportCommentAll($(this).prop('text'),modalSportId);
	 })

</script>

<!--admin 查看 管理留言  模式框 -->
<script type="text/javascript">
	var modalCurrentPage ;
	var modalSportId;
	function getSportCommentAll(currentPage,sportId) {
		modalSportId = sportId;
		var url = '<%=basePath%>getSportCommentAll.action';
		var ar = {'sportId' : Number(sportId), 'modalCurrentPage' : Number(currentPage)};
		var args = JSON.stringify(ar);
		$.post(url,{json:args},function(data){
				var reslut = '';
				for(var i = 0; i < data.crList.length; i++) { 
					reslut += '<table style="margin-left:'+ data.crList[i].rank +';">'+  /* input的value代表是一级还是二级 0 是一  1 是二 */
								 '<td><input type="checkbox" class="input-control" name="checkbox2[]" id="'+ data.crList[i].id +'" value="'+ data.crList[i].rank+' "/></td>' +
 							     '<td>' + data.crList[i].content +'</td>' +
 							   '</table>';
 					 		    		 
 				}
 				if(data.crList.length != 0) {
  					var pagination = '';
	 				pagination += '<ul style="margin: 0 100;" class="pagination pagenav">';
	 				if(data.modalCurrentPage != 1) {
	 					pagination += '<li><a aria-label="Previous">&laquo;</a></li>';
	 					pagination += '<li><a >1</a></li>';
	 				}else {
	 					pagination += ' <li class="disabled"> <a aria-label="Previous">&laquo;</a></li>';
	 				} 
	 				if(data.modalCurrentPage - 1 >= 3) {
	 					pagination += '<li class="disabled"> <a aria-label="Previous" >...</a> </li>' ;	
	 				} 
	 				if(data.modalCurrentPage - 1 >= 2) {
	 					pagination += '<li > <a >'+ Number(data.modalCurrentPage - 1) +'</a> </li>';
	 				}
	 				pagination += '<li class="active"> <a  >'+data.modalCurrentPage+'</a>  </li>';
	 				modalCurrentPage = data.modalCurrentPage;
	 				if(data.modalCurrentPage + 1 < data.modalTotalPage) {
	 					pagination += '<li > <a >'+ Number(data.modalCurrentPage + 1) +'</a> </li>';
	 				}
	 				if(data.modalTotalPage - data.modalCurrentPage   >= 3) {
	 					pagination += '<li class="disabled"> <a  >...</a> </li>' ;	
	 				} 
	 				if(data.modalTotalPage != data.modalCurrentPage ) {
	 					pagination += '<li > <a >'+  data.modalTotalPage +'</a> </li>';
	 				}
	 				if(data.modalCurrentPage != data.modalTotalPage) {
	 					pagination += '<li> <a   aria-label="Next">&raquo;</a></li>';
	 				}else {
	 					pagination += ' <li class="disabled"> <a aria-label="Previous">&raquo;</a></li>';
	 				} 
	 				pagination += '</ul>';
	 				$('#modal-article-content').empty();
			  		$('.modal .btn-toolbar ul').remove();
			  		
	 				$('.modal .btn-toolbar').append(pagination);
	 				$('#modal-article-content').append(reslut);	
			  } else {
			  	$('#modal-article-content').append('<h3>暂无评论</h3>')
			  }
			  $('#getSportCommendAll').modal('show'); 
			}
		,'json');
		  
	}
	
	//清空
	$('#getSportCommendAll').on('hidden.bs.modal',function(){
		 $('#modal-article-content').empty();
		 $('.modal .btn-toolbar ul').remove();
	});
	

</script>

<!-- amdin 删除sport -->
<script>
$(function(){   
	$('#delete-sport').click(function(){
		 if(window.confirm('此操作不可逆，是否确认？'))
		 {
		 	var sportId = [];
		 	var obj = $('input[type="checkbox"]:checked');
		 	if(obj.length == 0) {
		 		alert('请先选择一项');
		 		$(this).blur();
		 		return false;
		 	}
		 	for(var i = 0; i < obj.length; i++) {
		 		sportId.push($(obj[i]).prop('value'));
		 	}
		 	var args = JSON.stringify(sportId);
			 $.ajax({
					type: 'post',
					url: '<%=basePath%>adminDeleteSport.action',
					data: {json : args},
					cache: false, //不缓存此页面   
					success: function () {
						$('input[type="checkbox"]:checked').each(function(){
							$(this).parent().parent().remove();
						});
					}
				}); 
			 $(this).blur();
		 } else {
		 	return false;
		 }
		 
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

