<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%//获取url
HashMap<String,String> param1= G.getParamMap(request);
String  urlfootor;
String patha = request.getContextPath();  
String basePatha = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+patha+"/";   
String servletPatha=request.getServletPath();    
String requestURIa=request.getRequestURI();  
System.out.println("path:"+patha);  
System.out.println("basePath:"+basePatha);   
System.out.println("servletPath:"+servletPatha);   
if(request.getQueryString()==null){
	urlfootor=requestURIa;
	
}else{
	urlfootor=requestURIa+"?"+request.getQueryString();
	
} 
if(servletPatha.equals("/admin_info.jsp")){
	System.out.println("d"+request.getParameter("caid"));
	%>
	<script type="text/javascript">
		$("#d<%=request.getParameter("caid")%>").addClass("on"); 
	 </script><%
}
%>
<div class="leftnav">

  <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>
  <h2><span class="icon-user"></span>管理页面</h2>
  <ul style="display:block">
    <li>
    	<h4><span class="icon-caret-right"></span>系统信息</h4>
    	<div class="tree-p">
    		<p class="mb0" ><a href="admin_info.jsp?caid=1" id="d1">系统检测</a></p>
    		<p class="mb0" ><a href="admin_info.jsp" style="color:#0ae;">版权信息</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>主题管理</h4>
    	<div class="tree-p" style="display:block">
    		<p class="mb0"><a href="admin_info.jsp?caid=2" class="on" >添加新主题</a></p>
    		<p class="mb0"><a href="admin_list.jsp?caid=3" >主题列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>后台用户</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加用户</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >用户列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>数据管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >备份数据库</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >还原数据库</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >备份数据列表</a></p>
    	</div>
    </li>
  </ul>   
  <h2><span class="icon-pencil-square-o"></span>栏目管理</h2>
  <ul>
  	<li>
    	<h4><span class="icon-caret-right"></span>中文栏目管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加一级栏目</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >栏目列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>中文留言管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >留言列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>英文栏目管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加一级栏目</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >栏目列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>英文留言管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >留言列表</a></p>
    	</div>
    </li>
  </ul>
  <h2><span class="icon-asterisk"></span>中文系统设置</h2>
  <ul>
  	<li>
    	<h4><span class="icon-caret-right"></span>中文网站设置</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >网站信息设置</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >网站客服设置</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>中文导航管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加一级导航</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >一级导航列表</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >添加二级导航</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >二级导航列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>中文广告管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >广告位置管理</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >添加广告</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >广告列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>中文友情链接</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加链接</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >链接列表</a></p>
    	</div>
    </li>
  </ul>
  <h2><span class="icon-file-alt"></span>中文内容管理</h2>
  <ul>
  	<li>
    	<h4><span class="icon-caret-right"></span>中文文章管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加文字</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >文章列表</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >文章关键词</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >文章来源</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>中文产品管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加产品</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >产品列表</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >订单管理</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>中文案例管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加案例</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >案例列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>中文招聘管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加招聘职位</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >招聘职位列表</a></p>
    	</div>
    </li>
  </ul>
  <h2><span class="icon-certificate"></span>英文系统设置</h2>
  <ul>
  	<li>
    	<h4><span class="icon-caret-right"></span>英文网站设置</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >网站信息设置</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>英文导航管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加一级导航</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >一级导航列表</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >添加二级导航</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >二级导航列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>英文广告管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >广告位置管理</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >添加广告</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >广告列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>英文友情链接</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加链接</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >链接列表</a></p>
    	</div>
    </li>
  </ul>
  <h2><span class="icon-file"></span>英文内容管理</h2>
  <ul>
  	<li>
    	<h4><span class="icon-caret-right"></span>英文文章管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加文字</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >文章列表</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >文章关键词</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >文章来源</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>英文产品管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加产品</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >产品列表</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >订单管理</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>英文案例管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加案例</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >案例列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>英文招聘管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加招聘职位</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >招聘职位列表</a></p>
    	</div>
    </li>
  </ul>
  <h2><span class="icon-wrench"></span>高级设置</h2>
  <ul>
  	<li>
    	<h4><span class="icon-caret-right"></span>主题管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加主题</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >主题列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>模板分类</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加新模板分类</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >模板分类列表</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>模板管理</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >添加新模板</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >模板列表</a></p>
    	</div>
    </li>
  </ul>
  <h2><span class="icon-desktop"></span>静态管理</h2>
  <ul>
  	<li>
    	<h4><span class="icon-caret-right"></span>生成中文</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_info.jsp" >生成中文首页</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >生成中文栏目</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >生成中文内容</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >生成中文所有</a></p>
    	</div>
    </li>
    <li>
    	<h4><span class="icon-caret-right"></span>生成英文</h4>
    	<div class="tree-p">
    		<p class="mb0"><a href="admin_add.jsp" >生成英文首页</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >生成英文栏目</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >生成英文内容</a></p>
    		<p class="mb0"><a href="admin_info.jsp" >生成英文所有</a></p>
    	</div>
    </li>
  </ul>
</div>
<script type="text/javascript">
$(function(){
  $(".leftnav h2").click(function(){
	  $(this).next().slideToggle(200);	
	  $(this).toggleClass("on"); 
  })
  $(".leftnav h4").click(function(){
	  $(this).next().slideToggle(200);	 
  })
//$(".leftnav ul li a").click(function(){
//	    $("#a_leader_txt").text($(this).text());
//		$(".leftnav ul li a").removeClass("on");
//		$(this).addClass("on");
//})
});
</script>