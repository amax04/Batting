<%@ page import="java.sql.*, java.io.* " %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.security.*" %>
<%@ page import="java.util.Base64" %>

<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/admin_betting";
    String user = "admin_root";
    String password = "ET&NhwLo1W!j";

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        // Establish the database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, password);

        // Get parameters from the request
        String userEmail =(String) session.getAttribute("email");
        String newPassword = request.getParameter("password");

        // Hash the new password before updating
       

        // Update the password in the database
        String sqlUpdate = "UPDATE users SET password = ? WHERE email = ?";
        preparedStatement = connection.prepareStatement(sqlUpdate);
        preparedStatement.setString(1, newPassword);
        preparedStatement.setString(2, userEmail);
        int rowsAffected = preparedStatement.executeUpdate();

        if (rowsAffected > 0) {
            out.println("Password updated successfully!");
            out.println("<a href='index.html'>Go Back To Login!</a>");
        } else {
            out.println("Failed to update password. User not found.");
            out.println("<a href='index.html'>Go Back!</a>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        // Close the database connections
        try {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
%>
