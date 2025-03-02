<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Retrieve the outpassId from the request
    String rcIdParam = request.getParameter("id");
    int id = 0;

    if (rcIdParam != null && !rcIdParam.isEmpty()) {
        id = Integer.parseInt(rcIdParam);
    } else {
        id = 0; // Or handle the error by redirecting to an error page or displaying a message
    }



    // Database connection
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    // Variables to hold outpass details
    String   name= "", email = "", hostel = "";


    try {
        // Set up database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3305/hostel", "root", "hARINI@2304");

        // Query to fetch the outpass details
        String query = "SELECT * FROM Rc WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, id); // Set the outpassId parameter
        rs = stmt.executeQuery();

        if (rs.next()) {
            id = rs.getInt("id");
            name = rs.getString("name");
            email = rs.getString("email");
            hostel = rs.getString("hostel");


        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Outpass</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .button-container {
                      display: flex;     /* Enables Flexbox */
                    justify-content: center; /* Centers horizontally */
                    align-items: center;   /* Centers vertically */

                }

        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
    <% if (request.getAttribute("successMessage") != null) { %>
        <div style="color: green; text-align: center; font-weight: bold;">
            <%= request.getAttribute("successMessage") %>
        </div>
    <% } else if (request.getAttribute("errorMessage") != null) { %>
        <div style="color: red; text-align: center; font-weight: bold;">
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>
        <h1>Edit Rc</h1>
        <form method="post" action="updateRc">
            <!-- Hidden field to pass the outpass ID -->
            <input type="hidden" name="id" value="<%= rcIdParam %>">

            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" value="<%= name %>" required>
            </div>
            <div class="form-group">
                            <label for="email">Email</label>
                            <input type="text" id="email" name="email" value="<%= email %>" required>
                        </div>



            <div class="form-group">
                <label for="hostel">Hostel</label>
                <select id="hostel" name="hostel" required>
                    <option value="Ponni" <%= "Ponni".equals(hostel) ? "selected" : "" %>>Ponni</option>
                    <option value="Cauvery" <%= "Cauvery".equals(hostel) ? "selected" : "" %>>Cauvery</option>
                    <option value="Amaravathi" <%= "Amaravathi".equals(hostel) ? "selected" : "" %>>Amaravathi</option>
                    <option value="NRI" <%= "NRI".equals(hostel) ? "selected" : "" %>>NRI</option>
                </select>
            </div>

            <div class="button-container">
                    <button type="submit">Update Rcs Details</button>
                </div>
        </form>
        </form>
        <br>
             <form action="executive.jsp" method="post">
                                                    <button type="submit" class="logout">Go back</button>
                                                </form>
    </div>
</body>
</html>
