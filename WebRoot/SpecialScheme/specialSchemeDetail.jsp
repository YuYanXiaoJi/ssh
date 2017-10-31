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
<!--sweetalert  -->
 <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/sweetalert/sweetalert.min.js "></script>
 <link rel="stylesheet" href="<%=basePath%>css/sweetalert/sweetalert.css">
<!-- 基本样式 -->
<link rel="stylesheet" type="text/css" href="<%=basePath%>SpecialScheme/css/jquery.fullPage.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>SpecialScheme/css/style.css">
<!-- bootstrap -->
<script type="text/javascript" src="<%=basePath%>jquery/jquery-3.2.1.min.js "></script>
<script src="<%=basePath%>Admin/js/bootstrap.min.js"></script> 
<link rel="stylesheet" type="text/css" href="<%=basePath%>Admin/css/bootstrap.min.css">
<!-- 下拉搜索框 -->
<script src="<%=basePath%>SpecialScheme/js/area.js"></script>
	
	<style type="text/css">
		a,a:hover,a:visited,a:focus{
			/*text-decoration: none; */
			color: black;
		}
		select {
			 height: 30;width: 130;
		}
		h1,h3 {
			color: white;
		}
	</style>
	
</head>

<body>
<div class="ml-nav">
	<div class="center-wrap clearfix">
		<span style="font-size: 30;" >知了</span>
		<p class="ml-link">
			<a href="${pageContext.request.contextPath}/index.jsp">主页</a>
			<a href="${pageContext.request.contextPath}/sport/showSportAll.action?category1.name=全部地区&category2.name=全部类别&category3=score">乡村</a>
			<a href="${pageContext.request.contextPath}/article/getArticleAll.action">见闻</a>
			<a href="${pageContext.request.contextPath}/recommend.action">为你推荐</a> 
			<a href="${pageContext.request.contextPath}/userGetSpecialSchemeAll.action">特别策划</a>
			<a href="${pageContext.request.contextPath}/talk/getQuestionAll.action?category=1">秉烛夜谈</a>
			<c:if test="${empty (sessionScope.name)}">
				<a   href="${pageContext.request.contextPath}/User/Login.jsp">登入/注册</a>
			</c:if>
		</p>
		<a class="buy-now" style="    margin-right: 5%;" href="javascript:;" onclick="recruit()">立即报名</a>
	</div>
</div>
 	
 	<div class="section"  style="height: 1000;width: 100%;background-image:url(${specialScheme.page1});background-size:100% 100%; ">
 		<div class="center-wrap">
			<div class="desc cnc-desc" style="padding-top: 20%;margin-left: 10%">
				<h1>${specialScheme.h1}</h1>
				<h3>${specialScheme.p1}</h3>
			</div>
		</div>
 	</div>
  
	 
	 
	<div class="section"  style="height:  1000;width: 100%;background-image:url(${specialScheme.page2});background-size:100% 100%; ">
		<div class="center-wrap" style="margin-left: 50%;">
			<div class="desc cnc-desc"  >
				<h1>${specialScheme.h2}</h1>
				<h3>${specialScheme.p2}</h3>	
			</div>
		</div>
	</div>
   
	<div class="section"  style="height: 1000;width: 100%;background-image:url(${specialScheme.page3});background-size:100% 100%; ">
		<div class="center-wrap">
			<div class="desc camera-desc">
				<h1>${specialScheme.h3}</h1>
				<h3>${specialScheme.p3}</h3>
			</div>
		</div>
	</div>  
 
	 <div class="section"  style="height: 1000;width: 100%;background-image:url(${specialScheme.page4});background-size:100% 100%; ">
		<div class="center-wrap">
			<div class="desc cnc-desc">
				<h1>${specialScheme.h4}</h1>
				<h3>${specialScheme.p4}</h3>
			</div>
		</div>
	</div>
  
	 <div class="section"  style="height: 800;width: 100%;background-image:url(${specialScheme.page5});background-size:100% 100%; ">
		<div class="center-wrap" style="margin-left:10%">
			<div class="desc camera-desc">
				<h1>${specialScheme.h5}</h1>
				<h3>${specialScheme.p5}</h3>
			</div>
		</div>
	</div> 
	

