<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
int cailei;
if(request.getParameter("cailei")==null){
	cailei=1;
}else{
	cailei=Integer.parseInt(request.getParameter("cailei"));
}
System.out.println("cailei"+cailei);
//获取页数信息
String index_page;
if(request.getParameter("page")==null){
	index_page=String.valueOf(0);
}else{
	index_page=request.getParameter("page");
}
int page_ye=Integer.parseInt(index_page)*9;
//搜索属性
String searchtj;

//用户信息
//List<Mapx<String, Object>> user = DB.getRunner().query("select userid from user where username=? ",new MapxListHandler(), username);
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
String leibie="";
if(cailei==1){
	leibie="特色锅底";
}
if(cailei==2){
	leibie="开胃凉菜";
	}
if(cailei==3){
	leibie="精美热菜"; 
	}
if(cailei==4){
	leibie="主食";
	}
if(cailei==5){
	leibie="酒水饮料";
	}
System.out.println(leibie);
/*统计 页数*/
String sqlPreCount;
List<Mapx<String,Object>> sqlPreCount1;
if(cailei!=6){
	sqlPreCount = "select count(1) as count from productmenu where productlei=? and (del is NULL or del <>1) ";
	sqlPreCount1 =  DB.getRunner().query(sqlPreCount, new MapxListHandler(),leibie);
}else{
	sqlPreCount = "select count(1) as count from productmenu where  (del is NULL or del <>1)  ";
	sqlPreCount1 =  DB.getRunner().query(sqlPreCount, new MapxListHandler());
}
//总商品数量
int total = sqlPreCount1.get(0).getInt("count");
//商品页数
int count_page=total/9;
System.out.println("count_page"+count_page);

