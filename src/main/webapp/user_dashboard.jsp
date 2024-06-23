<!-- processLogin.jsp -->
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>

<%
    String userId = request.getParameter("id");
	//out.println(" hj"+userId);
    String sessionuser=(String)session.getAttribute("username");
	//Check if the user is logged in (has an active session)
	 
	
	if (session == null || session.getAttribute("username") == null) {
	    // If no session or username attribute is found, redirect to login page
	    response.sendRedirect("index.html");
	} else {
    // JDBC Connection
    Connection conn = null;
    PreparedStatement pstmtUsers = null;
    PreparedStatement pstmtBet = null;
    ResultSet rsUsers = null;
    ResultSet rsBet = null;

    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        String url = "jdbc:mysql://localhost:3306/admin_betting";
        String dbUser = "admin_root";
        String dbPassword = "ET&NhwLo1W!j";
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Validate user credentials and fetch details from users table
        String sqlUsers = "SELECT * FROM users WHERE user_id=?";
        pstmtUsers = conn.prepareStatement(sqlUsers);
        pstmtUsers.setString(1, userId);
        rsUsers = pstmtUsers.executeQuery();

        if (rsUsers.next()) {
            // User found in the users table, retrieve details
            String name = rsUsers.getString("name");
            session.setAttribute("name", name);
            
            String username = rsUsers.getString("username");
            session.setAttribute("username", username);
            
            session.setAttribute("id", userId);
            
            double balance = rsUsers.getDouble("balance");
            String bal=String.valueOf(balance);
            session.setAttribute("bal",bal);
            
            String contact = rsUsers.getString("contact_number");
            session.setAttribute("number",contact);
            
            double totalInvest = rsUsers.getDouble("total_invest");
            double todayProfit = rsUsers.getDouble("total_profit");
            double totalProfit = balance + totalInvest + todayProfit;

            // Fetch details from the Bet table
            String sqlBet = "SELECT purchase_amount, earning_amount FROM Bet WHERE username=? AND invest_status='processing'";
            pstmtBet = conn.prepareStatement(sqlBet);
            pstmtBet.setString(1, username);
            rsBet = pstmtBet.executeQuery();

            double processingPurchaseAmount = 0.0;
            double processingEarningAmount = 0.0;

            while(rsBet.next()) {
                // Data found in the Bet table
                processingPurchaseAmount  = processingPurchaseAmount+rsBet.getDouble("purchase_amount");
                processingEarningAmount  = processingEarningAmount+rsBet.getDouble("earning_amount");
            }

            // Display user details
%>
            <html>
            <head>
                <title>Login Success</title>
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
			
			        .box {
			            width: 80%;
			            max-width: 400px;
			            margin: 10px auto;
			            padding: 20px;
			            background-color: rgba(255, 255, 255, 0.95);
			            box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
			            border-radius: 10px;
			            text-align: center;
			            transition: transform 0.3s ease-in-out;
			        }
			
			        .box:hover {
			            transform: scale(1.05);
			        }
			
			        h2 {
			            color: #333;
			        }
			
			        p {
			            color: #777;
			        }
			
			        label {
			            color: #555;
			        }
			
			        .button {
			            padding: 10px;
			            background-color: #2ecc71;
			            color: #fff;
			            border: none;
			            border-radius: 4px;
			            cursor: pointer;
			            margin-top: 15px;
			            font-size: 14px;
			            transition: background-color 0.3s ease-in-out;
			        }
			
			        .button:hover {
			            background-color: #27ae60;
			        }
			    </style>
			            </head>
            <body>
                
               
                 <header>
			        <h1>CPN5</h1>
			    </header>
			
			    <nav>
			        <a href="#">Home</a>
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
				<div class="box">
					<h2>Welcome! <br> <%= name %> </h2>
				</div>
			    <!-- First Box -->
			    <div class="box">
			        <h2>Wallet</h2>
			        <p>Rs <%= balance %>/-</p>
			        <button onclick="location='deposit.html'" class="button">Recharge Now</button>
			    </div>
			
			    <!-- Second Box -->
			    <div class="box">
			        <h2>Total Invest</h2>
			        <label>Completed: <span id="completedAmount">Rs <%= totalInvest %>/-</span></label><br>
			        <label>Processing: <span id="processingAmount">Rs <%=processingPurchaseAmount %>/-</span></label><br>
			        <button onclick="location='Update_invest.jsp'" class="button">Add to Wallet</button>
			    </div>
			
			    <!-- Third Box -->
			    <div class="box">
			        <h2>Today's Profit</h2>
			        <label>Profit: <span id="todayProfit">Rs <%= todayProfit %>/-</span></label><br>
			        <label>Processing: <span id="todayProcessing">Rs <%=processingEarningAmount %>/-</span></label><br>
			        <button onclick="location='Update_profit.jsp'" class="button">Add to Wallet</button>
			    </div>
			
			    <!-- Fourth Box -->
			    <div class="box">
			        <h2>Total Profit</h2>
			        <p>Rs<%= totalProfit %>/-</p>
			    </div>
                
            </body>
            </html>
<%
        } else {
            // User not found, display error message
%>
            <html>
            <head>
                <title>Login Failed</title>
            </head>
            <body>
                <h2>Login Failed. Invalid username or password.</h2>
            <p><a href="index.html">Back to Login</a></p>
            </body>
            </html>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try { if (rsUsers != null) rsUsers.close(); } catch (Exception e) {}
        try { if (pstmtUsers != null) pstmtUsers.close(); } catch (Exception e) {}
        try { if (rsBet != null) rsBet.close(); } catch (Exception e) {}
        try { if (pstmtBet != null) pstmtBet.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
    
  }
%>