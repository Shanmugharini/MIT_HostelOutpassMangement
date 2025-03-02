import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.example.model.Student;
@WebServlet("/FilterStudent")
public class FilterStudent extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String regno = request.getParameter("rollNumber");
        String department = request.getParameter("department");
        String hostel = request.getParameter("hostel");


        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3305/hostel", "root", "hARINI@2304");

            // SQL Query
            String query = "SELECT * FROM students " +
                    "WHERE (roll_number = ? OR ?= '') " +
                    "AND (department = ? OR ? = '') " +
                    "AND (hostel = ? OR ? = '')";


            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, regno);
            preparedStatement.setString(2, regno);
            preparedStatement.setString(3, department);
            preparedStatement.setString(4, department);
            preparedStatement.setString(5, hostel);
            preparedStatement.setString(6, hostel);

            ResultSet resultSet = preparedStatement.executeQuery();

            // Store data in a list
            List<Student>studDetails = new ArrayList<>();
            while (resultSet.next()) {
                Student student = new Student();
                student.setRollNo(resultSet.getString("roll_number"));
                student.setName(resultSet.getString("name"));
                student.setDepartment(resultSet.getString("department"));
                student.setEmail(resultSet.getString("email"));
                student.setPhone(resultSet.getString("phone"));
                student.setHostel(resultSet.getString("hostel"));
                student.setRoomNo(resultSet.getString("room_number"));

                studDetails.add(student);
            }

            // Forward data to JSP
            request.setAttribute("studDetails", studDetails);
            request.getRequestDispatcher("viewStudent.jsp").forward(request, response);

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
