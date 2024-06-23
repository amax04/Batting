<%@ page import="java.sql.*,java.math.BigDecimal" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String productName = request.getParameter("productName");
            int quota = Integer.parseInt(request.getParameter("quota"));
            int duration = Integer.parseInt(request.getParameter("duration"));
            BigDecimal amount = new BigDecimal(request.getParameter("amount"));
            BigDecimal profit = new BigDecimal(request.getParameter("profit"));

            // Database connection parameters
            String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
            String dbUser = "admin_root";
            String dbPassword = "ET&NhwLo1W!j";

            try {
                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish a connection to the database
                Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // Insert data into the 'products' table
                String insertQuery = "INSERT INTO products (product_name, quota, duration, amount, profit) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                    preparedStatement.setString(1, productName);
                    preparedStatement.setInt(2, quota);
                    preparedStatement.setInt(3, duration);
                    preparedStatement.setBigDecimal(4, amount);
                    preparedStatement.setBigDecimal(5, profit);

                    preparedStatement.executeUpdate();
                }
				response.sendRedirect("create_product.jsp");
                // Close resources
                connection.close();

                out.println("<p style='color: green;'>Product details inserted successfully!</p>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color: red;'>Error inserting product details. Please try again.</p>");
            }
        }
    %>
</body>
</html>