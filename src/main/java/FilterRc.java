import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.example.model.Rc;
@WebServlet("/FilterRc")
public class FilterRc extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String name = request.getParameter("name");

        String hostel = request.getParameter("hostel");


        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DBConnection.getConnection();

            // SQL Query
            String query = "SELECT * FROM rc " +
                    "WHERE (name = ? OR ?= '') " +
                    "AND (block = ? OR ? = '') " ;



            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, name);
            preparedStatement.setString(3, hostel);
            preparedStatement.setString(4, hostel);


            ResultSet resultSet = preparedStatement.executeQuery();

            // Store data in a list
            List<Rc>rcDetails = new ArrayList<>();
            while (resultSet.next()) {
                Rc rc = new Rc();
                rc.setId(resultSet.getInt("id"));
                rc.setName(resultSet.getString("name"));

                rc.setEmail(resultSet.getString("email"));

                rc.setBlock(resultSet.getString("block"));


                rcDetails.add(rc);
            }

            // Forward data to JSP
            request.setAttribute("rcDetails", rcDetails);
            request.getRequestDispatcher("viewRc.jsp").forward(request, response);

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
