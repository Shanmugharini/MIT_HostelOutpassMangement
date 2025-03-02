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

@WebServlet("/updateOutpass")
public class UpdateOutpassServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve parameters from the form
        int outpassId = Integer.parseInt(request.getParameter("outpassId"));
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

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Set up database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3305/hostel", "root", "hARINI@2304");

            // Update query
            String query = "UPDATE outpass SET regno = ?, dept = ?, block = ?, room_no = ?, place = ?, " +
                    "number_of_days = ?, out_date = ?, out_time = ?, in_date = ?, in_time = ?, " +
                    "student_phone = ?, parent_phone = ?, reason = ?,status=?, reject_reason = NULL WHERE outpass_id = ?";

            stmt = conn.prepareStatement(query);

            // Set parameters for the query
            stmt.setString(1, regNo);
            stmt.setString(2, department);
            stmt.setString(3, block);
            stmt.setString(4, roomNo);
            stmt.setString(5, visitPlace);
            stmt.setInt(6, daysLeave);
            stmt.setString(7, outDate);
            stmt.setString(8, outTime);
            stmt.setString(9, inDate);
            stmt.setString(10, inTime);
            stmt.setString(11, studentPhone);
            stmt.setString(12, parentPhone);
            stmt.setString(13, reason);
            stmt.setInt(15, outpassId);
            stmt.setString(14, "not verified");

            // Execute update
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                // Set success message
                request.setAttribute("successMessage", "Your pass has been updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to upadte pass. Please try again.");
            }
        } catch (Exception e) {
            out.println("<h1>Error: " + e.getMessage() + "</h1>");
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("editOutpass.jsp").forward(request, response);
    }
}
