<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
    <!-- <script  src=../jquery/jquery-3.2.1.min.js"></script> -->
    <script type="text/javascript" src = "<%=basePath%>jquery/jquery-3.2.1.min.js"></script>
    <!--sweetalert  -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/sweetalert/sweetalert.min.js "></script>
   <link rel="stylesheet" href="<%=basePath%>css/sweetalert/sweetalert.css">
    <!--引入input框  -->
    <link href="<%=basePath%>css/input/input.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>css/button/button.css" rel="stylesheet" type="text/css" />
    <!--标签的折叠  -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    <!--百度编辑器  -->
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor-forAnswer.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/lang/zh-cn/zh-cn.js"></script>

    <style type="text/css">
        div{
            width:100%;
        }
        a:focus,a:hover {
        	text-decoration: none;
        }
        .button a{
        	color:white;
        	text-decoration: none;
        }
        
    </style>
    <script type="text/javascript" src="<%=basePath%>jquery/jquery-3.2.1.min.js "></script>
    <script type="text/javascript">
    	
    	var tagName = '', category1 = '', category2 = '';
    	
    	//如果是修改问题
    	$(function(){
    		if('${question}' != ''){
    			$('#Qid').prop('value', '${question.id}' );
    			var array  = new Array();
    			<c:forEach items='${questionCategory}' var='t'>
    				if('${t}' != ''){
    					array.push('${t}');
    				}
    			</c:forEach>
    			 for(var i in array){

    				if(i == 0){
    					$('input[name="Three"]').each(function(){
    						if($(this).prop('value') == array[i]){
    							$(this).prop('checked', 'true');
    							$('#Three').text(array[i]);
    							category1 = array[i];
    						}
    					});
    				}else if(i == 1){
    					$('input[name="Two"]').each(function(){
    						if($(this).prop('value') == array[i]){
    							$(this).prop('checked', 'true');
    							$('#Two').text(array[i]);
    							category2 = array[i];
    						}
    					});
    				}else {
    					$('#tag').val(array[2]);
    					tagName = array[2];
    				}
    			} 
    			
    		}
    	}); 
    	 
    	 //设置输入的字数限制
    	$(document).ready(function(){
    		$("#title").keyup(function(){
    			var numb = 50 - $.trim($(this).val()).length;
    			if(numb <= 0){
    				$(this).val($(this).val().substring(0,50))
    				$("#checkWord").text(0);
    			}else{
    				$("#checkWord").text(numb);
    			}
 
    		});
    	});
    	
    	//鉴定是否选中了单选按钮  大类别
    	$(document).ready(function(){
    		$("input[name='Two']").each(function(){
    			$(this).click(function(){
    				$("#Two").text($(this).prop("value"));
    				category2 = $(this).prop("value");
    			});
    		});
    	});
    	//地区
    	$(document).ready(function(){  
    		$("input[name='Three']").each(function(){
    			$(this).click(function(){
    				$("#Three").text($(this).prop("value"));
    				category1 = $(this).prop("value");
    			});
    		});
    	});
    	
    	//填写自定义标签
    	$(document).ready(function(){
    		$("#tag").change(function(){
    			 tagName = $.trim($(this).val());
    			} ); 
    	});
    	//提交表单
    	$(document).ready(function(){
    		$("#save").click(function(){
    			if(category1 == '' || category2 == ''){
    				swal("请选择板块哦~");
    			}else{
	    			var ue = UE.getEditor('editor'); 
	    			if($.trim($("#title").val()) == ''
	    				||	$.trim(ue.getContent()) == '' ){
	    				swal("需要填写完整标题和内容哦~");
	    			}
	    			else{
	    				$("#Qcontent").prop("value", ue.getContent());
	    				if(tagName == ''){
	    					$("#Qtag").prop("value",category1+'/'+category2);
	    				}else  $("#Qtag").prop("value",category1+'/'+category2+'/'+tagName);
	    				$("#form").prop("action", "<%=basePath%>"+"talk/saveQuestion.action");
	    				$("#form").submit();
	    			}
    			}
    			
    		});
    	});
    	//返回shangyiye 
    	function goBack(){
		 swal({
    		title: "确定取消填写吗?",
  			type: "warning",
  			showCancelButton: true,
  			confirmButtonColor: "#DD6B55",
  			confirmButtonText: "Yes",
  			closeOnConfirm: false
  		},function(){
  				var backUrl = '<%= request.getHeader("Referer")%>';
  				location.href=backUrl;
  			}	
  		);
 
   } 	
    	
    </script>
    
</head>
<body>

