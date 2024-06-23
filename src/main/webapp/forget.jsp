<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .forgot-password-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }

        .forgot-password-container h2 {
            text-align: center;
            color: #333;
        }

        .forgot-password-form {
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        .form-group button {
            background-color: #3498db;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
    </style>
</head>
<body>

<%
    String email = request.getParameter("email");
    

    // JDBC Connection details (update with your database information)
    String jdbcUrl =  "jdbc:mysql://localhost:3306/admin_betting";
    String dbUser = "admin_root";
    String dbPassword = "ET&NhwLo1W!j";

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the database connection
        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // Check if the email exists in the users table
        String query = "SELECT * FROM users WHERE email = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Email exists, you can proceed with password reset logic
                session.setAttribute("email", email);
                out.println("Email Found");
                
                response.sendRedirect("otpServlet.jsp");
             //<jsp:forward page="OtpServlet" /> 
             } else {
                // Email does not exist
                out.println("Email not found. Please check your email address.");
            }
        }

        // Close the database connection
        connection.close();

    } catch (Exception e) {
        e.printStackTrace();
       	out.println("Error: Unable to process your request.");
    }
%>


</body>
</html>
