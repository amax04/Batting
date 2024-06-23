<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>Payment Form</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        #container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        li {
            margin-bottom: 10px;
            color: #555;
        }

        form {
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        select, input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div id="container">
    <%
        String id = (String) session.getAttribute("id");
        String name = (String) session.getAttribute("name");
        String balance = (String) session.getAttribute("bal");
        String user = (String) session.getAttribute("username");

        if (id == null) {
            response.sendRedirect("index.html");
        }
    %>

    <h2>Welcome, <%= user %>!</h2>
    <ul>
        <li>Name: <%= name %></li>
        <li>Balance: <%= balance %></li>
        <li>User ID: <%= id %></li>
    </ul>

    <form action="DepositServlet" method="post" >
        <label for="paymentMethod">Select Payment Method:</label>
        <select name="paymentMethod" id="paymentMethod" required>
            <option value="upi">UPI</option>
            <option value="gpay">Google Pay</option>
            <option value="paytm">Paytm</option>
            <option value="phonepay">PhonePe</option>
            <option value="amazonpay">Amazon Pay</option>
            <option value="bharatpay">Bharat Pay</option>
            <option value="others">Others</option>
        </select>

        <label for="upiId">UPI ID:</label>
        <select name="upiId" id="upiId" required>
            <option value="upi1">UPI ID 1</option>
            <option value="upi2">UPI ID 2</option>
            <option value="upi3">UPI ID 3</option>
        </select>

        <label for="amount">Amount:</label>
        <input type="text" name="amount" id="amount" required>

        <label for="image">Upload Image:</label>
        <input type="file" id="image" name="image" accept="image/*" onchange="encodeImage()"><br>
         <input type="hidden" id="imageBase64" name="imageBase64">
		
		<script>
		    function encodeImage() {
		        var fileInput = document.getElementById("image");
		        var file = fileInput.files[0];
		
		        var reader = new FileReader();
		        reader.onload = function(e) {
		            document.getElementById("imageBase64").value = e.target.result.split(",")[1];
		        };
		
		        reader.readAsDataURL(file);
		    }
		</script>		
        <input type="submit" value="Submit">
    </form>
</div>

</body>
</html>
