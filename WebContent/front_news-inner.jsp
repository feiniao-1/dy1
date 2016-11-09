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
List<Mapx<String, Object>> article=DB.getRunner().query("select articleid,author,title,content1,content2,zcount,tag1,tag2,tag3,tag4,img1,img2,createtime,origin from article where tagid=?", new MapxListHandler(),request.getParameter("tagid"));
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
List<Mapx<String, Object>> articlenext=DB.getRunner().query("select title,tagid from article where articleid<? and del=? order by articleid desc limit 1", new MapxListHandler(),article.get(0).getIntView("articleid"),"0");
System.out.println(articlenext);
//获取文章作者
List<Mapx<String, Object>> authorxx= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),article.get(0).getStringView("author"));
//获取当前url
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String jishu = "";

try{
jishu = request.getParameter("jishu");
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
		content=new String(request.getParameter("content").getBytes("iso-8859-1"),"utf-8");
		if(content.equals("")||content.equals(null)){
		}else{
			DB.getRunner().update("insert into discuss(discusscontent,visitor,canshu_url,discusstime,userid,articleid,zcount) values(?,?,?,?,?,?,?)",content,10168,url_canshu,df.format(new Date()),10049,article.get(0).getStringView("articleid"),"0");
			content=null;
		}
		//if(flag==1){
		//	content=new String(request.getParameter("content").getBytes("iso-8859-1"),"utf-8");
		//	if(content.equals("")||content.equals(null)){
		//	}else{
		//		DB.getRunner().update("insert into discuss(discusscontent,visitor,canshu_url,discusstime,userid,articleid) values(?,?,?,?,?,?)",content,useridc.get(0).getIntView("userid"),url_canshu,df.format(new Date()),10049,article.get(0).getStringView("articleid"));
		//		content=null;
		//	}
		//}else{
		//	%>
	<script type="text/javascript" language="javascript">
		//			alert("请登录");                                            // 弹出错误信息
			//window.location='front_news-inner.jsp?page=0&jishu=<%=val%>&tagid=<%=request.getParameter("tagid") %>' ;                            // 跳转到登录界面
	</script>
		<%
		//}
	}else{
	}
	}

