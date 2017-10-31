<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<script type="text/javascript">
	function get(){
		document.form1.submit();
	}
	</script>
</head>
<body onload="get()">
		
		<form name="form1" action="${pageContext.request.contextPath}/article/getIndexArticle.action" method="post">
				
		</form>

</body>
</html>
