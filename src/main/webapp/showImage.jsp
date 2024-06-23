<%@ page import="java.sql.*, java.io.*, javax.imageio.*, java.awt.image.BufferedImage" %>
<%
		String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
		String dbUser = "admin_root";
		String dbPassword = "ET&NhwLo1W!j";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        String transactionId = request.getParameter("transactionId");
        String sql = "SELECT image FROM transaction WHERE transaction_id = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, transactionId);
        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            // Retrieve the image bytes
            byte[] imageData = resultSet.getBytes("image");

            // Set the appropriate response headers
            response.setContentType("image/jpeg");
            response.setContentLength(imageData.length);

            // Write the image data to the response output stream
            OutputStream outputStream = response.getOutputStream();
            outputStream.write(imageData);
            outputStream.close();
        }

        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
