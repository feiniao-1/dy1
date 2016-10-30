<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head><title>Simple jsp page</title></head>
  <body>Place your content here

  here is a. jsp
    get header info
  <%=request.getHeader("Referer")%>
  <%if(null == request.getHeader("Referer") || request.getHeader("Referer").indexOf("huahuashen.com") < 0){%>
     做人要厚道
  <%}else{%>
  合法访问
  <%}%>
  </body>
</html>