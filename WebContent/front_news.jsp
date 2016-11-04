
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>
<%
HashMap<String,String> param= G.getParamMap(request);
//获取url
String  url  =  "http://"  +  request.getServerName()  +  ":"  +  request.getServerPort()  +  request.getContextPath()+request.getServletPath().substring(0,request.getServletPath().lastIndexOf("/")+1);
String url1 = request.getRequestURI(); 

String url3=request.getRequestURI().toString(); //得到相对url 
String url2=request.getRequestURI().toString(); //得到绝对URL
//验证用户登陆
String username = (String)session.getAttribute("username");
int flag=0;
if(username==null){
	
}else{
	flag=1;
}
int xwlei;
if(request.getParameter("xwlei")==null){
	xwlei=1;
}else{
	xwlei=Integer.parseInt(request.getParameter("xwlei"));
}
//获取页数信息
String index_page;
if(request.getParameter("page")==null){
	index_page=String.valueOf(0);
}else{
	index_page=request.getParameter("page");
}
int page_ye=Integer.parseInt(index_page)*5;
//搜索属性
String searchtj;

/*统计 新闻数及 页数*/
String leibie="";
if(xwlei==2){
	leibie="热门";
	}
if(xwlei==3){
	leibie="美食"; 
	}
if(xwlei==4){
	leibie="科技";
	}
if(xwlei==5){
	leibie="娱乐";
	}
String sqlPreCount;
List<Mapx<String,Object>> sqlPreCount1;
if(xwlei!=1){
	sqlPreCount = "select count(1) as count from news where newstype=? and type=? and (del is NULL or del <>1)  order BY newsid DESC ";
	sqlPreCount1 =  DB.getRunner().query(sqlPreCount, new MapxListHandler(),"boke",leibie);
}else{
	sqlPreCount = "select count(1) as count from news where newstype=? and (del is NULL or del <>1)  order BY newsid DESC ";
	sqlPreCount1 =  DB.getRunner().query(sqlPreCount, new MapxListHandler(),"boke");
}

//总商品数量
int total = sqlPreCount1.get(0).getInt("count");
//商品页数
int count_page=total/5;
int plus;
int minus;
//下一页
if(Integer.parseInt(index_page)==count_page){
	plus=count_page;
}else{
	plus =Integer.parseInt(index_page)+1;
}
//上一页
if(Integer.parseInt(index_page)==1){
	minus =1;	
}else{
	minus =Integer.parseInt(index_page)-1;
}
//用户信息
//List<Mapx<String, Object>> user = DB.getRunner().query("select userid from user where username=? ",new MapxListHandler(), username);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <meta name="description" content="舵爷，火锅的江湖。舵爷江湖老火锅旗舰店创立于北京财满街。舵爷品牌名来自在“京城孟尝君”之美誉的黄珂黄舵爷，一群骨灰级美食家创造了这一文化老火锅的饕餮盛宴，主打重庆传统火锅情怀。">
		 <meta name="keywords" content="火锅，舵爷火锅，美味火锅，舵爷文化，江湖老火锅，麻辣鲜美，涮锅，四川火锅，重庆火锅，好吃的火锅">
		<title>新闻咨询</title>
		<link href="img/dy-icon.png" type="image/x-icon" rel="shortcut icon" />	
		<link href="css/_main.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<script src="js/jquery-1.11.1.min.js"></script>
		<script src="js/bootstrap.min.js" type="text/javascript"></script>
		<script src="layer/layer.js"></script>
		<!--[if it iE8]>
			<p class="tixin">为了达到最佳观看效果，请升级到最新浏览器</p>
        -->
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    	
	</head>
