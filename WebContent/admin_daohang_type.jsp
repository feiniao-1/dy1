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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">
<title>博客编辑</title>
<link href="img/toubiao.png" rel="SHORTCUT ICON">
<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/bootstrap-theme.min.css"/>
<link rel="stylesheet" href="css/style.css"/>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<%
//获取当前url
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String jishu = "";
String fileName = "";
String fullName = "";
String dhpage = "";
try{
jishu = request.getParameter("jishu");
fileName = request.getParameter("fileName");
fullName = request.getParameter("fullName");
dhpage = request.getParameter("page");
System.out.println("jishu"+jishu);
}catch(Exception e){
	
}
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
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式  
System.out.println(df.format(new Date()));// new Date()为获取当前系统时间  
//设置随机数
int  val = (int)(Math.random()*10000)+1;
int tagid=(int)new Date().getTime()/1000+(int)(Math.random()*10000)+1;
int url_canshu;
if(jishu==null){
	url_canshu=Integer.parseInt("1");
}else{	
	url_canshu=Integer.parseInt(jishu);
}
//当前登录用户
//int dluserid=useridc.get(0).getInt("userid");
int dluserid=10196;
//设置标题栏信息
String[] colNames={"ID","名字","分类级别","父级ID","排序权重","操作"};	
//统计导航栏总页数
List<Mapx<String,Object>> daohangpage=DB.getRunner().query("select count(1) as count from daohang_type where del=? ", new MapxListHandler(),"0");
int pagetotal=Integer.parseInt(daohangpage.get(0).getIntView("count"))/10;
System.out.println("总页数="+pagetotal);
//如果urlpage为null
int intdhpage;
if(dhpage==null){
	intdhpage=Integer.parseInt("0");
}else{	
	intdhpage=Integer.parseInt(dhpage);
}
System.out.println("当前页数="+intdhpage);
int plus;
int minus;
//下一页
if(intdhpage==pagetotal){
	plus=pagetotal;
}else{
	plus =intdhpage+1;
}
//上一页
if(intdhpage==0){
	minus =0;	
}else{
	minus =intdhpage-1;
}
HashMap<String,String> param= G.getParamMap(request); 
//导航栏信息
//CREATE TABLE `daohang_type` (
//  `id` int(11) DEFAULT '0',
//  `level` int(11) DEFAULT NULL COMMENT '分类级别1级分类2级分类3级分类',
//  `name` varchar(255) DEFAULT NULL,
//  `parentid` int(11) DEFAULT NULL COMMENT '父级id,一级的父级id是0',
//  `paixu` int(11) DEFAULT NULL COMMENT '排序，越大越往前',
//  `del` int(11) DEFAULT NULL
//) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='导航分类';
List<Mapx<String,Object>> daohang=DB.getRunner().query("select id ,level,name,parentid,paixu,del from daohang_type where del=? order by level,id limit "+intdhpage*10+", 10 ", new MapxListHandler(),"0");
//删除
String dhid;
System.out.println("提交前"+param.get("Action"));  
if((param.get("Action")!=null)&&(param.get("Action").equals("删除"))){
	dhid=new String(request.getParameter("dhid").getBytes("iso-8859-1"),"utf-8");
		DB.getRunner().update("update daohang_type set del=? where id=?","1",dhid);
		%>
		<script type="text/javascript" language="javascript">
				alert("删除成功");                                            // 弹出错误信息
				window.location='admin_daohang_type.jsp' ;                            // 跳转到登录界面
		</script>
	<%
	
}
%> 
</head>
<body>
<div class="panel panel-default container box-shadow"  style="text-align:center; padding-top:50px; margin-top:50px;">
    <div class="row">
<h3>top导航栏信息</h3><br>
        <span style="margin-left:500px;">
        <a href="admin_boke_edit.jsp" class="btn btn-primary">发表博客</a>/<a  href="admin_baike_edit.jsp" class="btn btn-primary">发表百科</a>/<a href="front_index.jsp" class="btn btn-primary">首页</a></span><br>
        <a href="#" class="btn btn-primary">添加</a>
        		<!-- 表格 start -->
				<table class="table table-striped">
					<thead>
						<tr>
							<% for(int i=0;i<colNames.length;i++){%>
							<th><%= colNames[i] %></th>
							<%} %>
						</tr>
					</thead>
					<tbody>
					<%for(int j=0;j<daohang.size();j++) {%>
						<tr>
							<td><%=daohang.get(j).getIntView("id") %></td>
							<td><%=daohang.get(j).getStringView("name") %></td>
							<td><%=daohang.get(j).getIntView("level") %></td>
							<td><%=daohang.get(j).getIntView("parentid") %></td>
							<td><%=daohang.get(j).getIntView("paixu") %></td>
							<td>
<script type="text/javascript">
function guanli(){
	window.location='admin_daohang_type_publish.jsp?daohangid=<%=daohang.get(j).getIntView("id") %>' ; 
}
</script>
								<div style="width:100px;"><input type="button" value="管理" onclick="guanli()" style="float:left;">|
								<form action="admin_daohang_type.jsp"  method="POST" style="float:right;">
								<input type="hidden" value="<%=daohang.get(j).getIntView("id") %>" name="dhid">
								<input type="submit" value="删除" name="Action">
								</form>
								</div>
							</td>
						</tr>
<%} %>
					</tbody>
				</table>
				<!-- 表格 end -->
				<!-- 分页start -->
				<div class="nav-page">
								    <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/admin_daohang_type.jsp?page=<%=minus%>">«</a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_daohang_type.jsp?page=0">1</a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_daohang_type.jsp?page=1">2</a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_daohang_type.jsp?page=2">3</a></li>
								    <li><a>...</a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_daohang_type.jsp?page=<%=pagetotal-1%>"><%=pagetotal%></a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_daohang_type.jsp?page=<%=pagetotal%>"><%=pagetotal+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_daohang_type.jsp?page=<%=plus%>">»</a></li>
								  </ul>
				</div>
				<!-- 分页end -->
  </div>
</div>
</body>
</html>