<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
<%
	String userId = request.getParameter("id");
	
   String sessionuser=(String)session.getAttribute("username");
	//Check if the user is logged in (has an active session)
	 
	
	if (session == null || session.getAttribute("username") == null) {
	    // If no session or username attribute is found, redirect to login page
	    response.sendRedirect("index.html");
	} else {
%>
				<header>
			        <h1>CPN5</h1>
			    </header>
   		 <nav>
        <h1>Admin</h1>
        
        <a href="#">Home</a>
        <a href="transaction_control.jsp">Transaction Control</a>
        <a href="bet_approve.jsp">Bet Approve</a>
        <a href="create_product.jsp">Create Product</a>
        <a href="#">
			        <form action="logout.jsp" method="post">
                        <input type="submit" value="Logout">
                    </form>
                    </a>
        
    </nav>

    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="box" onclick="location='transaction_control.jsp'">
                    <h2>Transaction Control</h2>
                    <p>Effortlessly manage your transactions.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="box" onclick="location='bet_approve.jsp'">
                    <h2>Bet Approve</h2>
                    <p>Swiftly approve bets with confidence.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="box" onclick="location='create_product.jsp'">
                    <h2>Create Product</h2>
                    <p>Innovate and create exciting new products.</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openBox(boxTitle) {
            alert('Clicked on ' + boxTitle);
            // Add your logic to handle box click event here
        }
    </script>
<%} %>
</body>
</html>