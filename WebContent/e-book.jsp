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
/*char[] jiequhou;
int q=0;
for(int n=0;n<jiequ.length;n++){
	System.out.println(jiequ[n]);
	if(jiequ[n]=='f'){
		for(int m=n;m<jiequ.length;m++){
			jiequhou[q]=jiequ[m];
		q++;
		}
	}
}*/

System.out.println("url1"+url1);
if(url1.matches("^index$")){
	System.out.println("YES");
}else{
	System.out.println("NO");
}
int cailei;
if(request.getParameter("cailei")==null){
	cailei=1;
}else{
	cailei=Integer.parseInt(request.getParameter("cailei"));
}
String url3=request.getRequestURI().toString(); //得到相对url 
String url2=request.getRequestURI().toString(); //得到绝对URL
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

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <meta name="description" content="舵爷，火锅的江湖。舵爷江湖老火锅旗舰店创立于北京财满街。舵爷品牌名来自在“京城孟尝君”之美誉的黄珂黄舵爷，一群骨灰级美食家创造了这一文化老火锅的饕餮盛宴，主打重庆传统火锅情怀。">
		 <meta name="keywords" content="火锅，舵爷火锅，美味火锅，舵爷文化，江湖老火锅，麻辣鲜美，涮锅，四川火锅，重庆火锅，好吃的火锅">
		<title>电子杂志</title>
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
						<li class="nLi ">
								<h3><a href="front_news.jsp" >舵爷资讯</a></h3>
						</li>
						<li class="nLi on">
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
        <div class="us-banner"></div>
        <!--banner图部分结束-->
        <!--博客主体内容开始-->
        <div class="mainbox" style="padding: 50px 0;">
         <div class="container" style="position: relative;">
         	<!--左边导航部分开始-->
         	<div class="us-left">
                    <ul class="about-tab">
                        <a href="about-us.jsp?cailei=1"><li id="d1" class="js-tab">公司介绍 <i></i></li></a>
                        <a href="about-us.jsp?cailei=2"><li id="d2" class="js-tab">企业文化<i></i></li></a>
                        <a href="about-us.jsp?cailei=3"><li id="d3" class="js-tab">线下活动<i></i></li></a>
                        <a href="about-us.jsp?cailei=6"><li id="d6" class="js-tab">电子杂志<i></i></li></a>
                        <a href="about-us.jsp?cailei=4"><li id="d4" class="js-tab">人才招聘<i></i></li></a>
                        <a href="about-us.jsp?cailei=5"><li id="d5" class="js-tab">联系我们 <i></i></li></a>

                    </ul>
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
                    <div class="tab-line"></div>
            </div>
         	<!--左边导航部分结束-->
         	<!--右边部分开始-->
         	<div class="us-right">
         		<div class="e-book">
         			<div class="top-title">
         				<h3>饺耳电子杂志（第一期）</h3>
         			</div>
         			<div class="summary">
         				<div class="cell cell-start">
         					<div class="book-fm">
         						<img src="img/book01.jpg" class="img-responsive"/>
         					</div>
         					<div class="cell_primary">
         						<ul class="clearfix">
			                    	<li>【饺耳世家】：暖暖刊（第一期）</li>
			                    	<li>【发布日期】：2016-10-24</li>
			                    	<li>【所属分类】：电子杂志</li>
			                    	<li>【出版商】：饺耳世家</li>
			                    	<li>【案例大小】：6.94MB</li>
			                    	<li>【页数】：23页</li>
			                   </ul>
							    <div class="bdsharebuttonbox">
							    	<span class="fl" style="margin: 6px 6px 6px 0;font-size: 18px;">分享到</span>
									<a href="#" class="bds_more" data-cmd="more"></a>
									<a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
									<a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
									<a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a>
									<a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a>
									<a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
								</div>
								<div class="down_read">
									<a class="down" href="magazine/20161030-1.rar"><strong><span class="glyphicon glyphicon-circle-arrow-down"></span>免费下载</strong></a>
									<a class="media" href="magazine/20161030-1.pdf" target="_blank"><strong><span class="glyphicon glyphicon-sound-6-1"></span>在线阅读</strong></a>
<script type="text/javascript">  
    $(function() {  
        $('a.media').media({width:800, height:600});  
    });  
</script>  
								</div>
         					</div>
         				</div>
         				<div class="about-word">
                   <strong>杂志关键词:</strong>二十四节气之寒露，饺耳红烧肉，养生美食
                 </div>
                 <div class="book-infor">
                   <h4>杂志描述</h4>
                   <p>《饺耳美食》杂志是一本倡导提高人们生活质量，专注美食与健康的生活期刊。“二十四节气的秘密”和您一起讨论节气、饮食、健康之间联系，而“美食地图”将带您遍尝饺耳美食；如果想要亲自下厨大展身手，可以从“养生食单”中找到简单好吃又营养的菜谱。“饺耳趣闻”里那些关于饺子不得不说的故事；还有饺耳世家相关新闻、活动等内容让您更了解我们。饺耳美食，关于吃，关于健康，关于生活，关于爱。</p>
                 </div>
         				<div class="about-book">
         					<h4>相关杂志</h4>
         					<ul class="clearfix">
         						<li><a href=""><img src="img/book01.jpg" class="img-responsive"/><p>饺耳杂志</p></a></li>
         						<li><a href=""><img src="img/book01.jpg" class="img-responsive"/><p>饺耳杂志</p></a></li>
         						<li><a href=""><img src="img/book01.jpg" class="img-responsive"/><p>饺耳杂志</p></a></li>
         						<li><a href=""><img src="img/book01.jpg" class="img-responsive"/><p>饺耳杂志</p></a></li>
         						<li><a href=""><img src="img/book01.jpg" class="img-responsive"/><p>饺耳杂志</p></a></li>
         					</ul>
         				</div>
         			</div>
         		</div>
         	</div>
         	<!--右边部分结束-->
         </div>	
        </div> 	
	</body>
	<!--百度分享js-->
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"1","bdSize":"24"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
</html>
