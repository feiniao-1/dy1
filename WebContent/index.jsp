<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<script type="text/javascript" src="js/jquery-1.8.0.min.js"></script> 
	<script type="text/javascript" src="ckeditor/ckeditor.js"></script>  
    <script type="text/javascript" src="ckeditor/config.js"></script>  
    <script type="text/javascript">
	    $(document).ready(function(){  
	    	CKEDITOR.replace('myckeditor'); 
	    });  
    </script>
  </head>
  
  <body>
    	 <textarea name="myckeditor"></textarea>  
  </body>
</html>
