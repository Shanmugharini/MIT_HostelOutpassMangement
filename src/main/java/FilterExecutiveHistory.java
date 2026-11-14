import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.example.model.Outpass;
@WebServlet("/FilterRcHistory")
public class FilterExecutiveHistory extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inDate = request.getParameter("date1");
        String department = request.getParameter("department");
        String rollNumber = request.getParameter("rollNumber");
        String outDate = request.getParameter("date");

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DBConnection.getConnection();

            // SQL Query
            String query = "SELECT * FROM outpass " +
                    "WHERE (in_date = ? OR ?= '') " +
                    "AND (dept = ? OR ? = '') " +
                    "AND (regno = ? OR ? = '') " +
                    "AND (out_date = ? OR ? = '')";

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, inDate);
            preparedStatement.setString(2, inDate);
            preparedStatement.setString(3, department);
            preparedStatement.setString(4, department);
            preparedStatement.setString(5, rollNumber);
            preparedStatement.setString(6, rollNumber);
            preparedStatement.setString(7, outDate);
            preparedStatement.setString(8, outDate);

            ResultSet resultSet = preparedStatement.executeQuery();

            // Store data in a list
            List<Outpass>passHistory = new ArrayList<>();
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

            // Forward data to JSP
            request.setAttribute("passHistory", passHistory);
            request.getRequestDispatcher("history2.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while fetching pass records: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Driver class not found. Please check your JDBC driver setup.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
