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

@WebServlet("/updateRc")
public class updateRc extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String rcIdParam = request.getParameter("id");
        int id = 0;

        if (rcIdParam != null && !rcIdParam.isEmpty()) {
            id = Integer.parseInt(rcIdParam);
        } else {
            id = 0; // Or handle the error by redirecting to an error page or displaying a message
        }
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String hostel = request.getParameter("hostel");
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Set up database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DBConnection.getConnection();

            // SQL query to update student details
            String query = "UPDATE rc SET name = ?, email = ?, block = ? WHERE id = ?";
            stmt = conn.prepareStatement(query);

            // Set parameters
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, hostel);
            stmt.setInt(4, id);


            // Execute update
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                request.setAttribute("successMessage", "RC details updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Failed to update Rc details. Please check the details.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while updating the rc details.");
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
        request.getRequestDispatcher("editRc.jsp").forward(request, response);
    }
}
