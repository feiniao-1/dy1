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
//获取当前url
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String caiid = "";
try{
caiid = request.getParameter("caiid");
System.out.println("caiid"+request.getParameter("caiid"));
}catch(Exception e){
	
}
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
//菜品列表信息
//CREATE TABLE `productmenu` (
//`productmenuid` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜品ID',
//`productlei` varchar(255) DEFAULT NULL COMMENT '菜品类别',
//`productname` varchar(255) DEFAULT NULL COMMENT '菜名',
//`productEname` varchar(255) DEFAULT NULL COMMENT '菜英文名',
//`content1` text COMMENT '菜品简介',
//`img1` varchar(255) DEFAULT NULL COMMENT '图片1',
//`createtime` datetime DEFAULT NULL COMMENT '创建时间',
//`updatetime` datetime DEFAULT NULL COMMENT '最新修改时间',
//`is_discuss` tinyint(1) DEFAULT NULL COMMENT '是否被评论',
//`del` int(11) DEFAULT NULL,
//`count` int(11) DEFAULT NULL COMMENT '销售量',
//`yprice` int(11) DEFAULT NULL COMMENT '原价格',
//`xprice` int(11) DEFAULT NULL COMMENT '现价格',
//`shoucang` int(11) DEFAULT NULL COMMENT '收藏量',
//`canshu_url` int(11) DEFAULT NULL,
//`tagid` int(22) DEFAULT NULL,
//`visitor` varchar(255) DEFAULT NULL,
//PRIMARY KEY (`productmenuid`)
//) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
//获取菜品信息

List<Mapx<String,Object>> caipinshow;
caipinshow=DB.getRunner().query("select productmenuid, productname,productEname,content1,img1,createtime,updatetime,count,yprice,shoucang from productmenu where del=? and productmenuid=? order by productmenuid desc limit 9", new MapxListHandler(), "0",caiid);
List<Mapx<String,Object>> tuijian;
tuijian=DB.getRunner().query("select productmenuid,img1 from productmenu where del=? order by count desc limit 2", new MapxListHandler(), "0");
//增加收藏
String xxid;
if(param.get("Action")!=null && param.get("Action").equals("喜欢")){
	xxid=param.get("xxid");
	//获取该id的收藏量
	List<Mapx<String,Object>> idxihuan=DB.getRunner().query("select shoucang from productmenu where productmenuid=? ", new MapxListHandler(), xxid);
	System.out.println("增加收藏量："+idxihuan+xxid);
	DB.getRunner().update("update productmenu set shoucang=? where productmenuid=?",Integer.parseInt(idxihuan.get(0).getIntView("shoucang"))+1,xxid);
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
		<title>饺耳菜品详情页</title>
		<link href="images/top-icon.png" type="image/x-icon" rel="shortcut icon" />
		<link href="css/m-style.css" rel="stylesheet">
		<script src="js/jquery-1.11.1.min.js"></script>
	</head>
	<body>
		<div class="container">
			<div class="head head-rel">
				<p>饺耳菜谱</p>
				<a href="yd_front_product.jsp" class="back02"><img src="images/back.png"></a>
			</div>
			<!--产品内页开始-->
			<div class="product product-inner">
				<div class="plate plate1">
					<img src="<%=caipinshow.get(0).getStringView("img1") %>" class="mb10">
					<div class="cell">
		            			<div class="cell_primary">
		            				<h3><%=caipinshow.get(0).getStringView("productname") %></h3>
		            				<p class="color-999999"><%=caipinshow.get(0).getStringView("productEname") %></p>
		            				<p class="color-666666 mb5">月售<%=caipinshow.get(0).getIntView("count") %><span class="ml10">好评率100%</span></p>
		            				<p><span class="color-dd2727 size18">￥<%=caipinshow.get(0).getIntView("yprice") %></span><del class="color-666666 ml10">58</del></p>
		            			</div>
            			<form  id="subform" method="POST" >
            				<input type="hidden" value="<%=caipinshow.get(0).getIntView("productmenuid")%>" name="xxid">
							<input type="hidden" value="喜欢" name="Action">
						</form>
						<%if(param.get("yn")!=null && param.get("yn").equals("1")){ %>
							<div class="collection"><span><img src="images/sc1.png"></span><%=Integer.parseInt(caipinshow.get(0).getIntView("shoucang"))+1%></div>
							<%}else{ %>
							<div class="collection"><a class="zhuce"  name="喜欢" onclick="test_post()"><span><img src="images/sc.png"></span></a><%=caipinshow.get(0).getIntView("shoucang")%></div>
							<%} %>
							<script type="text/javascript">
							function test_post() {
							var testform=document.getElementById("subform");
							testform.action="yd_front_product_inner.jsp?yn=1&caiid="+<%=caiid%>;
							testform.submit();
							}
							</script>
            			
	            	</div>
				</div>
				<div class="plate">
					<h3 class="panel__hd mb10">菜品介绍</h3>
					<p class="color-999999 panel__hd mb10 pt10"><%=caipinshow.get(0).getStringView("content1") %></p>
					<a href="">
					<div class="cell">
						<div class="cell_primary"><h3>菜品评价</h3></div>
						<span class="size18 color-999999">></span>
					</div>
					</a>
				</div>
				<div class="plate">
					<h3 class="panel__hd mb10">推荐菜品</h3>
					<ul class="tj-product clearfix">
						<li class="mr20"><a href="yd_front_product_inner.jsp?caiid=<%=tuijian.get(0).getIntView("productmenuid")%>"><img src="<%=tuijian.get(0).getStringView("img1")%>"></a></li>
						<li><a href="yd_front_product_inner.jsp?caiid=<%=tuijian.get(1).getIntView("productmenuid")%>"><img src="<%=tuijian.get(1).getStringView("img1")%>"></a></li>
					</ul>
				</div>
				<div style="height: 50px; width: 100%;"></div>
			</div>
			<!--产品内页结束-->
			<div class="tellbox">
				<h3>订餐电话:<a href="tel:01080440188"> 010-<span>8044</span><span>0188</span></a></h3>
			</div>
			
			<div id="topcontrol" style="display:none; position: fixed; bottom: 180px; right: 0px; cursor: pointer; z-index: 119;" title="返回顶部">
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
