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
String fullName = "";
try{
jishu = request.getParameter("jishu");
fileName = request.getParameter("fileName");
fullName = request.getParameter("fullName");
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
//显示博客信息
List<Mapx<String,Object>> showdiscuss1 = DB.getRunner().query("select canshu_url as canshu_url from article where  author=? order by articleid desc limit 1",new MapxListHandler(),dluserid);
System.out.println();
int canshu_url=showdiscuss1.get(0).getInt("canshu_url");
//编辑保存博客信息
System.out.println(request.getMethod());//获取request方法 POST or GET
HashMap<String,String> param= G.getParamMap(request);
String title;
String content1;
String content2;
String tag1;
String tag2;
String tag3;
String tag4;
String img1;
String leixing;
System.out.println("url_canshu:"+url_canshu+";canshu_url:"+canshu_url+";提交前img:"+(String)session.getAttribute("fullName1"));
if(url_canshu!=canshu_url){
if(param.get("Action")!=null && param.get("Action").equals("发表文章")){
	title=new String(request.getParameter("title").getBytes("iso-8859-1"),"utf-8");
	content1=new String(request.getParameter("content1").getBytes("iso-8859-1"),"utf-8");
	content2=new String(request.getParameter("content2").getBytes("iso-8859-1"),"utf-8");
	tag1=new String(request.getParameter("tag1").getBytes("iso-8859-1"),"utf-8");
	tag2=new String(request.getParameter("tag2").getBytes("iso-8859-1"),"utf-8");
	tag3=new String(request.getParameter("tag3").getBytes("iso-8859-1"),"utf-8");
	tag4=new String(request.getParameter("tag4").getBytes("iso-8859-1"),"utf-8");
	leixing=new String(request.getParameter("leixing").getBytes("iso-8859-1"),"utf-8");
	img1="upload/"+(String)session.getAttribute("fullName1boke");
	System.out.println("img1"+img1);
	if((title.equals("")||title.equals(null))||(content1.equals("")||content1.equals(null))||(content2.equals("")||content2.equals(null))){
		%>
			<script type="text/javascript" language="javascript">
					alert("主体信息不能为空");                                            // 弹出错误信息
			</script>
		<%
	}else{
		DB.getRunner().update("insert into article(author,title,content1,content2,createtime,tag1,tag2,tag3,tag4,canshu_url,img1,tagid,del,articletype) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dluserid,title,content1,content2,df.format(new Date()),tag1,tag2,tag3,tag4,url_canshu,img1,tagid,"0",leixing);
		DB.getRunner().update("insert into news(author,title,content,createtime,newstype,img1,tagid,type) values(?,?,?,?,?,?,?,?)",dluserid,title,content1,df.format(new Date()),"boke",img1,tagid,leixing);
		session.removeAttribute("fullName1boke");
		%>
		<script type="text/javascript" language="javascript">
				alert("发表成功");                                            // 弹出错误信息
				window.location='admin_boke_edit.jsp' ;                            // 跳转到登录界面
		</script>
	<%
	}
}else{
}
}

%> 
</head>
<body>
<div class="panel panel-default container box-shadow"  style="text-align:center; padding-top:50px; margin-top:50px;">
    <div class="row">
<h3>上传图片</h3><br>

        <span style="margin-left:500px;">
        
      <label>只上传图片 成功后显示图片路径，可直接使用</label>
        <br/>
     <!-- 图片上传start  -->
 	 <br/>
 	 <form action="${pageContext.request.contextPath }/uploadServlet?url=photo" method="post" enctype="multipart/form-data">
 	 <div style="margin-left:-100px;">图片格式：<span style="color:red;">79*60</span>
		<input type="file" name="attr_file" style="display:inline-block;"></div>
		<div style="margin-top:-25px;margin-left:200px;">
		<%if(fullName==null){
			session.removeAttribute("fullName1boke");
		}else{
			if(fileName=="") {%>
				<script type="text/javascript" language="javascript">
				document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
			</script>
			<%}else{ %>
						<script type="text/javascript" language="javascript">
				document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
				
			</script>
			<%
			session.setAttribute("fullName1boke", fullName);
			} %>
		<%}%>
		<input type="submit" value="上传"></div>
  	 </form>
  	 <%if((fileName=="")||(fileName==null)){ }else{ %>
  	<center><img alt="" src="upload/<%=(String)session.getAttribute("fullName1boke") %>" style="width:50px!important;" height="50px"><br></center> 
  	<center>图片路径：upload/<%=(String)session.getAttribute("fullName1boke") %><br></center> <%} %>
	、
</body>
</html>