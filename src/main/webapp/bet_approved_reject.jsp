<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Investment Status to Rejected</title>
</head>
<body>
<%
    String username = request.getParameter("username");

    Connection connection = null;
    PreparedStatement updateBetStatement = null;

    try {
        // Establish a connection to the database
        String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
        String dbUsername = "admin_root";
        String dbPassword = "ET&NhwLo1W!j";

        connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

        // Assuming 'bet_id' is available as a request parameter
        int betId = Integer.parseInt(request.getParameter("bet_id"));

        // Update the invest_status to 'rejected' in the 'bet' table
        String updateInvestStatusQuery = "UPDATE bet SET invest_status = 'rejected' WHERE bet_id = ?";
        updateBetStatement = connection.prepareStatement(updateInvestStatusQuery);
        updateBetStatement.setInt(1, betId);
        updateBetStatement.executeUpdate();

        out.println("<p>Investment status updated to 'rejected'.</p>");
        response.sendRedirect("bet_approve.jsp");

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        try {
            if (updateBetStatement != null) updateBetStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
