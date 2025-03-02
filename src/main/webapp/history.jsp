<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.example.model.Outpass" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pass History</title>
    <style>
        /* Reset some default styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        /* Overall page styling */
        body {
            display: flex;
            flex-direction: column;
            background-color: #cce7ff;
            align-items: center;
        }

        /* Header styling */
        .header {
            width: 100%;
            background-color: #002c6d;
            color: white;
            padding: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header h1 {
            margin-left: 20px;
        }

        .header .nav {
            display: flex;
            gap: 20px;
            margin-right: 20px;
        }

        .header .nav a {
            color: white;
            text-decoration: none;
            padding: 5px 10px;
        }

        .header .nav a:hover {
            background-color: #00449b;
            border-radius: 5px;
        }

        .logout {
            background-color: red;
            padding: 5px 10px;
            border-radius: 5px;
        }

        /* Main content styling */
        .container {
            margin-top: 20px;
            width: 100%;
            max-width: 600px;
            padding: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
        }

        /* Pass card styling */
        .pass-card {
            background-color: #00449b;
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: left;
            position: relative;
        }

        .pass-card img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-right: 20px;
            vertical-align: middle;
        }

        .pass-info {
            display: inline-block;
            vertical-align: middle;
        }

        .info {
            margin: 10px 0;
        }

        .info label {
            font-weight: bold;
        }

        .info span {
            display: block;
            padding: 5px;
            background-color: #3366cc;
            border-radius: 5px;
            color: white;
            margin-top: 5px;
        }

        /* Warden status styling */
        .status {
            color: red;
            font-weight: bold;
        }

        /* Print button styling */
        .print-btn {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .print-btn:hover {
            background-color: #555;
        }

        .actions button {
            margin: 5px;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            color: white;
            background-color: #007bff;
            cursor: pointer;
        }

        .actions button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>MIT Hostel</h1>
        <div class="nav">
            <a href="student.jsp">Home</a>
            <a href="outpassForm.jsp">Request Pass</a>
            <a href="#">Pass History</a>
            <a href="index.jsp" class="logout">Log Out</a>
        </div>
    </div>

    <div class="container">
        <h2>Pass History</h2>

        <%
            // Retrieve the passHistory from the request
            List<Outpass> passHistory = (List<Outpass>) request.getAttribute("passHistory");
            if (passHistory != null && !passHistory.isEmpty()) {
                // Get the current date and time
                LocalDate currentDate = LocalDate.now();
                LocalTime currentTime = LocalTime.now();
                DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

                for (Outpass pass : passHistory) {
                    // Parse outDate and outTime for comparison
                    LocalDate outDate = LocalDate.parse(pass.getOutDate());
                    LocalTime outTime = LocalTime.parse(pass.getOutTime(), timeFormatter);

                    // Check if the out date and time are in the future
        %>
                    <div class="pass-card">
                        <div class="pass-info">
                            <img src="img/stud.jpg" alt="Profile Picture">
                        </div>
                        <div class="info">
                            <label>Place</label>
                            <span><%= pass.getPlace() %></span>
                        </div>
                        <div class="info">
                            <label>Reason</label>
                            <span><%= pass.getReason() %></span>
                        </div>
                        <div class="info">
                            <label>From Date</label>
                            <span><%= pass.getOutDate() %></span>
                        </div>
                        <div class="info">
                            <label>To Date</label>
                            <span><%= pass.getInDate() %></span>
                        </div>
                        <div class="info">
                            <label>From Time</label>
                            <span><%= pass.getOutTime() %></span>
                        </div>
                        <div class="info">
                            <label>To Time</label>
                            <span><%= pass.getInTime() %></span>
                        </div>
                        <div class="info">
                            <label>Warden Status</label>
                            <span class="status"><%= pass.getStatus() %></span>
                        </div>
                         <div class="info">
                                                    <label>Reject Reason</label>
                                                    <span class="status"><%= pass.getReject_reason() %></span>
                                                </div>

                        <%
                            if (outDate.isAfter(currentDate) || (outDate.isEqual(currentDate) && outTime.isAfter(currentTime))) {
                        %>
                        <div class="actions">
                            <form method="post" action="deleteOutpass">
                                <input type="hidden" name="outpassId" value="<%= pass.getOutpassId() %>">
                                <button type="submit">Delete</button>
                            </form>

                        </div>
                        <div class="actions">
                        <form method="post" action="editOutpass.jsp">
                                                                                    <input type="hidden" name="outpassId" value="<%= pass.getOutpassId() %>">
                                                                                    <button type="submit">Edit</button>
                                                                                </form>
                        </div>

                        <%
                            }
                        %>
                        </div>

                    <br>
        <%
                }
            } else {
        %>
            <p>No passes found.</p>

        <%
            }
        %>
<button class="print-btn" onclick="window.print()">Print</button>
                                        </div>
</body>
</html>
