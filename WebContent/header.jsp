<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>
<%

//导航信息
List<Mapx<String, Object>> top_daohang= DB.getRunner().query("SELECT * FROM daohang_type where parentid=0", new MapxListHandler());
//String url1 = request.getScheme()+"://"+ request.getServerName()+request.getRequestURI()+"?"+request.getQueryString(); 
//获取用户角色
List<Mapx<String, Object>> juese=DB.getRunner().query("select userrole from user where username=?", new MapxListHandler(), username);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>
<!--顶部开始-->
        <div class="header">
        	<div class="container">
        		<div class="row">
	        		<div class="top clearfix">
	        				<div class="dropdown fr">
							  <a class="dropdown-toggle" href="" id="dropdownMenu1" data-toggle="dropdown">
							            更多语言
							    <span class="caret"></span>
							  </a>
							  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
							    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">语言1</a></li>
							    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">语言2</a></li>
							    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">语言3</a></li>
							    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">语言4</a></li>
							  </ul>
							</div>
	        				<p class="fr">选择语言：<a href="" >简体中文</a><span>|</span><a href="" >繁体中文</a><span>|</span><a href="" >English</a><span>|</span></p>
	        		</div>
        		</div>
        		<div class="row">
	        		<div class="head clearfix">
	        			<div class="logo fl"><a href="front_index.jsp"><img src="img/duoyeLOGO.png"></a></div>
	        			<div class="tell fl">
	        				<p><span>010-8994<strong>2510</strong></span></p>
	        			</div>
	        			<%//获取url
        				HashMap<String,String> param2= G.getParamMap(request);
        				String  urlfootor2;
        				String pathb = request.getContextPath();  
        				String basePathb = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+pathb+"/";   
        				String servletPathb=request.getServletPath();    
        				String requestURIb=request.getRequestURI();  
        				//System.out.println("path:"+pathb);  
        				//System.out.println("basePath:"+basePathb);   
        				//System.out.println("servletPath:"+servletPathb);   
        				if(request.getQueryString()==null){
        					urlfootor2=requestURIb;
        				}else{
        					urlfootor2=requestURIb+"?"+request.getQueryString();
        				}%>
	        			<div class="search fr">
	        				<div class="resiter fr">
								<%if(flag==1){ 
									if(juese.get(0).getStringView("userrole").equals("管理员")){
									%>
									<span class="glyphicon glyphicon-user"></span><a><%=username %></a>/<a href="front_login.jsp" >退出</a>/<a href="${pageContext.request.contextPath}/admin_boke_edit.jsp">用户中心</a>
									<%}else{ %>
									<span class="glyphicon glyphicon-user"></span><a><%=username %></a>/<a href="front_login.jsp" >退出</a>
								<%}}else{ %>
								<span class="glyphicon glyphicon-user"></span><a href="front_login.jsp" target="_blank">登陆</a>/<a href="front_reg.jsp" target="_blank">注册</a>
							<%} %>
							</div>
	        				<div class="input-group fr">
							 <form  method="post" id="subform">
							  <input placeholder="请输入搜索内容"  type="text" class="form-control" name="search" onfocus="javascript:this.value=''"  id="ipt1">
							  <input class="input-group-addon cursor" type="submit" name="search_submit" value="搜索"  id="btn1" onclick="checkform()" >
							 </form>
							<script type="text/javascript">    
							function checkform(){ 
								if((document.getElementById('ipt1').value.length==0)||(document.getElementById('ipt1').value=="请输入搜索内容")){    
									alert('输入为空！');
									document.getElementById('ipt1').focus();
									return false;
								}else{
									var testform=document.getElementById("subform");
									testform.action="front_news.jsp?page=0";
									testform.submit();
								}
							}
							</script>
							</div>
	        			</div>
	        		</div>
        		</div>
        	</div>
        </div>	
        <!--顶部结束-->
        
</body>
</html>