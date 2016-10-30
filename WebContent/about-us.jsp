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
		  <meta name="description" content="">
		  <meta name="keywords" content="饺耳、美食">
		<title>关于饺耳</title>
		<link href="img/m-icon.png" type="image/x-icon" rel="shortcut icon" />	
		<!--<link href="css/bootstrap.css" rel="stylesheet">-->
		<link href="css/_main.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<script src="js/jquery-1.11.1.min.js"></script>
		<script src="js/bootstrap.min.js" type="text/javascript"></script>
		<script src="layer/layer.js"></script>
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=0VbFXF73nx75ZYZ6LGNsVC109G5ZY54F"></script>
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
								<h3><a href="front_news.jsp" >饺耳资讯</a></h3>
						</li>
						<li class="nLi ">
								<h3><a href="front_product.jsp?cailei=1" >饺耳菜品</a></h3>
								<ul class="sub">
									<li><a href="front_product.jsp?cailei=6">店长推荐</a></li>
									<li><a href="front_product.jsp?cailei=1">特色水饺</a></li>
									<li><a href="front_product.jsp?cailei=2">开胃凉菜</a></li>
									<li><a href="front_product.jsp?cailei=3">精品热菜</a></li>
									<li><a href="front_product.jsp?cailei=5">酒水饮料</a></li>
									<li><a href="front_product.jsp?cailei=4">美味主食</a></li>
								</ul>
						</li>
						<li class="nLi on">
								<h3><a href="about-us.jsp" >关于饺耳</a></h3>
								<ul class="sub">
									<li><a href="about-us.jsp?cailei=1">公司介绍</a></li>
									<li><a href="about-us.jsp?cailei=2">公司文化</a></li>
									<li><a href="about-us.jsp?cailei=3">线下活动</a></li>
									<li><a href="about-us.jsp?cailei=6">电子杂志</a></li>
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
         	<%if(cailei==1){ %>
                     <div class="tab-content" style="display: block;">
                        <h3 class="mb20">公司介绍</h3>
                        <img src="img/us01_03.jpg" class="img-responsive mb20"/>
                        <p class="txt-indent">饺耳世家，是全国首家致力于传承千年养生饮食文化的饺子店。
                        	秉承“传以古法，注以新意，精于食材，通于传达。”品牌理念和“养生食疗”的经营宗旨，
                        	让饺子的食疗养生文化在老北京宫廷御厨祖传配方接班人张芳女士的手上，继续发扬光大，
                        	铸就饺耳金质品牌。让饺耳世家成为中国餐饮行业的价值典范。</p>
                        <p class="txt-indent">我们不单纯注重于饺子的口感与味道，同时注重于饺子的营养与功效。
                        	饺子的馅料制作均选用新鲜的原食材，进行合理的营养搭配。自第一道工序开始，通过29道工艺标准，49道工艺流程，
                        	从皮到馅全部纯手工制作，为您奉上传统地道的纯手工水饺。饺子为东汉末年，“医圣”张仲景发明，原名娇耳。
                        	第一个饺子的诞生并不是作为食物，而是作为药引“祛寒娇耳汤”，帮助穷人驱寒暖身，医治冻烂的耳朵。
                        	饺耳世家将遵循1800年前张仲景发明饺子的初衷，让饺子作为美味食物的同时，继续完成它温补身体，养生食疗的使命。
                        	让饺子延续其最初诞生的意义，让大家享受美味的同时养胃健脾，温补身体，吃的美味也吃得健康。
                        </p>
                        <p class="txt-indent">来到饺耳世家，除了美味健康的饺子外，还有其他精美养生菜品售卖。饺耳世家，纯正中国味，等您来尝鲜！</p>
                    </div>
<%} %>
<%if(cailei==2){ %>
                    <div class="tab-content">
                        <h3>企业文化</h3>
                        <h4>1.企业宗旨</h4>
                        <p>秉承“传以古法，注以新意，精于食材，通于传达。”</p>
                        <h4>2.企业使命</h4>
                        <p>传千年饮食文化，树餐饮价值典范</p>
                        <h4>3.企业环境</h4>
                        <img src="img/dm01.jpg" class="img-responsive mb20" />
                        <!-- <h4>4.企业资质</h4>
                        <ul class="qualification clearfix">
                        	<li><img src="img/us03.jpg" class="img-responsive"></li>
                        	<li><img src="img/us03.jpg" class="img-responsive"></li>
                        	<li class="mr0"><img src="img/us03.jpg" class="img-responsive"></li>
                        </ul> -->
                    </div>
                    <%} %>
 <%if(cailei==3){ %>
                    <div class="tab-content">
                        <h3>线下活动</h3>
                        <p class="mb20">
                          <img src="img/hd01.jpg" class="img-responsive" />
                        </p>
                        <h4 class="color-dd2727">活动一</h4>
                        <p>现在只要到店消费，就送饺子一盘。什么？就吃送的一盘饺子就饱了，不点别的了行吗?小编告诉你，这样也可以</p>
                        <h4 class="color-dd2727">活动二</h4>
                        <p>生日当天持卡消费还将获赠镇店菜、长寿面各一份(详情请质询店内服务员)</p>
                        <h4 class="color-dd2727">活动三</h4>
                        <p>店内充值卡满赠活动正在火热进行。充1000赠100，充5000赠750，最高赠到4000！！！</br>还有金牌饺子券和豪礼相送拿着充值卡，享受会员价</p>
                         <p class="color-dd2727">注释：具体活动详情请到店咨询，本活动最终解释权归饺耳世家所有。</p>
                    </div>
<%} %>
<%if(cailei==6){ %>
                    <div class="tab-content">
                        <h3>电子杂志</h3>
                        <ul class="clearfix  e-zine">
                        	<li><a href="e-book.jsp?cailei=6"><img src="img/book01.jpg" class="img-responsive"><p>饺耳美食第一期</p></a></li>
                   			<li><a href="e-book.jsp?cailei=6"><img src="img/book01.jpg" class="img-responsive"><p>饺耳美食第一期</p></a></li>
                   			<li><a href="e-book.jsp?cailei=6"><img src="img/book01.jpg" class="img-responsive"><p>饺耳美食第一期</p></a></li>
                   			<li><a href="e-book.jsp?cailei=6"><img src="img/book01.jpg" class="img-responsive"><p>饺耳美食第一期</p></a></li>
                   			<li><a href="e-book.jsp?cailei=6"><img src="img/book01.jpg" class="img-responsive"><p>饺耳美食第一期</p></a></li>
                   			<li><a href="e-book.jsp?cailei=6"><img src="img/book01.jpg" class="img-responsive"><p>饺耳美食第一期</p></a></li>
                   			<li><a href="e-book.jsp?cailei=6"><img src="img/book01.jpg" class="img-responsive"><p>饺耳美食第一期</p></a></li>
                   			<li><a href="e-book.jsp?cailei=6"><img src="img/book01.jpg" class="img-responsive"><p>饺耳美食第一期</p></a></li>
                        </ul>
                        <!--分页内容标签开始-->
								<div class="nav-page">
								  <ul class="pagination">
								    <li><a href="#">&laquo;</a></li>
								    <li><a href="#">1</a></li>
								    <li><a href="#">2</a></li>
								    <li><a href="#">3</a></li>
								    <li><a href="#">...</a></li>
								    <li><a href="#">9</a></li>
								    <li><a href="#">10</a></li>
								    <li><a href="#">&raquo;</a></li>
								  </ul>
								</div>
                    </div>
<%} %>
<%if(cailei==4){ %>
                    <div class="tab-content">
                        <h3>人才招聘</h3>
                        <h4> 饺耳世家正在招聘以下岗位的小伙伴，加入“饺耳团队”来，</h4>
                        <p><strong>1、内容编辑</strong><br>
                                                                            招聘人数：1-2人
                        </p>
                        <p>
                        	<strong>岗位职责：</strong><br />
							1、完成相关约稿、采访和文章撰写工作；<br />
							2、根据全球移动互联网行业热点，及时撰写文章；<br />
							3、编译外文；<br />
							4、完成交办的其他临时任务。
                        </p>  
                        <p><strong>1、内容编辑</strong><br>
                                                                            招聘人数：1-2人
                        </p>
                        <p>
                        	<strong>岗位职责：</strong><br />
							1、完成相关约稿、采访和文章撰写工作；<br />
							2、根据全球移动互联网行业热点，及时撰写文章；<br />
							3、编译外文；<br />
							4、完成交办的其他临时任务。
                        </p> 
                        <p><strong>1、内容编辑</strong><br>
                                                                            招聘人数：1-2人
                        </p>
                        <p>
                        	<strong>岗位职责：</strong><br />
							1、完成相关约稿、采访和文章撰写工作；<br />
							2、根据全球移动互联网行业热点，及时撰写文章；<br />
							3、编译外文；<br />
							4、完成交办的其他临时任务。
                        </p> 
                        <p>
                        	地      址：北京市朝阳区朝阳路69号<br />
					                      电       话：010-80850472   18910622378  王经理<br />
							面试时间：周一到周日 上午10:00到 下午17:00<br />
							有意者请携带简历，在上述时间直接参加面试，无需预约。<br />
                                                                             错过招聘时间，有意加入公司者可与王经理电话联系，另行约定面试时间。                                         
                        </p>
                    </div>
<%} %>
<%if(cailei==5){ %>
                    <div class="tab-content">
                        <h3>联系我们</h3>
                        <div class="cell mb30">
                        	<div class="cell_primary">
                        		<p class="contact-information"><label>公司名称：</label>饺耳世家<br />
								<label>公司地址：</label>北京市朝阳区朝阳路福福满街69号<br />
								<label>联系人：</label>张经理<br />
								<label>联系电话：</label>010-80440188<br />
								<label>邮箱：</label>jiaoear@126.com<br /></p>
                        	</div>
                        	<div class="cell_primary">
                        		<img src="img/pic18_03.jpg" class="fr">
                        	</div>
                        </div>
                        <div style="width:100%;height:600px;border:#ccc solid 1px;font-size:14px" id="map"></div>
                    </div>

<%} %>

                </div>
         	<!--右边部分结束-->
         </div>  
       </div>  
        <!--博客主体内容结束-->
         <!--页面底部板块开始-->
		<%@ include file="footer.jsp"%>
        <!--页面底部板块结束-->
        <!--返回顶部-->
		<div id="topcontrol" style="position: fixed; bottom: 80px; right: 30px;cursor: pointer; z-index: 9; display: none;" title="返回顶部">
			<img style="width:50px; height:50px;" src="img/gotop.jpg">
		</div>
		<!--返回顶部结束-->
	</body>
	<!--关于我们页面竖向导航js-->
	<script>
		$(function(){
		    var hash=window.location.hash;
		    var start=hash.substr(-1);
		
		    $(document).on('click','.js-tab',function(){
		            var $dom=$(this);
		            window.location.hash='about0';
		            var index=$dom.index();
		            $dom.addClass('active').siblings().removeClass('active');
		            $('.tab-content').eq(index).show().siblings().hide();
		
		    })
		})
	</script>
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
		        $("body,html").stop().animate({"scrollTop":0},1000);
		    });
      })
	</script>
