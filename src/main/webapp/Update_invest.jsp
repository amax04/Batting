<%@ page import="java.sql.*, java.util.*, java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>

<%
	String id=(String)session.getAttribute("id");
	String user=(String)session.getAttribute("username");
	session.setAttribute("username", user);
    Connection connection = null;
    PreparedStatement updateStatement = null;
    ResultSet resultSet = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection to the database
        String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
        String username = "admin_root";
        String password = "ET&NhwLo1W!j";

        connection = DriverManager.getConnection(jdbcUrl, username, password);

        // Retrieve data from the users table
        String selectQuery = "SELECT total_invest FROM users where user_id="+id;
        Statement selectStatement = connection.createStatement();
        resultSet = selectStatement.executeQuery(selectQuery);

        // Update the balance column and set total_invest to 0
        String updateQuery = "UPDATE users SET balance = balance + ? , total_invest = 0 WHERE user_id = ?";
        updateStatement = connection.prepareStatement(updateQuery);

        if (resultSet.next()) {
            // Get values from the result set
            
            BigDecimal totalInvest = resultSet.getBigDecimal("total_invest");

            // Update the balance column and set total_invest to 0
            updateStatement.setBigDecimal(1, totalInvest);
            updateStatement.setInt(2, Integer.parseInt(id));
            int rowsAffected = updateStatement.executeUpdate();
         
		if(rowsAffected>0){
		
			response.sendRedirect("user_dashboard.jsp?id="+id);
		}
		else{
        // Print a message indicating the update was successful
        out.println("Balance update unsuccessful!");
		}
 }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        // Handle exceptions or redirect to an error page
    } finally {
        // Close the database resources
        try {
            if (resultSet != null) resultSet.close();
            if (updateStatement != null) updateStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
