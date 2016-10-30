package com.mail.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

import com.mail.bean.*;


public class login extends HttpServlet{
	
	public void doGet(HttpServletRequest request,HttpServletResponse response)
	throws ServletException,IOException{
		doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response)
	throws ServletException,IOException {
		
		ConDB con;
		boolean exist;
		String msg;
		HttpSession session=request.getSession();
		String stu_name=request.getParameter("stu_name");
		String stu_password=request.getParameter("stu_password");
		try{
			con=new ConDB();
			exist=con.existStudent(stu_name,stu_password);
			if(exist){
				msg="你已经成功登陆"+stu_name+stu_password;
			}else{
				msg="用户名或密码错误";
			}
			
			session.setAttribute("msg",msg);
			response.sendRedirect("mail_result.jsp");
			con.close();
		}catch(SQLException e){
			e.printStackTrace();
			throw new ServletException(e.fillInStackTrace());
		} 
		
		
		
	}
	

}
