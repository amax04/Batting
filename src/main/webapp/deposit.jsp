<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String username=(String)session.getAttribute("username");
	out.println(username);
	session.setAttribute("username", username);
%>
	<br>
	<a href="user_dashboard.jsp">go back</a>
</body>
</html>