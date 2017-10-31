<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
    <title>完整demo</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <script type="text/javascript" charset="utf-8" src="ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="lang/zh-cn/zh-cn.js"></script>

    <style type="text/css">
        div{
            width:100%;
        }
        
    </style>
    
    <script type="text/javascript">
    function  test(){
     var content = UE.getEditor('editor').getContent();
     document.getElementById("content").value=content;
      
     var index1 = document.getElementById("select1").selectedIndex;
     var category1 = document.getElementById("select1").options[index1].value;
     document.getElementById("category1").value=category1;
      
     var index2 = document.getElementById("select2").selectedIndex;
     var category2 = document.getElementById("select2").options[index2].value;
     document.getElementById("category2").value=category2;   
     
     document.form1.action="createSport";
     document.form1.submit();   
    } 
    
    
    </script>
    
   
</head>
<body>

<div>
 	 
     <form  method="post"  name="form1"  target="_blank" enctype="multipart/form-data"  >
     	
     	景点名字：<input  type="text"   name="sport.name" /><br><br>
                        景点概述：<input type="text"  name="sport.summary" /><br><br>
                        上传封面1： <input type="file" name="uploadImage"/><br/><br/> 
                       上传封面2： <input type="file" name="uploadImage"/><br/><br/> 
                        上传封面3： <input type="file" name="uploadImage"/><br/><br/>
                        东经： <input type="text" name="sport.x"/><br/><br/>  
                        北纬： <input type="text" name="sport.y"/><br/><br/> 
                         省份： 
            <select id="select1">
            	<option value="浙江">浙江</option>
            	<option value="江苏">江苏</option>
            	<option value="云南">云南</option>
            	<option value="贵州">贵州</option>
            	<option value="四川">四川</option>
            	<option value="广东">广东</option>
            </select>
                         类别：  
            <select id="select2">
            	<option value="美丽">美丽</option>
            	<option value="文化">文化</option>
            	<option value="名族风情">名族风情</option>
            	<option value="田园">田园</option>
            	<option value="古典">古典</option>
            </select>         
     	<h3>主要简介：</h3>
        <script id="editor" type="text/plain" style="width:1024px;height:500px;">
			  
		</script>
		<input type="hidden" name="category1.name" id="category1" />
		<input type="hidden" name="category2.name" id="category2" />
		<input type="hidden" name="sport.content" id="content" />
		<br>
        <input type="button"  value="添加景点"  onclick="test()"  /> 
        
 
     </form>
    
   
</div>
 

<script type="text/javascript">

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');


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
