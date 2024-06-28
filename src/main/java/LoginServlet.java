import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        PrintWriter out = response.getWriter();
        // Perform validation (you might want to connect to a database to validate credentials)

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection
            String jdbcUrl = "jdbc:mysql://localhost:3306/admin_betting";
            String username = "admin_root";//DB Username
            String password = "******";//DB Password
            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);

            // Execute a query
            String query = "SELECT user_id,role FROM users where username =? and password=?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1,user);
			preparedStatement.setString(2,pass);
            ResultSet resultSet = preparedStatement.executeQuery();
            HttpSession session=request.getSession();
            // Process the results
            if(resultSet.next()) {
                // Retrieve data and do something with it
	               String id = resultSet.getString("user_id");
	               String role=resultSet.getString("role");
	               if(role.equals("admin"))
	               {
	            	   session.setAttribute("username",user);
	            	   response.sendRedirect("admin.jsp");
	               }
	               else {
	            	   
	            	   session.setAttribute("username",user);
	            	   response.sendRedirect("user_dashboard.jsp?id="+id);
	               }
				}
			else{
				
                out.println("Invalid username or password");
                ;
				}

            // Close resources
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            out.println("Error: " + e.getMessage());
        }
    
    }
}
