package com.mail.bean;




import java.util.*;

import javax.mail.Session;
import javax.mail.Message;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.InternetAddress;
import javax.mail.Message.RecipientType;
import javax.mail.Transport;
import javax.mail.MessagingException;

public class sendMail {
	
	String username="18244686060@163.com";//发邮件的邮箱
	
	private Message getMessage(){

		Properties p=new Properties();
		p.put("mail.transport.protocol","smtp");
		p.put("mail.smtp.host","smtp.163.com");
		p.put("mail.smtp.port","25");
		p.put("mail.smtp.auth","true");
		
		
		String password="huang920127";//该邮箱的密码
		MyAuthor auth=new MyAuthor(username,password);
		Session session=Session.getDefaultInstance(p,auth);
		Message message=new MimeMessage(session);
		
		return message;
	}
		
	
	
	public void sendVerify(String stu_email,String stu_nameMd5,String randMd5,String stu_name,String stu_password)
	throws MessagingException {
		System.out.println("register sendmail");
		Message message=getMessage();
		
			message.setFrom(new InternetAddress(username));
			message.setRecipient(RecipientType.TO,new InternetAddress(stu_email));
			message.setSentDate(new Date());
			
			/*message.setSubject("博客邮箱验证");
			String m="<a href=\"http://huahuashen.com/javamail/mailVerify?stu_nameMd5="+stu_nameMd5+"&randMd5="+randMd5+"\">" +
					"http://huahuashen.com/javamail/mailVerify?stu_nameMd5="+stu_nameMd5+"&randMd5="+randMd5+"</a>";*/
			message.setSubject("博客邮箱验证");
			String m="<a href=\"http://192.168.108.165:8080/javamail/mailVerify?stu_nameMd5="+stu_nameMd5+"&randMd5="+randMd5+"&stu_name="+stu_name+"&stu_password="+stu_password+"&stu_email="+stu_email+"\">" +
					"http://192.168.108.165:8080/javamail/mailVerify?stu_nameMd5="+stu_nameMd5+"&randMd5="+randMd5+"</a>";
			
			//"169.254.72.1660"为本人电脑临时IP地址
			
			
			message.setContent(m,"text/html;charset=gb2312");
			
			Transport.send(message);
			
		}
	
	public void sendReset(String stu_email,String stu_nameMd5,String randMd5)
	throws MessagingException {
		System.out.println("reset sendmail");
		Message message=getMessage();
		message.setFrom(new InternetAddress(username));
		message.setRecipient(RecipientType.TO,new InternetAddress(stu_email));
		message.setSentDate(new Date());
		message.setSubject("博客邮箱验证");
		
		String m="<a href=\"http://192.168.108.165:8080/javamail/mailReset?stu_nameMd5="+stu_nameMd5+"&randMd5="+randMd5+"\">" +
				"http://192.168.108.165:8080/javamail/mailReset?stu_nameMd5="+stu_nameMd5+"&randMd5="+randMd5+"</a>";
		
		
		
		
		message.setContent(m,"text/html;charset=gb2312");
		
		Transport.send(message);
		
	}
	
	

}
