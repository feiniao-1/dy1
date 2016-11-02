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
<title>新闻编辑</title>
<link href="img/dy-icon.png" rel="SHORTCUT ICON">
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
String fullName1 = "";
String fullName2 = "";
String fullName3 = "";
String fullName4 = "";
String shuzi = "";
try{
jishu = request.getParameter("jishu");
fileName = request.getParameter("fileName");
fullName1 = request.getParameter("fullName1");
fullName2 = request.getParameter("fullName2");
fullName3 = request.getParameter("fullName3");
fullName4 = request.getParameter("fullName4");
shuzi = request.getParameter("shuzi");
}catch(Exception e){
	
}
if(fileName==null){
	session.removeAttribute("newsfullName1");
	session.removeAttribute("newsfullName2");
	session.removeAttribute("newsfullName3");
	session.removeAttribute("newsfullName4");
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
String titlejs;
String content1;
String content2;
String tag1;
String tag2;
String tag3;
String tag4;
String img1;
String ydimg1;
String img2;
String ydimg2;
String leixing;
String origin;
System.out.println("url_canshu:"+url_canshu+";canshu_url:"+canshu_url+";提交前img:"+(String)session.getAttribute("fullName1"));
if(url_canshu!=canshu_url){
if(param.get("Action")!=null && param.get("Action").equals("发表文章")){
	title=new String(request.getParameter("title").getBytes("iso-8859-1"),"utf-8");
	titlejs=new String(request.getParameter("titlejs").getBytes("iso-8859-1"),"utf-8");
	content1=param.get("content1");
	content2=param.get("content2");
	tag1=new String(request.getParameter("tag1").getBytes("iso-8859-1"),"utf-8");
	tag2=new String(request.getParameter("tag2").getBytes("iso-8859-1"),"utf-8");
	tag3=new String(request.getParameter("tag3").getBytes("iso-8859-1"),"utf-8");
	tag4=new String(request.getParameter("tag4").getBytes("iso-8859-1"),"utf-8");
	leixing=new String(request.getParameter("leixing").getBytes("iso-8859-1"),"utf-8");
	origin=new String(request.getParameter("origin").getBytes("iso-8859-1"),"utf-8");
	img1="upload/"+(String)session.getAttribute("newsfullName1");
	ydimg1="upload/"+(String)session.getAttribute("newsfullName2");
	img2="upload/"+(String)session.getAttribute("newsfullName3");
	ydimg2="upload/"+(String)session.getAttribute("newsfullName4");
	System.out.println("img1"+img1);
	if((title.equals("")||title.equals(null))||(content1.equals("")||content1.equals(null))||(content2.equals("")||content2.equals(null))){
		%>
			<script type="text/javascript" language="javascript">
					alert("主体信息不能为空");                                            // 弹出错误信息
			</script>
		<%
	}else{
		DB.getRunner().update("insert into article(author,title,titlejs,content1,content2,createtime,tag1,tag2,tag3,tag4,canshu_url,img1,img2,ydimg1,ydimg2,tagid,del,articletype,origin) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dluserid,title,titlejs,content1,content2,df.format(new Date()),tag1,tag2,tag3,tag4,url_canshu,img1,img2,ydimg1,ydimg2,tagid,"0",leixing,origin);
		DB.getRunner().update("insert into news(author,title,titlejs,content,createtime,newstype,img1,tagid,del,type,origin) values(?,?,?,?,?,?,?,?,?,?,?)",dluserid,title,titlejs,content1,df.format(new Date()),"boke",img1,tagid,"0",leixing,origin);
		session.removeAttribute("newsfullName1");
		session.removeAttribute("newsfullName2");
		session.removeAttribute("newsfullName3");
		session.removeAttribute("newsfullName4");
		%>
		<script type="text/javascript" language="javascript">
				alert("发表成功");                                            // 弹出错误信息
				window.location='admin_news_edit.jsp' ;                            // 跳转到登录界面
		</script>
	<%
	}
}else{
}
}

%> 
</head>
<body>
<div class="container mainbox">
    <div class="row">
        <h3 class="title">填写新闻信息</h3>
		<div class="botton-group">
        <a href="front_index.jsp" class="btn btn-primary">首页</a>
        <a href="admin_news_list.jsp" class="btn btn-warning">发表新闻</a>
        <a href="admin_product.jsp" class="btn btn-primary">发表菜品</a>
        <a href="admin_mail_list.jsp" class="btn btn-primary">邮件列表</a>
        <a href="photo.jsp" class="btn btn-primary" target="_blank">图片上传</a>
        </div>
        <div class="botton-group">
        <a href="admin_news_list.jsp" class="btn btn-danger">返回</a>
         </div>
        <p style="color:red; margin-bottom:30px;"> 说明：请先上传图片，后填写主体信息。</p>
       
     <!-- 图片上传start  -->
     <div class="form-group">
     <h5>PC新闻封面图片<span style="color:red;">*(240*180)</span></h5> 
 	 <form action="${pageContext.request.contextPath }/uploadServlet?url=news&shuzi=1" method="post" enctype="multipart/form-data">
 	 <div class="mb10">
						<input type="file" name="attr_file1" style="display:inline-block; width:220px;">
						<input type="submit" value="上传">  
						<%if(shuzi!=null&&shuzi.equals("1")){
							if(fullName1==null){
								//session.removeAttribute("fullName2");
							}else{
								if(fileName=="") {%>
									<script type="text/javascript" language="javascript">
									document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
								</script>
								<%}else{ %>
								<%
								session.setAttribute("newsfullName1", fullName1);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("newsfullName1")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
									</script>
							<%}else{ %>
							<%} %>
						
						</div>
  	 </form>
  	<div class="mb15"><img alt="" src="upload/<%=(String)session.getAttribute("newsfullName1") %>" style="width:50px!important;" height="50px"></div>
  	</div>
  	<div class="form-group">
        		<h5>PC新闻详细图片<span style="color:red;">*(798*532)</span></h5> 
					<form action="${pageContext.request.contextPath }/uploadServlet?url=news&shuzi=3" method="post" enctype="multipart/form-data">
						<div class="mb10">
						<input type="file" name="attr_file3" style="display:inline-block; width:220px;">
						<input type="submit" value="上传">  
						<%if(shuzi!=null&&shuzi.equals("3")){
							if(fullName3==null){
								//session.removeAttribute("fullName2");
							}else{
								if(fileName=="") {%>
									<script type="text/javascript" language="javascript">
									document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
								</script>
								<%}else{ %>
								<%
								session.setAttribute("newsfullName3", fullName3);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("newsfullName3")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %>
						
						</div>
				  	 </form>
				  	 <img alt="" src="upload/<%=(String)session.getAttribute("newsfullName3") %>" style="width:220px!important;" height="150px">
				</div>
				<div class="form-group">
        		<h5>移动端新闻封面图片<span style="color:red;">*</span></h5> 
					<form action="${pageContext.request.contextPath }/uploadServlet?url=news&shuzi=2" method="post" enctype="multipart/form-data">
						<div class="mb10">
						<input type="file" name="attr_file2" style="display:inline-block; width:220px;">
						<input type="submit" value="上传">  	
						<%if(shuzi!=null&&shuzi.equals("2")){
							if(fullName2==null){
								//session.removeAttribute("fullName2");
							}else{
								if(fileName=="") {%>
									<script type="text/javascript" language="javascript">
									document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
								</script>
								<%}else{ %>
								<%
								session.setAttribute("newsfullName2", fullName2);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("newsfullName2")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %>
						
						</div>
				  	 </form>
				  	 <img alt="" src="upload/<%=(String)session.getAttribute("newsfullName2") %>" style="width:120px!important;" height="80px">
				</div>
				<div class="form-group">
        		<h5>移动端新闻详情图片<span style="color:red;">*</span></h5> 
					<form action="${pageContext.request.contextPath }/uploadServlet?url=news&shuzi=4" method="post" enctype="multipart/form-data">
						<div class="mb10">
						<input type="file" name="attr_file4" style="display:inline-block; width:220px;">
						<input type="submit" value="上传">  	
						<%if(shuzi!=null&&shuzi.equals("4")){
							if(fullName4==null){
								//session.removeAttribute("fullName2");
							}else{
								if(fileName=="") {%>
									<script type="text/javascript" language="javascript">
									document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
								</script>
								<%}else{ %>
								<%
								session.setAttribute("newsfullName4", fullName4);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("newsfullName4")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %>
						
						</div>
				  	 </form>
				  	 <img alt="" src="upload/<%=(String)session.getAttribute("newsfullName4") %>" style="width:120px!important;" height="80px">
				</div>
	<!-- 图片上传end -->
	<form id="form_tj" action="admin_news_edit.jsp?jishu=<%=val%>&fileName=tijiao" method="post" >
		<p class="mb10">标题<span style="color:red;">*(最多20字)</span>：</p>
		<p class="mb15"><input type="text" Name="title"  placeholder="标题"></p>
		<p class="mb10">标题简述<span style="color:red;">*(最多5个字)</span>：</p>
		<p class="mb15"><input type="text" Name="titlejs"  placeholder="标题简述"></p>
		<p>文章类别*</p> 
		<div class="mb15">
							<select name="leixing" style="width:60px;">
								<option>热门</option>
								<option>美食</option>
								<option>体育</option>		
								<option>娱乐</option>
								<option>科技</option>
							</select>
		</div>				
		<p>描述<span style="color:red;">*(建议3-4行；最多200字)</span>：</p>
		<div  class="mb10">
		<script type="text/plain" id="myEditor" name="content1"></script>
		</div>
		<p  class="mb10">内容*：</p>
		<div  class="mb15">
		<script type="text/plain" id="myEditor1" name="content2"></script>
		</div>
		<p class="mb10">新闻出处(不填默认是饺耳世家)：</p>
		<p class="mb15"><input type="text" Name="origin"  placeholder="新闻出处"></p>	
		<p  class="mb10">词条标签（选填）：</p>
		<div class="mb15">
		<input type="text" Name="tag1"  placeholder="标签1" style="width:80px;">
		<input type="text" Name="tag2"  placeholder="标签2" style="width:80px;">
		<input type="text" Name="tag3"  placeholder="标签3" style="width:80px;">
		<input type="text" Name="tag4"  placeholder="标签4" style="width:80px;">
		</div>
		<input type="submit" Name="Action" value="发表文章" >
	</form>
  </div>
</div>
    <script type="text/javascript">
        var editor_a = UE.getEditor('myEditor',{initialFrameHeight:150});
        var editor_a = UE.getEditor('myEditor1',{initialFrameHeight:250});
    </script>
</body>
</html>