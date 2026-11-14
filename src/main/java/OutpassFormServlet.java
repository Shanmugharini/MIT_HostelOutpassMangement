import com.example.dao.DBConnection;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
@WebServlet("/submitOutpass")
public class OutpassFormServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String regNo = request.getParameter("regNo");
        String department = request.getParameter("department");
        String block = request.getParameter("block");
        String roomNo = request.getParameter("roomNo");
        String visitPlace = request.getParameter("visitPlace");
        int daysLeave = Integer.parseInt(request.getParameter("daysLeave"));
        String outDate = request.getParameter("outDate");
        String outTime = request.getParameter("outTime");
        String inDate = request.getParameter("inDate");
        String inTime = request.getParameter("inTime");
        String studentPhone = request.getParameter("studentPhone");
        String parentPhone = request.getParameter("parentPhone");
        String reason = request.getParameter("reason");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            connection = DBConnection.getConnection();

            // SQL Query to insert data into the outpass table
            String sql = "INSERT INTO outpass (name, regno, dept, block, room_no, place, number_of_days, "
                    + "out_date, out_time, in_date, in_time, student_phone, parent_phone, reason,status) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)";

// Set values for the prepared statement
            preparedStatement = connection.prepareStatement(sql);  // removed unnecessary casting

            preparedStatement.setString(1, name);
            preparedStatement.setString(2, regNo);
            preparedStatement.setString(3, department);
            preparedStatement.setString(4, block);
            preparedStatement.setString(5, roomNo);
            preparedStatement.setString(6, visitPlace);
            preparedStatement.setInt(7, daysLeave);
            preparedStatement.setString(8, outDate);
            preparedStatement.setString(9, outTime);
            preparedStatement.setString(10, inDate);
            preparedStatement.setString(11, inTime);
            preparedStatement.setString(12, studentPhone);
            preparedStatement.setString(13, parentPhone);
            preparedStatement.setString(14, reason);
            preparedStatement.setString(15, "not verified");  // Added the missing status field


            // Execute the query
            int rowsInserted = preparedStatement.executeUpdate();

            if (rowsInserted > 0) {
                // Set success message
                request.setAttribute("successMessage", "Your form has been submitted successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to submit the form. Please try again.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        // Forward back to the form with the message
        request.getRequestDispatcher("outpassForm.jsp").forward(request, response);
    }
}
