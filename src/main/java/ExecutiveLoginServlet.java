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

@WebServlet("/ExecutiveLoginServlet")
public class ExecutiveLoginServlet extends HttpServlet {
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
            conn = DBConnection.getConnection();

            // Query to check if the email exists
            String query = "SELECT * FROM executive WHERE email = ?";
            pst = conn.prepareStatement(query);
            pst.setString(1, email);
            rs = pst.executeQuery();

            if (rs.next()) {
                // Email exists, check the password
                String dbPassword = rs.getString("password");
                if (dbPassword.equals(password)) {
                    // User authentication successful

                    String name = rs.getString("name");
                    String email1 = rs.getString("email");
                    String  phone= rs.getString("phone");

                    HttpSession session= request.getSession();

                    session.setAttribute("name",name);
                    session.setAttribute("email",email1);
                    session.setAttribute("phone",phone);
                    // Set user details as request attributes
                    request.setAttribute("name", name);

                    request.setAttribute("email", email1);
                    request.setAttribute("phone", phone);

                    // Forward to student.jsp
                    request.getRequestDispatcher("executive.jsp").forward(request, response);
                }
                else {
                    // Password mismatch
                    response.sendRedirect("wardenLogin.jsp?message=Incorrect+password");
                }
            } else {
                // Email not found
                response.sendRedirect("wardenLogin.jsp?message=Invalid+email");
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
