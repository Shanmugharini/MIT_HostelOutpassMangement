<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Outpass Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(115deg, #56d8e4 10%, #9f01ea 90%);
        }

        .form-container {
            width: 800px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            overflow-y: auto;
            max-height: 90vh;
        }

        h2 {
            text-align: center;
            font-size: 28px;
            color: #333;
        }

        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .form-group label {
            width: 150px;
            font-weight: bold;
        }

        .form-group input,
        .form-group select {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .error {
            color: red;
            font-size: 0.8em;
            margin-top: 5px;
            margin-left: 150px;
        }

        .success-message {
            color: green;
            font-weight: bold;
            text-align: center;
            display: none;
        }

        button {
            padding: 10px 15px;
            background: linear-gradient(to right, #de48b5 0%, #0097ff 100%);
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            margin-top: 15px;
        }

        button:hover {
            background-color: #45a049;
        }
        .logout{
                                    background-color: #f8d7da;
                                    color: white;
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
<%-- Display Success or Error Messages --%>
<% if (request.getAttribute("successMessage") != null) { %>
    <div style="color: green; text-align: center; font-weight: bold;">
        <%= request.getAttribute("successMessage") %>
    </div>
<% } else if (request.getAttribute("errorMessage") != null) { %>
    <div style="color: red; text-align: center; font-weight: bold;">
        <%= request.getAttribute("errorMessage") %>
    </div>
<% } %>

    <h2>Outpass Form</h2>
    <form id="outpassForm" method="post" action="submitOutpass">

        <div class="form-group">
            <label for="name">Name</label>
              <input type="text" id="name" name="name" value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>">
             <div class="error" id="regNoError"></div>
        </div>

        <div class="form-group">
            <label for="regNo">Registration Number</label>
            <input type="text" id="regNo" name="regNo" value="<%= request.getAttribute("regNo") != null ? request.getAttribute("regNo") : "" %>">
            <div class="error" id="regNoError"></div>
        </div>

        <div class="form-group">
            <label for="department">Department</label>
            <select id="department" name="department">
                <option value="">Select Department</option>
                <option value="CSE" <%= "CSE".equals(request.getAttribute("department")) ? "selected" : "" %>>Computer Science Engineering (CSE)</option>
                <option value="ECE" <%= "ECE".equals(request.getAttribute("department")) ? "selected" : "" %>>Electronics and Communication Engineering (ECE)</option>
                <option value="EEE" <%= "EEE".equals(request.getAttribute("department")) ? "selected" : "" %>>Electrical and Electronics Engineering (EEE)</option>
                <option value="MECH" <%= "MECH".equals(request.getAttribute("department")) ? "selected" : "" %>>Mechanical Engineering (MECH)</option>
                <option value="CIVIL" <%= "CIVIL".equals(request.getAttribute("department")) ? "selected" : "" %>>Civil Engineering (CIVIL)</option>
            </select>
            <div class="error" id="departmentError"></div>
        </div>

        <div class="form-group">
            <label for="block">Block</label>
            <select id="block" name="block">
                <option value="">Select Block</option>
                <option value="Ponni" <%= "Ponni".equals(request.getAttribute("block")) ? "selected" : "" %>>Ponni</option>
                <option value="Cauvery" <%= "Cauvery".equals(request.getAttribute("block")) ? "selected" : "" %>>Cauvery</option>
                <option value="Amaravathi" <%= "Amaravathi".equals(request.getAttribute("block")) ? "selected" : "" %>>Amaravathi</option>
                <option value="NRI" <%= "NRI".equals(request.getAttribute("block")) ? "selected" : "" %>>NRI</option>
            </select>
            <div class="error" id="blockError"></div>
        </div>

        <div class="form-group">
            <label for="roomNo">Room Number</label>
            <input type="text" id="roomNo" name="roomNo" value="<%= request.getAttribute("roomNo") != null ? request.getAttribute("roomNo") : "" %>">
            <div class="error" id="roomNoError"></div>
        </div>

        <div class="form-group">
            <label for="visitPlace">Place of Visit</label>
            <input type="text" id="visitPlace" name="visitPlace" value="<%= request.getAttribute("visitPlace") != null ? request.getAttribute("visitPlace") : "" %>">
            <div class="error" id="visitPlaceError"></div>
        </div>

        <div class="form-group">
            <label for="daysLeave">Number of Days Leave</label>
            <input type="number" id="daysLeave" name="daysLeave" value="<%= request.getAttribute("daysLeave") != null ? request.getAttribute("daysLeave") : "" %>">
            <div class="error" id="daysLeaveError"></div>
        </div>

        <div class="form-group">
            <label for="outDate">Out Date</label>
            <input type="date" id="outDate" name="outDate" value="<%= request.getAttribute("outDate") != null ? request.getAttribute("outDate") : "" %>">
            <div class="error" id="outDateError"></div>
        </div>

        <div class="form-group">
            <label for="outTime">Out Time</label>
            <input type="time" id="outTime" name="outTime" value="<%= request.getAttribute("outTime") != null ? request.getAttribute("outTime") : "" %>">
            <div class="error" id="outTimeError"></div>
        </div>

        <div class="form-group">
            <label for="inDate">In Date</label>
            <input type="date" id="inDate" name="inDate" value="<%= request.getAttribute("inDate") != null ? request.getAttribute("inDate") : "" %>">
            <div class="error" id="inDateError"></div>
        </div>

        <div class="form-group">
            <label for="inTime">In Time</label>
            <input type="time" id="inTime" name="inTime" value="<%= request.getAttribute("inTime") != null ? request.getAttribute("inTime") : "" %>">
            <div class="error" id="inTimeError"></div>
        </div>

        <div class="form-group">
            <label for="studentPhone">Student Phone Number</label>
            <input type="tel" id="studentPhone" name="studentPhone" value="<%= request.getAttribute("studentPhone") != null ? request.getAttribute("studentPhone") : "" %>">
            <div class="error" id="studentPhoneError"></div>
        </div>

        <div class="form-group">
            <label for="parentPhone">Parent Phone Number</label>
            <input type="tel" id="parentPhone" name="parentPhone" value="<%= request.getAttribute("parentPhone") != null ? request.getAttribute("parentPhone") : "" %>">
            <div class="error" id="parentPhoneError"></div>
        </div>

        <div class="form-group">
            <label for="reason">Reason</label>
            <input type="text" id="reason" name="reason" value="<%= request.getAttribute("reason") != null ? request.getAttribute("reason") : "" %>">
            <div class="error" id="reasonError"></div>
        </div>

        <button type="submit">Submit</button>
        <div class="success-message" id="successMessage">Your form has been submitted successfully!</div>
    </form>
     <form action="student.jsp" method="post">
                                            <button type="submit" class="logout">Go back</button>
                                        </form>
</div>

<script>
    function validateForm() {
        let isValid = true;
        let fields = [
            "name", "regNo", "department", "block", "roomNo", "visitPlace",
            "daysLeave", "outDate", "outTime", "inDate", "inTime",
            "studentPhone", "parentPhone", "reason"
        ];

        fields.forEach(field => {
            let input = document.getElementById(field);
            let error = document.getElementById(field + "Error");

            if (input.value.trim() === "") {
                error.innerText = "This field is required.";
                isValid = false;
            } else {
                error.innerText = "";
            }
        });

        if (isValid) {
            document.getElementById("successMessage").style.display = "block";
        } else {
            document.getElementById("successMessage").style.display = "none";
        }

        return isValid;
    }
</script>

</body>
</html>
