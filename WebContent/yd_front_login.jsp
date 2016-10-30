<%@page import="com.mchange.v2.c3p0.impl.DbAuth"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>

<% 
//退出
session.removeAttribute("username");
HashMap<String,String> param= G.getParamMap(request);
HashMap<String,Object> myparam=new HashMap<String,Object>();
List<String> errors=new ArrayList<String>();
if(param.get("opt")!=null && param.get("opt").equals("login")){
	if(param.get("str")==null || param.get("str").equals("") || param.get("password")==null || param.get("password").equals("")){//如果用户名 或密码填写的空值 则报错
		errors.add("用户名密码错误");
	}
	if(errors.size()==0){
		String password2 = DesUtils.encrypt(param.get("password")); // DesUtils加密
		System.out.println(password2);
		List<Mapx<String, Object>> listAll = DB.getRunner().query("select password ,userid from user where username=? ",new MapxListHandler(), param.get("str"));
		if((listAll==null || listAll.size()==0)){
		System.out.println("用户名不存在");
			errors.add("用户名不存在");
		}else if(listAll.get(0).getStringView("password").equals(password2)){//登陆成功
			System.out.println(" password YES");
			G.setCookie("token", G.getToken(listAll.get(0).getInt("userid"),param.get("password")), response);
			response.sendRedirect("yd_front_index.jsp");
			session.setAttribute("username", param.get("str"));
			return;
		}else{
			System.out.println(" password NO");
			errors.add("密码错误");
		}
	}
	myparam.put("errorStr", G.toErrorStr(errors));
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
		<title>登陆饺耳</title>
		<link href="images/top-icon.png" type="image/x-icon" rel="shortcut icon" />
		<link href="css/weui.css" rel="stylesheet">
		<link href="css/m-style.css" rel="stylesheet">
		<script src="js/jquery-1.11.1.min.js"></script>
		<style>
			html,body{ height: 100%!important;}
			.container{ width: 100%; height: 100%;}
		</style>
	</head>
	<body style="width: 100%;">
		<div class="container">
			<div class="wrapbox">
				<div class="back"><img src="images/back.png"></div>
				<div class="logo"><img src="images/M-logo.png"></div>
				<form class="form-group" action="yd_front_login.jsp" method="POST">
				<input type="hidden" name="referer"	value="<%=request.getHeader("referer") %>">
						<input type="hidden" name="opt" value="login">
					<div class="cell">
						<div class="icon"><img src="images/user.png"></div>
						<div class="cell_primary">
							<input class="weui_input" placeholder="请输入账号" value="" type="text" autocomplete="off" name="str"  maxlength="11">
						</div>
					</div>
					<div class="cell">
						<div class="icon"><img src="images/password.png"></div>
						<div class="cell_primary">
							<input class="weui_input" placeholder="请输入密码" value="" type="password" autocomplete="off" name="password" maxlength="8">
						</div>
					</div>
					<div class="cell" style="border: 0;">
						<div class="cell_primary" style="text-align: left;"><a href="yd_front_register.jsp" class="color-fff">新用户注册</a></div>
						<div class="cell_primary" style="text-align: right;"><a href="#" class="color-fff">忘记密码?</a></div>
					</div>
					<input class="input-btn" type="submit" value="登录" />
				</form>
				
				<div class="User-notes">理解并同意饺耳的<a href="" style="text-decoration: underline; color: #e2e2e2;">用户协议</a></div>
			</div>
		</div>
		<script>
	//手机号 规则匹配
function checkPhone(){ var phone = document.getElementById('phone').value; if(!(/^1[3|4|5|7|8]\d{9}$/.test(phone))){ alert("手机号码有误，请重填"); return false; } }
</script>	
	</body>
</html>
