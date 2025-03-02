<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Provide Reason for Rejection</title>
    <style>
        body {
            background-color: #0099FF; /* Blue background color */
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            text-align: center;
            background-color: white;
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        h1 {
            color: #003366;
            margin-bottom: 20px;
            font-size: 24px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 10px;
            text-align: left;
        }

        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: none;
        }

        button {
            background-color: #003366; /* Dark blue color */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
            width: 100%;
        }

        button:hover {
            background-color: #002244; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Reason for Rejection</h1>
        <%
            // Retrieve the registration number from the request attribute
            int regno = (int) request.getAttribute("regno");
        %>

        <form action="UpdateReasonServlet" method="get">
        <% if (request.getAttribute("message") != null) { %>
            <p style="color: red;"><%= request.getAttribute("message") %></p>
        <% } %>
            <input type="hidden" name="regno" value="<%= regno %>">
            <label for="reason">Reason:</label>
            <textarea id="reason" name="reason" rows="4" required></textarea>
            <button type="submit">Submit</button>
        </form>
    </div>
</body>
</html>
