<%@ page import="java.sql.*, java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Buy Product</title>
</head>
<body>

<%
    // Retrieve parameters from the URL
    int productId = Integer.parseInt(request.getParameter("productId"));
    String username = (String) session.getAttribute("username"); // Assuming username is stored in the session

    // Retrieve product details from the database based on the product ID
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        // Establish a connection to the database
        String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
        String dbUsername = "admin_root";
        String dbPassword = "ET&NhwLo1W!j";

        connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

        // Retrieve product details
        String getProductQuery = "SELECT * FROM products WHERE product_id = ?";
        preparedStatement = connection.prepareStatement(getProductQuery);
        preparedStatement.setInt(1, productId);
        resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            // Product details
            String productName = resultSet.getString("product_name");
            double purchaseAmount = resultSet.getDouble("amount");
            double dailyProfitPercentage = resultSet.getDouble("profit");
            int investDuration = resultSet.getInt("duration");

            // Calculate earning amount based on daily profit percentage
            double earningAmount = (purchaseAmount * (1 + dailyProfitPercentage / 100))-purchaseAmount;

            // Calculate invest start and end dates
            Date investStartDate = new Date(); // Replace with the actual start date
            // Assuming invest end date is invest start date + invest duration (in days)
            Date investEndDate = new Date(investStartDate.getTime() + investDuration * 24 * 60 * 60 * 1000);

            // Insert details into the bet table
            String insertBetQuery = "INSERT INTO bet (product_id, username, purchase_amount, earning_amount, " +
                    "daily_profit_percentage, invest_start_date, invest_end_date, invest_duration, invest_status, product_name) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'processing', ?)";
            preparedStatement = connection.prepareStatement(insertBetQuery);
            preparedStatement.setInt(1, productId);
            preparedStatement.setString(2, username);
            preparedStatement.setDouble(3, purchaseAmount);
            preparedStatement.setDouble(4, earningAmount);
            preparedStatement.setDouble(5, dailyProfitPercentage);
            preparedStatement.setDate(6, new java.sql.Date(investStartDate.getTime()));
            preparedStatement.setDate(7, new java.sql.Date(investEndDate.getTime()));
            preparedStatement.setInt(8, investDuration);
            preparedStatement.setString(9, productName);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("bet_show.jsp");
            } else {
                out.println("<h2>Error buying the product. Please try again.</h2>");
            }
        } else {
            out.println("<h2>Product not found.</h2>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        try {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
