import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SubmitForm")
public class SubmitForm extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String block = request.getParameter("block");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Load the database driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            String dbURL = "jdbc:mysql://localhost:3305/hostel";
            String dbUser = "root";
            String dbPassword = "hARINI@2304";
            connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // SQL query to insert data
            String sql = "INSERT INTO RC (name, email, block) VALUES (?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, block);

            // Execute the query
            int rowsInserted = preparedStatement.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("rcRegister.jsp?message=Registration Success");
            } else {
                response.sendRedirect("rcRegister.jsp?message=Registration Failed");
            }
        } catch (ClassNotFoundException e) {
            out.println("<h2>Error loading database driver: " + e.getMessage() + "</h2>");
        } catch (SQLException e) {
            out.println("<h2>Error connecting to the database or executing query: " + e.getMessage() + "</h2>");
        } finally {
            // Close resources
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                out.println("<h2>Error closing database resources: " + e.getMessage() + "</h2>");
            }
        }
    }
}
