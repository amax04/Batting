<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Define database connection parameters
    String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
    String dbUser = "admin_root";
    String dbPassword = "ET&NhwLo1W!j";

    // Get the transaction_id parameter from the request
    String transactionIdParam = request.getParameter("transaction_id");

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection to the database
        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // Update transaction status to 'rejected'
        String updateTransactionStatusQuery = "UPDATE transaction SET transaction_status = 'rejected' WHERE transaction_id = ?";
        try (PreparedStatement updateTransactionStatusStatement = connection.prepareStatement(updateTransactionStatusQuery)) {
            updateTransactionStatusStatement.setInt(1, Integer.parseInt(transactionIdParam));
            updateTransactionStatusStatement.executeUpdate();
        }
        response.sendRedirect("transaction_control.jsp");
        // Close resources
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
        // Handle database errors or redirect to an error page
        
        out.println("<P>Error occurs !</P>");
        out.println("<a href='transaction_control.jsp'> Go Back!</a>");
    }
%>

