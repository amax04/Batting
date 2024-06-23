<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Remove Product</title>
</head>
<body>
<%
    Connection connection = null;
    PreparedStatement deleteProductStatement = null;

    try {
        // Establish a connection to the database
        String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
        String dbUsername = "admin_root";
        String dbPassword = "ET&NhwLo1W!j";

        connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

        // Assuming 'product_id' is available as a request parameter
        int productId = Integer.parseInt(request.getParameter("product_id"));

        // Delete the row from the 'products' table based on product ID
        String deleteProductQuery = "DELETE FROM products WHERE product_id = ?";
        deleteProductStatement = connection.prepareStatement(deleteProductQuery);
        deleteProductStatement.setInt(1, productId);
        int rowsAffected = deleteProductStatement.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<p>Product with ID " + productId + " removed successfully.</p>");
            response.sendRedirect("create_product.jsp");
        } else {
            out.println("<p>No product found with ID " + productId + ".</p>");
            out.println("<a href='create_product.jsp'>Go back!</a>");
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        try {
            if (deleteProductStatement != null) deleteProductStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
