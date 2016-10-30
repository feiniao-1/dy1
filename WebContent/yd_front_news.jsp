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
int page_ye=Integer.parseInt(index_page)*5;
//搜索属性
String searchtj;

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
		<meta name="description" content="饺耳世家">
		<meta name="keywords" content="饺耳世家、美食">
		<title>饺耳新闻资讯</title>
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
				<p>饺耳新闻</p>
				<a href="yd_front_index.jsp" class="back02"><img src="images/back.png"></a>
			</div>
			<!--产品列表部分开始-->
			<div class="news news-list">
				<!--标题部分-->
				<div class="title-nav clearfix">
							<div class="title-nav-item active">推荐</div>
							<div class="title-nav-item">热门</div>
							<div class="title-nav-item">美食</div>
							<div class="title-nav-item">科技</div>
							<div class="title-nav-item">娱乐</div>
			    </div>
			    <!--内容部分开始-->
			    <div class="course-slide">
			    <!-- 推荐 -->
			    	<div class="news-type">
			    		<% List<Mapx<String,Object>> tuijian=DB.getRunner().query("select img1,subString(title,1,10) as title,author,subString(createtime,1,19) as createtime ,articleid,tagid from article where del=? order by zcount desc limit 30", new MapxListHandler(),"0");
			    		List<Mapx<String,Object>> count1=DB.getRunner().query("select count(1)  as count from article where del=? ", new MapxListHandler(),"0");
			    		int max1;
			    		if(Integer.parseInt(count1.get(0).getIntView("count"))<10){
			    			max1=Integer.parseInt(count1.get(0).getIntView("count"));
			    		}else{
			    			max1=10;
			    		}
			    		for(int i=0;i<max1;i++){
			    			//获取文章作者
							List<Mapx<String, Object>> authorxx1= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),tuijian.get(i).getIntView("author"));
			    		%>
	            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=tuijian.get(i).getIntView("tagid") %>">
	            		<div class="cell bg-white">
		            			<div class="news-pic">
		            				<img src="<%=tuijian.get(i).getStringView("img1")%>">
		            			</div>
		            			<div class="cell_primary">
		            				<h4 class="line2"><%=tuijian.get(i).getStringView("title")%></h4>
		            				<p class="color-999999"><%=authorxx1.get(0).getStringView("username") %><span>|</span><%=tuijian.get(i).getStringView("createtime")%></p>
		            			</div>
	            		</div>
	            		</a><%} %>
	            		<!--加载更多 模块一 start  -->
	            		<%if(Integer.parseInt(count1.get(0).getIntView("count"))>10){ %>
	   					<div id="box01" style="DISPLAY: none" style="behavior:url(#default#savehistory)">
						<% 
			    		int max11;
			    		if(Integer.parseInt(count1.get(0).getIntView("count"))<20){
			    			max11=Integer.parseInt(count1.get(0).getIntView("count"));
			    		}else{
			    			max11=20;
			    		}
			    		for(int i=10;i<max11;i++){
			    			//获取文章作者
							List<Mapx<String, Object>> authorxx11= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),tuijian.get(i).getIntView("author"));
			    		%>
	            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=tuijian.get(i).getIntView("tagid") %>">
	            		<div class="cell bg-white">
		            			<div class="news-pic">
		            				<img src="<%=tuijian.get(i).getStringView("img1")%>">
		            			</div>
		            			<div class="cell_primary">
		            				<h4 class="line2"><%=tuijian.get(i).getStringView("title")%></h4>
		            				<p class="color-999999"><%=authorxx11.get(0).getStringView("username") %><span>|</span><%=tuijian.get(i).getStringView("createtime")%></p>
		            			</div>
	            		</div>
	            		</a><%} %>
	            		<!--加载更多 模块二 start  -->
	            				<%if(Integer.parseInt(count1.get(0).getIntView("count"))>20){ %>
			            		<div id="box02" style="DISPLAY: none" style="behavior:url(#default#savehistory)">
								<% int max12;
					    		if(Integer.parseInt(count1.get(0).getIntView("count"))<30){
					    			max12=Integer.parseInt(count1.get(0).getIntView("count"));
					    		}else{
					    			max12=30;
					    		}
					    		for(int i=20;i<max12;i++){
					    			//获取文章作者
									List<Mapx<String, Object>> authorxx12= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),tuijian.get(i).getIntView("author"));
					    		%>
			            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=tuijian.get(i).getIntView("tagid") %>">
			            		<div class="cell bg-white">
				            			<div class="news-pic">
				            				<img src="<%=tuijian.get(i).getStringView("img1")%>">
				            			</div>
				            			<div class="cell_primary">
				            				<h4 class="line2"><%=tuijian.get(i).getStringView("title")%></h4>
				            				<p class="color-999999"><%=authorxx12.get(0).getStringView("username") %><span>|</span><%=tuijian.get(i).getStringView("createtime")%></p>
				            			</div>
			            		</div>
			            		</a><%} %>
				            		<a href="javascript:void(0)" onclick="yincang()"><div class="load-more" style="background:#F0F0F0"><span style="color:white;font-size:18px;">已经到底了</span></div></a>
				            		 <script type="text/javascript">
				            		 function yincang(){
				            			//将更多加载出的数据隐藏
				            		 $("#box01").css('display','none'); 
				            		 $("#box02").css('display','none'); 
				            		 }
				            		 </script>
				    			</div>
				   			    <div class="load-more" ><a  style="behavior:url(#default#savehistory);" onclick="openShutManager(this,'box02',false,' ','点击加载更多...')" href="###"><span style="color:white;font-size:18px;">加载更多+</span></a></div>
				   			    <!--加载更多 模块二 end  -->
				   			    <%} %>
		    			</div>
		   			    <div class="load-more" ><a  style="behavior:url(#default#savehistory);" onclick="openShutManager(this,'box01',false,' ','点击加载更多...')" href="###"><span style="color:white;font-size:18px;">加载更多+</span></a></div>
		   			   <!--加载更多 模块一end -->
		   			   <%} %>
	            		<!--<div class="load-more">加载更多+</div>  by chenhui-->
					   	<!--点击加载更多JS-->
						<script>
						//  by chenhui
							//$(function(e){
							//	var txt1="<a href=''><div class='cell bg-white'><div class='menu-pic'><img src='images/b01_03.jpg'></div><div class='cell_primary'><h4>aaa</h4><p class='color-999999'>Tomato and egg boiled dumplings</p><p class='color-666666 mb5'>月售799<span class='ml10'></span></p><p><span class='color-dd2727 size16'>￥30</span><del class='color-666666 ml10'>38</del></p></div></div></a>"
							//	$(".load-more").click(function(){
							//		$(this).before(txt1);
							//	})
							//})
						</script>
			    	</div>
			    	<!-- 热门-->
			    	<div class="news-type" style="display: none;">
	            		<% List<Mapx<String,Object>> remen=DB.getRunner().query("select img1,subString(title,1,10) as title,author,subString(createtime,1,19) as createtime ,articleid ,tagid from article where del=? and articletype=? order by articleid desc limit 30", new MapxListHandler(),"0","热门");
			    		List<Mapx<String,Object>> count2=DB.getRunner().query("select count(1)  as count from article where del=? and articletype=? ", new MapxListHandler(),"0","热门");
			    		int max2;
			    		if(Integer.parseInt(count2.get(0).getIntView("count"))<10){
			    			max2=Integer.parseInt(count2.get(0).getIntView("count"));
			    		}else{
			    			max2=10;
			    		}
			    		for(int i=0;i<max2;i++){
			    			//获取文章作者
							List<Mapx<String, Object>> authorxx2= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),remen.get(i).getIntView("author"));
			    		%>
	            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=remen.get(i).getIntView("tagid") %>">
	            		<div class="cell bg-white">
		            			<div class="news-pic">
		            				<img src="<%=remen.get(i).getStringView("img1")%>">
		            			</div>
		            			<div class="cell_primary">
		            				<h4 class="line2"><%=remen.get(i).getStringView("title")%></h4>
		            				<p class="color-999999"><%=authorxx2.get(0).getStringView("username") %><span>|</span><%=remen.get(i).getStringView("createtime")%></p>
		            			</div>
	            		</div>
	            		</a><%} %>
	            		<%if(Integer.parseInt(count2.get(0).getIntView("count"))>10){ %>
	            		<!--加载更多 模块一 start  -->
	   					<div id="box11" style="DISPLAY: none" style="behavior:url(#default#savehistory)">
						<% 	int max21;
			    		if(Integer.parseInt(count2.get(0).getIntView("count"))<20){
			    			max21=Integer.parseInt(count2.get(0).getIntView("count"));
			    		}else{
			    			max21=20;
			    		}
			    		for(int i=10;i<max21;i++){
			    			//获取文章作者
							List<Mapx<String, Object>> authorxx21= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),remen.get(i).getIntView("author"));
			    		%>
	            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=remen.get(i).getIntView("tagid") %>">
	            		<div class="cell bg-white">
		            			<div class="news-pic">
		            				<img src="<%=remen.get(i).getStringView("img1")%>">
		            			</div>
		            			<div class="cell_primary">
		            				<h4 class="line2"><%=remen.get(i).getStringView("title")%></h4>
		            				<p class="color-999999"><%=authorxx21.get(0).getStringView("username") %><span>|</span><%=remen.get(i).getStringView("createtime")%></p>
		            			</div>
	            		</div>
	            		</a><%} %>
	            		<%if(Integer.parseInt(count2.get(0).getIntView("count"))>20){ %>
	            				<!--加载更多 模块二 start  -->
			            		<div id="box12" style="DISPLAY: none" style="behavior:url(#default#savehistory)">
								<% 	int max22;
					    		if(Integer.parseInt(count2.get(0).getIntView("count"))<30){
					    			max22=Integer.parseInt(count2.get(0).getIntView("count"));
					    		}else{
					    			max22=30;
					    		}
					    		for(int i=20;i<max22;i++){
					    			//获取文章作者
									List<Mapx<String, Object>> authorxx22= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),remen.get(i).getIntView("author"));
					    		%>
			            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=remen.get(i).getIntView("tagid") %>">
			            		<div class="cell bg-white">
				            			<div class="news-pic">
				            				<img src="<%=remen.get(i).getStringView("img1")%>">
				            			</div>
				            			<div class="cell_primary">
				            				<h4 class="line2"><%=remen.get(i).getStringView("title")%></h4>
				            				<p class="color-999999"><%=authorxx22.get(0).getStringView("username") %><span>|</span><%=remen.get(i).getStringView("createtime")%></p>
				            			</div>
			            		</div>
			            		</a><%} %>
				            		<a href="javascript:void(0)" onclick="yincang1()"><div class="load-more" style="background:#F0F0F0"><span style="color:white;font-size:18px;">已经到底了</span></div></a>
				            		 <script type="text/javascript">
				            		 function yincang1(){
				            			//将更多加载出的数据隐藏
				            		 $("#box11").css('display','none'); 
				            		 $("#box12").css('display','none'); 
				            		 }
				            		 </script>
				    			</div>
				   			    <div class="load-more" ><a  style="behavior:url(#default#savehistory);" onclick="openShutManager(this,'box12',false,' ','点击加载更多...')" href="###"><span style="color:white;font-size:18px;">加载更多+</span></a></div>
				   			    <!--加载更多 模块二 end  -->
				   			    <%} %>
		    			</div>
		   			    <div class="load-more" ><a  style="behavior:url(#default#savehistory);" onclick="openShutManager(this,'box11',false,' ','点击加载更多...')" href="###"><span style="color:white;font-size:18px;">加载更多+</span></a></div>
		   			   <!--加载更多 模块一end -->
		   			   <%} %>
			    	</div>
			    	<!-- 美食 -->
			    	<div class="news-type" style="display: none;">
	            		<% List<Mapx<String,Object>> meishi=DB.getRunner().query("select img1,subString(title,1,10) as title,author,subString(createtime,1,19) as createtime ,articleid,tagid from article where del=? and articletype=? order by articleid desc limit 30", new MapxListHandler(),"0","美食");
			    		List<Mapx<String,Object>> count3=DB.getRunner().query("select count(1)  as count from article where del=? and articletype=? ", new MapxListHandler(),"0","美食");
			    		int max3;
			    		if(Integer.parseInt(count3.get(0).getIntView("count"))<10){
			    			max3=Integer.parseInt(count3.get(0).getIntView("count"));
			    		}else{
			    			max3=10;
			    		}
			    		for(int i=0;i<max3;i++){
			    			//获取文章作者
							List<Mapx<String, Object>> authorxx3= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),meishi.get(i).getIntView("author"));
			    		%>
	            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=meishi.get(i).getIntView("tagid") %>">
	            		<div class="cell bg-white">
		            			<div class="news-pic">
		            				<img src="<%=meishi.get(i).getStringView("img1")%>">
		            			</div>
		            			<div class="cell_primary">
		            				<h4 class="line2"><%=meishi.get(i).getStringView("title")%></h4>
		            				<p class="color-999999"><%=authorxx3.get(0).getStringView("username") %><span>|</span><%=meishi.get(i).getStringView("createtime")%></p>
		            			</div>
	            		</div>
	            		</a><%} %>
	            		<%if(Integer.parseInt(count3.get(0).getIntView("count"))>10){ %>
	            		<!--加载更多 模块一 start  -->
	   					<div id="box21" style="DISPLAY: none" style="behavior:url(#default#savehistory)">
						<% 	int max31;
			    		if(Integer.parseInt(count3.get(0).getIntView("count"))<20){
			    			max31=Integer.parseInt(count3.get(0).getIntView("count"));
			    		}else{
			    			max31=20;
			    		}
			    		for(int i=10;i<max31;i++){
			    			//获取文章作者
							List<Mapx<String, Object>> authorxx31= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),meishi.get(i).getIntView("author"));
			    		%>
	            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=meishi.get(i).getIntView("tagid") %>">
	            		<div class="cell bg-white">
		            			<div class="news-pic">
		            				<img src="<%=meishi.get(i).getStringView("img1")%>">
		            			</div>
		            			<div class="cell_primary">
		            				<h4 class="line2"><%=meishi.get(i).getStringView("title")%></h4>
		            				<p class="color-999999"><%=authorxx31.get(0).getStringView("username") %><span>|</span><%=meishi.get(i).getStringView("createtime")%></p>
		            			</div>
	            		</div>
	            		</a><%} %>
	            		<%if(Integer.parseInt(count3.get(0).getIntView("count"))>20){ %>
	            				<!--加载更多 模块二 start  -->
			            		<div id="box22" style="DISPLAY: none" style="behavior:url(#default#savehistory)">
								<% 	int max32;
					    		if(Integer.parseInt(count3.get(0).getIntView("count"))<30){
					    			max32=Integer.parseInt(count3.get(0).getIntView("count"));
					    		}else{
					    			max32=30;
					    		}
					    		for(int i=20;i<max32;i++){
					    			//获取文章作者
									List<Mapx<String, Object>> authorxx32= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),meishi.get(i).getIntView("author"));
					    		%>
			            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=meishi.get(i).getIntView("tagid") %>">
			            		<div class="cell bg-white">
				            			<div class="news-pic">
				            				<img src="<%=meishi.get(i).getStringView("img1")%>">
				            			</div>
				            			<div class="cell_primary">
				            				<h4 class="line2"><%=meishi.get(i).getStringView("title")%></h4>
				            				<p class="color-999999"><%=authorxx32.get(0).getStringView("username") %><span>|</span><%=meishi.get(i).getStringView("createtime")%></p>
				            			</div>
			            		</div>
			            		</a><%} %>
				            		<a href="javascript:void(0)" onclick="yincang2()"><div class="load-more" style="background:#F0F0F0"><span style="color:white;font-size:18px;">已经到底了</span></div></a>
				            		 <script type="text/javascript">
				            		 //将更多加载出的数据隐藏
				            		 function yincang2(){
				            		 $("#box21").css('display','none'); 
				            		 $("#box22").css('display','none'); 
				            		 }
				            		 </script>
				    			</div>
				   			    <div class="load-more" ><a  style="behavior:url(#default#savehistory);" onclick="openShutManager(this,'box22',false,' ','点击加载更多...')" href="###"><span style="color:white;font-size:18px;">加载更多+</span></a></div>
				   			    <!--加载更多 模块二 end  -->
				   			    <%} %>
		    			</div>
		   			    <div class="load-more" ><a  style="behavior:url(#default#savehistory);" onclick="openShutManager(this,'box21',false,' ','点击加载更多...')" href="###"><span style="color:white;font-size:18px;">加载更多+</span></a></div>
		   			   <!--加载更多 模块一end --><%} %>
			    	</div>
			    	<!-- 科技 -->
			    	<div class="news-type" style="display: none;">
	            		<% List<Mapx<String,Object>> tiyu=DB.getRunner().query("select img1,subString(title,1,10) as title,author,subString(createtime,1,19) as createtime ,articleid,tagid from article where del=? and articletype=? order by articleid desc limit 30", new MapxListHandler(),"0","科技");
			    		List<Mapx<String,Object>> count4=DB.getRunner().query("select count(1)  as count from article where del=? and articletype=? ", new MapxListHandler(),"0","科技");
			    		int max4;
			    		if(Integer.parseInt(count4.get(0).getIntView("count"))<10){
			    			max4=Integer.parseInt(count4.get(0).getIntView("count"));
			    		}else{
			    			max4=10;
			    		}
			    		for(int i=0;i<max4;i++){
			    			//获取文章作者
							List<Mapx<String, Object>> authorxx4= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),tiyu.get(i).getIntView("author"));
			    		%>
	            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=tiyu.get(i).getIntView("tagid") %>">
	            		<div class="cell bg-white">
		            			<div class="news-pic">
		            				<img src="<%=tiyu.get(i).getStringView("img1")%>">
		            			</div>
		            			<div class="cell_primary">
		            				<h4 class="line2"><%=tiyu.get(i).getStringView("title")%></h4>
		            				<p class="color-999999"><%=authorxx4.get(0).getStringView("username") %><span>|</span><%=tiyu.get(i).getStringView("createtime")%></p>
		            			</div>
	            		</div>
	            		</a><%} %>
	            		<%if(Integer.parseInt(count4.get(0).getIntView("count"))>10){ %>
	            		<!--加载更多 模块一 start  -->
	   					<div id="box31" style="DISPLAY: none" style="behavior:url(#default#savehistory)">
						<%	int max41;
			    		if(Integer.parseInt(count4.get(0).getIntView("count"))<20){
			    			max41=Integer.parseInt(count4.get(0).getIntView("count"));
			    		}else{
			    			max41=20;
			    		}
			    		for(int i=10;i<max41;i++){
			    			//获取文章作者
							List<Mapx<String, Object>> authorxx41= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),tiyu.get(i).getIntView("author"));
			    		%>
	            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=tiyu.get(i).getIntView("tagid") %>">
	            		<div class="cell bg-white">
		            			<div class="news-pic">
		            				<img src="<%=tiyu.get(i).getStringView("img1")%>">
		            			</div>
		            			<div class="cell_primary">
		            				<h4 class="line2"><%=tiyu.get(i).getStringView("title")%></h4>
		            				<p class="color-999999"><%=authorxx41.get(0).getStringView("username") %><span>|</span><%=tiyu.get(i).getStringView("createtime")%></p>
		            			</div>
	            		</div>
	            		</a><%} %>
	            		<%if(Integer.parseInt(count4.get(0).getIntView("count"))>20){ %>
	            				<!--加载更多 模块二 start  -->
			            		<div id="box32" style="DISPLAY: none" style="behavior:url(#default#savehistory)">
								<% 	int max42;
					    		if(Integer.parseInt(count4.get(0).getIntView("count"))<30){
					    			max42=Integer.parseInt(count4.get(0).getIntView("count"));
					    		}else{
					    			max42=30;
					    		}
					    		for(int i=20;i<max42;i++){
					    			//获取文章作者
									List<Mapx<String, Object>> authorxx42= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),tiyu.get(i).getIntView("author"));
					    		%>
			            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=tiyu.get(i).getIntView("tagid") %>">
			            		<div class="cell bg-white">
				            			<div class="news-pic">
				            				<img src="<%=tiyu.get(i).getStringView("img1")%>">
				            			</div>
				            			<div class="cell_primary">
				            				<h4 class="line2"><%=tiyu.get(i).getStringView("title")%></h4>
				            				<p class="color-999999"><%=authorxx42.get(0).getStringView("username") %><span>|</span><%=tiyu.get(i).getStringView("createtime")%></p>
				            			</div>
			            		</div>
			            		</a><%} %>
				            		<a href="javascript:void(0)" onclick="yincang3()"><div class="load-more" style="background:#F0F0F0"><span style="color:white;font-size:18px;">已经到底了</span></div></a>
				            		 <script type="text/javascript">
				            		 //将更多加载出的数据隐藏
				            		 function yincang3(){
				            		 $("#box31").css('display','none'); 
				            		 $("#box32").css('display','none'); 
				            		 }
				            		 </script>
				    			</div>
				   			    <div class="load-more" ><a  style="behavior:url(#default#savehistory);" onclick="openShutManager(this,'box32',false,' ','点击加载更多...')" href="###"><span style="color:white;font-size:18px;">加载更多+</span></a></div>
				   			    <!--加载更多 模块二 end  -->
				   			    <%} %>
		    			</div>
		   			    <div class="load-more" ><a  style="behavior:url(#default#savehistory);" onclick="openShutManager(this,'box31',false,' ','点击加载更多...')" href="###"><span style="color:white;font-size:18px;">加载更多+</span></a></div>
		   			   <!--加载更多 模块一end -->
		   			   <%} %>
			    	</div>
			    	<!-- 娱乐-->
			    	<div class="news-type" style="display: none;">
			    		<% List<Mapx<String,Object>> yule=DB.getRunner().query("select img1,subString(title,1,10) as title,author,subString(createtime,1,19) as createtime ,articleid,tagid from article where del=? and articletype=? order by articleid desc limit 30", new MapxListHandler(),"0","娱乐");
			    		List<Mapx<String,Object>> count5=DB.getRunner().query("select count(1)  as count from article where del=? and articletype=? ", new MapxListHandler(),"0","娱乐");
			    		int max5;
			    		if(Integer.parseInt(count5.get(0).getIntView("count"))<10){
			    			max5=Integer.parseInt(count5.get(0).getIntView("count"));
			    		}else{
			    			max5=10;
			    		}
			    		for(int i=0;i<max5;i++){
			    			//获取文章作者
							List<Mapx<String, Object>> authorxx5= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),yule.get(i).getIntView("author"));
			    		%>
	            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=yule.get(i).getIntView("tagid") %>">
	            		<div class="cell bg-white">
		            			<div class="news-pic">
		            				<img src="<%=yule.get(i).getStringView("img1")%>">
		            			</div>
		            			<div class="cell_primary">
		            				<h4 class="line2"><%=yule.get(i).getStringView("title")%></h4>
		            				<p class="color-999999"><%=authorxx5.get(0).getStringView("username") %><span>|</span><%=yule.get(i).getStringView("createtime")%></p>
		            			</div>
	            		</div>
	            		</a><%} %>
	            		<%if(Integer.parseInt(count5.get(0).getIntView("count"))>10){ %>
	            		<!--加载更多 模块一 start  -->
	   					<div id="box41" style="DISPLAY: none" style="behavior:url(#default#savehistory)">
						<% 	int max51;
			    		if(Integer.parseInt(count5.get(0).getIntView("count"))<20){
			    			max51=Integer.parseInt(count5.get(0).getIntView("count"));
			    		}else{
			    			max51=20;
			    		}
			    		for(int i=10;i<max51;i++){
			    			//获取文章作者
							List<Mapx<String, Object>> authorxx51= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),yule.get(i).getIntView("author"));
			    		%>
	            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=yule.get(i).getIntView("tagid") %>">
	            		<div class="cell bg-white">
		            			<div class="news-pic">
		            				<img src="<%=yule.get(i).getStringView("img1")%>">
		            			</div>
		            			<div class="cell_primary">
		            				<h4 class="line2"><%=yule.get(i).getStringView("title")%></h4>
		            				<p class="color-999999"><%=authorxx51.get(0).getStringView("username") %><span>|</span><%=yule.get(i).getStringView("createtime")%></p>
		            			</div>
	            		</div>
	            		</a><%} %>
	            		<%if(Integer.parseInt(count5.get(0).getIntView("count"))>20){ %>
	            				<!--加载更多 模块二 start  -->
			            		<div id="box42" style="DISPLAY: none" style="behavior:url(#default#savehistory)">
								<% 	int max52;
					    		if(Integer.parseInt(count5.get(0).getIntView("count"))<30){
					    			max52=Integer.parseInt(count5.get(0).getIntView("count"));
					    		}else{
					    			max52=30;
					    		}
					    		for(int i=20;i<max52;i++){
					    			//获取文章作者
									List<Mapx<String, Object>> authorxx52= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),yule.get(i).getIntView("author"));
					    		%>
			            		<a href="yd_front_news_inner.jsp??page=0&tagid=<%=yule.get(i).getIntView("tagid") %>">
			            		<div class="cell bg-white">
				            			<div class="news-pic">
				            				<img src="<%=yule.get(i).getStringView("img1")%>">
				            			</div>
				            			<div class="cell_primary">
				            				<h4 class="line2"><%=yule.get(i).getStringView("title")%></h4>
				            				<p class="color-999999"><%=authorxx52.get(0).getStringView("username") %><span>|</span><%=yule.get(i).getStringView("createtime")%></p>
				            			</div>
			            		</div>
			            		</a><%} %>
				            		<a href="javascript:void(0)" onclick="yincang4()"><div class="load-more" style="background:#F0F0F0"><span style="color:white;font-size:18px;">已经到底了</span></div></a>
				            		 <script type="text/javascript">
				            		 //将更多加载出的数据隐藏
				            		 function yincang4(){
				            		 $("#box41").css('display','none'); 
				            		 $("#box42").css('display','none'); 
				            		 }
				            		 </script>
				    			</div>
				   			    <div class="load-more" ><a  style="behavior:url(#default#savehistory);" onclick="openShutManager(this,'box42',false,' ','点击加载更多...')" href="###"><span style="color:white;font-size:18px;">加载更多+</span></a></div>
				   			    <!--加载更多 模块二 end  -->
				   			    <%} %>
		    			</div>
		   			    <div class="load-more" ><a  style="behavior:url(#default#savehistory);" onclick="openShutManager(this,'box41',false,' ','点击加载更多...')" href="###"><span style="color:white;font-size:18px;">加载更多+</span></a></div>
		   			   <!--加载更多 模块一end -->
		   			   <%} %>
			    	</div>
			    </div>
			</div>
			<!--返回顶部按钮-->
			<div id="topcontrol" style="display:none; position: fixed; bottom:180px; right: 0px; cursor: pointer; z-index: 119;" title="返回顶部">
			<img style="width:36px; height:40px;" src="images/gotop.png">
		    </div>
		</div>
		<!--菜品切换js-->
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
 <script type="text/javascript">
