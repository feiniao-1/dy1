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
<title>菜品列表</title>
<link href="img/toubiao.png" rel="SHORTCUT ICON">
<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/backstage.css"/>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script src="js/jquery-1.11.1.min.js"></script>
<script src="layer/layer.js"></script>
<%
//获取当前url
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String jishu = "";
String fileName = "";
String fullName = "";
String dhpage = "";
String searchnr="";
try{
jishu = request.getParameter("jishu");
fileName = request.getParameter("fileName");
fullName = request.getParameter("fullName");
dhpage = request.getParameter("page");
searchnr = request.getParameter("searchnr");
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
List<Mapx<String,Object>> menupage=DB.getRunner().query("select count(1) as count from productmenu where del=? ", new MapxListHandler(),"0");
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
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式  
System.out.println(df.format(new Date()));// new Date()为获取当前系统时间 
//排序类型
String paixu;
if(param.get("paixu")==null){
	paixu="productmenuid";
}else if(param.get("paixu").equals("默认")){
	paixu="productmenuid";
}else if(param.get("paixu").equals("收藏量")){
	paixu="shoucang";
}else if(param.get("paixu").equals("shoucang")){
	paixu="shoucang";
}else{
	paixu="productmenuid";
}
String insearch;
if(request.getParameter("searchnr")!=null){
	insearch=new String(request.getParameter("searchnr").getBytes("iso-8859-1"),"utf-8");
}else{
	insearch="";
}

//菜品列表信息
//CREATE TABLE `productmenu` (
// `productmenuid` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜品ID',
//  `productlei` varchar(255) DEFAULT NULL COMMENT '菜品类别',
//  `productname` varchar(255) DEFAULT NULL COMMENT '菜名',
//  `productEname` varchar(255) DEFAULT NULL COMMENT '菜英文名',
//  `content1` text COMMENT '菜品简介',
//  `img1` varchar(255) DEFAULT NULL COMMENT '图片1',
//  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
//  `updatetime` datetime DEFAULT NULL COMMENT '最新修改时间',
//  `is_discuss` tinyint(1) DEFAULT NULL COMMENT '是否被评论',
//  `del` int(11) DEFAULT NULL,
//  `count` int(11) DEFAULT NULL COMMENT '销售量',
//  `yprice` int(11) DEFAULT NULL COMMENT '原价格',
//  `xprice` int(11) DEFAULT NULL COMMENT '现价格',
//  `shoucang` int(11) DEFAULT NULL COMMENT '收藏量',
//  `canshu_url` int(11) DEFAULT NULL,
//  `tagid` int(22) DEFAULT NULL,
//  `visitor` varchar(255) DEFAULT NULL,
//  PRIMARY KEY (`productmenuid`)
//) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
//设置标题栏信息
String[] colNames={"菜品ID","菜名","英文名","菜品类别","创建时间","销售量","价格","收藏量","操作"};
//菜品列表信息
List<Mapx<String,Object>> menu;
if((searchnr==null)||(searchnr=="")){
	menu=DB.getRunner().query("select productmenuid,productname,productEname,productlei,substring(createtime,1,19) as createtime,count,yprice,shoucang from productmenu where del=? order by "+paixu+" desc limit "+intdhpage*10+",10 ", new MapxListHandler(),"0");
}else{
	menu=DB.getRunner().query("select productmenuid,productname,productEname,productlei,substring(createtime,1,19) as createtime,count,yprice,shoucang from productmenu where del=? and productname like '%"+param.get("searchnr")+"%' ", new MapxListHandler(),"0");
}
System.out.println(menu);
//删除
String dhid; 
System.out.println("Action"+param.get("Action")+"dhid"+request.getParameter("dhid"));
if((param.get("Action")!=null)&&(param.get("Action").equals("删除"))){
	dhid=new String(request.getParameter("dhid").getBytes("iso-8859-1"),"utf-8");
		DB.getRunner().update("update productmenu set del=?,deltime=? where productmenuid=?","1",df.format(new Date()),dhid);
		%>
		<script type="text/javascript" language="javascript">
				alert("删除成功");                                            // 弹出错误信息
				window.location='admin_product.jsp' ;                            // 跳转到登录界面
		</script>
	<%
	
}
%> 
</head>
<body>
<div class="container mainbox">
    <div class="row">
     <h3  class="title">菜品列表信息</h3>
       <div class="botton-group">
       <a href="front_index.jsp" class="btn btn-primary">首页</a>
       <a href="admin_news_list.jsp" class="btn btn-primary">发表新闻</a>
       <a href="admin_product.jsp" class="btn btn-warning">发表菜品</a>
       <a href="admin_mail_list.jsp" class="btn btn-primary">邮件列表</a>
       </div>
       <div class="botton-group">
        <a href="admin_product_add.jsp" class="btn btn-danger">添加</a>
        <form action="admin_product.jsp"  method="POST" >
			<select name="paixu">
			<%if((param.get("paixu")!=null)&&(param.get("paixu").equals("收藏量"))) {%>
				<option>收藏量</option>
				<option>默认</option>
				<%}else if((param.get("paixu")!=null)&&(param.get("paixu").equals("shoucang"))) {%>
				<option>收藏量</option>
				<option>默认</option>
				<%}else{ %>
				<option>默认</option>
				<option>收藏量</option>
				<%} %>
		 	</select>
		 	<input type="text" Name="searchnr"  placeholder="搜索中文名">
			<input type="submit" value="搜索" name="search">
		</form>
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
							<td><%=menu.get(j).getIntView("productmenuid") %></td>
							<td><%=menu.get(j).getStringView("productname") %></td>
							<td><%=menu.get(j).getStringView("productEname") %></td>
							<td><%if(menu.get(j).getStringView("productlei").equals("主食")){%>
							美味主食
							<%}else{ %>
							<%=menu.get(j).getStringView("productlei")%>
							<%} %></td>
							<td><%=menu.get(j).getIntView("createtime") %></td>
							<td><%=menu.get(j).getIntView("count") %></td>
							<td><%=menu.get(j).getIntView("yprice") %></td>
							<td><%=menu.get(j).getIntView("shoucang") %></td>
							<td>
								<a href="admin_product_publish.jsp?caiid=<%=menu.get(j).getIntView("productmenuid")%>&inpage=<%=intdhpage%>&inpaixu=<%=paixu%>&insearch=<%=insearch%>">管理</a>|
								<form action="admin_product.jsp" id="subform<%=j%>" method="POST" style="float:right;">
									<input type="hidden" value="<%=menu.get(j).getIntView("productmenuid") %>" name="dhid">
									<input type="hidden" value="删除" name="Action">
								</form>
								<a class="zhuce"  name="删除" onclick="test_post<%=j%>()">删除</a>
							</td>
						</tr>
					<script type="text/javascript">
					function test_post<%=j%>() {
					var testform=document.getElementById("subform<%=j%>");
					testform.action="admin_product.jsp?aa=<%=j%>";
					testform.submit();
					}
					</script>
					<%} %>

					</tbody>
				</table>
				<!-- 表格 end -->
				<!-- 分页start -->
				<%if((searchnr==null)||(searchnr=="")){ %>
								<div class="nav-page">
								<%if(pagetotal>4){ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=minus%>">&laquo;</a></li>
								    <%if(intdhpage<3) {%>
								    <li id="t1"><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=0">1</a></li>
								    <li id="t2"><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=1">2</a></li>
								    <li id="t3"><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=2">3</a></li>
								    <%}else if((intdhpage>=3)&&(intdhpage<(pagetotal-3))){ %>
								    <li id="t<%=intdhpage+1%>"><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=intdhpage%>"><%=intdhpage+1%></a></li>
								    <li id="t<%=intdhpage+2%>"><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=intdhpage+1%>"><%=intdhpage+2%></a></li>
								    <li id="t<%=intdhpage+3%>"><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=intdhpage+2%>"><%=intdhpage+3%></a></li>
								    <%}else{ %>
								    <li id="t<%=pagetotal-3%>"><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=pagetotal-4%>"><%=pagetotal-3%></a></li>
								    <li id="t<%=pagetotal-2%>"><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=pagetotal-3%>"><%=pagetotal-2%></a></li>
								    <li id="t<%=pagetotal-1%>"><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=pagetotal-2%>"><%=pagetotal-1%></a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li id="t<%=pagetotal%>"><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=pagetotal-1%>"><%=pagetotal%></a></li>
								    <li id="t<%=pagetotal+1%>"><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=pagetotal%>"><%=pagetotal+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%}else{ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=minus%>">&laquo;</a></li>
								    <%for(int i=0;i<=pagetotal;i++){ %>
								    <li id="t<%=i+1%>"><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=i%>"><%=i+1%></a></li>
								    <%} %>
								    <li><a href="${pageContext.request.contextPath}/admin_product.jsp?paixu=<%=param.get("paixu") %>&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%} %>
								</div>
<script type="text/javascript">
<%for(int j=0;j<=pagetotal;j++){ %>
	if(<%=intdhpage%>==<%=j%>){
		$("#t<%=j+1%>").addClass("on"); 
	}
	<%} %>
</script>
<%} %>
				<!-- 分页end -->
  </div>
</div>
</body>
</html>