<div  style="text-align: center;">
 	  <div class="button" style="float: left;height: 30;width: 60px; ">
    		<a href="javascript:void(0);" class="more red" onclick="goBack()" >返回</a>
		</div>
		<br>
      <form  method="post" id="form"   >
     	<br><br>
     		<div class="group">      
      			<input type="text" id="title" name="question.title" required value="${question.title}">
      			<span class="highlight"></span>
      			<span class="bar"></span>
      			<label style="color:#a5e4b3;" >键入标题</label>
      			<div style="margin-top: 15px;text-align: left;color:#a5e4b3;">
      				还可以输入<span id="checkWord">50</span>字
      			</div>
    		</div>
    		
    		
    	<div style="text-align: center; height: 30px;margin: 0 0 30 0;">
    		<span style="color:#a5e4b3;font-size: 22px;" >问题描述</span>
    	</div>
        <script id="editor" type="text/plain" style="margin:0 auto;  width:1024px;height:300px;">	  
		</script>
		<div style="text-align: center; height: 30px;margin: 30 0 30 0;">
    		<span style="color:#a5e4b3;font-size: 22px;" >问题标签选择</span>
    	</div>
    	
 <div class="panel-group" id="accordion" style="width: 1022px;margin: 0 auto;">
 
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<a  data-toggle="collapse" data-parent="#accordion" 
				   href="#collapseTwo">
					主板块&nbsp;&nbsp;&nbsp;<span id="Two" style="color:#10b041;"></span>
				</a>
			</h4>
		</div>
		<div id="collapseTwo" class="panel-collapse collapse">
			<div class="panel-body">
				<input style="width: 50;display:inline;" type="radio" name="Two" value="民族风情"  />民族风情
				<input style="width: 50;display:inline;" type="radio" name="Two" value="人文历史" />人文历史
				<input style="width: 50;display:inline;" type="radio" name="Two" value="田园休闲" />田园休闲
				<input style="width: 50;display:inline;" type="radio" name="Two" value="健康生态" />健康生态
				<input style="width: 50;display:inline;" type="radio" name="Two" value="山青水绿 " />山青水绿 
				<input style="width: 50;display:inline;" type="radio" name="Two" value="其他 " />其他
			</div>
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<a data-toggle="collapse" data-parent="#accordion" 
				   href="#collapseThree">
					地区&nbsp;&nbsp;&nbsp;<span id="Three" style="color:#10b041;"></span>
				</a>
			</h4>
		</div>
		<div id="collapseThree" class="panel-collapse collapse">
			<div class="panel-body">
				<div class="panel-body">
				<input style="width: 50;display:inline;" type="radio" name="Three" value="浙江" />浙江
				<input style="width: 50;display:inline;" type="radio" name="Three" value="云南" />云南
				<input style="width: 50;display:inline;" type="radio" name="Three" value="贵州" />贵州
				<input style="width: 50;display:inline;" type="radio" name="Three" value="四川" />四川
				<input style="width: 50;display:inline;" type="radio" name="Three" value="广东" />广东
				<input style="width: 50;display:inline;" type="radio" name="Three" value="江苏" />江苏
				<input style="width: 50;display:inline;" type="radio" name="Three" value="广西" />广西
				<input style="width: 50;display:inline;" type="radio" name="Three" value="辽宁" />辽宁
				<input style="width: 50;display:inline;" type="radio" name="Three" value="江西" />江西
				<input style="width: 50;display:inline;" type="radio" name="Three" value="福建" />福建
				<input style="width: 50;display:inline;" type="radio" name="Three" value="安徽" />安徽
				<input style="width: 50;display:inline;" type="radio" name="Three" value="河南" />河南
				<input style="width: 50;display:inline;" type="radio" name="Three" value="湖南" />湖南
				<input style="width: 50;display:inline;" type="radio" name="Three" value="新疆" />新疆
				<input style="width: 50;display:inline;" type="radio" name="Three" value="其他" />其他
			</div>
 
			</div>
		</div>
	</div>
	<!--自定义标签  -->
	 <div class="group" style="margin: 30px 300px;">      
      	 <input  type="text" id="tag"  required>
      	 <span class="highlight"></span>
      	 <span class="bar"></span>
      	 <label style="color:#a5e4b3;" >自定义标签(利用'/'分割)</label>
    </div>
</div>
    
		 <input type="hidden"   id="Qcontent" name="question.content" />
		  <input type="hidden"   id="Qtag" name="question.tag" />
		  <input type="hidden" id="Qid" name="question.id">
		 <div class="button" style="text-align: center;">
    		<a href="javascript:void(0);" class="more red" id="save" >提交问题</a>
		</div>
		
     </form>
    
   
</div>
 

<script type="text/javascript">

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');
	 
	//如果需要修改问题  
	 $(function(){
		if('${question}' != ''){
			ue.ready(function(){
				ue.setContent('${question.content}');
			});
		}
	}); 

    function isFocus(e){
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e)
    }
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e)
    }
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('editor').execCommand('insertHtml', value)
    }
    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }
    function getAllHtml() {
        alert(UE.getEditor('editor').getAllHtml())
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'))
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UE.getEditor('editor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UE.getEditor('editor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UE.getEditor('editor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UE.getEditor('editor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UE.getEditor('editor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }

    function getLocalData () {
        alert(UE.getEditor('editor').execCommand( "getlocaldata" ));
    }

    function clearLocalData () {
        UE.getEditor('editor').execCommand( "clearlocaldata" );
        alert("已清空草稿箱")
    }
</script>
</body>
</html>
