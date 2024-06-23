<%@ page import="java.sql.*, java.util.*,java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Processing Payment</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 80%;
            max-width: 600px;
            padding: 20px;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        p {
            text-align: center;
            margin-bottom: 20px;
        }

        button {
            padding: 12px;
            background-color: #3498db;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
    <!-- Link to Google Fonts for the 'Roboto' font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
</head>
<body>

<%
    // Retrieve user details and payment details from the request
    String id =(String)session.getAttribute("id"); // Replace with actual user ID
    int userId=Integer.parseInt(id);
    String bal=(String)session.getAttribute("bal");
    double balance=Double.parseDouble(bal);
    String upiId = request.getParameter("upiId");
    String paymentMethod = request.getParameter("paymentMethod");
    double amount = Double.parseDouble(request.getParameter("amount"));
	
    
    // Generate a unique transaction ID (You may want to use a more robust method in a production environment)
    
    // Connect to the database and insert transaction details
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection to the database
        String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
        String username = "admin_root";
        String password = "ET&NhwLo1W!j";

        connection = DriverManager.getConnection(jdbcUrl, username, password);
        
        // Insert transaction details into the transaction table
        String insertQuery = "INSERT INTO transaction (request, request_amount, transaction_status, balance, image, user_id, upi_id, paymentmethod,applydate) " +
                "VALUES ( ?, ?, ?, ?, ?, ?, ?, ?,?)";
		
        preparedStatement = connection.prepareStatement(insertQuery);
        Date investStartDate = new Date();
        preparedStatement.setString(1, "credit");
        preparedStatement.setDouble(2, amount);
        preparedStatement.setString(3, "processing");
        preparedStatement.setDouble(4, balance); // Balance will be updated later
        preparedStatement.setNull(5, Types.BLOB); // Set image to NULL
        preparedStatement.setInt(6, userId);
        preparedStatement.setString(7, upiId);
        preparedStatement.setString(8, paymentMethod);
        preparedStatement.setDate(9, new java.sql.Date(investStartDate.getTime()));
        int rowsAffected = preparedStatement.executeUpdate();
		
        if (rowsAffected > 0) {
            // Transaction details successfully inserted

            response.sendRedirect("success_deposit.jsp");

        } else {
            // Error in inserting transaction details
%>
            <div class="container">
                <h2>Error</h2>
                <p>Sorry, there was an error processing your payment. Please try again later.</p>
                <button onclick="window.location.href='user_dashboard.jsp'">Go Back to Dashboard</button>
            </div>
<%
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        try {
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
