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
import com.example.model.Student;
@WebServlet("/deleteStudent")
public class DeleteStudentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rollNo = request.getParameter("RollNo");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Database connection
            connection = DBConnection.getConnection();

            // Delete query
            String query = "DELETE FROM students WHERE roll_number = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, rollNo);
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                // Success: Redirect back to the student list
                request.setAttribute("successMessage", "Student record deleted successfully.");
            } else {
                // Failure: Record not found
                request.setAttribute("errorMessage", "Student record not found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error deleting student record: " + e.getMessage());
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Redirect back to the view page
        request.getRequestDispatcher("viewStudentServlet").forward(request, response);
    }
}