//加载更多  --by chang start
function openShutManager(oSourceObj,oTargetObj,shutAble,oOpenTip,oShutTip){
	var sourceObj = typeof oSourceObj == "string" ? document.getElementById(oSourceObj) : oSourceObj;
	var targetObj = typeof oTargetObj == "string" ? document.getElementById(oTargetObj) : oTargetObj;
	var openTip = oOpenTip || "";
	var shutTip = oShutTip || "";
	if(targetObj.style.display!="none"){
	if(shutAble) return;
	targetObj.style.display="none";
	if(openTip && shutTip){
	sourceObj.innerHTML = shutTip; 
	}
	} else {
	targetObj.style.display="block";
	if(openTip && shutTip){
	sourceObj.innerHTML = openTip; 
	}
	}
	}
var temp = 1;
var curIndex = 0;
var total = 0;
$(function($){    
	TouchSlide({ 
		slideCell:"#slideBox",
		titCell:".hd ul", //开启自动分页 autoPage:true ，此时设置 titCell 为导航元素包裹层
		mainCell:".bd ul", 
		effect:"leftLoop", 
		autoPage:true,//自动分页
		autoPlay:true //自动播放
	});
	
	var topAd=getCookie("topAd");
    if(topAd=="" || topAd == undefined){
    	$(".topAd").show();
    }else{
    	$(".topAd").hide();
    }
	//顶部banner
	$(".topAd i").bind('click',function(){
		$(".topAd").animate({height:0},1000);
		setCookie("topAd","1", 7);
	});
	
	//var titleWidh = $(window).width();
	//$('.recoTitle').css("width",titleWidh);
	
	//搜索框
	var headW = $(".mainBody").width();
	var searW = headW-155;
	var adTopH = $(".topAd").height();
		seachIpt = $('.searBtn');
		gotoBack = $('.gotoBack');
		
	$('#header').css("width",headW-20);
	$('.searchForm').css("width",searW);
	$(".topAd").css("height",adTopH);	
	//掌上秒拍
	getms(1,1);
	//专属推荐
	getzxs(1);
	//掌上秒杀倒计时
	timeChange();
	var countPage=1;
	//滚动到底部加载
	
		window.onscroll = function(){
			var sw = getScrollTop() + getWindowHeight();
			var sh = getScrollHeight();
// 			if(Math.ceil(sw) == sh || Math.floor(sw) == sh){
			if((sh >= (Math.floor(sw)-30)) && (sh <= (Math.ceil(sw)+30))){
				//加载区域
				if(total==0){
					return;	
				}
				
				if(total > curIndex){				
					if((total-curIndex)<=10){
						$('.refresh').hide();	
					}
					temp++;
					getzxs(temp);
						
				}else{
					$('.refresh').hide();
					$(".noMore").show();
					var time =2;
					var i=null;
					
					function getTimer(){
						time--;
						if(time==0){
						clearInterval(i);
						$(".noMore").addClass("noMoreHover");
						time=2;
						}
						
					}
					i=setInterval(getTimer,1000);
				}
				
				
			}
		};		
	
	
	

	$(".picHeight").each(function(){
		var picWidth = $(this).width();
		$(this).find("img").css("height",picWidth);

	});

});
//加载更多 by chang end

</script>
	</body>
</html>
