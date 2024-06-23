<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Investment Status</title>
    </head>
<body>
<%
    String username = request.getParameter("username");

		
	Connection connection = null;
	PreparedStatement checkBalanceStatement = null;
	PreparedStatement updateBetStatement = null;
	PreparedStatement updateBalanceStatement = null;
	PreparedStatement updateProfitStatement = null;
	ResultSet resultSet = null;
	
	try { 
    // Establish a connection to the database
    String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
    String dbUsername = "admin_root";
    String dbPassword = "ET&NhwLo1W!j";

    connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

    // Check if the balance is greater than the purchase_amount
    String checkBalanceQuery = "SELECT balance FROM users WHERE username = ?";
    checkBalanceStatement = connection.prepareStatement(checkBalanceQuery);
    checkBalanceStatement.setString(1, username);
    resultSet = checkBalanceStatement.executeQuery();

    if (resultSet.next()) {
        double balance = resultSet.getDouble("balance");

        // Assuming 'bet_id' is available as a request parameter
        int betId = Integer.parseInt(request.getParameter("bet_id"));

        // Retrieve purchase_amount and earning_amount from the 'bet' table
        String getBetDetailsQuery = "SELECT purchase_amount, earning_amount FROM bet WHERE bet_id = ?";
        PreparedStatement getBetDetailsStatement = connection.prepareStatement(getBetDetailsQuery);
        getBetDetailsStatement.setInt(1, betId);
        ResultSet betDetailsResultSet = getBetDetailsStatement.executeQuery();

        if (betDetailsResultSet.next()) {
            double purchaseAmount = betDetailsResultSet.getDouble("purchase_amount");
            double earningAmount = betDetailsResultSet.getDouble("earning_amount");

            if (balance >= purchaseAmount) {
                // Deduct the purchase_amount from the balance
                double newBalance = balance - purchaseAmount;

                // Update the balance in the 'users' table
                String updateBalanceQuery = "UPDATE users SET balance = ?, total_invest = total_invest + ? WHERE username = ?";
                updateBalanceStatement = connection.prepareStatement(updateBalanceQuery);
                updateBalanceStatement.setDouble(1, newBalance);
                updateBalanceStatement.setDouble(2, purchaseAmount);
                updateBalanceStatement.setString(3, username);
                updateBalanceStatement.executeUpdate();

                // Update the total_profit in the 'users' table
                String updateProfitQuery = "UPDATE users SET total_profit = total_profit + ? WHERE username = ?";
                updateProfitStatement = connection.prepareStatement(updateProfitQuery);
                updateProfitStatement.setDouble(1, earningAmount);
                updateProfitStatement.setString(2, username);
                updateProfitStatement.executeUpdate();

                // Update the invest_status to 'completed' in the 'bet' table
                String updateInvestStatusQuery = "UPDATE bet SET invest_status = 'completed' WHERE bet_id = ?";
                updateBetStatement = connection.prepareStatement(updateInvestStatusQuery);
                updateBetStatement.setInt(1, betId);
                updateBetStatement.executeUpdate();


                    out.println("<p>Investment status updated to 'completed'. Balance deducted successfully.</p>");
                    response.sendRedirect("bet_approve.jsp");
                } else {
                    out.println("<p>Insufficient balance for the investment.</p> <br> <a href='bet_approve.jsp'>Go back!</a>");
                }
            }
        } else {
            out.println("<p>User not found.</p>");
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        try {
            if (resultSet != null) resultSet.close();
            if (checkBalanceStatement != null) checkBalanceStatement.close();
            if (updateBetStatement != null) updateBetStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
