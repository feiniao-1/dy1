package com.mail.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.sql.SQLException;

import com.mail.bean.*;

public class mailReset extends HttpServlet {
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
		
		HttpSession session=request.getSession();
		
		String stu_nameMd5=request.getParameter("stu_nameMd5");
		String randMd5=request.getParameter("randMd5");
		
		try {
		con =new ConDB();
		String stu_name=con.getLegalReset(stu_nameMd5,randMd5);
		
		if(stu_name!=null){
			msg="你的密码已被重置为'123456'";
			con.resetPassword(stu_name,"123456");
			con.delReset(stu_name);
			
		}else{
			msg="错误";
		}
		session.setAttribute("msg",msg);
		response.sendRedirect("mail_result.jsp");
		}catch(Exception e){
			throw new ServletException(e.fillInStackTrace());
		}
	}
		

}