int plus;
int minus;
//下一页
if(Integer.parseInt(index_page)==count_page){
	plus=count_page;
}else{
	plus =Integer.parseInt(index_page)+1;
}
//上一页
if(Integer.parseInt(index_page)==0){
	minus =0;	
}else{
	minus =Integer.parseInt(index_page)-1;
}
List<Mapx<String,Object>> caipinshow;
//获取菜品信息
if(cailei!=6){
	caipinshow=DB.getRunner().query("select productmenuid,productname,productEname,substring(content1,1,64) as content1,img1,yprice from productmenu where (del is NULL or del <>1) and productlei=? order by shoucang desc,productmenuid desc limit "+page_ye+",9", new MapxListHandler(),leibie);
}else{
	caipinshow=DB.getRunner().query("select productmenuid,productname,productEname,substring(content1,1,64) as content1,img1,yprice from productmenu where (del is NULL or del <>1) order by shoucang desc,productmenuid desc limit "+page_ye+",9", new MapxListHandler());
}
System.out.println("caipinshow"+caipinshow);

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <meta name="description" content="">
		  <meta name="keywords" content="饺耳、美食">
		<title>舵爷产品页面</title>
		<link href="img/duoyeLOGO.png" rel="SHORTCUT ICON">
		<!--<link href="css/bootstrap.css" rel="stylesheet">-->
		<link href="css/_main.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<script src="js/jquery-1.11.1.min.js"></script>
		<script src="js/bootstrap.min.js" type="text/javascript"></script>
		<!--<script src="layer/layer.js"></script>-->
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
		<%@ include file="header.jsp"%>
		<!--导航部分开始-->
        <div class="navbar">
        	<div class="container">
        		<div class="row">
			    	<ul id="nav2" class="nav2 clearfix">
						<li class="nLi">
								<h3><a href="front_index.jsp" >首页</a></h3>
						</li>
						<li class="nLi ">
								<h3><a href="front_news.jsp" >舵爷资讯</a></h3>
						</li>
						<li class="nLi on">
								<h3><a href="front_product.jsp?cailei=1" >舵爷菜品</a></h3>
								<ul class="sub">
									<li><a href="front_product.jsp?cailei=6">店长推荐</a></li>
									<li><a href="front_product.jsp?cailei=1">特色锅底</a></li>
									<li><a href="front_product.jsp?cailei=2">开胃凉菜</a></li>
									<li><a href="front_product.jsp?cailei=3">精品热菜</a></li>
									<li><a href="front_product.jsp?cailei=5">酒水饮料</a></li>
									<li><a href="front_product.jsp?cailei=4">美味主食</a></li>
								</ul>
						</li>
						<li class="nLi">
								<h3><a href="about-us.jsp" >关于舵爷</a></h3>
								<ul class="sub">
									<li><a href="about-us.jsp">公司介绍</a></li>
									<li><a href="about-us.jsp">公司文化</a></li>
									<li><a href="about-us.jsp">店铺活动</a></li>
									<li><a href="about-us.jsp">人才招聘</a></li>
									<li><a href="about-us.jsp">联系我们</a></li>
								</ul>
						</li>
						<li class="nLi">
								<h3><a href="about-us.jsp">线下活动</a></h3>
						</li>
						<li class="nLi">
								<h3><a href="about-us.jsp">人才招聘</a></h3>
						</li>
						<li class="nLi">
								<h3><a href="about-us.jsp">联系我们</a></h3>
						</li>
						
					</ul>


        		</div>
		    </div>
		</div>
        <!--导航部分结束-->
		        <!--banner图部分开始-->
        <div class="product-banner"></div>
        <!--banner图部分结束-->
        <!--博客主体内容开始-->
        <div class="mainbox">
         <div class="container">
         	<div class="row">
         		<ol class="breadcrumb">
         		  <li>当前页面</li>
				  <li><a href="front_product.jsp">舵爷菜品</a></li>
				  <li class="active">菜品列表</li>
				</ol>
         	</div>
         	<div class="row product">
         		<div class="product-title"></div>
         		<div class="title-nav clearfix">
         					<a href="front_product.jsp?cailei=6"><div id="d6" class="title-nav-item">店长推荐</div></a>
							<a href="front_product.jsp?cailei=1"><div id="d1" class="title-nav-item">特色锅底</div></a>
							<a href="front_product.jsp?cailei=2"><div id="d2" class="title-nav-item">开胃凉菜</div></a>
							<a href="front_product.jsp?cailei=3"><div id="d3" class="title-nav-item">精品热菜</div></a>
							<a href="front_product.jsp?cailei=4"><div id="d4" class="title-nav-item">美味主食</div></a>
							<a href="front_product.jsp?cailei=5"><div id="d5" class="title-nav-item">酒水饮料</div></a>
			    </div>
			    <script type="text/javascript">
if(<%=cailei%>==1){
	$("#d1").addClass("active"); 
}
if(<%=cailei%>==2){
	$("#d2").addClass("active"); 
	}
if(<%=cailei%>==3){
	$("#d3").addClass("active"); 
	}
if(<%=cailei%>==4){
	$("#d4").addClass("active"); 
	}
if(<%=cailei%>==5){
	$("#d5").addClass("active"); 
	}
