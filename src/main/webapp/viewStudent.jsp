<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Student" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Outpass Management</title>
    <link rel="stylesheet" href="request.css">
    <style>
    button.delete-btn {
        background-color: #dc3545; /* Red */
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    button.delete-btn:hover {
        background-color: #c82333; /* Darker Red */
    }

    button.edit-btn {
        background-color: #28a745; /* Green */
        color: white;
        border: none;
        padding: 10px 20px;
        margin-top:10px;
        border-radius: 5px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    button.edit-btn:hover {
        background-color: #218838; /* Darker Green */
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
            <button onclick="location.href='executive.jsp'">Home</button>
            <button onclick="location.href='index.jsp'">Log Out</button>
        </nav>
    </header>

    <main>
        <h2>Welcome, <span id="username"><%=request.getSession().getAttribute("name")%></span>!</h2>

<form class="filters" action="FilterStudent" method="get">



    <label for="rollNumber">Roll Number:</label>
    <input type="text" id="rollNumber" name="rollNumber" placeholder="Enter Roll Number">
    <label for="department">Department:</label>
    <select id="department" name="department">
            <option value="aero">Aero</option>
            <option value="cse">cse</option>
            <option value="ece">ECE</option>
            <option value="it">IT</option>
            <option value="aids">AIDS</option>
            <option value="rpt">RPT</option>
        </select>
    <label for="hostel">Hostel:</label>
    <input type="text" id="hostel" name="hostel">

    <button type="submit" class="search-btn">SEARCH</button>

</form>
<br>
<button type="submit" class="reset-btn"><a href="viewStudentServlet">Reset</a></button>
<br>

        <!-- Outpass Table -->
        <table id="outpassTable">
            <thead>
                <tr>

                    <th>Rc Id</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Hostel</th>
                    <th>Room No</th>
                    <th>Email</th>
                    <th>Phone no</th>
                    <th>Edit / Delete<th>
                </tr>
            </thead>
            <tbody>
                    <%
                        List<Student> studDetails = (List<Student>) request.getAttribute("studDetails");
                        if (studDetails != null && !studDetails.isEmpty()) {
                            for (Student student : studDetails) {
                    %>
                        <tr>

                            <td><%= student.getRollNo() %></td>
                            <td><%= student.getName() %></td>
                            <td><%= student.getDepartment() %></td>
                            <td><%= student.getHostel() %></td>
                            <td><%= student.getRoomNo() %></td>
                            <td><%= student.getEmail() %></td>
                            <td><%= student.getPhone() %></td>
                            <td>
                                        <div class="actions">
                                                                    <form method="get" action="deleteStudent">
                                                                        <input type="hidden" name="RollNo" value="<%= student.getRollNo() %>">
                                                                        <button type="submit" class="delete-btn">Delete</button>
                                                                    </form>

                                                                    <div class="actions">
                                                                        <form method="post" action="editStudent.jsp">
                                                                            <input type="hidden" name="RollNo" value="<%= student.getRollNo() %>">
                                                                            <button type="submit" class="edit-btn"> Edit </button>
                                                                        </form>
                                                                    </div>

                                                                </div>
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
