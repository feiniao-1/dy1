package com.mail.servlet;

import java.io.IOException;

import javax.servlet.http.*;
import javax.servlet.ServletException;

import java.sql.SQLException;

import com.mail.bean.*;

public class mailVerify extends HttpServlet {
	public void doGet(HttpServletRequest request, 
			HttpServletResponse response)
	throws ServletException,IOException {
		doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request,
			HttpServletResponse response)
	throws ServletException,IOException {
		
		ConDB con;
		String stu_name;
		String msg;
		HttpSession session=request.getSession();
		
		String stu_nameMd5=request.getParameter("stu_nameMd5");
		String randMd5=request.getParameter("randMd5");
		
		try {
			con=new ConDB();
			stu_name=con.getVerify(stu_nameMd5,randMd5);
			if(stu_name!=null){
				msg="注册成功,请返回登录页面";
				con.addStudent(stu_name);
				con.delStudentTemp(stu_name);
				con.delVerify(stu_name);
				
			}else{msg="错误";}
			con.close();
			session.setAttribute("msg",msg);
			response.sendRedirect("mail_result.jsp");
			
		}catch(SQLException e){
			throw new ServletException(e.fillInStackTrace());
		}
		
	}

}