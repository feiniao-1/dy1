<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%
HashMap<String,String> param= G.getParamMap(request);
if(param.get("Action")!=null && param.get("Action").equals("提交")){
System.out.println("提交:"+param.get("myEditor"));
response.getWriter().print("<div class='content'>"+param.get("myEditor")+"</div>");
}
%>
<!DOCTYPE HTML>
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title></title>
    <!-- 配置文件 -->
    <script type="text/javascript" src="ueditor/ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="ueditor/ueditor.all.js"></script>
    <style type="text/css">
        body{
            font-size:14px;
        }
    </style>
</head>
<body>
    <h2>UEditor提交示例11</h2>
    <form id="form" method="post" target="_blank" action="${pageContext.request.contextPath}/test.jsp" style="width:1000px;">
         <script type="text/plain" id="myEditor" name="myEditor"></script>
         <script type="text/plain" id="myEditor1" name="myEditor">
        </script>
        <input type="submit" name="Action"  value="提交">
    </form>

    <script type="text/javascript">
        var editor_a = UE.getEditor('myEditor',{initialFrameHeight:200});
        var editor_a = UE.getEditor('myEditor1',{initialFrameHeight:200});
    </script>

</body>


</html>