//显示评论信息
List<Mapx<String,Object>> showdiscuss = DB.getRunner().query("select discussid as discussid,discusscontent as sh_discuss,userid as sh_userid,visitor as sh_visitor,canshu_url as canshu_url ,substring(discusstime,1,19) as discusstime from discuss where  articleid=? order by discussid desc limit "+page_ye+",5",new MapxListHandler(),article.get(0).getStringView("articleid"));
/*统计 评论数及 页数*/
String sqlPreCount = "select count(1) as count from discuss where  (del is NULL or del <>1) and articleid=? order BY discussid DESC ";
List<Mapx<String,Object>> sqlPreCount1 =  DB.getRunner().query(sqlPreCount, new MapxListHandler(),article.get(0).getStringView("articleid"));
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
//增加赞
String cussid;
if(param.get("Action")!=null && param.get("Action").equals("zan")){
	cussid=param.get("id");
	//获取该id的赞量
	List<Mapx<String,Object>> idxihuan=DB.getRunner().query("select zcount from discuss where discussid=? ", new MapxListHandler(), cussid);
	DB.getRunner().update("update discuss set zcount=? where discussid=?",Integer.parseInt(idxihuan.get(0).getIntView("zcount"))+1,cussid);
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <meta name="description" content="舵爷，火锅的江湖。舵爷江湖老火锅旗舰店创立于北京财满街。舵爷品牌名来自在“京城孟尝君”之美誉的黄珂黄舵爷，一群骨灰级美食家创造了这一文化老火锅的饕餮盛宴，主打重庆传统火锅情怀。">
		 <meta name="keywords" content="火锅，舵爷火锅，美味火锅，舵爷文化，江湖老火锅，麻辣鲜美，涮锅，四川火锅，重庆火锅，好吃的火锅">
		<title>新闻资讯</title>
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
						<li class="nLi on">
								<h3><a href="front_news.jsp" >舵爷资讯</a></h3>
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
				  <li class="active">资讯详情</li>
				</ol>
         	</div>
         	<div class="row">
	         	<!--左边部分开始-->
	         		<div class="col-md-9">
	         			<div class="main-left">
	         				<!--文章部分开始-->
	         				<div class="article">
	         					<h3 class="color-dd2727 mb15"><%=article.get(0).getStringView("title") %></h3>
	         					<div class="cell">
	         						<div class="cell_primary">
	         							<p class="color-666666">来自：<%if(article.get(0).getStringView("origin").equals("")){ %>
											<%=authorxx.get(0).getStringView("username") %>
											<%}else{ %>
											<%=article.get(0).getStringView("origin") %>
											<%} %><span class="m_r_l-10">|</span><%=article.get(0).getStringView("createtime") %><span class="glyphicon glyphicon-eye-open color-ff6600 m_r_l-10"></span><%=zcount+1 %></p>
	         						</div>
	         						<div class="cell_primary">
	         							<div class="bdsharebuttonbox">
											<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
										</div>
	         						</div>
	         					</div>
	         					<div class="summary txt-indent">
	         						<%=article.get(0).getStringView("content1") %>
	         					</div>
	         					<div class="article-pic mb20">
	         						<img src="<%=article.get(0).getStringView("img2") %>">
	         					</div>
	         					<div class="article-word" >
	         						<%=article.get(0).getStringView("content2") %>
	         					</div>
	         					<p class="lable color-ff6600"><%
	         					if(article.get(0).getStringView("tag1").equals("")&&article.get(0).getStringView("tag2").equals("")&&article.get(0).getStringView("tag3").equals("")&&article.get(0).getStringView("tag4").equals("")){
	         					%><%}else{ %>词条标签：<%} %>
	         					<%
	         					if(!article.get(0).getStringView("tag1").equals("")){
	         					%>
	         					<a href="https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&tn=baidu&wd=<%=article.get(0).getStringView("tag1") %>&rsv_pq=ef8ff8b2000107d3&rsv_t=539fv3OednOCU8H3mP%2BGn0qNTHMjZWGcq3sMUjvyv%2FioPrhdVEi%2Bx2jarQM&rqlang=cn&rsv_enter=1&rsv_sug3=8&rsv_sug1=6&rsv_sug7=100&rsv_sug2=0&inputT=2022&rsv_sug4=2880" target="_blank"><%=article.get(0).getStringView("tag1") %></a>
	         					<%}%>
	         					<%if(!article.get(0).getStringView("tag2").equals("")){%>
	         					<a href="https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&tn=baidu&wd=<%=article.get(0).getStringView("tag2") %>&rsv_pq=ef8ff8b2000107d3&rsv_t=539fv3OednOCU8H3mP%2BGn0qNTHMjZWGcq3sMUjvyv%2FioPrhdVEi%2Bx2jarQM&rqlang=cn&rsv_enter=1&rsv_sug3=8&rsv_sug1=6&rsv_sug7=100&rsv_sug2=0&inputT=2022&rsv_sug4=2880" target="_blank"><%=article.get(0).getStringView("tag2") %></a>
	         					<%}%>
	         					<%if(!article.get(0).getStringView("tag3").equals("")){%>
	         					<a href="https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&tn=baidu&wd=<%=article.get(0).getStringView("tag3") %>&rsv_pq=ef8ff8b2000107d3&rsv_t=539fv3OednOCU8H3mP%2BGn0qNTHMjZWGcq3sMUjvyv%2FioPrhdVEi%2Bx2jarQM&rqlang=cn&rsv_enter=1&rsv_sug3=8&rsv_sug1=6&rsv_sug7=100&rsv_sug2=0&inputT=2022&rsv_sug4=2880" target="_blank"><%=article.get(0).getStringView("tag3") %></a>
	         					<%}%>
	         					<%if(!article.get(0).getStringView("tag4").equals("")){%>
	         					<a href="https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&tn=baidu&wd=<%=article.get(0).getStringView("tag4") %>&rsv_pq=ef8ff8b2000107d3&rsv_t=539fv3OednOCU8H3mP%2BGn0qNTHMjZWGcq3sMUjvyv%2FioPrhdVEi%2Bx2jarQM&rqlang=cn&rsv_enter=1&rsv_sug3=8&rsv_sug1=6&rsv_sug7=100&rsv_sug2=0&inputT=2022&rsv_sug4=2880" target="_blank"><%=article.get(0).getStringView("tag4") %></a>
	         					<%}%>
	         					</p>
	         					<h4 class="next-article-tilte"><a href="front_news-inner.jsp?page=0&tagid=<%=articlenext.get(0).getIntView("tagid")%>" target="_blank">下一篇：<%=articlenext.get(0).getStringView("title") %></a></h4>
	         				</div>
	         				<!--文章部分结束-->
	         				<!--评价部分开始-->
	         				<div class="evaluate">
	         					<h4>发表评论</h4>
	         					<form id="form_tj" action="front_news-inner.jsp?page=0&jishu=<%=val%>&tagid=<%=request.getParameter("tagid") %>" method="post"  class="clearfix mb20">
		         					<textarea placeholder="写出你的点评" id="discuss_content" rows="5" cols="35" name="content"></textarea>
		         					<input type="submit" Name="Action" value="发表评论" class="submit-fb" >
	         					</form>
	         					<div class="evaluate-list">
	         					 <% for(int i=0;i<showdiscuss.size();i++){
						    	Mapx<String,Object> showdiscuss_1 = showdiscuss.get(i);
						    	List<Mapx<String,Object>> user_xinxi = DB.getRunner().query("select username from user where  userid=? ",new MapxListHandler(),showdiscuss_1.getIntView("sh_userid"));
						    	//获取访客用户
						    	List<Mapx<String, Object>> visitorxx= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),"10168");
						    	//评论信息计数
						    	List<Mapx<String, Object>> zcountshu= DB.getRunner().query("SELECT zcount FROM discuss where discussid=?", new MapxListHandler(),showdiscuss_1.getIntView("discussid"));
						    	%>
						    		<div class="cell" style="align-items:flex-start;">
	         							<div class="pic-tx">
	         								<img src="img/visitor.png">
	         							</div>
	         							<div class="cell_primary">
	         								<h5 class="mb10"><%=visitorxx.get(0).getStringView("username") %></h5>
	         								<p class="color-666666 mb10"><%=showdiscuss_1.getStringView("sh_discuss") %></p>
	         								<p class="color-999999"><span class="mr20">时间：<%=showdiscuss_1.getStringView("discusstime")%></span>
	         								<a href="javascript:;" class=" mr10" onclick="test_post<%=i %>()"><span class="glyphicon glyphicon-thumbs-up"></span></a><%=zcountshu.get(0).getIntView("zcount") %></p>
	         								<form  id="subform<%=i %>" method="POST" >
	         									<input type="hidden" value="<%=showdiscuss_1.getStringView("discussid")%>" name="id">
												<input type="hidden" value="zan" name="Action">
											</form>
											<script type="text/javascript">
												function test_post<%=i %>() {
												var testform=document.getElementById("subform<%=i %>");
												testform.action="front_news-inner.jsp?page=0&val="+<%=val%>+"&tagid="+<%=request.getParameter("tagid")%>+"&id="+<%=showdiscuss.get(i).getStringView("discussid")%>;
												testform.submit();
												}
											</script>
	         							</div>
	         						</div>
						            
						    	<%} %> 
	         					</div>
	         					<div class="nav-page">
								    <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_news-inner.jsp?page=<%=minus%>&tagid=<%=request.getParameter("tagid") %>">«</a></li>
								    <li><a href="${pageContext.request.contextPath}/front_news-inner.jsp?page=0&tagid=<%=request.getParameter("tagid") %>">1</a></li>
								    <li><a href="${pageContext.request.contextPath}/front_news-inner.jsp?page=1&tagid=<%=request.getParameter("tagid") %>">2</a></li>
								    <li><a href="${pageContext.request.contextPath}/front_news-inner.jsp?page=2&tagid=<%=request.getParameter("tagid") %>">3</a></li>
								    <li><a>...</a></li>
								    <li><a href="${pageContext.request.contextPath}/front_news-inner.jsp?page=<%=count_page-1%>&tagid=<%=request.getParameter("tagid") %>"><%=count_page%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_news-inner.jsp?page=<%=count_page%>&tagid=<%=request.getParameter("tagid") %>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_news-inner.jsp?page=<%=plus%>&tagid=<%=request.getParameter("tagid") %>">»</a></li>
								  </ul>
								</div>
	         				</div>
	         				<!--评价部分结束-->
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
		         				System.out.println(wzt);
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
		         				<%List<Mapx<String, Object>> wzm=DB.getRunner().query("select title,subString(createtime,1,10) as createtime,tagid from news where newstype=? and (del is NULL or del <>1) order by newsid desc limit 6", new MapxListHandler(),"boke");
		         				for(int index_wz=0;index_wz<wzm.size();index_wz++){ %>
		         					<li><span class="date"><%=wzm.get(index_wz).getStringView("createtime")%></span><a href="front_news-inner.jsp?page=0&tagid=<%=wzm.get(index_wz).getIntView("tagid") %>" target="_blank"><%=wzm.get(index_wz).getStringView("title") %></a></li>
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
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
</html>
