// Imports
package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;

public class DepositServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public void init() throws ServletException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("JDBC Driver not found", e);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String deposit ="deposit";
        String requestAmount = request.getParameter("amount");
        String transactionStatus = "processing";
        String imageBase64 = request.getParameter("imageBase64");
        
        String paymentMethod = request.getParameter("paymentMethod");
        String upiId = request.getParameter("upiId");
         
        HttpSession session=request.getSession();
        // Retrieve user details from session
        String userId = (String) session.getAttribute("id"); 
        String balance = (String)session.getAttribute("bal");
        

        // Convert Base64 string to byte array
        byte[] imageBytes = Base64.getDecoder().decode(imageBase64);

        // Insert data into the database
        
        try {
        	insertData(deposit, requestAmount, transactionStatus, balance, imageBytes, userId,upiId,paymentMethod);
            //response.getWriter().println("Data inserted successfully!");
        	response.sendRedirect("success_deposit.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error inserting data: " + e.getMessage());
        }

    }

    private void insertData(String deposit, String requestAmount, String transactionStatus,
            String balance, byte[] imageBytes, String userId,String upiId,String paymentMethod) {
    	
    	
        String jdbcURL = "jdbc:mysql://localhost:3306/admin_betting";
        String jdbcUsername = "admin_root";
        String jdbcPassword = "ET&NhwLo1W!j";

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            connection.setAutoCommit(false); // Disable autocommit

            String sql = "INSERT INTO transaction (request, request_amount, transaction_status, balance, image, user_id, upi_id, paymentmethod,applydate) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";
            Date investStartDate = new Date();
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, deposit);
                statement.setString(2, requestAmount);
                statement.setString(3, transactionStatus);
                statement.setString(4, balance);
                statement.setBytes(5, imageBytes); // Set image as BLOB
                statement.setString(6, userId);
                statement.setString(7, upiId);
                statement.setString(8, paymentMethod);
                statement.setDate(9, new java.sql.Date(investStartDate.getTime()));
                
                System.out.println("SQL Query: " + statement.toString());  // Print the SQL query

                int rowsAffected = statement.executeUpdate();

                if (rowsAffected > 0) {
                    System.out.println("Data inserted successfully!");
                    connection.commit();  // Commit the changes since the operation was successful
                   
                } else {
                    System.out.println("Data not inserted!");
                }
            } catch (SQLException e) {
                connection.rollback(); // Rollback the transaction in case of an exception
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
