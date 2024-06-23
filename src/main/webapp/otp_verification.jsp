<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>OTP Verification</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #333;
        }

        input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            margin-bottom: 20px;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form action="VerifyOtpServlet.jsp" method="post">
        <label for="otp">Enter OTP:</label>
        <input type="text" id="otp" name="otp" required><br>

        <input type="submit" value="Verify">
    </form>
</body>
</html>
