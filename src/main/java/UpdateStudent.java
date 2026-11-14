import com.example.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateStudent")
public class UpdateStudent extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String rollNo = request.getParameter("regno");
        String name = request.getParameter("name");
        String department = request.getParameter("department");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String hostel = request.getParameter("hostel");
        String roomNo = request.getParameter("roomNo");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Set up database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DBConnection.getConnection();

            // SQL query to update student details
            String query = "UPDATE students SET name = ?, department = ?, email = ?, phone = ?, hostel = ?, room_number = ? WHERE roll_number = ?";
            stmt = conn.prepareStatement(query);

            // Set parameters
            stmt.setString(1, name);
            stmt.setString(2, department);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, hostel);
            stmt.setString(6, roomNo);
            stmt.setString(7, rollNo);

            // Execute update
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                request.setAttribute("successMessage", "Student details updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Failed to update student details. Please check the registration number.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while updating the student details.");
        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Forward to the JSP
        request.getRequestDispatcher("editStudent.jsp").forward(request, response);
    }
}
