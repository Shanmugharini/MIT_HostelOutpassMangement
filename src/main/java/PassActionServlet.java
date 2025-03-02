import com.example.model.Outpass;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static java.sql.ResultSet.*;

@WebServlet("/PassActionServlet")
public class PassActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String passId = request.getParameter("passId");

        if (action == null || passId == null) {
            request.setAttribute("errorMessage", "Invalid request parameters.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3305/hostel", "root", "hARINI@2304")) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String query = "UPDATE outpass SET status = ? WHERE outpass_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                if ("accept".equals(action)) {
                    preparedStatement.setString(1, "Accepted");
                } else if ("reject".equals(action)) {
                    preparedStatement.setString(1, "Rejected");
                    preparedStatement.setString(2, passId);
                    preparedStatement.executeUpdate();
                    String query1 = "SELECT regno FROM outpass WHERE outpass_id = ?";
                    try (PreparedStatement preparedStatement1 = connection.prepareStatement(query1)) {
                        preparedStatement1.setString(1, passId);
                        try (ResultSet resultSet = preparedStatement1.executeQuery()) {
                            if (resultSet.next()) {
                                request.setAttribute("regno", resultSet.getInt("regno"));
                            }
                        }
                    }

                    // Forward to Reason.jsp only after setting regno
                    request.getRequestDispatcher("reason.jsp").forward(request, response);
                    return; // Exit after forwarding
                }

                preparedStatement.setString(2, passId);
                preparedStatement.executeUpdate();
            }

            response.sendRedirect("RequestServlet");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error processing request: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
