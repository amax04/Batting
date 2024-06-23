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
	String userEnteredOtp = request.getParameter("otp");
	
	String storedOtp = (String) session.getAttribute("otp");
	
	if (userEnteredOtp.equals(storedOtp)) {
        response.getWriter().println("OTP verification successful!");
        response.sendRedirect("reset.jsp");
    } else {
        response.getWriter().println("Incorrect OTP. Please try again.");
        out.println("<a href='forget_form.html'>go back</a>");
    }
%>
</body>
</html>