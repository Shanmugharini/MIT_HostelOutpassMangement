<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // Fetch the message from the request if it exists
    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Outpass Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff; /* Light blue background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }

        .form-container h2 {
            text-align: center;
            color: #1A3C77;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            color: #333;
            margin-bottom: 5px;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group input:focus, .form-group select:focus {
            border-color: #1A3C77;
            outline: none;
        }

        .submit-btn {
            width: 100%;
            padding: 10px;
            background-color: #1A3C77;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: #155a9f;
        }

        .message {
            padding: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
        .logout{
                    background-color: #f8d7da;
                    color: #721c24;
                    padding: 10px;
                    margin-top: 20px;
                    text-align: center;
                     width: 100%;
                     border:none;
                                font-weight: bold;
                }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Add Student</h2>

    <!-- Display success or failure message -->
    <%
        if (message != null) {
            String messageClass = message.equals("Registration Success") ? "success" : "error";
    %>
        <div class="message <%= messageClass %>">
            <%= message %>
        </div>
    <%
        }
    %>

    <form id="register" action="<%= request.getContextPath() %>/submitRegisterServlet" method="POST">

        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
        </div>

        <div class="form-group">
            <label for="rollNo">Roll Number:</label>
            <input type="text" id="rollNo" name="rollNo" required>
        </div>

        <div class="form-group">
            <label for="department">Department:</label>
            <select id="department" name="department" required>
                <option value="">Select Department</option>
                <option value="CSE">CSE</option>
                <option value="ECE">ECE</option>
                <option value="EEE">EEE</option>
                <option value="MECH">MECH</option>
                <option value="CIVIL">CIVIL</option>
            </select>
        </div>

        <div class="form-group">
            <label for="email">Email ID:</label>
            <input type="email" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="phone">Phone:</label>
            <input type="tel" id="phone" name="phone" required>
        </div>

        <div class="form-group">
            <label for="hostel">Hostel:</label>
            <input type="text" id="hostel" name="hostel" required>
        </div>

        <div class="form-group">
            <label for="roomNo">Room Number:</label>
            <input type="text" id="roomNo" name="roomNo" required>
        </div>

        <button type="submit" class="submit-btn">Submit</button>


    </form>
    <form action="executive.jsp" method="post">
                                <button type="submit" class="logout">Go back</button>
                            </form>
</div>

<script>
    function validateForm() {
        const name = document.getElementById("name").value;
        const rollNo = document.getElementById("rollNo").value;
        const email = document.getElementById("email").value;
        const phone = document.getElementById("phone").value;
        const roomNo = document.getElementById("roomNo").value;

        // Check if all fields are filled
        if (!name || !rollNo || !email || !phone || !roomNo) {
            alert("Please fill out all fields.");
            return false;
        }

        // Basic phone validation (Indian format)
        const phonePattern = /^[6-9]\d{9}$/;
        if (!phonePattern.test(phone)) {
            alert("Please enter a valid 10-digit phone number.");
            return false;
        }

        // Email validation (basic)
        const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        if (!emailPattern.test(email)) {
            alert("Please enter a valid email address.");
            return false;
        }

        alert("Form submitted successfully!");
        return true; // Form will be submitted
    }
</script>

</body>
</html>
