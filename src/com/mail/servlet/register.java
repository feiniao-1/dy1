package com.mail.servlet;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.SQLException;
import java.security.NoSuchAlgorithmException;

import javax.mail.MessagingException;

import com.jx.common.DB;
import com.jx.common.Mapx;
import com.jx.common.MapxListHandler;
import com.mail.bean.*;

public class register extends HttpServlet{
	public void doGet(HttpServletRequest request, 
			HttpServletResponse response)
	throws ServletException,IOException {
		doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request,
			HttpServletResponse response)
	throws ServletException,IOException {
		ConDB con;
		String msg;
		sendMail send;
		md5 md5new;
		random rand;
		HttpSession session=request.getSession();
		String stu_name=request.getParameter("stu_name");
		String stu_password=request.getParameter("stu_password");
		String stu_email=request.getParameter("stu_email");
		
		try {
			System.out.println("try");
			con=new ConDB();
			con.addStudentTemp(stu_name,stu_password,stu_email);
			md5new=new md5();
			String stu_nameMd5=md5new.getMD5Str(stu_name);
			rand=new random();
			String randMd5=md5new.getMD5Str(String.valueOf(rand.getInt()));
			con.addVerify(stu_name,stu_nameMd5,randMd5);
			send=new sendMail();
			send.sendVerify(stu_email,stu_nameMd5,randMd5,stu_name,stu_password);
			msg="邮件已发送到你的邮箱,请确认完成注册";
			con.close();
			session.setAttribute("msg",msg);
			System.out.println("msg"+msg);
			response.sendRedirect("result.jsp");
		}catch(SQLException e){
			System.out.println("catch1");
			e.printStackTrace();
			//throw new IOException(e.fillInStackTrace());
			throw new ServletException(e.fillInStackTrace());
		}catch(NoSuchAlgorithmException e){
			System.out.println("catch3");
			e.printStackTrace();
			//throw new IOException(e.fillInStackTrace());
			throw new ServletException(e.fillInStackTrace());
		}catch(MessagingException e){
			System.out.println("catch4");
			e.printStackTrace();
			System.out.println("catch4-1");
			//throw new IOException(e.fillInStackTrace());
			throw new ServletException(e.fillInStackTrace());
			
		}
		
	}

}
