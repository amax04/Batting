<%@ page import="javax.mail.MessagingException" %>
<%@ page import="com.OtpService" %>

<%
    try {
    	
        // Generate OTP
        String otp = OtpService.generateOTP();

        // Store OTP in session
        session.setAttribute("otp", otp);

        // Get user's email from the form
        String userEmail = (String) session.getAttribute("email");

        // Send OTP to user's email
        OtpService.sendOtpToEmail(userEmail, otp);

        // Forward to the verification page
        request.getRequestDispatcher("otp_verification.jsp").forward(request, response);
    } catch (MessagingException e) {
        e.printStackTrace();
        out.println("Error sending OTP. Please try again later.");
    }
%>
