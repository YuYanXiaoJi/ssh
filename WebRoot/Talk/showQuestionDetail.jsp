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
  
  	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js "></script>
  	
  	<!--sweetalert  -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/sweetalert/sweetalert.min.js "></script>
   <link rel="stylesheet" href="<%=basePath%>css/sweetalert/sweetalert.css">
  	
  	 <!--导入问题列表样式 (为了推荐相关问题)-->
   	<link href="<%=basePath%>css/show-question/show-question.css" rel="stylesheet" type="text/css" />
  	<!--圆jiao头像  -->
  	 <link href="<%=basePath%>css/avatar/avatar.css" rel="stylesheet" type="text/css" />
  	<!--顶部返回 -->
  	<script src="<%=basePath%>jquery/go-top/go-top.js"></script> 
  	<link href="<%=basePath%>css/go-top/go-top.css" rel="stylesheet" type="text/css" />
    <!-- 搜索框 -->
	<link href="<%=basePath%>css/search/search.css" rel='stylesheet' type='text/css' />
	<link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!--引入基本样式（头）  -->
	<!-- <link href="<%=basePath%>css/index-css/bootstrap.min.css" rel='stylesheet' type='text/css' /> -->
	<link href="<%=basePath%>css/index-css/bootstrap.css" rel='stylesheet' type='text/css' />
	<link href="<%=basePath%>css/index-css/blue.css" rel="stylesheet" type="text/css" media="all" />
  	
  	<!--百度编辑器  -->
  	<script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor-forAnswer.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/lang/zh-cn/zh-cn.js"></script>
 
  	<!-- 折叠式评论 -->
    <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet"> 
   <!--  <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script> -->
 	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
 
	 <!--文字展开(问题字数显示展开和收起) -->
	<script type="text/javascript" src="<%=basePath%>jquery/plug.js"></script>
	
	<style type="text/css">
		.container a:hover{
		color: #41c074;
		text-decoration: none;
	 }
	    a:link{ 
	      text-decoration: none;
	  }
	</style>
	
	
	<script type="text/javascript">
 
    var ue = UE.getEditor('editor');
    
    //关注问题或者不关注
    $(function(){
    	$('#focusHref').click(function(){
    		if('${sessionScope.name}'==''){
    			swal('请先登入哦~');
    		}else{

	    		var content = $.trim($(this).text());
	    		var method = '';
	    		if(content == '关注问题'){
	    			$(this).text('已关注');
	    			$(this).prev().prop('src','../image/focus.png');
	    			var count = Number($('#focusCount').text()) + 1;
	    			method = 'add';
	    			
	    		}else{
	    			$(this).text('关注问题');
	    			$(this).prev().prop('src','../image/focusNo.png');
	    			var count = Number($('#focusCount').text()) - 1;
					method = 'sub';
	    		}
	    		$('#focusCount').text(count);
	    		//进行action的处置
	    		var url = '<%=basePath%>' + 'talk/focusOrNo.action';
	    		var ar = {'method':method,'question_id':'${question.id}'};
	    		var args = JSON.stringify(ar);
	    		$.post(url, {json:args});
    		    			
    		}
    	});
    });
    
    //对提问的问题的  文字的控制  收起  展开
    $(function(){
		$('.desc2 ').moreText({
		maxLength: 1650, //默认最大显示字数，超过...
		mainCell: '.branddesc2' //文字容器
		});
	});
	//对下列的回答的收起和展开
	 $(function(){
		$('.desc').each(function(){
			var id = $(this).children().prop('id');
			$(this).moreText({
				maxLength: 650,
				mainCell: $('#'+id)
			});
		});
	});
    
    //点击我要回答（DAO底部）
    function goEnd(){
    	var h = $(document).height();//-$(window).height();
    	ue.focus();
        $(document).scrollTop(h);
    }
 
    //提交一级评论
    $(document).ready(function(){
    	$('#saveReply').click(function(){
    		if ('${sessionScope.name}' == '') {
    			swal('请先登入哦~');
    		}
    		if(!ue.hasContents()){
    			swal('请先填写哦~');
    		}else{
    			var content = ue.getContent();
    			var url = '<%=basePath%>talk/ajaxSaveReply.action';
    			var ar = {'content' : content, 'flag' : 0, 'question_id' : Number('${question.id}'), 'father_id' : Number('${question.id}')};
    			var args = JSON.stringify(ar);
    			 $.post(url, {json : args}, function(data){ 
    				var reslut = '';
    				reslut += '<div><article class="type-post hentry clearfix" style="background-color:white;padding:15px 20px;border:2px solid #ececec;" >' +
    				'<header class="clearfix"><div class="avatar-img">'	+ 
    					'<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=' +'${sessionScope.name}' + '">'+
											'<img  src="<%=basePath%>'+ '${sessionScope.img}' +' " />' +
									 '</a>' +
						'</div><div class="user-name">' +
						'<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=' +'${sessionScope.name}' + '">'+
							 '<span style="margin: auto 0;" >' + '${sessionScope.name}' + '</span>' + 
						'</a></div></header><p style="font-size: 16px;"> <div class="desc" style="font-size: 17px;"  > ' +
							'<div id="'+data.father_id+'" >' + //用于展开和收起
								content +
							'</div></div></p><div style="color: #959595; width: 100% " ><span>' +
								'<img onclick="greatCount('+data.father_id+',this)" style="width: 30px;height: 25px;" alt="是否点赞" src="../image/00.jpg">&nbsp;'+
									' <span style="font-size: 18;font-weight: 500" id="greatCount'+ data.father_id +'">0</span>' +
								'</span><span style="float: right;"><img style="width: 23px;height: 20px;" src="../image/time.png">&nbsp;' + getNowFormatDate() +
								'</span><span style="float: right;"> <img style="width: 17px;height: 13px;" src="../image/report.png">&nbsp;' +
								'<a href="javascript:;" style="text-decoration: none;" >举报&nbsp;&nbsp;</a>'	 +
								'</span></div><div style="width: 100%; padding:10px 0; text-align: left;">	<div class="panel panel-default">' +
								'<div class="panel-heading"><h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion"  href="#collapse'+data.father_id+'">' +
								'<img src="../image/answer-count.png" style="width: 20px;height: 20px;" /><span id="replyCount'+data.father_id+'">添加讨论</span></a></h4></div>' +
								'<div id="collapse'+ data.father_id +'" class="panel-collapse collapse" style="background: #fafafa;">' +
								'<div class="panel-body"><div id="commitReply'+ data.father_id +'" style=" float: left;height:70px; width: 100%;padding:15px 15px; background-color:#ededed;" >' +
								'<input style=" width: 650px;" type="text" name="answer'+ data.father_id +'" />' +
								'<input style="margin: 0 10px ;color: #8c96a0;" type="button" onclick="saveAnswer('+ data.father_id +',1)"  value="提交"  />' +
								'</div></div></div></div></div> </article></div>';
					$('article').last().after(reslut);	
								
					ue.setContent('');			 
    			}
    			,'json'); 
 
    		}
    	});
    	
    });
	
	
	//为对话框添加@的人(answer就是一级评论)
	function answer(id, username){
		$("input[name='answer"+id+"']").val("[回复:"+username+"]");
		$("input[name='answer"+id+"']").focus();
	}
	//为按钮(提交二级评论)(father_id就是一级回复的id和表示flag的二级评论)
	function saveAnswer(id,flag){
		if('${sessionScope.name}' == ''){
			swal('请先登入哦~');
		}else{
			 var content = $("input[name='answer"+id+"']").val();
			 content = $.trim(content);
	 		 if(content == ''){
	 		 	swal('请先填写评论哦~');
	 		 }else{
	 		 	
				//ajax 提交二级评论 
				if ($('#replyCount'+id).text() == '添加讨论') {
					$('#replyCount'+id).text('1条评论');
				} else {
					$('#replyCount'+id).text(Number(Number($('#replyCount' + id).text().substr(0,1)) + 1) + '条评论');
				}
				
				var reslut = '';
				reslut += '<div ><div class="avatar-img" >' +
									'<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=' +'${sessionScope.name}' + '">'+
											'<img  src="<%=basePath%>'+ '${sessionScope.img}' +' " />' +
									 '</a>' +
								 '</div><div class="user-name">' +
								     '<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=' +'${sessionScope.name}' + '">'+
								     		'<span style="margin: auto 0;" >' + '${sessionScope.name}' + '</span>' +
								      '</a></div><div style="float:right;"><span style="float: right;"><img style="width: 23px;height: 20px;" src="../image/reply.png">&nbsp;' +
								      		'<a href="javascript:void(0);" onclick="answer(' + id + ',' + "'" + '${sessionScope.name}' + "'" + ')">' +
								      	'回复TA</a></span>' +
								      	'<span style="float: right;"><img style="width: 23px;height: 20px;" src="../image/time.png">&nbsp;' + getNowFormatDate() +'</span>' +
								      	'<span style="float: right;">' +
								      	'<img style="width: 17px;height: 13px;" src="../image/report.png">&nbsp;<a href="javascript:;" style="text-decoration: none;" >举报&nbsp;&nbsp;</a>' +
								      	' </span></div><div style="float: left;width: 100%;"><p style="margin:0px 0px 15px 20px; border-bottom: 1px solid #dddddd; padding-bottom:5px;  word-wrap: break-word;font-size: 16px;">' +
								      	content +
								      	'</p></div></div>';	
 				$('#commitReply' + id).before(reslut);
 				
 				var url = '<%=basePath%>talk/ajaxSaveReply.action';
 				var ar = {'flag' : 1, 'question_id' : Number('${question.id}'), 'father_id' : id, 'content' : content};
 				var args = JSON.stringify(ar);
 				$.post(url, {json : args});
 				//清空input
 				$("input[name='answer"+id+"']").val('');
	 		 }
	 	}
	}
	//得到当前时间
	function getNowFormatDate() {
	    var date = new Date();
	    var seperator1 = "-";
	    var seperator2 = ":";
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
	            + " " + date.getHours() + seperator2 + date.getMinutes();
	            //+ seperator2 + date.getSeconds();
	    return currentdate;
	}
	
	//对点赞或取消赞的操作
	 function greatCount(id,obj){
		var taggle = true;
		//是否重新点赞
		if('${sessionScope.name}' == ''){
			swal('请先登入哦~');
		}
		else{
			 var method = '减';
			if($(obj).attr('src') == '../image/11.jpg'){
				$(obj).attr('src', '../image/00.jpg');
				method = '减';
			}
			else{
				$(obj).attr('src', '../image/11.jpg');
				method = '加';
			}
			 var url = '<%=basePath%>'+'talk/addOrSub.action';
			var answer_id = id;
			var ar = {'method':method, 'answer_id':answer_id};
			var args = JSON.stringify(ar);
			
			$.post(url, {json:args}, function(data){
				$('#greatCount'+id).text(data.greatCount);
			},'json');
		}
 
	 }
 	//用户---点击（我要提问）
 	$(function(){
 		$('#questionAsk').click(function(){
 			if('${sessionScope.name}' == ''){
 				swal('请先登入哦~');
 			}else{
 				$('#questionForm').submit();
 			}
 		});
 	});
 	
 	//点击加载更多的回答
 	var count = 0;//点击加载的次数
 	var addCount = 2;//每次加载的增量数
 	var totalCount = Number('${fn:length(answerList)}');//初始页面显示的总数
 	$(function(){
 		$('#getMoreAnswer').click(function(){
 			var url = '<%=basePath%>talk/ajaxGetMoreAnswer.action';
 			var ar = {'totalCount' : Number(totalCount + count * addCount), 'addCount' : addCount, 'question_id' : '${question.id}'};
 			count++;
 			var args = JSON.stringify(ar);
 			$.post(url, {json : args} , function(data){
 					var reslut = '', reslut2 = '';	
 					if(data.isShowAll == true) $('#isShowAll').remove();
 					for (var i = 0; i < data.list.length; i++) {
 						temp1 = (data.list[i].son.length == 0) ? ('添加讨论') : (data.list[i].son.length + '条评论');
 						/* 子评论 */
 						for (var j = 0; j < data.list[i].son.length; j++) {
 							reslut2 += '<div ><div class="avatar-img" >' +
									'<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=' + data.list[i].son[j].user.username + '">'+
											'<img  src="<%=basePath%>'+ data.list[i].son[j].user.avatar +' " />' +
									 '</a>' +
								 '</div><div class="user-name">' +
								     '<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=' + data.list[i].son[j].user.username + '">'+
								     		'<span style="margin: auto 0;" >' + data.list[i].son[j].user.username + '</span>' +
								      '</a></div><div style="float:right;"><span style="float: right;"><img style="width: 23px;height: 20px;" src="../image/reply.png">&nbsp;' +
								      		'<a href="javascript:void(0);" onclick="answer(' + data.list[i].father.id + ',' + data.list[i].son[j].user.username + ')">' +
								      	'回复TA</a></span>' +
								      	'<span style="float: right;"><img style="width: 23px;height: 20px;" src="../image/time.png">&nbsp;' + '2017-'+Number(1+Number(data.list[i].son[j].time.month))+'-'+data.list[i].son[j].time.date+'&nbsp;'+data.list[i].son[j].time.hours +':'+data.list[i].son[j].time.minutes +'</span>' +
								      	'<span style="float: right;">' +
								      	'<img style="width: 17px;height: 13px;" src="../image/report.png">&nbsp;<a href="javascript:;" style="text-decoration: none;" >举报&nbsp;&nbsp;</a>' +
								      	' </span></div><div style="float: left;width: 100%;"><p style="margin:0px 0px 15px 20px; border-bottom: 1px solid #dddddd; padding-bottom:5px;  word-wrap: break-word;font-size: 16px;">' +
								      	data.list[i].son[j].content +
								      	'</p></div></div>';	
 						}
 						/* 一级评论 加上 子评论 */
 						reslut += '<div><article class="type-post hentry clearfix" style="background-color:white;padding:15px 20px;border:2px solid #ececec;" >' +
    				'<header class="clearfix"><div class="avatar-img">'	+ 
    					'<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=' + data.list[i].father.user.username + '">'+
											'<img  src="<%=basePath%>'+ data.list[i].father.user.avatar +' " />' +
									 '</a>' +
						'</div><div class="user-name">' +
						'<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=' + data.list[i].father.user.username + '">'+
							 '<span style="margin: auto 0;" >' + data.list[i].father.user.username + '</span>' + 
						'</a></div></header><p style="font-size: 16px;"> <div class="desc" style="font-size: 17px;"  > ' +
							'<div id="'+data.list[i].father.id+'" >' + //用于展开和收起
								data.list[i].father.content +
							'</div></div></p><div style="color: #959595; width: 100% " ><span>' +
								'<img onclick="greatCount('+ data.list[i].father.id +',this)" style="width: 30px;height: 25px;" alt="是否点赞" src="'+ data.list[i].img +'">&nbsp;'+
									' <span style="font-size: 18;font-weight: 500" id="greatCount'+ data.list[i].father.id +'">'+data.list[i].father.greatCount+'</span>' +
								'</span><span style="float: right;"><img style="width: 23px;height: 20px;" src="../image/time.png">&nbsp;' + '2017-'+Number(1+Number(data.list[i].father.time.month))+'-'+data.list[i].father.time.date+'&nbsp;'+data.list[i].father.time.hours +':'+data.list[i].father.time.minutes+
								'</span><span style="float: right;"> <img style="width: 17px;height: 13px;" src="../image/report.png">&nbsp;' +
								'<a href="javascript:;" style="text-decoration: none;" >举报&nbsp;&nbsp;</a>'	 +
								'</span></div><div style="width: 100%; padding:10px 0; text-align: left;">	<div class="panel panel-default">' +
								'<div class="panel-heading"><h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion"  href="#collapse'+data.list[i].father.id+'">' +
								'<img src="../image/answer-count.png" style="width: 20px;height: 20px;" /><span id="replyCount'+data.list[i].father.id+'">'+temp1+'</span></a></h4></div>' +
								'<div id="collapse'+ data.list[i].father.id +'" class="panel-collapse collapse" style="background: #fafafa;">' +
								'<div class="panel-body">'+ reslut2 +'<div id="commitReply'+ data.list[i].father.id +'" style=" float: left;height:70px; width: 100%;padding:15px 15px; background-color:#ededed;" >' +
								'<input style=" width: 650px;" type="text" name="answer'+ data.list[i].father.id +'" />' +
								'<input style="margin: 0 10px ;color: #8c96a0;" type="button" onclick="saveAnswer('+ data.list[i].father.id +',1)"  value="提交"  />' +
								'</div></div></div></div></div> </article></div>';
 					}
 				$('article').last().after(reslut);		
 				}
 			,'json');
 		});
 	});
	
