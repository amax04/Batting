<%@ page import="java.sql.*,java.math.BigDecimal" %>
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

        // Retrieve transaction details from the 'transaction' table
        String selectQuery = "SELECT * FROM transaction WHERE transaction_id = ?";
        try (PreparedStatement selectStatement = connection.prepareStatement(selectQuery)) {
            selectStatement.setInt(1, Integer.parseInt(transactionIdParam));
            ResultSet resultSet = selectStatement.executeQuery();

            // Process the transaction and update user balance
            if (resultSet.next()) {
                String req = resultSet.getString("request");
                BigDecimal requestAmount = resultSet.getBigDecimal("request_amount");
                String userId = resultSet.getString("user_id");

                // Update user balance in the 'users' table based on the request type
                String updateBalanceQuery = "";
                if ("deposit".equals(req)) {
                    updateBalanceQuery = "UPDATE users SET balance = balance + ? WHERE user_id = ?";
                } else if ("credit".equals(req)) {
                    // Check if the balance is sufficient
                    String balanceCheckQuery = "SELECT balance FROM users WHERE user_id = ?";
                    try (PreparedStatement balanceCheckStatement = connection.prepareStatement(balanceCheckQuery)) {
                        balanceCheckStatement.setString(1, userId);
                        ResultSet balanceCheckResult = balanceCheckStatement.executeQuery();

                        if (balanceCheckResult.next()) {
                            BigDecimal currentBalance = balanceCheckResult.getBigDecimal("balance");

                            // Check if the balance is sufficient for the credit request
                            if (currentBalance.compareTo(requestAmount) < 0) {
                                // Insufficient balance, display a message and redirect
                                response.sendRedirect("insufficient_balance.jsp");
                                return; // Stop further processing
                            }
                            updateBalanceQuery = "UPDATE users SET balance = balance - ? WHERE user_id = ?";
                        } else {
                            // Handle the case where user_id is not found
                            response.sendRedirect("error.jsp");
                            return; // Stop further processing
                        }
                    }

                    
                }

                try (PreparedStatement updateBalanceStatement = connection.prepareStatement(updateBalanceQuery)) {
                    updateBalanceStatement.setBigDecimal(1, requestAmount);
                    updateBalanceStatement.setString(2, userId);
                    updateBalanceStatement.executeUpdate();
                }

                // Update transaction status to 'completed'
                String updateTransactionStatusQuery = "UPDATE transaction SET transaction_status = 'completed' WHERE transaction_id = ?";
                try (PreparedStatement updateTransactionStatusStatement = connection.prepareStatement(updateTransactionStatusQuery)) {
                    updateTransactionStatusStatement.setInt(1, Integer.parseInt(transactionIdParam));
                    updateTransactionStatusStatement.executeUpdate();
                }
            }
			
            response.sendRedirect("transaction_control.jsp");
            // Close resources
            resultSet.close();
        }

        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
        // Handle database errors or redirect to an error page
        response.sendRedirect("error.jsp");
    }
%>

