package com.example;

import com.example.dao.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteRc")
public class DeleteRcServelet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rcIdParam = request.getParameter("id");
        int id = 0;

        if (rcIdParam != null && !rcIdParam.isEmpty()) {
            id = Integer.parseInt(rcIdParam);
        } else {
            id = 0; // Or handle the error by redirecting to an error page or displaying a message
        }

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DBConnection.getConnection();

            // Delete query
            String deleteQuery = "DELETE FROM rc WHERE id = ?";
            preparedStatement = connection.prepareStatement(deleteQuery);
            preparedStatement.setInt(1, id);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                request.setAttribute("successMessage", "Record deleted successfully.");
            } else {
                request.setAttribute("errorMessage", "Record not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error occurred while deleting record: " + e.getMessage());
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Redirect back to the list page
        request.getRequestDispatcher("viewRcServlet").forward(request, response);
    }
}
