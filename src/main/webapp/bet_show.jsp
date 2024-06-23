<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Investments</title>
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
			
			        nav a,a>form>[input] {
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
			
			

        h2 {
            color: #333;
            text-align:center;
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            color: #333;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .rejected {
            color: red;
        }
		.processing{
		color:#EE9626;
		}
        .completed {
            color: green;
        }
    </style>
</head>
	<% 	
		String username = (String) session.getAttribute("username");
		String id = (String) session.getAttribute("id");
		if (session == null || session.getAttribute("username") == null) {
		    // If no session or username attribute is found, redirect to login page
		    response.sendRedirect("index.html");
		} else {
  	%>
<body>
				<header>
			        <h1>CPN5</h1>
			    </header>
			
			    <nav>
			        <a href="user_dashboard.jsp?id=<%= id %>">Home</a>
			        <a href="wallet.jsp">Withdraw</a>
			        <a href="products.jsp">Invest</a>
			        <a href="bet_show.jsp">Invested</a>
			        <a href="success_deposit.jsp">Transaction</a>
			        <a href="#">
			        <form action="logout.jsp" method="post">
                        <input type="submit" value="Logout">
                    </form>
                    </a>
			    </nav>
<%
    // Retrieve username from the session (you might want to handle authentication before reaching this page)
   
	session.setAttribute("username", username);
	

    // Retrieve investment details from the database based on the username
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        // Establish a connection to the database
        String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
        String dbUsername = "admin_root";
        String dbPassword = "ET&NhwLo1W!j";

        connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

        // Retrieve investment details
        String getInvestmentsQuery = "SELECT * FROM bet WHERE username = ?";
        preparedStatement = connection.prepareStatement(getInvestmentsQuery);
        preparedStatement.setString(1, username);
        resultSet = preparedStatement.executeQuery();

        // Display investment details in a table
        out.println("<h2>Your Investments</h2>");
        out.println("<table border='1'>");
        out.println("<tr>");
        out.println("<th>Sno.</th>");
        out.println("<th>Product ID</th>");
        out.println("<th>Purchase Amount</th>");
        
        out.println("<th>Earning Amount</th>");
        out.println("<th>Daily Profit Percentage</th>");
        out.println("<th>Invest Start Date</th>");
        out.println("<th>Invest End Date</th>");
        out.println("<th>Invest Duration</th>");
        out.println("<th>Invest Status</th>");
        out.println("<th>Product Name</th>");
        out.println("</tr>");
		int sno=1;
        while (resultSet.next()) {
            int productId = resultSet.getInt("product_id");
            String productName = resultSet.getString("product_name");
            double purchaseAmount = resultSet.getDouble("purchase_amount");
            double earningAmount = resultSet.getDouble("earning_amount");
            double dailyProfitPercentage = resultSet.getDouble("daily_profit_percentage");
            java.util.Date investStartDate = resultSet.getDate("invest_start_date");
            java.util.Date investEndDate = resultSet.getDate("invest_end_date");
            int investDuration = resultSet.getInt("invest_duration");
            String investStatus = resultSet.getString("invest_status");

            out.println("<tr>");
            out.println("<th>"+sno+"</th>");
            out.println("<td>" + productId + "</td>");
            out.println("<td>" + purchaseAmount + "</td>");
            
            out.println("<td>" + earningAmount + "</td>");
            out.println("<td>" + dailyProfitPercentage + "</td>");
            out.println("<td>" + investStartDate + "</td>");
            out.println("<td>" + investEndDate + "</td>");
            out.println("<td>" + investDuration + "</td>");
            out.println("<td class='"+resultSet.getString("invest_status").toLowerCase()+"'>" + investStatus + "</td>");
            out.println("<td>" + productName + "</td>");
            
            out.println("</tr>");
            sno++;
        }

        out.println("</table>");

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
		}
%>

</body>
</html>
