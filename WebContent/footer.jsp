<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
 <!--页面底部板块开始-->
         <div class="footer">
        	<div class="container">
        		<div class="row">
        			<div class="cell">
        				<div class="logo"><a href="" target="_blank"><img src="img/logo02_03.png"></a></div>
        				<div class="cell_primary">
        					<p class="foot-link">
        						<a href="front_index.jsp" target="_blank">首页</a><span>|</span>
        						<a href="#" target="_blank">舵爷博客</a><span>|</span>
        						<a href="front_baike.jsp?page=0" target="_blank">舵爷百科</a><span>|</span>
        						<a href="#" target="_blank">舵爷问答</a><span>|</span>
        						<a href="#" target="_blank">舵爷图库</a><span>|</span>
        						<a href="#" target="_blank">RSS</a><span>|</span>
        						<a href="#" target="_blank">XML</a>
        					</p>
        					<p>© Copyright 2008-2016. 京ICP备15008545号</p>
        					<p>舵爷热线：010-80440188 / 010-80443266</p>
        					<p><a href="" target="_blank">技术支持：DESIGN BY IWISDOMS TEAM</a></p>
        					<div class="icon-link bdsharebuttonbox" data-tag="share_1">
								<a style="background-image:url(img/wx-icon_03.png);" data-cmd="weixin"></a>
								<a style="background-image:url(img/wb-icon_03.png);" data-cmd="tsina"></a>
								<a style="background-image:url(img/kj-icon_03.png);" data-cmd="qzone"></a>
								<a style="background-image:url(img/rr-icon_03.png);" data-cmd="renren"></a>
							</div>

        				</div>
        				<div class="e-mail">
        				<%//获取url
        				HashMap<String,String> param1= G.getParamMap(request);
        				String  urlfootor;
        				String patha = request.getContextPath();  
        				String basePatha = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+patha+"/";   
        				String servletPatha=request.getServletPath();    
        				String requestURIa=request.getRequestURI();  
        				//System.out.println("path:"+patha);  
        				//System.out.println("basePath:"+basePatha);   
        				//System.out.println("servletPath:"+servletPatha);   
        				if(request.getQueryString()==null){
        					urlfootor=requestURIa;
        					
        				}else{
        					urlfootor=requestURIa+"?"+request.getQueryString();
        					
        				}
        				//CREATE TABLE `mail` (
        				//		  `mailid` int(11) NOT NULL AUTO_INCREMENT COMMENT '邮箱ID',
        				//		  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
        				//		  `mail` varchar(255) DEFAULT NULL COMMENT '邮箱',
        				//		  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
        				//		  `updatetime` datetime DEFAULT NULL COMMENT '最新修改时间',
        				//		  `count` int(11) DEFAULT NULL COMMENT '统计次数',
        				//		  `del` int(11) DEFAULT NULL,
        				//		  PRIMARY KEY (`mailid`)
        				//		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
        				//收集邮件信息
        				String mailusername;
						String mailmail;
						SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式  
        				if(param1.get("Action")!=null && param1.get("Action").equals("订阅")){
        					mailusername=new String(request.getParameter("username").getBytes("iso-8859-1"),"utf-8");
        					mailmail=new String(request.getParameter("mail").getBytes("iso-8859-1"),"utf-8");
        					DB.getRunner().update("insert into mail(username,mail,createtime) values(?,?,?)",mailusername,mailmail,df1.format(new Date()));
        					%>
        					<script type="text/javascript" language="javascript">
        							alert("感谢您的订阅提交，我们将在2个工作日内给您发送邮件");                                            // 弹出错误信息
        							window.location="<%=urlfootor%>" ;                            // 跳转到登录界面
        					</script>
        				<%
        				}
        				%>
        					<h4>邮箱订阅/Newsletter</h4>
        					<form action="<%=urlfootor%>" class="input-group" method="POST">
        						<input type="text" name="username" placeholder="姓名"/>
        						<input type="text" name="mail" placeholder="邮箱"/>
        						<span class="mr20">把最新鲜的东西呈现给您</span><input type="submit" name="Action" value="订阅" />
        					</form>
        				</div>
        				<div class="ewm-box">
        					<img src="img/ewm02_03.jpg">
        				</div>
        			</div>
        		</div>
        	</div>
        </div>
        <!--页面底部板块结束-->
        <!--返回顶部-->
		<div id="topcontrol" style="position: fixed; bottom: 80px; right: 30px;cursor: pointer; z-index: 9; display: none;" title="返回顶部">
			<img style="width:50px; height:50px;" src="img/gotop.jpg">
		</div>
		<!--返回顶部结束-->
		<script>
	window._bd_share_config = {
		common : {
			bdText : '饺耳',	
			bdDesc : '饺耳首页',	
			bdUrl : 'front_index.jsp', 	
			bdPic : 'img/logo_03.jpg'
		},
		share : [{
			"bdSize" : 16
		}],
		slide : [{	   
			bdImg : 0,
			bdPos : "right",
			bdTop : 100
		}],
		image : [{
			viewType : 'list',
			viewPos : 'top',
			viewColor : 'black',
			viewSize : '16',
			viewList : ['qzone','tsina','huaban','tqq','renren']
		}],
		selectShare : [{
			"bdselectMiniList" : ['qzone','tqq','kaixin001','bdxc','tqf']
		}]
	}
	with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
</script>
</body>
</html>