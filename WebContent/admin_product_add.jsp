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
<title>添加菜品</title>
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
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式  
System.out.println(df.format(new Date()));// new Date()为获取当前系统时间 
if(fileName==null){
	session.removeAttribute("fullName1");
	session.removeAttribute("fullName2");
	session.removeAttribute("fullName3");
	session.removeAttribute("fullName4");
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
//菜品列表信息
List<Mapx<String,Object>> menu=DB.getRunner().query("select productmenuid,productname,productEname,productlei,content1,img1,img2,ydimg1,ydimg2,substring(createtime,1,19) as createtime,count,yprice,shoucang from productmenu where del=? and productmenuid=?", new MapxListHandler(),"0","1");
//显示该菜品的随机数信息
List<Mapx<String,Object>> showdiscuss1 = DB.getRunner().query("select canshu_url as canshu_url from productmenu where  author=? order by productmenuid desc limit 1",new MapxListHandler(),10196);
System.out.println();
int canshu_url=showdiscuss1.get(0).getInt("canshu_url");
//编辑保存菜品信息
String productlei;
String productname;
String productEname;
String yprice;
String content1;
String content2;
String createtime;
String count;
String shoucang;
String img1;
String ydimg1;
String img2;
String ydimg2;
System.out.println("url_canshu:"+url_canshu+";canshu_url:"+canshu_url+";提交前img:"+(String)session.getAttribute("fullName1"));
System.out.println("提交前img:fullName1="+(String)session.getAttribute("fullName1")+";;fullName2="+(String)session.getAttribute("fullName2"));
if(url_canshu!=canshu_url){
if(param.get("Action")!=null && param.get("Action").equals("确定")){
	productlei=new String(request.getParameter("productlei").getBytes("iso-8859-1"),"utf-8");
	productname=new String(request.getParameter("productname").getBytes("iso-8859-1"),"utf-8");
	productEname=new String(request.getParameter("productEname").getBytes("iso-8859-1"),"utf-8");
	yprice=new String(request.getParameter("yprice").getBytes("iso-8859-1"),"utf-8");
	content1=new String(request.getParameter("content1").getBytes("iso-8859-1"),"utf-8");
	content2=param.get("content2");
	createtime=df.format(new Date());
	count=new String("1");
	shoucang=new String("1");
	img1="upload/"+(String)session.getAttribute("fullName1");
	ydimg1="upload/"+(String)session.getAttribute("fullName2");
	img2="upload/"+(String)session.getAttribute("fullName3");
	ydimg2="upload/"+(String)session.getAttribute("fullName4");
	if((productlei.equals("")||productlei.equals(null))||(productname.equals("")||productname.equals(null))||(yprice.equals("")||yprice.equals(null))||(content1.equals("")||content1.equals(null))){
		%>
			<script type="text/javascript" language="javascript">
					alert("标*处的主要信息不能为空");                                            // 弹出错误信息
					window.location='admin_product_add.jsp' ;                            
			</script>
		<%
	}else{
		DB.getRunner().update("insert into productmenu(author,productlei,productname,productEname,content1,content2,img1,img2,ydimg1,ydimg2,createtime,del,count,canshu_url,yprice,shoucang) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",10196,productlei,productname,productEname,content1,content2,img1,img2,ydimg1,ydimg2,df.format(new Date()),"0",count,url_canshu,yprice,shoucang);
		session.removeAttribute("fullName1");
		session.removeAttribute("fullName2");
		session.removeAttribute("fullName3");
		session.removeAttribute("fullName4");
		%>
		<script type="text/javascript" language="javascript">
				alert("发表成功");                                            // 弹出提示信息
				window.location='admin_product.jsp' ;                           
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
        <h3  class="title">菜品添加</h3>
        <div class="botton-group">
         <a href="front_index.jsp" class="btn btn-primary">首页</a>
         <a href="admin_news_list.jsp" class="btn btn-primary">发表新闻</a>
         <a href="admin_product.jsp" class="btn btn-warning">发表菜品</a>
         <a href="admin_mail_list.jsp" class="btn btn-primary">邮件列表</a>
         </div>
         <div class="botton-group">
	        <a href="admin_product.jsp" class="btn btn-danger">返回</a><span style="color:red;">操作说明：先上传图片，再填写内容</span>
	     </div>
        		<!-- 表格 start -->
        		<div class="form-group">
        		<h5>PC商品封面图片<span style="color:red;">*(370*247)</span></h5> 
					<form action="${pageContext.request.contextPath }/uploadServlet?url=product&shuzi=1" method="post" enctype="multipart/form-data">
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
								session.setAttribute("fullName1", fullName1);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("fullName1")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %>
						
						</div>
				  	 </form>
				  	 <img alt="" src="upload/<%=(String)session.getAttribute("fullName1") %>" style="width:220px!important;" height="150px">
				</div>
				<div class="form-group">
        		<h5>PC商品详细图片<span style="color:red;">*(798*532)</span></h5> 
					<form action="${pageContext.request.contextPath }/uploadServlet?url=product&shuzi=3" method="post" enctype="multipart/form-data">
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
								session.setAttribute("fullName3", fullName3);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("fullName3")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %>
						
						</div>
				  	 </form>
				  	 <img alt="" src="upload/<%=(String)session.getAttribute("fullName3") %>" style="width:220px!important;" height="150px">
				</div>
				<div class="form-group">
        		<h5>移动端商品封面图片<span style="color:red;">*</span></h5> 
					<form action="${pageContext.request.contextPath }/uploadServlet?url=product&shuzi=2" method="post" enctype="multipart/form-data">
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
								session.setAttribute("fullName2", fullName2);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("fullName2")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %>
						
						</div>
				  	 </form>
				  	 <img alt="" src="upload/<%=(String)session.getAttribute("fullName2") %>" style="width:120px!important;" height="80px">
				</div>
				<div class="form-group">
        		<h5>移动端商品详情图片<span style="color:red;">*</span></h5> 
					<form action="${pageContext.request.contextPath }/uploadServlet?url=product&shuzi=4" method="post" enctype="multipart/form-data">
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
								session.setAttribute("fullName4", fullName4);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("fullName4")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %>
						
						</div>
				  	 </form>
				  	 <img alt="" src="upload/<%=(String)session.getAttribute("fullName4") %>" style="width:120px!important;" height="80px">
				</div>
				<form role="form" action="admin_product_add.jsp?jishu=<%=val%>&fileName=you" method="POST" name="form1"	novalidate>

					<div class="form-group">
						<h5>菜品类别<span style="color:red;">*</span></h5> 
							<select name="productlei">
								<option>特色水饺</option>
								<option>开胃凉菜</option>
								<option>精美热菜</option>		
								<option>酒水饮料</option>
								<option>主食</option>
							</select>
					</div>
					<div class="form-group">
						<h5>菜品名称<span style="color:red;">*</span></h5> 
						<input type="text" class="form-control" style="width:220px;"
							name="productname"
							placeholder="菜名">
					</div>
					<div class="form-group">
						<h5>英文名称<span style="color:red;">*</span></h5> 
						<input type="text" class="form-control" style="width:220px;"
							name="productEname"
							placeholder="英文名">
					</div>
					<div class="form-group">
						<h5>价格<span style="color:red;">*</span></h5> <input type="text" class="form-control" style="width:220px;"
							name="yprice"
							placeholder="请填写菜品价格">
					</div>
					<div class="form-group">
						<h5>菜品简介<span style="color:red;">*(字数为1行或最多65字)</span></h5> 
							<script type="text/plain" id="myEditor" name="content1"></script>
					</div>
					<div class="form-group">
						<h5>菜品介绍<span style="color:red;">*</span></h5>
							<script type="text/plain" id="myEditor1" name="content2"></script>
					</div>
					<div class="form-group">
						<h5>创建时间</h5> <input type="text" class="form-control" style="width:200px;"
							name="createtime" readOnly="true"
							placeholder="<%=df.format(new Date()) %>">
					</div>
					<input type="submit" class="btn btn-danger" name="Action" value="确定">
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