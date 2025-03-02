<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Rc" %>

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
     /* Search Button: Blue */
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

<form class="filters" action="FilterRc" method="get">



    <label for="name">Name:</label>
    <input type="text" id="name" name="name" placeholder="Enter Name">


    <label for="hostel">Hostel:</label>
    <input type="text" id="hostel" name="hostel">

    <button type="submit" class="search-btn">SEARCH</button>

</form>
<div>
<button class="reset-btn"><a href="viewRcServlet">Reset</a></button>
</div>

        <!-- Outpass Table -->
        <table id="outpassTable">
            <thead>
                <tr>

                    <th>RC Id</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Hostel</th>
                    <th>Edit / Delete<th>
                </tr>
            </thead>
            <tbody>
                    <%
                        List<Rc> rcDetails = (List<Rc>) request.getAttribute("rcDetails");
                        if (rcDetails != null && !rcDetails.isEmpty()) {
                            for (Rc rc : rcDetails) {
                    %>
                        <tr>

                            <td><%= rc.getId() %></td>
                            <td><%= rc.getName() %></td>
                            <td><%= rc.getEmail() %></td>
                            <td><%= rc.getBlock() %></td>

                            <td>
                                        <div class="actions">
                                                                    <form method="get" action="deleteRc">
                                                                        <input type="hidden" name="id" value="<%= rc.getId() %>">
                                                                        <button type="submit" class="delete-btn">Delete</button>
                                                                    </form>

                                                                </div>
                                                                <div class="actions">
                                                                <form method="post" action="editRc.jsp">
                                                                                                                            <input type="hidden" name="id" value="<%= rc.getId() %>">
                                                                                                                            <button type="submit" class="edit-btn">Edit</button>
                                                                                                                        </form>
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
