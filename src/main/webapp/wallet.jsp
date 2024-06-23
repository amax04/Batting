<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment Details</title>
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
			
			
		
        .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 80%;
            margin:auto;
            max-width: 600px;
            padding: 20px;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 8px;
        }

        input {
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        select {
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
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
			        <a href="#">Withdraw</a>
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
	String name=(String)session.getAttribute("name");
	//String id=(String)session.getAttribute("id");
	//String username=(String)session.getAttribute("username");
	String balance=(String)session.getAttribute("bal");
	String number=(String)session.getAttribute("number");
    // Retrieve user details from the session (you might want to handle authentication before reaching this page)
    //String name = "John Doe"; // Replace with actual name
    //String id = "123456"; // Replace with actual ID
    //String username = "john_doe"; // Replace with actual username
    //Double balance = 1000.0; // Replace with actual balance
    //String phoneNumber = "123-456-7890"; // Replace with actual phone number
%>

<div class="container">
    <h2>Withdrawal Details</h2>

    <p><strong>Name:</strong> <%= name %></p>
    <p><strong>ID:</strong> <%= id %></p>
    <p><strong>Username:</strong> <%= username %></p>
    <p><strong>Balance:</strong> ₹<%= balance %></p>
    <p><strong>Phone Number:</strong> <%= number %></p>

    <form action="process_payment.jsp" method="post">
        <label for="paymentMethod">Payment Method:</label>
        <select id="paymentMethod" name="paymentMethod" required>
            <option value="upi">UPI</option>
            <option value="gpay">Google Pay</option>
            <option value="paytm">Paytm</option>
            <option value="phonepay">PhonePe</option>
            <option value="amazonpay">Amazon Pay</option>
            <option value="bharatpay">Bharat Pay</option>
            <option value="others">Others</option>
            <!-- Add more payment methods as needed -->
        </select>

        <label for="upiId">UPI ID:</label>
        <input type="text" id="upiId" name="upiId" required>

        <label for="amount">Amount:</label>
        <input type="number" id="amount" name="amount" min="1" required>

        <button type="submit">Submit</button>
    </form>
</div>
<%} %>
</body>
</html>
