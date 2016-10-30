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
String sqlPreCount = "select count(1) as count from news where newstype=? and (del is NULL or del <>1)  order BY newsid DESC ";
List<Mapx<String,Object>> sqlPreCount1 =  DB.getRunner().query(sqlPreCount, new MapxListHandler(),"boke");
//总商品数量
int total = sqlPreCount1.get(0).getInt("count");
//商品页数
int count_page=total/5;
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
if(Integer.parseInt(index_page)==1){
	minus =1;	
}else{
	minus =Integer.parseInt(index_page)-1;
}
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
//获取菜品信息

List<Mapx<String,Object>> caipinshow;
caipinshow=DB.getRunner().query("select productlei,productname,productEname,content1,content2,img1,img2,createtime,updatetime from productmenu where del=? and productmenuid=? order by productmenuid desc limit 9", new MapxListHandler(), "0",caiid);
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
		<title>菜品详情页</title>
		<!--<link href="css/bootstrap.css" rel="stylesheet">-->
		<link href="img/duoyeLOGO.png" rel="SHORTCUT ICON">
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
				  <li class="active">菜品详情</a></li>
				  <li class="active"><%=caipinshow.get(0).getStringView("productname") %></li>
				</ol>
         	</div>
         	<div class="row">
         		<!--左边部分开始-->
	         		<div class="col-md-9">
	         			<div class="main-left">
	         				<div class="product-detail">
	         					<div class="bdsharebuttonbox" style="position: absolute; right: 0px; top: 5px;">
								    <a href="#" class="bds_more" data-cmd="more">分享到：</a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信">微信</a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博">新浪微博</a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博">腾讯微博</a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网">人人网</a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间">QQ空间</a>
								</div>
		         				<h3 class="color-dd2727 mb20"><%=caipinshow.get(0).getStringView("productname") %></h3>
		         				<img src="<%=caipinshow.get(0).getStringView("img2") %>" class="img-responsive mb20" style="width:100%"/>
		         				<div class="txt-indent color-666666 mb30 dash-line"><%=caipinshow.get(0).getStringView("content1") %></div>
		         				<%if(!caipinshow.get(0).getStringView("productlei").equals("酒水饮料")){ %>
	         					<h4 class="icon-cp mb20">菜品介绍</h4>
	         					<div class="img_W100"><%=caipinshow.get(0).getStringView("content2") %></div>
	         					<%} %>
	         					<h4 class="icon-xg">店长推荐</h4>
		         				<ul class="about-food clearfix">
		         				<%List<Mapx<String,Object>> caipinshow2;
		         				caipinshow2=DB.getRunner().query("select productmenuid,productname,img1 from productmenu where del=?  order by shoucang desc limit 4", new MapxListHandler(), "0"); 
		         				for(int i=0;i<caipinshow2.size();i++){%>
		         				<%if(i==3){ %>
		         					<li class="mr0">
		         						<a href="front_product-inner.jsp?caiid=<%=caipinshow2.get(i).getIntView("productmenuid")%>" target="_blank">
			         						<img src="<%=caipinshow2.get(i).getStringView("img1")%>">
			         						<p><%=caipinshow2.get(i).getStringView("productname")%></p>
		         						</a>
		         					</li>
		         					<%}else{ %>
		         					<li>
		         						<a href="front_product-inner.jsp?caiid=<%=caipinshow2.get(i).getIntView("productmenuid")%>" target="_blank">
			         						<img src="<%=caipinshow2.get(i).getStringView("img1")%>">
			         						<p><%=caipinshow2.get(i).getStringView("productname")%></p>
		         						</a>
		         					</li>
		         				<%}} %>
		         				</ul>
		         				
	         				</div>
	         			</div>
         		    </div>
         		<!--右边部分开始-->
	         		<div class="col-md-3">
	         			<div class="main-right">
	         				<!--广告图部分-->
	         				<div class="baike-content">
	         				<div class="ad mb30">
	         				<%List<Mapx<String,Object>> zuijiashow;
	         				zuijiashow=DB.getRunner().query("select productmenuid,productname,productEname,img1 from productmenu where del=?  order by shoucang desc limit 1", new MapxListHandler(), "0"); %>
	         					<a href="front_product-inner.jsp?caiid=<%=zuijiashow.get(0).getIntView("productmenuid")%>" target="_blank"><img src="<%=zuijiashow.get(0).getStringView("img1") %>" class="img-responsive"></a>
	         				</div>
	         				<h4 class="icon-sp">相关视频</h4>
		         			<div class="video mb30">
		         				<a href="javascript:;" class="play-video"><img src="img/video-pic_03.jpg"  class="img-responsive"></a>
		         			</div>
		         			<h4  class="icon-tj">推荐</h4>
		         			<table width="100%" border="0" cellspacing="0" class="recommend">
		         				<tbody>
		         				<%List<Mapx<String,Object>> caipinshow1;
		         				caipinshow1=DB.getRunner().query("select productmenuid,productname from productmenu where del=?  order by shoucang desc limit 10", new MapxListHandler(), "0"); 
		         				for(int i=0;i<caipinshow1.size();i++){%>
		         					<tr>
		         						<td width="50%"><a href="front_product-inner.jsp?caiid=<%=caipinshow1.get(i).getIntView("productmenuid")%>" target="_blank"><%=caipinshow1.get(i).getStringView("productname") %></a></td>
		         						<td width="50%"><a href="front_product-inner.jsp?caiid=<%=caipinshow1.get(i+1).getIntView("productmenuid")%>" target="_blank"><%=caipinshow1.get(i+1).getStringView("productname")%></a></td>
		         					</tr>
		         					<%i++;}%>
		         				</tbody>
		         			</table>
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
	<!--<script>
	$(function(){
	var $div_li=$('.title-nav .title-nav-item');
	$div_li.click(function(){
		$(this).addClass('active').siblings().removeClass('active');
		var index =$div_li.index(this);
		$('.course-slide >div').eq(index).show().siblings().hide();
		});	
	});
	</script>-->
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
		        $("body,html").stop().animate({"scrollTop":0},1000);//一秒钟时间回到顶部
		    });
      })
	</script>
<!--百度分享js-->
<script>
window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"饺耳的美味让你无法阻挡！","bdMini":"2","bdMiniList":false,"bdPic":"www.jiaoear.com","bdStyle":"0","bdSize":"16"},"share":{"bdSize":16},"image":{"viewList":["weixin","tsina","qzone","tqq","renren"],"viewText":"分享到：","viewSize":"24"}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>
</html>
