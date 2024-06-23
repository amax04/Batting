<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product Details</title>
    <!-- Include Bootstrap CSS (adjust the path based on your project structure) -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            background: linear-gradient(135deg, #ecf0f1, #bdc3c7);
            color: #333;
        }

        header {
            background: linear-gradient(135deg, #3498db, #9b59b6);
            color: #fff;
            text-align: center;
            padding: 20px;
            margin-bottom: 20px;
        }

        h1 {
            margin: 0;
            font-size: 28px;
        }

        nav {
            display: flex;
            justify-content: center;
            background-color: #2c3e50;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        nav a, a>form>[input] {
            color: #fff;
            text-decoration: none;
            padding: 10px;
            border-radius: 4px;
            transition: background-color 0.3s ease-in-out;
            margin: 0 10px;
        }

        nav a:hover {
            background-color: #34495e;
        }

        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
        }

        .product-box {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            margin: 20px;
            width: 600px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }

        .product-box img {
            width: 100%;
            border-radius: 10px 10px 0 0;
            margin-bottom: 10px;
        }

        .product-box h3 {
            color: #007bff;
        }

        .product-box p {
            margin-bottom: 10px;
        }

        .buy-button {
            width: 100%;
        }
    </style>
    <% String id = (String) session.getAttribute("id"); %>
    <% String bal = (String) session.getAttribute("bal");
       
       if (session == null || session.getAttribute("username") == null) {
   	    // If no session or username attribute is found, redirect to login page
   	    response.sendRedirect("index.html");
   	} else {
   		Double balance = Double.parseDouble(bal);
    %>
</head>
<body>
    <header>
        <h1>CPN5</h1>
    </header>
    <nav>
        <a href="user_dashboard.jsp?id=<%=id%>">Home</a>
        <a href="wallet.jsp">Withdraw</a>
        <a href="#">Invest</a>
        <a href="bet_show.jsp">Invested</a>
        <a href="success_deposit.jsp">Transaction</a>
        <a href="#">
            <form action="logout.jsp" method="post">
                <input type="submit" value="Logout">
            </form>
        </a>
    </nav>

    <div class="container">
        <h1 class="mt-5 mb-4 text-center">Product Details</h1>

        <div class="product-container">
            <%
                // Establish a connection to the MySQL database
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish a connection to the database
                    String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
                    String username = "admin_root";
                    String password = "ET&NhwLo1W!j";

                    connection = DriverManager.getConnection(jdbcUrl, username, password);

                    // Execute a query to retrieve product details
                    String query = "SELECT * FROM products"; // replace "your_table" with your actual table name
                    statement = connection.createStatement();
                    resultSet = statement.executeQuery(query);

                    // Display product details in boxes
                    while (resultSet.next()) {
                        int productId = resultSet.getInt("product_id");
                        String productName = resultSet.getString("product_name");
                        int quota = resultSet.getInt("quota");
                        int duration = resultSet.getInt("duration");
                        double amount = resultSet.getDouble("amount");
                        double profit = resultSet.getDouble("profit");
                        String imageUrl = "images/gold.jpg";

                        // Check if the balance is not null and greater than or equal to the product amount
                        if (balance != null && balance >= amount) {
                            // Display product details in a box with an image and a "Buy" button
                            out.println("<div class='product-box'>");
                            out.println("<img src='" + imageUrl + "' alt='" + productName + "'/>");
                            out.println("<h3 class='mb-4'>Product ID: " + productId + "</h3>");
                            out.println("<p><strong>Name:</strong> " + productName + "</p>");
                            out.println("<p><strong>Quota:</strong> " + quota + "</p>");
                            out.println("<p><strong>Duration:</strong> " + duration + "</p>");
                            out.println("<p><strong>Amount:</strong> ₹" + amount + "</p>");
                            out.println("<p><strong>Profit: </strong>" + profit + "%</p>");
							out.println("<P>If you have any query with cpn5betting then you can contact us at our telegram channel(cpn5betting).</p>");
                            // "Buy" button with a link to a hypothetical buy page (replace with your actual URL)
                            out.println("<button class='btn btn-primary buy-button' onclick='confirmBuy(" + productId + ")'>Buy</button>");
                            out.println("</div>");
                        } else {
                            // Display a message indicating insufficient balance
                            out.println("<div class='product-box'>");
                            out.println("<p>Your balance is insufficient to buy this product.</p>");
                            out.println("</div>");
                        }
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                } finally {
                    // Close the database resources
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
    </div>

    <!-- Include Bootstrap JS and Popper.js (adjust the paths based on your project structure) -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
        function confirmBuy(productId) {
            var confirmMessage = "Are you sure you want to buy this product?";
            if (confirm(confirmMessage)) {
                window.location.href = "buy.jsp?productId=" + productId;
            } else {
                // Do nothing or provide feedback to the user
            }
        }
    </script>
    <%} %>
</body>
</html>
