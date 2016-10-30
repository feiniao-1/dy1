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
<title>邮件列表</title>
<link href="img/toubiao.png" rel="SHORTCUT ICON">
<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/backstage.css"/>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<%
//获取当前url
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String jishu = "";
String dhpage = "";
try{
jishu = request.getParameter("jishu");
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
HashMap<String,String> param= G.getParamMap(request); 
//统计菜品总页数
List<Mapx<String,Object>> menupage=DB.getRunner().query("select count(1) as count from mail where (del is NULL or del <>1) ", new MapxListHandler());
int pagetotal=Integer.parseInt(menupage.get(0).getIntView("count"))/10;
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
//博客列表信息
//CREATE TABLE `mail` (
//  `mailid` int(11) NOT NULL AUTO_INCREMENT COMMENT '邮箱ID',
//  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
//  `mail` varchar(255) DEFAULT NULL COMMENT '邮箱',
//  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
//  `updatetime` datetime DEFAULT NULL COMMENT '最新修改时间',
//  `count` int(11) DEFAULT NULL COMMENT '统计次数',
//  `del` int(11) DEFAULT NULL,
//  `status` varchar(255) DEFAULT NULL,
//  PRIMARY KEY (`mailid`)
//) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
//设置标题栏信息
String[] colNames={"邮件ID","姓名","邮箱","创建时间","发送时间","状态","操作"};
//博客列表信息
List<Mapx<String,Object>> menu=DB.getRunner().query("select mailid,username,mail,substring(createtime,1,19) as createtime,substring(updatetime,1,19) as updatetime,count,status from mail where (del is NULL or del <>1) order by mailid desc limit "+intdhpage*10+",10  ", new MapxListHandler());
System.out.println(menu);
//删除
String dhid; 
if((param.get("Action")!=null)&&(param.get("Action").equals("发送"))){
	dhid=new String(request.getParameter("tagid").getBytes("iso-8859-1"),"utf-8");
		DB.getRunner().update("update mail set updatetime=?,status=? where mailid=?",df.format(new Date()),"已发送",dhid);
		%>
		<script type="text/javascript" language="javascript">
				alert("状态修改成功");                                            // 弹出错误信息
				window.location='admin_mail_list.jsp' ;                            // 跳转到登录界面
		</script>
	<%
	
}
%> 
</head>
<body>
<div class="container mainbox">
    <div class="row">
        <h3 class="title">新闻列表信息</h3>
        <div class="botton-group">
        <a href="front_index.jsp" class="btn btn-primary">首页</a>
        <a href="admin_news_list.jsp" class="btn btn-primary">发表新闻</a>
        <a href="admin_product.jsp" class="btn btn-primary">发表菜品</a>
        <a href="admin_mail_list.jsp" class="btn btn-warning">邮件列表</a>
        </div>
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
					<%for(int j=0;j<menu.size();j++) {%>
						<tr>
							<td><%=menu.get(j).getIntView("mailid") %></td>
							<td><%=menu.get(j).getStringView("username") %></td>
							<td><%=menu.get(j).getStringView("mail") %></td>
							<td><%=menu.get(j).getStringView("createtime") %></td>
							<td><%=menu.get(j).getStringView("updatetime") %></td>
							<%if(menu.get(j).getStringView("status").equals("")){ %>
							<td>未发送</td>
							<%}else{ %>
							<td><%=menu.get(j).getStringView("status") %></td>
							<%} %>
							<td>
								<form  id="subform<%=j %>" method="POST" style="float:right;">
									<input type="hidden" value="<%=menu.get(j).getIntView("mailid") %>" name="tagid">
									<input type="hidden" value="发送" name="Action">
								</form>
							<%if(menu.get(j).getStringView("status").equals("")){ %>
							<a class="zhuce"  name="发送" onclick="test_post<%=j %>()">发送</a>
							<%}else{ %>
							<span>已操作</span>
							<%} %>
								
							</td>
						</tr>
<script type="text/javascript">
function test_post<%=j %>() {
var testform=document.getElementById("subform<%=j %>");
testform.action="admin_mail_list.jsp?aa=<%=j %>";
testform.submit();
}
</script>
<%} %>

					</tbody>
				</table>
				<!-- 表格 end -->
				<!-- 分页start -->
				<div class="nav-page">
								    <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/admin_mail_list.jsp?page=<%=minus%>">«</a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_mail_list.jsp?page=0">1</a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_mail_list.jsp?page=1">2</a></li>
								    <%if(pagetotal>=3){ %>
								    <li><a href="${pageContext.request.contextPath}/admin_mail_list.jsp?page=2">3</a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_mail_list.jsp?page=<%=pagetotal-1%>"><%=pagetotal%></a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_mail_list.jsp?page=<%=pagetotal%>"><%=pagetotal+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_mail_list.jsp?page=<%=plus%>">»</a></li>
								  </ul>
				</div>
				<!-- 分页end -->
  </div>
</div>
</body>
</html>