<!-- processSignup.jsp -->
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String contactNumber = request.getParameter("contact");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // JDBC Connection
    Connection conn = null;
    PreparedStatement pstmtCheck = null;
    PreparedStatement pstmtInsert = null;
    ResultSet rs = null;

    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        String url = "jdbc:mysql://localhost:3306/admin_betting";
        String dbUser = "admin_root";
        String dbPassword = "ET&NhwLo1W!j";
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Check if username or email already exists
        String checkSql = "SELECT COUNT(*) AS count FROM users WHERE username=? OR email=? OR contact_number=?";
        pstmtCheck = conn.prepareStatement(checkSql);
        pstmtCheck.setString(1, username);
        pstmtCheck.setString(2, email);
        pstmtCheck.setString(3, contactNumber);
        rs = pstmtCheck.executeQuery();

        if (rs.next() && rs.getInt("count") > 0) {
            // User or email already exists, display error message
%>
            <html>
            <head>
                <title>Sign Up Failed</title>
            </head>
            <body>
                <h2>Sign Up Failed. Username or contact number or email already exists.</h2>
                <p><a href="signin.html">Back to Sign Up</a></p>
            </body>
            </html>
<%
        } else {
            // Username and email are unique, proceed with user insertion
            String insertSql = "INSERT INTO users (name, email, contact_number, username, password, balance, total_invest, total_profit) VALUES (?, ?, ?, ?, ?, 0.00, 0.00, 0.00)";
            pstmtInsert = conn.prepareStatement(insertSql);
            pstmtInsert.setString(1, name);
            pstmtInsert.setString(2, email);
            pstmtInsert.setString(3, contactNumber);
            pstmtInsert.setString(4, username);
            pstmtInsert.setString(5, password);
            pstmtInsert.executeUpdate();
%>
            <html>
            <head>
                <title>Sign Up Success</title>
            </head>
            <body>
                <h2>Sign Up Successful!</h2>
                <p>Name: <%= name %></p>
                <p>Email: <%= email %></p>
                <p>Contact Number: <%= contactNumber %></p>
                <p>Username: <%= username %></p>
                <!-- You might not want to display the password in production -->
                <p>Password: <%= password %></p>
                <p>Balance: $0.00</p>
                <p>Total Invested: $0.00</p>
                <p>Total Profit: $0.00</p>
                
                <h1>Sign up is Success.</h1>
    			<a href="index.html">go back to login</a>
            </body>
            </html>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmtCheck != null) pstmtCheck.close(); } catch (Exception e) {}
        try { if (pstmtInsert != null) pstmtInsert.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
