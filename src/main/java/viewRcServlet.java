import com.example.dao.DBConnection;
import com.example.model.Rc;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/viewRcServlet")
public class viewRcServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Rc> rcDetails = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DBConnection.getConnection();

            // Fetch student details
            String query = "SELECT id, name, block, email FROM rc";
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Rc rc = new Rc();
                rc.setId(resultSet.getInt("id"));
                rc.setName(resultSet.getString("name"));
                rc.setBlock(resultSet.getString("block"));
                rc.setEmail(resultSet.getString("email"));
                rcDetails.add(rc);
            }

            // Pass the data to JSP
            request.setAttribute("rcDetails", rcDetails);
            request.getRequestDispatcher("viewRc.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error fetching RC details: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "JDBC Driver not found.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } finally {
            // Close resources
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
