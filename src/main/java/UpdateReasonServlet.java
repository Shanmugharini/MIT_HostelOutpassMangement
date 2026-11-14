import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet("/UpdateReasonServlet")
public class UpdateReasonServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        int regno = Integer.parseInt(request.getParameter("regno"));
        String reason = request.getParameter("reason");

        // Database connection variables
        
        // SQL query to update the reason
        String updateQuery = "UPDATE outpass SET reject_reason = ? WHERE regno = ?";

        String targetPage;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(updateQuery)) {

            // Set query parameters
            preparedStatement.setString(1, reason);
            preparedStatement.setInt(2, regno);

            // Execute update
            int rowsUpdated = preparedStatement.executeUpdate();
            if (rowsUpdated > 0) {
                request.setAttribute("message", "Reason updated successfully!");
                targetPage = "RequestServlet"; // Redirect to RequestServlet on success
            } else {
                request.setAttribute("message", "Failed to update reason. Please try again.");
                targetPage = "reason.jsp"; // Redirect to reason.jsp on failure
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error occurred: " + e.getMessage());
            targetPage = "reason.jsp"; // Redirect to reason.jsp on exception
        }

        // Forward to the target page
        RequestDispatcher dispatcher = request.getRequestDispatcher(targetPage);
        dispatcher.forward(request, response);
    }
}