<body>
		<!--视频弹出层开始-->
		<div class="video-box" style="display: none;">
			<video id="vPlayer" controls="controls"  width="100%" heigh="517" poster="img/video-bg.jpg" src="video/example.mp4"></video>
		</div>
		<!--视频弹出层结束-->
		<%@ include file="header.jsp"%>
		<!--导航部分开始-->
        <div class="navbar">
        	<div class="container">
        		<div class="row">
			    	<ul id="nav2" class="nav2 clearfix">
						<li class="nLi">
								<h3><a href="front_index.jsp" >首页</a></h3>
						</li>
						<li class="nLi on">
								<h3><a href="front_news.jsp" >舵爷资讯</a></h3>
						</li>
						<li class="nLi">
								<h3><a href="front_product.jsp?cailei=1" >舵爷菜品</a></h3>
								<ul class="sub">
									<li><a href="front_product.jsp?cailei=6">店长推荐</a></li>
									<li><a href="front_product.jsp?cailei=1">秘制锅底</a></li>
									<li><a href="front_product.jsp?cailei=2">牛羊肉类</a></li>
									<li><a href="front_product.jsp?cailei=3">海鲜鱼丸</a></li>
									<li><a href="front_product.jsp?cailei=4">菌菇时蔬</a></li>
									<li><a href="front_product.jsp?cailei=5">京川小吃</a></li>
									<li><a href="front_product.jsp?cailei=7">酒水饮料</a></li>
								</ul>
						</li>
						<li class="nLi">
								<h3><a href="about-us.jsp" >关于舵爷</a></h3>
								<ul class="sub">
									<li><a href="about-us.jsp?cailei=1">公司介绍</a></li>
									<li><a href="about-us.jsp?cailei=2">公司文化</a></li>
									<li><a href="about-us.jsp?cailei=3">线下活动</a></li>
									<li><a href="about-us.jsp?cailei=4">人才招聘</a></li>
									<li><a href="about-us.jsp?cailei=5">联系我们</a></li>
								</ul>
						</li>
						<li class="nLi">
								<h3><a href="about-us.jsp?cailei=3">线下活动</a></h3>
						</li>
						<li class="nLi">
								<h3><a href="about-us.jsp?cailei=4">人才招聘</a></h3>
						</li>
						<li class="nLi">
								<h3><a href="about-us.jsp?cailei=5">联系我们</a></h3>
						</li>
						
					</ul>


        		</div>
		    </div>
		</div>
        <!--导航部分结束-->
		               <!--banner图部分开始-->
        <div class="news-banner"></div>
        <!--banner图部分结束-->
           <!--博客主体内容开始-->
        <div class="mainbox">
         <div class="container">
         	<div class="row">
         		<ol class="breadcrumb">
         		  <li>当前页面</li>	
				  <li><a href="front_news.jsp">舵爷资讯</a></li>
				  <li class="active">资讯列表</li>
				</ol>
         	</div>
         	<div class="row">
         		<!--左边部分开始-->
	         		<div class="col-md-9">
	         			<div class="main-left">
	         			<div class="title-nav clearfix">
							<a href="front_news.jsp?xwlei=1"><div id="d1" class="title-nav-item"><a href="front_news.jsp?page=0">全部</a></div></a>
							<a href="front_news.jsp?xwlei=2"><div id="d2" class="title-nav-item">热门</div></a>
							<a href="front_news.jsp?xwlei=3"><div id="d3" class="title-nav-item">美食</div></a>
							<a href="front_news.jsp?xwlei=4"><div id="d4" class="title-nav-item">科技</div></a>
							<a href="front_news.jsp?xwlei=5"><div id="d5" class="title-nav-item">娱乐</div></a>
						</div>
			    <script type="text/javascript">
if(<%=xwlei%>==1){
	$("#d1").addClass("active"); 
}
if(<%=xwlei%>==2){
	$("#d2").addClass("active"); 
	}
if(<%=xwlei%>==3){
	$("#d3").addClass("active"); 
	}
if(<%=xwlei%>==4){
	$("#d4").addClass("active"); 
	}
