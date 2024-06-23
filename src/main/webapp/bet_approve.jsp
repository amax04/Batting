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
			            color:white; 	
			            margin:auto 420px auto 15px;
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
			
			
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px auto;
            text-align: left;
            
        }

        th {
        	padding: 18px 2px ;
        	text-align:center;
            background-color: #f2f2f2;
        }
         tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        h2{
        text-align:center;
        }
        .processing {
            color: #EE9626;
        }
        .rejected {
            color: red;
        }

        .completed {
            color: green;
        }
        .deposit{color:#EE9626;}
        .credit{color:#32CD32;}

        .acceptbutton{
				      background-color: #04AA6D; /* Green */
					  border: none;
					  color: white;
					  padding: 15px 32px;
					  text-align: center;
					  text-decoration: none;
					  display: inline-block;
					  font-size: 16px;
	    }
	    .rejectbutton{
	    			  background-color: #f44336; /* Red */
					  border: none;
					  color: white;
					  padding: 15px 32px;
					  text-align: center;
					  text-decoration: none;
					  display: inline-block;
					  font-size: 16px;
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
        <h1>Admin</h1>
        
        <a href="admin.jsp?id=<%=id%>">Home</a>
        <a href="transaction_control.jsp">Transaction Control</a>
        <a href="#">Bet Approve</a>
        <a href="create_product.jsp">Create Product</a>
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
        String getInvestmentsQuery = "SELECT * FROM bet where invest_status='processing'";
        preparedStatement = connection.prepareStatement(getInvestmentsQuery);
        resultSet = preparedStatement.executeQuery();

        // Display investment details in a table
        out.println("<h2>Bets Approve</h2>");
        out.println("<table border='1'>");
        out.println("<tr>");
        out.println("<th>Sno.</th>");
        out.println("<th>bet_Id</th>");
        out.println("<th>Product ID</th>");
        out.println("<th>Purchase Amount</th>");
        out.println("<th>Earning<br> Amount</th>");
        out.println("<th>Daily-Profit<br> Percentage</th>");
        out.println("<th>Invest Start Date</th>");
        out.println("<th>Invest End Date</th>");
        out.println("<th>Invest<br> Duration</th>");
        out.println("<th>Invest Status</th>");
        out.println("<th>Product Name</th>");
        out.println("<th>Username</th>");
        out.println("<th>Action</th>");
        out.println("</tr>");
%><%
    int sno = 1;
    while (resultSet.next()) {
        int productId = resultSet.getInt("product_id");
        int betId = resultSet.getInt("bet_id");
        String productName = resultSet.getString("product_name");
        double purchaseAmount = resultSet.getDouble("purchase_amount");
        double earningAmount = resultSet.getDouble("earning_amount");
        double dailyProfitPercentage = resultSet.getDouble("daily_profit_percentage");
        java.util.Date investStartDate = resultSet.getDate("invest_start_date");
        java.util.Date investEndDate = resultSet.getDate("invest_end_date");
        int investDuration = resultSet.getInt("invest_duration");
        String investStatus = resultSet.getString("invest_status");
        String user = resultSet.getString("username");

        out.println("<tr>");
        out.println("<th>" + sno + "</th>");
        out.println("<th>" + betId + "</th>");
        out.println("<td>" + productId + "</td>");
        out.println("<td>" + purchaseAmount + "</td>");
        out.println("<td>" + earningAmount + "</td>");
        out.println("<td>" + dailyProfitPercentage + " %</td>");
        out.println("<td>" + investStartDate + "</td>");
        out.println("<td>" + investEndDate + "</td>");
        out.println("<td>" + investDuration + "</td>");
        out.println("<td class='" + investStatus.toLowerCase() + "'>" + investStatus + "</td>");
        out.println("<td>" + productName + "</td>");
        out.println("<td>" + user + "</td>");
%>
        <td>
            <button class="acceptbutton" onclick="location='bet_approved_update.jsp?username=<%=user%>&bet_id=<%=betId%>'">accept</button>
            <button class="rejectbutton" onclick="location='bet_approved_reject.jsp?username=<%=user%>&bet_id=<%=betId%>'">reject</button>
        </td>
<%
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
