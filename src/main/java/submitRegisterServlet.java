import com.example.dao.DBConnection;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/submitRegister")
public class submitRegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch form data from request
        String name = request.getParameter("name");
        String rollNo = request.getParameter("rollNo");
        String department = request.getParameter("department");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String hostel = request.getParameter("hostel");
        String roomNo = request.getParameter("roomNo");

        Connection conn = null;
        PreparedStatement stmt = null;

        boolean success = false;

        try {
            // Establish the database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DBConnection.getConnection();

            // Prepare the SQL statement to insert student data
            String sql = "INSERT INTO studentS (roll_number, name, department, email, phone, hostel, room_number) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);

            stmt.setString(1, rollNo);
            stmt.setString(2, name);
            stmt.setString(3, department);
            stmt.setString(4, email);
            stmt.setString(5, phone);
            stmt.setString(6, hostel);
            stmt.setString(7, roomNo);

            // Execute the update and check if the insertion was successful
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                success = true;  // Data inserted successfully
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Redirect to the registration page with a success or failure message
        if (success) {
            response.sendRedirect("register.jsp?message=Registration Success");
        } else {
            response.sendRedirect("register.jsp?message=Registration Failed");
        }
    }
}