if(<%=xwlei%>==5){
	$("#d5").addClass("active"); 
	}
 </script>
						<!--下部内容-->
						<div class="course-slide">
						 <%if(xwlei==1){ %>
							<!--板块一内容 即热门部分--> 
							<div class="tab-inner cell-list">
							<%
							//判断是否是搜索显示
							if((param.get("search_submit")!=null && param.get("search_submit").equals("搜索"))||request.getParameter("searchname")!=null){
								if(request.getParameter("searchname")!=null){
									searchtj=new String(request.getParameter("searchname").getBytes("iso-8859-1"),"utf-8");
								}else{
									searchtj=new String(request.getParameter("search").getBytes("iso-8859-1"),"utf-8");
								}
								//搜索信息统计
								List<Mapx<String, Object>> searchSql= DB.getRunner().query("select searchtj,count(1) from search_count where searchname=? and searchtype=?", new MapxListHandler(),searchtj,"boke");
								if(searchSql.get(0).getInt("count(1)").equals(0)){
									DB.getRunner().update("insert into search_count(searchname,searchtj,searchtype) values(?,?,?)",searchtj,1,"boke");
								}else{
									DB.getRunner().update("update search_count set searchtj = ? where searchname=? and searchtype=?",searchSql.get(0).getInt("searchtj")+1,searchtj ,"boke");	
								}
								System.out.println("search yes"+"searchSql"+searchSql);
								//获取新闻资讯的信息
								String xinwenSql="select author,subString(title,1,22) as title,img1,subString(content,1,120) as content, subString(createtime,1,19) as createtime ,type,count,tagid,origin from news where newstype=? and (del is NULL or del <>1) and (title LIKE '%"+searchtj+"%' or content like '%"+searchtj+"%' or  author=(select userid from user where username like '%"+searchtj+"%'))  order BY newsid DESC   limit "+page_ye+",5";
								List<Mapx<String,Object>> xinwens =  DB.getRunner().query(xinwenSql, new MapxListHandler(),"boke");
								for(int i=0;i<xinwens.size();i++){
									Mapx<String,Object> one = xinwens.get(i);
									//获取文章作者
									List<Mapx<String, Object>> authorxx= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),one.getIntView("author"));
								%> 
									<div class="cell">
										<div class="pic">
											<img src="<%=one.getStringView("img1") %>">
											<span class="pic-tilte"><%=one.getStringView("type") %></span>
										</div>
										<div class="cell_primary">
											<a href="front_news-inner.jsp?page=0&tagid=<%=one.getIntView("tagid") %>" target="_blank"><h3 class="color-dd2727 mb15"><%=one.getStringView("title") %></h3></a>	
											<div class="mb20 txt-indent">
											<a href="front_news-inner.jsp?page=0&tagid=<%=one.getIntView("tagid") %>" class="line3 color-666666"><%=one.getStringView("content") %></a>
											</div>
											<div class="color-666666">来自：
											<%if(one.getStringView("origin").equals("")){ %>
											<%=authorxx.get(0).getStringView("username") %>
											<%}else{ %>
											<%=one.getStringView("origin") %>
											<%} %>
											<span>|</span><%=one.getIntView("createtime") %><span class="glyphicon glyphicon-eye-open color-ff6600"></span><%=one.getIntView("count") %></div>
											<div class="bdsharebuttonbox bd-share">
												<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
											</div>
										</div>
									</div>
								<%}
							}else{
								System.out.println("search no");
								//获取新闻资讯的信息
								String xinwenSql="select author,subString(title,1,22) as title,img1,subString(content,1,120) as content, subString(createtime,1,19) as createtime ,type,count ,tagid ,origin from news where  newstype=? and  (del is NULL or del <>1)  order BY newsid DESC  limit "+page_ye+",5";
								List<Mapx<String,Object>> xinwens =  DB.getRunner().query(xinwenSql, new MapxListHandler(),"boke");
								for(int i=0;i<xinwens.size();i++){
									Mapx<String,Object> one = xinwens.get(i);
									//获取文章作者
									List<Mapx<String, Object>> authorxx= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),one.getIntView("author"));
								%>
									<div class="cell">
										<div class="pic">
											<img src="<%=one.getStringView("img1") %>">
											<span class="pic-tilte"><%=one.getStringView("type") %></span>
										</div>
										<div class="cell_primary">
											<a href="front_news-inner.jsp?page=0&tagid=<%=one.getIntView("tagid") %>" target="_blank"><h3 class="color-dd2727 mb15"><%=one.getStringView("title") %></h3></a>	
											<div class="mb20 txt-indent">
													<a href="front_news-inner.jsp?page=0&tagid=<%=one.getIntView("tagid") %>" class="line3 color-666666"><%=one.getStringView("content") %></a>
											</div>
											<div class="color-666666">来自：
											<%if(one.getStringView("origin").equals("")){ %>
											<%=authorxx.get(0).getStringView("username") %>
											<%}else{ %>
											<%=one.getStringView("origin") %>
											<%} %>
											<span>|</span><%=one.getIntView("createtime") %><span class="glyphicon glyphicon-eye-open color-ff6600"></span><%=one.getIntView("count") %></div>
											<div class="bdsharebuttonbox bd-share">
												<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
											</div>
										</div>
									</div>
							<%} }%>
								<!--分页内容标签开始-->
								 <%if(total>5){ %>
								<div class="nav-page">
								<%if(count_page>4){ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=minus%>">&laquo;</a></li>
								    <%if(Integer.parseInt(index_page)<3) {%>
								    <li id="t1"><a href="${pageContext.request.contextPath}/front_news.jsp?page=0">1</a></li>
								    <li id="t2"><a href="${pageContext.request.contextPath}/front_news.jsp?page=1">2</a></li>
								    <li id="t3"><a href="${pageContext.request.contextPath}/front_news.jsp?page=2">3</a></li>
								    <%}else if((Integer.parseInt(index_page)>=3)&&(Integer.parseInt(index_page)<(count_page-3))){ %>
								    <li id="t<%=Integer.parseInt(index_page)+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=Integer.parseInt(index_page)%>"><%=Integer.parseInt(index_page)+1%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+2%>"><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=Integer.parseInt(index_page)+1%>"><%=Integer.parseInt(index_page)+2%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+3%>"><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=Integer.parseInt(index_page)+2%>"><%=Integer.parseInt(index_page)+3%></a></li>
								    <%}else{ %>
								    <li id="t<%=count_page-3%>"><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=count_page-4%>"><%=count_page-3%></a></li>
								    <li id="t<%=count_page-2%>"><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=count_page-3%>"><%=count_page-2%></a></li>
								    <li id="t<%=count_page-1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=count_page-2%>"><%=count_page-1%></a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li id="t<%=count_page%>"><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=count_page-1%>"><%=count_page%></a></li>
								    <li id="t<%=count_page+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=count_page%>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%}else{ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=minus%>">&laquo;</a></li>
								    <%for(int i=0;i<=count_page;i++){ %>
								    <li id="t<%=i+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=i%>"><%=i+1%></a></li>
								    <%} %>
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%} %>
								</div>
<script type="text/javascript">
<%for(int j=0;j<=count_page;j++){ %>
	if((<%=xwlei%>==1)&&(<%=Integer.parseInt(index_page)%>==<%=j%>)){
		$("#t<%=j+1%>").addClass("on"); 
	}
	<%} %>
</script>
<%} %>
						<!--分页内容标签结束-->
							</div>
							<%}else if(xwlei==2){ %>
							<!--板块二内容开始  热门-->
							<div class="tab-inner cell-list">
							<%//获取新闻资讯的信息
							String xinwenSqlrm="select author,subString(title,1,22) as title,img1,subString(content,1,120) as content, subString(createtime,1,19) as createtime ,type,count ,tagid,origin from news where  newstype=? and type=? and  (del is NULL or del <>1)  order BY newsid DESC   limit "+page_ye+",5";
							List<Mapx<String,Object>> xinwensrm =  DB.getRunner().query(xinwenSqlrm, new MapxListHandler(),"boke","热门");
							for(int i=0;i<xinwensrm.size();i++){
								Mapx<String,Object> one = xinwensrm.get(i);
								//获取文章作者
								List<Mapx<String, Object>> authorxx= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),one.getIntView("author"));
							%>
								<div class="cell">
									<div class="pic">
										<img src="<%=one.getStringView("img1") %>">
										<span class="pic-tilte"><%=one.getStringView("type") %></span>
									</div>
									<div class="cell_primary">
										<a href="front_news-inner.jsp?page=0&tagid=<%=one.getIntView("tagid") %>" target="_blank"><h3 class="color-dd2727 mb15"><%=one.getStringView("title") %></h3></a>	
										<div class="mb20 txt-indent">
												<a href="front_news-inner.jsp?page=0&tagid=<%=one.getIntView("tagid") %>" class="line3 color-666666"><%=one.getStringView("content") %></a>
										</div>
										
										<div class="color-666666">来自：
											<%if(one.getStringView("origin").equals("")){ %>
											<%=authorxx.get(0).getStringView("username") %>
											<%}else{ %>
											<%=one.getStringView("origin") %>
											<%} %>
											<span>|</span><%=one.getIntView("createtime") %><span class="glyphicon glyphicon-eye-open color-ff6600"></span><%=one.getIntView("count") %></div>
										<div class="bdsharebuttonbox bd-share">
											<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
										</div>
									</div>
								</div>
						<%} %>
								<!--分页内容标签开始-->
								 <%if(total>5){ %>
								<div class="nav-page">
								<%if(count_page>4){ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=minus%>">&laquo;</a></li>
								    <%if(Integer.parseInt(index_page)<3) {%>
								    <li id="t1"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=0">1</a></li>
								    <li id="t2"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=1">2</a></li>
								    <li id="t3"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=2">3</a></li>
								    <%}else if((Integer.parseInt(index_page)>=3)&&(Integer.parseInt(index_page)<(count_page-3))){ %>
								    <li id="t<%=Integer.parseInt(index_page)+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=Integer.parseInt(index_page)%>"><%=Integer.parseInt(index_page)+1%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+2%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=Integer.parseInt(index_page)+1%>"><%=Integer.parseInt(index_page)+2%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+3%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=Integer.parseInt(index_page)+2%>"><%=Integer.parseInt(index_page)+3%></a></li>
								    <%}else{ %>
								    <li id="t<%=count_page-3%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=count_page-4%>"><%=count_page-3%></a></li>
								    <li id="t<%=count_page-2%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=count_page-3%>"><%=count_page-2%></a></li>
								    <li id="t<%=count_page-1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=count_page-2%>"><%=count_page-1%></a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li id="t<%=count_page%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=count_page-1%>"><%=count_page%></a></li>
								    <li id="t<%=count_page+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=count_page%>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%}else{ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=minus%>">&laquo;</a></li>
								    <%for(int i=0;i<=count_page;i++){ %>
								    <li id="t<%=i+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=i%>"><%=i+1%></a></li>
								    <%} %>
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=2&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%} %>
								</div>
<script type="text/javascript">
<%for(int j=0;j<=count_page;j++){ %>
	if((<%=xwlei%>==2)&&(<%=Integer.parseInt(index_page)%>==<%=j%>)){
		$("#t<%=j+1%>").addClass("on"); 
	}
	<%} %>
</script>
<%} %>
						<!--分页内容标签结束-->
							</div>
							<%}else if(xwlei==3){ %>
							<!--板块三内容开始  美食-->
							<div class="tab-inner cell-list">
							<%//获取新闻资讯的信息
							String xinwenSqlms="select author,subString(title,1,22) as title,img1,subString(content,1,120) as content, subString(createtime,1,19) as createtime ,type,count ,tagid,origin from news where  newstype=? and type=? and  (del is NULL or del <>1)  order BY newsid DESC   limit "+page_ye+",5";
							List<Mapx<String,Object>> xinwensms =  DB.getRunner().query(xinwenSqlms, new MapxListHandler(),"boke","美食");
							for(int i=0;i<xinwensms.size();i++){
								Mapx<String,Object> one = xinwensms.get(i);
								//获取文章作者
								List<Mapx<String, Object>> authorxx= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),one.getIntView("author"));
							%>
								<div class="cell">
									<div class="pic">
										<img src="<%=one.getStringView("img1") %>">
										<span class="pic-tilte"><%=one.getStringView("type") %></span>
									</div>
									<div class="cell_primary">
										<a href="front_news-inner.jsp?page=0&tagid=<%=one.getIntView("tagid") %>" target="_blank"><h3 class="color-dd2727 mb15"><%=one.getStringView("title") %></h3></a>	
										<div class="mb20 txt-indent">
												<a href="front_news-inner.jsp?page=0&tagid=<%=one.getIntView("tagid") %>" class="line3 color-666666"><%=one.getStringView("content") %></a>
										</div>
										
										<div class="color-666666">来自：
											<%if(one.getStringView("origin").equals("")){ %>
											<%=authorxx.get(0).getStringView("username") %>
											<%}else{ %>
											<%=one.getStringView("origin") %>
											<%} %>
											<span>|</span><%=one.getIntView("createtime") %><span class="glyphicon glyphicon-eye-open color-ff6600"></span><%=one.getIntView("count") %></div>
										<div class="bdsharebuttonbox bd-share">
											<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
										</div>
									</div>
								</div>
						<%} %>
								<!--分页内容标签开始-->
								 <%if(total>5){ %>
								<div class="nav-page">
								<%if(count_page>4){ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=minus%>">&laquo;</a></li>
								    <%if(Integer.parseInt(index_page)<3) {%>
								    <li id="t1"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=0">1</a></li>
								    <li id="t2"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=1">2</a></li>
								    <li id="t3"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=2">3</a></li>
								    <%}else if((Integer.parseInt(index_page)>=3)&&(Integer.parseInt(index_page)<(count_page-3))){ %>
								    <li id="t<%=Integer.parseInt(index_page)+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=Integer.parseInt(index_page)%>"><%=Integer.parseInt(index_page)+1%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+2%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=Integer.parseInt(index_page)+1%>"><%=Integer.parseInt(index_page)+2%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+3%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=Integer.parseInt(index_page)+2%>"><%=Integer.parseInt(index_page)+3%></a></li>
								    <%}else{ %>
								    <li id="t<%=count_page-3%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=count_page-4%>"><%=count_page-3%></a></li>
								    <li id="t<%=count_page-2%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=count_page-3%>"><%=count_page-2%></a></li>
								    <li id="t<%=count_page-1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=count_page-2%>"><%=count_page-1%></a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li id="t<%=count_page%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=count_page-1%>"><%=count_page%></a></li>
								    <li id="t<%=count_page+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=count_page%>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%}else{ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=minus%>">&laquo;</a></li>
								    <%for(int i=0;i<=count_page;i++){ %>
								    <li id="t<%=i+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=i%>"><%=i+1%></a></li>
								    <%} %>
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=3&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%} %>
								</div>
<script type="text/javascript">
<%for(int j=0;j<=count_page;j++){ %>
	if((<%=xwlei%>==3)&&(<%=Integer.parseInt(index_page)%>==<%=j%>)){
		$("#t<%=j+1%>").addClass("on"); 
	}
	<%} %>
</script>
<%} %>
						<!--分页内容标签结束-->
							</div>
							<%} else if(xwlei==4){ %>
							<!--板块四内容开始  科技-->
							<div class="tab-inner cell-list" >
							<%//获取新闻资讯的信息
							String xinwenSqltu="select author,subString(title,1,22) as title,img1,subString(content,1,120) as content, subString(createtime,1,19) as createtime ,type,count ,tagid,origin from news where  newstype=? and type=? and  (del is NULL or del <>1)  order BY newsid DESC   limit "+page_ye+",5";
							List<Mapx<String,Object>> xinwenstu =  DB.getRunner().query(xinwenSqltu, new MapxListHandler(),"boke","科技");
							for(int i=0;i<xinwenstu.size();i++){
								Mapx<String,Object> one = xinwenstu.get(i);
								//获取文章作者
								List<Mapx<String, Object>> authorxx= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),one.getIntView("author"));
							%>
								<div class="cell">
									<div class="pic">
										<img src="<%=one.getStringView("img1") %>">
										<span class="pic-tilte"><%=one.getStringView("type") %></span>
									</div>
									<div class="cell_primary">
										<a href="front_news-inner.jsp?page=0&tagid=<%=one.getIntView("tagid") %>" target="_blank"><h3 class="color-dd2727 mb15"><%=one.getStringView("title") %></h3></a>	
										<div class="mb20 txt-indent">
												<a href="front_news-inner.jsp?page=0&tagid=<%=one.getIntView("tagid") %>" class="line3 color-666666"><%=one.getStringView("content") %></a>
										</div>
										
										<div class="color-666666">来自：
											<%if(one.getStringView("origin").equals("")){ %>
											<%=authorxx.get(0).getStringView("username") %>
											<%}else{ %>
											<%=one.getStringView("origin") %>
											<%} %>
											<span>|</span><%=one.getIntView("createtime") %><span class="glyphicon glyphicon-eye-open color-ff6600"></span><%=one.getIntView("count") %></div>
										<div class="bdsharebuttonbox bd-share">
											<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
										</div>
									</div>
								</div>
						<%} %>
								<!--分页内容标签开始-->
								 <%if(total>5){ %>
								<div class="nav-page">
								<%if(count_page>4){ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=minus%>">&laquo;</a></li>
								    <%if(Integer.parseInt(index_page)<3) {%>
								    <li id="t1"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=0">1</a></li>
								    <li id="t2"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=1">2</a></li>
								    <li id="t3"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=2">3</a></li>
								    <%}else if((Integer.parseInt(index_page)>=3)&&(Integer.parseInt(index_page)<(count_page-3))){ %>
								    <li id="t<%=Integer.parseInt(index_page)+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=Integer.parseInt(index_page)%>"><%=Integer.parseInt(index_page)+1%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+2%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=Integer.parseInt(index_page)+1%>"><%=Integer.parseInt(index_page)+2%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+3%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=Integer.parseInt(index_page)+2%>"><%=Integer.parseInt(index_page)+3%></a></li>
								    <%}else{ %>
								    <li id="t<%=count_page-3%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=count_page-4%>"><%=count_page-3%></a></li>
								    <li id="t<%=count_page-2%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=count_page-3%>"><%=count_page-2%></a></li>
								    <li id="t<%=count_page-1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=count_page-2%>"><%=count_page-1%></a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li id="t<%=count_page%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=count_page-1%>"><%=count_page%></a></li>
								    <li id="t<%=count_page+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=count_page%>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%}else{ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=minus%>">&laquo;</a></li>
								    <%for(int i=0;i<=count_page;i++){ %>
								    <li id="t<%=i+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=i%>"><%=i+1%></a></li>
								    <%} %>
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=4&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%} %>
								</div>
<script type="text/javascript">
<%for(int j=0;j<=count_page;j++){ %>
	if((<%=xwlei%>==4)&&(<%=Integer.parseInt(index_page)%>==<%=j%>)){
		$("#t<%=j+1%>").addClass("on"); 
	}
	<%} %>
</script>
<%} %>
						<!--分页内容标签结束-->
							</div>
							<%}else if(xwlei==5){ %>
							<!--板块五内容开始  娱乐-->
							<div class="tab-inner cell-list" >
							<%//获取新闻资讯的信息
							String xinwenSqlyl="select author,subString(title,1,22) as title,img1,subString(content,1,120) as content, subString(createtime,1,19) as createtime ,type,count ,tagid,origin from news where  newstype=? and type=? and  (del is NULL or del <>1)  order BY newsid DESC   limit "+page_ye+",5";
							List<Mapx<String,Object>> xinwensyl =  DB.getRunner().query(xinwenSqlyl, new MapxListHandler(),"boke","娱乐");
							for(int i=0;i<xinwensyl.size();i++){
								Mapx<String,Object> one = xinwensyl.get(i);
								//获取文章作者
								List<Mapx<String, Object>> authorxx= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),one.getIntView("author"));
							%>
								<div class="cell">
									<div class="pic">
										<img src="<%=one.getStringView("img1") %>">
										<span class="pic-tilte"><%=one.getStringView("type") %></span>
									</div>
									<div class="cell_primary">
										<a href="front_news-inner.jsp?page=0&tagid=<%=one.getIntView("tagid") %>" target="_blank"><h3 class="color-dd2727 mb15"><%=one.getStringView("title") %></h3></a>	
										<div class="mb20 txt-indent">
												<a href="front_news-inner.jsp?page=0&tagid=<%=one.getIntView("tagid") %>" class="line3 color-666666"><%=one.getStringView("content") %></a>
										</div>
										
										<div class="color-666666">来自：
											<%if(one.getStringView("origin").equals("")){ %>
											<%=authorxx.get(0).getStringView("username") %>
											<%}else{ %>
											<%=one.getStringView("origin") %>
											<%} %>
											<span>|</span><%=one.getIntView("createtime") %><span class="glyphicon glyphicon-eye-open color-ff6600"></span><%=one.getIntView("count") %></div>
										<div class="bdsharebuttonbox bd-share">
											<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
										</div>
									</div>
								</div>
						<%} %>
								<!--分页内容标签开始-->
								 <%if(total>5){ %>
								<div class="nav-page">
								<%if(count_page>4){ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=minus%>">&laquo;</a></li>
								    <%if(Integer.parseInt(index_page)<3) {%>
								    <li id="t1"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=0">1</a></li>
								    <li id="t2"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=1">2</a></li>
								    <li id="t3"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=2">3</a></li>
								    <%}else if((Integer.parseInt(index_page)>=3)&&(Integer.parseInt(index_page)<(count_page-3))){ %>
								    <li id="t<%=Integer.parseInt(index_page)+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=Integer.parseInt(index_page)%>"><%=Integer.parseInt(index_page)+1%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+2%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=Integer.parseInt(index_page)+1%>"><%=Integer.parseInt(index_page)+2%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+3%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=Integer.parseInt(index_page)+2%>"><%=Integer.parseInt(index_page)+3%></a></li>
								    <%}else{ %>
								    <li id="t<%=count_page-3%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=count_page-4%>"><%=count_page-3%></a></li>
								    <li id="t<%=count_page-2%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=count_page-3%>"><%=count_page-2%></a></li>
								    <li id="t<%=count_page-1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=count_page-2%>"><%=count_page-1%></a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li id="t<%=count_page%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=count_page-1%>"><%=count_page%></a></li>
								    <li id="t<%=count_page+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=count_page%>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%}else{ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=minus%>">&laquo;</a></li>
								    <%for(int i=0;i<=count_page;i++){ %>
								    <li id="t<%=i+1%>"><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=i%>"><%=i+1%></a></li>
								    <%} %>
								    <li><a href="${pageContext.request.contextPath}/front_news.jsp?xwlei=5&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%} %>
								</div>
<script type="text/javascript">
<%for(int j=0;j<=count_page;j++){ %>
	if((<%=xwlei%>==5)&&(<%=Integer.parseInt(index_page)%>==<%=j%>)){
		$("#t<%=j+1%>").addClass("on"); 
	}
	<%} %>
</script>
<%} %>
						<!--分页内容标签结束-->
							</div>
							<%} %>
						</div>
	         		</div>
         		</div>
         		<!--右边部分开始-->
         		
	         		<div class="col-md-3">
	         			<div class="main-right">
		         			<!--右边-板块一开始-->
		         			<div class="celan celan1">
		         				<h4>图片集</h4>
		         				<ul class="clearfix">
		         				<%List<Mapx<String, Object>> wzt=DB.getRunner().query("select img1 ,titlejs,tagid from news where newstype=? and (del is NULL or del <>1) order by newsid desc limit 9", new MapxListHandler(),"boke");
		         				//总数
		         				List<Mapx<String, Object>> zongwzt=DB.getRunner().query("select count(1) as count from news where newstype=? and (del is NULL or del <>1) ", new MapxListHandler(),"boke");
		         				int shu11;
					    		if(Integer.parseInt(zongwzt.get(0).getStringView("count"))<9){
					    			shu11=Integer.parseInt(zongwzt.get(0).getStringView("count"));
					    		}else{
					    			shu11=9;
					    		}
		         				for(int index_tp=0;index_tp<shu11;index_tp++){ 
		         				if(((index_tp+1)%3)!=0){%>
		         					<li> 
		         						<a href="front_news-inner.jsp?page=0&tagid=<%=wzt.get(index_tp).getIntView("tagid") %>" target="_blank"><img src="<%=wzt.get(index_tp).getStringView("img1")%>" ></a>
		         						<p><%=wzt.get(index_tp).getStringView("titlejs")%></p>
		         					</li>
		         					<%}else{ %>
		         					<li  class="mr0">
		         						<a href="front_news-inner.jsp?page=0&tagid=<%=wzt.get(index_tp).getIntView("tagid") %>" target="_blank"><img src="<%=wzt.get(index_tp).getStringView("img1")%>"></a>
		         						<p><%=wzt.get(index_tp).getStringView("titlejs")%></p>
		         					</li>
		         					<%} }%>
		         				</ul>
		         			</div>
		         			<!--右边-板块二开始-->
		         			<div class="celan celan2">
		         				<h4>最新文章</h4>
		         				<ul>
		         				<%List<Mapx<String, Object>> wzm=DB.getRunner().query("select title,tagid from news where newstype=? and (del is NULL or del <>1) order by newsid desc limit 6", new MapxListHandler(),"boke");
		         				for(int index_wz=0;index_wz<wzm.size();index_wz++){ %>
		         					<li><a href="front_news-inner.jsp?page=0&tagid=<%=wzm.get(index_wz).getIntView("tagid") %>" target="_blank"><%=wzm.get(index_wz).getStringView("title") %></a></li>
		         				<%} %>
		         				</ul>
		         			</div>
		         			<!--右边-板块三开始-->
		         			<div class="celan celan3">
		         				<h4>视频</h4>
		         				<div class="video">
		         					<a href="javascript:;" class="play-video"><img src="img/video-pic_03.jpg"></a>
		         				</div>
		         			</div>
		         			<!--右边-板块四开始-->
		         			<div class="celan celan4">
		         				<h4>你可能感兴趣</h4>
		         				<ul class="keyword-first clearfix">
		         				<%List<Mapx<String, Object>> targ=DB.getRunner().query("select  substring(searchname,1,4) as searchname from search_count where searchtype=? order by searchtj desc limit 9",new MapxListHandler(),"boke");
		         				
		         				%>
		         					<li class="bqb-width"><a href="front_news.jsp?page=0&searchname=<%=targ.get(0).getStringView("searchname") %>" class="bg_color-dd2727"><%=targ.get(0).getStringView("searchname") %></a></li>
		         					<li class="bqb-width"><a href="front_news.jsp?page=0&searchname=<%=targ.get(1).getStringView("searchname") %>" class="bg_color-ff6600"><%=targ.get(1).getStringView("searchname") %></a></li>
		         					<li class="bqb-width mr0"><a href="front_news.jsp?page=0&searchname=<%=targ.get(2).getStringView("searchname") %>" class="bg_color-dd2727"><%=targ.get(2).getStringView("searchname") %></a></li>
		         					<li class="bqb-width"><a href="front_news.jsp?page=0&searchname=<%=targ.get(3).getStringView("searchname") %>" class="bg_color-ff6600"><%=targ.get(3).getStringView("searchname") %></a></li>
		         					<li class="bqb-width"><a href="front_news.jsp?page=0&searchname=<%=targ.get(4).getStringView("searchname") %>" class="bg_color-dd2727"><%=targ.get(4).getStringView("searchname") %></a></li>
		         					<li class="bqb-width mr0"><a href="front_news.jsp?page=0&searchname=<%=targ.get(5).getStringView("searchname") %>" class="bg_color-ff6600"><%=targ.get(5).getStringView("searchname") %></a></li>
		         					<li class="bqb-width"><a href="front_news.jsp?page=0&searchname=<%=targ.get(6).getStringView("searchname") %>" class="bg_color-dd2727"><%=targ.get(6).getStringView("searchname") %></a></li>
		         					<li class="bqb-width"><a href="front_news.jsp?page=0&searchname=<%=targ.get(7).getStringView("searchname") %>" class="bg_color-ff6600"><%=targ.get(7).getStringView("searchname") %></a></li>
		         					<li class="bqb-width mr0"><a href="front_news.jsp?page=0&searchname=<%=targ.get(8).getStringView("searchname") %>" class="bg_color-dd2727"><%=targ.get(8).getStringView("searchname") %></a></li>
		         				</ul>
		         			</div>
		         			<!--右边-板块五开始-->
		         			<div class="celan5">
		         				<img src="img/pic18_03.jpg" />
		         			</div>
	         			</div>
         		</div>
         		<!--右边部分结束-->
         	</div>
         </div>  
       </div>
        <!--博客主体内容结束-->
        <!--页面底部板块开始-->
		<%@ include file="footer.jsp"%>
        <!--页面底部板块结束-->
	</body>
	<!--主内容区左边标题导航tab切换js-->
	<script>
	$(function(){
	var $div_li=$('.title-nav .title-nav-item');
	$div_li.click(function(){
		$(this).addClass('active').siblings().removeClass('active');
		var index =$div_li.index(this);
		$('.course-slide >div').eq(index).show().siblings().hide();
		});	
	});
	</script>
	<!--导航下拉菜单js部分-->
	<script src="js/jquery.SuperSlide.2.1.1.js"></script>
	<script id="jsID" type="text/javascript">
			
			jQuery("#nav2").slide({ 
				type:"menu",// 效果类型，针对菜单/导航而引入的参数（默认slide）
				titCell:".nLi", //鼠标触发对象
				targetCell:".sub", //titCell里面包含的要显示/消失的对象
				effect:"slideDown", //targetCell下拉效果
				delayTime:300 , //效果时间
				triggerTime:0, //鼠标延迟触发时间（默认150）
				returnDefault:true //鼠标移走后返回默认状态，例如默认频道是“预告片”，鼠标移走后会返回“预告片”（默认false）
			});
	</script>
	<!--视频弹出层js开始-->
	<script>
		$(function(){
			$(".play-video").click(function(){
			layer.open({
				  type: 1, 
				  title: false,//不要标题
				  area: ['930px', '537px'],//区域宽和高
				  shadeClose:1,//点击遮罩层关闭弹窗
				  content: $(".video-box") //这里显示内容
			});
		})	
		})
	</script>
	<!--返回顶部js部分-->
	<script>
		$(function(e) {
            var T=0;
		    $(window).scroll(function(event) {
		        T=$(window).scrollTop();
		
		        if(T>500)
		        {
		            $("#topcontrol").fadeIn();
		        }
		        else
		        {
		            $("#topcontrol").fadeOut();
		        }
		
		    });
		    $("#topcontrol").click(function(event) {
		        $("body,html").stop().animate({"scrollTop":0},1000);
		    });
      })
	</script>
<!--百度分享js-->
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"1","bdSize":"18"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
</html>
