<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="javax.swing.JOptionPane"%>
<%
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式  
System.out.println(df.format(new Date()));// new Date()为获取当前系统时间  
//验证用户登陆
Mapx<String,Object> user = G.getUser(request);
String pageType = null;
String userType = null;
//验证用户登陆
String username = (String)session.getAttribute("username");
System.out.println("当前登录用户"+username);
List<Mapx<String, Object>> useridc= DB.getRunner().query("SELECT userid FROM user where username=?", new MapxListHandler(),username);
int flag=0;
if(username==null){
	
}else{
	flag=1;
}
//文章信息
List<Mapx<String, Object>> article=DB.getRunner().query("select articleid,author,title,content1,content2,zcount,tag1,tag2,tag3,tag4,img1,subString(createtime,1,10) as createtime from article where tagid=?", new MapxListHandler(),request.getParameter("tagid"));
int zcount;
if(article.get(0).getIntView("zcount").equals("")){
	zcount=0;
}else{
	zcount=Integer.parseInt(article.get(0).getIntView("zcount"));
}
//更新访问量加1
DB.getRunner().update("update article set zcount=? where tagid=?",zcount+1,request.getParameter("tagid"));
DB.getRunner().update("update news set count=? where tagid=?",zcount+1,request.getParameter("tagid"));
//当前文章的下一条文章信息
List<Mapx<String, Object>> articlenext=DB.getRunner().query("select title,tagid from article where articleid<? order by articleid desc limit 1", new MapxListHandler(),article.get(0).getIntView("articleid"));
System.out.println(articlenext);
//获取文章作者
List<Mapx<String, Object>> authorxx= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),article.get(0).getStringView("author"));
//获取当前url
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String jishu = "";
try{
jishu = request.getParameter("jishu");
System.out.println("jishu"+jishu);
}catch(Exception e){
	
}
//设置随机数
int  val = (int)(Math.random()*10000)+1;
int url_canshu;
if(jishu==null){
	url_canshu=Integer.parseInt("1");
}else{	
	url_canshu=Integer.parseInt(jishu);
}
//获取页数信息
String discuss_page;
if(request.getParameter("page")==null){
	discuss_page=String.valueOf(0);
}else{
	discuss_page=request.getParameter("page");
}
int page_ye=Integer.parseInt(discuss_page)*5;
//显示评论信息
int canshu_url;
int useridh=10049;
List<Mapx<String,Object>> showdiscuss1 = DB.getRunner().query("select canshu_url as canshu_url from discuss where  articleid=? order by discussid desc limit 1",new MapxListHandler(),article.get(0).getStringView("articleid"));
System.out.println("showdiscuss1"+showdiscuss1.size());
if(showdiscuss1.size()==0){
	canshu_url=1;
}else{
	canshu_url=showdiscuss1.get(0).getInt("canshu_url");
}
//获取评论信息
System.out.println(request.getMethod());//获取request方法 POST or GET
HashMap<String,String> param= G.getParamMap(request);
String content;
	if(url_canshu!=canshu_url){
	if(param.get("Action")!=null && param.get("Action").equals("发表评论")){
		if(flag==1){
			content=new String(request.getParameter("content").getBytes("iso-8859-1"),"utf-8");
			if(content.equals("")||content.equals(null)){
			}else{
				DB.getRunner().update("insert into discuss(discusscontent,visitor,canshu_url,discusstime,userid,articleid) values(?,?,?,?,?,?)",content,useridc.get(0).getIntView("userid"),url_canshu,df.format(new Date()),10049,article.get(0).getStringView("articleid"));
				content=null;
			}
		}else{
			//JOptionPane.showMessageDialog(null, "请登录", "请登录", JOptionPane.ERROR_MESSAGE); 
			//response.sendRedirect("front_login.jsp");
			%>
			<script type="text/javascript" language="javascript">
					alert("请登录");                                            // 弹出错误信息
					window.location='yd_front_boke_inner.jsp?page=0&jishu=<%=val%>&tagid=<%=request.getParameter("tagid") %>' ;                            // 跳转到登录界面
			</script>
		<%
		}
	}else{
	}
	}

//显示评论信息
List<Mapx<String,Object>> showdiscuss = DB.getRunner().query("select discusscontent as sh_discuss,userid as sh_userid,visitor as sh_visitor,canshu_url as canshu_url ,substring(discusstime,1,19) as discusstime from discuss where  articleid=? order by discussid desc limit "+page_ye+",5",new MapxListHandler(),article.get(0).getStringView("articleid"));

