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
		<title>饺耳百科词条</title>
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
				<p>饺耳百科</p>
				<a href="" class="back02"><img src="images/back.png"></a>
			</div>
			<!--百科词条内页-->
			<div class="baike-inner">
				<div class="baike-plate baike-inner-plate">
					<div class="cell bg-white mb10">
				            	    <div class="cover-pic02">
				            				<a href="">
				            				<img src="images/bk03.jpg">
				            				<p class="cover-word">图集</p>
				            				</a>
				            		</div>
			            			<div class="cell_primary">
			            				<h4>【油焖虾】</h4>
			            				<ul class="remark">
			            					<li><label>中文名</label>油焖虾</li>
			            					<li><label>英文名</label>Braised shrimp</li>
			            					<li><label>主食材</label>虾</li>
			            					<li><label>分类</label>粤菜、鲁菜</li>
			            					<li><label>口味</label>鲜嫩微甜，油润适口 </li>
			            					<li><label>工艺</label>焖</li>
			            				</ul>
			            			</div>
		            </div>
		            <div class="summary">
		            	油焖虾是一道色香味俱全的传统名肴，属于鲁菜系四大代表菜
						之一，主要食材是渤海湾产对虾，主要烹饪工艺是炒焖。菜品
						色泽枣红亮丽，味香飘逸，鲜嫩微甜，油润适口，是著名的美
						味佳肴。
		            </div>
		            <div class="sharebox">
		            	<span class="love on">喜欢188</span><span class="house">收藏96</span><span class="share">分享</span>
		            </div>
				</div>
				<div class="baike-plate baike-inner-plate">
					<h4 class="mb10">油焖虾</h4>
					<p class="color-999999">油焖虾是一道在餐桌上比较常见的海鲜菜之一油焖过的虾
吃起来肉里有了清油以及作料的味道，美味可口。</p>
				</div>
				<div class="baike-plate baike-inner-plate">
					<h4 class="mb10">做法</h4>
					<ul class="color-999999">
						<li>主料：对虾适量。</li>
						<li>调料：色拉油适量，葱适量，姜适量，料酒适量，生抽适
                                                                  量，老抽适量，白糖适量。</li>
						<li>1.买回的虾用清水再养一会</li>
						<li>2.剔除虾泥肠，剪去虾脚，虾须和虾枪</li>
						<li>3.再次冲洗干净</li>
						<li>4.热锅冷油加入生姜煸炒出香味</li>
						<li>5.把虾倒入锅里，先加老抽翻炒上色</li>
						<li>6.加入一些生抽翻炒几下</li>
						<li>7.点入料酒翻炒一下后再倒入一些料酒</li>
						<li>8.加半碗水，加一勺糖，调味，煮开焖2分钟，撒上葱</li>
					</ul>
				</div>
				<div class="baike-plate baike-inner-plate">
					<h4 class="mb10">营养价值</h4>
					<ul class="color-999999">
						<li>1.虾营养丰富，且其肉质松软，易消化，对身体虚弱以及
                                                        病后需要调养的人是极好的食物</li>
						<li>2.虾中含有丰富的镁，镁对心脏活动具有重要的调节作用
								能很好的保护心血管系统，它可减少血液中胆固醇含量，
								防止动脉硬化，同时还能扩张冠状动脉，有利于预防高血
								压及心肌梗死。</li>
						<li>3.虾的通乳作用较强，并且富含磷、钙、对小儿、孕妇尤
                                                       有补益功效。</li>
					</ul>
				</div>
			</div>
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