<!--百度分享js-->
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"1","bdSize":"18"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
<!--百度地图js-->
<script type="text/javascript">
    //创建和初始化地图函数：
    function initMap(){
      createMap();//创建地图
      setMapEvent();//设置地图事件
      addMapControl();//向地图添加控件
      addMapOverlay();//向地图添加覆盖物
    }
    function createMap(){ 
      map = new BMap.Map("map"); 
      map.centerAndZoom(new BMap.Point(116.538173,39.923708),19);
    }
    function setMapEvent(){
      map.enableScrollWheelZoom();
      map.enableKeyboard();
      map.enableDragging();
      map.enableDoubleClickZoom()
    }
    function addClickHandler(target,window){
      target.addEventListener("click",function(){
        target.openInfoWindow(window);
      });
    }
    function addMapOverlay(){
      var markers = [
        {content:"北京市朝阳区朝阳路福福满街69号,电话：010-80440188",title:"饺耳世家",imageOffset: {width:-46,height:-21},position:{lat:39.923708,lng:116.538173}}
      ];
      for(var index = 0; index < markers.length; index++ ){
        var point = new BMap.Point(markers[index].position.lng,markers[index].position.lat);
        var marker = new BMap.Marker(point,{icon:new BMap.Icon("http://api.map.baidu.com/lbsapi/createmap/images/icon.png",new BMap.Size(20,25),{
          imageOffset: new BMap.Size(markers[index].imageOffset.width,markers[index].imageOffset.height)
        })});
        var label = new BMap.Label(markers[index].title,{offset: new BMap.Size(25,5)});
        var opts = {
          width: 200,
          title: markers[index].title,
          enableMessage: false
        };
        var infoWindow = new BMap.InfoWindow(markers[index].content,opts);
        marker.setLabel(label);
        addClickHandler(marker,infoWindow);
        map.addOverlay(marker);
      };
    }
    //向地图添加控件
    function addMapControl(){
      var scaleControl = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
      scaleControl.setUnit(BMAP_UNIT_IMPERIAL);
      map.addControl(scaleControl);
      var navControl = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
      map.addControl(navControl);
      var overviewControl = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:true});
      map.addControl(overviewControl);
    }
    var map;
      initMap();
  </script>
</html>
