package com.mail.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import java.sql.SQLException;
import java.security.NoSuchAlgorithmException;

import javax.mail.MessagingException;

import com.jx.common.DB;
import com.jx.common.Mapx;
import com.jx.common.MapxListHandler;
import com.mail.bean.*;

public class reset extends HttpServlet{
	public void doGet(HttpServletRequest request, 
			HttpServletResponse response)
	throws ServletException,IOException {
		doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request,
			HttpServletResponse response)
	throws ServletException,IOException {
		
		md5 md5new;
		random rand;
		sendMail send;
		HttpSession session=request.getSession();
		String msg;
		
		try {
		String stu_email=request.getParameter("stu_email");
		System.out.println("重置密码的邮箱：11"+stu_email);
		Mapx<String,Object> cz_mima = DB.getRunner().query("select stu_name from student where stu_email= ? limit 1", new MapxListHandler(), stu_email).get(0);
		System.out.println("cz_mima"+cz_mima);
		String stu_name=cz_mima.getStringView("stu_name");
		System.out.println("重置密码的邮箱的stu_name："+stu_name);
		if(stu_name!=null){
			System.out.println("No");
			md5new=new md5();
			String stu_nameMd5=md5new.getMD5Str(stu_name);
			rand=new random();
			String randMd5=md5new.getMD5Str(String.valueOf(rand.getInt()));
			System.out.println("1");
			Mapx<String,Object> reset_name = DB.getRunner().query("select * from reset where stu_name= ? ", new MapxListHandler(), stu_name).get(0);
			System.out.println(reset_name);
			if(reset_name!=null){
				System.out.println("Yes");
				DB.getRunner().update("update reset set stu_name = ? ,stu_nameMd5 = ? ,randMd5 = ? where stu_name=?",stu_name,stu_nameMd5,randMd5,stu_name );
			}else{
				System.out.println("No");
				DB.getRunner().update("insert into reset(stu_name,stu_nameMd5,randMd5) values(?,?,?)",stu_name,stu_nameMd5,randMd5);
			}
			System.out.println("2");
			send=new sendMail();
			send.sendReset(stu_email,stu_nameMd5,randMd5);
			msg="邮件已发送到你的邮箱,请确认重置密码";
		}else {
			System.out.println("Yes");
			msg="不存在此邮箱用户";
		}
		System.out.println("end");
		session.setAttribute("msg",msg);
		response.sendRedirect("mail_result.jsp");
		
		}
		catch(Exception e){
			throw new ServletException(e.fillInStackTrace());
		}
		
	}

}
