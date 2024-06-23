<%@ page import="java.sql.*, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Details</title>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .reset-form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .error-message {
            color: red;
            margin-top: -10px;
            margin-bottom: 10px;
        }

        button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<%
	String userEmail = (String)session.getAttribute("email");
    // Database connection parameters
    //out.println(userEmail);
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        String url = "jdbc:mysql://localhost:3306/admin_betting";
        String dbUser = "admin_root";
        String dbPassword = "ET&NhwLo1W!j";
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Validate user credentials and fetch details
        String sql = "SELECT username,password FROM users WHERE email=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userEmail);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // User found, display details
            String user = rs.getString("username");
            String pass = rs.getString("password");

            // Display user details
%>
            <html>
            <head>
                <title>Login Success</title>
            </head>
            <body>
               
             <div class="reset-form">
			    <h2>Password Reset</h2>
			    <p>Enter your new password below.</p>
			    <p>Username : <%= user %></p>
                
			  <form action="Conform_reset.jsp" method="post" onsubmit="return validateForm()">
			        <label for="password">New Password:</label>
			        <input type="password" id="password" name="password" required>
			
			        <label for="confirm-password">Confirm Password:</label>
			        <input type="password" id="confirm-password" name="confirm-password" required>
			        <div class="error-message" id="password-error"></div>
			
			        <button type="submit">Reset Password</button>
			    </form>
			
			    <script>
			        function validateForm() {
			            var password = document.getElementById('password').value;
			            var confirmPassword = document.getElementById('confirm-password').value;
			            var errorDiv = document.getElementById('password-error');
			
			            if (password !== confirmPassword) {
			                errorDiv.innerHTML = 'Passwords do not match.';
			                return false;
			            } else {
			                errorDiv.innerHTML = '';
			                return true;
			            }
			        }
			    </script>
			</div>
          		  	 
            	    
            </body>
            </html>
<%
        } else {
            // User not found, display error message
%>
            <html>
            <head>
                <title>Login Failed</title>
            </head>
            <body>
                <h2> Failed. </h2>
                <p><a href="index.html">Back to Login</a></p>
            </body>
            </html>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>