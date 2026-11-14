import com.example.dao.DBConnection;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
@WebServlet("/student_registration")
public class RegisterStudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Database connection setup
        Connection conn = null;
        PreparedStatement stmtCheck = null;
        PreparedStatement stmtUpdate = null;
        ResultSet rs = null;

        try {
            // 1. Setup database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DBConnection.getConnection();

            // 2. Check if the email already exists in the student table
            String checkQuery = "SELECT email FROM studentS WHERE email = ?";
            stmtCheck = conn.prepareStatement(checkQuery);
            stmtCheck.setString(1, email);
            rs = stmtCheck.executeQuery();

            if (rs.next()) {
                // 3. If email exists, update the password
                String updateQuery = "UPDATE studentS SET password = ? WHERE email = ?";
                stmtUpdate = conn.prepareStatement(updateQuery);
                stmtUpdate.setString(1, password);
                stmtUpdate.setString(2, email);

                int result = stmtUpdate.executeUpdate();

                if (result > 0) {
                    // 4. If password update is successful, redirect to login page
                    response.sendRedirect("studLogin.jsp");
                } else {
                    request.setAttribute("error", "Password update failed. Please try again.");
                    request.getRequestDispatcher("student_registration.jsp").forward(request, response);
                }
            } else {
                // 5. If email does not exist, redirect back to the registration page with an error message
                request.setAttribute("error", "Email ID not found. Please register.");
                request.getRequestDispatcher("student_registration.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again later.");
            request.getRequestDispatcher("student_registration.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmtCheck != null) stmtCheck.close();
                if (stmtUpdate != null) stmtUpdate.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
}
