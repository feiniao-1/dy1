package com.mail.bean;




import java.sql.*;

public class ConDB {
	
	private Connection con;
	private Statement sta;
	private ResultSet res;
	private PreparedStatement pres;
	
	/*public ConDB() throws SQLException,ClassNotFoundException{
	
	
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://139.129.27.119:3306/blog",
					"root","mysql123");
			sta=con.createStatement();
	
	}*/
	
    public void addStudentTemp(String stu_name,String stu_password,String stu_email)
    throws SQLException{
    	
    	
    	String sql="insert into studentTemp values(?,?,?)";
    	pres=con.prepareStatement(sql);
    	
    	pres.setString(1,stu_name);
    	pres.setString(2,stu_password);
    	pres.setString(3,stu_email);
    	pres.executeUpdate();
    	
    }
    public void delStudentTemp(String stu_name)
    throws SQLException{
    	String sql="delete from studentTemp where stu_name='"+stu_name+"'";
    	sta.executeUpdate(sql);
    }
    
    
    public void addVerify(String stu_name,String stu_nameMd5,String randMd5)
    throws SQLException{
    	String sql="insert into verify values(?,?,?)";
    	pres=con.prepareStatement(sql);
    	
    	pres.setString(1,stu_name);
    	pres.setString(2,stu_nameMd5);
    	pres.setString(3,randMd5);
    	pres.executeUpdate();    	
    }
    public void delVerify(String stu_name)
    throws SQLException{
    	String sql="delete from verify where stu_name='"+stu_name+"'";
    	sta.executeUpdate(sql);
    }
    public String getVerify(String stu_nameMd5,String randMd5)
    throws SQLException{
    	String stu_name=null;
    	String sql="select stu_name from verify where stu_nameMd5=? and randMd5=?";
    	pres=con.prepareStatement(sql);
    	
    	pres.setString(1,stu_nameMd5);
    	pres.setString(2,randMd5);
    	res=pres.executeQuery();
    	while(res.next()){
    		stu_name=res.getString("stu_name");
    	}
    	return stu_name;
    }
    
    
    public void addStudent(String stu_name)
    throws SQLException{
    	String sql="insert into student select * from studentTemp where stu_name='"+stu_name+"'";
    	sta.executeUpdate(sql);
    }
    public String getStu_name(String stu_email)
    throws SQLException{
    
    	String sql="select stu_name from student where stu_email='"+stu_email+"'";
    	String stu_name=null;
    	
    	res=sta.executeQuery(sql);
    	while(res.next()){
    		stu_name=res.getString("stu_name");
    	}
    	
   
    return stu_name;
    }
    public void resetPassword(String stu_name,String stu_password)
    throws SQLException{
    	String sql="update student set stu_password=? where stu_name=?";
    	pres=con.prepareStatement(sql);
    	pres.setString(1,stu_password);
    	pres.setString(2,stu_name);
    	pres.executeUpdate();
    }
    public boolean existStudent(String stu_name,String stu_password)
    throws SQLException{
    	boolean exist=false;
    	String sql="select * from student where stu_name=? and stu_password=?";
    	pres=con.prepareStatement(sql);
    	pres.setString(1,stu_name);
    	pres.setString(2,stu_password);
    	res=pres.executeQuery();
    	if(res.next()){
    		exist=true;
    	}
    	return exist;
    }
    
    
    public void addReset(String stu_name,String stu_nameMd5,
    		String randMd5)
    throws SQLException {
    
    	String sql="insert into reset(stu_name,stu_nameMd5,randMd5) values(?,?,?)";
    	
    		pres=con.prepareStatement(sql);
    	
    	pres.setString(1,stu_name);
    	pres.setString(2,stu_nameMd5);
    	pres.setString(3,randMd5);
    	pres.executeUpdate();
    	
    	
    }
    public void delReset(String stu_name)
    throws SQLException {
    	String sql="delete from reset where stu_name='"+stu_name+"'";
    	sta.execute(sql);
    }
    public String getLegalReset(String stu_nameMd5,String randMd5)
    throws SQLException {
    	
    	String stu_name=null;
    	String sql="select stu_name, timestampdiff(hour,sent_time,now()) as hours from reset where stu_nameMd5=? and randMd5=?";
    	pres=con.prepareStatement(sql);
    	pres.setString(1,stu_nameMd5);
    	pres.setString(2,randMd5);
    	res=pres.executeQuery();
    	if(res.next()){
    		stu_name=res.getString("stu_name");
    		int h=res.getInt("hours");
    		if(h<=24){
    			return stu_name;
    		}
    	}
    	return stu_name; 	
    	    	
    }
	
	
	
	
	
	public void close() 
	throws SQLException {
	{
		
		if (res != null) {
			
				res.close();
			
		}
		if (sta != null) {
			
				sta.close();
			
		}
		
		if (con != null) {
			
				con.close();
				con = null;
			
		}
	}
	}

}
