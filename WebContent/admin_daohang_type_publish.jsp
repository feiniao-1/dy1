<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="css/back/bootstrap.css">
<link rel="stylesheet" href="css/back/main.css">
<title>商品分类管理</title>
<style type="text/css">
.style1{
background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
    color: #555;
    display: block;
    font-size: 14px;
    height: 20px;
    line-height: 1.42857;
    padding: 6px 12px;
    transition: border-color 0.15s ease-in-out 0s, box-shadow 0.15s ease-in-out 0s;
    width: 10%;
}
</style>
</head>
<body>
<% 
//验证用户登陆
Mapx<String,Object> user = G.getUser(request);
String pageType = null;
String userType = null;
//验证用户登陆
String username = (String)session.getAttribute("username");
List<Mapx<String, Object>> useridc= DB.getRunner().query("SELECT userid FROM user where username=?", new MapxListHandler(),username);
int flag=0;
if(username==null){
	%>
	<script type="text/javascript" language="javascript">
			alert("请登录");                                            // 弹出错误信息
			window.location='front_login.jsp' ;                            // 跳转到登录界面
	</script>
<%
}else{
	flag=1;
}
HashMap<String,String> param= G.getParamMap(request);
//获取当前url
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String daohangid = "";

try{
	daohangid = request.getParameter("daohangid");

}catch(Exception e){
	
}
//导航栏信息
//CREATE TABLE `daohang_type` (
//`id` int(11) DEFAULT '0',
//`level` int(11) DEFAULT NULL COMMENT '分类级别1级分类2级分类3级分类',
//`name` varchar(255) DEFAULT NULL,
//`parentid` int(11) DEFAULT NULL COMMENT '父级id,一级的父级id是0',
//`paixu` int(11) DEFAULT NULL COMMENT '排序，越大越往前',
//`del` int(11) DEFAULT NULL
//) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='导航分类';
List<Mapx<String,Object>> daohang=DB.getRunner().query("select id ,level,name,parentid,paixu,del from daohang_type where id=?", new MapxListHandler(),daohangid);
//编辑保存

String name;
String paixu;
System.out.println("提交前"+param.get("Action"));
if((param.get("Action")!=null)&&(param.get("Action").equals("确定"))){
	name=new String(request.getParameter("name").getBytes("iso-8859-1"),"utf-8");
	paixu=new String(request.getParameter("paixu").getBytes("iso-8859-1"),"utf-8");
	System.out.println("提交："+name+paixu);
		//DB.getRunner().update("insert into daohang_type(name,paixu) values(?,?,?)",name,paixu);
		DB.getRunner().update("update daohang_type set name=?,paixu=? where id=?",name,paixu,daohangid);
		%>
		<script type="text/javascript" language="javascript">
				alert("修改成功");                                            // 弹出错误信息
				window.location='admin_daohang_type_publish.jsp?daohangid=<%=daohang.get(0).getIntView("id") %>' ;                            // 跳转到登录界面
		</script>
	<%
	
}
%>

<center>
<h2>导航信息编辑 <button value="返回" onclick="fanhui()"> 返回</button></h2>
				<form action="admin_daohang_type_publish.jsp?daohangid=<%=daohang.get(0).getIntView("id") %>" method="POST" >
					<div >
						<label>ID</label> <input type="text"  readOnly="true" value="<%=daohang.get(0).getIntView("id") %>" style="background:#eee;width:50px;"> &nbsp; &nbsp;(ID由系统自动生成)
					</div>
					<div>
						<label>名称</label> <input type="text"  name="name" 	value="<%=daohang.get(0).getStringView("name")%>">
					</div>
					<div>
						<label>排序权重</label> <input type="text" name="paixu" value="<%=daohang.get(0).getIntView("paixu") %>">
					</div>
					<input type="submit" Name="Action" value="确定" >
				</form>
</center>
<script type="text/javascript">
//返回
function fanhui(){
	window.location='admin_daohang_type.jsp' ; 
}

</script>

</body>
</html>