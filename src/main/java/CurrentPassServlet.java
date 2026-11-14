import com.example.model.Outpass;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CurrentPassServlet")
public class CurrentPassServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rollNumber = (String) request.getSession().getAttribute("rollNumber");

        if (rollNumber == null) {
            response.sendRedirect("studLogin.jsp"); // Redirect to login if not logged in
            return;
        }

        try {
            // Database connection
            Connection connection = DBConnection.getConnection();
            LocalDate currentDate = LocalDate.now();
            LocalTime currentTime = LocalTime.now();
            // Fetch pass history
            String query = "SELECT * FROM outpass WHERE regno = ? AND (in_date > ? OR (in_date = ? AND in_time >= ?)) AND status!=? ORDER BY out_date DESC";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            String formattedDate = currentDate.toString();  // Will be in 'YYYY-MM-DD' format
            String formattedTime = currentTime.toString();

            // Set parameters for regno and out_date
            preparedStatement.setString(1, rollNumber);  // Set regno as string
            preparedStatement.setString(2, formattedDate);
            preparedStatement.setString(3, formattedDate);
            preparedStatement.setString(4, formattedTime);
            preparedStatement.setString(5, "Rejected");

            ResultSet resultSet = preparedStatement.executeQuery();

            // Store data in a list
            List<Outpass> passHistory = new ArrayList<>();
            while (resultSet.next()) {
                Outpass pass = new Outpass();
                pass.setOutpassId(resultSet.getInt("outpass_id"));
                pass.setName(resultSet.getString("name"));
                pass.setRegNo(resultSet.getString("regno"));
                pass.setDept(resultSet.getString("dept"));
                pass.setBlock(resultSet.getString("block"));
                pass.setRoomNo(resultSet.getString("room_no"));
                pass.setPlace(resultSet.getString("place"));
                pass.setNumOfDays(resultSet.getInt("number_of_days"));
                pass.setReason(resultSet.getString("reason"));
                pass.setStudentPhone(resultSet.getString("student_phone"));
                pass.setParentPhone(resultSet.getString("parent_phone"));
                pass.setOutDate(resultSet.getString("out_date"));
                pass.setOutTime(resultSet.getString("out_time"));
                pass.setInDate(resultSet.getString("in_date"));
                pass.setInTime(resultSet.getString("in_time"));
                pass.setStatus(resultSet.getString("status"));
                passHistory.add(pass);
            }

            // Pass the data to JSP
            request.setAttribute("passHistory", passHistory);
            request.getRequestDispatcher("history.jsp").forward(request, response);

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