if(<%=cailei%>==6){
	$("#d6").addClass("active"); 
	}
 </script>
			    <div class="course-slide">
			    	<!--板块一部分开始 特色锅底-->
			    <%if(cailei==1){ %>

			    	<div class="product-list">
			    		<ul class="clearfix fmpage">
			    		<%int q;for(q=0;q<caipinshow.size();q++){ %>
			    			<%if((q!=2)&&(q!=5)&&(q!=8)){ %>
			    			<li>
			    				<a href="front_product-inner.jsp?caiid=<%=caipinshow.get(q).getIntView("productmenuid")%>" target="_blank">
				    				<img src="<%=caipinshow.get(q).getStringView("img1") %>" class="img-responsive">
				    				<div class="txt">
				    					<h4><%=caipinshow.get(q).getStringView("productname") %></h4>
				    					<p><%=caipinshow.get(q).getStringView("productEname") %></p>
				    					<p class="txt-indent"><%=caipinshow.get(q).getStringView("content1") %></p>
				    					<p class="size18"><strong>￥<%=caipinshow.get(q).getIntView("yprice") %>/份</strong></p>
				    				</div>
			    				</a>
			    			</li>
			    			<%}else{ %>
			    			<li class="mr0">
			    				<a href="front_product-inner.jsp?caiid=<%=caipinshow.get(q).getIntView("productmenuid")%>" target="_blank">
				    				<img src="<%=caipinshow.get(q).getStringView("img1") %>" class="img-responsive">
				    				<div class="txt">
				    					<h4><%=caipinshow.get(q).getStringView("productname") %></h4>
				    					<p><%=caipinshow.get(q).getStringView("productEname") %></p>
				    					<p class="txt-indent"><%=caipinshow.get(q).getStringView("content1") %></p>
				    					<p class="size18"><strong>￥<%=caipinshow.get(q).getIntView("yprice") %>/份</strong></p>
				    				</div>
			    				</a>
			    			</li>
			    		<%}} %>
			    		</ul>
			    		<%if(total>9){ %>
			    			
			    		<!--分页内容标签开始-->
								<div class="nav-page">
								<%if(count_page>4){ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=minus%>">&laquo;</a></li>
								    <%if(Integer.parseInt(index_page)<3) {%>
								    <li id="t1"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=0">1</a></li>
								    <li id="t2"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=1">2</a></li>
								    <li id="t3"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=2">3</a></li>
								    <%}else if((Integer.parseInt(index_page)>=3)&&(Integer.parseInt(index_page)<(count_page-3))){ %>
								    <li id="t<%=Integer.parseInt(index_page)+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=<%=Integer.parseInt(index_page)%>"><%=Integer.parseInt(index_page)+1%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+2%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=<%=Integer.parseInt(index_page)+1%>"><%=Integer.parseInt(index_page)+2%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+3%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=<%=Integer.parseInt(index_page)+2%>"><%=Integer.parseInt(index_page)+3%></a></li>
								    <%}else{ %>
								    <li id="t<%=count_page-3%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=<%=count_page-4%>"><%=count_page-3%></a></li>
								    <li id="t<%=count_page-2%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=<%=count_page-3%>"><%=count_page-2%></a></li>
								    <li id="t<%=count_page-1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=<%=count_page-2%>"><%=count_page-1%></a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li id="t<%=count_page%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=<%=count_page-1%>"><%=count_page%></a></li>
								    <li id="t<%=count_page+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=<%=count_page%>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%}else{ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=<%=minus%>">&laquo;</a></li>
								    <%for(int i=0;i<=count_page;i++){ %>
								    <li id="t<%=i+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=<%=i%>"><%=i+1%></a></li>
								    <%} %>
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=1&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%} %>
								</div>
<script type="text/javascript">
<%for(int j=0;j<=count_page;j++){ %>
	if((<%=cailei%>==1)&&(<%=Integer.parseInt(index_page)%>==<%=j%>)){
		$("#t<%=j+1%>").addClass("on"); 
	}
	<%} %>
</script>
						<!--分页内容标签结束-->
			    	</div>
					<%}%>
			    	<%} else if(cailei==2){ %>
			    	<!--板块一部分结束-->
			    	<!--板块二部分开始 开胃凉菜-->
			    	<div class="product-list" >
			    		<ul class="clearfix fmpage" >
			    		<%int q;for(q=0;q<caipinshow.size();q++){ %>
			    			<%if((q!=2)&&(q!=5)&&(q!=8)){ %>
			    			<li>
			    				<a href="front_product-inner.jsp?caiid=<%=caipinshow.get(q).getIntView("productmenuid")%>" target="_blank">
				    				<img src="<%=caipinshow.get(q).getStringView("img1") %>" class="img-responsive">
				    				<div class="txt">
				    					<h4><%=caipinshow.get(q).getStringView("productname") %></h4>
				    					<p><%=caipinshow.get(q).getStringView("productEname") %></p>
				    					<p class="txt-indent"><%=caipinshow.get(q).getStringView("content1") %></p>
				    					<p class="size18"><strong>￥<%=caipinshow.get(q).getIntView("yprice") %>/份</strong></p>
				    				</div>
			    				</a>
			    			</li>
			    			<%}else{ %>
			    			<li class="mr0">
			    				<a href="front_product-inner.jsp?caiid=<%=caipinshow.get(q).getIntView("productmenuid")%>" target="_blank">
				    				<img src="<%=caipinshow.get(q).getStringView("img1") %>" class="img-responsive">
				    				<div class="txt">
				    					<h4><%=caipinshow.get(q).getStringView("productname") %></h4>
				    					<p><%=caipinshow.get(q).getStringView("productEname") %></p>
				    					<p class="txt-indent"><%=caipinshow.get(q).getStringView("content1") %></p>
				    					<p class="size18"><strong>￥<%=caipinshow.get(q).getIntView("yprice") %>/份</strong></p>
				    				</div>
			    				</a>
			    			</li>
			    		<%}} %>
			    		</ul>
			    		<%if(total>9){ %>
			    		<!--分页内容标签开始-->
								<div class="nav-page">
								<%if(count_page>4){ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=minus%>">&laquo;</a></li>
								    <%if(Integer.parseInt(index_page)<3) {%>
								    <li id="t1"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=0">1</a></li>
								    <li id="t2"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=1">2</a></li>
								    <li id="t3"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=2">3</a></li>
								    <%}else if((Integer.parseInt(index_page)>=3)&&(Integer.parseInt(index_page)<(count_page-3))){ %>
								    <li id="t<%=Integer.parseInt(index_page)+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=Integer.parseInt(index_page)%>"><%=Integer.parseInt(index_page)+1%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+2%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=Integer.parseInt(index_page)+1%>"><%=Integer.parseInt(index_page)+2%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+3%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=Integer.parseInt(index_page)+2%>"><%=Integer.parseInt(index_page)+3%></a></li>
								    <%}else{ %>
								    <li id="t<%=count_page-3%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=count_page-4%>"><%=count_page-3%></a></li>
								    <li id="t<%=count_page-2%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=count_page-3%>"><%=count_page-2%></a></li>
								    <li id="t<%=count_page-1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=count_page-2%>"><%=count_page-1%></a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li id="t<%=count_page%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=count_page-1%>"><%=count_page%></a></li>
								    <li id="t<%=count_page+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=count_page%>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%}else{ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=minus%>">&laquo;</a></li>
								    <%for(int i=0;i<=count_page;i++){ %>
								    <li id="t<%=i+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=i%>"><%=i+1%></a></li>
								    <%} %>
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=2&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%} %>
								</div>
<script type="text/javascript">
<%for(int j=0;j<=count_page;j++){ %>
	if((<%=cailei%>==2)&&(<%=Integer.parseInt(index_page)%>==<%=j%>)){
		$("#t<%=j+1%>").addClass("on"); 
	}
	<%} %>
</script>
						<!--分页内容标签结束-->
			    	</div>
			    	<%} %>
			    	<%} else if(cailei==3){ %>
			    	<!--板块二部分结束-->
			    	<!--板块三部分开始 精美热菜-->
			    	<div class="product-list" >
			    		<ul class="clearfix fmpage">
			    		<%int q;for(q=0;q<caipinshow.size();q++){ %>
			    			<%if((q!=2)&&(q!=5)&&(q!=8)){ %>
			    			<li>
			    				<a href="front_product-inner.jsp?caiid=<%=caipinshow.get(q).getIntView("productmenuid")%>" target="_blank">
				    				<img src="<%=caipinshow.get(q).getStringView("img1") %>" class="img-responsive">
				    				<div class="txt">
				    					<h4><%=caipinshow.get(q).getStringView("productname") %></h4>
				    					<p><%=caipinshow.get(q).getStringView("productEname") %></p>
				    					<p class="txt-indent"><%=caipinshow.get(q).getStringView("content1") %></p>
				    					<p class="size18"><strong>￥<%=caipinshow.get(q).getIntView("yprice") %>/份</strong></p>
				    				</div>
			    				</a>
			    			</li>
			    			<%}else{ %>
			    			<li class="mr0">
			    				<a href="front_product-inner.jsp?caiid=<%=caipinshow.get(q).getIntView("productmenuid")%>" target="_blank">
				    				<img src="<%=caipinshow.get(q).getStringView("img1") %>" class="img-responsive">
				    				<div class="txt">
				    					<h4><%=caipinshow.get(q).getStringView("productname") %></h4>
				    					<p><%=caipinshow.get(q).getStringView("productEname") %></p>
				    					<p class="txt-indent"><%=caipinshow.get(q).getStringView("content1") %></p>
				    					<p class="size18"><strong>￥<%=caipinshow.get(q).getIntView("yprice") %>/份</strong></p>
				    				</div>
			    				</a>
			    			</li>
			    		<%}} %>
			    		</ul>
			    		<%if(total>9){ %>
			    		<!--分页内容标签开始-->
								<div class="nav-page">
								<%if(count_page>4){ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=minus%>">&laquo;</a></li>
								    <%if(Integer.parseInt(index_page)<3) {%>
								    <li id="t1"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=0">1</a></li>
								    <li id="t2"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=1">2</a></li>
								    <li id="t3"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=2">3</a></li>
								    <%}else if((Integer.parseInt(index_page)>=3)&&(Integer.parseInt(index_page)<(count_page-3))){ %>
								    <li id="t<%=Integer.parseInt(index_page)+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=<%=Integer.parseInt(index_page)%>"><%=Integer.parseInt(index_page)+1%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+2%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=<%=Integer.parseInt(index_page)+1%>"><%=Integer.parseInt(index_page)+2%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+3%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=<%=Integer.parseInt(index_page)+2%>"><%=Integer.parseInt(index_page)+3%></a></li>
								    <%}else{ %>
								    <li id="t<%=count_page-3%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=<%=count_page-4%>"><%=count_page-3%></a></li>
								    <li id="t<%=count_page-2%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=<%=count_page-3%>"><%=count_page-2%></a></li>
								    <li id="t<%=count_page-1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=<%=count_page-2%>"><%=count_page-1%></a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li id="t<%=count_page%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=<%=count_page-1%>"><%=count_page%></a></li>
								    <li id="t<%=count_page+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=<%=count_page%>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%}else{ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=<%=minus%>">&laquo;</a></li>
								    <%for(int i=0;i<=count_page;i++){ %>
								    <li id="t<%=i+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=<%=i%>"><%=i+1%></a></li>
								    <%} %>
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=3&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%} %>
								</div>
<script type="text/javascript">
<%for(int j=0;j<=count_page;j++){ %>
	if((<%=cailei%>==3)&&(<%=Integer.parseInt(index_page)%>==<%=j%>)){
		$("#t<%=j+1%>").addClass("on"); 
	}
	<%} %>
</script>
						<!--分页内容标签结束-->
			    	</div>
			    	<%} %>
			    	<%} else if(cailei==4){ %>
			    	<!--板块三部分结束-->
			    	<!--板块四部分开始 美味主食-->
			    	<div class="product-list" >
			    		<ul class="clearfix fmpage">
			    		<%int q;for(q=0;q<caipinshow.size();q++){ %>
			    			<%if((q!=2)&&(q!=5)&&(q!=8)){ %>
			    			<li>
			    				<a href="front_product-inner.jsp?caiid=<%=caipinshow.get(q).getIntView("productmenuid")%>" target="_blank">
				    				<img src="<%=caipinshow.get(q).getStringView("img1") %>" class="img-responsive">
				    				<div class="txt">
				    					<h4><%=caipinshow.get(q).getStringView("productname") %></h4>
				    					<p><%=caipinshow.get(q).getStringView("productEname") %></p>
				    					<p class="txt-indent"><%=caipinshow.get(q).getStringView("content1") %></p>
				    					<p class="size18"><strong>￥<%=caipinshow.get(q).getIntView("yprice") %>/份</strong></p>
				    				</div>
			    				</a>
			    			</li>
			    			<%}else{ %>
			    			<li class="mr0">
			    				<a href="front_product-inner.jsp?caiid=<%=caipinshow.get(q).getIntView("productmenuid")%>" target="_blank">
				    				<img src="<%=caipinshow.get(q).getStringView("img1") %>" class="img-responsive">
				    				<div class="txt">
				    					<h4><%=caipinshow.get(q).getStringView("productname") %></h4>
				    					<p><%=caipinshow.get(q).getStringView("productEname") %></p>
				    					<p class="txt-indent"><%=caipinshow.get(q).getStringView("content1") %></p>
				    					<p class="size18"><strong>￥<%=caipinshow.get(q).getIntView("yprice") %>/份</strong></p>
				    				</div>
			    				</a>
			    			</li>
			    		<%}} %>
			    		</ul>
			    		<%if(total>9){ %>
			    		<!--分页内容标签开始-->
								<div class="nav-page">
								<%if(count_page>4){ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=minus%>">&laquo;</a></li>
								    <%if(Integer.parseInt(index_page)<3) {%>
								    <li id="t1"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=0">1</a></li>
								    <li id="t2"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=1">2</a></li>
								    <li id="t3"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=2">3</a></li>
								    <%}else if((Integer.parseInt(index_page)>=3)&&(Integer.parseInt(index_page)<(count_page-3))){ %>
								    <li id="t<%=Integer.parseInt(index_page)+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=Integer.parseInt(index_page)%>"><%=Integer.parseInt(index_page)+1%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+2%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=Integer.parseInt(index_page)+1%>"><%=Integer.parseInt(index_page)+2%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+3%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=Integer.parseInt(index_page)+2%>"><%=Integer.parseInt(index_page)+3%></a></li>
								    <%}else{ %>
								    <li id="t<%=count_page-3%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=count_page-4%>"><%=count_page-3%></a></li>
								    <li id="t<%=count_page-2%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=count_page-3%>"><%=count_page-2%></a></li>
								    <li id="t<%=count_page-1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=count_page-2%>"><%=count_page-1%></a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li id="t<%=count_page%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=count_page-1%>"><%=count_page%></a></li>
								    <li id="t<%=count_page+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=count_page%>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%}else{ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=minus%>">&laquo;</a></li>
								    <%for(int i=0;i<=count_page;i++){ %>
								    <li id="t<%=i+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=i%>"><%=i+1%></a></li>
								    <%} %>
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=4&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%} %>
								</div>
<script type="text/javascript">
<%for(int j=0;j<=count_page;j++){ %>
	if((<%=cailei%>==4)&&(<%=Integer.parseInt(index_page)%>==<%=j%>)){
		$("#t<%=j+1%>").addClass("on"); 
	}
	<%} %>
</script>
						<!--分页内容标签结束-->
			    	</div>
			    	<%} %>
			    	<%} else if(cailei==5){ %>
			    	<!--板块四部分结束-->
			    	<!--板块五部分开始 酒水饮料-->
			    	<div class="product-list" >
			    		<ul class="clearfix fmpage">
			    		<%int q;for(q=0;q<caipinshow.size();q++){ %>
			    			<%if((q!=2)&&(q!=5)&&(q!=8)){ %>
			    			<li>
			    				<a href="front_product-inner.jsp?caiid=<%=caipinshow.get(q).getIntView("productmenuid")%>" target="_blank">
				    				<img src="<%=caipinshow.get(q).getStringView("img1") %>" class="img-responsive">
				    				<div class="txt">
				    					<h4><%=caipinshow.get(q).getStringView("productname") %></h4>
				    					<p><%=caipinshow.get(q).getStringView("productEname") %></p>
				    					<p class="txt-indent"><%=caipinshow.get(q).getStringView("content1") %></p>
				    					<p class="size18"><strong>￥<%=caipinshow.get(q).getIntView("yprice") %>/份</strong></p>
				    				</div>
			    				</a>
			    			</li>
			    			<%}else{ %>
			    			<li class="mr0">
			    				<a href="front_product-inner.jsp?caiid=<%=caipinshow.get(q).getIntView("productmenuid")%>" target="_blank">
				    				<img src="<%=caipinshow.get(q).getStringView("img1") %>" class="img-responsive">
				    				<div class="txt">
				    					<h4><%=caipinshow.get(q).getStringView("productname") %></h4>
				    					<p><%=caipinshow.get(q).getStringView("productEname") %></p>
				    					<p class="txt-indent"><%=caipinshow.get(q).getStringView("content1") %></p>
				    					<p class="size18"><strong>￥<%=caipinshow.get(q).getIntView("yprice") %>/份</strong></p>
				    				</div>
			    				</a>
			    			</li>
			    		<%}} %>
			    		</ul>
			    		<%if(total>9){ %>
			    		<!--分页内容标签开始-->
								<div class="nav-page">
								<%if(count_page>4){ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=minus%>">&laquo;</a></li>
								    <%if(Integer.parseInt(index_page)<3) {%>
								    <li id="t1"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=0">1</a></li>
								    <li id="t2"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=1">2</a></li>
								    <li id="t3"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=2">3</a></li>
								    <%}else if((Integer.parseInt(index_page)>=3)&&(Integer.parseInt(index_page)<(count_page-3))){ %>
								    <li id="t<%=Integer.parseInt(index_page)+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=Integer.parseInt(index_page)%>"><%=Integer.parseInt(index_page)+1%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+2%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=Integer.parseInt(index_page)+1%>"><%=Integer.parseInt(index_page)+2%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+3%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=Integer.parseInt(index_page)+2%>"><%=Integer.parseInt(index_page)+3%></a></li>
								    <%}else{ %>
								    <li id="t<%=count_page-3%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=count_page-4%>"><%=count_page-3%></a></li>
								    <li id="t<%=count_page-2%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=count_page-3%>"><%=count_page-2%></a></li>
								    <li id="t<%=count_page-1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=count_page-2%>"><%=count_page-1%></a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li id="t<%=count_page%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=count_page-1%>"><%=count_page%></a></li>
								    <li id="t<%=count_page+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=count_page%>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%}else{ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=minus%>">&laquo;</a></li>
								    <%for(int i=0;i<=count_page;i++){ %>
								    <li id="t<%=i+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=i%>"><%=i+1%></a></li>
								    <%} %>
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=5&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%} %>
								</div>
<script type="text/javascript">
<%for(int j=0;j<=count_page;j++){ %>
	if((<%=cailei%>==5)&&(<%=Integer.parseInt(index_page)%>==<%=j%>)){
		$("#t<%=j+1%>").addClass("on"); 
	}
	<%} %>
</script>
						<!--分页内容标签结束-->
			    	</div>
			    	<%} %>
			    	<%} else if(cailei==6){ %>
			    	<!--板块五部分结束-->
			    	<!--板块六部分开始  店长推荐-->
			    	<div class="product-list" >
			    		<ul class="clearfix fmpage">
			    		<%int q;for(q=0;q<caipinshow.size();q++){ %>
			    			<%if((q!=2)&&(q!=5)&&(q!=8)){ %>
			    			<li>
			    				<a href="front_product-inner.jsp?caiid=<%=caipinshow.get(q).getIntView("productmenuid")%>" target="_blank">
				    				<img src="<%=caipinshow.get(q).getStringView("img1") %>" class="img-responsive">
				    				<div class="txt">
				    					<h4><%=caipinshow.get(q).getStringView("productname") %></h4>
				    					<p><%=caipinshow.get(q).getStringView("productEname") %></p>
				    					<p class="txt-indent"><%=caipinshow.get(q).getStringView("content1") %></p>
				    					<p class="size18"><strong>￥<%=caipinshow.get(q).getIntView("yprice") %>/份</strong></p>
				    				</div>
			    				</a>
			    			</li>
			    			<%}else{ %>
			    			<li class="mr0">
			    				<a href="front_product-inner.jsp?caiid=<%=caipinshow.get(q).getIntView("productmenuid")%>" target="_blank">
				    				<img src="<%=caipinshow.get(q).getStringView("img1") %>" class="img-responsive">
				    				<div class="txt">
				    					<h4><%=caipinshow.get(q).getStringView("productname") %></h4>
				    					<p><%=caipinshow.get(q).getStringView("productEname") %></p>
				    					<p class="txt-indent"><%=caipinshow.get(q).getStringView("content1") %></p>
				    					<p class="size18"><strong >￥<%=caipinshow.get(q).getIntView("yprice") %>/份</strong></p>
				    				</div>
			    				</a>
			    			</li>
			    		<%}} %>
			    		</ul>
			    		<!--分页内容标签开始-->
								<div class="nav-page">
								<%if(count_page>4){ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=minus%>">&laquo;</a></li>
								    <%if(Integer.parseInt(index_page)<3) {%>
								    <li id="t1"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=0">1</a></li>
								    <li id="t2"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=1">2</a></li>
								    <li id="t3"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=2">3</a></li>
								    <%}else if((Integer.parseInt(index_page)>=3)&&(Integer.parseInt(index_page)<(count_page-3))){ %>
								    <li id="t<%=Integer.parseInt(index_page)+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=Integer.parseInt(index_page)%>"><%=Integer.parseInt(index_page)+1%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+2%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=Integer.parseInt(index_page)+1%>"><%=Integer.parseInt(index_page)+2%></a></li>
								    <li id="t<%=Integer.parseInt(index_page)+3%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=Integer.parseInt(index_page)+2%>"><%=Integer.parseInt(index_page)+3%></a></li>
								    <%}else{ %>
								    <li id="t<%=count_page-3%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=count_page-4%>"><%=count_page-3%></a></li>
								    <li id="t<%=count_page-2%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=count_page-3%>"><%=count_page-2%></a></li>
								    <li id="t<%=count_page-1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=count_page-2%>"><%=count_page-1%></a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li id="t<%=count_page%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=count_page-1%>"><%=count_page%></a></li>
								    <li id="t<%=count_page+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=count_page%>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%}else{ %>
								  <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=minus%>">&laquo;</a></li>
								    <%for(int i=0;i<=count_page;i++){ %>
								    <li id="t<%=i+1%>"><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=i%>"><%=i+1%></a></li>
								    <%} %>
								    <li><a href="${pageContext.request.contextPath}/front_product.jsp?cailei=6&page=<%=plus%>">&raquo;</a></li>
								  </ul>
								  <%} %>
								</div>
<script type="text/javascript">
<%for(int j=0;j<=count_page;j++){ %>
	if((<%=cailei%>==6)&&(<%=Integer.parseInt(index_page)%>==<%=j%>)){
		$("#t<%=j+1%>").addClass("on"); 
	}
	<%} %>
</script>
						<!--分页内容标签结束-->
			    	</div>
			    	<%} %>
			    	<!--板块六部分结束-->
			    </div>
         	</div>
         </div>  
       </div>  
        <!--博客主体内容结束-->
        <!--页面底部板块开始-->
        <div>
		<%@ include file="footer.jsp"%>
		</div>
        <!--页面底部板块结束-->
	</body>
	<!--主内容区左边标题导航tab切换js-->
	<script>
	//$(function(){
	//var $div_li=$('.title-nav .title-nav-item');
	//$div_li.click(function(){
		//$(this).addClass('active').siblings().removeClass('active');
		//var index =$div_li.index(this);
		//$('.course-slide >div').eq(index).show().siblings().hide();
		//});	
	//});
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
<!--菜品介绍浮动层JS脚本开始-->
			<script>
            $(".product-list ul li").hover(function(){
                $(this).find(".txt").stop().animate({height:"100%"},400);
                $(this).find(".txt h4").stop().animate({paddingTop:"30px"},400);
            },function(){
                $(this).find(".txt").stop().animate({height:"40px"},400);
                $(this).find(".txt h4").stop().animate({paddingTop:"0px"},400);
            })
            </script>
            <!--菜品浮动层JS脚本end-->

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
		        $("body,html").stop().animate({"scrollTop":0},1000);//一秒钟时间回到顶部
		    });
      })
	</script>
<!--百度分享js-->
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"1","bdSize":"18"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
</html>
