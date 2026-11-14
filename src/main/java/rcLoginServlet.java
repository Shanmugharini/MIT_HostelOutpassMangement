import com.example.dao.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/rcLoginServlet")
public class rcLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DBConnection.getConnection();

            // Query to check if the email exists
            String query = "SELECT * FROM rc WHERE email = ?";
            pst = conn.prepareStatement(query);
            pst.setString(1, email);
            rs = pst.executeQuery();

            if (rs.next()) {
                // Email exists, check the password
                String dbPassword = rs.getString("password");
                if (dbPassword.equals(password)) {
                    // User authentication successful
                    String id = rs.getString("id");
                    String name = rs.getString("name");
                    String block = rs.getString("block");

                    // Set user details as session attributes
                    HttpSession session = request.getSession();
                    session.setAttribute("id", id);
                    session.setAttribute("name", name);
                    session.setAttribute("block", block);

                    // Redirect to rc.jsp
                    response.sendRedirect("rc.jsp");
                } else {
                    // Password mismatch
                    response.sendRedirect("rcLogin.jsp?message=Incorrect+password");
                }
            } else {
                // Email not found
                response.sendRedirect("rcLogin.jsp?message=Invalid+email");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Database connection error: " + e.getMessage() + "</h3>");
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
