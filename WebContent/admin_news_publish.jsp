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
<title>新闻管理编辑</title>
<link href="img/toubiao.png" rel="SHORTCUT ICON">
<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/backstage.css"/>
    <!-- 配置文件 -->
    <script type="text/javascript" src="ueditor/ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<%
//获取当前url
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String jishu = "";
String fileName = "";
String upimg1 = "";
String upimg2 = "";
String upydimg1 = "";
String upydimg2 = "";
String caiid = "";
String shuzi = "";
try{
jishu = request.getParameter("jishu");
fileName = request.getParameter("fileName");
upimg1 = request.getParameter("upimg1");
upimg2 = request.getParameter("upimg2");
upydimg1 = request.getParameter("upimg3");
upydimg2 = request.getParameter("upimg4");
caiid = request.getParameter("caiid");
shuzi = request.getParameter("shuzi");

System.out.println("caiid"+request.getParameter("caiid"));
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
if(fileName==null){
	session.removeAttribute("upimg1");
	session.removeAttribute("upimg2");
	session.removeAttribute("upydimg1");
	session.removeAttribute("upydimg2");
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
String searchnr;
if(request.getParameter("insearch")==null){
	searchnr=null;
}else{
	searchnr=new String(request.getParameter("insearch").getBytes("iso-8859-1"),"utf-8");
}

//当前登录用户
//int dluserid=useridc.get(0).getInt("userid");
int dluserid=10196;	
HashMap<String,String> param= G.getParamMap(request); 
//博客列表信息
//CREATE TABLE `article` (
//  `articleid` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
//  `author` int(11) DEFAULT NULL COMMENT '作者',
//  `title` varchar(255) DEFAULT NULL COMMENT '文章标题',
//  `content1` text COMMENT '文章内容',
//  `content2` text,
//  `img1` varchar(255) DEFAULT NULL COMMENT '图片1',
//  `img2` varchar(255) DEFAULT NULL COMMENT '图片2',
//  `img3` varchar(255) DEFAULT NULL COMMENT '图片3',
//  `articletype` int(11) DEFAULT NULL COMMENT '所属文章类型',
//  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
//  `updatetime` datetime DEFAULT NULL COMMENT '最新修改时间',
//  `is_discuss` tinyint(1) DEFAULT NULL COMMENT '是否被评论',
//  `del` int(11) DEFAULT NULL,
//  `zcount` int(11) DEFAULT NULL,
//  `tag1` varchar(255) DEFAULT NULL,
//  `tag2` varchar(255) DEFAULT NULL,
//  `tag3` varchar(255) DEFAULT NULL,
//  `tag4` varchar(255) DEFAULT NULL,
//  `canshu_url` int(11) DEFAULT NULL,
//  `tagid` int(22) DEFAULT NULL,
//  `visitor` varchar(255) DEFAULT NULL,
//  PRIMARY KEY (`articleid`)
//) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
//新闻列表信息
List<Mapx<String,Object>> menu=DB.getRunner().query("select articleid,articletype,author,title,titlejs,content1,content2,img1,img2,ydimg1,ydimg2,articletype,substring(createtime,1,19) as createtime,substring(updatetime,1,19) as updatetime,zcount,tag1,tag2,tag3,tag4,tagid,origin  from article where del=? and articleid=?", new MapxListHandler(),"0",caiid);
System.out.println(menu);
//显示该博客的随机数信息
List<Mapx<String,Object>> showdiscuss1 = DB.getRunner().query("select canshu_url as canshu_url from article where  articleid=? ",new MapxListHandler(),caiid);
int canshu_url=showdiscuss1.get(0).getInt("canshu_url");
//编辑保存博客信息
String title;
String titlejs;
String content1;
String content2;
String tag1;
String tag2;
String tag3;
String tag4;
String img1;
String img2;
String ydimg1;
String ydimg2;
String leixing;
String origin;
if(url_canshu!=canshu_url){
if(param.get("Action")!=null && param.get("Action").equals("确定")){
	title=param.get("title");
	titlejs=param.get("titlejs");
	content1=param.get("content1");
	content2=param.get("content2");
	origin=new String(request.getParameter("origin").getBytes("iso-8859-1"),"utf-8");
	tag1=param.get("tag1");
	tag2=param.get("tag2");
	tag3=param.get("tag3");
	tag4=param.get("tag4");
	leixing=new String(request.getParameter("leixing").getBytes("iso-8859-1"),"utf-8");
	if((String)session.getAttribute("upimg1")==null){
		img1=menu.get(0).getStringView("img1");
	}else{
		img1="upload/"+(String)session.getAttribute("upimg1");
	}
	if((String)session.getAttribute("upimg2")==null){
		img2=menu.get(0).getStringView("img2");
	}else{
		img2="upload/"+(String)session.getAttribute("upimg2");
	}
	if((String)session.getAttribute("upydimg1")==null){
		ydimg1=menu.get(0).getStringView("ydimg1");
	}else{
		ydimg1="upload/"+(String)session.getAttribute("upydimg1");
	}
	if((String)session.getAttribute("upydimg2")==null){
		ydimg2=menu.get(0).getStringView("ydimg2");
	}else{
		ydimg2="upload/"+(String)session.getAttribute("upydimg2");
	}
		DB.getRunner().update("update article set title=?,titlejs=?,content1=?,content2=?,tag1=?,tag2=?,tag3=?,tag4=?,updatetime=?,canshu_url=?,img1=?,img2=?,ydimg1=?,ydimg2=? ,articletype=?,origin=? where articleid=?",title,titlejs,content1,content2,tag1,tag2,tag3,tag4,df.format(new Date()),url_canshu,img1,img2,ydimg1,ydimg2,leixing,origin,caiid);
		DB.getRunner().update("update news set title=?,titlejs=?,content=?,newstype=?,img1=?,ydimg1=?,updatetime=?,type=?,origin=? where tagid=?",title,titlejs,content1,"boke",img1,ydimg1,df.format(new Date()),leixing,origin,menu.get(0).getIntView("tagid"));
		session.removeAttribute("upimg1");
		session.removeAttribute("upimg2");
		session.removeAttribute("upydimg1");
		session.removeAttribute("upydimg2");
		%>
		<script type="text/javascript" language="javascript">
				alert("修改成功");                                            // 弹出提示信息
				window.location='admin_news_list.jsp' ;                           
		</script>
	<%
}else{
}
}
%> 
</head>
<body>
<div class="container mainbox">
    <div class="row">
       <h3 class="title">新闻详细信息</h3>
        <div class="botton-group">
        <a href="front_index.jsp" class="btn btn-primary">首页</a>
        <a href="admin_news_list.jsp" class="btn btn-warning">发表新闻</a>
        <a href="admin_product.jsp" class="btn btn-primary">发表菜品</a>
        <a href="admin_mail_list.jsp" class="btn btn-primary">邮件列表</a>
       </div>
        <div class="botton-group">
        <a href="admin_news_list.jsp?page=<%=request.getParameter("inpage") %>&paixu=<%=request.getParameter("inpaixu") %>&searchnr=<%= searchnr%>" class="btn btn-danger">返回</a><span style="color:red;">操作说明：如需改动图片；先上传图片，再修改内容</span>
        </div>
        		<!-- 表格 start -->
        		<div class="form-group">
        		<h5 class="mb10">PC封面图<span style="color:red;">*(240*180)</span></h5> 
					<form action="${pageContext.request.contextPath }/uploadServlet?url=newspublish&caiid=<%= caiid%>&shuzi=1" method="post" enctype="multipart/form-data">
						<div class="mb10">
						<input type="file" name="attr_file1" style="display:inline-block; width:220px;">
						<input type="submit" value="上传"> 
						<%if(shuzi!=null&&shuzi.equals("1")){
							if(upimg1==null){
								//session.removeAttribute("fullName2");
							}else{
								if(fileName=="") {%>
									<script type="text/javascript" language="javascript">
									document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
								</script>
								<%}else{ %>
								<%
								session.setAttribute("upimg1", upimg1);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("upimg1")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %> 	
							</div>
				  	 </form>
						 <%if((String)session.getAttribute("upimg1")!=null){ %>
							 	<img alt="" src="upload/<%=(String)session.getAttribute("upimg1") %>" style="width:200px!important;" height="150px">
							 <%}else{ %>
							 	<img alt="" src="<%=menu.get(0).getStringView("img1") %>" style="width:200px!important;" height="150px">
							 <%} %>
						<h5 class="mb10">PC详情图片<span style="color:red;">*(798*532)</span></h5> 
						<form action="${pageContext.request.contextPath }/uploadServlet?url=newspublish&caiid=<%= caiid%>&shuzi=2" method="post" enctype="multipart/form-data">
						<div class="mb10">
						<input type="file" name="attr_file1" style="display:inline-block; width:220px;">						
						<input type="submit" value="上传">  	
						<%if(shuzi!=null&&shuzi.equals("2")){
							if(upimg2==null){
								//session.removeAttribute("fullName2");
							}else{
								if(fileName=="") {%>
									<script type="text/javascript" language="javascript">
									document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
								</script>
								<%}else{ %>
								<%
								session.setAttribute("upimg2", upimg2);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("upimg2")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %>
						</div>
				  	 </form>
						 <%if((String)session.getAttribute("upimg2")!=null){ %>
							 	<img alt="" src="upload/<%=(String)session.getAttribute("upimg2") %>" style="width:220px!important;" height="150px">
							 <%}else{ %>
							 	<img alt="" src="<%=menu.get(0).getStringView("img2") %>" style="width:220px!important;" height="150px">
							 <%} %>
					<h5 class="mb10">移动端封面图<span style="color:red;">*</span></h5> 
					<form action="${pageContext.request.contextPath }/uploadServlet?url=newspublish&caiid=<%= caiid%>&shuzi=3" method="post" enctype="multipart/form-data">
						<div class="mb10">
						<input type="file" name="attr_file1" style="display:inline-block; width:220px;">
						<input type="submit" value="上传">  
						<%if(shuzi!=null&&shuzi.equals("3")){
							if(upydimg1==null){
								//session.removeAttribute("fullName2");
							}else{
								if(fileName=="") {%>
									<script type="text/javascript" language="javascript">
									document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
								</script>
								<%}else{ %>
								<%
								session.setAttribute("upydimg1", upydimg1);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("upydimg1")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %>
						</div>
				  	 </form>
						 <%if((String)session.getAttribute("upydimg1")!=null){ %>
							 	<img alt="" src="upload/<%=(String)session.getAttribute("upydimg1") %>" style="width:120px!important;" height="90px">
							 <%}else{ %>
							 	<img alt="" src="<%=menu.get(0).getStringView("ydimg1") %>" style="width:120px!important;" height="90px">
							 <%} %>
					<h5 class="mb10">移动端详情图片<span style="color:red;">*</span></h5> 
					<form action="${pageContext.request.contextPath }/uploadServlet?url=newspublish&caiid=<%= caiid%>&shuzi=4" method="post" enctype="multipart/form-data">
						<div class="mb10">
						<input type="file" name="attr_file1" style="display:inline-block; width:220px;">
						<input type="submit" value="上传" style="display:inline-block;">  
						<%if(shuzi!=null&&shuzi.equals("4")){
							if(upydimg2==null){
								//session.removeAttribute("fullName2");
							}else{
								if(fileName=="") {%>
									<script type="text/javascript" language="javascript">
									document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
								</script>
								<%}else{ %>
								<%
								session.setAttribute("upydimg2", upydimg2);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("upydimg2")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %>
						</div>
				  	 </form>
						 <%if((String)session.getAttribute("upydimg2")!=null){ %>
							 	<img alt="" src="upload/<%=(String)session.getAttribute("upydimg2") %>" style="width:220px!important;" height="150px">
							 <%}else{ %>
							 	<img alt="" src="<%=menu.get(0).getStringView("ydimg2") %>" style="width:220px!important;" height="150px">
							 <%} %>
				</div>
				<form role="form" action="admin_news_publish.jsp?jishu=<%=val%>&caiid=<%=caiid %>&fileName=tijiao" method="POST" name="form1"
					novalidate>
					<div class="form-group">
						<label>ID</label> <input type="text" class="form-control" style="width:200px;"
							readOnly="true" value="<%= menu.get(0).getIntView("articleid") %>" name="id">
						<p class="help-block">ID由系统自动生成</p>
					</div>
					<div class="form-group">
						<label>作者</label> <input type="text" class="form-control" style="width:200px;"
							name="author" readOnly="true"
							value="<%= menu.get(0).getStringView("author") %>">
					</div>
					<h5 class="mb10">文章类别<span style="color:red;">*</span></h5> 
					<select name="leixing" style="width:80px; margin-bottom:10px;">
								<option><%=menu.get(0).getStringView("articletype") %></option>
								<option>热门</option>
								<option>美食</option>
								<option>体育</option>		
								<option>娱乐</option>
								<option>科技</option>
							</select>
					<div class="form-group">
						<label>文章标题</label> <input type="text" class="form-control" style="width:360px;"
							name="title"
							value="<%= menu.get(0).getStringView("title") %>">
					</div>
					<div class="form-group">
						<label>标题简述(最多5个字)</label> <input type="text" class="form-control" style="width:100px;"
							name="titlejs"
							value="<%= menu.get(0).getStringView("titlejs") %>">
					</div>
					<div class="form-group">
						<label>文章简介</label>
							<script type="text/plain" id="myEditor" name="content1"><%=menu.get(0).getStringView("content1") %></script>
					</div>
					<div class="form-group">
						<label>文章内容</label>
							<script type="text/plain" id="myEditor1" name="content2"><%=menu.get(0).getStringView("content2") %></script>
					</div>
					<div class="form-group">
						<label>创建时间</label> <input type="text" class="form-control" style="width:200px;"
							name="createtime" readOnly="true"
							value="<%=menu.get(0).getIntView("createtime") %>">
					</div>
					<div class="form-group">
						<label>最近修改时间</label> <input type="text" class="form-control" style="width:200px;"
							name="updatetime" readOnly="true"
							value="<%=menu.get(0).getIntView("updatetime") %>">
					</div>
					<div class="form-group">
						<label>浏览量</label> <input type="text" class="form-control" style="width:200px;"
							name="zcount" readOnly="true"
							value="<%=menu.get(0).getIntView("zcount") %>">
					</div>
					<p class="mb10">新闻出处(不填默认是饺耳世家)：</p>
					<p class="mb15"><input type="text" Name="origin"  value="<%= menu.get(0).getStringView("origin") %>"></p>	
					<p class="mb10">词条标签：</p>
					<div class="form-group">
						<input type="text" Name="tag1"  value="<%=menu.get(0).getStringView("tag1") %>" style="width:80px;">
						<input type="text" Name="tag2"  value="<%=menu.get(0).getStringView("tag2") %>" style="width:80px;">
						<input type="text" Name="tag3"  value="<%=menu.get(0).getStringView("tag3") %>" style="width:80px;">
						<input type="text" Name="tag4"  value="<%=menu.get(0).getStringView("tag4") %>" style="width:80px;">
					</div>
					<input type=submit class="btn btn-danger" name="Action" value="确定">
				</form>
				<!-- 表格 end -->
			
  </div>
</div>
    <script type="text/javascript">
        var editor_a = UE.getEditor('myEditor',{initialFrameHeight:150});
        var editor_a = UE.getEditor('myEditor1',{initialFrameHeight:150});
    </script>
</body>
</html>