</script>
 	<style type="text/css">
 		img{
 			max-width: 650px;
 		}
 	</style>
  </head>
  <body>
 <div class="header_bg">
 <div class="container">
	<div class="header">
		<div class="logo">
			<a href="<%=basePath%>index.jsp"><img style="margin-top: -35;  width: 120;margin-left: 60;" src="../image/index-images/logo.png" alt=""/></a>
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
<div class="main_bg" style="height: 81.59px;" >
<div class="container">
	<div class="main_grid1">
		<h3 class="style pull-left">our Portfolios</h3>
		<ol class="breadcrumb pull-right">
		  <li><a href="${pageContext.request.contextPath}/index.jsp">主页</a></li>
		  <li><a href="${pageContext.request.contextPath}/talk/getQuestionAll.action?category=1">秉烛夜谈</a></li>
		  <li class="active">${fn:substring(question.title,0,12)}...</li>
		</ol>
		<div class="clearfix"></div>
	</div>
</div>
</div>

<!--显示问题内容+回答+标签（靠左边）  -->
<div class="main_btm1" style="background-color:#fafafa;" >
<div class="container" style="margin-bottom: 200px;">
	<div class="blog">
			<!-- start blog -->
			<div class="blog_main col-md-9">
			  <div>
				 <article class="type-post hentry clearfix"
				 	 style="background-color:white;padding:15px 20px;border:2px solid #ececec;" >
                           <header class="clearfix">
                                  <h3 class="post-title"   >
                                        <span   style="color:black;
                                         font-size: 18px;" >
                                        	 ${question.title } 
                                        </span>
                                   </h3>
                                   <div class="avatar-img">
                                   		<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=${question.user.username}">
                                   			<img src="<%=basePath%>${question.user.avatar}" alt="avatar" >
                                   		</a>		
                                   </div>
                                  	<div class="user-name">
                                  	    <a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=${question.user.username}">
                                  	    	<span style="margin: auto 0;" >${question.user.username}</span>
                                  	    </a>
                                  	</div> 	   
 							</header>
 							<p >
 								 <div class="desc2" style="font-size: 17px;"  >
     								<div class="branddesc2"  >
     			 						${question.content}
     								</div>
     							</div> 
 							</p>
 							 <div style="color: #959595; width: 100% " >
                                   <span ><img style="width: 17px;height: 13px;" src="../image/view-count.png">&nbsp;${question.pageView }人浏览</span>
                                   <span style="margin: 0 10px;border-left:3px solid #E1E1E1;width:1px;height:7px;"></span>
                                   <span ><img style="width: 17px;height: 13px;" src="../image/answer-count.png">&nbsp;${question.replyCount}个回答</span>
                                   <span style="margin: 0 10px;border-left:3px solid #E1E1E1;width:1px;height:7px;"></span>
                                   <span ><img style="width: 17px;height: 13px;" src="../image/focus-count.png">&nbsp;<span id="focusCount">${question.focusCount }</span>人关注</span>
                                   <span style="margin: 0 10px;border-left:3px solid #E1E1E1;width:1px;height:7px;"></span>
                                    <span ><img style="width: 17px;height: 13px;" src="../image/time.png">&nbsp;${fn:substring(question.time,0,16) }</span>
                                   
                                   <span style="float: right;">
                                   		<img style="width: 23px;height: 20px;" src="${questionFocusImg}">&nbsp;
                                   		<a href="javascript:void(0);" id="focusHref">
                                   			${questionFocusWord}
                                   		</a><!--已关注  -->
                                   </span>
                                   <span style="float: right;">
                                        <img style="width: 17px;height: 13px;" src="../image/report.png">&nbsp;
                                   		<a href="#" style="text-decoration: none;" >举报&nbsp;&nbsp;</a>
                                   </span>
                                   <c:if test="${!empty (sessionScope.user_id)}">
                                   		<c:if test="${sessionScope.user_id == question.user.id}">
                                   			<span style="float: right;">
                                        		<img style="width: 17px;height: 17px;" src="<%=basePath%>image/revice.png">&nbsp;
                                   				<a href="<%=basePath%>talk/reviseQuestion.action?question.id=${question.id}" style="text-decoration: none;" >修改&nbsp;&nbsp;</a>
                                   			</span>
                                   		</c:if>
                                   </c:if>
                             </div>
 				      </article>
 			     </div>
 			     <hr style="border: 2px solid #d8d8d8;" >
 			     <br>
 			     <c:if test="${fn:length(answerList) == 0}">
 						<div style="width: 100%;height:250px; 
 							text-align:center; background:#ffffff; border: 2px solid #ececec" >
 							 <img  style="height: 150px;width: 120px;" src="<%=basePath%>image/comment.png">
 							 <br><br>
 							 <span style="font-size: 15px;color: #8590a6;">还没有回答</span>
 						</div>				     	
 			     </c:if>
 			     
 			     <!--是否展开所有的回答   -->	
 			    <c:if test="${param.isShowAnswerAll == 'false'}">
 			     		<div style="background: white;border: 2px solid #ececec;height: 50px;font-size: 20px;
 			     				margin-bottom: 20px;text-align: center;">
 			     				<a style="line-height: 50px;" href="<%=basePath%>talk/getQuestionDetail.action?question.id=${question.id}&isShowAnswerAll=true" >展开全部回答</a>
 			     		</div>
 			     		
 			   </c:if>
 			     
 			     <!--下面是罗列的回答  -->
 			    <c:forEach items="${answerList}" var="cr">
				  <div>
				   <article class="type-post hentry clearfix"
				 	 style="background-color:white;padding:15px 20px;border:2px solid #ececec;" >
                           <header class="clearfix">  
                                   <div class="avatar-img">
                                   		<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=${cr.father.user.username}">
                                   			<img src="<%=basePath%>${cr.father.user.avatar}"  >
                                   		</a>		
                                   </div>
                                  	<div class="user-name">
                                  	    <a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=${cr.father.user.username}">
                                  	    	<span style="margin: auto 0;" >${cr.father.user.username}</span>
                                  	    </a>
                                  	</div> 	   
 							</header>
 							<p style="font-size: 16px;"> 
 								<div class="desc" style="font-size: 17px;"  >  <!-- 实现展开和收起过多的文字 -->
     								<div   id="${cr.father.id}" >
     			 						${cr.father.content}
     								</div>
     							</div> 
 							</p>
 							 <!--添加回复+举报+时间  -->
 							 <div style="color: #959595; width: 100% " >
                                   	<!--点赞操作  -->
                                   	<span>
                                   		<img onclick="greatCount(${cr.father.id},this)" style="width: 30px;height: 25px;" alt="是否点赞" src="${cr.img}">
                                   		 &nbsp;
                                   		 <span style="font-size: 18;font-weight: 500" id="greatCount${cr.father.id}">${cr.father.greatCount }</span>
                                   	</span>
                                   <span style="float: right;">
                                   		<img style="width: 23px;height: 20px;" src="../image/time.png">&nbsp;
                                   		${fn:substring(cr.father.time,0,16) }
                                   </span>
                                   <span style="float: right;">
                                        <img style="width: 17px;height: 13px;" src="../image/report.png">&nbsp;
                                   		<a href="#" style="text-decoration: none;" >举报&nbsp;&nbsp;</a>
                                   </span>
                             </div>
                             <!--给回答的二级评论(son)  -->
                             <div style="width: 100%; padding:10px 0; text-align: left;">
						       	<div class="panel panel-default">
							  		<div class="panel-heading">
							  			<h4 class="panel-title">
							  				<a data-toggle="collapse" data-parent="#accordion"  href="#collapse${cr.father.id}">
								 				<c:choose>
								 					<c:when test="${fn:length(cr.son)==0}">
								 						<img src="../image/answer-count.png" style="width: 20px;height: 20px;" />
								 						 <span id="replyCount${cr.father.id}">添加讨论</span>
								 					 </c:when>
								 					<c:otherwise>
								 						<img src="../image/answer-count.png" style="width: 20px;height: 20px;" /> 
								 						<span id="replyCount${cr.father.id}">${fn:length(cr.son)}条评论</span>
								 					</c:otherwise>
								 				</c:choose>
								 						 
							  				</a>
										</h4>
									</div>
									<!--显示评论的全部内筒 -->
									<div id="collapse${cr.father.id }" class="panel-collapse collapse" style="background: #fafafa;">
										<div class="panel-body"><!--展示一个父亲的所有儿子  -->
									 	  <c:forEach items="${cr.son}" var="son">	
									 		<div >
									 			<div class="avatar-img" >
									 				<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=${son.user.username}">
											 			<img  src="<%=basePath%>${son.user.avatar}" />
											 		</a>
									  			</div>		  			
								  				<div class="user-name">
                                  	    			<a target="_blank" href="<%=basePath%>user/getUserUpdate.action?category=activities&userUpdateName=${son.user.username}">
                                  	    				<span style="margin: auto 0;" >${son.user.username}</span>
                                  	    			</a>
                                  				</div>
                                  				<!--添加举报+回复+时间  -->
                                  				<div style="float:right;">
                                  					 <span style="float: right;">
                                   						<img style="width: 23px;height: 20px;" src="../image/reply.png">&nbsp;
                                   		 				<a href="javascript:void(0);" onclick="answer(${son.father_id},'${son.user.username}')">
                                   		 					回复TA
                                   		 				</a>
                                   					 </span>
                                  					 <span style="float: right;">
                                   						<img style="width: 23px;height: 20px;" src="../image/time.png">&nbsp;
                                   		 				${fn:substring(son.time,0,16) }
                                   					 </span>
                                   					  <span style="float: right;">
                                       						 <img style="width: 17px;height: 13px;" src="../image/report.png">&nbsp;
                                   								<a href="#" style="text-decoration: none;" >举报&nbsp;&nbsp;</a>
                                   					  </span>
                                  				</div>
	                                  			<div style="float: left;width: 100%;">
	                                  				<p style="margin:0px 0px 15px 20px; border-bottom: 1px solid #dddddd; padding-bottom:5px;  word-wrap: break-word;font-size: 16px;">
	                                  					 ${son.content }
	                                  				</p>
	                                  			</div>
	                                  		</div>
	                                  	    </c:forEach>
	                                  		 
								  			<!--下面是填写评论  -->
								  			<div id="commitReply${cr.father.id}" style=" float: left;height:70px; width: 100%;
								  						padding:15px 15px; background-color:#ededed;"  >
								  				<input style=" width: 85%;" type="text" name="answer${cr.father.id}" />
							 					<input style="margin: 0 10px ;color: #8c96a0;" type="button" onclick="saveAnswer(${cr.father.id},1)"  value="提交"  />	
								  			</div>
							 				 								 	
										</div>
								 </div>
							</div>
     					</div>      
 				      </article>
 			     </div>
				 </c:forEach> 
				 
			  <!-- 展开更多回答 -->
		   <c:if test="${!isShowAll}">  
			 <div id="isShowAll" style="background: white;border: 2px solid #ececec;height: 50px;font-size: 20px;
 			     	 margin-top: 30px;text-align: center;">
 			    <a style="line-height: 50px;" id="getMoreAnswer" href="javascript:;"  >展开更多回答</a>
 			 </div>
 		   </c:if> 
				 
			</div>
			
			
			
			<div class="col-md-3 blog_right"> 
				
				<div class="news_letter">
					  <form action="<%=basePath%>ueditor/Question.jsp" id="questionForm">
						<input style="font-family:'Lucida Console', Monaco, monospace; font-size:30px; background:#65c4bc; float: none;"
						 id="questionAsk" type="button"  value="我要提问">
						 <input style="font-family:'Lucida Console', Monaco, monospace;
						 font-size:30px; background:#429ad9; float: none;" type="button" onclick="goEnd()" value="我要回答">
					 </form>
				</div>
	
				<hr style="border-top:10px solid #D8D8D8;" />
				<ul class="tag_nav list-unstyled">
					<h4>问题标签</h4><!--改问题所包含的标签  -->
						<c:forEach items="${tagList}" var="tagName" >
     						<li class="active"><a target="_blank" href="<%=basePath%>sport/searchContent.action?method=tag&value=${tagName}">${tagName }</a></li>
     					</c:forEach>
				</ul>
				<hr style="border-top:10px solid #D8D8D8;" />
				<!--类似的问题列表  -->
				  <h4>相关浏览</h4>
				 
				 <aside class="span4 page-sidebar">
				  <section class="widget"> 
                         <ul>
                         	 <c:forEach items="${relateQuestion}" var="question" >
	                              <li>
	                              	<a   href="<%=basePath%>talk/getQuestionDetail?question.id=${question.id}"  title="Lorem ipsum dolor sit amet,">
	                              		${question.title}
	                              	</a>
	                              </li>
	                              
                         	</c:forEach>
                         </ul>
                 </section>
                 </aside>
		   </div> 
			 <!-- <div class="clearfix"></div> -->  
	</div><!-- end blog -->
</div>
<!--填写答案编辑器  -->
<hr style="border:2px solid #d8d8d8; margin-left: 10%;width: 80%">
<div style="margin-left: 10%;margin-bottom:50px; width:840px;min-height:220px;
		padding:15px 10px 25px 10px;   background-color:#f2eeee; "  >
	<form method="post"  id="form">  
     <input type="hidden" name="answer.content" id="content" /> 
     <script id="editor" type="text/plain" style="width:820px;min-height:200px;height:auto;">	  
	 </script> 
	 <input type="button" id="saveReply" style="color: #8c96a0; float: right;margin-top: 10px;"  value="提交" /> 
	</form>
</div> 
</div>
</body>
 
  <!--返回顶部  -->
  <a href="#0" class="cd-top">Top</a>

</html>

