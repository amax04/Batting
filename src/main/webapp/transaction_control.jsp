<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Base64" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
	String id=(String) session.getAttribute("id");
	session.setAttribute("id",id);
	out.println("<input type='hidden' name='id' value='"+id+"'>");
	String username=(String) session.getAttribute("username");
	session.setAttribute("username", username);
	
	if (session == null || session.getAttribute("username") == null) {
	    // If no session or username attribute is found, redirect to login page
	    response.sendRedirect("index.html");
	} else {
    // Define database connection parameters
    String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
    String dbUser = "admin_root";
    String dbPassword = "ET&NhwLo1W!j";

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection to the database
        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // Retrieve transaction data from the 'transaction' table
        String selectQuery = "SELECT * FROM transaction where transaction_status = 'processing' ";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(selectQuery);

        // Display the retrieved data in a table
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Transaction _control</title>
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
            padding: 8px;
            text-align: left;
        }

        th {
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
        
        .modal {
        display: none;
        position: fixed;
        z-index: 1;
        padding-top: 50px;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgb(0, 0, 0);
        background-color: rgba(0, 0, 0, 0.9);
    }

    .modal-content {
        margin: auto;
        display: block;
        width: 80%;
        max-width: 800px;
    }

    .close {
        position: absolute;
        top: 15px;
        right: 35px;
        font-size: 30px;
        color: #fff;
        cursor: pointer;
    }
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
    .rejectbutton{background-color: #f44336; /* Red */
				  border: none;
				  color: white;
				  padding: 15px 32px;
				  text-align: center;
				  text-decoration: none;
				  display: inline-block;
				  font-size: 16px;
				  }
    </style>
     <script>
        function enlargeImage(imageSrc) {
            var modal = document.getElementById('enlargeModal');
            var modalImg = document.getElementById('enlargedImg');
            modal.style.display = 'block';
            modalImg.src = imageSrc;
        }

        function closeModal() {
            var modal = document.getElementById('enlargeModal');
            modal.style.display = 'none';
        }
    </script>
</head>
<body>
			<header>
			        <h1>CPN5</h1>
			</header>
   		 <nav>
        <h1>Admin</h1>
        
        <a href="admin.jsp?id=<%=id%>">Home</a>
        <a href="#">Transaction Control</a>
        <a href="bet_approve.jsp">Bet Approve</a>
        <a href="create_product.jsp">Create Product</a>
        <a href="#">
			        <form action="logout.jsp" method="post">
                        <input type="submit" value="Logout">
                    </form>
                    </a>
        
   		 </nav>
<h2>Transaction Details</h2>

<table>
    <thead>
        <tr>
        	<th>Sno.</th>
            <th>Transaction ID</th>
            <th>Request</th>
            <th>Request Amount</th>
            <th>Transaction Status</th>
            <th>Apply Date</th>
            <th>Balance</th>
            <th>User ID</th>
            <th>Image</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
<%
		int sno=1;
        while (resultSet.next()) {
%>
        <tr>
        	<td><%= sno%></td>
            <td><%= resultSet.getInt("transaction_id") %></td>
            <td class="<%= resultSet.getString("request").toLowerCase() %>">
            <%= resultSet.getString("request") %></td>
            <td><%= resultSet.getBigDecimal("request_amount") %></td>
             <td class="<%= resultSet.getString("transaction_status").toLowerCase() %>">
             <%= resultSet.getString("transaction_status") %></td>
             <td><%= resultSet.getDate("applydate") %></td>
            <td><%= resultSet.getBigDecimal("balance") %></td>
            <td><%= resultSet.getString("user_id") %></td>
            <!-- Handle image display here if necessary -->
            <%
				byte[] imageBytes = resultSet.getBytes("image");
				String base64Image = imageBytes != null ? new String(Base64.getEncoder().encode(imageBytes)) : "";
				%>
				<td onclick="enlargeImage('data:image/jpeg;base64,<%= base64Image %>')">
				    <img src="data:image/jpeg;base64,<%= base64Image %>" width="50" height="50" alt="Image">
				</td>
				<td>
					<button class="acceptbutton" onclick="location='approved_deposit.jsp?transaction_id=<%=resultSet.getInt("transaction_id")%>'">accept</button>
					<button class="rejectbutton" onclick="location='rejected_deposit.jsp?transaction_id=<%=resultSet.getInt("transaction_id")%>'">reject</button>
				</td>
        </tr>
<%
		sno++;
        }
%>
    </tbody>
</table>
	<div id="enlargeModal" class="modal" onclick="closeModal()">
        <span class="close" onclick="closeModal()">&times;</span>
        <img class="modal-content" id="enlargedImg">
    </div>
	
</body>
</html>

<%
        // Close resources
        resultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
        // Handle database errors or redirect to an error page
        response.sendRedirect("error.jsp");
    }
}
%>
