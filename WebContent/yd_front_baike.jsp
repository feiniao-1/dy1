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
		<link href="images/top-icon.png" type="image/x-icon" rel="shortcut icon" />
		<title>饺耳百科</title>
		<link href="css/m-style.css" rel="stylesheet">
		<script src="js/jquery-1.11.1.min.js"></script>
		<style>
		html,body{background: #F0F0F0; width: 100%; height: 100%;}
		</style>
	</head>
	<body>
		<div class="container">
			<div class="head head-rel">
				<p>饺耳百科</p>
				<a href="yd_front_index.jsp" class="back02"><img src="images/back.png"></a>
			</div>
			<!--百科列表开始-->
			<div class="baike baike-list">
				<div class="baike-list-plate baike-plate">
					<a href="">
		            	<div class="cell bg-white">
			            			<div class="cover-pic">
			            				<img src="images/bk01.jpg">
			            			</div>
			            			<div class="cell_primary">
			            				<h4>纯手工馒头<span class="collect">199</span></h4>
			            				<p class="color-999999 line2">手工馒头真的比机器馒头好吃,手工揉出来的面比机器做的,口感要更劲道。</p>
			            			</div>
		            	</div>
		            </a>
	            </div>
	            <div class="baike-list-plate baike-plate">
		            <a href="">
		            	<div class="cell bg-white">
			            			<div class="cover-pic">
			            				<img src="images/bk02.jpg">
			            			</div>
			            			<div class="cell_primary">
			            				<h4>麻辣小龙虾<span class="collect">188</span></h4>
			            				<p class="color-999999 line2">麻辣小龙虾又叫长沙口味虾、香辣小龙虾等，是湖南省著名的传统小吃，以小龙虾制成，口味辣鲜香，色泽红亮，质地滑嫩，滋味香辣。</p>
			            			</div>
		            	</div>
		            </a>
	            </div>
	            <div class="baike-list-plate baike-plate">
					<a href="">
		            	<div class="cell bg-white">
			            			<div class="cover-pic">
			            				<img src="images/bk01.jpg">
			            			</div>
			            			<div class="cell_primary">
			            				<h4>纯手工馒头<span class="collect">199</span></h4>
			            				<p class="color-999999 line2">手工馒头真的比机器馒头好吃,手工揉出来的面比机器做的,口感要更劲道。</p>
			            			</div>
		            	</div>
		            </a>
	            </div>
	            <div class="baike-list-plate baike-plate">
		            <a href="">
		            	<div class="cell bg-white">
			            			<div class="cover-pic">
			            				<img src="images/bk02.jpg">
			            			</div>
			            			<div class="cell_primary">
			            				<h4>麻辣小龙虾<span class="collect">188</span></h4>
			            				<p class="color-999999 line2">麻辣小龙虾又叫长沙口味虾、香辣小龙虾等，是湖南省著名的传统小吃，以小龙虾制成，口味辣鲜香，色泽红亮，质地滑嫩，滋味香辣。</p>
			            			</div>
		            	</div>
		            </a>
	            </div>
	            <div class="baike-list-plate baike-plate">
					<a href="">
		            	<div class="cell bg-white">
			            			<div class="cover-pic">
			            				<img src="images/bk01.jpg">
			            			</div>
			            			<div class="cell_primary">
			            				<h4>纯手工馒头<span class="collect">199</span></h4>
			            				<p class="color-999999 line2">手工馒头真的比机器馒头好吃,手工揉出来的面比机器做的,口感要更劲道。</p>
			            			</div>
		            	</div>
		            </a>
	            </div>
	            <div class="baike-list-plate baike-plate">
		            <a href="">
		            	<div class="cell bg-white">
			            			<div class="cover-pic">
			            				<img src="images/bk02.jpg">
			            			</div>
			            			<div class="cell_primary">
			            				<h4>麻辣小龙虾<span class="collect">188</span></h4>
			            				<p class="color-999999 line2">麻辣小龙虾又叫长沙口味虾、香辣小龙虾等，是湖南省著名的传统小吃，以小龙虾制成，口味辣鲜香，色泽红亮，质地滑嫩，滋味香辣。</p>
			            			</div>
		            	</div>
		            </a>
	            </div>
	            <div class="baike-list-plate baike-plate">
					<a href="">
		            	<div class="cell bg-white">
			            			<div class="cover-pic">
			            				<img src="images/bk01.jpg">
			            			</div>
			            			<div class="cell_primary">
			            				<h4>纯手工馒头<span class="collect">199</span></h4>
			            				<p class="color-999999 line2">手工馒头真的比机器馒头好吃,手工揉出来的面比机器做的,口感要更劲道。</p>
			            			</div>
		            	</div>
		            </a>
	            </div>
	            <div class="baike-list-plate baike-plate">
		            <a href="">
		            	<div class="cell bg-white">
			            			<div class="cover-pic">
			            				<img src="images/bk02.jpg">
			            			</div>
			            			<div class="cell_primary">
			            				<h4>麻辣小龙虾<span class="collect">188</span></h4>
			            				<p class="color-999999 line2">麻辣小龙虾又叫长沙口味虾、香辣小龙虾等，是湖南省著名的传统小吃，以小龙虾制成，口味辣鲜香，色泽红亮，质地滑嫩，滋味香辣。</p>
			            			</div>
		            	</div>
		            </a>
	            </div>
	            <div class="baike-list-plate baike-plate">
					<a href="">
		            	<div class="cell bg-white">
			            			<div class="cover-pic">
			            				<img src="images/bk01.jpg">
			            			</div>
			            			<div class="cell_primary">
			            				<h4>纯手工馒头<span class="collect">199</span></h4>
			            				<p class="color-999999 line2">手工馒头真的比机器馒头好吃,手工揉出来的面比机器做的,口感要更劲道。</p>
			            			</div>
		            	</div>
		            </a>
	            </div>
	            <div class="baike-list-plate baike-plate">
		            <a href="">
		            	<div class="cell bg-white">
			            			<div class="cover-pic">
			            				<img src="images/bk02.jpg">
			            			</div>
			            			<div class="cell_primary">
			            				<h4>麻辣小龙虾<span class="collect">188</span></h4>
			            				<p class="color-999999 line2">麻辣小龙虾又叫长沙口味虾、香辣小龙虾等，是湖南省著名的传统小吃，以小龙虾制成，口味辣鲜香，色泽红亮，质地滑嫩，滋味香辣。</p>
			            			</div>
		            	</div>
		            </a>
	            </div>
	            <div class="baike-list-plate baike-plate">
					<a href="">
		            	<div class="cell bg-white">
			            			<div class="cover-pic">
			            				<img src="images/bk01.jpg">
			            			</div>
			            			<div class="cell_primary">
			            				<h4>纯手工馒头<span class="collect">199</span></h4>
			            				<p class="color-999999 line2">手工馒头真的比机器馒头好吃,手工揉出来的面比机器做的,口感要更劲道。</p>
			            			</div>
		            	</div>
		            </a>
	            </div>
	            <div class="baike-list-plate baike-plate">
		            <a href="">
		            	<div class="cell bg-white">
			            			<div class="cover-pic">
			            				<img src="images/bk02.jpg">
			            			</div>
			            			<div class="cell_primary">
			            				<h4>麻辣小龙虾<span class="collect">188</span></h4>
			            				<p class="color-999999 line2">麻辣小龙虾又叫长沙口味虾、香辣小龙虾等，是湖南省著名的传统小吃，以小龙虾制成，口味辣鲜香，色泽红亮，质地滑嫩，滋味香辣。</p>
			            			</div>
		            	</div>
		            </a>
	            </div>
			</div>
			<!--百科列表结束-->
			<!--返回顶部按钮-->
			<div id="topcontrol" style="display:none; position: fixed; bottom: 180px; right: 0px; cursor: pointer; z-index: 119;" title="返回顶部">
			<img style="width:36px; height:40px;" src="images/gotop.png">
		    </div>
		</div>
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
	</body>
</html>
