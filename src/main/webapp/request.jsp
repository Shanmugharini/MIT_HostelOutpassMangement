<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Outpass" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Outpass Management</title>
    <link rel="stylesheet" href="request.css">
    <style>
    .accept-btn {
        background-color: #28a745; /* Green color */
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .accept-btn:hover {
        background-color: #218838; /* Darker green on hover */
    }

    .reject-btn {
        background-color: #dc3545; /* Red color */
        color: white;
        border: none;
        padding: 10px 20px;
        margin-top:10px;
        border-radius: 5px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .reject-btn:hover {
        background-color: #c82333; /* Darker red on hover */
    }
button.search-btn {
         background-color:#1F509A; /* Blue */
         color: white;
         border: none;
         padding: 10px 20px;
         border-radius: 5px;
         font-size: 14px;
         cursor: pointer;
         transition: background-color 0.3s ease;
     }

     button.search-btn:hover {
         background-color: #0056b3; /* Darker Blue */
     }

     /* Reset Button: Orange */
     button.reset-btn {
         background-color: #3E5879; /* Orange */
         color: white;
         border: none;
         padding: 10px 20px;
         border-radius: 5px;
         font-size: 14px;
         cursor: pointer;
         transition: background-color 0.3s ease;
     }

     button.reset-btn:hover {
         background-color: #e68a00; /* Darker Orange */
     }

     /* Remove link styling inside the Reset button */
     button.reset-btn a {
         color: white;
         text-decoration: none;
         margin-bottom:10px;
     }

     button.reset-btn a:hover {
         text-decoration: underline;
     }
    </style>
</head>
<body>
    <header>
        <h1>MIT HOSTEL</h1>
        <nav>
            <button onclick="location.href='rc.jsp'">Home</button>
            <button onclick="location.href='history1.jsp'">History</button>
            <button onclick="location.href='index.jsp'">Log Out</button>
        </nav>
    </header>

    <main>
        <h2>Welcome, <span id="username"><%=request.getSession().getAttribute("name")%></span>!</h2>

<form class="filters" action="FilterRequest" method="get">
<label for="In date">In Date:</label>
    <input  type="text" id="date1" name="date1">
<label for="department">Department:</label>
    <select id="department" name="department">
        <option value="cse">cse</option>
    </select>

    <label for="rollNumber">Roll Number:</label>
    <input type="text" id="rollNumber" name="rollNumber" placeholder="Enter Roll Number">
    <label for="Out date">Out Date:</label>
    <input type="text" id="date" name="date">

    <button type="submit" class="search-btn">SEARCH</button>

</form>
<br>
<button type="submit" class="reset-btn"><a href="RequestServlet">Reset</a></button>
<br>

        <!-- Outpass Table -->
        <table id="outpassTable">
            <thead>
                <tr>
                    <th>Photo</th>
                    <th>Pass ID</th>
                    <th>Roll Number</th>
                    <th>Name</th>
                    <th>Department</th>
                    <th>Destination</th>
                    <th>Reason</th>
                    <th>Out Date</th>
                                        <th>In Date</th>
                                        <th>Out Time</th>
                                         <th>In Time</th>
                                         <th>Parent Ph.no</th>
                                        <th>Status</th>
                                        <th>Accept / Reject</th>
                </tr>
            </thead>
            <tbody>
                    <%
                        List<Outpass> passHistory = (List<Outpass>) request.getAttribute("passHistory");
                        if (passHistory != null && !passHistory.isEmpty()) {
                            for (Outpass pass : passHistory) {
                    %>
                        <tr>
                            <td>
                                <img src="img/stud.png" alt="User Photo" class="photo">
                            </td>
                            <td><%= pass.getOutpassId() %></td>
                            <td><%= pass.getRegNo() %></td>
                            <td><%= pass.getName() %></td>
                            <td><%= pass.getDept() %></td>
                            <td><%= pass.getPlace() %></td>
                            <td><%= pass.getReason() %></td>
                            <td><%= pass.getOutDate() %></td>
                            <td><%= pass.getInDate() %></td>
                            <td><%= pass.getOutTime() %></td>
                                                        <td><%= pass.getInTime() %></td>
                                                        <td><%= pass.getParentPhone() %></td>
                                                        <td><%= pass.getStatus() %></td>

                            <td>
                                        <form method="POST" action="PassActionServlet">
                                            <input type="hidden" name="passId" value="<%=pass.getOutpassId()%>">
                                            <button type="submit" name="action" value="accept" class="accept-btn">Accept</button>
                                            <button type="submit" name="action" value="reject" class="reject-btn">Reject</button>
                                        </form>
                                    </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="10" style="text-align:center;">No records found</td>
                        </tr>
                    <%
                        }
                    %>

                </tbody>

        </table>
    </main>

    <script src="request.js"></script>
</body>
</html>
