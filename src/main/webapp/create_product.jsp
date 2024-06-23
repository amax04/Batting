<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
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
			

			h2 {
			    font-size: 24px;
			    text-align:center;
			}


        table {
			    width: 100%;
			    border-collapse: collapse;
			    margin-bottom: 20px;
			    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			    background-color: #fff;
				}
				
				th, td {
				    padding: 15px;
				    border: 1px solid #ddd;
				    text-align: left;
				}
				
				th {
				    background-color: #3498db;
				    color: #fff;
				}


        #form {
		    background-color: #fff;
		    padding: 20px;
		    border-radius: 8px;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		    width: 300px;
		    text-align: center;
		    margin: 20px auto;
		    background-color: #fff;
			}
			
			label {
			    display: block;
			    margin-bottom: 8px;
			    color: #333;
			}
			
			#form>input {
			    width: calc(100% - 16px);
			    padding: 12px;
			    margin-bottom: 16px;
			    box-sizing: border-box;
			    border: 1px solid #ddd;
			    border-radius: 4px;
			    font-size: 14px;
			}

	        #form>input[type="submit"] {
			    background-color: #27ae60;
			    color: #fff;
			}
			
			#form>input[type="submit"]:hover {
			    background-color: #219a52;
			}
        /* Responsive styling */
		@media screen and (max-width: 600px) {
		    table {
		        overflow-x: auto;
		    }
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
	String id=(String) session.getAttribute("id");
	session.setAttribute("id",id);
	out.println("<input type='hidden' name='id' value='"+id+"'>");
	String username=(String) session.getAttribute("username");
	session.setAttribute("username", username);
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
        <a href="bet_approve.jsp">Bet Approve</a>
        <a href="#">Create Product</a>
        <a href="#">
			        <form action="logout.jsp" method="post">
                        <input type="submit" value="Logout">
                    </form>
                    </a>
        
    </nav>
	
    <h2>Product Details</h2>

    <table>
        <thead>
            <tr>
            	<th>Sno.</th>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Quota</th>
                <th>Duration</th>
                <th>Amount</th>
                <th>Profit</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Define database connection parameters
                String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
                String dbUser = "admin_root";
                String dbPassword = "ET&NhwLo1W!j";

                try {
                    // Load the JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish a connection to the database
                    Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                    // Retrieve product details from the 'products' table
                    String selectQuery = "SELECT * FROM products";
                    Statement statement = connection.createStatement();
                    ResultSet resultSet = statement.executeQuery(selectQuery);
					int sno=1;
                    // Display product details in the table
                    while (resultSet.next()) {
            %>
                        <tr>
                        	<td><%=sno %></td>
                            <td><%= resultSet.getInt("product_id") %></td>
                            <td><%= resultSet.getString("product_name") %></td>
                            <td><%= resultSet.getInt("quota") %></td>
                            <td><%= resultSet.getInt("duration") %></td>
                            <td><%= resultSet.getBigDecimal("amount") %></td>
                            <td><%= resultSet.getBigDecimal("profit") %>%</td>
                       		<td> <button class="rejectbutton" onclick="location='remove_product.jsp?product_id=<%=resultSet.getInt("product_id")%>'">Remove</button></td>
                        </tr>
            <%
            	sno++;
                    }

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
        </tbody>
    </table>

    <form id="form" action="insert_product.jsp" method="post">
        <label for="productName">Product Name:</label>
        <input type="text" id="productName" name="productName" required>

        <label for="quota">Quota(No. of participants):</label>
        <input type="number" id="quota" name="quota" required>

        <label for="duration">Duration(in Days):</label>
        <input type="number" id="duration" name="duration" required>

        <label for="amount">Amount:</label>
        <input type="number" step="0.01" id="amount" name="amount" required>

        <label for="profit">Profit(in Percents):</label>
        <input type="number" step="0.01" id="profit" name="profit" required>

        <input type="submit" value="Insert Details">
    </form>
</body>
</html>
