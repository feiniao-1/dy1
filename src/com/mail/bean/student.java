package com.mail.bean;



public class student {
	
	private String stu_name;
	private String stu_password;
	private String stu_email;
	
	
	public student(){}
	
	public student(String stu_name,String stu_password,String stu_email){
		this.stu_name=stu_name;
		this.stu_password=stu_password;
		this.stu_email=stu_email;
	}
	
	
	public void setName(String stu_name){
		this.stu_name=stu_name;
	}
	public String getName(){
		return this.stu_name;
	}
	
	public void setPassword(String stu_password){
		this.stu_password=stu_password;
	}
	public String getPassword(){
		return this.stu_password;
	}
	
	public void setEmail(String stu_email){
		this.stu_email=stu_email;
	}
	public String getEmail(){
		return this.stu_email;
	}
	

}
