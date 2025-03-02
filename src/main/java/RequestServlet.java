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

@WebServlet("/RequestServlet")
public class RequestServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String block = (String) request.getSession().getAttribute("block");

        if (block == null) {
            response.sendRedirect("rcLogin.jsp"); // Redirect to login if not logged in
            return;
        }

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3305/hostel", "root", "hARINI@2304");

            // Fetch pass history
            String query = "SELECT * FROM outpass WHERE block = ? and status=? ORDER BY out_date DESC";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, "A");
            preparedStatement.setString(2,"not verified");

            ResultSet resultSet = preparedStatement.executeQuery();

            // Store data in a list
            List<Outpass> passHistory = new ArrayList<>();
            while (resultSet.next()) {
                Outpass pass = new Outpass();
                pass.setOutpassId(resultSet.getInt("outpass_id"));
                pass.setRegNo(resultSet.getString("regno"));
                pass.setDept(resultSet.getString("dept"));
                pass.setName(resultSet.getString("name"));
                pass.setPlace(resultSet.getString("place"));
                pass.setReason(resultSet.getString("reason"));
                pass.setOutDate(resultSet.getString("out_date"));
                pass.setOutTime(resultSet.getString("out_time"));
                pass.setInDate(resultSet.getString("in_date"));
                pass.setInTime(resultSet.getString("in_time"));
                pass.setStatus(resultSet.getString("status"));
                pass.setParentPhone(resultSet.getString("parent_phone"));
                passHistory.add(pass);
            }

            // Pass the data to JSP
            request.setAttribute("passHistory", passHistory);
            request.getRequestDispatcher("request.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace(); // Log the error
            request.setAttribute("errorMessage", "An error occurred while fetching pass history: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Driver class not found. Please check your JDBC driver setup.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

    }
}