/*统计 评论数及 页数*/
String sqlPreCount = "select count(1) as count from discuss where  (del is NULL or del <>1) and userid=? order BY discussid DESC ";
List<Mapx<String,Object>> sqlPreCount1 =  DB.getRunner().query(sqlPreCount, new MapxListHandler(),useridh);
//总商品数量
int total = sqlPreCount1.get(0).getInt("count");
//商品页数
int count_page=total/5;
System.out.println("count_page"+count_page);
int plus;
int minus;
//下一页
if(Integer.parseInt(discuss_page)==count_page){
	plus=count_page;
}else{
	plus =Integer.parseInt(discuss_page)+1;
}
//上一页
if(Integer.parseInt(discuss_page)==0){
	minus =0;	
}else{
	minus =Integer.parseInt(discuss_page)-1;
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
		<meta name="description" content="饺耳世家">
		<meta name="keywords" content="饺耳世家、美食">
		<title>饺耳博客详情</title>
		<link href="images/top-icon.png" type="image/x-icon" rel="shortcut icon" />	
		<link href="css/m-style.css" rel="stylesheet">
		<script src="js/jquery-1.11.1.min.js"></script>
		<style>
		html,body{background: #F0F0F0; width: 100%; height: 100%;}
		</style>
	</head>
	<body>
		<div class="container">
			<div class="head head-rel">
				<p>饺耳博客</p>
				<a href="yd_front_boke.jsp" class="back02"><img src="images/back.png"></a>
			</div>
			<!--博客内页开始-->
			<div class="blog-inner">
				<div class="blog-plate">
					<div class="cell mb10">
						<div class="user-tx"><img src="images/user-icon.png"></div>
						<div class="cell_primary"><%=authorxx.get(0).getStringView("username") %></div>
						<div class="blog-time"><%=article.get(0).getStringView("createtime") %></div>
					</div>
					<h3 class="mb10"><%=article.get(0).getStringView("title") %></h3>
					<img src="<%=article.get(0).getStringView("img1") %>" class="mb10">
					<p class="bottom-line mb10 color-999999"><%=article.get(0).getStringView("content1") %></p>
					<div class="sharebox">
		            	<span class="love on">喜欢266</span><span class="comment">评论96</span>
		            </div>
				</div>
				<!--发表评论-->
				<div class="blog-plate">
					<h3 class="mb10">发表评论</h3>
					<form id="form_tj" action="yd_front_boke_inner.jsp?page=0&jishu=<%=val%>&tagid=<%=request.getParameter("tagid") %>" method="post"  class="form">
       					<textarea placeholder="发表你的评价" name="content"></textarea>
       					<div class="clearfix"><input type="submit" Name="Action" value="发表评论" class="submit" ></div>
      				</form>
				</div>
				<!--热门评论-->
				<div class="blog-plate">
					<h3 class="mb10 bottom-line">热门评论</h3>
					 <% for(int i=0;i<showdiscuss.size();i++){
		    	Mapx<String,Object> showdiscuss_1 = showdiscuss.get(i);
		    	List<Mapx<String,Object>> user_xinxi = DB.getRunner().query("select username from user where  userid=? ",new MapxListHandler(),showdiscuss_1.getIntView("sh_userid"));
		    	//获取访客用户
		    	
		    	List<Mapx<String, Object>> visitorxx= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),showdiscuss_1.getIntView("sh_visitor"));
		    	System.out.println("showdiscuss_1"+showdiscuss_1);
		    	%>
      				<div class="hot-comment bottom-line mb10">
						<div class="cell mb10">
							<div class="user-tx"><img src="images/user-icon.png"></div>
							<div class="cell_primary"><%=visitorxx.get(0).getStringView("username") %></div>
							<div class="blog-time"><%=showdiscuss_1.getStringView("discusstime")%></div>
						</div>
						<p class="color-999999"><%=showdiscuss_1.getStringView("sh_discuss") %></p>
					</div>
		            
		    	<%} %> 
				</div>
				<!--评价部分开始-->
      			<!-- <div class="nav-page">
				<div class="pagination">
				    <a href="${pageContext.request.contextPath}/yd_front_boke_inner.jsp?page=<%=minus%>&tagid=<%=request.getParameter("tagid") %>">«</a>
				    <a href="${pageContext.request.contextPath}/yd_front_boke_inner.jsp?page=0&tagid=<%=request.getParameter("tagid") %>">1</a>
				    <a href="${pageContext.request.contextPath}/yd_front_boke_inner.jsp?page=1&tagid=<%=request.getParameter("tagid") %>">2</a>
				    <a href="${pageContext.request.contextPath}/yd_front_boke_inner.jsp?page=2&tagid=<%=request.getParameter("tagid") %>">3</a>
				    <a>...</a>
				    <a href="${pageContext.request.contextPath}/yd_front_boke_inner.jsp?page=<%=count_page-1%>&tagid=<%=request.getParameter("tagid") %>"><%=count_page%></a>
				    <a href="${pageContext.request.contextPath}/yd_front_boke_inner.jsp?page=<%=count_page%>&tagid=<%=request.getParameter("tagid") %>"><%=count_page+1%></a>
				    <a href="${pageContext.request.contextPath}/yd_front_boke_inner.jsp?page=<%=plus%>&tagid=<%=request.getParameter("tagid") %>">»</a>
				</div>
				</div> -->
       			<!--评价部分结束-->
			</div>
			<!--返回顶部按钮-->
			<div id="topcontrol" style="display:none; position: fixed; bottom:180px; right: 0px; cursor: pointer; z-index: 119;" title="返回顶部">
			<img style="width:36px; height:40px;" src="images/gotop.png">
		    </div>
		</div>	
	</body>
	<!--返回顶部js-->
		<script>
		$(function(e) {
            var T=0;
		    $(window).scroll(function(event) {
		        T=$(window).scrollTop();
		
		        if(T>300)
		        {
		            $("#topcontrol").fadeIn();
		        }
		        else
		        {
		            $("#topcontrol").fadeOut();
		        }
		
		    });
		    $("#topcontrol").click(function(event) {
		        $("body,html").stop().animate({"scrollTop":0},1000);//一秒钟时间回到顶部
		    });
      })
	 </script>
</html>