<!--个人信息模态框-->
<div class="modal fade" id="seeUserInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <form  id="form" method="post" action="saveSpecialSchemeUser.action" >
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" >填写报名表</h4>
          <span style="color:red;" id="modal-msg"></span>	
        </div>
        <div class="modal-body">
          <table class="table" style="margin-bottom:0px;">
            <thead>
              <tr> </tr>
            </thead>
            <tbody>
              <tr>
                <td wdith="20%">
                	<span>真实姓名:</span>		
                </td><!--真实名字就暂存在background字段中  -->	<!--must  必须输入的选项  -->
                <td width="80%">
                	<input  type="hidden" name="specialScheme.id" value="${specialScheme.id}" /> 
                	<input type="text" name="specialSchemeUser.realName" id="1"  class="must form-control" maxlength="10" autocomplete="off" />
                </td>
              </tr>
              <tr>
                <td wdith="20%">
                	<span>电话:</span>
                </td>
                <td width="80%">
                	<input type="text"   class="must form-control" onkeyup="value=this.value.replace(/\D+/g,'')" name="specialSchemeUser.telephone" id="2" maxlength="13" autocomplete="off" />
                </td>
              </tr>

              <tr>
                <td wdith="20%">
                	<span >详细地址</span>	
                </td>
                <td width="80%" class="address">
                	<input type="hidden" id="address"  name="specialSchemeUser.address"  /> 
	 					<select id="s_province" name="s_province"></select>  
	 					<select id="s_city" name="s_city" ></select>  
	 					<select id="s_county" name="s_county"></select>
 					<script class="resources library" src="<%=basePath%>SpecialScheme/js/area.js" type="text/javascript"></script>
 					<script type="text/javascript">_init_area();</script>
                </td>
              </tr>
              <tr>
                <td wdith="20%">
                	<span>年龄</span>
                </td>
                <td width="80%">
                	<input type="text" id="3" name="specialSchemeUser.age" onkeyup="value=this.value.replace(/\D+/g,'')" class="form-control"  maxlength="18" autocomplete="off" />
                </td>
              </tr>
               <tr>
                <td wdith="20%">
                	<span>性别</span>
                </td>
                <td width="80%">
                	  <select name="specialSchemeUser.sex"  id="4" class="form-control">
		                <option value="男" selected>男</option>
		                <option value="女">女</option>
              		</select> 
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
          <button type="button" class="btn btn-primary" id="issue" >提交</button>
        </div>
      </div>
    </form>
  </div>
</div>

 
 
 
<!--用户报名  -->
<script type="text/javascript">
	//监听地址选择
	var a1 = false, a2 = false, a3 = false;//判断用户的地址选择
	$(function(){
		$('#s_province').on('change',function(){
			a1 = ($(this).val() != '省份') ? true : false;
		});
		$('#s_city').on('change',function(){
			a2 = ($(this).val() != '地级市') ? true : false;
		});
		$('#s_county').on('change',function(){
			a3 = ($(this).val() != '县级市') ? true : false;
		});
		 
	}); 
	 
	//点击发布提交
	function recruit()	{
		 if('${sessionScope.name}' == '') {
			swal('请先登入哦~');
			return false;
		}  
		$('#seeUserInfo').modal('show');
	}
	
	$(function(){
		$('#issue').click(function(){
			  for(var i = 1; i <= 4; i++) {
				if ('' == $.trim($('#' + i).val())) {
					$('#modal-msg').text('请填写完整');
					return false;
				}
			}  
			if (!(a1 && a2 && a3)) {
				$('#modal-msg').text('请选择地址');return false;
			} 
			
			var address = '';
			$('.address select').each(function(){
				address += $(this).val();
			});
			
			$('#address').val(address);
		     swal({
			  title: "报名成功",
			  type: "success",
			  showCancelButton: false,
			  confirmButtonColor: "#8cd4f5",
			  confirmButtonText: "Yes!",
			  closeOnConfirm: false
			},
			function(){ 
				 $('#form').submit();
			});  
			
			
		});
		
		$('#seeUserInfo').on('hidden.bs.modal', function () {
		   for(var i = 1; i <= 4; i++) {
				$('#' + i).val('');
				$('#modal-msg').text(''); 
			}
			a1 = a2 = a3 = false;
			$('select option:eq(0)').prop('selected',true);
		});	
		
		
	});
	
</script> 
</body>
</html>