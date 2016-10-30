<%@page import="java.net.URLEncoder"%>
<%@page import="com.mchange.v2.c3p0.impl.DbAuth"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.dbutils.QueryRunner" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
HashMap<String,String> param= G.getParamMap(request);
if(param==null){//临时，未正式交付，无法创建新用户
	response.sendRedirect("yd_front_login.jsp");
	return;
}
HashMap<String,Object> myparam = new HashMap<String,Object>();//存储自用的一些变量
String opt = param.get("opt");
if(opt==null){
	opt="add";
	param.put("opt",opt);
}
if(opt.equals("add")){//创建用户
	int id = Ukey.getKey("user");
	param.put("id", ""+id);
}
System.out.println(param.get("id"));
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
System.out.println(df.format(new Date()));// new Date()为获取当前系统时间
///保存用户注册信息 -start  下面定义的变量 仅在此处使用     
if(param.get("Action")!=null && param.get("Action").equals("注册")){
	List<String> errors = new ArrayList<String>();
			int id = Integer.parseInt(param.get("id"));
			String name = (String)G.commonCheckx(errors,param.get("username"),"用户名","must","string","between,2,50");
			String phone = (String)G.commonCheckx(errors,param.get("phone"),"电话","phone","string","between,11,20");
			String mail = (String)G.commonCheckx(errors,param.get("mail"),"邮箱","mail","string","between,5,50");
			String password = (String)G.commonCheckx(errors,param.get("password"),"密码","must","string","between,6,50");
			String password2 = (String)G.commonCheckx(errors,param.get("password2"),"密码确认","must","string","between,6,50");
			if(errors.size()>0){
				System.out.println(errors);%>
				<script type="text/javascript" language="javascript">
					alert("<%=errors%>");                                            // 弹出错误信息
					//window.location='front_reg.jsp' ; 
				</script>
			<%}else{//普通验证通过，继续确认
				if(!password.equals(password2)){
					errors.add("两次输入密码不一致");
					myparam.put("errorStr", G.toErrorStr(errors));
				}else{//验证通过，存库
					password = DesUtils.encrypt(password);
					DB.getRunner().update("insert into user(userid,username,password,shenhe,status,createtime,phone,mail) values(?,?,?,?,?,?,?,?)", id,name,password,"审核通过","有效",df.format(new Date()),phone,mail);
					myparam.put("addResult", "1");
					out.print("<script>alert('注册成功'); window.location='yd_front_index.jsp' </script>");
					//response.sendRedirect("front_boke.jsp");
				}
			}
		}
///end
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
		<meta name="description" content="饺耳世家">
		<meta name="keywords" content="饺耳世家、美食">
		<title>注册饺耳</title>
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
				<form class="form-group" action="yd_front_register.jsp" method="POST">
				<input type="hidden" name="opt" value="addsave">
					<input type="hidden" name="usertype" value="<%= param.get("usertype")==null?"":param.get("usertype") %>">
					<input type="text" style="visibility: hidden;" readOnly="true" class="text"  autocomplete="off" name="id"
		                   onpaste="return false;" value="<%= param.get("id")==null?"":param.get("id") %>">
					<div class="cell">
						<div class="weui_cell_hd"><label class="weui_label">用户名</label></div>
						<div class="cell_primary">
							<input class="weui_input" placeholder="请输入用户名" value="<%= param.get("username")==null?"":param.get("username") %>" type="text" autocomplete="off" name="username"  maxlength="11">
						</div>
					</div>
					<div class="cell">
						<div class="weui_cell_hd"><label class="weui_label">手机号</label></div>
						<div class="cell_primary">
							<input class="weui_input" placeholder="请输入手机号" value="<%= param.get("phone")==null?"":param.get("phone") %>" type="tel" autocomplete="off" name="phone" id="phone" maxlength="11">
						</div>
					</div>
								<%if(false) {%>
			<script type="text/javascript" language="javascript">
				document.write('<span style="color:red;margin-top:-5px;">请输入正确的手机号</span>'); // 手机号验证
			</script>
			<%}%>
					<div class="cell">
						<div class="weui_cell_hd"><label class="weui_label">邮箱</label></div>
						<div class="cell_primary">
							<input class="weui_input" placeholder="请输入邮箱" value="<%= param.get("mail")==null?"":param.get("mail") %>" type="text" autocomplete="off" name="mail" >
						</div>
					</div>
					<div class="cell">
						<div class="weui_cell_hd"><label class="weui_label">密码</label></div>
						<div class="cell_primary">
							<input class="weui_input" placeholder="请输入6-8位密码" value="<%= param.get("password")==null?"":param.get("password") %>" type="password" autocomplete="off" name="password" maxlength="8">
						</div>
					</div>
					<div class="cell" style="margin-bottom: 30px;">
						<div class="weui_cell_hd"><label class="weui_label">确认密码</label></div>
						<div class="cell_primary">
							<input class="weui_input" placeholder="请输入6-8位密码" value="<%= param.get("password2")==null?"":param.get("password2") %>" type="password" autocomplete="off" name="password2" maxlength="8">
						</div>
					</div>
					<input class="input-btn" type="submit" Name="Action" value="注册" />
				</form>
				<div class="User-notes">理解并同意饺耳的<a href="" style="text-decoration: underline; color: #e2e2e2;">用户协议</a></div>
			</div>
		</div>
<!--获取验证码部分JS-->
	<script>
	$(function(){
	  $('.get-validate').click(function(){
		  $('.get-validate').hide();
		  $('.wait-validate').show();
	   });	
		
	});
	</script>
	<script>
	//手机号 规则匹配
	//function checkPhone(){ var phone = document.getElementById('phone').value; if(!(/^1[3|4|5|7|8]\d{9}$/.test(phone))){ alert("手机号码有误，请重填"); return false; } }
	//JS正则验证邮箱的格式
	function test()
        {
           var temp = document.getElementById("mail");
           //对电子邮件的验证
           var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
           if(!myreg.test(temp.value))
           {
                alert('提示\n\n请输入有效的E_mail！');
                myreg.focus();
                return false;
           }
        }
	</script>	
	<script type="text/javascript">  
	//电子邮箱正则表达式  
	var tel=document.getElementById("teltext");      if(!(reg.test(tel))){           alert("不是正确的11位手机号");          document.getElementById("teltext").Value="";      }else{            }}  
	//检查输入的数据是不是邮箱格式  function checkemail(){
	var email = document.getElementById("emailtext");    
	//获取email控件对象         
	var reg =/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	//正则表达式        
	if (!reg.test(email.Value)) {                    alert("邮箱格式错误，请重新输入！");                    emailtext.focus();                    document.getElementById("emailtext").Value="";                      return;                    }          }    

</script>
	</body>
</html>
