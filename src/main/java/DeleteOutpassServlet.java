

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/deleteOutpass")
public class DeleteOutpassServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details (can be moved to a separate DBConnection class)
    private static final String URL = "jdbc:mysql://localhost:3305/hostel";
    private static final String USER = "root";
    private static final String PASSWORD = "hARINI@2304";

    // Method to get the database connection
    private Connection getConnection() throws SQLException {
        return java.sql.DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Method to delete the outpass from the database
    private boolean deleteOutpass(String outpassId) {
        String query = "DELETE FROM outpass WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, outpassId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the outpassId parameter from the request
        String outpassId = request.getParameter("outpassId");

        if (outpassId != null && !outpassId.trim().isEmpty()) {
            // Call the delete method to remove the outpass
            boolean isDeleted = deleteOutpass(outpassId);

            // Provide feedback to the user based on the result
            if (isDeleted) {
                // Success message
                request.setAttribute("message", "Outpass deleted successfully.");
            } else {
                // Failure message
                request.setAttribute("message", "Failed to delete outpass. Please try again.");
            }
        } else {
            // Invalid input message
            request.setAttribute("message", "Invalid Outpass ID.");
        }

        // Forward the request back to the pass history page (passHistory.jsp)
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }
}
