<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Retrieve the outpassId from the request
    String outpassIdStr = request.getParameter("outpassId");
    int outpassId = Integer.parseInt(outpassIdStr); // Convert to int

    // Database connection
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    // Variables to hold outpass details
    String regNo = "", department = "", block = "", roomNo = "", visitPlace = "", daysLeave = "",
           outDate = "", outTime = "", inDate = "", inTime = "", studentPhone = "", parentPhone = "", reason = "";

    try {
        // Set up database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3305/hostel", "root", "hARINI@2304");

        // Query to fetch the outpass details
        String query = "SELECT * FROM outpass WHERE outpass_id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, outpassId); // Set the outpassId parameter
        rs = stmt.executeQuery();

        if (rs.next()) {
            regNo = rs.getString("regno");
            department = rs.getString("dept");
            block = rs.getString("block");
            roomNo = rs.getString("room_no");
            visitPlace = rs.getString("place");
            daysLeave = rs.getString("number_of_days");
            outDate = rs.getString("out_date");
            outTime = rs.getString("out_time");
            inDate = rs.getString("in_date");
            inTime = rs.getString("in_time");
            studentPhone = rs.getString("student_phone");
            parentPhone = rs.getString("parent_phone");
            reason = rs.getString("reason");
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
        <h1>Edit Outpass</h1>
        <form method="post" action="updateOutpass">
            <!-- Hidden field to pass the outpass ID -->
            <input type="hidden" name="outpassId" value="<%= outpassId %>">

            <div class="form-group">
                <label for="regNo">Registration Number</label>
                <input type="text" id="regNo" name="regNo" value="<%= regNo %>" required>
            </div>

            <div class="form-group">
                <label for="department">Department</label>
                <select id="department" name="department" required>
                    <option value="CSE" <%= "CSE".equals(department) ? "selected" : "" %>>Computer Science Engineering</option>
                    <option value="ECE" <%= "ECE".equals(department) ? "selected" : "" %>>Electronics and Communication Engineering</option>
                    <option value="EEE" <%= "EEE".equals(department) ? "selected" : "" %>>Electrical and Electronics Engineering</option>
                    <option value="MECH" <%= "MECH".equals(department) ? "selected" : "" %>>Mechanical Engineering</option>
                    <option value="CIVIL" <%= "CIVIL".equals(department) ? "selected" : "" %>>Civil Engineering</option>
                </select>
            </div>

            <div class="form-group">
                <label for="block">Block</label>
                <select id="block" name="block" required>
                    <option value="A" <%= "A".equals(block) ? "selected" : "" %>>Ponni</option>
                    <option value="B" <%= "B".equals(block) ? "selected" : "" %>>Cauvery</option>
                    <option value="C" <%= "C".equals(block) ? "selected" : "" %>>Amaravathi</option>
                    <option value="D" <%= "D".equals(block) ? "selected" : "" %>>NRI</option>
                </select>
            </div>

            <div class="form-group">
                <label for="roomNo">Room Number</label>
                <input type="text" id="roomNo" name="roomNo" value="<%= roomNo %>" required>
            </div>

            <div class="form-group">
                <label for="visitPlace">Place of Visit</label>
                <input type="text" id="visitPlace" name="visitPlace" value="<%= visitPlace %>" required>
            </div>

            <div class="form-group">
                <label for="daysLeave">Number of Days Leave</label>
                <input type="number" id="daysLeave" name="daysLeave" value="<%= daysLeave %>" required>
            </div>

            <div class="form-group">
                <label for="outDate">Out Date</label>
                <input type="date" id="outDate" name="outDate" value="<%= outDate %>" required>
            </div>

            <div class="form-group">
                <label for="outTime">Out Time</label>
                <input type="time" id="outTime" name="outTime" value="<%= outTime %>" required>
            </div>

            <div class="form-group">
                <label for="inDate">In Date</label>
                <input type="date" id="inDate" name="inDate" value="<%= inDate %>" required>
            </div>

            <div class="form-group">
                <label for="inTime">In Time</label>
                <input type="time" id="inTime" name="inTime" value="<%= inTime %>" required>
            </div>

            <div class="form-group">
                <label for="studentPhone">Student Phone Number</label>
                <input type="tel" id="studentPhone" name="studentPhone" value="<%= studentPhone %>" required>
            </div>

            <div class="form-group">
                <label for="parentPhone">Parent Phone Number</label>
                <input type="tel" id="parentPhone" name="parentPhone" value="<%= parentPhone %>" required>
            </div>

            <div class="form-group">
                <label for="reason">Reason</label>
                <input type="text" id="reason" name="reason" value="<%= reason %>" required>
            </div>

            <div class="button-container">
                    <button type="submit">Update Outpass</button>
                </div>
        </form>
        </form>
        <br>
             <form action="student.jsp" method="post">
                                                    <button type="submit" class="logout">Go back</button>
                                                </form>
    </div>
</body>
</html>
